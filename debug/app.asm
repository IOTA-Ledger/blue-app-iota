
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
c0d00014:	f001 f884 	bl	c0d01120 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f000 ffd0 	bl	c0d00fbc <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 fc35 	bl	c0d03894 <setjmp>
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
c0d00040:	f001 fa14 	bl	c0d0146c <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 fef5 	bl	c0d01e34 <pic>
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
c0d0005a:	f001 feeb 	bl	c0d01e34 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 ff39 	bl	c0d01ed8 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f003 f840 	bl	c0d030ec <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f003 f83d 	bl	c0d030ec <USB_power>

            ui_idle();
c0d00072:	f002 f9d1 	bl	c0d02418 <ui_idle>

            IOTA_main();
c0d00076:	f000 fe55 	bl	c0d00d24 <IOTA_main>
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
c0d0008c:	f003 fc0e 	bl	c0d038ac <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d03d40 	.word	0xc0d03d40

c0d000a4 <generate_private_key_half>:
    return 0;
}

// generates half of a private key to encoded format of trints
int generate_private_key_half(trint_t *seed_trints, uint32_t index, trint_t *private_key)
{
c0d000a4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d000a6:	af03      	add	r7, sp, #12
c0d000a8:	b081      	sub	sp, #4
c0d000aa:	4614      	mov	r4, r2
c0d000ac:	4605      	mov	r5, r0
    // Add index -- keep in mind fix index_to_seed
    add_index_to_seed_trints(&seed_trints[0], index);
    
    kerl_initialize();
c0d000ae:	f000 fbe5 	bl	c0d0087c <kerl_initialize>
c0d000b2:	2631      	movs	r6, #49	; 0x31
    kerl_absorb_trints(&seed_trints[0], 49);
c0d000b4:	4628      	mov	r0, r5
c0d000b6:	4631      	mov	r1, r6
c0d000b8:	f000 fc30 	bl	c0d0091c <kerl_absorb_trints>
    kerl_squeeze_trints(&private_key[0], 49);
c0d000bc:	4620      	mov	r0, r4
c0d000be:	4631      	mov	r1, r6
c0d000c0:	f000 fc5c 	bl	c0d0097c <kerl_squeeze_trints>
    
    kerl_initialize();
c0d000c4:	f000 fbda 	bl	c0d0087c <kerl_initialize>
    kerl_absorb_trints(&seed_trints[0], 49);
c0d000c8:	4628      	mov	r0, r5
c0d000ca:	4631      	mov	r1, r6
c0d000cc:	f000 fc26 	bl	c0d0091c <kerl_absorb_trints>
c0d000d0:	251b      	movs	r5, #27
c0d000d2:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < level; i++) {
        for (uint8_t j = 0; j < 27; j++) {
            //27 chunks makes up half the private key
            
            // THIS SHOULD TAKE ROUGHLY 3 SECONDS ELSE IT HUNG
            kerl_squeeze_trints(&private_key[j * 49], 49);
c0d000d4:	4620      	mov	r0, r4
c0d000d6:	f000 fc51 	bl	c0d0097c <kerl_squeeze_trints>
    kerl_absorb_trints(&seed_trints[0], 49);
    
    //Set level to be 1 - only do first half of private key for now
    int8_t level = 1;
    for (uint8_t i = 0; i < level; i++) {
        for (uint8_t j = 0; j < 27; j++) {
c0d000da:	1e6d      	subs	r5, r5, #1
c0d000dc:	3431      	adds	r4, #49	; 0x31
c0d000de:	2d00      	cmp	r5, #0
c0d000e0:	d1f7      	bne.n	c0d000d2 <generate_private_key_half+0x2e>
            
            // THIS SHOULD TAKE ROUGHLY 3 SECONDS ELSE IT HUNG
            kerl_squeeze_trints(&private_key[j * 49], 49);
        }
    }
    return 0;
c0d000e2:	2000      	movs	r0, #0
c0d000e4:	b001      	add	sp, #4
c0d000e6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d000e8 <write_debug>:

char debug_str[64];

//write_debug(&words, sizeof(words), TYPE_STR);
//write_debug(&int_val, sizeof(int_val), TYPE_INT);
void write_debug(void* o, unsigned int sz, uint8_t t) {
c0d000e8:	b580      	push	{r7, lr}
c0d000ea:	af00      	add	r7, sp, #0
c0d000ec:	4603      	mov	r3, r0

    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
c0d000ee:	2a03      	cmp	r2, #3
c0d000f0:	d007      	beq.n	c0d00102 <write_debug+0x1a>
c0d000f2:	2a02      	cmp	r2, #2
c0d000f4:	d008      	beq.n	c0d00108 <write_debug+0x20>
c0d000f6:	2a01      	cmp	r2, #1
c0d000f8:	d10b      	bne.n	c0d00112 <write_debug+0x2a>
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
c0d000fa:	681b      	ldr	r3, [r3, #0]
c0d000fc:	4805      	ldr	r0, [pc, #20]	; (c0d00114 <write_debug+0x2c>)
c0d000fe:	a208      	add	r2, pc, #32	; (adr r2, c0d00120 <write_debug+0x38>)
c0d00100:	e005      	b.n	c0d0010e <write_debug+0x26>
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
c0d00102:	4804      	ldr	r0, [pc, #16]	; (c0d00114 <write_debug+0x2c>)
c0d00104:	a204      	add	r2, pc, #16	; (adr r2, c0d00118 <write_debug+0x30>)
c0d00106:	e002      	b.n	c0d0010e <write_debug+0x26>
    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
c0d00108:	681b      	ldr	r3, [r3, #0]
c0d0010a:	4802      	ldr	r0, [pc, #8]	; (c0d00114 <write_debug+0x2c>)
c0d0010c:	a203      	add	r2, pc, #12	; (adr r2, c0d0011c <write_debug+0x34>)
c0d0010e:	f001 fc41 	bl	c0d01994 <snprintf>
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
    }
}
c0d00112:	bd80      	pop	{r7, pc}
c0d00114:	20001800 	.word	0x20001800
c0d00118:	00007325 	.word	0x00007325
c0d0011c:	00007525 	.word	0x00007525
c0d00120:	00006425 	.word	0x00006425

c0d00124 <trits_to_trint>:
        pow3_val /= 3;
    }
}

//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
c0d00124:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00126:	af03      	add	r7, sp, #12
c0d00128:	2200      	movs	r2, #0
    int8_t pow3_val = 1;
    int8_t ret = 0;
    
    for(int8_t i=sz-1; i>=0; i--)
c0d0012a:	43d3      	mvns	r3, r2
c0d0012c:	b2c9      	uxtb	r1, r1
c0d0012e:	31ff      	adds	r1, #255	; 0xff
c0d00130:	b24c      	sxtb	r4, r1
c0d00132:	2c00      	cmp	r4, #0
c0d00134:	db0f      	blt.n	c0d00156 <trits_to_trint+0x32>
c0d00136:	1900      	adds	r0, r0, r4
c0d00138:	2401      	movs	r4, #1
c0d0013a:	2200      	movs	r2, #0
    {
        ret += trits[i]*pow3_val;
c0d0013c:	b265      	sxtb	r5, r4
        pow3_val *= 3;
c0d0013e:	2403      	movs	r4, #3
c0d00140:	436c      	muls	r4, r5
    int8_t pow3_val = 1;
    int8_t ret = 0;
    
    for(int8_t i=sz-1; i>=0; i--)
    {
        ret += trits[i]*pow3_val;
c0d00142:	7806      	ldrb	r6, [r0, #0]
c0d00144:	b276      	sxtb	r6, r6
c0d00146:	436e      	muls	r6, r5
c0d00148:	b2d2      	uxtb	r2, r2
c0d0014a:	18b2      	adds	r2, r6, r2
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;
    
    for(int8_t i=sz-1; i>=0; i--)
c0d0014c:	1e40      	subs	r0, r0, #1
c0d0014e:	1e49      	subs	r1, r1, #1
c0d00150:	b249      	sxtb	r1, r1
c0d00152:	4299      	cmp	r1, r3
c0d00154:	dcf2      	bgt.n	c0d0013c <trits_to_trint+0x18>
    {
        ret += trits[i]*pow3_val;
        pow3_val *= 3;
    }
    
    return ret;
c0d00156:	b250      	sxtb	r0, r2
c0d00158:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0015a <specific_49trints_to_243trits>:
        //incr count as we get trints
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
c0d0015a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0015c:	af03      	add	r7, sp, #12
c0d0015e:	b081      	sub	sp, #4
c0d00160:	460e      	mov	r6, r1
c0d00162:	4605      	mov	r5, r0
c0d00164:	2400      	movs	r4, #0
c0d00166:	9600      	str	r6, [sp, #0]
    for(uint8_t i = 0; i < 48; i++) {
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
c0d00168:	1b28      	subs	r0, r5, r4
c0d0016a:	7800      	ldrb	r0, [r0, #0]
c0d0016c:	b240      	sxtb	r0, r0
c0d0016e:	2205      	movs	r2, #5
c0d00170:	4631      	mov	r1, r6
c0d00172:	f000 f80f 	bl	c0d00194 <trint_to_trits>
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
    for(uint8_t i = 0; i < 48; i++) {
c0d00176:	1d76      	adds	r6, r6, #5
c0d00178:	1e64      	subs	r4, r4, #1
c0d0017a:	4620      	mov	r0, r4
c0d0017c:	3030      	adds	r0, #48	; 0x30
c0d0017e:	d1f3      	bne.n	c0d00168 <specific_49trints_to_243trits+0xe>
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
c0d00180:	2030      	movs	r0, #48	; 0x30
c0d00182:	5628      	ldrsb	r0, [r5, r0]
c0d00184:	9900      	ldr	r1, [sp, #0]
c0d00186:	31f0      	adds	r1, #240	; 0xf0
c0d00188:	2203      	movs	r2, #3
c0d0018a:	f000 f803 	bl	c0d00194 <trint_to_trits>
}
c0d0018e:	b001      	add	sp, #4
c0d00190:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00194 <trint_to_trits>:

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
c0d00194:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00196:	af03      	add	r7, sp, #12
c0d00198:	b083      	sub	sp, #12
c0d0019a:	9100      	str	r1, [sp, #0]
c0d0019c:	4603      	mov	r3, r0
c0d0019e:	9201      	str	r2, [sp, #4]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;
    
    for(uint8_t j = 0; j<sz; j++) {
c0d001a0:	2a01      	cmp	r2, #1
c0d001a2:	db2b      	blt.n	c0d001fc <trint_to_trits+0x68>
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
c0d001a4:	2009      	movs	r0, #9
c0d001a6:	2151      	movs	r1, #81	; 0x51
c0d001a8:	9a01      	ldr	r2, [sp, #4]
c0d001aa:	2a03      	cmp	r2, #3
c0d001ac:	d000      	beq.n	c0d001b0 <trint_to_trits+0x1c>
c0d001ae:	4608      	mov	r0, r1
c0d001b0:	2500      	movs	r5, #0
c0d001b2:	462e      	mov	r6, r5
        pow3_val = 9;
    
    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d001b4:	b2c4      	uxtb	r4, r0
c0d001b6:	b258      	sxtb	r0, r3
c0d001b8:	9002      	str	r0, [sp, #8]
c0d001ba:	0040      	lsls	r0, r0, #1
c0d001bc:	4621      	mov	r1, r4
c0d001be:	f003 f8dd 	bl	c0d0337c <__aeabi_idiv>
c0d001c2:	9900      	ldr	r1, [sp, #0]
c0d001c4:	5548      	strb	r0, [r1, r5]
c0d001c6:	194a      	adds	r2, r1, r5
        
        
        if(trits_r[j] > 1) trits_r[j] = 1;
c0d001c8:	0603      	lsls	r3, r0, #24
c0d001ca:	2101      	movs	r1, #1
c0d001cc:	060d      	lsls	r5, r1, #24
c0d001ce:	42ab      	cmp	r3, r5
c0d001d0:	dc03      	bgt.n	c0d001da <trint_to_trits+0x46>
c0d001d2:	21ff      	movs	r1, #255	; 0xff
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d001d4:	4d0a      	ldr	r5, [pc, #40]	; (c0d00200 <trint_to_trits+0x6c>)
c0d001d6:	42ab      	cmp	r3, r5
c0d001d8:	dc01      	bgt.n	c0d001de <trint_to_trits+0x4a>
c0d001da:	7011      	strb	r1, [r2, #0]
c0d001dc:	e000      	b.n	c0d001e0 <trint_to_trits+0x4c>
        
        integ -= trits_r[j] * pow3_val;
c0d001de:	4601      	mov	r1, r0
c0d001e0:	9a02      	ldr	r2, [sp, #8]
c0d001e2:	b248      	sxtb	r0, r1
c0d001e4:	4360      	muls	r0, r4
c0d001e6:	1a15      	subs	r5, r2, r0
        pow3_val /= 3;
c0d001e8:	2103      	movs	r1, #3
c0d001ea:	4620      	mov	r0, r4
c0d001ec:	f003 f83c 	bl	c0d03268 <__aeabi_uidiv>
c0d001f0:	462b      	mov	r3, r5
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;
    
    for(uint8_t j = 0; j<sz; j++) {
c0d001f2:	1c76      	adds	r6, r6, #1
c0d001f4:	b2f5      	uxtb	r5, r6
c0d001f6:	9901      	ldr	r1, [sp, #4]
c0d001f8:	428d      	cmp	r5, r1
c0d001fa:	dbdb      	blt.n	c0d001b4 <trint_to_trits+0x20>
        else if(trits_r[j] < -1) trits_r[j] = -1;
        
        integ -= trits_r[j] * pow3_val;
        pow3_val /= 3;
    }
}
c0d001fc:	b003      	add	sp, #12
c0d001fe:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00200:	feffffff 	.word	0xfeffffff

c0d00204 <get_seed>:
    return ret;
}

void do_nothing() {}

void get_seed(unsigned char *privateKey, uint8_t sz, char *msg) {
c0d00204:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00206:	af03      	add	r7, sp, #12
c0d00208:	b0ff      	sub	sp, #508	; 0x1fc
c0d0020a:	b0ff      	sub	sp, #508	; 0x1fc
c0d0020c:	b0e3      	sub	sp, #396	; 0x18c
c0d0020e:	9206      	str	r2, [sp, #24]
c0d00210:	460e      	mov	r6, r1
c0d00212:	4605      	mov	r5, r0
    
    //kerl requires 424 bytes
    kerl_initialize();
c0d00214:	9505      	str	r5, [sp, #20]
c0d00216:	f000 fb31 	bl	c0d0087c <kerl_initialize>
    
    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d0021a:	f000 fb2f 	bl	c0d0087c <kerl_initialize>
c0d0021e:	ac16      	add	r4, sp, #88	; 0x58

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d00220:	4620      	mov	r0, r4
c0d00222:	4629      	mov	r1, r5
c0d00224:	4632      	mov	r2, r6
c0d00226:	f003 faa5 	bl	c0d03774 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d0022a:	19a0      	adds	r0, r4, r6
c0d0022c:	2530      	movs	r5, #48	; 0x30
c0d0022e:	1baa      	subs	r2, r5, r6
c0d00230:	9905      	ldr	r1, [sp, #20]
c0d00232:	f003 fa9f 	bl	c0d03774 <__aeabi_memcpy>
        
        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00236:	4620      	mov	r0, r4
c0d00238:	4629      	mov	r1, r5
c0d0023a:	f000 fb2b 	bl	c0d00894 <kerl_absorb_bytes>
c0d0023e:	ad09      	add	r5, sp, #36	; 0x24
c0d00240:	2431      	movs	r4, #49	; 0x31
    }
    
    trint_t seed_trints[49];
    kerl_squeeze_trints(&seed_trints[0], 49);
c0d00242:	4628      	mov	r0, r5
c0d00244:	4621      	mov	r1, r4
c0d00246:	f000 fb99 	bl	c0d0097c <kerl_squeeze_trints>
c0d0024a:	ae16      	add	r6, sp, #88	; 0x58
    }
 */
    {
        //testing absorb and squeeze, I get 0 -1 1 -1 -1
        trit_t seed_trits[243];
        specific_49trints_to_243trits(&seed_trints[0], &seed_trits[0]);
c0d0024c:	4628      	mov	r0, r5
c0d0024e:	4631      	mov	r1, r6
c0d00250:	f7ff ff83 	bl	c0d0015a <specific_49trints_to_243trits>
        //absorb seed via trits, then via trints, to verify absorb is the same
        kerl_absorb_trints(&seed_trints[0], 49);
c0d00254:	4628      	mov	r0, r5
c0d00256:	4621      	mov	r1, r4
c0d00258:	f000 fb60 	bl	c0d0091c <kerl_absorb_trints>
        
        kerl_squeeze_trits(seed_trits, 243);
c0d0025c:	21f3      	movs	r1, #243	; 0xf3
c0d0025e:	4630      	mov	r0, r6
c0d00260:	f000 fb2c 	bl	c0d008bc <kerl_squeeze_trits>
    
        /* Debug trints being passed */
        trit_t trits[5];
        trint_to_trits(seed_trints[0], &trits[0], 5);
c0d00264:	7828      	ldrb	r0, [r5, #0]
c0d00266:	b240      	sxtb	r0, r0
c0d00268:	a907      	add	r1, sp, #28
c0d0026a:	2205      	movs	r2, #5
c0d0026c:	f7ff ff92 	bl	c0d00194 <trint_to_trits>
        
        snprintf(&msg[0], 64, "[%d][%d][%d][%d][%d]\n", seed_trits[0], seed_trits[1],
c0d00270:	2001      	movs	r0, #1
c0d00272:	5630      	ldrsb	r0, [r6, r0]
                 seed_trits[2], seed_trits[3], seed_trits[4]);
c0d00274:	2102      	movs	r1, #2
c0d00276:	5671      	ldrsb	r1, [r6, r1]
c0d00278:	2203      	movs	r2, #3
c0d0027a:	56b2      	ldrsb	r2, [r6, r2]
c0d0027c:	2304      	movs	r3, #4
c0d0027e:	56f3      	ldrsb	r3, [r6, r3]
    
        /* Debug trints being passed */
        trit_t trits[5];
        trint_to_trits(seed_trints[0], &trits[0], 5);
        
        snprintf(&msg[0], 64, "[%d][%d][%d][%d][%d]\n", seed_trits[0], seed_trits[1],
c0d00280:	7834      	ldrb	r4, [r6, #0]
c0d00282:	466e      	mov	r6, sp
c0d00284:	c60f      	stmia	r6!, {r0, r1, r2, r3}
c0d00286:	b263      	sxtb	r3, r4
c0d00288:	2140      	movs	r1, #64	; 0x40
c0d0028a:	a206      	add	r2, pc, #24	; (adr r2, c0d002a4 <get_seed+0xa0>)
c0d0028c:	9806      	ldr	r0, [sp, #24]
c0d0028e:	f001 fb81 	bl	c0d01994 <snprintf>
c0d00292:	2100      	movs	r1, #0
c0d00294:	aa16      	add	r2, sp, #88	; 0x58

//write func to get private key
void get_private_key(trint_t *seed_trints, uint32_t idx, char *msg) {
    //currently able to store 29 - [-1][-1][-1][0][-1]
    trint_t private_key_trints[49 * 27]; //trints are still just int8_t but encoded
    generate_private_key_half(seed_trints, idx, &private_key_trints[0]);
c0d00296:	4628      	mov	r0, r5
c0d00298:	f7ff ff04 	bl	c0d000a4 <generate_private_key_half>
    //null terminate seed
    //seed_chars[81] = '\0';
    
    //pass trits to private key func and let it handle the response
    get_private_key(&seed_trints[0], 0, msg);
}
c0d0029c:	1ffc      	subs	r4, r7, #7
c0d0029e:	3c05      	subs	r4, #5
c0d002a0:	46a5      	mov	sp, r4
c0d002a2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d002a4:	5d64255b 	.word	0x5d64255b
c0d002a8:	5d64255b 	.word	0x5d64255b
c0d002ac:	5d64255b 	.word	0x5d64255b
c0d002b0:	5d64255b 	.word	0x5d64255b
c0d002b4:	5d64255b 	.word	0x5d64255b
c0d002b8:	0000000a 	.word	0x0000000a

c0d002bc <bigint_add_int>:
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
    return ret;
}

int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
c0d002bc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d002be:	af03      	add	r7, sp, #12
c0d002c0:	b087      	sub	sp, #28
c0d002c2:	9105      	str	r1, [sp, #20]
c0d002c4:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d002c6:	2b00      	cmp	r3, #0
c0d002c8:	d03a      	beq.n	c0d00340 <bigint_add_int+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d002ca:	2100      	movs	r1, #0
c0d002cc:	43cc      	mvns	r4, r1
c0d002ce:	9400      	str	r4, [sp, #0]
c0d002d0:	460e      	mov	r6, r1
c0d002d2:	460c      	mov	r4, r1
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_in[i], val.low, val.hi);
c0d002d4:	9101      	str	r1, [sp, #4]
c0d002d6:	9302      	str	r3, [sp, #8]
c0d002d8:	9203      	str	r2, [sp, #12]
c0d002da:	9b00      	ldr	r3, [sp, #0]
c0d002dc:	460a      	mov	r2, r1
c0d002de:	4605      	mov	r5, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d002e0:	cd01      	ldmia	r5!, {r0}
c0d002e2:	9504      	str	r5, [sp, #16]
c0d002e4:	9905      	ldr	r1, [sp, #20]
c0d002e6:	1841      	adds	r1, r0, r1
c0d002e8:	4156      	adcs	r6, r2
c0d002ea:	9106      	str	r1, [sp, #24]
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d002ec:	4019      	ands	r1, r3
c0d002ee:	1c49      	adds	r1, r1, #1
c0d002f0:	4615      	mov	r5, r2
c0d002f2:	416d      	adcs	r5, r5
c0d002f4:	2001      	movs	r0, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d002f6:	4004      	ands	r4, r0
c0d002f8:	4622      	mov	r2, r4
c0d002fa:	2c00      	cmp	r4, #0
c0d002fc:	d100      	bne.n	c0d00300 <bigint_add_int+0x44>
c0d002fe:	9906      	ldr	r1, [sp, #24]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00300:	4299      	cmp	r1, r3
c0d00302:	9006      	str	r0, [sp, #24]
c0d00304:	d800      	bhi.n	c0d00308 <bigint_add_int+0x4c>
c0d00306:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00308:	2a00      	cmp	r2, #0
c0d0030a:	4632      	mov	r2, r6
c0d0030c:	d100      	bne.n	c0d00310 <bigint_add_int+0x54>
c0d0030e:	4615      	mov	r5, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00310:	2d00      	cmp	r5, #0
c0d00312:	9e06      	ldr	r6, [sp, #24]
c0d00314:	d100      	bne.n	c0d00318 <bigint_add_int+0x5c>
c0d00316:	462e      	mov	r6, r5
c0d00318:	2d00      	cmp	r5, #0
c0d0031a:	d000      	beq.n	c0d0031e <bigint_add_int+0x62>
c0d0031c:	4630      	mov	r0, r6
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d0031e:	4310      	orrs	r0, r2
c0d00320:	b2c0      	uxtb	r0, r0
c0d00322:	2800      	cmp	r0, #0
c0d00324:	9b02      	ldr	r3, [sp, #8]
c0d00326:	9a03      	ldr	r2, [sp, #12]
c0d00328:	9c01      	ldr	r4, [sp, #4]
c0d0032a:	d100      	bne.n	c0d0032e <bigint_add_int+0x72>
c0d0032c:	9006      	str	r0, [sp, #24]
        val = full_add(bigint_in[i], val.low, val.hi);
        bigint_out[i] = val.low;
c0d0032e:	c202      	stmia	r2!, {r1}
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00330:	1e5b      	subs	r3, r3, #1
c0d00332:	9405      	str	r4, [sp, #20]
c0d00334:	4626      	mov	r6, r4
c0d00336:	9d06      	ldr	r5, [sp, #24]
c0d00338:	4621      	mov	r1, r4
c0d0033a:	462c      	mov	r4, r5
c0d0033c:	9804      	ldr	r0, [sp, #16]
c0d0033e:	d1ca      	bne.n	c0d002d6 <bigint_add_int+0x1a>
        bigint_out[i] = val.low;
        val.low = 0;
    }

    if (val.hi) {
        return -1;
c0d00340:	4268      	negs	r0, r5
    }
    return 0;
}
c0d00342:	b007      	add	sp, #28
c0d00344:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00346 <bigint_add_bigint>:

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d00346:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00348:	af03      	add	r7, sp, #12
c0d0034a:	b086      	sub	sp, #24
c0d0034c:	461c      	mov	r4, r3
c0d0034e:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00350:	2c00      	cmp	r4, #0
c0d00352:	d034      	beq.n	c0d003be <bigint_add_bigint+0x78>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00354:	2600      	movs	r6, #0
c0d00356:	43f3      	mvns	r3, r6
c0d00358:	9300      	str	r3, [sp, #0]
c0d0035a:	9601      	str	r6, [sp, #4]
c0d0035c:	9202      	str	r2, [sp, #8]
c0d0035e:	9403      	str	r4, [sp, #12]
c0d00360:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00362:	cc01      	ldmia	r4!, {r0}
c0d00364:	9404      	str	r4, [sp, #16]
c0d00366:	460c      	mov	r4, r1
c0d00368:	cc02      	ldmia	r4!, {r1}
c0d0036a:	9405      	str	r4, [sp, #20]
c0d0036c:	180a      	adds	r2, r1, r0
c0d0036e:	9d01      	ldr	r5, [sp, #4]
c0d00370:	462c      	mov	r4, r5
c0d00372:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00374:	4611      	mov	r1, r2
c0d00376:	9800      	ldr	r0, [sp, #0]
c0d00378:	4001      	ands	r1, r0
c0d0037a:	1c4b      	adds	r3, r1, #1
c0d0037c:	4629      	mov	r1, r5
c0d0037e:	4149      	adcs	r1, r1
c0d00380:	2501      	movs	r5, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00382:	402e      	ands	r6, r5
c0d00384:	2e00      	cmp	r6, #0
c0d00386:	d100      	bne.n	c0d0038a <bigint_add_bigint+0x44>
c0d00388:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0038a:	4283      	cmp	r3, r0
c0d0038c:	4628      	mov	r0, r5
c0d0038e:	d800      	bhi.n	c0d00392 <bigint_add_bigint+0x4c>
c0d00390:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00392:	2e00      	cmp	r6, #0
c0d00394:	9a02      	ldr	r2, [sp, #8]
c0d00396:	d100      	bne.n	c0d0039a <bigint_add_bigint+0x54>
c0d00398:	4621      	mov	r1, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0039a:	2900      	cmp	r1, #0
c0d0039c:	462e      	mov	r6, r5
c0d0039e:	d100      	bne.n	c0d003a2 <bigint_add_bigint+0x5c>
c0d003a0:	460e      	mov	r6, r1
c0d003a2:	2900      	cmp	r1, #0
c0d003a4:	d000      	beq.n	c0d003a8 <bigint_add_bigint+0x62>
c0d003a6:	4630      	mov	r0, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d003a8:	4320      	orrs	r0, r4

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d003aa:	2800      	cmp	r0, #0
c0d003ac:	9905      	ldr	r1, [sp, #20]
c0d003ae:	d100      	bne.n	c0d003b2 <bigint_add_bigint+0x6c>
c0d003b0:	4605      	mov	r5, r0
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d003b2:	c208      	stmia	r2!, {r3}
c0d003b4:	9c03      	ldr	r4, [sp, #12]

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d003b6:	1e64      	subs	r4, r4, #1
c0d003b8:	462e      	mov	r6, r5
c0d003ba:	9804      	ldr	r0, [sp, #16]
c0d003bc:	d1ce      	bne.n	c0d0035c <bigint_add_bigint+0x16>
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }

    if (val.hi) {
        return -1;
c0d003be:	4268      	negs	r0, r5
    }
    return 0;
}
c0d003c0:	b006      	add	sp, #24
c0d003c2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d003c4 <bigint_sub_bigint>:

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d003c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003c6:	af03      	add	r7, sp, #12
c0d003c8:	b087      	sub	sp, #28
c0d003ca:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d003cc:	2d00      	cmp	r5, #0
c0d003ce:	d037      	beq.n	c0d00440 <bigint_sub_bigint+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003d0:	2400      	movs	r4, #0
c0d003d2:	9402      	str	r4, [sp, #8]
c0d003d4:	43e3      	mvns	r3, r4
c0d003d6:	9301      	str	r3, [sp, #4]
c0d003d8:	2601      	movs	r6, #1
c0d003da:	9600      	str	r6, [sp, #0]
c0d003dc:	9203      	str	r2, [sp, #12]
c0d003de:	9504      	str	r5, [sp, #16]
c0d003e0:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d003e2:	cc01      	ldmia	r4!, {r0}
c0d003e4:	9405      	str	r4, [sp, #20]
c0d003e6:	460c      	mov	r4, r1
int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d003e8:	cc02      	ldmia	r4!, {r1}
c0d003ea:	9406      	str	r4, [sp, #24]
c0d003ec:	43c9      	mvns	r1, r1
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d003ee:	180a      	adds	r2, r1, r0
c0d003f0:	9902      	ldr	r1, [sp, #8]
c0d003f2:	460c      	mov	r4, r1
c0d003f4:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d003f6:	4610      	mov	r0, r2
c0d003f8:	9d01      	ldr	r5, [sp, #4]
c0d003fa:	4028      	ands	r0, r5
c0d003fc:	1c43      	adds	r3, r0, #1
c0d003fe:	4608      	mov	r0, r1
c0d00400:	4140      	adcs	r0, r0
c0d00402:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00404:	400e      	ands	r6, r1
c0d00406:	2e00      	cmp	r6, #0
c0d00408:	d100      	bne.n	c0d0040c <bigint_sub_bigint+0x48>
c0d0040a:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0040c:	42ab      	cmp	r3, r5
c0d0040e:	460d      	mov	r5, r1
c0d00410:	d800      	bhi.n	c0d00414 <bigint_sub_bigint+0x50>
c0d00412:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00414:	2e00      	cmp	r6, #0
c0d00416:	9a03      	ldr	r2, [sp, #12]
c0d00418:	d100      	bne.n	c0d0041c <bigint_sub_bigint+0x58>
c0d0041a:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0041c:	2800      	cmp	r0, #0
c0d0041e:	460e      	mov	r6, r1
c0d00420:	d100      	bne.n	c0d00424 <bigint_sub_bigint+0x60>
c0d00422:	4606      	mov	r6, r0
c0d00424:	2800      	cmp	r0, #0
c0d00426:	d000      	beq.n	c0d0042a <bigint_sub_bigint+0x66>
c0d00428:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d0042a:	4325      	orrs	r5, r4

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0042c:	2d00      	cmp	r5, #0
c0d0042e:	460e      	mov	r6, r1
c0d00430:	9805      	ldr	r0, [sp, #20]
c0d00432:	d100      	bne.n	c0d00436 <bigint_sub_bigint+0x72>
c0d00434:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d00436:	c208      	stmia	r2!, {r3}
c0d00438:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0043a:	1e6d      	subs	r5, r5, #1
c0d0043c:	9906      	ldr	r1, [sp, #24]
c0d0043e:	d1cd      	bne.n	c0d003dc <bigint_sub_bigint+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d00440:	2000      	movs	r0, #0
c0d00442:	b007      	add	sp, #28
c0d00444:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00446 <bigint_cmp_bigint>:
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
c0d00446:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00448:	af03      	add	r7, sp, #12
c0d0044a:	b081      	sub	sp, #4
c0d0044c:	2400      	movs	r4, #0
c0d0044e:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d00450:	32ff      	adds	r2, #255	; 0xff
c0d00452:	b253      	sxtb	r3, r2
c0d00454:	2b00      	cmp	r3, #0
c0d00456:	db0f      	blt.n	c0d00478 <bigint_cmp_bigint+0x32>
c0d00458:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d0045a:	009b      	lsls	r3, r3, #2
c0d0045c:	58ce      	ldr	r6, [r1, r3]
c0d0045e:	58c4      	ldr	r4, [r0, r3]
c0d00460:	2301      	movs	r3, #1
c0d00462:	42b4      	cmp	r4, r6
c0d00464:	dc0b      	bgt.n	c0d0047e <bigint_cmp_bigint+0x38>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00466:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d00468:	42b4      	cmp	r4, r6
c0d0046a:	db07      	blt.n	c0d0047c <bigint_cmp_bigint+0x36>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d0046c:	b253      	sxtb	r3, r2
c0d0046e:	42ab      	cmp	r3, r5
c0d00470:	461a      	mov	r2, r3
c0d00472:	dcf2      	bgt.n	c0d0045a <bigint_cmp_bigint+0x14>
c0d00474:	9b00      	ldr	r3, [sp, #0]
c0d00476:	e002      	b.n	c0d0047e <bigint_cmp_bigint+0x38>
c0d00478:	4623      	mov	r3, r4
c0d0047a:	e000      	b.n	c0d0047e <bigint_cmp_bigint+0x38>
c0d0047c:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d0047e:	4618      	mov	r0, r3
c0d00480:	b001      	add	sp, #4
c0d00482:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00484 <bigint_not>:

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00484:	2900      	cmp	r1, #0
c0d00486:	d004      	beq.n	c0d00492 <bigint_not+0xe>
        bigint[i] = ~bigint[i];
c0d00488:	6802      	ldr	r2, [r0, #0]
c0d0048a:	43d2      	mvns	r2, r2
c0d0048c:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0048e:	1e49      	subs	r1, r1, #1
c0d00490:	d1fa      	bne.n	c0d00488 <bigint_not+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d00492:	2000      	movs	r0, #0
c0d00494:	4770      	bx	lr
	...

c0d00498 <words_to_trits>:
    memcpy(words_out, base, 48);
    return 0;
}

int words_to_trits(const int32_t words_in[], trit_t trits_out[])
{
c0d00498:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0049a:	af03      	add	r7, sp, #12
c0d0049c:	b0a1      	sub	sp, #132	; 0x84
c0d0049e:	9103      	str	r1, [sp, #12]
c0d004a0:	4604      	mov	r4, r0
    int32_t base[13] = {0};
c0d004a2:	9406      	str	r4, [sp, #24]
c0d004a4:	a814      	add	r0, sp, #80	; 0x50
c0d004a6:	2134      	movs	r1, #52	; 0x34
c0d004a8:	f003 f95e 	bl	c0d03768 <__aeabi_memclr>
c0d004ac:	2500      	movs	r5, #0
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
c0d004ae:	9513      	str	r5, [sp, #76]	; 0x4c
c0d004b0:	a807      	add	r0, sp, #28
c0d004b2:	4621      	mov	r1, r4
c0d004b4:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d004b6:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d004b8:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d004ba:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d004bc:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d004be:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d004c0:	20fe      	movs	r0, #254	; 0xfe
c0d004c2:	43c6      	mvns	r6, r0
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
c0d004c4:	9806      	ldr	r0, [sp, #24]
c0d004c6:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d004c8:	2800      	cmp	r0, #0
c0d004ca:	9504      	str	r5, [sp, #16]
c0d004cc:	db09      	blt.n	c0d004e2 <words_to_trits+0x4a>
c0d004ce:	a807      	add	r0, sp, #28
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
c0d004d0:	4936      	ldr	r1, [pc, #216]	; (c0d005ac <words_to_trits+0x114>)
c0d004d2:	4479      	add	r1, pc
c0d004d4:	aa14      	add	r2, sp, #80	; 0x50
c0d004d6:	230d      	movs	r3, #13
c0d004d8:	f7ff ff35 	bl	c0d00346 <bigint_add_bigint>
c0d004dc:	9501      	str	r5, [sp, #4]
c0d004de:	4628      	mov	r0, r5
c0d004e0:	e035      	b.n	c0d0054e <words_to_trits+0xb6>
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
c0d004e2:	4630      	mov	r0, r6
c0d004e4:	30fe      	adds	r0, #254	; 0xfe
c0d004e6:	9013      	str	r0, [sp, #76]	; 0x4c
c0d004e8:	ad07      	add	r5, sp, #28
c0d004ea:	240d      	movs	r4, #13
        bigint_not(tmp, 13);
c0d004ec:	4628      	mov	r0, r5
c0d004ee:	4621      	mov	r1, r4
c0d004f0:	f7ff ffc8 	bl	c0d00484 <bigint_not>
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
c0d004f4:	492a      	ldr	r1, [pc, #168]	; (c0d005a0 <words_to_trits+0x108>)
c0d004f6:	4479      	add	r1, pc
c0d004f8:	4628      	mov	r0, r5
c0d004fa:	4622      	mov	r2, r4
c0d004fc:	f7ff ffa3 	bl	c0d00446 <bigint_cmp_bigint>
c0d00500:	2801      	cmp	r0, #1
c0d00502:	db0a      	blt.n	c0d0051a <words_to_trits+0x82>
c0d00504:	a807      	add	r0, sp, #28
            bigint_sub_bigint(tmp, HALF_3, base, 13);
c0d00506:	4927      	ldr	r1, [pc, #156]	; (c0d005a4 <words_to_trits+0x10c>)
c0d00508:	4479      	add	r1, pc
c0d0050a:	aa14      	add	r2, sp, #80	; 0x50
c0d0050c:	230d      	movs	r3, #13
c0d0050e:	f7ff ff59 	bl	c0d003c4 <bigint_sub_bigint>
c0d00512:	2001      	movs	r0, #1
c0d00514:	9001      	str	r0, [sp, #4]
c0d00516:	9804      	ldr	r0, [sp, #16]
c0d00518:	e019      	b.n	c0d0054e <words_to_trits+0xb6>
c0d0051a:	ac07      	add	r4, sp, #28
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
c0d0051c:	2101      	movs	r1, #1
c0d0051e:	ad14      	add	r5, sp, #80	; 0x50
c0d00520:	230d      	movs	r3, #13
c0d00522:	9306      	str	r3, [sp, #24]
c0d00524:	4620      	mov	r0, r4
c0d00526:	462a      	mov	r2, r5
c0d00528:	f7ff fec8 	bl	c0d002bc <bigint_add_int>
            bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d0052c:	481e      	ldr	r0, [pc, #120]	; (c0d005a8 <words_to_trits+0x110>)
c0d0052e:	4478      	add	r0, pc
c0d00530:	4629      	mov	r1, r5
c0d00532:	4622      	mov	r2, r4
c0d00534:	9b06      	ldr	r3, [sp, #24]
c0d00536:	f7ff ff45 	bl	c0d003c4 <bigint_sub_bigint>
            memcpy(base, tmp, 52);
c0d0053a:	cc07      	ldmia	r4!, {r0, r1, r2}
c0d0053c:	c507      	stmia	r5!, {r0, r1, r2}
c0d0053e:	cc07      	ldmia	r4!, {r0, r1, r2}
c0d00540:	c507      	stmia	r5!, {r0, r1, r2}
c0d00542:	cc07      	ldmia	r4!, {r0, r1, r2}
c0d00544:	c507      	stmia	r5!, {r0, r1, r2}
c0d00546:	cc0f      	ldmia	r4!, {r0, r1, r2, r3}
c0d00548:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d0054a:	9804      	ldr	r0, [sp, #16]
c0d0054c:	9001      	str	r0, [sp, #4]
c0d0054e:	4601      	mov	r1, r0
c0d00550:	9602      	str	r6, [sp, #8]
c0d00552:	9105      	str	r1, [sp, #20]
c0d00554:	260c      	movs	r6, #12
c0d00556:	4602      	mov	r2, r0

    uint32_t rem = 0;
    for (int16_t i = 0; i < 243; i++) {
        rem = 0;
        for (int8_t j = 13-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
c0d00558:	00b0      	lsls	r0, r6, #2
c0d0055a:	ac14      	add	r4, sp, #80	; 0x50
c0d0055c:	9006      	str	r0, [sp, #24]
c0d0055e:	5820      	ldr	r0, [r4, r0]
c0d00560:	2a00      	cmp	r2, #0
c0d00562:	2503      	movs	r5, #3
c0d00564:	2300      	movs	r3, #0
            uint64_t q = (lhs / 3) & 0xFFFFFFFF;
            uint8_t r = lhs % 3;
c0d00566:	4611      	mov	r1, r2
c0d00568:	462a      	mov	r2, r5
c0d0056a:	f002 fff3 	bl	c0d03554 <__aeabi_uldivmod>

            base[j] = q;
c0d0056e:	9906      	ldr	r1, [sp, #24]
c0d00570:	5060      	str	r0, [r4, r1]


    uint32_t rem = 0;
    for (int16_t i = 0; i < 243; i++) {
        rem = 0;
        for (int8_t j = 13-1; j >= 0 ; j--) {
c0d00572:	1e70      	subs	r0, r6, #1
c0d00574:	2e00      	cmp	r6, #0
c0d00576:	4606      	mov	r6, r0
c0d00578:	dcee      	bgt.n	c0d00558 <words_to_trits+0xc0>
c0d0057a:	9e02      	ldr	r6, [sp, #8]
            base[j] = q;
            rem = r;
        }
        trits_out[i] = rem - 1;
        if (flip_trits) {
            trits_out[i] = -trits_out[i];
c0d0057c:	1ab0      	subs	r0, r6, r2
            uint8_t r = lhs % 3;

            base[j] = q;
            rem = r;
        }
        trits_out[i] = rem - 1;
c0d0057e:	32ff      	adds	r2, #255	; 0xff
        if (flip_trits) {
c0d00580:	9901      	ldr	r1, [sp, #4]
c0d00582:	2900      	cmp	r1, #0
c0d00584:	d100      	bne.n	c0d00588 <words_to_trits+0xf0>
c0d00586:	4610      	mov	r0, r2
            uint8_t r = lhs % 3;

            base[j] = q;
            rem = r;
        }
        trits_out[i] = rem - 1;
c0d00588:	9903      	ldr	r1, [sp, #12]
c0d0058a:	9a05      	ldr	r2, [sp, #20]
c0d0058c:	5488      	strb	r0, [r1, r2]
c0d0058e:	4611      	mov	r1, r2
        bigint_add_bigint(tmp, HALF_3, base, 13);
    }


    uint32_t rem = 0;
    for (int16_t i = 0; i < 243; i++) {
c0d00590:	1c49      	adds	r1, r1, #1
c0d00592:	29f3      	cmp	r1, #243	; 0xf3
c0d00594:	9804      	ldr	r0, [sp, #16]
c0d00596:	d1dc      	bne.n	c0d00552 <words_to_trits+0xba>
        trits_out[i] = rem - 1;
        if (flip_trits) {
            trits_out[i] = -trits_out[i];
        }
    }
    return 0;
c0d00598:	2000      	movs	r0, #0
c0d0059a:	b021      	add	sp, #132	; 0x84
c0d0059c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0059e:	46c0      	nop			; (mov r8, r8)
c0d005a0:	00003436 	.word	0x00003436
c0d005a4:	00003424 	.word	0x00003424
c0d005a8:	000033fe 	.word	0x000033fe
c0d005ac:	0000345a 	.word	0x0000345a

c0d005b0 <words_to_bytes>:

    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
c0d005b0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005b2:	af03      	add	r7, sp, #12
c0d005b4:	b082      	sub	sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d005b6:	2a00      	cmp	r2, #0
c0d005b8:	d01a      	beq.n	c0d005f0 <words_to_bytes+0x40>
c0d005ba:	0093      	lsls	r3, r2, #2
c0d005bc:	18c0      	adds	r0, r0, r3
c0d005be:	1f00      	subs	r0, r0, #4
c0d005c0:	2303      	movs	r3, #3
c0d005c2:	43db      	mvns	r3, r3
c0d005c4:	9301      	str	r3, [sp, #4]
c0d005c6:	4252      	negs	r2, r2
c0d005c8:	9200      	str	r2, [sp, #0]
c0d005ca:	2400      	movs	r4, #0
        bytes_out[i*4+0] = (words_in[word_len-1-i] >> 24);
c0d005cc:	9d01      	ldr	r5, [sp, #4]
c0d005ce:	4365      	muls	r5, r4
c0d005d0:	00a6      	lsls	r6, r4, #2
c0d005d2:	1983      	adds	r3, r0, r6
c0d005d4:	78da      	ldrb	r2, [r3, #3]
c0d005d6:	554a      	strb	r2, [r1, r5]
c0d005d8:	194a      	adds	r2, r1, r5
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
c0d005da:	885b      	ldrh	r3, [r3, #2]
c0d005dc:	7053      	strb	r3, [r2, #1]
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
c0d005de:	5983      	ldr	r3, [r0, r6]
c0d005e0:	0a1b      	lsrs	r3, r3, #8
c0d005e2:	7093      	strb	r3, [r2, #2]
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
c0d005e4:	5983      	ldr	r3, [r0, r6]
c0d005e6:	70d3      	strb	r3, [r2, #3]
    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d005e8:	1e64      	subs	r4, r4, #1
c0d005ea:	9a00      	ldr	r2, [sp, #0]
c0d005ec:	42a2      	cmp	r2, r4
c0d005ee:	d1ed      	bne.n	c0d005cc <words_to_bytes+0x1c>
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
    }

    return 0;
c0d005f0:	2000      	movs	r0, #0
c0d005f2:	b002      	add	sp, #8
c0d005f4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d005f6 <bytes_to_words>:
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
c0d005f6:	b5d0      	push	{r4, r6, r7, lr}
c0d005f8:	af02      	add	r7, sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d005fa:	2a00      	cmp	r2, #0
c0d005fc:	d015      	beq.n	c0d0062a <bytes_to_words+0x34>
c0d005fe:	0093      	lsls	r3, r2, #2
c0d00600:	18c0      	adds	r0, r0, r3
c0d00602:	1f00      	subs	r0, r0, #4
c0d00604:	2300      	movs	r3, #0
        words_out[i] = 0;
c0d00606:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
c0d00608:	7803      	ldrb	r3, [r0, #0]
c0d0060a:	061b      	lsls	r3, r3, #24
c0d0060c:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
c0d0060e:	7844      	ldrb	r4, [r0, #1]
c0d00610:	0424      	lsls	r4, r4, #16
c0d00612:	431c      	orrs	r4, r3
c0d00614:	600c      	str	r4, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
c0d00616:	7883      	ldrb	r3, [r0, #2]
c0d00618:	021b      	lsls	r3, r3, #8
c0d0061a:	4323      	orrs	r3, r4
c0d0061c:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
c0d0061e:	78c4      	ldrb	r4, [r0, #3]
c0d00620:	431c      	orrs	r4, r3
c0d00622:	c110      	stmia	r1!, {r4}
    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d00624:	1f00      	subs	r0, r0, #4
c0d00626:	1e52      	subs	r2, r2, #1
c0d00628:	d1ec      	bne.n	c0d00604 <bytes_to_words+0xe>
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
    }
    return 0;
c0d0062a:	2000      	movs	r0, #0
c0d0062c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d00630 <trints_to_words>:
}

//custom conversion straight from trints to words
int trints_to_words(trint_t *trints_in, int32_t words_out[])
{
c0d00630:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00632:	af03      	add	r7, sp, #12
c0d00634:	b0a1      	sub	sp, #132	; 0x84
c0d00636:	9101      	str	r1, [sp, #4]
c0d00638:	9002      	str	r0, [sp, #8]
c0d0063a:	a814      	add	r0, sp, #80	; 0x50
    int32_t base[13] = {0};
c0d0063c:	2134      	movs	r1, #52	; 0x34
c0d0063e:	f003 f893 	bl	c0d03768 <__aeabi_memclr>
c0d00642:	2430      	movs	r4, #48	; 0x30
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
c0d00644:	2603      	movs	r6, #3
c0d00646:	2005      	movs	r0, #5
c0d00648:	2c30      	cmp	r4, #48	; 0x30
c0d0064a:	d000      	beq.n	c0d0064e <trints_to_words+0x1e>
c0d0064c:	4606      	mov	r6, r0
        trint_to_trits(trints_in[x], &trits[0], get);
c0d0064e:	9802      	ldr	r0, [sp, #8]
c0d00650:	5700      	ldrsb	r0, [r0, r4]
c0d00652:	a912      	add	r1, sp, #72	; 0x48
c0d00654:	4632      	mov	r2, r6
c0d00656:	f7ff fd9d 	bl	c0d00194 <trint_to_trits>
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d0065a:	4833      	ldr	r0, [pc, #204]	; (c0d00728 <trints_to_words+0xf8>)
c0d0065c:	1832      	adds	r2, r6, r0
c0d0065e:	2006      	movs	r0, #6
c0d00660:	4010      	ands	r0, r2
            // multiply
            {
                int32_t sz = size;
                int32_t carry = 0;
                
                for (int32_t j = 0; j < sz; j++) {
c0d00662:	1e76      	subs	r6, r6, #1
c0d00664:	9403      	str	r4, [sp, #12]
            
            // add
            {
                int32_t tmp[12];
                // Ignore the last trit (48 is last trint, 2 is last trit in that trint)
                if (x == 48 & i == 2) {
c0d00666:	2c30      	cmp	r4, #48	; 0x30
c0d00668:	9204      	str	r2, [sp, #16]
c0d0066a:	d105      	bne.n	c0d00678 <trints_to_words+0x48>
c0d0066c:	b2b1      	uxth	r1, r6
c0d0066e:	2902      	cmp	r1, #2
c0d00670:	d102      	bne.n	c0d00678 <trints_to_words+0x48>
c0d00672:	a814      	add	r0, sp, #80	; 0x50
                    bigint_add_int(base, 1, tmp, 13);
c0d00674:	2101      	movs	r1, #1
c0d00676:	e003      	b.n	c0d00680 <trints_to_words+0x50>
c0d00678:	a912      	add	r1, sp, #72	; 0x48
                } else {
                    bigint_add_int(base, trits[i]+1, tmp, 13);
c0d0067a:	5608      	ldrsb	r0, [r1, r0]
c0d0067c:	1c41      	adds	r1, r0, #1
c0d0067e:	a814      	add	r0, sp, #80	; 0x50
c0d00680:	aa05      	add	r2, sp, #20
c0d00682:	230d      	movs	r3, #13
c0d00684:	f7ff fe1a 	bl	c0d002bc <bigint_add_int>
c0d00688:	a805      	add	r0, sp, #20
c0d0068a:	a914      	add	r1, sp, #80	; 0x50
                }
                memcpy(base, tmp, 52);
c0d0068c:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d0068e:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00690:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00692:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00694:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00696:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00698:	c83c      	ldmia	r0!, {r2, r3, r4, r5}
c0d0069a:	c13c      	stmia	r1!, {r2, r3, r4, r5}
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
        trint_to_trits(trints_in[x], &trits[0], get);
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d0069c:	1e76      	subs	r6, r6, #1
c0d0069e:	9804      	ldr	r0, [sp, #16]
c0d006a0:	1e40      	subs	r0, r0, #1
c0d006a2:	b200      	sxth	r0, r0
c0d006a4:	2800      	cmp	r0, #0
c0d006a6:	4602      	mov	r2, r0
c0d006a8:	9c03      	ldr	r4, [sp, #12]
c0d006aa:	dadc      	bge.n	c0d00666 <trints_to_words+0x36>
    int32_t size = 13;
    trit_t trits[5]; // on final call only left 3 trits matter
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
c0d006ac:	1e60      	subs	r0, r4, #1
c0d006ae:	2c00      	cmp	r4, #0
c0d006b0:	4604      	mov	r4, r0
c0d006b2:	dcc7      	bgt.n	c0d00644 <trints_to_words+0x14>
                // todo sz>size stuff
            }
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
c0d006b4:	481d      	ldr	r0, [pc, #116]	; (c0d0072c <trints_to_words+0xfc>)
c0d006b6:	4478      	add	r0, pc
c0d006b8:	a914      	add	r1, sp, #80	; 0x50
c0d006ba:	220d      	movs	r2, #13
c0d006bc:	f7ff fec3 	bl	c0d00446 <bigint_cmp_bigint>
c0d006c0:	2801      	cmp	r0, #1
c0d006c2:	db14      	blt.n	c0d006ee <trints_to_words+0xbe>
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d006c4:	481b      	ldr	r0, [pc, #108]	; (c0d00734 <trints_to_words+0x104>)
c0d006c6:	4478      	add	r0, pc
c0d006c8:	ad14      	add	r5, sp, #80	; 0x50
c0d006ca:	ac05      	add	r4, sp, #20
c0d006cc:	260d      	movs	r6, #13
c0d006ce:	4629      	mov	r1, r5
c0d006d0:	4622      	mov	r2, r4
c0d006d2:	4633      	mov	r3, r6
c0d006d4:	f7ff fe76 	bl	c0d003c4 <bigint_sub_bigint>
        bigint_not(tmp, 13);
c0d006d8:	4620      	mov	r0, r4
c0d006da:	4631      	mov	r1, r6
c0d006dc:	f7ff fed2 	bl	c0d00484 <bigint_not>
        bigint_add_int(tmp, 1, base, 13);
c0d006e0:	2101      	movs	r1, #1
c0d006e2:	4620      	mov	r0, r4
c0d006e4:	462a      	mov	r2, r5
c0d006e6:	4633      	mov	r3, r6
c0d006e8:	f7ff fde8 	bl	c0d002bc <bigint_add_int>
c0d006ec:	e010      	b.n	c0d00710 <trints_to_words+0xe0>
c0d006ee:	ad14      	add	r5, sp, #80	; 0x50
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
c0d006f0:	490f      	ldr	r1, [pc, #60]	; (c0d00730 <trints_to_words+0x100>)
c0d006f2:	4479      	add	r1, pc
c0d006f4:	ae05      	add	r6, sp, #20
c0d006f6:	230d      	movs	r3, #13
c0d006f8:	4628      	mov	r0, r5
c0d006fa:	4632      	mov	r2, r6
c0d006fc:	f7ff fe62 	bl	c0d003c4 <bigint_sub_bigint>
        memcpy(base, tmp, 52);
c0d00700:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d00702:	c507      	stmia	r5!, {r0, r1, r2}
c0d00704:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d00706:	c507      	stmia	r5!, {r0, r1, r2}
c0d00708:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d0070a:	c507      	stmia	r5!, {r0, r1, r2}
c0d0070c:	ce0f      	ldmia	r6!, {r0, r1, r2, r3}
c0d0070e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d00710:	a814      	add	r0, sp, #80	; 0x50
c0d00712:	9d01      	ldr	r5, [sp, #4]
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }
    
    
    memcpy(words_out, base, 48);
c0d00714:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00716:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00718:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d0071a:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d0071c:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d0071e:	c51e      	stmia	r5!, {r1, r2, r3, r4}
    return 0;
c0d00720:	2000      	movs	r0, #0
c0d00722:	b021      	add	sp, #132	; 0x84
c0d00724:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00726:	46c0      	nop			; (mov r8, r8)
c0d00728:	0000ffff 	.word	0x0000ffff
c0d0072c:	00003276 	.word	0x00003276
c0d00730:	0000323a 	.word	0x0000323a
c0d00734:	00003266 	.word	0x00003266

c0d00738 <words_to_trints>:
}

//straight from words into trints
int words_to_trints(const int32_t words_in[], trint_t *trints_out)
{
c0d00738:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0073a:	af03      	add	r7, sp, #12
c0d0073c:	b0a5      	sub	sp, #148	; 0x94
c0d0073e:	9100      	str	r1, [sp, #0]
c0d00740:	4604      	mov	r4, r0
    int32_t base[13] = {0};
c0d00742:	9408      	str	r4, [sp, #32]
c0d00744:	a818      	add	r0, sp, #96	; 0x60
c0d00746:	2134      	movs	r1, #52	; 0x34
c0d00748:	f003 f80e 	bl	c0d03768 <__aeabi_memclr>
c0d0074c:	2500      	movs	r5, #0
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
c0d0074e:	9517      	str	r5, [sp, #92]	; 0x5c
c0d00750:	a80b      	add	r0, sp, #44	; 0x2c
c0d00752:	4621      	mov	r1, r4
c0d00754:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d00756:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00758:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d0075a:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d0075c:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d0075e:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00760:	20fe      	movs	r0, #254	; 0xfe
c0d00762:	43c1      	mvns	r1, r0
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
c0d00764:	9808      	ldr	r0, [sp, #32]
c0d00766:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d00768:	2800      	cmp	r0, #0
c0d0076a:	9103      	str	r1, [sp, #12]
c0d0076c:	db08      	blt.n	c0d00780 <words_to_trints+0x48>
c0d0076e:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
c0d00770:	4941      	ldr	r1, [pc, #260]	; (c0d00878 <words_to_trints+0x140>)
c0d00772:	4479      	add	r1, pc
c0d00774:	aa18      	add	r2, sp, #96	; 0x60
c0d00776:	230d      	movs	r3, #13
c0d00778:	f7ff fde5 	bl	c0d00346 <bigint_add_bigint>
c0d0077c:	9502      	str	r5, [sp, #8]
c0d0077e:	e01b      	b.n	c0d007b8 <words_to_trints+0x80>
c0d00780:	9501      	str	r5, [sp, #4]
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
c0d00782:	4608      	mov	r0, r1
c0d00784:	30fe      	adds	r0, #254	; 0xfe
c0d00786:	9017      	str	r0, [sp, #92]	; 0x5c
c0d00788:	ad0b      	add	r5, sp, #44	; 0x2c
c0d0078a:	260d      	movs	r6, #13
        bigint_not(tmp, 13);
c0d0078c:	4628      	mov	r0, r5
c0d0078e:	4631      	mov	r1, r6
c0d00790:	f7ff fe78 	bl	c0d00484 <bigint_not>
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
c0d00794:	4935      	ldr	r1, [pc, #212]	; (c0d0086c <words_to_trints+0x134>)
c0d00796:	4479      	add	r1, pc
c0d00798:	4628      	mov	r0, r5
c0d0079a:	4632      	mov	r2, r6
c0d0079c:	f7ff fe53 	bl	c0d00446 <bigint_cmp_bigint>
c0d007a0:	2801      	cmp	r0, #1
c0d007a2:	db49      	blt.n	c0d00838 <words_to_trints+0x100>
c0d007a4:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(tmp, HALF_3, base, 13);
c0d007a6:	4932      	ldr	r1, [pc, #200]	; (c0d00870 <words_to_trints+0x138>)
c0d007a8:	4479      	add	r1, pc
c0d007aa:	aa18      	add	r2, sp, #96	; 0x60
c0d007ac:	230d      	movs	r3, #13
c0d007ae:	f7ff fe09 	bl	c0d003c4 <bigint_sub_bigint>
c0d007b2:	2001      	movs	r0, #1
c0d007b4:	9002      	str	r0, [sp, #8]
c0d007b6:	9d01      	ldr	r5, [sp, #4]
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
c0d007b8:	2403      	movs	r4, #3
c0d007ba:	2005      	movs	r0, #5
c0d007bc:	9501      	str	r5, [sp, #4]
c0d007be:	2d30      	cmp	r5, #48	; 0x30
c0d007c0:	d000      	beq.n	c0d007c4 <words_to_trints+0x8c>
c0d007c2:	4604      	mov	r4, r0
c0d007c4:	a809      	add	r0, sp, #36	; 0x24
        trits_to_trint(&trits[0], send);
c0d007c6:	4621      	mov	r1, r4
c0d007c8:	f7ff fcac 	bl	c0d00124 <trits_to_trint>
c0d007cc:	2000      	movs	r0, #0
c0d007ce:	4601      	mov	r1, r0
c0d007d0:	9004      	str	r0, [sp, #16]
c0d007d2:	9405      	str	r4, [sp, #20]
c0d007d4:	9106      	str	r1, [sp, #24]
c0d007d6:	9007      	str	r0, [sp, #28]
c0d007d8:	250c      	movs	r5, #12
c0d007da:	9a04      	ldr	r2, [sp, #16]
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
                uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
c0d007dc:	00a9      	lsls	r1, r5, #2
c0d007de:	ac18      	add	r4, sp, #96	; 0x60
c0d007e0:	5860      	ldr	r0, [r4, r1]
c0d007e2:	2a00      	cmp	r2, #0
c0d007e4:	9108      	str	r1, [sp, #32]
c0d007e6:	2603      	movs	r6, #3
c0d007e8:	2300      	movs	r3, #0
                uint64_t q = (lhs / 3) & 0xFFFFFFFF;
                uint8_t r = lhs % 3;
c0d007ea:	4611      	mov	r1, r2
c0d007ec:	4632      	mov	r2, r6
c0d007ee:	f002 feb1 	bl	c0d03554 <__aeabi_uldivmod>
                
                base[j] = q;
c0d007f2:	9908      	ldr	r1, [sp, #32]
c0d007f4:	5060      	str	r0, [r4, r1]
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
c0d007f6:	1e68      	subs	r0, r5, #1
c0d007f8:	2d00      	cmp	r5, #0
c0d007fa:	4605      	mov	r5, r0
c0d007fc:	dcee      	bgt.n	c0d007dc <words_to_trints+0xa4>
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
            if (flip_trits) {
                trits[i] = -trits[i];
c0d007fe:	9803      	ldr	r0, [sp, #12]
c0d00800:	1a80      	subs	r0, r0, r2
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d00802:	32ff      	adds	r2, #255	; 0xff
            if (flip_trits) {
c0d00804:	9902      	ldr	r1, [sp, #8]
c0d00806:	2900      	cmp	r1, #0
c0d00808:	d100      	bne.n	c0d0080c <words_to_trints+0xd4>
c0d0080a:	4610      	mov	r0, r2
c0d0080c:	a909      	add	r1, sp, #36	; 0x24
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d0080e:	9a06      	ldr	r2, [sp, #24]
c0d00810:	5488      	strb	r0, [r1, r2]
c0d00812:	9807      	ldr	r0, [sp, #28]
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
c0d00814:	1c40      	adds	r0, r0, #1
c0d00816:	b201      	sxth	r1, r0
c0d00818:	9c05      	ldr	r4, [sp, #20]
c0d0081a:	42a1      	cmp	r1, r4
c0d0081c:	dbda      	blt.n	c0d007d4 <words_to_trints+0x9c>
c0d0081e:	a809      	add	r0, sp, #36	; 0x24
            if (flip_trits) {
                trits[i] = -trits[i];
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
c0d00820:	4621      	mov	r1, r4
c0d00822:	f7ff fc7f 	bl	c0d00124 <trits_to_trint>
c0d00826:	9900      	ldr	r1, [sp, #0]
c0d00828:	9d01      	ldr	r5, [sp, #4]
c0d0082a:	5548      	strb	r0, [r1, r5]
    }
    
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
c0d0082c:	1c6d      	adds	r5, r5, #1
c0d0082e:	2d31      	cmp	r5, #49	; 0x31
c0d00830:	d1c2      	bne.n	c0d007b8 <words_to_trints+0x80>
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
    }
    return 0;
c0d00832:	2000      	movs	r0, #0
c0d00834:	b025      	add	sp, #148	; 0x94
c0d00836:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00838:	ad0b      	add	r5, sp, #44	; 0x2c
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
c0d0083a:	2101      	movs	r1, #1
c0d0083c:	ae18      	add	r6, sp, #96	; 0x60
c0d0083e:	240d      	movs	r4, #13
c0d00840:	4628      	mov	r0, r5
c0d00842:	4632      	mov	r2, r6
c0d00844:	4623      	mov	r3, r4
c0d00846:	f7ff fd39 	bl	c0d002bc <bigint_add_int>
            bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d0084a:	480a      	ldr	r0, [pc, #40]	; (c0d00874 <words_to_trints+0x13c>)
c0d0084c:	4478      	add	r0, pc
c0d0084e:	4631      	mov	r1, r6
c0d00850:	462a      	mov	r2, r5
c0d00852:	4623      	mov	r3, r4
c0d00854:	f7ff fdb6 	bl	c0d003c4 <bigint_sub_bigint>
            memcpy(base, tmp, 52);
c0d00858:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d0085a:	c607      	stmia	r6!, {r0, r1, r2}
c0d0085c:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d0085e:	c607      	stmia	r6!, {r0, r1, r2}
c0d00860:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00862:	c607      	stmia	r6!, {r0, r1, r2}
c0d00864:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00866:	c60f      	stmia	r6!, {r0, r1, r2, r3}
c0d00868:	9d01      	ldr	r5, [sp, #4]
c0d0086a:	e787      	b.n	c0d0077c <words_to_trints+0x44>
c0d0086c:	00003196 	.word	0x00003196
c0d00870:	00003184 	.word	0x00003184
c0d00874:	000030e0 	.word	0x000030e0
c0d00878:	000031ba 	.word	0x000031ba

c0d0087c <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d0087c:	b580      	push	{r7, lr}
c0d0087e:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00880:	2003      	movs	r0, #3
c0d00882:	01c1      	lsls	r1, r0, #7
c0d00884:	4802      	ldr	r0, [pc, #8]	; (c0d00890 <kerl_initialize+0x14>)
c0d00886:	f001 fb81 	bl	c0d01f8c <cx_keccak_init>
    return 0;
c0d0088a:	2000      	movs	r0, #0
c0d0088c:	bd80      	pop	{r7, pc}
c0d0088e:	46c0      	nop			; (mov r8, r8)
c0d00890:	20001840 	.word	0x20001840

c0d00894 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00894:	b580      	push	{r7, lr}
c0d00896:	af00      	add	r7, sp, #0
c0d00898:	b082      	sub	sp, #8
c0d0089a:	460b      	mov	r3, r1
c0d0089c:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d0089e:	4805      	ldr	r0, [pc, #20]	; (c0d008b4 <kerl_absorb_bytes+0x20>)
c0d008a0:	4669      	mov	r1, sp
c0d008a2:	6008      	str	r0, [r1, #0]
c0d008a4:	4804      	ldr	r0, [pc, #16]	; (c0d008b8 <kerl_absorb_bytes+0x24>)
c0d008a6:	2101      	movs	r1, #1
c0d008a8:	f001 fb8e 	bl	c0d01fc8 <cx_hash>
c0d008ac:	2000      	movs	r0, #0
    return 0;
c0d008ae:	b002      	add	sp, #8
c0d008b0:	bd80      	pop	{r7, pc}
c0d008b2:	46c0      	nop			; (mov r8, r8)
c0d008b4:	200019e8 	.word	0x200019e8
c0d008b8:	20001840 	.word	0x20001840

c0d008bc <kerl_squeeze_trits>:
    return 0;
}


int kerl_squeeze_trits(trit_t trits_out[], uint16_t len)
{
c0d008bc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d008be:	af03      	add	r7, sp, #12
c0d008c0:	b08d      	sub	sp, #52	; 0x34
c0d008c2:	4605      	mov	r5, r0
    (void) len;

    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
c0d008c4:	4c13      	ldr	r4, [pc, #76]	; (c0d00914 <kerl_squeeze_trits+0x58>)
c0d008c6:	ae01      	add	r6, sp, #4
c0d008c8:	220c      	movs	r2, #12
c0d008ca:	4620      	mov	r0, r4
c0d008cc:	4631      	mov	r1, r6
c0d008ce:	f7ff fe92 	bl	c0d005f6 <bytes_to_words>
    words_to_trits(words, trits_out);
c0d008d2:	4630      	mov	r0, r6
c0d008d4:	4629      	mov	r1, r5
c0d008d6:	f7ff fddf 	bl	c0d00498 <words_to_trits>

    // Last trit zero
    trits_out[242] = 0;
c0d008da:	21f2      	movs	r1, #242	; 0xf2
c0d008dc:	2000      	movs	r0, #0
c0d008de:	5468      	strb	r0, [r5, r1]

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
c0d008e0:	1a21      	subs	r1, r4, r0
c0d008e2:	780a      	ldrb	r2, [r1, #0]
c0d008e4:	43d2      	mvns	r2, r2
c0d008e6:	700a      	strb	r2, [r1, #0]
    trits_out[242] = 0;

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d008e8:	1e40      	subs	r0, r0, #1
c0d008ea:	4601      	mov	r1, r0
c0d008ec:	3130      	adds	r1, #48	; 0x30
c0d008ee:	d1f7      	bne.n	c0d008e0 <kerl_squeeze_trits+0x24>
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d008f0:	2003      	movs	r0, #3
c0d008f2:	01c1      	lsls	r1, r0, #7
c0d008f4:	4d08      	ldr	r5, [pc, #32]	; (c0d00918 <kerl_squeeze_trits+0x5c>)
c0d008f6:	4628      	mov	r0, r5
c0d008f8:	f001 fb48 	bl	c0d01f8c <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d008fc:	4668      	mov	r0, sp
c0d008fe:	6004      	str	r4, [r0, #0]
c0d00900:	2101      	movs	r1, #1
c0d00902:	2330      	movs	r3, #48	; 0x30
c0d00904:	4628      	mov	r0, r5
c0d00906:	4622      	mov	r2, r4
c0d00908:	f001 fb5e 	bl	c0d01fc8 <cx_hash>
c0d0090c:	2000      	movs	r0, #0
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
c0d0090e:	b00d      	add	sp, #52	; 0x34
c0d00910:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00912:	46c0      	nop			; (mov r8, r8)
c0d00914:	200019e8 	.word	0x200019e8
c0d00918:	20001840 	.word	0x20001840

c0d0091c <kerl_absorb_trints>:
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
c0d0091c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0091e:	af03      	add	r7, sp, #12
c0d00920:	b09b      	sub	sp, #108	; 0x6c
c0d00922:	460e      	mov	r6, r1
c0d00924:	4604      	mov	r4, r0
c0d00926:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00928:	4630      	mov	r0, r6
c0d0092a:	f002 fc9d 	bl	c0d03268 <__aeabi_uidiv>
c0d0092e:	2e31      	cmp	r6, #49	; 0x31
c0d00930:	d31c      	bcc.n	c0d0096c <kerl_absorb_trints+0x50>
c0d00932:	2500      	movs	r5, #0
c0d00934:	9402      	str	r4, [sp, #8]
c0d00936:	9001      	str	r0, [sp, #4]
c0d00938:	ae0f      	add	r6, sp, #60	; 0x3c
        // First, convert to bytes
        int32_t words[12];
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
c0d0093a:	4620      	mov	r0, r4
c0d0093c:	4631      	mov	r1, r6
c0d0093e:	f7ff fe77 	bl	c0d00630 <trints_to_words>
c0d00942:	ac03      	add	r4, sp, #12
        words_to_bytes(words, bytes, 12);
c0d00944:	220c      	movs	r2, #12
c0d00946:	4630      	mov	r0, r6
c0d00948:	4621      	mov	r1, r4
c0d0094a:	f7ff fe31 	bl	c0d005b0 <words_to_bytes>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d0094e:	4668      	mov	r0, sp
c0d00950:	4908      	ldr	r1, [pc, #32]	; (c0d00974 <kerl_absorb_trints+0x58>)
c0d00952:	6001      	str	r1, [r0, #0]
c0d00954:	2101      	movs	r1, #1
c0d00956:	2330      	movs	r3, #48	; 0x30
c0d00958:	4807      	ldr	r0, [pc, #28]	; (c0d00978 <kerl_absorb_trints+0x5c>)
c0d0095a:	4622      	mov	r2, r4
c0d0095c:	9c02      	ldr	r4, [sp, #8]
c0d0095e:	f001 fb33 	bl	c0d01fc8 <cx_hash>
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00962:	1c6d      	adds	r5, r5, #1
c0d00964:	b2e8      	uxtb	r0, r5
c0d00966:	9901      	ldr	r1, [sp, #4]
c0d00968:	4288      	cmp	r0, r1
c0d0096a:	d3e5      	bcc.n	c0d00938 <kerl_absorb_trints+0x1c>
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
c0d0096c:	2000      	movs	r0, #0
c0d0096e:	b01b      	add	sp, #108	; 0x6c
c0d00970:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00972:	46c0      	nop			; (mov r8, r8)
c0d00974:	200019e8 	.word	0x200019e8
c0d00978:	20001840 	.word	0x20001840

c0d0097c <kerl_squeeze_trints>:
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
c0d0097c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0097e:	af03      	add	r7, sp, #12
c0d00980:	b091      	sub	sp, #68	; 0x44
c0d00982:	4605      	mov	r5, r0
/* */
    (void) len;
    
    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
c0d00984:	4c1b      	ldr	r4, [pc, #108]	; (c0d009f4 <kerl_squeeze_trints+0x78>)
c0d00986:	ae05      	add	r6, sp, #20
c0d00988:	220c      	movs	r2, #12
c0d0098a:	4620      	mov	r0, r4
c0d0098c:	4631      	mov	r1, r6
c0d0098e:	f7ff fe32 	bl	c0d005f6 <bytes_to_words>
    words_to_trints(words, &trints_out[0]);
c0d00992:	4630      	mov	r0, r6
c0d00994:	9502      	str	r5, [sp, #8]
c0d00996:	4629      	mov	r1, r5
c0d00998:	f7ff fece 	bl	c0d00738 <words_to_trints>
    
    
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
c0d0099c:	2030      	movs	r0, #48	; 0x30
c0d0099e:	9003      	str	r0, [sp, #12]
c0d009a0:	5628      	ldrsb	r0, [r5, r0]
c0d009a2:	ad04      	add	r5, sp, #16
c0d009a4:	2203      	movs	r2, #3
c0d009a6:	9201      	str	r2, [sp, #4]
c0d009a8:	4629      	mov	r1, r5
c0d009aa:	f7ff fbf3 	bl	c0d00194 <trint_to_trits>
c0d009ae:	2600      	movs	r6, #0
    trits[2] = 0; //set last trit to 0
c0d009b0:	70ae      	strb	r6, [r5, #2]
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d009b2:	4628      	mov	r0, r5
c0d009b4:	9d01      	ldr	r5, [sp, #4]
c0d009b6:	4629      	mov	r1, r5
c0d009b8:	f7ff fbb4 	bl	c0d00124 <trits_to_trint>
c0d009bc:	9903      	ldr	r1, [sp, #12]
c0d009be:	9a02      	ldr	r2, [sp, #8]
c0d009c0:	5450      	strb	r0, [r2, r1]
    
    // TODO: Check if the following is needed. Seems to do nothing.
    
    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
c0d009c2:	1ba0      	subs	r0, r4, r6
c0d009c4:	7801      	ldrb	r1, [r0, #0]
c0d009c6:	43c9      	mvns	r1, r1
c0d009c8:	7001      	strb	r1, [r0, #0]
    trints_out[48] = trits_to_trint(&trits[0], 3);
    
    // TODO: Check if the following is needed. Seems to do nothing.
    
    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d009ca:	1e76      	subs	r6, r6, #1
c0d009cc:	4630      	mov	r0, r6
c0d009ce:	3030      	adds	r0, #48	; 0x30
c0d009d0:	d1f7      	bne.n	c0d009c2 <kerl_squeeze_trints+0x46>
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d009d2:	01e9      	lsls	r1, r5, #7
c0d009d4:	4d08      	ldr	r5, [pc, #32]	; (c0d009f8 <kerl_squeeze_trints+0x7c>)
c0d009d6:	4628      	mov	r0, r5
c0d009d8:	f001 fad8 	bl	c0d01f8c <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d009dc:	4668      	mov	r0, sp
c0d009de:	6004      	str	r4, [r0, #0]
c0d009e0:	2101      	movs	r1, #1
c0d009e2:	2330      	movs	r3, #48	; 0x30
c0d009e4:	4628      	mov	r0, r5
c0d009e6:	4622      	mov	r2, r4
c0d009e8:	f001 faee 	bl	c0d01fc8 <cx_hash>
c0d009ec:	2000      	movs	r0, #0
    }
    
    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);
    
    return 0;
c0d009ee:	b011      	add	sp, #68	; 0x44
c0d009f0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d009f2:	46c0      	nop			; (mov r8, r8)
c0d009f4:	200019e8 	.word	0x200019e8
c0d009f8:	20001840 	.word	0x20001840

c0d009fc <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d009fc:	b580      	push	{r7, lr}
c0d009fe:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00a00:	4804      	ldr	r0, [pc, #16]	; (c0d00a14 <nvram_is_init+0x18>)
c0d00a02:	f001 fa17 	bl	c0d01e34 <pic>
c0d00a06:	7801      	ldrb	r1, [r0, #0]
c0d00a08:	2000      	movs	r0, #0
c0d00a0a:	2901      	cmp	r1, #1
c0d00a0c:	d100      	bne.n	c0d00a10 <nvram_is_init+0x14>
c0d00a0e:	4608      	mov	r0, r1
    else return true;
}
c0d00a10:	bd80      	pop	{r7, pc}
c0d00a12:	46c0      	nop			; (mov r8, r8)
c0d00a14:	c0d03d40 	.word	0xc0d03d40

c0d00a18 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00a18:	b5b0      	push	{r4, r5, r7, lr}
c0d00a1a:	af02      	add	r7, sp, #8
c0d00a1c:	4605      	mov	r5, r0
c0d00a1e:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00a20:	4028      	ands	r0, r5
c0d00a22:	2400      	movs	r4, #0
c0d00a24:	2801      	cmp	r0, #1
c0d00a26:	d013      	beq.n	c0d00a50 <io_exchange_al+0x38>
c0d00a28:	2802      	cmp	r0, #2
c0d00a2a:	d113      	bne.n	c0d00a54 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00a2c:	2900      	cmp	r1, #0
c0d00a2e:	d008      	beq.n	c0d00a42 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00a30:	480b      	ldr	r0, [pc, #44]	; (c0d00a60 <io_exchange_al+0x48>)
c0d00a32:	f001 fbbb 	bl	c0d021ac <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d00a36:	b268      	sxtb	r0, r5
c0d00a38:	2800      	cmp	r0, #0
c0d00a3a:	da09      	bge.n	c0d00a50 <io_exchange_al+0x38>
                reset();
c0d00a3c:	f001 fa30 	bl	c0d01ea0 <reset>
c0d00a40:	e006      	b.n	c0d00a50 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00a42:	2041      	movs	r0, #65	; 0x41
c0d00a44:	0081      	lsls	r1, r0, #2
c0d00a46:	4806      	ldr	r0, [pc, #24]	; (c0d00a60 <io_exchange_al+0x48>)
c0d00a48:	2200      	movs	r2, #0
c0d00a4a:	f001 fbe9 	bl	c0d02220 <io_seproxyhal_spi_recv>
c0d00a4e:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00a50:	4620      	mov	r0, r4
c0d00a52:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00a54:	4803      	ldr	r0, [pc, #12]	; (c0d00a64 <io_exchange_al+0x4c>)
c0d00a56:	6800      	ldr	r0, [r0, #0]
c0d00a58:	2102      	movs	r1, #2
c0d00a5a:	f002 ff27 	bl	c0d038ac <longjmp>
c0d00a5e:	46c0      	nop			; (mov r8, r8)
c0d00a60:	20001c08 	.word	0x20001c08
c0d00a64:	20001bb8 	.word	0x20001bb8

c0d00a68 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00a68:	b580      	push	{r7, lr}
c0d00a6a:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00a6c:	f000 fe72 	bl	c0d01754 <io_seproxyhal_display_default>
}
c0d00a70:	bd80      	pop	{r7, pc}
	...

c0d00a74 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00a74:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a76:	af03      	add	r7, sp, #12
c0d00a78:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00a7a:	48a6      	ldr	r0, [pc, #664]	; (c0d00d14 <io_event+0x2a0>)
c0d00a7c:	7800      	ldrb	r0, [r0, #0]
c0d00a7e:	2805      	cmp	r0, #5
c0d00a80:	d02e      	beq.n	c0d00ae0 <io_event+0x6c>
c0d00a82:	280d      	cmp	r0, #13
c0d00a84:	d04e      	beq.n	c0d00b24 <io_event+0xb0>
c0d00a86:	280c      	cmp	r0, #12
c0d00a88:	d000      	beq.n	c0d00a8c <io_event+0x18>
c0d00a8a:	e13a      	b.n	c0d00d02 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00a8c:	4ea2      	ldr	r6, [pc, #648]	; (c0d00d18 <io_event+0x2a4>)
c0d00a8e:	2001      	movs	r0, #1
c0d00a90:	7630      	strb	r0, [r6, #24]
c0d00a92:	2500      	movs	r5, #0
c0d00a94:	61f5      	str	r5, [r6, #28]
c0d00a96:	4634      	mov	r4, r6
c0d00a98:	3418      	adds	r4, #24
c0d00a9a:	4620      	mov	r0, r4
c0d00a9c:	f001 fb4c 	bl	c0d02138 <os_ux>
c0d00aa0:	61f0      	str	r0, [r6, #28]
c0d00aa2:	499e      	ldr	r1, [pc, #632]	; (c0d00d1c <io_event+0x2a8>)
c0d00aa4:	4288      	cmp	r0, r1
c0d00aa6:	d100      	bne.n	c0d00aaa <io_event+0x36>
c0d00aa8:	e12b      	b.n	c0d00d02 <io_event+0x28e>
c0d00aaa:	2800      	cmp	r0, #0
c0d00aac:	d100      	bne.n	c0d00ab0 <io_event+0x3c>
c0d00aae:	e128      	b.n	c0d00d02 <io_event+0x28e>
c0d00ab0:	499b      	ldr	r1, [pc, #620]	; (c0d00d20 <io_event+0x2ac>)
c0d00ab2:	4288      	cmp	r0, r1
c0d00ab4:	d000      	beq.n	c0d00ab8 <io_event+0x44>
c0d00ab6:	e0ac      	b.n	c0d00c12 <io_event+0x19e>
c0d00ab8:	2003      	movs	r0, #3
c0d00aba:	7630      	strb	r0, [r6, #24]
c0d00abc:	61f5      	str	r5, [r6, #28]
c0d00abe:	4620      	mov	r0, r4
c0d00ac0:	f001 fb3a 	bl	c0d02138 <os_ux>
c0d00ac4:	61f0      	str	r0, [r6, #28]
c0d00ac6:	f000 fcfb 	bl	c0d014c0 <io_seproxyhal_init_ux>
c0d00aca:	60b5      	str	r5, [r6, #8]
c0d00acc:	6830      	ldr	r0, [r6, #0]
c0d00ace:	2800      	cmp	r0, #0
c0d00ad0:	d100      	bne.n	c0d00ad4 <io_event+0x60>
c0d00ad2:	e116      	b.n	c0d00d02 <io_event+0x28e>
c0d00ad4:	69f0      	ldr	r0, [r6, #28]
c0d00ad6:	4991      	ldr	r1, [pc, #580]	; (c0d00d1c <io_event+0x2a8>)
c0d00ad8:	4288      	cmp	r0, r1
c0d00ada:	d000      	beq.n	c0d00ade <io_event+0x6a>
c0d00adc:	e096      	b.n	c0d00c0c <io_event+0x198>
c0d00ade:	e110      	b.n	c0d00d02 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00ae0:	4d8d      	ldr	r5, [pc, #564]	; (c0d00d18 <io_event+0x2a4>)
c0d00ae2:	2001      	movs	r0, #1
c0d00ae4:	7628      	strb	r0, [r5, #24]
c0d00ae6:	2600      	movs	r6, #0
c0d00ae8:	61ee      	str	r6, [r5, #28]
c0d00aea:	462c      	mov	r4, r5
c0d00aec:	3418      	adds	r4, #24
c0d00aee:	4620      	mov	r0, r4
c0d00af0:	f001 fb22 	bl	c0d02138 <os_ux>
c0d00af4:	4601      	mov	r1, r0
c0d00af6:	61e9      	str	r1, [r5, #28]
c0d00af8:	4889      	ldr	r0, [pc, #548]	; (c0d00d20 <io_event+0x2ac>)
c0d00afa:	4281      	cmp	r1, r0
c0d00afc:	d15d      	bne.n	c0d00bba <io_event+0x146>
c0d00afe:	2003      	movs	r0, #3
c0d00b00:	7628      	strb	r0, [r5, #24]
c0d00b02:	61ee      	str	r6, [r5, #28]
c0d00b04:	4620      	mov	r0, r4
c0d00b06:	f001 fb17 	bl	c0d02138 <os_ux>
c0d00b0a:	61e8      	str	r0, [r5, #28]
c0d00b0c:	f000 fcd8 	bl	c0d014c0 <io_seproxyhal_init_ux>
c0d00b10:	60ae      	str	r6, [r5, #8]
c0d00b12:	6828      	ldr	r0, [r5, #0]
c0d00b14:	2800      	cmp	r0, #0
c0d00b16:	d100      	bne.n	c0d00b1a <io_event+0xa6>
c0d00b18:	e0f3      	b.n	c0d00d02 <io_event+0x28e>
c0d00b1a:	69e8      	ldr	r0, [r5, #28]
c0d00b1c:	497f      	ldr	r1, [pc, #508]	; (c0d00d1c <io_event+0x2a8>)
c0d00b1e:	4288      	cmp	r0, r1
c0d00b20:	d148      	bne.n	c0d00bb4 <io_event+0x140>
c0d00b22:	e0ee      	b.n	c0d00d02 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00b24:	4d7c      	ldr	r5, [pc, #496]	; (c0d00d18 <io_event+0x2a4>)
c0d00b26:	6868      	ldr	r0, [r5, #4]
c0d00b28:	68a9      	ldr	r1, [r5, #8]
c0d00b2a:	4281      	cmp	r1, r0
c0d00b2c:	d300      	bcc.n	c0d00b30 <io_event+0xbc>
c0d00b2e:	e0e8      	b.n	c0d00d02 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00b30:	2001      	movs	r0, #1
c0d00b32:	7628      	strb	r0, [r5, #24]
c0d00b34:	2600      	movs	r6, #0
c0d00b36:	61ee      	str	r6, [r5, #28]
c0d00b38:	462c      	mov	r4, r5
c0d00b3a:	3418      	adds	r4, #24
c0d00b3c:	4620      	mov	r0, r4
c0d00b3e:	f001 fafb 	bl	c0d02138 <os_ux>
c0d00b42:	61e8      	str	r0, [r5, #28]
c0d00b44:	4975      	ldr	r1, [pc, #468]	; (c0d00d1c <io_event+0x2a8>)
c0d00b46:	4288      	cmp	r0, r1
c0d00b48:	d100      	bne.n	c0d00b4c <io_event+0xd8>
c0d00b4a:	e0da      	b.n	c0d00d02 <io_event+0x28e>
c0d00b4c:	2800      	cmp	r0, #0
c0d00b4e:	d100      	bne.n	c0d00b52 <io_event+0xde>
c0d00b50:	e0d7      	b.n	c0d00d02 <io_event+0x28e>
c0d00b52:	4973      	ldr	r1, [pc, #460]	; (c0d00d20 <io_event+0x2ac>)
c0d00b54:	4288      	cmp	r0, r1
c0d00b56:	d000      	beq.n	c0d00b5a <io_event+0xe6>
c0d00b58:	e08d      	b.n	c0d00c76 <io_event+0x202>
c0d00b5a:	2003      	movs	r0, #3
c0d00b5c:	7628      	strb	r0, [r5, #24]
c0d00b5e:	61ee      	str	r6, [r5, #28]
c0d00b60:	4620      	mov	r0, r4
c0d00b62:	f001 fae9 	bl	c0d02138 <os_ux>
c0d00b66:	61e8      	str	r0, [r5, #28]
c0d00b68:	f000 fcaa 	bl	c0d014c0 <io_seproxyhal_init_ux>
c0d00b6c:	60ae      	str	r6, [r5, #8]
c0d00b6e:	6828      	ldr	r0, [r5, #0]
c0d00b70:	2800      	cmp	r0, #0
c0d00b72:	d100      	bne.n	c0d00b76 <io_event+0x102>
c0d00b74:	e0c5      	b.n	c0d00d02 <io_event+0x28e>
c0d00b76:	69e8      	ldr	r0, [r5, #28]
c0d00b78:	4968      	ldr	r1, [pc, #416]	; (c0d00d1c <io_event+0x2a8>)
c0d00b7a:	4288      	cmp	r0, r1
c0d00b7c:	d178      	bne.n	c0d00c70 <io_event+0x1fc>
c0d00b7e:	e0c0      	b.n	c0d00d02 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00b80:	6868      	ldr	r0, [r5, #4]
c0d00b82:	4286      	cmp	r6, r0
c0d00b84:	d300      	bcc.n	c0d00b88 <io_event+0x114>
c0d00b86:	e0bc      	b.n	c0d00d02 <io_event+0x28e>
c0d00b88:	f001 fb2e 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d00b8c:	2800      	cmp	r0, #0
c0d00b8e:	d000      	beq.n	c0d00b92 <io_event+0x11e>
c0d00b90:	e0b7      	b.n	c0d00d02 <io_event+0x28e>
c0d00b92:	68a8      	ldr	r0, [r5, #8]
c0d00b94:	68e9      	ldr	r1, [r5, #12]
c0d00b96:	2438      	movs	r4, #56	; 0x38
c0d00b98:	4360      	muls	r0, r4
c0d00b9a:	682a      	ldr	r2, [r5, #0]
c0d00b9c:	1810      	adds	r0, r2, r0
c0d00b9e:	2900      	cmp	r1, #0
c0d00ba0:	d100      	bne.n	c0d00ba4 <io_event+0x130>
c0d00ba2:	e085      	b.n	c0d00cb0 <io_event+0x23c>
c0d00ba4:	4788      	blx	r1
c0d00ba6:	2800      	cmp	r0, #0
c0d00ba8:	d000      	beq.n	c0d00bac <io_event+0x138>
c0d00baa:	e081      	b.n	c0d00cb0 <io_event+0x23c>
c0d00bac:	68a8      	ldr	r0, [r5, #8]
c0d00bae:	1c46      	adds	r6, r0, #1
c0d00bb0:	60ae      	str	r6, [r5, #8]
c0d00bb2:	6828      	ldr	r0, [r5, #0]
c0d00bb4:	2800      	cmp	r0, #0
c0d00bb6:	d1e3      	bne.n	c0d00b80 <io_event+0x10c>
c0d00bb8:	e0a3      	b.n	c0d00d02 <io_event+0x28e>
c0d00bba:	6928      	ldr	r0, [r5, #16]
c0d00bbc:	2800      	cmp	r0, #0
c0d00bbe:	d100      	bne.n	c0d00bc2 <io_event+0x14e>
c0d00bc0:	e09f      	b.n	c0d00d02 <io_event+0x28e>
c0d00bc2:	4a56      	ldr	r2, [pc, #344]	; (c0d00d1c <io_event+0x2a8>)
c0d00bc4:	4291      	cmp	r1, r2
c0d00bc6:	d100      	bne.n	c0d00bca <io_event+0x156>
c0d00bc8:	e09b      	b.n	c0d00d02 <io_event+0x28e>
c0d00bca:	2900      	cmp	r1, #0
c0d00bcc:	d100      	bne.n	c0d00bd0 <io_event+0x15c>
c0d00bce:	e098      	b.n	c0d00d02 <io_event+0x28e>
c0d00bd0:	4950      	ldr	r1, [pc, #320]	; (c0d00d14 <io_event+0x2a0>)
c0d00bd2:	78c9      	ldrb	r1, [r1, #3]
c0d00bd4:	0849      	lsrs	r1, r1, #1
c0d00bd6:	f000 fdff 	bl	c0d017d8 <io_seproxyhal_button_push>
c0d00bda:	e092      	b.n	c0d00d02 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00bdc:	6870      	ldr	r0, [r6, #4]
c0d00bde:	4285      	cmp	r5, r0
c0d00be0:	d300      	bcc.n	c0d00be4 <io_event+0x170>
c0d00be2:	e08e      	b.n	c0d00d02 <io_event+0x28e>
c0d00be4:	f001 fb00 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d00be8:	2800      	cmp	r0, #0
c0d00bea:	d000      	beq.n	c0d00bee <io_event+0x17a>
c0d00bec:	e089      	b.n	c0d00d02 <io_event+0x28e>
c0d00bee:	68b0      	ldr	r0, [r6, #8]
c0d00bf0:	68f1      	ldr	r1, [r6, #12]
c0d00bf2:	2438      	movs	r4, #56	; 0x38
c0d00bf4:	4360      	muls	r0, r4
c0d00bf6:	6832      	ldr	r2, [r6, #0]
c0d00bf8:	1810      	adds	r0, r2, r0
c0d00bfa:	2900      	cmp	r1, #0
c0d00bfc:	d076      	beq.n	c0d00cec <io_event+0x278>
c0d00bfe:	4788      	blx	r1
c0d00c00:	2800      	cmp	r0, #0
c0d00c02:	d173      	bne.n	c0d00cec <io_event+0x278>
c0d00c04:	68b0      	ldr	r0, [r6, #8]
c0d00c06:	1c45      	adds	r5, r0, #1
c0d00c08:	60b5      	str	r5, [r6, #8]
c0d00c0a:	6830      	ldr	r0, [r6, #0]
c0d00c0c:	2800      	cmp	r0, #0
c0d00c0e:	d1e5      	bne.n	c0d00bdc <io_event+0x168>
c0d00c10:	e077      	b.n	c0d00d02 <io_event+0x28e>
c0d00c12:	88b0      	ldrh	r0, [r6, #4]
c0d00c14:	9004      	str	r0, [sp, #16]
c0d00c16:	6830      	ldr	r0, [r6, #0]
c0d00c18:	9003      	str	r0, [sp, #12]
c0d00c1a:	483e      	ldr	r0, [pc, #248]	; (c0d00d14 <io_event+0x2a0>)
c0d00c1c:	4601      	mov	r1, r0
c0d00c1e:	79cc      	ldrb	r4, [r1, #7]
c0d00c20:	798b      	ldrb	r3, [r1, #6]
c0d00c22:	794d      	ldrb	r5, [r1, #5]
c0d00c24:	790a      	ldrb	r2, [r1, #4]
c0d00c26:	4630      	mov	r0, r6
c0d00c28:	78ce      	ldrb	r6, [r1, #3]
c0d00c2a:	68c1      	ldr	r1, [r0, #12]
c0d00c2c:	4668      	mov	r0, sp
c0d00c2e:	6006      	str	r6, [r0, #0]
c0d00c30:	6041      	str	r1, [r0, #4]
c0d00c32:	0212      	lsls	r2, r2, #8
c0d00c34:	432a      	orrs	r2, r5
c0d00c36:	021b      	lsls	r3, r3, #8
c0d00c38:	4323      	orrs	r3, r4
c0d00c3a:	9803      	ldr	r0, [sp, #12]
c0d00c3c:	9904      	ldr	r1, [sp, #16]
c0d00c3e:	f000 fcb9 	bl	c0d015b4 <io_seproxyhal_touch_element_callback>
c0d00c42:	e05e      	b.n	c0d00d02 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00c44:	6868      	ldr	r0, [r5, #4]
c0d00c46:	4286      	cmp	r6, r0
c0d00c48:	d25b      	bcs.n	c0d00d02 <io_event+0x28e>
c0d00c4a:	f001 facd 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d00c4e:	2800      	cmp	r0, #0
c0d00c50:	d157      	bne.n	c0d00d02 <io_event+0x28e>
c0d00c52:	68a8      	ldr	r0, [r5, #8]
c0d00c54:	68e9      	ldr	r1, [r5, #12]
c0d00c56:	2438      	movs	r4, #56	; 0x38
c0d00c58:	4360      	muls	r0, r4
c0d00c5a:	682a      	ldr	r2, [r5, #0]
c0d00c5c:	1810      	adds	r0, r2, r0
c0d00c5e:	2900      	cmp	r1, #0
c0d00c60:	d026      	beq.n	c0d00cb0 <io_event+0x23c>
c0d00c62:	4788      	blx	r1
c0d00c64:	2800      	cmp	r0, #0
c0d00c66:	d123      	bne.n	c0d00cb0 <io_event+0x23c>
c0d00c68:	68a8      	ldr	r0, [r5, #8]
c0d00c6a:	1c46      	adds	r6, r0, #1
c0d00c6c:	60ae      	str	r6, [r5, #8]
c0d00c6e:	6828      	ldr	r0, [r5, #0]
c0d00c70:	2800      	cmp	r0, #0
c0d00c72:	d1e7      	bne.n	c0d00c44 <io_event+0x1d0>
c0d00c74:	e045      	b.n	c0d00d02 <io_event+0x28e>
c0d00c76:	6828      	ldr	r0, [r5, #0]
c0d00c78:	2800      	cmp	r0, #0
c0d00c7a:	d030      	beq.n	c0d00cde <io_event+0x26a>
c0d00c7c:	68a8      	ldr	r0, [r5, #8]
c0d00c7e:	6869      	ldr	r1, [r5, #4]
c0d00c80:	4288      	cmp	r0, r1
c0d00c82:	d22c      	bcs.n	c0d00cde <io_event+0x26a>
c0d00c84:	f001 fab0 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d00c88:	2800      	cmp	r0, #0
c0d00c8a:	d128      	bne.n	c0d00cde <io_event+0x26a>
c0d00c8c:	68a8      	ldr	r0, [r5, #8]
c0d00c8e:	68e9      	ldr	r1, [r5, #12]
c0d00c90:	2438      	movs	r4, #56	; 0x38
c0d00c92:	4360      	muls	r0, r4
c0d00c94:	682a      	ldr	r2, [r5, #0]
c0d00c96:	1810      	adds	r0, r2, r0
c0d00c98:	2900      	cmp	r1, #0
c0d00c9a:	d015      	beq.n	c0d00cc8 <io_event+0x254>
c0d00c9c:	4788      	blx	r1
c0d00c9e:	2800      	cmp	r0, #0
c0d00ca0:	d112      	bne.n	c0d00cc8 <io_event+0x254>
c0d00ca2:	68a8      	ldr	r0, [r5, #8]
c0d00ca4:	1c40      	adds	r0, r0, #1
c0d00ca6:	60a8      	str	r0, [r5, #8]
c0d00ca8:	6829      	ldr	r1, [r5, #0]
c0d00caa:	2900      	cmp	r1, #0
c0d00cac:	d1e7      	bne.n	c0d00c7e <io_event+0x20a>
c0d00cae:	e016      	b.n	c0d00cde <io_event+0x26a>
c0d00cb0:	2801      	cmp	r0, #1
c0d00cb2:	d103      	bne.n	c0d00cbc <io_event+0x248>
c0d00cb4:	68a8      	ldr	r0, [r5, #8]
c0d00cb6:	4344      	muls	r4, r0
c0d00cb8:	6828      	ldr	r0, [r5, #0]
c0d00cba:	1900      	adds	r0, r0, r4
c0d00cbc:	f000 fd4a 	bl	c0d01754 <io_seproxyhal_display_default>
c0d00cc0:	68a8      	ldr	r0, [r5, #8]
c0d00cc2:	1c40      	adds	r0, r0, #1
c0d00cc4:	60a8      	str	r0, [r5, #8]
c0d00cc6:	e01c      	b.n	c0d00d02 <io_event+0x28e>
c0d00cc8:	2801      	cmp	r0, #1
c0d00cca:	d103      	bne.n	c0d00cd4 <io_event+0x260>
c0d00ccc:	68a8      	ldr	r0, [r5, #8]
c0d00cce:	4344      	muls	r4, r0
c0d00cd0:	6828      	ldr	r0, [r5, #0]
c0d00cd2:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00cd4:	f000 fd3e 	bl	c0d01754 <io_seproxyhal_display_default>
c0d00cd8:	68a8      	ldr	r0, [r5, #8]
c0d00cda:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00cdc:	60a8      	str	r0, [r5, #8]
c0d00cde:	6868      	ldr	r0, [r5, #4]
c0d00ce0:	68a9      	ldr	r1, [r5, #8]
c0d00ce2:	4281      	cmp	r1, r0
c0d00ce4:	d30d      	bcc.n	c0d00d02 <io_event+0x28e>
c0d00ce6:	f001 fa7f 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d00cea:	e00a      	b.n	c0d00d02 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00cec:	2801      	cmp	r0, #1
c0d00cee:	d103      	bne.n	c0d00cf8 <io_event+0x284>
c0d00cf0:	68b0      	ldr	r0, [r6, #8]
c0d00cf2:	4344      	muls	r4, r0
c0d00cf4:	6830      	ldr	r0, [r6, #0]
c0d00cf6:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00cf8:	f000 fd2c 	bl	c0d01754 <io_seproxyhal_display_default>
c0d00cfc:	68b0      	ldr	r0, [r6, #8]
c0d00cfe:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00d00:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00d02:	f001 fa71 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d00d06:	2800      	cmp	r0, #0
c0d00d08:	d101      	bne.n	c0d00d0e <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00d0a:	f000 faad 	bl	c0d01268 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00d0e:	2001      	movs	r0, #1
c0d00d10:	b005      	add	sp, #20
c0d00d12:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00d14:	20001a18 	.word	0x20001a18
c0d00d18:	20001a98 	.word	0x20001a98
c0d00d1c:	b0105044 	.word	0xb0105044
c0d00d20:	b0105055 	.word	0xb0105055

c0d00d24 <IOTA_main>:





static void IOTA_main(void) {
c0d00d24:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00d26:	af03      	add	r7, sp, #12
c0d00d28:	b0dd      	sub	sp, #372	; 0x174
c0d00d2a:	2600      	movs	r6, #0
    volatile unsigned int rx = 0;
c0d00d2c:	965c      	str	r6, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00d2e:	965b      	str	r6, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00d30:	965a      	str	r6, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00d32:	a093      	add	r0, pc, #588	; (adr r0, c0d00f80 <IOTA_main+0x25c>)
c0d00d34:	2110      	movs	r1, #16
c0d00d36:	2203      	movs	r2, #3
c0d00d38:	9109      	str	r1, [sp, #36]	; 0x24
c0d00d3a:	9208      	str	r2, [sp, #32]
c0d00d3c:	f7ff f9d4 	bl	c0d000e8 <write_debug>
c0d00d40:	4d93      	ldr	r5, [pc, #588]	; (c0d00f90 <IOTA_main+0x26c>)
c0d00d42:	6828      	ldr	r0, [r5, #0]
c0d00d44:	960a      	str	r6, [sp, #40]	; 0x28
c0d00d46:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00d48:	800e      	strh	r6, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00d4a:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00d4c:	ac4d      	add	r4, sp, #308	; 0x134
c0d00d4e:	4620      	mov	r0, r4
c0d00d50:	f002 fda0 	bl	c0d03894 <setjmp>
c0d00d54:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00d56:	602c      	str	r4, [r5, #0]
c0d00d58:	498e      	ldr	r1, [pc, #568]	; (c0d00f94 <IOTA_main+0x270>)
c0d00d5a:	4208      	tst	r0, r1
c0d00d5c:	d011      	beq.n	c0d00d82 <IOTA_main+0x5e>
c0d00d5e:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00d60:	858e      	strh	r6, [r1, #44]	; 0x2c
c0d00d62:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00d64:	6029      	str	r1, [r5, #0]
c0d00d66:	210f      	movs	r1, #15
c0d00d68:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00d6a:	4001      	ands	r1, r0
c0d00d6c:	2209      	movs	r2, #9
c0d00d6e:	0312      	lsls	r2, r2, #12
c0d00d70:	4291      	cmp	r1, r2
c0d00d72:	d003      	beq.n	c0d00d7c <IOTA_main+0x58>
c0d00d74:	9a08      	ldr	r2, [sp, #32]
c0d00d76:	0352      	lsls	r2, r2, #13
c0d00d78:	4291      	cmp	r1, r2
c0d00d7a:	d141      	bne.n	c0d00e00 <IOTA_main+0xdc>
c0d00d7c:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00d7e:	8008      	strh	r0, [r1, #0]
c0d00d80:	e045      	b.n	c0d00e0e <IOTA_main+0xea>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00d82:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00d84:	905c      	str	r0, [sp, #368]	; 0x170
c0d00d86:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00d88:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00d8a:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00d8c:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00d8e:	b2c0      	uxtb	r0, r0
c0d00d90:	b289      	uxth	r1, r1
c0d00d92:	f000 fd5d 	bl	c0d01850 <io_exchange>
c0d00d96:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00d98:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00d9a:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00d9c:	2800      	cmp	r0, #0
c0d00d9e:	d100      	bne.n	c0d00da2 <IOTA_main+0x7e>
c0d00da0:	e0cb      	b.n	c0d00f3a <IOTA_main+0x216>
c0d00da2:	497e      	ldr	r1, [pc, #504]	; (c0d00f9c <IOTA_main+0x278>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00da4:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00da6:	2580      	movs	r5, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00da8:	2880      	cmp	r0, #128	; 0x80
c0d00daa:	4e7d      	ldr	r6, [pc, #500]	; (c0d00fa0 <IOTA_main+0x27c>)
c0d00dac:	d000      	beq.n	c0d00db0 <IOTA_main+0x8c>
c0d00dae:	e0cc      	b.n	c0d00f4a <IOTA_main+0x226>
c0d00db0:	7848      	ldrb	r0, [r1, #1]
c0d00db2:	216d      	movs	r1, #109	; 0x6d
c0d00db4:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00db6:	2807      	cmp	r0, #7
c0d00db8:	dc36      	bgt.n	c0d00e28 <IOTA_main+0x104>
c0d00dba:	2802      	cmp	r0, #2
c0d00dbc:	d04f      	beq.n	c0d00e5e <IOTA_main+0x13a>
c0d00dbe:	2804      	cmp	r0, #4
c0d00dc0:	d000      	beq.n	c0d00dc4 <IOTA_main+0xa0>
c0d00dc2:	e0ca      	b.n	c0d00f5a <IOTA_main+0x236>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00dc4:	210b      	movs	r1, #11
c0d00dc6:	2203      	movs	r2, #3
c0d00dc8:	a078      	add	r0, pc, #480	; (adr r0, c0d00fac <IOTA_main+0x288>)
c0d00dca:	f7ff f98d 	bl	c0d000e8 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d00dce:	2048      	movs	r0, #72	; 0x48
c0d00dd0:	4972      	ldr	r1, [pc, #456]	; (c0d00f9c <IOTA_main+0x278>)
c0d00dd2:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00dd4:	2049      	movs	r0, #73	; 0x49
c0d00dd6:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d00dd8:	2021      	movs	r0, #33	; 0x21
c0d00dda:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00ddc:	3510      	adds	r5, #16
c0d00dde:	70cd      	strb	r5, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00de0:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00de2:	2005      	movs	r0, #5
c0d00de4:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00de6:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00de8:	b281      	uxth	r1, r0
c0d00dea:	2020      	movs	r0, #32
c0d00dec:	f000 fd30 	bl	c0d01850 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00df0:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00df2:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00df4:	4308      	orrs	r0, r1
c0d00df6:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d00df8:	4620      	mov	r0, r4
c0d00dfa:	4621      	mov	r1, r4
c0d00dfc:	4622      	mov	r2, r4
c0d00dfe:	e08b      	b.n	c0d00f18 <IOTA_main+0x1f4>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00e00:	4965      	ldr	r1, [pc, #404]	; (c0d00f98 <IOTA_main+0x274>)
c0d00e02:	4008      	ands	r0, r1
c0d00e04:	210d      	movs	r1, #13
c0d00e06:	02c9      	lsls	r1, r1, #11
c0d00e08:	4301      	orrs	r1, r0
c0d00e0a:	a859      	add	r0, sp, #356	; 0x164
c0d00e0c:	8001      	strh	r1, [r0, #0]
c0d00e0e:	4a63      	ldr	r2, [pc, #396]	; (c0d00f9c <IOTA_main+0x278>)
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00e10:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00e12:	0a00      	lsrs	r0, r0, #8
c0d00e14:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d00e16:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00e18:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00e1a:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00e1c:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00e1e:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00e20:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00e22:	1c80      	adds	r0, r0, #2
c0d00e24:	905b      	str	r0, [sp, #364]	; 0x16c
c0d00e26:	e07b      	b.n	c0d00f20 <IOTA_main+0x1fc>
c0d00e28:	2808      	cmp	r0, #8
c0d00e2a:	d000      	beq.n	c0d00e2e <IOTA_main+0x10a>
c0d00e2c:	e081      	b.n	c0d00f32 <IOTA_main+0x20e>
c0d00e2e:	485b      	ldr	r0, [pc, #364]	; (c0d00f9c <IOTA_main+0x278>)
c0d00e30:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00e32:	4328      	orrs	r0, r5
c0d00e34:	2880      	cmp	r0, #128	; 0x80
c0d00e36:	d000      	beq.n	c0d00e3a <IOTA_main+0x116>
c0d00e38:	e095      	b.n	c0d00f66 <IOTA_main+0x242>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d00e3a:	7830      	ldrb	r0, [r6, #0]
c0d00e3c:	2800      	cmp	r0, #0
c0d00e3e:	4d54      	ldr	r5, [pc, #336]	; (c0d00f90 <IOTA_main+0x26c>)
c0d00e40:	d003      	beq.n	c0d00e4a <IOTA_main+0x126>
                        cx_sha256_init(&hash);
c0d00e42:	4858      	ldr	r0, [pc, #352]	; (c0d00fa4 <IOTA_main+0x280>)
c0d00e44:	f001 f884 	bl	c0d01f50 <cx_sha256_init>
                        hashTainted = 0;
c0d00e48:	7034      	strb	r4, [r6, #0]
c0d00e4a:	4854      	ldr	r0, [pc, #336]	; (c0d00f9c <IOTA_main+0x278>)
c0d00e4c:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00e4e:	7908      	ldrb	r0, [r1, #4]
c0d00e50:	1808      	adds	r0, r1, r0
c0d00e52:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00e54:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00e56:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00e58:	4308      	orrs	r0, r1
c0d00e5a:	905a      	str	r0, [sp, #360]	; 0x168
c0d00e5c:	e05f      	b.n	c0d00f1e <IOTA_main+0x1fa>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00e5e:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00e60:	2818      	cmp	r0, #24
c0d00e62:	d800      	bhi.n	c0d00e66 <IOTA_main+0x142>
c0d00e64:	e084      	b.n	c0d00f70 <IOTA_main+0x24c>
c0d00e66:	4e4d      	ldr	r6, [pc, #308]	; (c0d00f9c <IOTA_main+0x278>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00e68:	00a0      	lsls	r0, r4, #2
c0d00e6a:	1831      	adds	r1, r6, r0
c0d00e6c:	794a      	ldrb	r2, [r1, #5]
c0d00e6e:	0612      	lsls	r2, r2, #24
c0d00e70:	798b      	ldrb	r3, [r1, #6]
c0d00e72:	041b      	lsls	r3, r3, #16
c0d00e74:	4313      	orrs	r3, r2
c0d00e76:	79ca      	ldrb	r2, [r1, #7]
c0d00e78:	0212      	lsls	r2, r2, #8
c0d00e7a:	431a      	orrs	r2, r3
c0d00e7c:	7a09      	ldrb	r1, [r1, #8]
c0d00e7e:	4311      	orrs	r1, r2
c0d00e80:	aa2b      	add	r2, sp, #172	; 0xac
c0d00e82:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00e84:	1c64      	adds	r4, r4, #1
c0d00e86:	2c05      	cmp	r4, #5
c0d00e88:	d1ee      	bne.n	c0d00e68 <IOTA_main+0x144>
c0d00e8a:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00e8c:	9106      	str	r1, [sp, #24]
c0d00e8e:	4668      	mov	r0, sp
c0d00e90:	6001      	str	r1, [r0, #0]
c0d00e92:	2021      	movs	r0, #33	; 0x21
c0d00e94:	9003      	str	r0, [sp, #12]
c0d00e96:	a92b      	add	r1, sp, #172	; 0xac
c0d00e98:	2205      	movs	r2, #5
c0d00e9a:	ac23      	add	r4, sp, #140	; 0x8c
c0d00e9c:	9405      	str	r4, [sp, #20]
c0d00e9e:	4623      	mov	r3, r4
c0d00ea0:	f001 f90c 	bl	c0d020bc <os_perso_derive_node_bip32>
c0d00ea4:	2220      	movs	r2, #32
c0d00ea6:	9207      	str	r2, [sp, #28]
c0d00ea8:	a830      	add	r0, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00eaa:	9004      	str	r0, [sp, #16]
c0d00eac:	9803      	ldr	r0, [sp, #12]
c0d00eae:	4621      	mov	r1, r4
c0d00eb0:	9b04      	ldr	r3, [sp, #16]
c0d00eb2:	f001 f8c7 	bl	c0d02044 <cx_ecfp_init_private_key>
c0d00eb6:	ab3a      	add	r3, sp, #232	; 0xe8
c0d00eb8:	9302      	str	r3, [sp, #8]
c0d00eba:	9c03      	ldr	r4, [sp, #12]

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00ebc:	4620      	mov	r0, r4
c0d00ebe:	9906      	ldr	r1, [sp, #24]
c0d00ec0:	460a      	mov	r2, r1
c0d00ec2:	f001 f8a1 	bl	c0d02008 <cx_ecfp_init_public_key>
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00ec6:	2301      	movs	r3, #1
c0d00ec8:	4620      	mov	r0, r4
c0d00eca:	9902      	ldr	r1, [sp, #8]
c0d00ecc:	9a04      	ldr	r2, [sp, #16]
c0d00ece:	f001 f8d7 	bl	c0d02080 <cx_ecfp_generate_pair>
c0d00ed2:	aa0e      	add	r2, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00ed4:	9201      	str	r2, [sp, #4]
c0d00ed6:	9805      	ldr	r0, [sp, #20]
c0d00ed8:	9907      	ldr	r1, [sp, #28]
c0d00eda:	f7ff f993 	bl	c0d00204 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d00ede:	2452      	movs	r4, #82	; 0x52
c0d00ee0:	4630      	mov	r0, r6
c0d00ee2:	9901      	ldr	r1, [sp, #4]
c0d00ee4:	4622      	mov	r2, r4
c0d00ee6:	f000 f925 	bl	c0d01134 <os_memmove>
                    tx = 82; // ---------CHECK THE SIZE IN BYTES OF KERL_INIT AND CXA_KECCAK SHIT
c0d00eea:	945b      	str	r4, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d00eec:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00eee:	1c41      	adds	r1, r0, #1
c0d00ef0:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00ef2:	3510      	adds	r5, #16
c0d00ef4:	5435      	strb	r5, [r6, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d00ef6:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00ef8:	1c41      	adds	r1, r0, #1
c0d00efa:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00efc:	9906      	ldr	r1, [sp, #24]
c0d00efe:	5431      	strb	r1, [r6, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00f00:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00f02:	b281      	uxth	r1, r0
c0d00f04:	9807      	ldr	r0, [sp, #28]
c0d00f06:	f000 fca3 	bl	c0d01850 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00f0a:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00f0c:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00f0e:	4308      	orrs	r0, r1
c0d00f10:	905a      	str	r0, [sp, #360]	; 0x168
c0d00f12:	a80b      	add	r0, sp, #44	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
                     */
                    

                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d00f14:	2140      	movs	r1, #64	; 0x40
c0d00f16:	2203      	movs	r2, #3
c0d00f18:	f001 fa16 	bl	c0d02348 <ui_display_debug>
c0d00f1c:	4d1c      	ldr	r5, [pc, #112]	; (c0d00f90 <IOTA_main+0x26c>)
c0d00f1e:	9e0a      	ldr	r6, [sp, #40]	; 0x28
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
                G_io_apdu_buffer[tx + 1] = sw;
                tx += 2;
            }
            FINALLY {
c0d00f20:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d00f22:	6028      	str	r0, [r5, #0]
c0d00f24:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d00f26:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d00f28:	2900      	cmp	r1, #0
c0d00f2a:	d100      	bne.n	c0d00f2e <IOTA_main+0x20a>
c0d00f2c:	e70b      	b.n	c0d00d46 <IOTA_main+0x22>
c0d00f2e:	f002 fcbd 	bl	c0d038ac <longjmp>
c0d00f32:	28ff      	cmp	r0, #255	; 0xff
c0d00f34:	d111      	bne.n	c0d00f5a <IOTA_main+0x236>
    }

return_to_dashboard:
    return;
}
c0d00f36:	b05d      	add	sp, #372	; 0x174
c0d00f38:	bdf0      	pop	{r4, r5, r6, r7, pc}
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d00f3a:	2001      	movs	r0, #1
c0d00f3c:	4918      	ldr	r1, [pc, #96]	; (c0d00fa0 <IOTA_main+0x27c>)
c0d00f3e:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d00f40:	4813      	ldr	r0, [pc, #76]	; (c0d00f90 <IOTA_main+0x26c>)
c0d00f42:	6800      	ldr	r0, [r0, #0]
c0d00f44:	491c      	ldr	r1, [pc, #112]	; (c0d00fb8 <IOTA_main+0x294>)
c0d00f46:	f002 fcb1 	bl	c0d038ac <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d00f4a:	2001      	movs	r0, #1
c0d00f4c:	7030      	strb	r0, [r6, #0]
                    THROW(0x6E00);
c0d00f4e:	4810      	ldr	r0, [pc, #64]	; (c0d00f90 <IOTA_main+0x26c>)
c0d00f50:	6800      	ldr	r0, [r0, #0]
c0d00f52:	2137      	movs	r1, #55	; 0x37
c0d00f54:	0249      	lsls	r1, r1, #9
c0d00f56:	f002 fca9 	bl	c0d038ac <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d00f5a:	2001      	movs	r0, #1
c0d00f5c:	7030      	strb	r0, [r6, #0]
                    THROW(0x6D00);
c0d00f5e:	480c      	ldr	r0, [pc, #48]	; (c0d00f90 <IOTA_main+0x26c>)
c0d00f60:	6800      	ldr	r0, [r0, #0]
c0d00f62:	f002 fca3 	bl	c0d038ac <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d00f66:	480a      	ldr	r0, [pc, #40]	; (c0d00f90 <IOTA_main+0x26c>)
c0d00f68:	6800      	ldr	r0, [r0, #0]
c0d00f6a:	490f      	ldr	r1, [pc, #60]	; (c0d00fa8 <IOTA_main+0x284>)
c0d00f6c:	f002 fc9e 	bl	c0d038ac <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d00f70:	2001      	movs	r0, #1
c0d00f72:	7030      	strb	r0, [r6, #0]
                        THROW(0x6D09);
c0d00f74:	4806      	ldr	r0, [pc, #24]	; (c0d00f90 <IOTA_main+0x26c>)
c0d00f76:	6800      	ldr	r0, [r0, #0]
c0d00f78:	3109      	adds	r1, #9
c0d00f7a:	f002 fc97 	bl	c0d038ac <longjmp>
c0d00f7e:	46c0      	nop			; (mov r8, r8)
c0d00f80:	74696157 	.word	0x74696157
c0d00f84:	20676e69 	.word	0x20676e69
c0d00f88:	20726f66 	.word	0x20726f66
c0d00f8c:	0067736d 	.word	0x0067736d
c0d00f90:	20001bb8 	.word	0x20001bb8
c0d00f94:	0000ffff 	.word	0x0000ffff
c0d00f98:	000007ff 	.word	0x000007ff
c0d00f9c:	20001c08 	.word	0x20001c08
c0d00fa0:	20001b48 	.word	0x20001b48
c0d00fa4:	20001b4c 	.word	0x20001b4c
c0d00fa8:	00006a86 	.word	0x00006a86
c0d00fac:	20646142 	.word	0x20646142
c0d00fb0:	6b627550 	.word	0x6b627550
c0d00fb4:	00007965 	.word	0x00007965
c0d00fb8:	00006982 	.word	0x00006982

c0d00fbc <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00fbc:	4801      	ldr	r0, [pc, #4]	; (c0d00fc4 <os_boot+0x8>)
c0d00fbe:	2100      	movs	r1, #0
c0d00fc0:	6001      	str	r1, [r0, #0]
}
c0d00fc2:	4770      	bx	lr
c0d00fc4:	20001bb8 	.word	0x20001bb8

c0d00fc8 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00fc8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00fca:	af03      	add	r7, sp, #12
c0d00fcc:	b083      	sub	sp, #12
c0d00fce:	9202      	str	r2, [sp, #8]
c0d00fd0:	460c      	mov	r4, r1
c0d00fd2:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00fd4:	4d4a      	ldr	r5, [pc, #296]	; (c0d01100 <io_usb_hid_receive+0x138>)
c0d00fd6:	42ac      	cmp	r4, r5
c0d00fd8:	d00f      	beq.n	c0d00ffa <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00fda:	4e49      	ldr	r6, [pc, #292]	; (c0d01100 <io_usb_hid_receive+0x138>)
c0d00fdc:	2540      	movs	r5, #64	; 0x40
c0d00fde:	4630      	mov	r0, r6
c0d00fe0:	4629      	mov	r1, r5
c0d00fe2:	f002 fbc1 	bl	c0d03768 <__aeabi_memclr>
c0d00fe6:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00fe8:	2840      	cmp	r0, #64	; 0x40
c0d00fea:	4602      	mov	r2, r0
c0d00fec:	d300      	bcc.n	c0d00ff0 <io_usb_hid_receive+0x28>
c0d00fee:	462a      	mov	r2, r5
c0d00ff0:	4630      	mov	r0, r6
c0d00ff2:	4621      	mov	r1, r4
c0d00ff4:	f000 f89e 	bl	c0d01134 <os_memmove>
c0d00ff8:	4d41      	ldr	r5, [pc, #260]	; (c0d01100 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00ffa:	78a8      	ldrb	r0, [r5, #2]
c0d00ffc:	2805      	cmp	r0, #5
c0d00ffe:	d900      	bls.n	c0d01002 <io_usb_hid_receive+0x3a>
c0d01000:	e076      	b.n	c0d010f0 <io_usb_hid_receive+0x128>
c0d01002:	46c0      	nop			; (mov r8, r8)
c0d01004:	4478      	add	r0, pc
c0d01006:	7900      	ldrb	r0, [r0, #4]
c0d01008:	0040      	lsls	r0, r0, #1
c0d0100a:	4487      	add	pc, r0
c0d0100c:	71130c02 	.word	0x71130c02
c0d01010:	1f71      	.short	0x1f71
c0d01012:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01014:	71ae      	strb	r6, [r5, #6]
c0d01016:	716e      	strb	r6, [r5, #5]
c0d01018:	712e      	strb	r6, [r5, #4]
c0d0101a:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d0101c:	2140      	movs	r1, #64	; 0x40
c0d0101e:	4628      	mov	r0, r5
c0d01020:	9a01      	ldr	r2, [sp, #4]
c0d01022:	4790      	blx	r2
c0d01024:	e00b      	b.n	c0d0103e <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d01026:	1ce8      	adds	r0, r5, #3
c0d01028:	2104      	movs	r1, #4
c0d0102a:	f000 ff73 	bl	c0d01f14 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d0102e:	2140      	movs	r1, #64	; 0x40
c0d01030:	4628      	mov	r0, r5
c0d01032:	e001      	b.n	c0d01038 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d01034:	4832      	ldr	r0, [pc, #200]	; (c0d01100 <io_usb_hid_receive+0x138>)
c0d01036:	2140      	movs	r1, #64	; 0x40
c0d01038:	9a01      	ldr	r2, [sp, #4]
c0d0103a:	4790      	blx	r2
c0d0103c:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d0103e:	4831      	ldr	r0, [pc, #196]	; (c0d01104 <io_usb_hid_receive+0x13c>)
c0d01040:	2100      	movs	r1, #0
c0d01042:	6001      	str	r1, [r0, #0]
c0d01044:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d01046:	b2c0      	uxtb	r0, r0
c0d01048:	b003      	add	sp, #12
c0d0104a:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d0104c:	78e8      	ldrb	r0, [r5, #3]
c0d0104e:	4c2d      	ldr	r4, [pc, #180]	; (c0d01104 <io_usb_hid_receive+0x13c>)
c0d01050:	6821      	ldr	r1, [r4, #0]
c0d01052:	0a09      	lsrs	r1, r1, #8
c0d01054:	2600      	movs	r6, #0
c0d01056:	4288      	cmp	r0, r1
c0d01058:	d1f1      	bne.n	c0d0103e <io_usb_hid_receive+0x76>
c0d0105a:	7928      	ldrb	r0, [r5, #4]
c0d0105c:	6821      	ldr	r1, [r4, #0]
c0d0105e:	b2c9      	uxtb	r1, r1
c0d01060:	4288      	cmp	r0, r1
c0d01062:	d1ec      	bne.n	c0d0103e <io_usb_hid_receive+0x76>
c0d01064:	4b28      	ldr	r3, [pc, #160]	; (c0d01108 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d01066:	9802      	ldr	r0, [sp, #8]
c0d01068:	18c0      	adds	r0, r0, r3
c0d0106a:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d0106c:	6820      	ldr	r0, [r4, #0]
c0d0106e:	2800      	cmp	r0, #0
c0d01070:	d00e      	beq.n	c0d01090 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d01072:	4629      	mov	r1, r5
c0d01074:	4019      	ands	r1, r3
c0d01076:	4825      	ldr	r0, [pc, #148]	; (c0d0110c <io_usb_hid_receive+0x144>)
c0d01078:	6802      	ldr	r2, [r0, #0]
c0d0107a:	4291      	cmp	r1, r2
c0d0107c:	461e      	mov	r6, r3
c0d0107e:	d900      	bls.n	c0d01082 <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d01080:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d01082:	462a      	mov	r2, r5
c0d01084:	4032      	ands	r2, r6
c0d01086:	4822      	ldr	r0, [pc, #136]	; (c0d01110 <io_usb_hid_receive+0x148>)
c0d01088:	6800      	ldr	r0, [r0, #0]
c0d0108a:	491d      	ldr	r1, [pc, #116]	; (c0d01100 <io_usb_hid_receive+0x138>)
c0d0108c:	1d49      	adds	r1, r1, #5
c0d0108e:	e021      	b.n	c0d010d4 <io_usb_hid_receive+0x10c>
c0d01090:	9301      	str	r3, [sp, #4]
c0d01092:	491b      	ldr	r1, [pc, #108]	; (c0d01100 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d01094:	7988      	ldrb	r0, [r1, #6]
c0d01096:	7949      	ldrb	r1, [r1, #5]
c0d01098:	0209      	lsls	r1, r1, #8
c0d0109a:	4301      	orrs	r1, r0
c0d0109c:	481d      	ldr	r0, [pc, #116]	; (c0d01114 <io_usb_hid_receive+0x14c>)
c0d0109e:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d010a0:	6801      	ldr	r1, [r0, #0]
c0d010a2:	2241      	movs	r2, #65	; 0x41
c0d010a4:	0092      	lsls	r2, r2, #2
c0d010a6:	4291      	cmp	r1, r2
c0d010a8:	d8c9      	bhi.n	c0d0103e <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d010aa:	6801      	ldr	r1, [r0, #0]
c0d010ac:	4817      	ldr	r0, [pc, #92]	; (c0d0110c <io_usb_hid_receive+0x144>)
c0d010ae:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d010b0:	4917      	ldr	r1, [pc, #92]	; (c0d01110 <io_usb_hid_receive+0x148>)
c0d010b2:	4a19      	ldr	r2, [pc, #100]	; (c0d01118 <io_usb_hid_receive+0x150>)
c0d010b4:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d010b6:	4919      	ldr	r1, [pc, #100]	; (c0d0111c <io_usb_hid_receive+0x154>)
c0d010b8:	9a02      	ldr	r2, [sp, #8]
c0d010ba:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d010bc:	4629      	mov	r1, r5
c0d010be:	9e01      	ldr	r6, [sp, #4]
c0d010c0:	4031      	ands	r1, r6
c0d010c2:	6802      	ldr	r2, [r0, #0]
c0d010c4:	4291      	cmp	r1, r2
c0d010c6:	d900      	bls.n	c0d010ca <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d010c8:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d010ca:	462a      	mov	r2, r5
c0d010cc:	4032      	ands	r2, r6
c0d010ce:	480c      	ldr	r0, [pc, #48]	; (c0d01100 <io_usb_hid_receive+0x138>)
c0d010d0:	1dc1      	adds	r1, r0, #7
c0d010d2:	4811      	ldr	r0, [pc, #68]	; (c0d01118 <io_usb_hid_receive+0x150>)
c0d010d4:	f000 f82e 	bl	c0d01134 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d010d8:	4035      	ands	r5, r6
c0d010da:	480d      	ldr	r0, [pc, #52]	; (c0d01110 <io_usb_hid_receive+0x148>)
c0d010dc:	6801      	ldr	r1, [r0, #0]
c0d010de:	1949      	adds	r1, r1, r5
c0d010e0:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d010e2:	480a      	ldr	r0, [pc, #40]	; (c0d0110c <io_usb_hid_receive+0x144>)
c0d010e4:	6801      	ldr	r1, [r0, #0]
c0d010e6:	1b49      	subs	r1, r1, r5
c0d010e8:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d010ea:	6820      	ldr	r0, [r4, #0]
c0d010ec:	1c40      	adds	r0, r0, #1
c0d010ee:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d010f0:	4806      	ldr	r0, [pc, #24]	; (c0d0110c <io_usb_hid_receive+0x144>)
c0d010f2:	6801      	ldr	r1, [r0, #0]
c0d010f4:	2001      	movs	r0, #1
c0d010f6:	2602      	movs	r6, #2
c0d010f8:	2900      	cmp	r1, #0
c0d010fa:	d1a4      	bne.n	c0d01046 <io_usb_hid_receive+0x7e>
c0d010fc:	e79f      	b.n	c0d0103e <io_usb_hid_receive+0x76>
c0d010fe:	46c0      	nop			; (mov r8, r8)
c0d01100:	20001bbc 	.word	0x20001bbc
c0d01104:	20001bfc 	.word	0x20001bfc
c0d01108:	0000ffff 	.word	0x0000ffff
c0d0110c:	20001c04 	.word	0x20001c04
c0d01110:	20001d0c 	.word	0x20001d0c
c0d01114:	20001c00 	.word	0x20001c00
c0d01118:	20001c08 	.word	0x20001c08
c0d0111c:	0001fff9 	.word	0x0001fff9

c0d01120 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d01120:	b580      	push	{r7, lr}
c0d01122:	af00      	add	r7, sp, #0
c0d01124:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d01126:	2a00      	cmp	r2, #0
c0d01128:	d003      	beq.n	c0d01132 <os_memset+0x12>
    DSTCHAR[length] = c;
c0d0112a:	4611      	mov	r1, r2
c0d0112c:	461a      	mov	r2, r3
c0d0112e:	f002 fb25 	bl	c0d0377c <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d01132:	bd80      	pop	{r7, pc}

c0d01134 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d01134:	b5b0      	push	{r4, r5, r7, lr}
c0d01136:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d01138:	4288      	cmp	r0, r1
c0d0113a:	d90d      	bls.n	c0d01158 <os_memmove+0x24>
    while(length--) {
c0d0113c:	2a00      	cmp	r2, #0
c0d0113e:	d014      	beq.n	c0d0116a <os_memmove+0x36>
c0d01140:	1e49      	subs	r1, r1, #1
c0d01142:	4252      	negs	r2, r2
c0d01144:	1e40      	subs	r0, r0, #1
c0d01146:	2300      	movs	r3, #0
c0d01148:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d0114a:	461c      	mov	r4, r3
c0d0114c:	4354      	muls	r4, r2
c0d0114e:	5d0d      	ldrb	r5, [r1, r4]
c0d01150:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d01152:	1c52      	adds	r2, r2, #1
c0d01154:	d1f9      	bne.n	c0d0114a <os_memmove+0x16>
c0d01156:	e008      	b.n	c0d0116a <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01158:	2a00      	cmp	r2, #0
c0d0115a:	d006      	beq.n	c0d0116a <os_memmove+0x36>
c0d0115c:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d0115e:	b29c      	uxth	r4, r3
c0d01160:	5d0d      	ldrb	r5, [r1, r4]
c0d01162:	5505      	strb	r5, [r0, r4]
      l++;
c0d01164:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01166:	1e52      	subs	r2, r2, #1
c0d01168:	d1f9      	bne.n	c0d0115e <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d0116a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0116c <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d0116c:	4801      	ldr	r0, [pc, #4]	; (c0d01174 <io_usb_hid_init+0x8>)
c0d0116e:	2100      	movs	r1, #0
c0d01170:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d01172:	4770      	bx	lr
c0d01174:	20001bfc 	.word	0x20001bfc

c0d01178 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d01178:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0117a:	af03      	add	r7, sp, #12
c0d0117c:	b087      	sub	sp, #28
c0d0117e:	9301      	str	r3, [sp, #4]
c0d01180:	9203      	str	r2, [sp, #12]
c0d01182:	460e      	mov	r6, r1
c0d01184:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d01186:	2e00      	cmp	r6, #0
c0d01188:	d042      	beq.n	c0d01210 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d0118a:	4d31      	ldr	r5, [pc, #196]	; (c0d01250 <io_usb_hid_exchange+0xd8>)
c0d0118c:	2000      	movs	r0, #0
c0d0118e:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01190:	4930      	ldr	r1, [pc, #192]	; (c0d01254 <io_usb_hid_exchange+0xdc>)
c0d01192:	4831      	ldr	r0, [pc, #196]	; (c0d01258 <io_usb_hid_exchange+0xe0>)
c0d01194:	6008      	str	r0, [r1, #0]
c0d01196:	4c31      	ldr	r4, [pc, #196]	; (c0d0125c <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01198:	1d60      	adds	r0, r4, #5
c0d0119a:	213b      	movs	r1, #59	; 0x3b
c0d0119c:	9005      	str	r0, [sp, #20]
c0d0119e:	9102      	str	r1, [sp, #8]
c0d011a0:	f002 fae2 	bl	c0d03768 <__aeabi_memclr>
c0d011a4:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d011a6:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d011a8:	6828      	ldr	r0, [r5, #0]
c0d011aa:	0a00      	lsrs	r0, r0, #8
c0d011ac:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d011ae:	6828      	ldr	r0, [r5, #0]
c0d011b0:	7120      	strb	r0, [r4, #4]
c0d011b2:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d011b4:	6828      	ldr	r0, [r5, #0]
c0d011b6:	2800      	cmp	r0, #0
c0d011b8:	9106      	str	r1, [sp, #24]
c0d011ba:	d009      	beq.n	c0d011d0 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d011bc:	293b      	cmp	r1, #59	; 0x3b
c0d011be:	460a      	mov	r2, r1
c0d011c0:	d300      	bcc.n	c0d011c4 <io_usb_hid_exchange+0x4c>
c0d011c2:	9a02      	ldr	r2, [sp, #8]
c0d011c4:	4823      	ldr	r0, [pc, #140]	; (c0d01254 <io_usb_hid_exchange+0xdc>)
c0d011c6:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d011c8:	6819      	ldr	r1, [r3, #0]
c0d011ca:	9805      	ldr	r0, [sp, #20]
c0d011cc:	461e      	mov	r6, r3
c0d011ce:	e00a      	b.n	c0d011e6 <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d011d0:	0a30      	lsrs	r0, r6, #8
c0d011d2:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d011d4:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d011d6:	2039      	movs	r0, #57	; 0x39
c0d011d8:	2939      	cmp	r1, #57	; 0x39
c0d011da:	460a      	mov	r2, r1
c0d011dc:	d300      	bcc.n	c0d011e0 <io_usb_hid_exchange+0x68>
c0d011de:	4602      	mov	r2, r0
c0d011e0:	4e1c      	ldr	r6, [pc, #112]	; (c0d01254 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d011e2:	6831      	ldr	r1, [r6, #0]
c0d011e4:	1de0      	adds	r0, r4, #7
c0d011e6:	9205      	str	r2, [sp, #20]
c0d011e8:	f7ff ffa4 	bl	c0d01134 <os_memmove>
c0d011ec:	4d18      	ldr	r5, [pc, #96]	; (c0d01250 <io_usb_hid_exchange+0xd8>)
c0d011ee:	6830      	ldr	r0, [r6, #0]
c0d011f0:	4631      	mov	r1, r6
c0d011f2:	9e05      	ldr	r6, [sp, #20]
c0d011f4:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d011f6:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d011f8:	6828      	ldr	r0, [r5, #0]
c0d011fa:	1c40      	adds	r0, r0, #1
c0d011fc:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d011fe:	2140      	movs	r1, #64	; 0x40
c0d01200:	4620      	mov	r0, r4
c0d01202:	9a04      	ldr	r2, [sp, #16]
c0d01204:	4790      	blx	r2
c0d01206:	9806      	ldr	r0, [sp, #24]
c0d01208:	1b86      	subs	r6, r0, r6
c0d0120a:	4815      	ldr	r0, [pc, #84]	; (c0d01260 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d0120c:	4206      	tst	r6, r0
c0d0120e:	d1c3      	bne.n	c0d01198 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01210:	480f      	ldr	r0, [pc, #60]	; (c0d01250 <io_usb_hid_exchange+0xd8>)
c0d01212:	2400      	movs	r4, #0
c0d01214:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d01216:	2080      	movs	r0, #128	; 0x80
c0d01218:	9901      	ldr	r1, [sp, #4]
c0d0121a:	4201      	tst	r1, r0
c0d0121c:	d001      	beq.n	c0d01222 <io_usb_hid_exchange+0xaa>
    reset();
c0d0121e:	f000 fe3f 	bl	c0d01ea0 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d01222:	9801      	ldr	r0, [sp, #4]
c0d01224:	0680      	lsls	r0, r0, #26
c0d01226:	d40f      	bmi.n	c0d01248 <io_usb_hid_exchange+0xd0>
c0d01228:	4c0c      	ldr	r4, [pc, #48]	; (c0d0125c <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d0122a:	2140      	movs	r1, #64	; 0x40
c0d0122c:	4620      	mov	r0, r4
c0d0122e:	9a03      	ldr	r2, [sp, #12]
c0d01230:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d01232:	b2c2      	uxtb	r2, r0
c0d01234:	2a40      	cmp	r2, #64	; 0x40
c0d01236:	d8f8      	bhi.n	c0d0122a <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d01238:	9804      	ldr	r0, [sp, #16]
c0d0123a:	4621      	mov	r1, r4
c0d0123c:	f7ff fec4 	bl	c0d00fc8 <io_usb_hid_receive>
c0d01240:	2802      	cmp	r0, #2
c0d01242:	d1f2      	bne.n	c0d0122a <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d01244:	4807      	ldr	r0, [pc, #28]	; (c0d01264 <io_usb_hid_exchange+0xec>)
c0d01246:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d01248:	b2a0      	uxth	r0, r4
c0d0124a:	b007      	add	sp, #28
c0d0124c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0124e:	46c0      	nop			; (mov r8, r8)
c0d01250:	20001bfc 	.word	0x20001bfc
c0d01254:	20001d0c 	.word	0x20001d0c
c0d01258:	20001c08 	.word	0x20001c08
c0d0125c:	20001bbc 	.word	0x20001bbc
c0d01260:	0000ffff 	.word	0x0000ffff
c0d01264:	20001c00 	.word	0x20001c00

c0d01268 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d01268:	b580      	push	{r7, lr}
c0d0126a:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d0126c:	f000 ffbc 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d01270:	2800      	cmp	r0, #0
c0d01272:	d10b      	bne.n	c0d0128c <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d01274:	4806      	ldr	r0, [pc, #24]	; (c0d01290 <io_seproxyhal_general_status+0x28>)
c0d01276:	2160      	movs	r1, #96	; 0x60
c0d01278:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d0127a:	2100      	movs	r1, #0
c0d0127c:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d0127e:	2202      	movs	r2, #2
c0d01280:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d01282:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d01284:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d01286:	2105      	movs	r1, #5
c0d01288:	f000 ff90 	bl	c0d021ac <io_seproxyhal_spi_send>
}
c0d0128c:	bd80      	pop	{r7, pc}
c0d0128e:	46c0      	nop			; (mov r8, r8)
c0d01290:	20001a18 	.word	0x20001a18

c0d01294 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d01294:	b5d0      	push	{r4, r6, r7, lr}
c0d01296:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d01298:	4815      	ldr	r0, [pc, #84]	; (c0d012f0 <io_seproxyhal_handle_usb_event+0x5c>)
c0d0129a:	78c0      	ldrb	r0, [r0, #3]
c0d0129c:	1e40      	subs	r0, r0, #1
c0d0129e:	2807      	cmp	r0, #7
c0d012a0:	d824      	bhi.n	c0d012ec <io_seproxyhal_handle_usb_event+0x58>
c0d012a2:	46c0      	nop			; (mov r8, r8)
c0d012a4:	4478      	add	r0, pc
c0d012a6:	7900      	ldrb	r0, [r0, #4]
c0d012a8:	0040      	lsls	r0, r0, #1
c0d012aa:	4487      	add	pc, r0
c0d012ac:	141f1803 	.word	0x141f1803
c0d012b0:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d012b4:	4c0f      	ldr	r4, [pc, #60]	; (c0d012f4 <io_seproxyhal_handle_usb_event+0x60>)
c0d012b6:	2101      	movs	r1, #1
c0d012b8:	4620      	mov	r0, r4
c0d012ba:	f001 fbd5 	bl	c0d02a68 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d012be:	4620      	mov	r0, r4
c0d012c0:	f001 fbba 	bl	c0d02a38 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d012c4:	480c      	ldr	r0, [pc, #48]	; (c0d012f8 <io_seproxyhal_handle_usb_event+0x64>)
c0d012c6:	7800      	ldrb	r0, [r0, #0]
c0d012c8:	2801      	cmp	r0, #1
c0d012ca:	d10f      	bne.n	c0d012ec <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d012cc:	480b      	ldr	r0, [pc, #44]	; (c0d012fc <io_seproxyhal_handle_usb_event+0x68>)
c0d012ce:	6800      	ldr	r0, [r0, #0]
c0d012d0:	2110      	movs	r1, #16
c0d012d2:	f002 faeb 	bl	c0d038ac <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d012d6:	4807      	ldr	r0, [pc, #28]	; (c0d012f4 <io_seproxyhal_handle_usb_event+0x60>)
c0d012d8:	f001 fbc9 	bl	c0d02a6e <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d012dc:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d012de:	4805      	ldr	r0, [pc, #20]	; (c0d012f4 <io_seproxyhal_handle_usb_event+0x60>)
c0d012e0:	f001 fbc9 	bl	c0d02a76 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d012e4:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d012e6:	4803      	ldr	r0, [pc, #12]	; (c0d012f4 <io_seproxyhal_handle_usb_event+0x60>)
c0d012e8:	f001 fbc3 	bl	c0d02a72 <USBD_LL_Resume>
      break;
  }
}
c0d012ec:	bdd0      	pop	{r4, r6, r7, pc}
c0d012ee:	46c0      	nop			; (mov r8, r8)
c0d012f0:	20001a18 	.word	0x20001a18
c0d012f4:	20001d34 	.word	0x20001d34
c0d012f8:	20001d10 	.word	0x20001d10
c0d012fc:	20001bb8 	.word	0x20001bb8

c0d01300 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d01300:	217f      	movs	r1, #127	; 0x7f
c0d01302:	4001      	ands	r1, r0
c0d01304:	4801      	ldr	r0, [pc, #4]	; (c0d0130c <io_seproxyhal_get_ep_rx_size+0xc>)
c0d01306:	5c40      	ldrb	r0, [r0, r1]
c0d01308:	4770      	bx	lr
c0d0130a:	46c0      	nop			; (mov r8, r8)
c0d0130c:	20001d11 	.word	0x20001d11

c0d01310 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d01310:	b580      	push	{r7, lr}
c0d01312:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d01314:	480f      	ldr	r0, [pc, #60]	; (c0d01354 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d01316:	7901      	ldrb	r1, [r0, #4]
c0d01318:	2904      	cmp	r1, #4
c0d0131a:	d008      	beq.n	c0d0132e <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d0131c:	2902      	cmp	r1, #2
c0d0131e:	d011      	beq.n	c0d01344 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d01320:	2901      	cmp	r1, #1
c0d01322:	d10e      	bne.n	c0d01342 <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d01324:	1d81      	adds	r1, r0, #6
c0d01326:	480d      	ldr	r0, [pc, #52]	; (c0d0135c <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01328:	f001 faaa 	bl	c0d02880 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d0132c:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d0132e:	78c2      	ldrb	r2, [r0, #3]
c0d01330:	217f      	movs	r1, #127	; 0x7f
c0d01332:	4011      	ands	r1, r2
c0d01334:	7942      	ldrb	r2, [r0, #5]
c0d01336:	4b08      	ldr	r3, [pc, #32]	; (c0d01358 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d01338:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d0133a:	1d82      	adds	r2, r0, #6
c0d0133c:	4807      	ldr	r0, [pc, #28]	; (c0d0135c <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d0133e:	f001 fad1 	bl	c0d028e4 <USBD_LL_DataOutStage>
      break;
  }
}
c0d01342:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01344:	78c2      	ldrb	r2, [r0, #3]
c0d01346:	217f      	movs	r1, #127	; 0x7f
c0d01348:	4011      	ands	r1, r2
c0d0134a:	1d82      	adds	r2, r0, #6
c0d0134c:	4803      	ldr	r0, [pc, #12]	; (c0d0135c <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d0134e:	f001 fb0f 	bl	c0d02970 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d01352:	bd80      	pop	{r7, pc}
c0d01354:	20001a18 	.word	0x20001a18
c0d01358:	20001d11 	.word	0x20001d11
c0d0135c:	20001d34 	.word	0x20001d34

c0d01360 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d01360:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01362:	af03      	add	r7, sp, #12
c0d01364:	b083      	sub	sp, #12
c0d01366:	9201      	str	r2, [sp, #4]
c0d01368:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d0136a:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d0136c:	2b00      	cmp	r3, #0
c0d0136e:	d100      	bne.n	c0d01372 <io_usb_send_ep+0x12>
c0d01370:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d01372:	9801      	ldr	r0, [sp, #4]
c0d01374:	28ff      	cmp	r0, #255	; 0xff
c0d01376:	d843      	bhi.n	c0d01400 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01378:	4e25      	ldr	r6, [pc, #148]	; (c0d01410 <io_usb_send_ep+0xb0>)
c0d0137a:	2050      	movs	r0, #80	; 0x50
c0d0137c:	7030      	strb	r0, [r6, #0]
c0d0137e:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d01380:	1ce0      	adds	r0, r4, #3
c0d01382:	9100      	str	r1, [sp, #0]
c0d01384:	0a01      	lsrs	r1, r0, #8
c0d01386:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d01388:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d0138a:	2080      	movs	r0, #128	; 0x80
c0d0138c:	4302      	orrs	r2, r0
c0d0138e:	9202      	str	r2, [sp, #8]
c0d01390:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d01392:	2020      	movs	r0, #32
c0d01394:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d01396:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d01398:	2106      	movs	r1, #6
c0d0139a:	4630      	mov	r0, r6
c0d0139c:	f000 ff06 	bl	c0d021ac <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d013a0:	9800      	ldr	r0, [sp, #0]
c0d013a2:	4621      	mov	r1, r4
c0d013a4:	f000 ff02 	bl	c0d021ac <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d013a8:	2d00      	cmp	r5, #0
c0d013aa:	d10d      	bne.n	c0d013c8 <io_usb_send_ep+0x68>
c0d013ac:	e028      	b.n	c0d01400 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d013ae:	2d00      	cmp	r5, #0
c0d013b0:	d002      	beq.n	c0d013b8 <io_usb_send_ep+0x58>
c0d013b2:	1e6c      	subs	r4, r5, #1
c0d013b4:	2d01      	cmp	r5, #1
c0d013b6:	d025      	beq.n	c0d01404 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d013b8:	2915      	cmp	r1, #21
c0d013ba:	d102      	bne.n	c0d013c2 <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d013bc:	79b0      	ldrb	r0, [r6, #6]
c0d013be:	0700      	lsls	r0, r0, #28
c0d013c0:	d520      	bpl.n	c0d01404 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d013c2:	f000 f829 	bl	c0d01418 <io_seproxyhal_handle_event>
c0d013c6:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d013c8:	f000 ff0e 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d013cc:	2800      	cmp	r0, #0
c0d013ce:	d101      	bne.n	c0d013d4 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d013d0:	f7ff ff4a 	bl	c0d01268 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d013d4:	2180      	movs	r1, #128	; 0x80
c0d013d6:	2400      	movs	r4, #0
c0d013d8:	4630      	mov	r0, r6
c0d013da:	4622      	mov	r2, r4
c0d013dc:	f000 ff20 	bl	c0d02220 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d013e0:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d013e2:	2806      	cmp	r0, #6
c0d013e4:	d1e3      	bne.n	c0d013ae <io_usb_send_ep+0x4e>
c0d013e6:	2910      	cmp	r1, #16
c0d013e8:	d1e1      	bne.n	c0d013ae <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d013ea:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d013ec:	9a02      	ldr	r2, [sp, #8]
c0d013ee:	4290      	cmp	r0, r2
c0d013f0:	d1dd      	bne.n	c0d013ae <io_usb_send_ep+0x4e>
c0d013f2:	7930      	ldrb	r0, [r6, #4]
c0d013f4:	2802      	cmp	r0, #2
c0d013f6:	d1da      	bne.n	c0d013ae <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d013f8:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d013fa:	9a01      	ldr	r2, [sp, #4]
c0d013fc:	4290      	cmp	r0, r2
c0d013fe:	d1d6      	bne.n	c0d013ae <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d01400:	b003      	add	sp, #12
c0d01402:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01404:	4803      	ldr	r0, [pc, #12]	; (c0d01414 <io_usb_send_ep+0xb4>)
c0d01406:	6800      	ldr	r0, [r0, #0]
c0d01408:	2110      	movs	r1, #16
c0d0140a:	f002 fa4f 	bl	c0d038ac <longjmp>
c0d0140e:	46c0      	nop			; (mov r8, r8)
c0d01410:	20001a18 	.word	0x20001a18
c0d01414:	20001bb8 	.word	0x20001bb8

c0d01418 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d01418:	b580      	push	{r7, lr}
c0d0141a:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d0141c:	480d      	ldr	r0, [pc, #52]	; (c0d01454 <io_seproxyhal_handle_event+0x3c>)
c0d0141e:	7882      	ldrb	r2, [r0, #2]
c0d01420:	7841      	ldrb	r1, [r0, #1]
c0d01422:	0209      	lsls	r1, r1, #8
c0d01424:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01426:	7800      	ldrb	r0, [r0, #0]
c0d01428:	2810      	cmp	r0, #16
c0d0142a:	d008      	beq.n	c0d0143e <io_seproxyhal_handle_event+0x26>
c0d0142c:	280f      	cmp	r0, #15
c0d0142e:	d10d      	bne.n	c0d0144c <io_seproxyhal_handle_event+0x34>
c0d01430:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d01432:	2904      	cmp	r1, #4
c0d01434:	d10d      	bne.n	c0d01452 <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d01436:	f7ff ff2d 	bl	c0d01294 <io_seproxyhal_handle_usb_event>
c0d0143a:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d0143c:	bd80      	pop	{r7, pc}
c0d0143e:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d01440:	2906      	cmp	r1, #6
c0d01442:	d306      	bcc.n	c0d01452 <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d01444:	f7ff ff64 	bl	c0d01310 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d01448:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d0144a:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d0144c:	2002      	movs	r0, #2
c0d0144e:	f7ff fb11 	bl	c0d00a74 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d01452:	bd80      	pop	{r7, pc}
c0d01454:	20001a18 	.word	0x20001a18

c0d01458 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01458:	b580      	push	{r7, lr}
c0d0145a:	af00      	add	r7, sp, #0
c0d0145c:	460a      	mov	r2, r1
c0d0145e:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01460:	2082      	movs	r0, #130	; 0x82
c0d01462:	2314      	movs	r3, #20
c0d01464:	f7ff ff7c 	bl	c0d01360 <io_usb_send_ep>
}
c0d01468:	bd80      	pop	{r7, pc}
	...

c0d0146c <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d0146c:	b5d0      	push	{r4, r6, r7, lr}
c0d0146e:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01470:	2007      	movs	r0, #7
c0d01472:	f000 fcf7 	bl	c0d01e64 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d01476:	480a      	ldr	r0, [pc, #40]	; (c0d014a0 <io_seproxyhal_init+0x34>)
c0d01478:	2400      	movs	r4, #0
c0d0147a:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d0147c:	4809      	ldr	r0, [pc, #36]	; (c0d014a4 <io_seproxyhal_init+0x38>)
c0d0147e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d01480:	4809      	ldr	r0, [pc, #36]	; (c0d014a8 <io_seproxyhal_init+0x3c>)
c0d01482:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d01484:	4809      	ldr	r0, [pc, #36]	; (c0d014ac <io_seproxyhal_init+0x40>)
c0d01486:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01488:	4809      	ldr	r0, [pc, #36]	; (c0d014b0 <io_seproxyhal_init+0x44>)
c0d0148a:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d0148c:	f7ff fe6e 	bl	c0d0116c <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01490:	4808      	ldr	r0, [pc, #32]	; (c0d014b4 <io_seproxyhal_init+0x48>)
c0d01492:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d01494:	4808      	ldr	r0, [pc, #32]	; (c0d014b8 <io_seproxyhal_init+0x4c>)
c0d01496:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d01498:	4808      	ldr	r0, [pc, #32]	; (c0d014bc <io_seproxyhal_init+0x50>)
c0d0149a:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d0149c:	bdd0      	pop	{r4, r6, r7, pc}
c0d0149e:	46c0      	nop			; (mov r8, r8)
c0d014a0:	20001d18 	.word	0x20001d18
c0d014a4:	20001d1a 	.word	0x20001d1a
c0d014a8:	20001d1c 	.word	0x20001d1c
c0d014ac:	20001d1e 	.word	0x20001d1e
c0d014b0:	20001d10 	.word	0x20001d10
c0d014b4:	20001d20 	.word	0x20001d20
c0d014b8:	20001d24 	.word	0x20001d24
c0d014bc:	20001d28 	.word	0x20001d28

c0d014c0 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d014c0:	4801      	ldr	r0, [pc, #4]	; (c0d014c8 <io_seproxyhal_init_ux+0x8>)
c0d014c2:	2100      	movs	r1, #0
c0d014c4:	6001      	str	r1, [r0, #0]

}
c0d014c6:	4770      	bx	lr
c0d014c8:	20001d20 	.word	0x20001d20

c0d014cc <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d014cc:	b5b0      	push	{r4, r5, r7, lr}
c0d014ce:	af02      	add	r7, sp, #8
c0d014d0:	460d      	mov	r5, r1
c0d014d2:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d014d4:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d014d6:	2800      	cmp	r0, #0
c0d014d8:	d00c      	beq.n	c0d014f4 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d014da:	f000 fcab 	bl	c0d01e34 <pic>
c0d014de:	4601      	mov	r1, r0
c0d014e0:	4620      	mov	r0, r4
c0d014e2:	4788      	blx	r1
c0d014e4:	f000 fca6 	bl	c0d01e34 <pic>
c0d014e8:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d014ea:	2800      	cmp	r0, #0
c0d014ec:	d010      	beq.n	c0d01510 <io_seproxyhal_touch_out+0x44>
c0d014ee:	2801      	cmp	r0, #1
c0d014f0:	d000      	beq.n	c0d014f4 <io_seproxyhal_touch_out+0x28>
c0d014f2:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d014f4:	2d00      	cmp	r5, #0
c0d014f6:	d007      	beq.n	c0d01508 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d014f8:	4620      	mov	r0, r4
c0d014fa:	47a8      	blx	r5
c0d014fc:	2100      	movs	r1, #0
    if (!el) {
c0d014fe:	2800      	cmp	r0, #0
c0d01500:	d006      	beq.n	c0d01510 <io_seproxyhal_touch_out+0x44>
c0d01502:	2801      	cmp	r0, #1
c0d01504:	d000      	beq.n	c0d01508 <io_seproxyhal_touch_out+0x3c>
c0d01506:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d01508:	4620      	mov	r0, r4
c0d0150a:	f7ff faad 	bl	c0d00a68 <io_seproxyhal_display>
c0d0150e:	2101      	movs	r1, #1
  return 1;
}
c0d01510:	4608      	mov	r0, r1
c0d01512:	bdb0      	pop	{r4, r5, r7, pc}

c0d01514 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01514:	b5b0      	push	{r4, r5, r7, lr}
c0d01516:	af02      	add	r7, sp, #8
c0d01518:	b08e      	sub	sp, #56	; 0x38
c0d0151a:	460c      	mov	r4, r1
c0d0151c:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d0151e:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d01520:	2800      	cmp	r0, #0
c0d01522:	d00c      	beq.n	c0d0153e <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d01524:	f000 fc86 	bl	c0d01e34 <pic>
c0d01528:	4601      	mov	r1, r0
c0d0152a:	4628      	mov	r0, r5
c0d0152c:	4788      	blx	r1
c0d0152e:	f000 fc81 	bl	c0d01e34 <pic>
c0d01532:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01534:	2800      	cmp	r0, #0
c0d01536:	d016      	beq.n	c0d01566 <io_seproxyhal_touch_over+0x52>
c0d01538:	2801      	cmp	r0, #1
c0d0153a:	d000      	beq.n	c0d0153e <io_seproxyhal_touch_over+0x2a>
c0d0153c:	4605      	mov	r5, r0
c0d0153e:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d01540:	2238      	movs	r2, #56	; 0x38
c0d01542:	4629      	mov	r1, r5
c0d01544:	f7ff fdf6 	bl	c0d01134 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d01548:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d0154a:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d0154c:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d0154e:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d01550:	2c00      	cmp	r4, #0
c0d01552:	d004      	beq.n	c0d0155e <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01554:	4628      	mov	r0, r5
c0d01556:	47a0      	blx	r4
c0d01558:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d0155a:	2800      	cmp	r0, #0
c0d0155c:	d003      	beq.n	c0d01566 <io_seproxyhal_touch_over+0x52>
c0d0155e:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01560:	f7ff fa82 	bl	c0d00a68 <io_seproxyhal_display>
c0d01564:	2101      	movs	r1, #1
  return 1;
}
c0d01566:	4608      	mov	r0, r1
c0d01568:	b00e      	add	sp, #56	; 0x38
c0d0156a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0156c <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d0156c:	b5b0      	push	{r4, r5, r7, lr}
c0d0156e:	af02      	add	r7, sp, #8
c0d01570:	460d      	mov	r5, r1
c0d01572:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01574:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d01576:	2800      	cmp	r0, #0
c0d01578:	d00c      	beq.n	c0d01594 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d0157a:	f000 fc5b 	bl	c0d01e34 <pic>
c0d0157e:	4601      	mov	r1, r0
c0d01580:	4620      	mov	r0, r4
c0d01582:	4788      	blx	r1
c0d01584:	f000 fc56 	bl	c0d01e34 <pic>
c0d01588:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0158a:	2800      	cmp	r0, #0
c0d0158c:	d010      	beq.n	c0d015b0 <io_seproxyhal_touch_tap+0x44>
c0d0158e:	2801      	cmp	r0, #1
c0d01590:	d000      	beq.n	c0d01594 <io_seproxyhal_touch_tap+0x28>
c0d01592:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01594:	2d00      	cmp	r5, #0
c0d01596:	d007      	beq.n	c0d015a8 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d01598:	4620      	mov	r0, r4
c0d0159a:	47a8      	blx	r5
c0d0159c:	2100      	movs	r1, #0
    if (!el) {
c0d0159e:	2800      	cmp	r0, #0
c0d015a0:	d006      	beq.n	c0d015b0 <io_seproxyhal_touch_tap+0x44>
c0d015a2:	2801      	cmp	r0, #1
c0d015a4:	d000      	beq.n	c0d015a8 <io_seproxyhal_touch_tap+0x3c>
c0d015a6:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d015a8:	4620      	mov	r0, r4
c0d015aa:	f7ff fa5d 	bl	c0d00a68 <io_seproxyhal_display>
c0d015ae:	2101      	movs	r1, #1
  return 1;
}
c0d015b0:	4608      	mov	r0, r1
c0d015b2:	bdb0      	pop	{r4, r5, r7, pc}

c0d015b4 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d015b4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d015b6:	af03      	add	r7, sp, #12
c0d015b8:	b087      	sub	sp, #28
c0d015ba:	9302      	str	r3, [sp, #8]
c0d015bc:	9203      	str	r2, [sp, #12]
c0d015be:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d015c0:	2900      	cmp	r1, #0
c0d015c2:	d076      	beq.n	c0d016b2 <io_seproxyhal_touch_element_callback+0xfe>
c0d015c4:	9004      	str	r0, [sp, #16]
c0d015c6:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d015c8:	9001      	str	r0, [sp, #4]
c0d015ca:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d015cc:	9000      	str	r0, [sp, #0]
c0d015ce:	2600      	movs	r6, #0
c0d015d0:	9606      	str	r6, [sp, #24]
c0d015d2:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d015d4:	f000 fe08 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d015d8:	2800      	cmp	r0, #0
c0d015da:	d155      	bne.n	c0d01688 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d015dc:	2038      	movs	r0, #56	; 0x38
c0d015de:	4370      	muls	r0, r6
c0d015e0:	9d04      	ldr	r5, [sp, #16]
c0d015e2:	182e      	adds	r6, r5, r0
c0d015e4:	4b36      	ldr	r3, [pc, #216]	; (c0d016c0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d015e6:	681a      	ldr	r2, [r3, #0]
c0d015e8:	2101      	movs	r1, #1
c0d015ea:	4296      	cmp	r6, r2
c0d015ec:	d000      	beq.n	c0d015f0 <io_seproxyhal_touch_element_callback+0x3c>
c0d015ee:	9906      	ldr	r1, [sp, #24]
c0d015f0:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d015f2:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d015f4:	2800      	cmp	r0, #0
c0d015f6:	da41      	bge.n	c0d0167c <io_seproxyhal_touch_element_callback+0xc8>
c0d015f8:	2020      	movs	r0, #32
c0d015fa:	5c35      	ldrb	r5, [r6, r0]
c0d015fc:	2102      	movs	r1, #2
c0d015fe:	5e71      	ldrsh	r1, [r6, r1]
c0d01600:	1b4a      	subs	r2, r1, r5
c0d01602:	9803      	ldr	r0, [sp, #12]
c0d01604:	4282      	cmp	r2, r0
c0d01606:	dc39      	bgt.n	c0d0167c <io_seproxyhal_touch_element_callback+0xc8>
c0d01608:	1869      	adds	r1, r5, r1
c0d0160a:	88f2      	ldrh	r2, [r6, #6]
c0d0160c:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d0160e:	9803      	ldr	r0, [sp, #12]
c0d01610:	4288      	cmp	r0, r1
c0d01612:	da33      	bge.n	c0d0167c <io_seproxyhal_touch_element_callback+0xc8>
c0d01614:	2104      	movs	r1, #4
c0d01616:	5e70      	ldrsh	r0, [r6, r1]
c0d01618:	1b42      	subs	r2, r0, r5
c0d0161a:	9902      	ldr	r1, [sp, #8]
c0d0161c:	428a      	cmp	r2, r1
c0d0161e:	dc2d      	bgt.n	c0d0167c <io_seproxyhal_touch_element_callback+0xc8>
c0d01620:	1940      	adds	r0, r0, r5
c0d01622:	8931      	ldrh	r1, [r6, #8]
c0d01624:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01626:	9902      	ldr	r1, [sp, #8]
c0d01628:	4281      	cmp	r1, r0
c0d0162a:	da27      	bge.n	c0d0167c <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d0162c:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d0162e:	4286      	cmp	r6, r0
c0d01630:	d010      	beq.n	c0d01654 <io_seproxyhal_touch_element_callback+0xa0>
c0d01632:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01634:	2800      	cmp	r0, #0
c0d01636:	d00d      	beq.n	c0d01654 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d01638:	9801      	ldr	r0, [sp, #4]
c0d0163a:	2800      	cmp	r0, #0
c0d0163c:	d005      	beq.n	c0d0164a <io_seproxyhal_touch_element_callback+0x96>
c0d0163e:	4630      	mov	r0, r6
c0d01640:	9901      	ldr	r1, [sp, #4]
c0d01642:	4788      	blx	r1
c0d01644:	4b1e      	ldr	r3, [pc, #120]	; (c0d016c0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01646:	2800      	cmp	r0, #0
c0d01648:	d018      	beq.n	c0d0167c <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d0164a:	6818      	ldr	r0, [r3, #0]
c0d0164c:	9901      	ldr	r1, [sp, #4]
c0d0164e:	f7ff ff3d 	bl	c0d014cc <io_seproxyhal_touch_out>
c0d01652:	e008      	b.n	c0d01666 <io_seproxyhal_touch_element_callback+0xb2>
c0d01654:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d01656:	2801      	cmp	r0, #1
c0d01658:	d009      	beq.n	c0d0166e <io_seproxyhal_touch_element_callback+0xba>
c0d0165a:	2802      	cmp	r0, #2
c0d0165c:	d10e      	bne.n	c0d0167c <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d0165e:	4630      	mov	r0, r6
c0d01660:	9901      	ldr	r1, [sp, #4]
c0d01662:	f7ff ff83 	bl	c0d0156c <io_seproxyhal_touch_tap>
c0d01666:	4b16      	ldr	r3, [pc, #88]	; (c0d016c0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01668:	2800      	cmp	r0, #0
c0d0166a:	d007      	beq.n	c0d0167c <io_seproxyhal_touch_element_callback+0xc8>
c0d0166c:	e023      	b.n	c0d016b6 <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d0166e:	4630      	mov	r0, r6
c0d01670:	9901      	ldr	r1, [sp, #4]
c0d01672:	f7ff ff4f 	bl	c0d01514 <io_seproxyhal_touch_over>
c0d01676:	4b12      	ldr	r3, [pc, #72]	; (c0d016c0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01678:	2800      	cmp	r0, #0
c0d0167a:	d11f      	bne.n	c0d016bc <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d0167c:	1c64      	adds	r4, r4, #1
c0d0167e:	b2e6      	uxtb	r6, r4
c0d01680:	9805      	ldr	r0, [sp, #20]
c0d01682:	4286      	cmp	r6, r0
c0d01684:	d3a6      	bcc.n	c0d015d4 <io_seproxyhal_touch_element_callback+0x20>
c0d01686:	e000      	b.n	c0d0168a <io_seproxyhal_touch_element_callback+0xd6>
c0d01688:	4b0d      	ldr	r3, [pc, #52]	; (c0d016c0 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d0168a:	9806      	ldr	r0, [sp, #24]
c0d0168c:	0600      	lsls	r0, r0, #24
c0d0168e:	d010      	beq.n	c0d016b2 <io_seproxyhal_touch_element_callback+0xfe>
c0d01690:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d01692:	2800      	cmp	r0, #0
c0d01694:	d00d      	beq.n	c0d016b2 <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01696:	f000 fda7 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d0169a:	4909      	ldr	r1, [pc, #36]	; (c0d016c0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0169c:	2800      	cmp	r0, #0
c0d0169e:	d108      	bne.n	c0d016b2 <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d016a0:	6808      	ldr	r0, [r1, #0]
c0d016a2:	9901      	ldr	r1, [sp, #4]
c0d016a4:	f7ff ff12 	bl	c0d014cc <io_seproxyhal_touch_out>
c0d016a8:	4d05      	ldr	r5, [pc, #20]	; (c0d016c0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d016aa:	2800      	cmp	r0, #0
c0d016ac:	d001      	beq.n	c0d016b2 <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d016ae:	2000      	movs	r0, #0
c0d016b0:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d016b2:	b007      	add	sp, #28
c0d016b4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d016b6:	2000      	movs	r0, #0
c0d016b8:	6018      	str	r0, [r3, #0]
c0d016ba:	e7fa      	b.n	c0d016b2 <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d016bc:	601e      	str	r6, [r3, #0]
c0d016be:	e7f8      	b.n	c0d016b2 <io_seproxyhal_touch_element_callback+0xfe>
c0d016c0:	20001d20 	.word	0x20001d20

c0d016c4 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d016c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d016c6:	af03      	add	r7, sp, #12
c0d016c8:	b08b      	sub	sp, #44	; 0x2c
c0d016ca:	460c      	mov	r4, r1
c0d016cc:	4601      	mov	r1, r0
c0d016ce:	ad04      	add	r5, sp, #16
c0d016d0:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d016d2:	4628      	mov	r0, r5
c0d016d4:	9203      	str	r2, [sp, #12]
c0d016d6:	f7ff fd2d 	bl	c0d01134 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d016da:	6821      	ldr	r1, [r4, #0]
c0d016dc:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d016de:	6862      	ldr	r2, [r4, #4]
c0d016e0:	9502      	str	r5, [sp, #8]
c0d016e2:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d016e4:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d016e6:	4e1a      	ldr	r6, [pc, #104]	; (c0d01750 <io_seproxyhal_display_icon+0x8c>)
c0d016e8:	2365      	movs	r3, #101	; 0x65
c0d016ea:	4635      	mov	r5, r6
c0d016ec:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d016ee:	b292      	uxth	r2, r2
c0d016f0:	4342      	muls	r2, r0
c0d016f2:	b28b      	uxth	r3, r1
c0d016f4:	4353      	muls	r3, r2
c0d016f6:	08d9      	lsrs	r1, r3, #3
c0d016f8:	1c4e      	adds	r6, r1, #1
c0d016fa:	2207      	movs	r2, #7
c0d016fc:	4213      	tst	r3, r2
c0d016fe:	d100      	bne.n	c0d01702 <io_seproxyhal_display_icon+0x3e>
c0d01700:	460e      	mov	r6, r1
c0d01702:	4631      	mov	r1, r6
c0d01704:	9101      	str	r1, [sp, #4]
c0d01706:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01708:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d0170a:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d0170c:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0170e:	0a01      	lsrs	r1, r0, #8
c0d01710:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d01712:	70a8      	strb	r0, [r5, #2]
c0d01714:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01716:	4628      	mov	r0, r5
c0d01718:	f000 fd48 	bl	c0d021ac <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d0171c:	9802      	ldr	r0, [sp, #8]
c0d0171e:	9903      	ldr	r1, [sp, #12]
c0d01720:	f000 fd44 	bl	c0d021ac <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01724:	68a0      	ldr	r0, [r4, #8]
c0d01726:	7028      	strb	r0, [r5, #0]
c0d01728:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d0172a:	4628      	mov	r0, r5
c0d0172c:	f000 fd3e 	bl	c0d021ac <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d01730:	68e0      	ldr	r0, [r4, #12]
c0d01732:	f000 fb7f 	bl	c0d01e34 <pic>
c0d01736:	b2b1      	uxth	r1, r6
c0d01738:	f000 fd38 	bl	c0d021ac <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d0173c:	9801      	ldr	r0, [sp, #4]
c0d0173e:	b285      	uxth	r5, r0
c0d01740:	6920      	ldr	r0, [r4, #16]
c0d01742:	f000 fb77 	bl	c0d01e34 <pic>
c0d01746:	4629      	mov	r1, r5
c0d01748:	f000 fd30 	bl	c0d021ac <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d0174c:	b00b      	add	sp, #44	; 0x2c
c0d0174e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01750:	20001a18 	.word	0x20001a18

c0d01754 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01754:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01756:	af03      	add	r7, sp, #12
c0d01758:	b081      	sub	sp, #4
c0d0175a:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d0175c:	7820      	ldrb	r0, [r4, #0]
c0d0175e:	267f      	movs	r6, #127	; 0x7f
c0d01760:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d01762:	2e00      	cmp	r6, #0
c0d01764:	d02e      	beq.n	c0d017c4 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d01766:	69e0      	ldr	r0, [r4, #28]
c0d01768:	2800      	cmp	r0, #0
c0d0176a:	d01d      	beq.n	c0d017a8 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d0176c:	f000 fb62 	bl	c0d01e34 <pic>
c0d01770:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d01772:	2e05      	cmp	r6, #5
c0d01774:	d102      	bne.n	c0d0177c <io_seproxyhal_display_default+0x28>
c0d01776:	7ea0      	ldrb	r0, [r4, #26]
c0d01778:	2800      	cmp	r0, #0
c0d0177a:	d025      	beq.n	c0d017c8 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0177c:	4628      	mov	r0, r5
c0d0177e:	f002 f8a3 	bl	c0d038c8 <strlen>
c0d01782:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01784:	4813      	ldr	r0, [pc, #76]	; (c0d017d4 <io_seproxyhal_display_default+0x80>)
c0d01786:	2165      	movs	r1, #101	; 0x65
c0d01788:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0178a:	4631      	mov	r1, r6
c0d0178c:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0178e:	0a0a      	lsrs	r2, r1, #8
c0d01790:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d01792:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01794:	2103      	movs	r1, #3
c0d01796:	f000 fd09 	bl	c0d021ac <io_seproxyhal_spi_send>
c0d0179a:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d0179c:	4620      	mov	r0, r4
c0d0179e:	f000 fd05 	bl	c0d021ac <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d017a2:	b2b1      	uxth	r1, r6
c0d017a4:	4628      	mov	r0, r5
c0d017a6:	e00b      	b.n	c0d017c0 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d017a8:	480a      	ldr	r0, [pc, #40]	; (c0d017d4 <io_seproxyhal_display_default+0x80>)
c0d017aa:	2165      	movs	r1, #101	; 0x65
c0d017ac:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d017ae:	2100      	movs	r1, #0
c0d017b0:	7041      	strb	r1, [r0, #1]
c0d017b2:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d017b4:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d017b6:	2103      	movs	r1, #3
c0d017b8:	f000 fcf8 	bl	c0d021ac <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d017bc:	4620      	mov	r0, r4
c0d017be:	4629      	mov	r1, r5
c0d017c0:	f000 fcf4 	bl	c0d021ac <io_seproxyhal_spi_send>
    }
  }
}
c0d017c4:	b001      	add	sp, #4
c0d017c6:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d017c8:	4620      	mov	r0, r4
c0d017ca:	4629      	mov	r1, r5
c0d017cc:	f7ff ff7a 	bl	c0d016c4 <io_seproxyhal_display_icon>
c0d017d0:	e7f8      	b.n	c0d017c4 <io_seproxyhal_display_default+0x70>
c0d017d2:	46c0      	nop			; (mov r8, r8)
c0d017d4:	20001a18 	.word	0x20001a18

c0d017d8 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d017d8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d017da:	af03      	add	r7, sp, #12
c0d017dc:	b081      	sub	sp, #4
c0d017de:	4604      	mov	r4, r0
  if (button_callback) {
c0d017e0:	2c00      	cmp	r4, #0
c0d017e2:	d02e      	beq.n	c0d01842 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d017e4:	4818      	ldr	r0, [pc, #96]	; (c0d01848 <io_seproxyhal_button_push+0x70>)
c0d017e6:	6802      	ldr	r2, [r0, #0]
c0d017e8:	428a      	cmp	r2, r1
c0d017ea:	d103      	bne.n	c0d017f4 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d017ec:	4a17      	ldr	r2, [pc, #92]	; (c0d0184c <io_seproxyhal_button_push+0x74>)
c0d017ee:	6813      	ldr	r3, [r2, #0]
c0d017f0:	1c5b      	adds	r3, r3, #1
c0d017f2:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d017f4:	6806      	ldr	r6, [r0, #0]
c0d017f6:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d017f8:	4a14      	ldr	r2, [pc, #80]	; (c0d0184c <io_seproxyhal_button_push+0x74>)
c0d017fa:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d017fc:	2900      	cmp	r1, #0
c0d017fe:	d001      	beq.n	c0d01804 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01800:	6006      	str	r6, [r0, #0]
c0d01802:	e005      	b.n	c0d01810 <io_seproxyhal_button_push+0x38>
c0d01804:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d01806:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d01808:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d0180a:	2301      	movs	r3, #1
c0d0180c:	07db      	lsls	r3, r3, #31
c0d0180e:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d01810:	6800      	ldr	r0, [r0, #0]
c0d01812:	4288      	cmp	r0, r1
c0d01814:	d001      	beq.n	c0d0181a <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d01816:	2000      	movs	r0, #0
c0d01818:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d0181a:	2d08      	cmp	r5, #8
c0d0181c:	d30e      	bcc.n	c0d0183c <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d0181e:	2103      	movs	r1, #3
c0d01820:	4628      	mov	r0, r5
c0d01822:	f001 fda7 	bl	c0d03374 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d01826:	2001      	movs	r0, #1
c0d01828:	0780      	lsls	r0, r0, #30
c0d0182a:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d0182c:	2900      	cmp	r1, #0
c0d0182e:	4601      	mov	r1, r0
c0d01830:	d000      	beq.n	c0d01834 <io_seproxyhal_button_push+0x5c>
c0d01832:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01834:	2900      	cmp	r1, #0
c0d01836:	db02      	blt.n	c0d0183e <io_seproxyhal_button_push+0x66>
c0d01838:	4608      	mov	r0, r1
c0d0183a:	e000      	b.n	c0d0183e <io_seproxyhal_button_push+0x66>
c0d0183c:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d0183e:	4629      	mov	r1, r5
c0d01840:	47a0      	blx	r4
  }
}
c0d01842:	b001      	add	sp, #4
c0d01844:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01846:	46c0      	nop			; (mov r8, r8)
c0d01848:	20001d24 	.word	0x20001d24
c0d0184c:	20001d28 	.word	0x20001d28

c0d01850 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01850:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01852:	af03      	add	r7, sp, #12
c0d01854:	b081      	sub	sp, #4
c0d01856:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01858:	200f      	movs	r0, #15
c0d0185a:	4204      	tst	r4, r0
c0d0185c:	d006      	beq.n	c0d0186c <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d0185e:	4620      	mov	r0, r4
c0d01860:	f7ff f8da 	bl	c0d00a18 <io_exchange_al>
c0d01864:	4605      	mov	r5, r0
  }
}
c0d01866:	b2a8      	uxth	r0, r5
c0d01868:	b001      	add	sp, #4
c0d0186a:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d0186c:	2610      	movs	r6, #16
c0d0186e:	4026      	ands	r6, r4
c0d01870:	2900      	cmp	r1, #0
c0d01872:	d02a      	beq.n	c0d018ca <io_exchange+0x7a>
c0d01874:	2e00      	cmp	r6, #0
c0d01876:	d128      	bne.n	c0d018ca <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01878:	483d      	ldr	r0, [pc, #244]	; (c0d01970 <io_exchange+0x120>)
c0d0187a:	7800      	ldrb	r0, [r0, #0]
c0d0187c:	2807      	cmp	r0, #7
c0d0187e:	d00b      	beq.n	c0d01898 <io_exchange+0x48>
c0d01880:	2800      	cmp	r0, #0
c0d01882:	d004      	beq.n	c0d0188e <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01884:	4620      	mov	r0, r4
c0d01886:	f7ff f8c7 	bl	c0d00a18 <io_exchange_al>
c0d0188a:	2800      	cmp	r0, #0
c0d0188c:	d00a      	beq.n	c0d018a4 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d0188e:	4839      	ldr	r0, [pc, #228]	; (c0d01974 <io_exchange+0x124>)
c0d01890:	6800      	ldr	r0, [r0, #0]
c0d01892:	2109      	movs	r1, #9
c0d01894:	f002 f80a 	bl	c0d038ac <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01898:	483d      	ldr	r0, [pc, #244]	; (c0d01990 <io_exchange+0x140>)
c0d0189a:	4478      	add	r0, pc
c0d0189c:	2200      	movs	r2, #0
c0d0189e:	2320      	movs	r3, #32
c0d018a0:	f7ff fc6a 	bl	c0d01178 <io_usb_hid_exchange>
c0d018a4:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d018a6:	4832      	ldr	r0, [pc, #200]	; (c0d01970 <io_exchange+0x120>)
c0d018a8:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d018aa:	4833      	ldr	r0, [pc, #204]	; (c0d01978 <io_exchange+0x128>)
c0d018ac:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d018ae:	4833      	ldr	r0, [pc, #204]	; (c0d0197c <io_exchange+0x12c>)
c0d018b0:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d018b2:	4833      	ldr	r0, [pc, #204]	; (c0d01980 <io_exchange+0x130>)
c0d018b4:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d018b6:	4833      	ldr	r0, [pc, #204]	; (c0d01984 <io_exchange+0x134>)
c0d018b8:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d018ba:	06a0      	lsls	r0, r4, #26
c0d018bc:	d4d3      	bmi.n	c0d01866 <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d018be:	f7ff fcd3 	bl	c0d01268 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d018c2:	0620      	lsls	r0, r4, #24
c0d018c4:	d501      	bpl.n	c0d018ca <io_exchange+0x7a>
        reset();
c0d018c6:	f000 faeb 	bl	c0d01ea0 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d018ca:	2e00      	cmp	r6, #0
c0d018cc:	d10c      	bne.n	c0d018e8 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d018ce:	0660      	lsls	r0, r4, #25
c0d018d0:	d448      	bmi.n	c0d01964 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d018d2:	4827      	ldr	r0, [pc, #156]	; (c0d01970 <io_exchange+0x120>)
c0d018d4:	2100      	movs	r1, #0
c0d018d6:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d018d8:	4827      	ldr	r0, [pc, #156]	; (c0d01978 <io_exchange+0x128>)
c0d018da:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d018dc:	4827      	ldr	r0, [pc, #156]	; (c0d0197c <io_exchange+0x12c>)
c0d018de:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d018e0:	4827      	ldr	r0, [pc, #156]	; (c0d01980 <io_exchange+0x130>)
c0d018e2:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d018e4:	4827      	ldr	r0, [pc, #156]	; (c0d01984 <io_exchange+0x134>)
c0d018e6:	7001      	strb	r1, [r0, #0]
c0d018e8:	4c28      	ldr	r4, [pc, #160]	; (c0d0198c <io_exchange+0x13c>)
c0d018ea:	4e24      	ldr	r6, [pc, #144]	; (c0d0197c <io_exchange+0x12c>)
c0d018ec:	e008      	b.n	c0d01900 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d018ee:	f7ff fd0f 	bl	c0d01310 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d018f2:	8830      	ldrh	r0, [r6, #0]
c0d018f4:	2800      	cmp	r0, #0
c0d018f6:	d003      	beq.n	c0d01900 <io_exchange+0xb0>
c0d018f8:	e032      	b.n	c0d01960 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d018fa:	2002      	movs	r0, #2
c0d018fc:	f7ff f8ba 	bl	c0d00a74 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01900:	f000 fc72 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d01904:	2800      	cmp	r0, #0
c0d01906:	d101      	bne.n	c0d0190c <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01908:	f7ff fcae 	bl	c0d01268 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0190c:	2180      	movs	r1, #128	; 0x80
c0d0190e:	2500      	movs	r5, #0
c0d01910:	4620      	mov	r0, r4
c0d01912:	462a      	mov	r2, r5
c0d01914:	f000 fc84 	bl	c0d02220 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01918:	1ec1      	subs	r1, r0, #3
c0d0191a:	78a2      	ldrb	r2, [r4, #2]
c0d0191c:	7863      	ldrb	r3, [r4, #1]
c0d0191e:	021b      	lsls	r3, r3, #8
c0d01920:	4313      	orrs	r3, r2
c0d01922:	4299      	cmp	r1, r3
c0d01924:	d110      	bne.n	c0d01948 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01926:	4917      	ldr	r1, [pc, #92]	; (c0d01984 <io_exchange+0x134>)
c0d01928:	7809      	ldrb	r1, [r1, #0]
c0d0192a:	2900      	cmp	r1, #0
c0d0192c:	d002      	beq.n	c0d01934 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d0192e:	f7ff fd73 	bl	c0d01418 <io_seproxyhal_handle_event>
c0d01932:	e7e5      	b.n	c0d01900 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01934:	7821      	ldrb	r1, [r4, #0]
c0d01936:	2910      	cmp	r1, #16
c0d01938:	d00f      	beq.n	c0d0195a <io_exchange+0x10a>
c0d0193a:	290f      	cmp	r1, #15
c0d0193c:	d1dd      	bne.n	c0d018fa <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d0193e:	2804      	cmp	r0, #4
c0d01940:	d102      	bne.n	c0d01948 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01942:	f7ff fca7 	bl	c0d01294 <io_seproxyhal_handle_usb_event>
c0d01946:	e7db      	b.n	c0d01900 <io_exchange+0xb0>
c0d01948:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d0194a:	4909      	ldr	r1, [pc, #36]	; (c0d01970 <io_exchange+0x120>)
c0d0194c:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d0194e:	490a      	ldr	r1, [pc, #40]	; (c0d01978 <io_exchange+0x128>)
c0d01950:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01952:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01954:	490a      	ldr	r1, [pc, #40]	; (c0d01980 <io_exchange+0x130>)
c0d01956:	8008      	strh	r0, [r1, #0]
c0d01958:	e7d2      	b.n	c0d01900 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d0195a:	2806      	cmp	r0, #6
c0d0195c:	d2c7      	bcs.n	c0d018ee <io_exchange+0x9e>
c0d0195e:	e782      	b.n	c0d01866 <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01960:	8835      	ldrh	r5, [r6, #0]
c0d01962:	e780      	b.n	c0d01866 <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01964:	4805      	ldr	r0, [pc, #20]	; (c0d0197c <io_exchange+0x12c>)
c0d01966:	8800      	ldrh	r0, [r0, #0]
c0d01968:	4907      	ldr	r1, [pc, #28]	; (c0d01988 <io_exchange+0x138>)
c0d0196a:	1845      	adds	r5, r0, r1
c0d0196c:	e77b      	b.n	c0d01866 <io_exchange+0x16>
c0d0196e:	46c0      	nop			; (mov r8, r8)
c0d01970:	20001d18 	.word	0x20001d18
c0d01974:	20001bb8 	.word	0x20001bb8
c0d01978:	20001d1a 	.word	0x20001d1a
c0d0197c:	20001d1c 	.word	0x20001d1c
c0d01980:	20001d1e 	.word	0x20001d1e
c0d01984:	20001d10 	.word	0x20001d10
c0d01988:	0000fffb 	.word	0x0000fffb
c0d0198c:	20001a18 	.word	0x20001a18
c0d01990:	fffffbbb 	.word	0xfffffbbb

c0d01994 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01994:	b081      	sub	sp, #4
c0d01996:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01998:	af03      	add	r7, sp, #12
c0d0199a:	b094      	sub	sp, #80	; 0x50
c0d0199c:	4616      	mov	r6, r2
c0d0199e:	460d      	mov	r5, r1
c0d019a0:	900e      	str	r0, [sp, #56]	; 0x38
c0d019a2:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d019a4:	2d02      	cmp	r5, #2
c0d019a6:	d200      	bcs.n	c0d019aa <snprintf+0x16>
c0d019a8:	e22a      	b.n	c0d01e00 <snprintf+0x46c>
c0d019aa:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d019ac:	2800      	cmp	r0, #0
c0d019ae:	d100      	bne.n	c0d019b2 <snprintf+0x1e>
c0d019b0:	e226      	b.n	c0d01e00 <snprintf+0x46c>
c0d019b2:	2e00      	cmp	r6, #0
c0d019b4:	d100      	bne.n	c0d019b8 <snprintf+0x24>
c0d019b6:	e223      	b.n	c0d01e00 <snprintf+0x46c>
c0d019b8:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d019ba:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d019bc:	9109      	str	r1, [sp, #36]	; 0x24
c0d019be:	462a      	mov	r2, r5
c0d019c0:	f7ff fbae 	bl	c0d01120 <os_memset>
c0d019c4:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d019c6:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d019c8:	7830      	ldrb	r0, [r6, #0]
c0d019ca:	2800      	cmp	r0, #0
c0d019cc:	d100      	bne.n	c0d019d0 <snprintf+0x3c>
c0d019ce:	e217      	b.n	c0d01e00 <snprintf+0x46c>
c0d019d0:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d019d2:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d019d4:	1e6b      	subs	r3, r5, #1
c0d019d6:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d019d8:	460a      	mov	r2, r1
c0d019da:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d019dc:	e003      	b.n	c0d019e6 <snprintf+0x52>
c0d019de:	1970      	adds	r0, r6, r5
c0d019e0:	7840      	ldrb	r0, [r0, #1]
c0d019e2:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d019e4:	1c6d      	adds	r5, r5, #1
c0d019e6:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d019e8:	2800      	cmp	r0, #0
c0d019ea:	d001      	beq.n	c0d019f0 <snprintf+0x5c>
c0d019ec:	2825      	cmp	r0, #37	; 0x25
c0d019ee:	d1f6      	bne.n	c0d019de <snprintf+0x4a>
c0d019f0:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d019f2:	429d      	cmp	r5, r3
c0d019f4:	d300      	bcc.n	c0d019f8 <snprintf+0x64>
c0d019f6:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d019f8:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d019fa:	4631      	mov	r1, r6
c0d019fc:	462a      	mov	r2, r5
c0d019fe:	461c      	mov	r4, r3
c0d01a00:	f7ff fb98 	bl	c0d01134 <os_memmove>
c0d01a04:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01a06:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01a08:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01a0a:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01a0c:	2b00      	cmp	r3, #0
c0d01a0e:	d100      	bne.n	c0d01a12 <snprintf+0x7e>
c0d01a10:	e1f6      	b.n	c0d01e00 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01a12:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01a14:	5d71      	ldrb	r1, [r6, r5]
c0d01a16:	2925      	cmp	r1, #37	; 0x25
c0d01a18:	d000      	beq.n	c0d01a1c <snprintf+0x88>
c0d01a1a:	e0ab      	b.n	c0d01b74 <snprintf+0x1e0>
c0d01a1c:	9304      	str	r3, [sp, #16]
c0d01a1e:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01a20:	1c40      	adds	r0, r0, #1
c0d01a22:	2100      	movs	r1, #0
c0d01a24:	2220      	movs	r2, #32
c0d01a26:	920a      	str	r2, [sp, #40]	; 0x28
c0d01a28:	220a      	movs	r2, #10
c0d01a2a:	9203      	str	r2, [sp, #12]
c0d01a2c:	9102      	str	r1, [sp, #8]
c0d01a2e:	9106      	str	r1, [sp, #24]
c0d01a30:	910d      	str	r1, [sp, #52]	; 0x34
c0d01a32:	460b      	mov	r3, r1
c0d01a34:	2102      	movs	r1, #2
c0d01a36:	910c      	str	r1, [sp, #48]	; 0x30
c0d01a38:	4606      	mov	r6, r0
c0d01a3a:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01a3c:	7831      	ldrb	r1, [r6, #0]
c0d01a3e:	1c76      	adds	r6, r6, #1
c0d01a40:	2300      	movs	r3, #0
c0d01a42:	2962      	cmp	r1, #98	; 0x62
c0d01a44:	dc41      	bgt.n	c0d01aca <snprintf+0x136>
c0d01a46:	4608      	mov	r0, r1
c0d01a48:	3825      	subs	r0, #37	; 0x25
c0d01a4a:	2823      	cmp	r0, #35	; 0x23
c0d01a4c:	d900      	bls.n	c0d01a50 <snprintf+0xbc>
c0d01a4e:	e094      	b.n	c0d01b7a <snprintf+0x1e6>
c0d01a50:	0040      	lsls	r0, r0, #1
c0d01a52:	46c0      	nop			; (mov r8, r8)
c0d01a54:	4478      	add	r0, pc
c0d01a56:	8880      	ldrh	r0, [r0, #4]
c0d01a58:	0040      	lsls	r0, r0, #1
c0d01a5a:	4487      	add	pc, r0
c0d01a5c:	0186012d 	.word	0x0186012d
c0d01a60:	01860186 	.word	0x01860186
c0d01a64:	00510186 	.word	0x00510186
c0d01a68:	01860186 	.word	0x01860186
c0d01a6c:	00580023 	.word	0x00580023
c0d01a70:	00240186 	.word	0x00240186
c0d01a74:	00240024 	.word	0x00240024
c0d01a78:	00240024 	.word	0x00240024
c0d01a7c:	00240024 	.word	0x00240024
c0d01a80:	00240024 	.word	0x00240024
c0d01a84:	01860024 	.word	0x01860024
c0d01a88:	01860186 	.word	0x01860186
c0d01a8c:	01860186 	.word	0x01860186
c0d01a90:	01860186 	.word	0x01860186
c0d01a94:	01860186 	.word	0x01860186
c0d01a98:	01860186 	.word	0x01860186
c0d01a9c:	01860186 	.word	0x01860186
c0d01aa0:	006c0186 	.word	0x006c0186
c0d01aa4:	e7c9      	b.n	c0d01a3a <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01aa6:	2930      	cmp	r1, #48	; 0x30
c0d01aa8:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01aaa:	4603      	mov	r3, r0
c0d01aac:	d100      	bne.n	c0d01ab0 <snprintf+0x11c>
c0d01aae:	460b      	mov	r3, r1
c0d01ab0:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01ab2:	2c00      	cmp	r4, #0
c0d01ab4:	d000      	beq.n	c0d01ab8 <snprintf+0x124>
c0d01ab6:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01ab8:	200a      	movs	r0, #10
c0d01aba:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01abc:	1840      	adds	r0, r0, r1
c0d01abe:	3830      	subs	r0, #48	; 0x30
c0d01ac0:	900d      	str	r0, [sp, #52]	; 0x34
c0d01ac2:	4630      	mov	r0, r6
c0d01ac4:	930a      	str	r3, [sp, #40]	; 0x28
c0d01ac6:	4613      	mov	r3, r2
c0d01ac8:	e7b4      	b.n	c0d01a34 <snprintf+0xa0>
c0d01aca:	296f      	cmp	r1, #111	; 0x6f
c0d01acc:	dd11      	ble.n	c0d01af2 <snprintf+0x15e>
c0d01ace:	3970      	subs	r1, #112	; 0x70
c0d01ad0:	2908      	cmp	r1, #8
c0d01ad2:	d900      	bls.n	c0d01ad6 <snprintf+0x142>
c0d01ad4:	e149      	b.n	c0d01d6a <snprintf+0x3d6>
c0d01ad6:	0049      	lsls	r1, r1, #1
c0d01ad8:	4479      	add	r1, pc
c0d01ada:	8889      	ldrh	r1, [r1, #4]
c0d01adc:	0049      	lsls	r1, r1, #1
c0d01ade:	448f      	add	pc, r1
c0d01ae0:	01440051 	.word	0x01440051
c0d01ae4:	002e0144 	.word	0x002e0144
c0d01ae8:	00590144 	.word	0x00590144
c0d01aec:	01440144 	.word	0x01440144
c0d01af0:	0051      	.short	0x0051
c0d01af2:	2963      	cmp	r1, #99	; 0x63
c0d01af4:	d054      	beq.n	c0d01ba0 <snprintf+0x20c>
c0d01af6:	2964      	cmp	r1, #100	; 0x64
c0d01af8:	d057      	beq.n	c0d01baa <snprintf+0x216>
c0d01afa:	2968      	cmp	r1, #104	; 0x68
c0d01afc:	d01d      	beq.n	c0d01b3a <snprintf+0x1a6>
c0d01afe:	e134      	b.n	c0d01d6a <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01b00:	7830      	ldrb	r0, [r6, #0]
c0d01b02:	2873      	cmp	r0, #115	; 0x73
c0d01b04:	d000      	beq.n	c0d01b08 <snprintf+0x174>
c0d01b06:	e130      	b.n	c0d01d6a <snprintf+0x3d6>
c0d01b08:	4630      	mov	r0, r6
c0d01b0a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01b0c:	e00d      	b.n	c0d01b2a <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01b0e:	7830      	ldrb	r0, [r6, #0]
c0d01b10:	282a      	cmp	r0, #42	; 0x2a
c0d01b12:	d000      	beq.n	c0d01b16 <snprintf+0x182>
c0d01b14:	e129      	b.n	c0d01d6a <snprintf+0x3d6>
c0d01b16:	7871      	ldrb	r1, [r6, #1]
c0d01b18:	1c70      	adds	r0, r6, #1
c0d01b1a:	2301      	movs	r3, #1
c0d01b1c:	2948      	cmp	r1, #72	; 0x48
c0d01b1e:	d004      	beq.n	c0d01b2a <snprintf+0x196>
c0d01b20:	2968      	cmp	r1, #104	; 0x68
c0d01b22:	d002      	beq.n	c0d01b2a <snprintf+0x196>
c0d01b24:	2973      	cmp	r1, #115	; 0x73
c0d01b26:	d000      	beq.n	c0d01b2a <snprintf+0x196>
c0d01b28:	e11f      	b.n	c0d01d6a <snprintf+0x3d6>
c0d01b2a:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01b2c:	1d0a      	adds	r2, r1, #4
c0d01b2e:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01b30:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01b32:	9102      	str	r1, [sp, #8]
c0d01b34:	e77e      	b.n	c0d01a34 <snprintf+0xa0>
c0d01b36:	2001      	movs	r0, #1
c0d01b38:	9006      	str	r0, [sp, #24]
c0d01b3a:	2010      	movs	r0, #16
c0d01b3c:	9003      	str	r0, [sp, #12]
c0d01b3e:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01b40:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01b42:	1d01      	adds	r1, r0, #4
c0d01b44:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01b46:	2103      	movs	r1, #3
c0d01b48:	400a      	ands	r2, r1
c0d01b4a:	1c5b      	adds	r3, r3, #1
c0d01b4c:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01b4e:	2a01      	cmp	r2, #1
c0d01b50:	d100      	bne.n	c0d01b54 <snprintf+0x1c0>
c0d01b52:	e0b8      	b.n	c0d01cc6 <snprintf+0x332>
c0d01b54:	2a02      	cmp	r2, #2
c0d01b56:	d100      	bne.n	c0d01b5a <snprintf+0x1c6>
c0d01b58:	e104      	b.n	c0d01d64 <snprintf+0x3d0>
c0d01b5a:	2a03      	cmp	r2, #3
c0d01b5c:	4630      	mov	r0, r6
c0d01b5e:	d100      	bne.n	c0d01b62 <snprintf+0x1ce>
c0d01b60:	e768      	b.n	c0d01a34 <snprintf+0xa0>
c0d01b62:	9c08      	ldr	r4, [sp, #32]
c0d01b64:	4625      	mov	r5, r4
c0d01b66:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01b68:	1948      	adds	r0, r1, r5
c0d01b6a:	7840      	ldrb	r0, [r0, #1]
c0d01b6c:	1c6d      	adds	r5, r5, #1
c0d01b6e:	2800      	cmp	r0, #0
c0d01b70:	d1fa      	bne.n	c0d01b68 <snprintf+0x1d4>
c0d01b72:	e0ab      	b.n	c0d01ccc <snprintf+0x338>
c0d01b74:	4606      	mov	r6, r0
c0d01b76:	920e      	str	r2, [sp, #56]	; 0x38
c0d01b78:	e109      	b.n	c0d01d8e <snprintf+0x3fa>
c0d01b7a:	2958      	cmp	r1, #88	; 0x58
c0d01b7c:	d000      	beq.n	c0d01b80 <snprintf+0x1ec>
c0d01b7e:	e0f4      	b.n	c0d01d6a <snprintf+0x3d6>
c0d01b80:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01b82:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01b84:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01b86:	1d01      	adds	r1, r0, #4
c0d01b88:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01b8a:	6802      	ldr	r2, [r0, #0]
c0d01b8c:	2000      	movs	r0, #0
c0d01b8e:	9005      	str	r0, [sp, #20]
c0d01b90:	2510      	movs	r5, #16
c0d01b92:	e014      	b.n	c0d01bbe <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01b94:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01b96:	1d01      	adds	r1, r0, #4
c0d01b98:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01b9a:	6802      	ldr	r2, [r0, #0]
c0d01b9c:	2000      	movs	r0, #0
c0d01b9e:	e00c      	b.n	c0d01bba <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01ba0:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01ba2:	1d01      	adds	r1, r0, #4
c0d01ba4:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01ba6:	6800      	ldr	r0, [r0, #0]
c0d01ba8:	e087      	b.n	c0d01cba <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01baa:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01bac:	1d01      	adds	r1, r0, #4
c0d01bae:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01bb0:	6800      	ldr	r0, [r0, #0]
c0d01bb2:	17c1      	asrs	r1, r0, #31
c0d01bb4:	1842      	adds	r2, r0, r1
c0d01bb6:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01bb8:	0fc0      	lsrs	r0, r0, #31
c0d01bba:	9005      	str	r0, [sp, #20]
c0d01bbc:	250a      	movs	r5, #10
c0d01bbe:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01bc0:	4295      	cmp	r5, r2
c0d01bc2:	920e      	str	r2, [sp, #56]	; 0x38
c0d01bc4:	d814      	bhi.n	c0d01bf0 <snprintf+0x25c>
c0d01bc6:	2201      	movs	r2, #1
c0d01bc8:	4628      	mov	r0, r5
c0d01bca:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01bcc:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01bce:	4629      	mov	r1, r5
c0d01bd0:	f001 fb4a 	bl	c0d03268 <__aeabi_uidiv>
c0d01bd4:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01bd6:	4288      	cmp	r0, r1
c0d01bd8:	d109      	bne.n	c0d01bee <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01bda:	4628      	mov	r0, r5
c0d01bdc:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01bde:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01be0:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01be2:	910d      	str	r1, [sp, #52]	; 0x34
c0d01be4:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01be6:	4288      	cmp	r0, r1
c0d01be8:	4622      	mov	r2, r4
c0d01bea:	d9ee      	bls.n	c0d01bca <snprintf+0x236>
c0d01bec:	e000      	b.n	c0d01bf0 <snprintf+0x25c>
c0d01bee:	460c      	mov	r4, r1
c0d01bf0:	950c      	str	r5, [sp, #48]	; 0x30
c0d01bf2:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01bf4:	2000      	movs	r0, #0
c0d01bf6:	4603      	mov	r3, r0
c0d01bf8:	43c1      	mvns	r1, r0
c0d01bfa:	9c05      	ldr	r4, [sp, #20]
c0d01bfc:	2c00      	cmp	r4, #0
c0d01bfe:	d100      	bne.n	c0d01c02 <snprintf+0x26e>
c0d01c00:	4621      	mov	r1, r4
c0d01c02:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01c04:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01c06:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01c08:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01c0a:	b2ca      	uxtb	r2, r1
c0d01c0c:	2a30      	cmp	r2, #48	; 0x30
c0d01c0e:	d106      	bne.n	c0d01c1e <snprintf+0x28a>
c0d01c10:	2c00      	cmp	r4, #0
c0d01c12:	d004      	beq.n	c0d01c1e <snprintf+0x28a>
c0d01c14:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01c16:	232d      	movs	r3, #45	; 0x2d
c0d01c18:	700b      	strb	r3, [r1, #0]
c0d01c1a:	2400      	movs	r4, #0
c0d01c1c:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01c1e:	1e81      	subs	r1, r0, #2
c0d01c20:	290d      	cmp	r1, #13
c0d01c22:	d80d      	bhi.n	c0d01c40 <snprintf+0x2ac>
c0d01c24:	1e41      	subs	r1, r0, #1
c0d01c26:	d00b      	beq.n	c0d01c40 <snprintf+0x2ac>
c0d01c28:	a810      	add	r0, sp, #64	; 0x40
c0d01c2a:	9405      	str	r4, [sp, #20]
c0d01c2c:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01c2e:	4320      	orrs	r0, r4
c0d01c30:	f001 fda4 	bl	c0d0377c <__aeabi_memset>
c0d01c34:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01c36:	1900      	adds	r0, r0, r4
c0d01c38:	9c05      	ldr	r4, [sp, #20]
c0d01c3a:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01c3c:	1840      	adds	r0, r0, r1
c0d01c3e:	1e43      	subs	r3, r0, #1
c0d01c40:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01c42:	2c00      	cmp	r4, #0
c0d01c44:	9601      	str	r6, [sp, #4]
c0d01c46:	d003      	beq.n	c0d01c50 <snprintf+0x2bc>
c0d01c48:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01c4a:	222d      	movs	r2, #45	; 0x2d
c0d01c4c:	54c2      	strb	r2, [r0, r3]
c0d01c4e:	1c5b      	adds	r3, r3, #1
c0d01c50:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01c52:	2900      	cmp	r1, #0
c0d01c54:	d003      	beq.n	c0d01c5e <snprintf+0x2ca>
c0d01c56:	2800      	cmp	r0, #0
c0d01c58:	d003      	beq.n	c0d01c62 <snprintf+0x2ce>
c0d01c5a:	a06c      	add	r0, pc, #432	; (adr r0, c0d01e0c <g_pcHex_cap>)
c0d01c5c:	e002      	b.n	c0d01c64 <snprintf+0x2d0>
c0d01c5e:	461c      	mov	r4, r3
c0d01c60:	e016      	b.n	c0d01c90 <snprintf+0x2fc>
c0d01c62:	a06e      	add	r0, pc, #440	; (adr r0, c0d01e1c <g_pcHex>)
c0d01c64:	900d      	str	r0, [sp, #52]	; 0x34
c0d01c66:	461c      	mov	r4, r3
c0d01c68:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01c6a:	460e      	mov	r6, r1
c0d01c6c:	f001 fafc 	bl	c0d03268 <__aeabi_uidiv>
c0d01c70:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01c72:	4629      	mov	r1, r5
c0d01c74:	f001 fb7e 	bl	c0d03374 <__aeabi_uidivmod>
c0d01c78:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01c7a:	5c40      	ldrb	r0, [r0, r1]
c0d01c7c:	a910      	add	r1, sp, #64	; 0x40
c0d01c7e:	5508      	strb	r0, [r1, r4]
c0d01c80:	4630      	mov	r0, r6
c0d01c82:	4629      	mov	r1, r5
c0d01c84:	f001 faf0 	bl	c0d03268 <__aeabi_uidiv>
c0d01c88:	1c64      	adds	r4, r4, #1
c0d01c8a:	42b5      	cmp	r5, r6
c0d01c8c:	4601      	mov	r1, r0
c0d01c8e:	d9eb      	bls.n	c0d01c68 <snprintf+0x2d4>
c0d01c90:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01c92:	429c      	cmp	r4, r3
c0d01c94:	4625      	mov	r5, r4
c0d01c96:	d300      	bcc.n	c0d01c9a <snprintf+0x306>
c0d01c98:	461d      	mov	r5, r3
c0d01c9a:	a910      	add	r1, sp, #64	; 0x40
c0d01c9c:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01c9e:	4620      	mov	r0, r4
c0d01ca0:	462a      	mov	r2, r5
c0d01ca2:	461e      	mov	r6, r3
c0d01ca4:	f7ff fa46 	bl	c0d01134 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01ca8:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d01caa:	1961      	adds	r1, r4, r5
c0d01cac:	910e      	str	r1, [sp, #56]	; 0x38
c0d01cae:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01cb0:	2800      	cmp	r0, #0
c0d01cb2:	9e01      	ldr	r6, [sp, #4]
c0d01cb4:	d16b      	bne.n	c0d01d8e <snprintf+0x3fa>
c0d01cb6:	e0a3      	b.n	c0d01e00 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01cb8:	2025      	movs	r0, #37	; 0x25
c0d01cba:	9907      	ldr	r1, [sp, #28]
c0d01cbc:	7008      	strb	r0, [r1, #0]
c0d01cbe:	9804      	ldr	r0, [sp, #16]
c0d01cc0:	1e40      	subs	r0, r0, #1
c0d01cc2:	1c49      	adds	r1, r1, #1
c0d01cc4:	e05f      	b.n	c0d01d86 <snprintf+0x3f2>
c0d01cc6:	9d02      	ldr	r5, [sp, #8]
c0d01cc8:	9c08      	ldr	r4, [sp, #32]
c0d01cca:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01ccc:	9803      	ldr	r0, [sp, #12]
c0d01cce:	2810      	cmp	r0, #16
c0d01cd0:	9807      	ldr	r0, [sp, #28]
c0d01cd2:	d161      	bne.n	c0d01d98 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01cd4:	2d00      	cmp	r5, #0
c0d01cd6:	d06a      	beq.n	c0d01dae <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01cd8:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01cda:	1900      	adds	r0, r0, r4
c0d01cdc:	900e      	str	r0, [sp, #56]	; 0x38
c0d01cde:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01ce0:	1aa0      	subs	r0, r4, r2
c0d01ce2:	9b05      	ldr	r3, [sp, #20]
c0d01ce4:	4283      	cmp	r3, r0
c0d01ce6:	d800      	bhi.n	c0d01cea <snprintf+0x356>
c0d01ce8:	4603      	mov	r3, r0
c0d01cea:	930c      	str	r3, [sp, #48]	; 0x30
c0d01cec:	435c      	muls	r4, r3
c0d01cee:	940a      	str	r4, [sp, #40]	; 0x28
c0d01cf0:	1c60      	adds	r0, r4, #1
c0d01cf2:	9007      	str	r0, [sp, #28]
c0d01cf4:	2000      	movs	r0, #0
c0d01cf6:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01cf8:	9100      	str	r1, [sp, #0]
c0d01cfa:	940e      	str	r4, [sp, #56]	; 0x38
c0d01cfc:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01cfe:	18e3      	adds	r3, r4, r3
c0d01d00:	900d      	str	r0, [sp, #52]	; 0x34
c0d01d02:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01d04:	200f      	movs	r0, #15
c0d01d06:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01d08:	0909      	lsrs	r1, r1, #4
c0d01d0a:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01d0c:	18a4      	adds	r4, r4, r2
c0d01d0e:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01d10:	2c02      	cmp	r4, #2
c0d01d12:	d375      	bcc.n	c0d01e00 <snprintf+0x46c>
c0d01d14:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01d16:	2c01      	cmp	r4, #1
c0d01d18:	d003      	beq.n	c0d01d22 <snprintf+0x38e>
c0d01d1a:	2c00      	cmp	r4, #0
c0d01d1c:	d108      	bne.n	c0d01d30 <snprintf+0x39c>
c0d01d1e:	a43f      	add	r4, pc, #252	; (adr r4, c0d01e1c <g_pcHex>)
c0d01d20:	e000      	b.n	c0d01d24 <snprintf+0x390>
c0d01d22:	a43a      	add	r4, pc, #232	; (adr r4, c0d01e0c <g_pcHex_cap>)
c0d01d24:	b2c9      	uxtb	r1, r1
c0d01d26:	5c61      	ldrb	r1, [r4, r1]
c0d01d28:	7019      	strb	r1, [r3, #0]
c0d01d2a:	b2c0      	uxtb	r0, r0
c0d01d2c:	5c20      	ldrb	r0, [r4, r0]
c0d01d2e:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01d30:	9807      	ldr	r0, [sp, #28]
c0d01d32:	4290      	cmp	r0, r2
c0d01d34:	d064      	beq.n	c0d01e00 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01d36:	1e92      	subs	r2, r2, #2
c0d01d38:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01d3a:	1ca4      	adds	r4, r4, #2
c0d01d3c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01d3e:	1c40      	adds	r0, r0, #1
c0d01d40:	42a8      	cmp	r0, r5
c0d01d42:	9900      	ldr	r1, [sp, #0]
c0d01d44:	d3d9      	bcc.n	c0d01cfa <snprintf+0x366>
c0d01d46:	900d      	str	r0, [sp, #52]	; 0x34
c0d01d48:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01d4a:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01d4c:	1a08      	subs	r0, r1, r0
c0d01d4e:	9b05      	ldr	r3, [sp, #20]
c0d01d50:	4283      	cmp	r3, r0
c0d01d52:	d800      	bhi.n	c0d01d56 <snprintf+0x3c2>
c0d01d54:	4603      	mov	r3, r0
c0d01d56:	4608      	mov	r0, r1
c0d01d58:	4358      	muls	r0, r3
c0d01d5a:	1820      	adds	r0, r4, r0
c0d01d5c:	900e      	str	r0, [sp, #56]	; 0x38
c0d01d5e:	1898      	adds	r0, r3, r2
c0d01d60:	1c43      	adds	r3, r0, #1
c0d01d62:	e038      	b.n	c0d01dd6 <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01d64:	7808      	ldrb	r0, [r1, #0]
c0d01d66:	2800      	cmp	r0, #0
c0d01d68:	d023      	beq.n	c0d01db2 <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d01d6a:	2005      	movs	r0, #5
c0d01d6c:	9d04      	ldr	r5, [sp, #16]
c0d01d6e:	2d05      	cmp	r5, #5
c0d01d70:	462c      	mov	r4, r5
c0d01d72:	d300      	bcc.n	c0d01d76 <snprintf+0x3e2>
c0d01d74:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01d76:	9807      	ldr	r0, [sp, #28]
c0d01d78:	a12c      	add	r1, pc, #176	; (adr r1, c0d01e2c <g_pcHex+0x10>)
c0d01d7a:	4622      	mov	r2, r4
c0d01d7c:	f7ff f9da 	bl	c0d01134 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01d80:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01d82:	9907      	ldr	r1, [sp, #28]
c0d01d84:	1909      	adds	r1, r1, r4
c0d01d86:	910e      	str	r1, [sp, #56]	; 0x38
c0d01d88:	4603      	mov	r3, r0
c0d01d8a:	2800      	cmp	r0, #0
c0d01d8c:	d038      	beq.n	c0d01e00 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01d8e:	7830      	ldrb	r0, [r6, #0]
c0d01d90:	2800      	cmp	r0, #0
c0d01d92:	9908      	ldr	r1, [sp, #32]
c0d01d94:	d034      	beq.n	c0d01e00 <snprintf+0x46c>
c0d01d96:	e61f      	b.n	c0d019d8 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01d98:	429d      	cmp	r5, r3
c0d01d9a:	d300      	bcc.n	c0d01d9e <snprintf+0x40a>
c0d01d9c:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01d9e:	462a      	mov	r2, r5
c0d01da0:	461c      	mov	r4, r3
c0d01da2:	f7ff f9c7 	bl	c0d01134 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01da6:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01da8:	9907      	ldr	r1, [sp, #28]
c0d01daa:	1949      	adds	r1, r1, r5
c0d01dac:	e00f      	b.n	c0d01dce <snprintf+0x43a>
c0d01dae:	900e      	str	r0, [sp, #56]	; 0x38
c0d01db0:	e7ed      	b.n	c0d01d8e <snprintf+0x3fa>
c0d01db2:	9b04      	ldr	r3, [sp, #16]
c0d01db4:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01db6:	429c      	cmp	r4, r3
c0d01db8:	d300      	bcc.n	c0d01dbc <snprintf+0x428>
c0d01dba:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d01dbc:	2120      	movs	r1, #32
c0d01dbe:	9807      	ldr	r0, [sp, #28]
c0d01dc0:	4622      	mov	r2, r4
c0d01dc2:	f7ff f9ad 	bl	c0d01120 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d01dc6:	9804      	ldr	r0, [sp, #16]
c0d01dc8:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d01dca:	9907      	ldr	r1, [sp, #28]
c0d01dcc:	1909      	adds	r1, r1, r4
c0d01dce:	910e      	str	r1, [sp, #56]	; 0x38
c0d01dd0:	4603      	mov	r3, r0
c0d01dd2:	2800      	cmp	r0, #0
c0d01dd4:	d014      	beq.n	c0d01e00 <snprintf+0x46c>
c0d01dd6:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01dd8:	42a8      	cmp	r0, r5
c0d01dda:	d9d8      	bls.n	c0d01d8e <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d01ddc:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d01dde:	429a      	cmp	r2, r3
c0d01de0:	d300      	bcc.n	c0d01de4 <snprintf+0x450>
c0d01de2:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d01de4:	2120      	movs	r1, #32
c0d01de6:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01de8:	4628      	mov	r0, r5
c0d01dea:	920d      	str	r2, [sp, #52]	; 0x34
c0d01dec:	461c      	mov	r4, r3
c0d01dee:	f7ff f997 	bl	c0d01120 <os_memset>
c0d01df2:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01df4:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01df6:	182d      	adds	r5, r5, r0
c0d01df8:	950e      	str	r5, [sp, #56]	; 0x38
c0d01dfa:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d01dfc:	2c00      	cmp	r4, #0
c0d01dfe:	d1c6      	bne.n	c0d01d8e <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01e00:	2000      	movs	r0, #0
c0d01e02:	b014      	add	sp, #80	; 0x50
c0d01e04:	bcf0      	pop	{r4, r5, r6, r7}
c0d01e06:	bc02      	pop	{r1}
c0d01e08:	b001      	add	sp, #4
c0d01e0a:	4708      	bx	r1

c0d01e0c <g_pcHex_cap>:
c0d01e0c:	33323130 	.word	0x33323130
c0d01e10:	37363534 	.word	0x37363534
c0d01e14:	42413938 	.word	0x42413938
c0d01e18:	46454443 	.word	0x46454443

c0d01e1c <g_pcHex>:
c0d01e1c:	33323130 	.word	0x33323130
c0d01e20:	37363534 	.word	0x37363534
c0d01e24:	62613938 	.word	0x62613938
c0d01e28:	66656463 	.word	0x66656463
c0d01e2c:	4f525245 	.word	0x4f525245
c0d01e30:	00000052 	.word	0x00000052

c0d01e34 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01e34:	b580      	push	{r7, lr}
c0d01e36:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01e38:	4904      	ldr	r1, [pc, #16]	; (c0d01e4c <pic+0x18>)
c0d01e3a:	4288      	cmp	r0, r1
c0d01e3c:	d304      	bcc.n	c0d01e48 <pic+0x14>
c0d01e3e:	4904      	ldr	r1, [pc, #16]	; (c0d01e50 <pic+0x1c>)
c0d01e40:	4288      	cmp	r0, r1
c0d01e42:	d201      	bcs.n	c0d01e48 <pic+0x14>
		link_address = pic_internal(link_address);
c0d01e44:	f000 f806 	bl	c0d01e54 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01e48:	bd80      	pop	{r7, pc}
c0d01e4a:	46c0      	nop			; (mov r8, r8)
c0d01e4c:	c0d00000 	.word	0xc0d00000
c0d01e50:	c0d03d80 	.word	0xc0d03d80

c0d01e54 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01e54:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01e56:	4902      	ldr	r1, [pc, #8]	; (c0d01e60 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01e58:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01e5a:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01e5c:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01e5e:	4770      	bx	lr
c0d01e60:	c0d01e55 	.word	0xc0d01e55

c0d01e64 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01e64:	b580      	push	{r7, lr}
c0d01e66:	af00      	add	r7, sp, #0
c0d01e68:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01e6a:	490a      	ldr	r1, [pc, #40]	; (c0d01e94 <check_api_level+0x30>)
c0d01e6c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e6e:	490a      	ldr	r1, [pc, #40]	; (c0d01e98 <check_api_level+0x34>)
c0d01e70:	680a      	ldr	r2, [r1, #0]
c0d01e72:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01e74:	9003      	str	r0, [sp, #12]
c0d01e76:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e78:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e7a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e7c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01e7e:	4807      	ldr	r0, [pc, #28]	; (c0d01e9c <check_api_level+0x38>)
c0d01e80:	9a01      	ldr	r2, [sp, #4]
c0d01e82:	4282      	cmp	r2, r0
c0d01e84:	d101      	bne.n	c0d01e8a <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01e86:	b004      	add	sp, #16
c0d01e88:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e8a:	6808      	ldr	r0, [r1, #0]
c0d01e8c:	2104      	movs	r1, #4
c0d01e8e:	f001 fd0d 	bl	c0d038ac <longjmp>
c0d01e92:	46c0      	nop			; (mov r8, r8)
c0d01e94:	60000137 	.word	0x60000137
c0d01e98:	20001bb8 	.word	0x20001bb8
c0d01e9c:	900001c6 	.word	0x900001c6

c0d01ea0 <reset>:
  }
}

void reset ( void ) 
{
c0d01ea0:	b580      	push	{r7, lr}
c0d01ea2:	af00      	add	r7, sp, #0
c0d01ea4:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d01ea6:	4809      	ldr	r0, [pc, #36]	; (c0d01ecc <reset+0x2c>)
c0d01ea8:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01eaa:	4809      	ldr	r0, [pc, #36]	; (c0d01ed0 <reset+0x30>)
c0d01eac:	6801      	ldr	r1, [r0, #0]
c0d01eae:	9101      	str	r1, [sp, #4]
c0d01eb0:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01eb2:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01eb4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01eb6:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01eb8:	4906      	ldr	r1, [pc, #24]	; (c0d01ed4 <reset+0x34>)
c0d01eba:	9a00      	ldr	r2, [sp, #0]
c0d01ebc:	428a      	cmp	r2, r1
c0d01ebe:	d101      	bne.n	c0d01ec4 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01ec0:	b002      	add	sp, #8
c0d01ec2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ec4:	6800      	ldr	r0, [r0, #0]
c0d01ec6:	2104      	movs	r1, #4
c0d01ec8:	f001 fcf0 	bl	c0d038ac <longjmp>
c0d01ecc:	60000200 	.word	0x60000200
c0d01ed0:	20001bb8 	.word	0x20001bb8
c0d01ed4:	900002f1 	.word	0x900002f1

c0d01ed8 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01ed8:	b5d0      	push	{r4, r6, r7, lr}
c0d01eda:	af02      	add	r7, sp, #8
c0d01edc:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d01ede:	4b0a      	ldr	r3, [pc, #40]	; (c0d01f08 <nvm_write+0x30>)
c0d01ee0:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ee2:	4b0a      	ldr	r3, [pc, #40]	; (c0d01f0c <nvm_write+0x34>)
c0d01ee4:	681c      	ldr	r4, [r3, #0]
c0d01ee6:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d01ee8:	ac03      	add	r4, sp, #12
c0d01eea:	c407      	stmia	r4!, {r0, r1, r2}
c0d01eec:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01eee:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ef0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ef2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01ef4:	4806      	ldr	r0, [pc, #24]	; (c0d01f10 <nvm_write+0x38>)
c0d01ef6:	9901      	ldr	r1, [sp, #4]
c0d01ef8:	4281      	cmp	r1, r0
c0d01efa:	d101      	bne.n	c0d01f00 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01efc:	b006      	add	sp, #24
c0d01efe:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f00:	6818      	ldr	r0, [r3, #0]
c0d01f02:	2104      	movs	r1, #4
c0d01f04:	f001 fcd2 	bl	c0d038ac <longjmp>
c0d01f08:	6000037f 	.word	0x6000037f
c0d01f0c:	20001bb8 	.word	0x20001bb8
c0d01f10:	900003bc 	.word	0x900003bc

c0d01f14 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01f14:	b580      	push	{r7, lr}
c0d01f16:	af00      	add	r7, sp, #0
c0d01f18:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d01f1a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01f44 <cx_rng+0x30>)
c0d01f1c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f1e:	4a0a      	ldr	r2, [pc, #40]	; (c0d01f48 <cx_rng+0x34>)
c0d01f20:	6813      	ldr	r3, [r2, #0]
c0d01f22:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01f24:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d01f26:	9103      	str	r1, [sp, #12]
c0d01f28:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f2a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01f2c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f2e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d01f30:	4906      	ldr	r1, [pc, #24]	; (c0d01f4c <cx_rng+0x38>)
c0d01f32:	9b00      	ldr	r3, [sp, #0]
c0d01f34:	428b      	cmp	r3, r1
c0d01f36:	d101      	bne.n	c0d01f3c <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d01f38:	b004      	add	sp, #16
c0d01f3a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f3c:	6810      	ldr	r0, [r2, #0]
c0d01f3e:	2104      	movs	r1, #4
c0d01f40:	f001 fcb4 	bl	c0d038ac <longjmp>
c0d01f44:	6000052c 	.word	0x6000052c
c0d01f48:	20001bb8 	.word	0x20001bb8
c0d01f4c:	90000567 	.word	0x90000567

c0d01f50 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d01f50:	b580      	push	{r7, lr}
c0d01f52:	af00      	add	r7, sp, #0
c0d01f54:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d01f56:	490a      	ldr	r1, [pc, #40]	; (c0d01f80 <cx_sha256_init+0x30>)
c0d01f58:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f5a:	490a      	ldr	r1, [pc, #40]	; (c0d01f84 <cx_sha256_init+0x34>)
c0d01f5c:	680a      	ldr	r2, [r1, #0]
c0d01f5e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01f60:	9003      	str	r0, [sp, #12]
c0d01f62:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f64:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01f66:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f68:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01f6a:	4a07      	ldr	r2, [pc, #28]	; (c0d01f88 <cx_sha256_init+0x38>)
c0d01f6c:	9b01      	ldr	r3, [sp, #4]
c0d01f6e:	4293      	cmp	r3, r2
c0d01f70:	d101      	bne.n	c0d01f76 <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01f72:	b004      	add	sp, #16
c0d01f74:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f76:	6808      	ldr	r0, [r1, #0]
c0d01f78:	2104      	movs	r1, #4
c0d01f7a:	f001 fc97 	bl	c0d038ac <longjmp>
c0d01f7e:	46c0      	nop			; (mov r8, r8)
c0d01f80:	600008db 	.word	0x600008db
c0d01f84:	20001bb8 	.word	0x20001bb8
c0d01f88:	90000864 	.word	0x90000864

c0d01f8c <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d01f8c:	b580      	push	{r7, lr}
c0d01f8e:	af00      	add	r7, sp, #0
c0d01f90:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d01f92:	4a0a      	ldr	r2, [pc, #40]	; (c0d01fbc <cx_keccak_init+0x30>)
c0d01f94:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f96:	4a0a      	ldr	r2, [pc, #40]	; (c0d01fc0 <cx_keccak_init+0x34>)
c0d01f98:	6813      	ldr	r3, [r2, #0]
c0d01f9a:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d01f9c:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d01f9e:	9103      	str	r1, [sp, #12]
c0d01fa0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01fa2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01fa4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01fa6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d01fa8:	4906      	ldr	r1, [pc, #24]	; (c0d01fc4 <cx_keccak_init+0x38>)
c0d01faa:	9b00      	ldr	r3, [sp, #0]
c0d01fac:	428b      	cmp	r3, r1
c0d01fae:	d101      	bne.n	c0d01fb4 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01fb0:	b004      	add	sp, #16
c0d01fb2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01fb4:	6810      	ldr	r0, [r2, #0]
c0d01fb6:	2104      	movs	r1, #4
c0d01fb8:	f001 fc78 	bl	c0d038ac <longjmp>
c0d01fbc:	60000c3c 	.word	0x60000c3c
c0d01fc0:	20001bb8 	.word	0x20001bb8
c0d01fc4:	90000c39 	.word	0x90000c39

c0d01fc8 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01fc8:	b5b0      	push	{r4, r5, r7, lr}
c0d01fca:	af02      	add	r7, sp, #8
c0d01fcc:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d01fce:	4c0b      	ldr	r4, [pc, #44]	; (c0d01ffc <cx_hash+0x34>)
c0d01fd0:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01fd2:	4c0b      	ldr	r4, [pc, #44]	; (c0d02000 <cx_hash+0x38>)
c0d01fd4:	6825      	ldr	r5, [r4, #0]
c0d01fd6:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01fd8:	ad03      	add	r5, sp, #12
c0d01fda:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01fdc:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d01fde:	9007      	str	r0, [sp, #28]
c0d01fe0:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01fe2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01fe4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01fe6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01fe8:	4906      	ldr	r1, [pc, #24]	; (c0d02004 <cx_hash+0x3c>)
c0d01fea:	9a01      	ldr	r2, [sp, #4]
c0d01fec:	428a      	cmp	r2, r1
c0d01fee:	d101      	bne.n	c0d01ff4 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01ff0:	b008      	add	sp, #32
c0d01ff2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ff4:	6820      	ldr	r0, [r4, #0]
c0d01ff6:	2104      	movs	r1, #4
c0d01ff8:	f001 fc58 	bl	c0d038ac <longjmp>
c0d01ffc:	60000ea6 	.word	0x60000ea6
c0d02000:	20001bb8 	.word	0x20001bb8
c0d02004:	90000e46 	.word	0x90000e46

c0d02008 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d02008:	b5b0      	push	{r4, r5, r7, lr}
c0d0200a:	af02      	add	r7, sp, #8
c0d0200c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d0200e:	4c0a      	ldr	r4, [pc, #40]	; (c0d02038 <cx_ecfp_init_public_key+0x30>)
c0d02010:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02012:	4c0a      	ldr	r4, [pc, #40]	; (c0d0203c <cx_ecfp_init_public_key+0x34>)
c0d02014:	6825      	ldr	r5, [r4, #0]
c0d02016:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02018:	ad02      	add	r5, sp, #8
c0d0201a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d0201c:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0201e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02020:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02022:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d02024:	4906      	ldr	r1, [pc, #24]	; (c0d02040 <cx_ecfp_init_public_key+0x38>)
c0d02026:	9a00      	ldr	r2, [sp, #0]
c0d02028:	428a      	cmp	r2, r1
c0d0202a:	d101      	bne.n	c0d02030 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0202c:	b006      	add	sp, #24
c0d0202e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02030:	6820      	ldr	r0, [r4, #0]
c0d02032:	2104      	movs	r1, #4
c0d02034:	f001 fc3a 	bl	c0d038ac <longjmp>
c0d02038:	60002835 	.word	0x60002835
c0d0203c:	20001bb8 	.word	0x20001bb8
c0d02040:	900028f0 	.word	0x900028f0

c0d02044 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d02044:	b5b0      	push	{r4, r5, r7, lr}
c0d02046:	af02      	add	r7, sp, #8
c0d02048:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d0204a:	4c0a      	ldr	r4, [pc, #40]	; (c0d02074 <cx_ecfp_init_private_key+0x30>)
c0d0204c:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0204e:	4c0a      	ldr	r4, [pc, #40]	; (c0d02078 <cx_ecfp_init_private_key+0x34>)
c0d02050:	6825      	ldr	r5, [r4, #0]
c0d02052:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02054:	ad02      	add	r5, sp, #8
c0d02056:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02058:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0205a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0205c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0205e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d02060:	4906      	ldr	r1, [pc, #24]	; (c0d0207c <cx_ecfp_init_private_key+0x38>)
c0d02062:	9a00      	ldr	r2, [sp, #0]
c0d02064:	428a      	cmp	r2, r1
c0d02066:	d101      	bne.n	c0d0206c <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02068:	b006      	add	sp, #24
c0d0206a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0206c:	6820      	ldr	r0, [r4, #0]
c0d0206e:	2104      	movs	r1, #4
c0d02070:	f001 fc1c 	bl	c0d038ac <longjmp>
c0d02074:	600029ed 	.word	0x600029ed
c0d02078:	20001bb8 	.word	0x20001bb8
c0d0207c:	900029ae 	.word	0x900029ae

c0d02080 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d02080:	b5b0      	push	{r4, r5, r7, lr}
c0d02082:	af02      	add	r7, sp, #8
c0d02084:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d02086:	4c0a      	ldr	r4, [pc, #40]	; (c0d020b0 <cx_ecfp_generate_pair+0x30>)
c0d02088:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0208a:	4c0a      	ldr	r4, [pc, #40]	; (c0d020b4 <cx_ecfp_generate_pair+0x34>)
c0d0208c:	6825      	ldr	r5, [r4, #0]
c0d0208e:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02090:	ad02      	add	r5, sp, #8
c0d02092:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02094:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02096:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02098:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0209a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d0209c:	4906      	ldr	r1, [pc, #24]	; (c0d020b8 <cx_ecfp_generate_pair+0x38>)
c0d0209e:	9a00      	ldr	r2, [sp, #0]
c0d020a0:	428a      	cmp	r2, r1
c0d020a2:	d101      	bne.n	c0d020a8 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d020a4:	b006      	add	sp, #24
c0d020a6:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020a8:	6820      	ldr	r0, [r4, #0]
c0d020aa:	2104      	movs	r1, #4
c0d020ac:	f001 fbfe 	bl	c0d038ac <longjmp>
c0d020b0:	60002a2e 	.word	0x60002a2e
c0d020b4:	20001bb8 	.word	0x20001bb8
c0d020b8:	90002a74 	.word	0x90002a74

c0d020bc <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d020bc:	b5b0      	push	{r4, r5, r7, lr}
c0d020be:	af02      	add	r7, sp, #8
c0d020c0:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d020c2:	4c0b      	ldr	r4, [pc, #44]	; (c0d020f0 <os_perso_derive_node_bip32+0x34>)
c0d020c4:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d020c6:	4c0b      	ldr	r4, [pc, #44]	; (c0d020f4 <os_perso_derive_node_bip32+0x38>)
c0d020c8:	6825      	ldr	r5, [r4, #0]
c0d020ca:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d020cc:	ad03      	add	r5, sp, #12
c0d020ce:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d020d0:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d020d2:	9007      	str	r0, [sp, #28]
c0d020d4:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d020d6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d020d8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d020da:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d020dc:	4806      	ldr	r0, [pc, #24]	; (c0d020f8 <os_perso_derive_node_bip32+0x3c>)
c0d020de:	9901      	ldr	r1, [sp, #4]
c0d020e0:	4281      	cmp	r1, r0
c0d020e2:	d101      	bne.n	c0d020e8 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d020e4:	b008      	add	sp, #32
c0d020e6:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020e8:	6820      	ldr	r0, [r4, #0]
c0d020ea:	2104      	movs	r1, #4
c0d020ec:	f001 fbde 	bl	c0d038ac <longjmp>
c0d020f0:	6000512b 	.word	0x6000512b
c0d020f4:	20001bb8 	.word	0x20001bb8
c0d020f8:	9000517f 	.word	0x9000517f

c0d020fc <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d020fc:	b580      	push	{r7, lr}
c0d020fe:	af00      	add	r7, sp, #0
c0d02100:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d02102:	490a      	ldr	r1, [pc, #40]	; (c0d0212c <os_sched_exit+0x30>)
c0d02104:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02106:	490a      	ldr	r1, [pc, #40]	; (c0d02130 <os_sched_exit+0x34>)
c0d02108:	680a      	ldr	r2, [r1, #0]
c0d0210a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d0210c:	9003      	str	r0, [sp, #12]
c0d0210e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02110:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02112:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02114:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d02116:	4807      	ldr	r0, [pc, #28]	; (c0d02134 <os_sched_exit+0x38>)
c0d02118:	9a01      	ldr	r2, [sp, #4]
c0d0211a:	4282      	cmp	r2, r0
c0d0211c:	d101      	bne.n	c0d02122 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0211e:	b004      	add	sp, #16
c0d02120:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02122:	6808      	ldr	r0, [r1, #0]
c0d02124:	2104      	movs	r1, #4
c0d02126:	f001 fbc1 	bl	c0d038ac <longjmp>
c0d0212a:	46c0      	nop			; (mov r8, r8)
c0d0212c:	60005fe1 	.word	0x60005fe1
c0d02130:	20001bb8 	.word	0x20001bb8
c0d02134:	90005f6f 	.word	0x90005f6f

c0d02138 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d02138:	b580      	push	{r7, lr}
c0d0213a:	af00      	add	r7, sp, #0
c0d0213c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d0213e:	490a      	ldr	r1, [pc, #40]	; (c0d02168 <os_ux+0x30>)
c0d02140:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02142:	490a      	ldr	r1, [pc, #40]	; (c0d0216c <os_ux+0x34>)
c0d02144:	680a      	ldr	r2, [r1, #0]
c0d02146:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d02148:	9003      	str	r0, [sp, #12]
c0d0214a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0214c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0214e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02150:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d02152:	4a07      	ldr	r2, [pc, #28]	; (c0d02170 <os_ux+0x38>)
c0d02154:	9b01      	ldr	r3, [sp, #4]
c0d02156:	4293      	cmp	r3, r2
c0d02158:	d101      	bne.n	c0d0215e <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0215a:	b004      	add	sp, #16
c0d0215c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0215e:	6808      	ldr	r0, [r1, #0]
c0d02160:	2104      	movs	r1, #4
c0d02162:	f001 fba3 	bl	c0d038ac <longjmp>
c0d02166:	46c0      	nop			; (mov r8, r8)
c0d02168:	60006158 	.word	0x60006158
c0d0216c:	20001bb8 	.word	0x20001bb8
c0d02170:	9000611f 	.word	0x9000611f

c0d02174 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d02174:	b580      	push	{r7, lr}
c0d02176:	af00      	add	r7, sp, #0
c0d02178:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d0217a:	4809      	ldr	r0, [pc, #36]	; (c0d021a0 <os_seph_features+0x2c>)
c0d0217c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0217e:	4909      	ldr	r1, [pc, #36]	; (c0d021a4 <os_seph_features+0x30>)
c0d02180:	6808      	ldr	r0, [r1, #0]
c0d02182:	9001      	str	r0, [sp, #4]
c0d02184:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02186:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02188:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0218a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d0218c:	4a06      	ldr	r2, [pc, #24]	; (c0d021a8 <os_seph_features+0x34>)
c0d0218e:	9b00      	ldr	r3, [sp, #0]
c0d02190:	4293      	cmp	r3, r2
c0d02192:	d101      	bne.n	c0d02198 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02194:	b002      	add	sp, #8
c0d02196:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02198:	6808      	ldr	r0, [r1, #0]
c0d0219a:	2104      	movs	r1, #4
c0d0219c:	f001 fb86 	bl	c0d038ac <longjmp>
c0d021a0:	600064d6 	.word	0x600064d6
c0d021a4:	20001bb8 	.word	0x20001bb8
c0d021a8:	90006444 	.word	0x90006444

c0d021ac <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d021ac:	b580      	push	{r7, lr}
c0d021ae:	af00      	add	r7, sp, #0
c0d021b0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d021b2:	4a0a      	ldr	r2, [pc, #40]	; (c0d021dc <io_seproxyhal_spi_send+0x30>)
c0d021b4:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021b6:	4a0a      	ldr	r2, [pc, #40]	; (c0d021e0 <io_seproxyhal_spi_send+0x34>)
c0d021b8:	6813      	ldr	r3, [r2, #0]
c0d021ba:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d021bc:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d021be:	9103      	str	r1, [sp, #12]
c0d021c0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021c2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021c4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021c6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d021c8:	4806      	ldr	r0, [pc, #24]	; (c0d021e4 <io_seproxyhal_spi_send+0x38>)
c0d021ca:	9900      	ldr	r1, [sp, #0]
c0d021cc:	4281      	cmp	r1, r0
c0d021ce:	d101      	bne.n	c0d021d4 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d021d0:	b004      	add	sp, #16
c0d021d2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021d4:	6810      	ldr	r0, [r2, #0]
c0d021d6:	2104      	movs	r1, #4
c0d021d8:	f001 fb68 	bl	c0d038ac <longjmp>
c0d021dc:	60006a1c 	.word	0x60006a1c
c0d021e0:	20001bb8 	.word	0x20001bb8
c0d021e4:	90006af3 	.word	0x90006af3

c0d021e8 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d021e8:	b580      	push	{r7, lr}
c0d021ea:	af00      	add	r7, sp, #0
c0d021ec:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d021ee:	4809      	ldr	r0, [pc, #36]	; (c0d02214 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d021f0:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021f2:	4909      	ldr	r1, [pc, #36]	; (c0d02218 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d021f4:	6808      	ldr	r0, [r1, #0]
c0d021f6:	9001      	str	r0, [sp, #4]
c0d021f8:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021fa:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021fc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021fe:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d02200:	4a06      	ldr	r2, [pc, #24]	; (c0d0221c <io_seproxyhal_spi_is_status_sent+0x34>)
c0d02202:	9b00      	ldr	r3, [sp, #0]
c0d02204:	4293      	cmp	r3, r2
c0d02206:	d101      	bne.n	c0d0220c <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02208:	b002      	add	sp, #8
c0d0220a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0220c:	6808      	ldr	r0, [r1, #0]
c0d0220e:	2104      	movs	r1, #4
c0d02210:	f001 fb4c 	bl	c0d038ac <longjmp>
c0d02214:	60006bcf 	.word	0x60006bcf
c0d02218:	20001bb8 	.word	0x20001bb8
c0d0221c:	90006b7f 	.word	0x90006b7f

c0d02220 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d02220:	b5d0      	push	{r4, r6, r7, lr}
c0d02222:	af02      	add	r7, sp, #8
c0d02224:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d02226:	4b0b      	ldr	r3, [pc, #44]	; (c0d02254 <io_seproxyhal_spi_recv+0x34>)
c0d02228:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0222a:	4b0b      	ldr	r3, [pc, #44]	; (c0d02258 <io_seproxyhal_spi_recv+0x38>)
c0d0222c:	681c      	ldr	r4, [r3, #0]
c0d0222e:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d02230:	ac03      	add	r4, sp, #12
c0d02232:	c407      	stmia	r4!, {r0, r1, r2}
c0d02234:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02236:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02238:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0223a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d0223c:	4907      	ldr	r1, [pc, #28]	; (c0d0225c <io_seproxyhal_spi_recv+0x3c>)
c0d0223e:	9a01      	ldr	r2, [sp, #4]
c0d02240:	428a      	cmp	r2, r1
c0d02242:	d102      	bne.n	c0d0224a <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d02244:	b280      	uxth	r0, r0
c0d02246:	b006      	add	sp, #24
c0d02248:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0224a:	6818      	ldr	r0, [r3, #0]
c0d0224c:	2104      	movs	r1, #4
c0d0224e:	f001 fb2d 	bl	c0d038ac <longjmp>
c0d02252:	46c0      	nop			; (mov r8, r8)
c0d02254:	60006cd1 	.word	0x60006cd1
c0d02258:	20001bb8 	.word	0x20001bb8
c0d0225c:	90006c2b 	.word	0x90006c2b

c0d02260 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02260:	b5b0      	push	{r4, r5, r7, lr}
c0d02262:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d02264:	492c      	ldr	r1, [pc, #176]	; (c0d02318 <bagl_ui_nanos_screen1_button+0xb8>)
c0d02266:	4288      	cmp	r0, r1
c0d02268:	d006      	beq.n	c0d02278 <bagl_ui_nanos_screen1_button+0x18>
c0d0226a:	492c      	ldr	r1, [pc, #176]	; (c0d0231c <bagl_ui_nanos_screen1_button+0xbc>)
c0d0226c:	4288      	cmp	r0, r1
c0d0226e:	d151      	bne.n	c0d02314 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d02270:	2000      	movs	r0, #0
c0d02272:	f7ff ff43 	bl	c0d020fc <os_sched_exit>
c0d02276:	e04d      	b.n	c0d02314 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d02278:	f7fe fbc0 	bl	c0d009fc <nvram_is_init>
c0d0227c:	2801      	cmp	r0, #1
c0d0227e:	d102      	bne.n	c0d02286 <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d02280:	a029      	add	r0, pc, #164	; (adr r0, c0d02328 <bagl_ui_nanos_screen1_button+0xc8>)
c0d02282:	210d      	movs	r1, #13
c0d02284:	e001      	b.n	c0d0228a <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d02286:	a026      	add	r0, pc, #152	; (adr r0, c0d02320 <bagl_ui_nanos_screen1_button+0xc0>)
c0d02288:	2105      	movs	r1, #5
c0d0228a:	2203      	movs	r2, #3
c0d0228c:	f7fd ff2c 	bl	c0d000e8 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02290:	4c29      	ldr	r4, [pc, #164]	; (c0d02338 <bagl_ui_nanos_screen1_button+0xd8>)
c0d02292:	482b      	ldr	r0, [pc, #172]	; (c0d02340 <bagl_ui_nanos_screen1_button+0xe0>)
c0d02294:	4478      	add	r0, pc
c0d02296:	6020      	str	r0, [r4, #0]
c0d02298:	2004      	movs	r0, #4
c0d0229a:	6060      	str	r0, [r4, #4]
c0d0229c:	4829      	ldr	r0, [pc, #164]	; (c0d02344 <bagl_ui_nanos_screen1_button+0xe4>)
c0d0229e:	4478      	add	r0, pc
c0d022a0:	6120      	str	r0, [r4, #16]
c0d022a2:	2500      	movs	r5, #0
c0d022a4:	60e5      	str	r5, [r4, #12]
c0d022a6:	2003      	movs	r0, #3
c0d022a8:	7620      	strb	r0, [r4, #24]
c0d022aa:	61e5      	str	r5, [r4, #28]
c0d022ac:	4620      	mov	r0, r4
c0d022ae:	3018      	adds	r0, #24
c0d022b0:	f7ff ff42 	bl	c0d02138 <os_ux>
c0d022b4:	61e0      	str	r0, [r4, #28]
c0d022b6:	f7ff f903 	bl	c0d014c0 <io_seproxyhal_init_ux>
c0d022ba:	60a5      	str	r5, [r4, #8]
c0d022bc:	6820      	ldr	r0, [r4, #0]
c0d022be:	2800      	cmp	r0, #0
c0d022c0:	d028      	beq.n	c0d02314 <bagl_ui_nanos_screen1_button+0xb4>
c0d022c2:	69e0      	ldr	r0, [r4, #28]
c0d022c4:	491d      	ldr	r1, [pc, #116]	; (c0d0233c <bagl_ui_nanos_screen1_button+0xdc>)
c0d022c6:	4288      	cmp	r0, r1
c0d022c8:	d116      	bne.n	c0d022f8 <bagl_ui_nanos_screen1_button+0x98>
c0d022ca:	e023      	b.n	c0d02314 <bagl_ui_nanos_screen1_button+0xb4>
c0d022cc:	6860      	ldr	r0, [r4, #4]
c0d022ce:	4285      	cmp	r5, r0
c0d022d0:	d220      	bcs.n	c0d02314 <bagl_ui_nanos_screen1_button+0xb4>
c0d022d2:	f7ff ff89 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d022d6:	2800      	cmp	r0, #0
c0d022d8:	d11c      	bne.n	c0d02314 <bagl_ui_nanos_screen1_button+0xb4>
c0d022da:	68a0      	ldr	r0, [r4, #8]
c0d022dc:	68e1      	ldr	r1, [r4, #12]
c0d022de:	2538      	movs	r5, #56	; 0x38
c0d022e0:	4368      	muls	r0, r5
c0d022e2:	6822      	ldr	r2, [r4, #0]
c0d022e4:	1810      	adds	r0, r2, r0
c0d022e6:	2900      	cmp	r1, #0
c0d022e8:	d009      	beq.n	c0d022fe <bagl_ui_nanos_screen1_button+0x9e>
c0d022ea:	4788      	blx	r1
c0d022ec:	2800      	cmp	r0, #0
c0d022ee:	d106      	bne.n	c0d022fe <bagl_ui_nanos_screen1_button+0x9e>
c0d022f0:	68a0      	ldr	r0, [r4, #8]
c0d022f2:	1c45      	adds	r5, r0, #1
c0d022f4:	60a5      	str	r5, [r4, #8]
c0d022f6:	6820      	ldr	r0, [r4, #0]
c0d022f8:	2800      	cmp	r0, #0
c0d022fa:	d1e7      	bne.n	c0d022cc <bagl_ui_nanos_screen1_button+0x6c>
c0d022fc:	e00a      	b.n	c0d02314 <bagl_ui_nanos_screen1_button+0xb4>
c0d022fe:	2801      	cmp	r0, #1
c0d02300:	d103      	bne.n	c0d0230a <bagl_ui_nanos_screen1_button+0xaa>
c0d02302:	68a0      	ldr	r0, [r4, #8]
c0d02304:	4345      	muls	r5, r0
c0d02306:	6820      	ldr	r0, [r4, #0]
c0d02308:	1940      	adds	r0, r0, r5
c0d0230a:	f7fe fbad 	bl	c0d00a68 <io_seproxyhal_display>
c0d0230e:	68a0      	ldr	r0, [r4, #8]
c0d02310:	1c40      	adds	r0, r0, #1
c0d02312:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d02314:	2000      	movs	r0, #0
c0d02316:	bdb0      	pop	{r4, r5, r7, pc}
c0d02318:	80000002 	.word	0x80000002
c0d0231c:	80000001 	.word	0x80000001
c0d02320:	54494e49 	.word	0x54494e49
c0d02324:	00000000 	.word	0x00000000
c0d02328:	6c697453 	.word	0x6c697453
c0d0232c:	6e75206c 	.word	0x6e75206c
c0d02330:	74696e69 	.word	0x74696e69
c0d02334:	00000000 	.word	0x00000000
c0d02338:	20001a98 	.word	0x20001a98
c0d0233c:	b0105044 	.word	0xb0105044
c0d02340:	000017ac 	.word	0x000017ac
c0d02344:	00000153 	.word	0x00000153

c0d02348 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d02348:	b5b0      	push	{r4, r5, r7, lr}
c0d0234a:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d0234c:	2800      	cmp	r0, #0
c0d0234e:	d005      	beq.n	c0d0235c <ui_display_debug+0x14>
c0d02350:	2900      	cmp	r1, #0
c0d02352:	d003      	beq.n	c0d0235c <ui_display_debug+0x14>
c0d02354:	2a00      	cmp	r2, #0
c0d02356:	d001      	beq.n	c0d0235c <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d02358:	f7fd fec6 	bl	c0d000e8 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d0235c:	4c21      	ldr	r4, [pc, #132]	; (c0d023e4 <ui_display_debug+0x9c>)
c0d0235e:	4823      	ldr	r0, [pc, #140]	; (c0d023ec <ui_display_debug+0xa4>)
c0d02360:	4478      	add	r0, pc
c0d02362:	6020      	str	r0, [r4, #0]
c0d02364:	2004      	movs	r0, #4
c0d02366:	6060      	str	r0, [r4, #4]
c0d02368:	4821      	ldr	r0, [pc, #132]	; (c0d023f0 <ui_display_debug+0xa8>)
c0d0236a:	4478      	add	r0, pc
c0d0236c:	6120      	str	r0, [r4, #16]
c0d0236e:	2500      	movs	r5, #0
c0d02370:	60e5      	str	r5, [r4, #12]
c0d02372:	2003      	movs	r0, #3
c0d02374:	7620      	strb	r0, [r4, #24]
c0d02376:	61e5      	str	r5, [r4, #28]
c0d02378:	4620      	mov	r0, r4
c0d0237a:	3018      	adds	r0, #24
c0d0237c:	f7ff fedc 	bl	c0d02138 <os_ux>
c0d02380:	61e0      	str	r0, [r4, #28]
c0d02382:	f7ff f89d 	bl	c0d014c0 <io_seproxyhal_init_ux>
c0d02386:	60a5      	str	r5, [r4, #8]
c0d02388:	6820      	ldr	r0, [r4, #0]
c0d0238a:	2800      	cmp	r0, #0
c0d0238c:	d028      	beq.n	c0d023e0 <ui_display_debug+0x98>
c0d0238e:	69e0      	ldr	r0, [r4, #28]
c0d02390:	4915      	ldr	r1, [pc, #84]	; (c0d023e8 <ui_display_debug+0xa0>)
c0d02392:	4288      	cmp	r0, r1
c0d02394:	d116      	bne.n	c0d023c4 <ui_display_debug+0x7c>
c0d02396:	e023      	b.n	c0d023e0 <ui_display_debug+0x98>
c0d02398:	6860      	ldr	r0, [r4, #4]
c0d0239a:	4285      	cmp	r5, r0
c0d0239c:	d220      	bcs.n	c0d023e0 <ui_display_debug+0x98>
c0d0239e:	f7ff ff23 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d023a2:	2800      	cmp	r0, #0
c0d023a4:	d11c      	bne.n	c0d023e0 <ui_display_debug+0x98>
c0d023a6:	68a0      	ldr	r0, [r4, #8]
c0d023a8:	68e1      	ldr	r1, [r4, #12]
c0d023aa:	2538      	movs	r5, #56	; 0x38
c0d023ac:	4368      	muls	r0, r5
c0d023ae:	6822      	ldr	r2, [r4, #0]
c0d023b0:	1810      	adds	r0, r2, r0
c0d023b2:	2900      	cmp	r1, #0
c0d023b4:	d009      	beq.n	c0d023ca <ui_display_debug+0x82>
c0d023b6:	4788      	blx	r1
c0d023b8:	2800      	cmp	r0, #0
c0d023ba:	d106      	bne.n	c0d023ca <ui_display_debug+0x82>
c0d023bc:	68a0      	ldr	r0, [r4, #8]
c0d023be:	1c45      	adds	r5, r0, #1
c0d023c0:	60a5      	str	r5, [r4, #8]
c0d023c2:	6820      	ldr	r0, [r4, #0]
c0d023c4:	2800      	cmp	r0, #0
c0d023c6:	d1e7      	bne.n	c0d02398 <ui_display_debug+0x50>
c0d023c8:	e00a      	b.n	c0d023e0 <ui_display_debug+0x98>
c0d023ca:	2801      	cmp	r0, #1
c0d023cc:	d103      	bne.n	c0d023d6 <ui_display_debug+0x8e>
c0d023ce:	68a0      	ldr	r0, [r4, #8]
c0d023d0:	4345      	muls	r5, r0
c0d023d2:	6820      	ldr	r0, [r4, #0]
c0d023d4:	1940      	adds	r0, r0, r5
c0d023d6:	f7fe fb47 	bl	c0d00a68 <io_seproxyhal_display>
c0d023da:	68a0      	ldr	r0, [r4, #8]
c0d023dc:	1c40      	adds	r0, r0, #1
c0d023de:	60a0      	str	r0, [r4, #8]
}
c0d023e0:	bdb0      	pop	{r4, r5, r7, pc}
c0d023e2:	46c0      	nop			; (mov r8, r8)
c0d023e4:	20001a98 	.word	0x20001a98
c0d023e8:	b0105044 	.word	0xb0105044
c0d023ec:	000016e0 	.word	0x000016e0
c0d023f0:	00000087 	.word	0x00000087

c0d023f4 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d023f4:	b580      	push	{r7, lr}
c0d023f6:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d023f8:	4905      	ldr	r1, [pc, #20]	; (c0d02410 <bagl_ui_nanos_screen2_button+0x1c>)
c0d023fa:	4288      	cmp	r0, r1
c0d023fc:	d002      	beq.n	c0d02404 <bagl_ui_nanos_screen2_button+0x10>
c0d023fe:	4905      	ldr	r1, [pc, #20]	; (c0d02414 <bagl_ui_nanos_screen2_button+0x20>)
c0d02400:	4288      	cmp	r0, r1
c0d02402:	d102      	bne.n	c0d0240a <bagl_ui_nanos_screen2_button+0x16>
c0d02404:	2000      	movs	r0, #0
c0d02406:	f7ff fe79 	bl	c0d020fc <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d0240a:	2000      	movs	r0, #0
c0d0240c:	bd80      	pop	{r7, pc}
c0d0240e:	46c0      	nop			; (mov r8, r8)
c0d02410:	80000002 	.word	0x80000002
c0d02414:	80000001 	.word	0x80000001

c0d02418 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d02418:	b5b0      	push	{r4, r5, r7, lr}
c0d0241a:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d0241c:	2001      	movs	r0, #1
c0d0241e:	0204      	lsls	r4, r0, #8
c0d02420:	f7ff fea8 	bl	c0d02174 <os_seph_features>
c0d02424:	4220      	tst	r0, r4
c0d02426:	d136      	bne.n	c0d02496 <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d02428:	4c3c      	ldr	r4, [pc, #240]	; (c0d0251c <ui_idle+0x104>)
c0d0242a:	4840      	ldr	r0, [pc, #256]	; (c0d0252c <ui_idle+0x114>)
c0d0242c:	4478      	add	r0, pc
c0d0242e:	6020      	str	r0, [r4, #0]
c0d02430:	2004      	movs	r0, #4
c0d02432:	6060      	str	r0, [r4, #4]
c0d02434:	483e      	ldr	r0, [pc, #248]	; (c0d02530 <ui_idle+0x118>)
c0d02436:	4478      	add	r0, pc
c0d02438:	6120      	str	r0, [r4, #16]
c0d0243a:	2500      	movs	r5, #0
c0d0243c:	60e5      	str	r5, [r4, #12]
c0d0243e:	2003      	movs	r0, #3
c0d02440:	7620      	strb	r0, [r4, #24]
c0d02442:	61e5      	str	r5, [r4, #28]
c0d02444:	4620      	mov	r0, r4
c0d02446:	3018      	adds	r0, #24
c0d02448:	f7ff fe76 	bl	c0d02138 <os_ux>
c0d0244c:	61e0      	str	r0, [r4, #28]
c0d0244e:	f7ff f837 	bl	c0d014c0 <io_seproxyhal_init_ux>
c0d02452:	60a5      	str	r5, [r4, #8]
c0d02454:	6820      	ldr	r0, [r4, #0]
c0d02456:	2800      	cmp	r0, #0
c0d02458:	d05f      	beq.n	c0d0251a <ui_idle+0x102>
c0d0245a:	69e0      	ldr	r0, [r4, #28]
c0d0245c:	4930      	ldr	r1, [pc, #192]	; (c0d02520 <ui_idle+0x108>)
c0d0245e:	4288      	cmp	r0, r1
c0d02460:	d116      	bne.n	c0d02490 <ui_idle+0x78>
c0d02462:	e05a      	b.n	c0d0251a <ui_idle+0x102>
c0d02464:	6860      	ldr	r0, [r4, #4]
c0d02466:	4285      	cmp	r5, r0
c0d02468:	d257      	bcs.n	c0d0251a <ui_idle+0x102>
c0d0246a:	f7ff febd 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d0246e:	2800      	cmp	r0, #0
c0d02470:	d153      	bne.n	c0d0251a <ui_idle+0x102>
c0d02472:	68a0      	ldr	r0, [r4, #8]
c0d02474:	68e1      	ldr	r1, [r4, #12]
c0d02476:	2538      	movs	r5, #56	; 0x38
c0d02478:	4368      	muls	r0, r5
c0d0247a:	6822      	ldr	r2, [r4, #0]
c0d0247c:	1810      	adds	r0, r2, r0
c0d0247e:	2900      	cmp	r1, #0
c0d02480:	d040      	beq.n	c0d02504 <ui_idle+0xec>
c0d02482:	4788      	blx	r1
c0d02484:	2800      	cmp	r0, #0
c0d02486:	d13d      	bne.n	c0d02504 <ui_idle+0xec>
c0d02488:	68a0      	ldr	r0, [r4, #8]
c0d0248a:	1c45      	adds	r5, r0, #1
c0d0248c:	60a5      	str	r5, [r4, #8]
c0d0248e:	6820      	ldr	r0, [r4, #0]
c0d02490:	2800      	cmp	r0, #0
c0d02492:	d1e7      	bne.n	c0d02464 <ui_idle+0x4c>
c0d02494:	e041      	b.n	c0d0251a <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d02496:	4c21      	ldr	r4, [pc, #132]	; (c0d0251c <ui_idle+0x104>)
c0d02498:	4822      	ldr	r0, [pc, #136]	; (c0d02524 <ui_idle+0x10c>)
c0d0249a:	4478      	add	r0, pc
c0d0249c:	6020      	str	r0, [r4, #0]
c0d0249e:	2004      	movs	r0, #4
c0d024a0:	6060      	str	r0, [r4, #4]
c0d024a2:	4821      	ldr	r0, [pc, #132]	; (c0d02528 <ui_idle+0x110>)
c0d024a4:	4478      	add	r0, pc
c0d024a6:	6120      	str	r0, [r4, #16]
c0d024a8:	2500      	movs	r5, #0
c0d024aa:	60e5      	str	r5, [r4, #12]
c0d024ac:	2003      	movs	r0, #3
c0d024ae:	7620      	strb	r0, [r4, #24]
c0d024b0:	61e5      	str	r5, [r4, #28]
c0d024b2:	4620      	mov	r0, r4
c0d024b4:	3018      	adds	r0, #24
c0d024b6:	f7ff fe3f 	bl	c0d02138 <os_ux>
c0d024ba:	61e0      	str	r0, [r4, #28]
c0d024bc:	f7ff f800 	bl	c0d014c0 <io_seproxyhal_init_ux>
c0d024c0:	60a5      	str	r5, [r4, #8]
c0d024c2:	6820      	ldr	r0, [r4, #0]
c0d024c4:	2800      	cmp	r0, #0
c0d024c6:	d028      	beq.n	c0d0251a <ui_idle+0x102>
c0d024c8:	69e0      	ldr	r0, [r4, #28]
c0d024ca:	4915      	ldr	r1, [pc, #84]	; (c0d02520 <ui_idle+0x108>)
c0d024cc:	4288      	cmp	r0, r1
c0d024ce:	d116      	bne.n	c0d024fe <ui_idle+0xe6>
c0d024d0:	e023      	b.n	c0d0251a <ui_idle+0x102>
c0d024d2:	6860      	ldr	r0, [r4, #4]
c0d024d4:	4285      	cmp	r5, r0
c0d024d6:	d220      	bcs.n	c0d0251a <ui_idle+0x102>
c0d024d8:	f7ff fe86 	bl	c0d021e8 <io_seproxyhal_spi_is_status_sent>
c0d024dc:	2800      	cmp	r0, #0
c0d024de:	d11c      	bne.n	c0d0251a <ui_idle+0x102>
c0d024e0:	68a0      	ldr	r0, [r4, #8]
c0d024e2:	68e1      	ldr	r1, [r4, #12]
c0d024e4:	2538      	movs	r5, #56	; 0x38
c0d024e6:	4368      	muls	r0, r5
c0d024e8:	6822      	ldr	r2, [r4, #0]
c0d024ea:	1810      	adds	r0, r2, r0
c0d024ec:	2900      	cmp	r1, #0
c0d024ee:	d009      	beq.n	c0d02504 <ui_idle+0xec>
c0d024f0:	4788      	blx	r1
c0d024f2:	2800      	cmp	r0, #0
c0d024f4:	d106      	bne.n	c0d02504 <ui_idle+0xec>
c0d024f6:	68a0      	ldr	r0, [r4, #8]
c0d024f8:	1c45      	adds	r5, r0, #1
c0d024fa:	60a5      	str	r5, [r4, #8]
c0d024fc:	6820      	ldr	r0, [r4, #0]
c0d024fe:	2800      	cmp	r0, #0
c0d02500:	d1e7      	bne.n	c0d024d2 <ui_idle+0xba>
c0d02502:	e00a      	b.n	c0d0251a <ui_idle+0x102>
c0d02504:	2801      	cmp	r0, #1
c0d02506:	d103      	bne.n	c0d02510 <ui_idle+0xf8>
c0d02508:	68a0      	ldr	r0, [r4, #8]
c0d0250a:	4345      	muls	r5, r0
c0d0250c:	6820      	ldr	r0, [r4, #0]
c0d0250e:	1940      	adds	r0, r0, r5
c0d02510:	f7fe faaa 	bl	c0d00a68 <io_seproxyhal_display>
c0d02514:	68a0      	ldr	r0, [r4, #8]
c0d02516:	1c40      	adds	r0, r0, #1
c0d02518:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d0251a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0251c:	20001a98 	.word	0x20001a98
c0d02520:	b0105044 	.word	0xb0105044
c0d02524:	00001686 	.word	0x00001686
c0d02528:	0000008d 	.word	0x0000008d
c0d0252c:	00001534 	.word	0x00001534
c0d02530:	fffffe27 	.word	0xfffffe27

c0d02534 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d02534:	2000      	movs	r0, #0
c0d02536:	4770      	bx	lr

c0d02538 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d02538:	b5d0      	push	{r4, r6, r7, lr}
c0d0253a:	af02      	add	r7, sp, #8
c0d0253c:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d0253e:	4620      	mov	r0, r4
c0d02540:	f7ff fddc 	bl	c0d020fc <os_sched_exit>
    return NULL;
c0d02544:	4620      	mov	r0, r4
c0d02546:	bdd0      	pop	{r4, r6, r7, pc}

c0d02548 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02548:	4902      	ldr	r1, [pc, #8]	; (c0d02554 <USBD_LL_Init+0xc>)
c0d0254a:	2000      	movs	r0, #0
c0d0254c:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d0254e:	4902      	ldr	r1, [pc, #8]	; (c0d02558 <USBD_LL_Init+0x10>)
c0d02550:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d02552:	4770      	bx	lr
c0d02554:	20001d2c 	.word	0x20001d2c
c0d02558:	20001d30 	.word	0x20001d30

c0d0255c <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d0255c:	b5d0      	push	{r4, r6, r7, lr}
c0d0255e:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02560:	4806      	ldr	r0, [pc, #24]	; (c0d0257c <USBD_LL_DeInit+0x20>)
c0d02562:	214f      	movs	r1, #79	; 0x4f
c0d02564:	7001      	strb	r1, [r0, #0]
c0d02566:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02568:	7044      	strb	r4, [r0, #1]
c0d0256a:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d0256c:	7081      	strb	r1, [r0, #2]
c0d0256e:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02570:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d02572:	2104      	movs	r1, #4
c0d02574:	f7ff fe1a 	bl	c0d021ac <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02578:	4620      	mov	r0, r4
c0d0257a:	bdd0      	pop	{r4, r6, r7, pc}
c0d0257c:	20001a18 	.word	0x20001a18

c0d02580 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02580:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02582:	af03      	add	r7, sp, #12
c0d02584:	b083      	sub	sp, #12
c0d02586:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02588:	264f      	movs	r6, #79	; 0x4f
c0d0258a:	702e      	strb	r6, [r5, #0]
c0d0258c:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0258e:	706c      	strb	r4, [r5, #1]
c0d02590:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d02592:	70a8      	strb	r0, [r5, #2]
c0d02594:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02596:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d02598:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0259a:	2105      	movs	r1, #5
c0d0259c:	4628      	mov	r0, r5
c0d0259e:	f7ff fe05 	bl	c0d021ac <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d025a2:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d025a4:	706c      	strb	r4, [r5, #1]
c0d025a6:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d025a8:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d025aa:	70e8      	strb	r0, [r5, #3]
c0d025ac:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d025ae:	4628      	mov	r0, r5
c0d025b0:	f7ff fdfc 	bl	c0d021ac <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d025b4:	4620      	mov	r0, r4
c0d025b6:	b003      	add	sp, #12
c0d025b8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d025ba <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d025ba:	b5d0      	push	{r4, r6, r7, lr}
c0d025bc:	af02      	add	r7, sp, #8
c0d025be:	b082      	sub	sp, #8
c0d025c0:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d025c2:	214f      	movs	r1, #79	; 0x4f
c0d025c4:	7001      	strb	r1, [r0, #0]
c0d025c6:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d025c8:	7044      	strb	r4, [r0, #1]
c0d025ca:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d025cc:	7081      	strb	r1, [r0, #2]
c0d025ce:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d025d0:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d025d2:	2104      	movs	r1, #4
c0d025d4:	f7ff fdea 	bl	c0d021ac <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d025d8:	4620      	mov	r0, r4
c0d025da:	b002      	add	sp, #8
c0d025dc:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d025e0 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d025e0:	b5b0      	push	{r4, r5, r7, lr}
c0d025e2:	af02      	add	r7, sp, #8
c0d025e4:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d025e6:	480f      	ldr	r0, [pc, #60]	; (c0d02624 <USBD_LL_OpenEP+0x44>)
c0d025e8:	2400      	movs	r4, #0
c0d025ea:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d025ec:	480e      	ldr	r0, [pc, #56]	; (c0d02628 <USBD_LL_OpenEP+0x48>)
c0d025ee:	6004      	str	r4, [r0, #0]
c0d025f0:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d025f2:	254f      	movs	r5, #79	; 0x4f
c0d025f4:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d025f6:	7044      	strb	r4, [r0, #1]
c0d025f8:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d025fa:	7085      	strb	r5, [r0, #2]
c0d025fc:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d025fe:	70c5      	strb	r5, [r0, #3]
c0d02600:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d02602:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d02604:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d02606:	2a03      	cmp	r2, #3
c0d02608:	d802      	bhi.n	c0d02610 <USBD_LL_OpenEP+0x30>
c0d0260a:	00d0      	lsls	r0, r2, #3
c0d0260c:	4c07      	ldr	r4, [pc, #28]	; (c0d0262c <USBD_LL_OpenEP+0x4c>)
c0d0260e:	40c4      	lsrs	r4, r0
c0d02610:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d02612:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d02614:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02616:	2108      	movs	r1, #8
c0d02618:	f7ff fdc8 	bl	c0d021ac <io_seproxyhal_spi_send>
c0d0261c:	2000      	movs	r0, #0
  return USBD_OK; 
c0d0261e:	b002      	add	sp, #8
c0d02620:	bdb0      	pop	{r4, r5, r7, pc}
c0d02622:	46c0      	nop			; (mov r8, r8)
c0d02624:	20001d2c 	.word	0x20001d2c
c0d02628:	20001d30 	.word	0x20001d30
c0d0262c:	02030401 	.word	0x02030401

c0d02630 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02630:	b5d0      	push	{r4, r6, r7, lr}
c0d02632:	af02      	add	r7, sp, #8
c0d02634:	b082      	sub	sp, #8
c0d02636:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02638:	224f      	movs	r2, #79	; 0x4f
c0d0263a:	7002      	strb	r2, [r0, #0]
c0d0263c:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0263e:	7044      	strb	r4, [r0, #1]
c0d02640:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d02642:	7082      	strb	r2, [r0, #2]
c0d02644:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02646:	70c2      	strb	r2, [r0, #3]
c0d02648:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d0264a:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d0264c:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d0264e:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02650:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02652:	2108      	movs	r1, #8
c0d02654:	f7ff fdaa 	bl	c0d021ac <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02658:	4620      	mov	r0, r4
c0d0265a:	b002      	add	sp, #8
c0d0265c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02660 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02660:	b5b0      	push	{r4, r5, r7, lr}
c0d02662:	af02      	add	r7, sp, #8
c0d02664:	b082      	sub	sp, #8
c0d02666:	460d      	mov	r5, r1
c0d02668:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0266a:	2150      	movs	r1, #80	; 0x50
c0d0266c:	7001      	strb	r1, [r0, #0]
c0d0266e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02670:	7044      	strb	r4, [r0, #1]
c0d02672:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02674:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02676:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02678:	2140      	movs	r1, #64	; 0x40
c0d0267a:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d0267c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0267e:	2106      	movs	r1, #6
c0d02680:	f7ff fd94 	bl	c0d021ac <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02684:	2080      	movs	r0, #128	; 0x80
c0d02686:	4205      	tst	r5, r0
c0d02688:	d101      	bne.n	c0d0268e <USBD_LL_StallEP+0x2e>
c0d0268a:	4807      	ldr	r0, [pc, #28]	; (c0d026a8 <USBD_LL_StallEP+0x48>)
c0d0268c:	e000      	b.n	c0d02690 <USBD_LL_StallEP+0x30>
c0d0268e:	4805      	ldr	r0, [pc, #20]	; (c0d026a4 <USBD_LL_StallEP+0x44>)
c0d02690:	6801      	ldr	r1, [r0, #0]
c0d02692:	227f      	movs	r2, #127	; 0x7f
c0d02694:	4015      	ands	r5, r2
c0d02696:	2201      	movs	r2, #1
c0d02698:	40aa      	lsls	r2, r5
c0d0269a:	430a      	orrs	r2, r1
c0d0269c:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d0269e:	4620      	mov	r0, r4
c0d026a0:	b002      	add	sp, #8
c0d026a2:	bdb0      	pop	{r4, r5, r7, pc}
c0d026a4:	20001d2c 	.word	0x20001d2c
c0d026a8:	20001d30 	.word	0x20001d30

c0d026ac <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d026ac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d026ae:	af03      	add	r7, sp, #12
c0d026b0:	b083      	sub	sp, #12
c0d026b2:	460d      	mov	r5, r1
c0d026b4:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d026b6:	2150      	movs	r1, #80	; 0x50
c0d026b8:	7001      	strb	r1, [r0, #0]
c0d026ba:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d026bc:	7044      	strb	r4, [r0, #1]
c0d026be:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d026c0:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d026c2:	70c5      	strb	r5, [r0, #3]
c0d026c4:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d026c6:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d026c8:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d026ca:	2106      	movs	r1, #6
c0d026cc:	f7ff fd6e 	bl	c0d021ac <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d026d0:	4235      	tst	r5, r6
c0d026d2:	d101      	bne.n	c0d026d8 <USBD_LL_ClearStallEP+0x2c>
c0d026d4:	4807      	ldr	r0, [pc, #28]	; (c0d026f4 <USBD_LL_ClearStallEP+0x48>)
c0d026d6:	e000      	b.n	c0d026da <USBD_LL_ClearStallEP+0x2e>
c0d026d8:	4805      	ldr	r0, [pc, #20]	; (c0d026f0 <USBD_LL_ClearStallEP+0x44>)
c0d026da:	6801      	ldr	r1, [r0, #0]
c0d026dc:	227f      	movs	r2, #127	; 0x7f
c0d026de:	4015      	ands	r5, r2
c0d026e0:	2201      	movs	r2, #1
c0d026e2:	40aa      	lsls	r2, r5
c0d026e4:	4391      	bics	r1, r2
c0d026e6:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d026e8:	4620      	mov	r0, r4
c0d026ea:	b003      	add	sp, #12
c0d026ec:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d026ee:	46c0      	nop			; (mov r8, r8)
c0d026f0:	20001d2c 	.word	0x20001d2c
c0d026f4:	20001d30 	.word	0x20001d30

c0d026f8 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d026f8:	2080      	movs	r0, #128	; 0x80
c0d026fa:	4201      	tst	r1, r0
c0d026fc:	d001      	beq.n	c0d02702 <USBD_LL_IsStallEP+0xa>
c0d026fe:	4806      	ldr	r0, [pc, #24]	; (c0d02718 <USBD_LL_IsStallEP+0x20>)
c0d02700:	e000      	b.n	c0d02704 <USBD_LL_IsStallEP+0xc>
c0d02702:	4804      	ldr	r0, [pc, #16]	; (c0d02714 <USBD_LL_IsStallEP+0x1c>)
c0d02704:	6800      	ldr	r0, [r0, #0]
c0d02706:	227f      	movs	r2, #127	; 0x7f
c0d02708:	4011      	ands	r1, r2
c0d0270a:	2201      	movs	r2, #1
c0d0270c:	408a      	lsls	r2, r1
c0d0270e:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d02710:	b2d0      	uxtb	r0, r2
c0d02712:	4770      	bx	lr
c0d02714:	20001d30 	.word	0x20001d30
c0d02718:	20001d2c 	.word	0x20001d2c

c0d0271c <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d0271c:	b5d0      	push	{r4, r6, r7, lr}
c0d0271e:	af02      	add	r7, sp, #8
c0d02720:	b082      	sub	sp, #8
c0d02722:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02724:	224f      	movs	r2, #79	; 0x4f
c0d02726:	7002      	strb	r2, [r0, #0]
c0d02728:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0272a:	7044      	strb	r4, [r0, #1]
c0d0272c:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d0272e:	7082      	strb	r2, [r0, #2]
c0d02730:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02732:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02734:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02736:	2105      	movs	r1, #5
c0d02738:	f7ff fd38 	bl	c0d021ac <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0273c:	4620      	mov	r0, r4
c0d0273e:	b002      	add	sp, #8
c0d02740:	bdd0      	pop	{r4, r6, r7, pc}

c0d02742 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d02742:	b5b0      	push	{r4, r5, r7, lr}
c0d02744:	af02      	add	r7, sp, #8
c0d02746:	b082      	sub	sp, #8
c0d02748:	461c      	mov	r4, r3
c0d0274a:	4615      	mov	r5, r2
c0d0274c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0274e:	2250      	movs	r2, #80	; 0x50
c0d02750:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d02752:	1ce2      	adds	r2, r4, #3
c0d02754:	0a13      	lsrs	r3, r2, #8
c0d02756:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d02758:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d0275a:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0275c:	2120      	movs	r1, #32
c0d0275e:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02760:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02762:	2106      	movs	r1, #6
c0d02764:	f7ff fd22 	bl	c0d021ac <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02768:	4628      	mov	r0, r5
c0d0276a:	4621      	mov	r1, r4
c0d0276c:	f7ff fd1e 	bl	c0d021ac <io_seproxyhal_spi_send>
c0d02770:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02772:	b002      	add	sp, #8
c0d02774:	bdb0      	pop	{r4, r5, r7, pc}

c0d02776 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02776:	b5d0      	push	{r4, r6, r7, lr}
c0d02778:	af02      	add	r7, sp, #8
c0d0277a:	b082      	sub	sp, #8
c0d0277c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0277e:	2350      	movs	r3, #80	; 0x50
c0d02780:	7003      	strb	r3, [r0, #0]
c0d02782:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02784:	7044      	strb	r4, [r0, #1]
c0d02786:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02788:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d0278a:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d0278c:	2130      	movs	r1, #48	; 0x30
c0d0278e:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02790:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02792:	2106      	movs	r1, #6
c0d02794:	f7ff fd0a 	bl	c0d021ac <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d02798:	4620      	mov	r0, r4
c0d0279a:	b002      	add	sp, #8
c0d0279c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0279e <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d0279e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d027a0:	af03      	add	r7, sp, #12
c0d027a2:	b081      	sub	sp, #4
c0d027a4:	4615      	mov	r5, r2
c0d027a6:	460e      	mov	r6, r1
c0d027a8:	4604      	mov	r4, r0
c0d027aa:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d027ac:	2c00      	cmp	r4, #0
c0d027ae:	d011      	beq.n	c0d027d4 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d027b0:	2049      	movs	r0, #73	; 0x49
c0d027b2:	0081      	lsls	r1, r0, #2
c0d027b4:	4620      	mov	r0, r4
c0d027b6:	f000 ffd7 	bl	c0d03768 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d027ba:	2e00      	cmp	r6, #0
c0d027bc:	d002      	beq.n	c0d027c4 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d027be:	2011      	movs	r0, #17
c0d027c0:	0100      	lsls	r0, r0, #4
c0d027c2:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d027c4:	20fc      	movs	r0, #252	; 0xfc
c0d027c6:	2101      	movs	r1, #1
c0d027c8:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d027ca:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d027cc:	4620      	mov	r0, r4
c0d027ce:	f7ff febb 	bl	c0d02548 <USBD_LL_Init>
c0d027d2:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d027d4:	b2c0      	uxtb	r0, r0
c0d027d6:	b001      	add	sp, #4
c0d027d8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d027da <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d027da:	b5d0      	push	{r4, r6, r7, lr}
c0d027dc:	af02      	add	r7, sp, #8
c0d027de:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d027e0:	20fc      	movs	r0, #252	; 0xfc
c0d027e2:	2101      	movs	r1, #1
c0d027e4:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d027e6:	2045      	movs	r0, #69	; 0x45
c0d027e8:	0080      	lsls	r0, r0, #2
c0d027ea:	5820      	ldr	r0, [r4, r0]
c0d027ec:	2800      	cmp	r0, #0
c0d027ee:	d006      	beq.n	c0d027fe <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d027f0:	6840      	ldr	r0, [r0, #4]
c0d027f2:	f7ff fb1f 	bl	c0d01e34 <pic>
c0d027f6:	4602      	mov	r2, r0
c0d027f8:	7921      	ldrb	r1, [r4, #4]
c0d027fa:	4620      	mov	r0, r4
c0d027fc:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d027fe:	4620      	mov	r0, r4
c0d02800:	f7ff fedb 	bl	c0d025ba <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02804:	4620      	mov	r0, r4
c0d02806:	f7ff fea9 	bl	c0d0255c <USBD_LL_DeInit>
  
  return USBD_OK;
c0d0280a:	2000      	movs	r0, #0
c0d0280c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0280e <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d0280e:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d02810:	2900      	cmp	r1, #0
c0d02812:	d003      	beq.n	c0d0281c <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02814:	2245      	movs	r2, #69	; 0x45
c0d02816:	0092      	lsls	r2, r2, #2
c0d02818:	5081      	str	r1, [r0, r2]
c0d0281a:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d0281c:	b2d0      	uxtb	r0, r2
c0d0281e:	4770      	bx	lr

c0d02820 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02820:	b580      	push	{r7, lr}
c0d02822:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02824:	f7ff feac 	bl	c0d02580 <USBD_LL_Start>
  
  return USBD_OK;  
c0d02828:	2000      	movs	r0, #0
c0d0282a:	bd80      	pop	{r7, pc}

c0d0282c <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d0282c:	b5b0      	push	{r4, r5, r7, lr}
c0d0282e:	af02      	add	r7, sp, #8
c0d02830:	460c      	mov	r4, r1
c0d02832:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02834:	2045      	movs	r0, #69	; 0x45
c0d02836:	0080      	lsls	r0, r0, #2
c0d02838:	5828      	ldr	r0, [r5, r0]
c0d0283a:	2800      	cmp	r0, #0
c0d0283c:	d00c      	beq.n	c0d02858 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d0283e:	6800      	ldr	r0, [r0, #0]
c0d02840:	f7ff faf8 	bl	c0d01e34 <pic>
c0d02844:	4602      	mov	r2, r0
c0d02846:	4628      	mov	r0, r5
c0d02848:	4621      	mov	r1, r4
c0d0284a:	4790      	blx	r2
c0d0284c:	4601      	mov	r1, r0
c0d0284e:	2002      	movs	r0, #2
c0d02850:	2900      	cmp	r1, #0
c0d02852:	d100      	bne.n	c0d02856 <USBD_SetClassConfig+0x2a>
c0d02854:	4608      	mov	r0, r1
c0d02856:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02858:	2002      	movs	r0, #2
c0d0285a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0285c <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d0285c:	b5b0      	push	{r4, r5, r7, lr}
c0d0285e:	af02      	add	r7, sp, #8
c0d02860:	460c      	mov	r4, r1
c0d02862:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02864:	2045      	movs	r0, #69	; 0x45
c0d02866:	0080      	lsls	r0, r0, #2
c0d02868:	5828      	ldr	r0, [r5, r0]
c0d0286a:	2800      	cmp	r0, #0
c0d0286c:	d006      	beq.n	c0d0287c <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d0286e:	6840      	ldr	r0, [r0, #4]
c0d02870:	f7ff fae0 	bl	c0d01e34 <pic>
c0d02874:	4602      	mov	r2, r0
c0d02876:	4628      	mov	r0, r5
c0d02878:	4621      	mov	r1, r4
c0d0287a:	4790      	blx	r2
  }
  return USBD_OK;
c0d0287c:	2000      	movs	r0, #0
c0d0287e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02880 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02880:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02882:	af03      	add	r7, sp, #12
c0d02884:	b081      	sub	sp, #4
c0d02886:	4604      	mov	r4, r0
c0d02888:	2021      	movs	r0, #33	; 0x21
c0d0288a:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d0288c:	19a5      	adds	r5, r4, r6
c0d0288e:	4628      	mov	r0, r5
c0d02890:	f000 fb69 	bl	c0d02f66 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02894:	20f4      	movs	r0, #244	; 0xf4
c0d02896:	2101      	movs	r1, #1
c0d02898:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d0289a:	2087      	movs	r0, #135	; 0x87
c0d0289c:	0040      	lsls	r0, r0, #1
c0d0289e:	5a20      	ldrh	r0, [r4, r0]
c0d028a0:	21f8      	movs	r1, #248	; 0xf8
c0d028a2:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d028a4:	5da1      	ldrb	r1, [r4, r6]
c0d028a6:	201f      	movs	r0, #31
c0d028a8:	4008      	ands	r0, r1
c0d028aa:	2802      	cmp	r0, #2
c0d028ac:	d008      	beq.n	c0d028c0 <USBD_LL_SetupStage+0x40>
c0d028ae:	2801      	cmp	r0, #1
c0d028b0:	d00b      	beq.n	c0d028ca <USBD_LL_SetupStage+0x4a>
c0d028b2:	2800      	cmp	r0, #0
c0d028b4:	d10e      	bne.n	c0d028d4 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d028b6:	4620      	mov	r0, r4
c0d028b8:	4629      	mov	r1, r5
c0d028ba:	f000 f8f1 	bl	c0d02aa0 <USBD_StdDevReq>
c0d028be:	e00e      	b.n	c0d028de <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d028c0:	4620      	mov	r0, r4
c0d028c2:	4629      	mov	r1, r5
c0d028c4:	f000 fad3 	bl	c0d02e6e <USBD_StdEPReq>
c0d028c8:	e009      	b.n	c0d028de <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d028ca:	4620      	mov	r0, r4
c0d028cc:	4629      	mov	r1, r5
c0d028ce:	f000 faa6 	bl	c0d02e1e <USBD_StdItfReq>
c0d028d2:	e004      	b.n	c0d028de <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d028d4:	2080      	movs	r0, #128	; 0x80
c0d028d6:	4001      	ands	r1, r0
c0d028d8:	4620      	mov	r0, r4
c0d028da:	f7ff fec1 	bl	c0d02660 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d028de:	2000      	movs	r0, #0
c0d028e0:	b001      	add	sp, #4
c0d028e2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d028e4 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d028e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d028e6:	af03      	add	r7, sp, #12
c0d028e8:	b081      	sub	sp, #4
c0d028ea:	4615      	mov	r5, r2
c0d028ec:	460e      	mov	r6, r1
c0d028ee:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d028f0:	2e00      	cmp	r6, #0
c0d028f2:	d011      	beq.n	c0d02918 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d028f4:	2045      	movs	r0, #69	; 0x45
c0d028f6:	0080      	lsls	r0, r0, #2
c0d028f8:	5820      	ldr	r0, [r4, r0]
c0d028fa:	6980      	ldr	r0, [r0, #24]
c0d028fc:	2800      	cmp	r0, #0
c0d028fe:	d034      	beq.n	c0d0296a <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02900:	21fc      	movs	r1, #252	; 0xfc
c0d02902:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02904:	2903      	cmp	r1, #3
c0d02906:	d130      	bne.n	c0d0296a <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02908:	f7ff fa94 	bl	c0d01e34 <pic>
c0d0290c:	4603      	mov	r3, r0
c0d0290e:	4620      	mov	r0, r4
c0d02910:	4631      	mov	r1, r6
c0d02912:	462a      	mov	r2, r5
c0d02914:	4798      	blx	r3
c0d02916:	e028      	b.n	c0d0296a <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02918:	20f4      	movs	r0, #244	; 0xf4
c0d0291a:	5820      	ldr	r0, [r4, r0]
c0d0291c:	2803      	cmp	r0, #3
c0d0291e:	d124      	bne.n	c0d0296a <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02920:	2090      	movs	r0, #144	; 0x90
c0d02922:	5820      	ldr	r0, [r4, r0]
c0d02924:	218c      	movs	r1, #140	; 0x8c
c0d02926:	5861      	ldr	r1, [r4, r1]
c0d02928:	4622      	mov	r2, r4
c0d0292a:	328c      	adds	r2, #140	; 0x8c
c0d0292c:	4281      	cmp	r1, r0
c0d0292e:	d90a      	bls.n	c0d02946 <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02930:	1a09      	subs	r1, r1, r0
c0d02932:	6011      	str	r1, [r2, #0]
c0d02934:	4281      	cmp	r1, r0
c0d02936:	d300      	bcc.n	c0d0293a <USBD_LL_DataOutStage+0x56>
c0d02938:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d0293a:	b28a      	uxth	r2, r1
c0d0293c:	4620      	mov	r0, r4
c0d0293e:	4629      	mov	r1, r5
c0d02940:	f000 fc70 	bl	c0d03224 <USBD_CtlContinueRx>
c0d02944:	e011      	b.n	c0d0296a <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02946:	2045      	movs	r0, #69	; 0x45
c0d02948:	0080      	lsls	r0, r0, #2
c0d0294a:	5820      	ldr	r0, [r4, r0]
c0d0294c:	6900      	ldr	r0, [r0, #16]
c0d0294e:	2800      	cmp	r0, #0
c0d02950:	d008      	beq.n	c0d02964 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02952:	21fc      	movs	r1, #252	; 0xfc
c0d02954:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02956:	2903      	cmp	r1, #3
c0d02958:	d104      	bne.n	c0d02964 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d0295a:	f7ff fa6b 	bl	c0d01e34 <pic>
c0d0295e:	4601      	mov	r1, r0
c0d02960:	4620      	mov	r0, r4
c0d02962:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02964:	4620      	mov	r0, r4
c0d02966:	f000 fc65 	bl	c0d03234 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d0296a:	2000      	movs	r0, #0
c0d0296c:	b001      	add	sp, #4
c0d0296e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02970 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02970:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02972:	af03      	add	r7, sp, #12
c0d02974:	b081      	sub	sp, #4
c0d02976:	460d      	mov	r5, r1
c0d02978:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d0297a:	2d00      	cmp	r5, #0
c0d0297c:	d012      	beq.n	c0d029a4 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d0297e:	2045      	movs	r0, #69	; 0x45
c0d02980:	0080      	lsls	r0, r0, #2
c0d02982:	5820      	ldr	r0, [r4, r0]
c0d02984:	2800      	cmp	r0, #0
c0d02986:	d054      	beq.n	c0d02a32 <USBD_LL_DataInStage+0xc2>
c0d02988:	6940      	ldr	r0, [r0, #20]
c0d0298a:	2800      	cmp	r0, #0
c0d0298c:	d051      	beq.n	c0d02a32 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0298e:	21fc      	movs	r1, #252	; 0xfc
c0d02990:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02992:	2903      	cmp	r1, #3
c0d02994:	d14d      	bne.n	c0d02a32 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d02996:	f7ff fa4d 	bl	c0d01e34 <pic>
c0d0299a:	4602      	mov	r2, r0
c0d0299c:	4620      	mov	r0, r4
c0d0299e:	4629      	mov	r1, r5
c0d029a0:	4790      	blx	r2
c0d029a2:	e046      	b.n	c0d02a32 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d029a4:	20f4      	movs	r0, #244	; 0xf4
c0d029a6:	5820      	ldr	r0, [r4, r0]
c0d029a8:	2802      	cmp	r0, #2
c0d029aa:	d13a      	bne.n	c0d02a22 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d029ac:	69e0      	ldr	r0, [r4, #28]
c0d029ae:	6a25      	ldr	r5, [r4, #32]
c0d029b0:	42a8      	cmp	r0, r5
c0d029b2:	d90b      	bls.n	c0d029cc <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d029b4:	1b40      	subs	r0, r0, r5
c0d029b6:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d029b8:	2109      	movs	r1, #9
c0d029ba:	014a      	lsls	r2, r1, #5
c0d029bc:	58a1      	ldr	r1, [r4, r2]
c0d029be:	1949      	adds	r1, r1, r5
c0d029c0:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d029c2:	b282      	uxth	r2, r0
c0d029c4:	4620      	mov	r0, r4
c0d029c6:	f000 fc1e 	bl	c0d03206 <USBD_CtlContinueSendData>
c0d029ca:	e02a      	b.n	c0d02a22 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d029cc:	69a6      	ldr	r6, [r4, #24]
c0d029ce:	4630      	mov	r0, r6
c0d029d0:	4629      	mov	r1, r5
c0d029d2:	f000 fccf 	bl	c0d03374 <__aeabi_uidivmod>
c0d029d6:	42ae      	cmp	r6, r5
c0d029d8:	d30f      	bcc.n	c0d029fa <USBD_LL_DataInStage+0x8a>
c0d029da:	2900      	cmp	r1, #0
c0d029dc:	d10d      	bne.n	c0d029fa <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d029de:	20f8      	movs	r0, #248	; 0xf8
c0d029e0:	5820      	ldr	r0, [r4, r0]
c0d029e2:	4625      	mov	r5, r4
c0d029e4:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d029e6:	4286      	cmp	r6, r0
c0d029e8:	d207      	bcs.n	c0d029fa <USBD_LL_DataInStage+0x8a>
c0d029ea:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d029ec:	4620      	mov	r0, r4
c0d029ee:	4631      	mov	r1, r6
c0d029f0:	4632      	mov	r2, r6
c0d029f2:	f000 fc08 	bl	c0d03206 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d029f6:	602e      	str	r6, [r5, #0]
c0d029f8:	e013      	b.n	c0d02a22 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d029fa:	2045      	movs	r0, #69	; 0x45
c0d029fc:	0080      	lsls	r0, r0, #2
c0d029fe:	5820      	ldr	r0, [r4, r0]
c0d02a00:	2800      	cmp	r0, #0
c0d02a02:	d00b      	beq.n	c0d02a1c <USBD_LL_DataInStage+0xac>
c0d02a04:	68c0      	ldr	r0, [r0, #12]
c0d02a06:	2800      	cmp	r0, #0
c0d02a08:	d008      	beq.n	c0d02a1c <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02a0a:	21fc      	movs	r1, #252	; 0xfc
c0d02a0c:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02a0e:	2903      	cmp	r1, #3
c0d02a10:	d104      	bne.n	c0d02a1c <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02a12:	f7ff fa0f 	bl	c0d01e34 <pic>
c0d02a16:	4601      	mov	r1, r0
c0d02a18:	4620      	mov	r0, r4
c0d02a1a:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02a1c:	4620      	mov	r0, r4
c0d02a1e:	f000 fc16 	bl	c0d0324e <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02a22:	2001      	movs	r0, #1
c0d02a24:	0201      	lsls	r1, r0, #8
c0d02a26:	1860      	adds	r0, r4, r1
c0d02a28:	5c61      	ldrb	r1, [r4, r1]
c0d02a2a:	2901      	cmp	r1, #1
c0d02a2c:	d101      	bne.n	c0d02a32 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02a2e:	2100      	movs	r1, #0
c0d02a30:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02a32:	2000      	movs	r0, #0
c0d02a34:	b001      	add	sp, #4
c0d02a36:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a38 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02a38:	b5d0      	push	{r4, r6, r7, lr}
c0d02a3a:	af02      	add	r7, sp, #8
c0d02a3c:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02a3e:	2090      	movs	r0, #144	; 0x90
c0d02a40:	2140      	movs	r1, #64	; 0x40
c0d02a42:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02a44:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02a46:	20fc      	movs	r0, #252	; 0xfc
c0d02a48:	2101      	movs	r1, #1
c0d02a4a:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02a4c:	2045      	movs	r0, #69	; 0x45
c0d02a4e:	0080      	lsls	r0, r0, #2
c0d02a50:	5820      	ldr	r0, [r4, r0]
c0d02a52:	2800      	cmp	r0, #0
c0d02a54:	d006      	beq.n	c0d02a64 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02a56:	6840      	ldr	r0, [r0, #4]
c0d02a58:	f7ff f9ec 	bl	c0d01e34 <pic>
c0d02a5c:	4602      	mov	r2, r0
c0d02a5e:	7921      	ldrb	r1, [r4, #4]
c0d02a60:	4620      	mov	r0, r4
c0d02a62:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02a64:	2000      	movs	r0, #0
c0d02a66:	bdd0      	pop	{r4, r6, r7, pc}

c0d02a68 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02a68:	7401      	strb	r1, [r0, #16]
c0d02a6a:	2000      	movs	r0, #0
  return USBD_OK;
c0d02a6c:	4770      	bx	lr

c0d02a6e <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02a6e:	2000      	movs	r0, #0
c0d02a70:	4770      	bx	lr

c0d02a72 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02a72:	2000      	movs	r0, #0
c0d02a74:	4770      	bx	lr

c0d02a76 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02a76:	b5d0      	push	{r4, r6, r7, lr}
c0d02a78:	af02      	add	r7, sp, #8
c0d02a7a:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02a7c:	20fc      	movs	r0, #252	; 0xfc
c0d02a7e:	5c20      	ldrb	r0, [r4, r0]
c0d02a80:	2803      	cmp	r0, #3
c0d02a82:	d10a      	bne.n	c0d02a9a <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02a84:	2045      	movs	r0, #69	; 0x45
c0d02a86:	0080      	lsls	r0, r0, #2
c0d02a88:	5820      	ldr	r0, [r4, r0]
c0d02a8a:	69c0      	ldr	r0, [r0, #28]
c0d02a8c:	2800      	cmp	r0, #0
c0d02a8e:	d004      	beq.n	c0d02a9a <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02a90:	f7ff f9d0 	bl	c0d01e34 <pic>
c0d02a94:	4601      	mov	r1, r0
c0d02a96:	4620      	mov	r0, r4
c0d02a98:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d02a9a:	2000      	movs	r0, #0
c0d02a9c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02aa0 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02aa0:	b5d0      	push	{r4, r6, r7, lr}
c0d02aa2:	af02      	add	r7, sp, #8
c0d02aa4:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02aa6:	7848      	ldrb	r0, [r1, #1]
c0d02aa8:	2809      	cmp	r0, #9
c0d02aaa:	d810      	bhi.n	c0d02ace <USBD_StdDevReq+0x2e>
c0d02aac:	4478      	add	r0, pc
c0d02aae:	7900      	ldrb	r0, [r0, #4]
c0d02ab0:	0040      	lsls	r0, r0, #1
c0d02ab2:	4487      	add	pc, r0
c0d02ab4:	150c0804 	.word	0x150c0804
c0d02ab8:	0c25190c 	.word	0x0c25190c
c0d02abc:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02abe:	4620      	mov	r0, r4
c0d02ac0:	f000 f938 	bl	c0d02d34 <USBD_GetStatus>
c0d02ac4:	e01f      	b.n	c0d02b06 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02ac6:	4620      	mov	r0, r4
c0d02ac8:	f000 f976 	bl	c0d02db8 <USBD_ClrFeature>
c0d02acc:	e01b      	b.n	c0d02b06 <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02ace:	2180      	movs	r1, #128	; 0x80
c0d02ad0:	4620      	mov	r0, r4
c0d02ad2:	f7ff fdc5 	bl	c0d02660 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02ad6:	2100      	movs	r1, #0
c0d02ad8:	4620      	mov	r0, r4
c0d02ada:	f7ff fdc1 	bl	c0d02660 <USBD_LL_StallEP>
c0d02ade:	e012      	b.n	c0d02b06 <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02ae0:	4620      	mov	r0, r4
c0d02ae2:	f000 f950 	bl	c0d02d86 <USBD_SetFeature>
c0d02ae6:	e00e      	b.n	c0d02b06 <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02ae8:	4620      	mov	r0, r4
c0d02aea:	f000 f897 	bl	c0d02c1c <USBD_SetAddress>
c0d02aee:	e00a      	b.n	c0d02b06 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02af0:	4620      	mov	r0, r4
c0d02af2:	f000 f8ff 	bl	c0d02cf4 <USBD_GetConfig>
c0d02af6:	e006      	b.n	c0d02b06 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02af8:	4620      	mov	r0, r4
c0d02afa:	f000 f8bd 	bl	c0d02c78 <USBD_SetConfig>
c0d02afe:	e002      	b.n	c0d02b06 <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02b00:	4620      	mov	r0, r4
c0d02b02:	f000 f803 	bl	c0d02b0c <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02b06:	2000      	movs	r0, #0
c0d02b08:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02b0c <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02b0c:	b5b0      	push	{r4, r5, r7, lr}
c0d02b0e:	af02      	add	r7, sp, #8
c0d02b10:	b082      	sub	sp, #8
c0d02b12:	460d      	mov	r5, r1
c0d02b14:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02b16:	8868      	ldrh	r0, [r5, #2]
c0d02b18:	0a01      	lsrs	r1, r0, #8
c0d02b1a:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02b1c:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02b1e:	2a0e      	cmp	r2, #14
c0d02b20:	d83e      	bhi.n	c0d02ba0 <USBD_GetDescriptor+0x94>
c0d02b22:	46c0      	nop			; (mov r8, r8)
c0d02b24:	447a      	add	r2, pc
c0d02b26:	7912      	ldrb	r2, [r2, #4]
c0d02b28:	0052      	lsls	r2, r2, #1
c0d02b2a:	4497      	add	pc, r2
c0d02b2c:	390c2607 	.word	0x390c2607
c0d02b30:	39362e39 	.word	0x39362e39
c0d02b34:	39393939 	.word	0x39393939
c0d02b38:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02b3c:	2011      	movs	r0, #17
c0d02b3e:	0100      	lsls	r0, r0, #4
c0d02b40:	5820      	ldr	r0, [r4, r0]
c0d02b42:	6800      	ldr	r0, [r0, #0]
c0d02b44:	e012      	b.n	c0d02b6c <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02b46:	b2c0      	uxtb	r0, r0
c0d02b48:	2805      	cmp	r0, #5
c0d02b4a:	d829      	bhi.n	c0d02ba0 <USBD_GetDescriptor+0x94>
c0d02b4c:	4478      	add	r0, pc
c0d02b4e:	7900      	ldrb	r0, [r0, #4]
c0d02b50:	0040      	lsls	r0, r0, #1
c0d02b52:	4487      	add	pc, r0
c0d02b54:	544f4a02 	.word	0x544f4a02
c0d02b58:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02b5a:	2011      	movs	r0, #17
c0d02b5c:	0100      	lsls	r0, r0, #4
c0d02b5e:	5820      	ldr	r0, [r4, r0]
c0d02b60:	6840      	ldr	r0, [r0, #4]
c0d02b62:	e003      	b.n	c0d02b6c <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02b64:	2011      	movs	r0, #17
c0d02b66:	0100      	lsls	r0, r0, #4
c0d02b68:	5820      	ldr	r0, [r4, r0]
c0d02b6a:	69c0      	ldr	r0, [r0, #28]
c0d02b6c:	f7ff f962 	bl	c0d01e34 <pic>
c0d02b70:	4602      	mov	r2, r0
c0d02b72:	7c20      	ldrb	r0, [r4, #16]
c0d02b74:	a901      	add	r1, sp, #4
c0d02b76:	4790      	blx	r2
c0d02b78:	e025      	b.n	c0d02bc6 <USBD_GetDescriptor+0xba>
c0d02b7a:	2045      	movs	r0, #69	; 0x45
c0d02b7c:	0080      	lsls	r0, r0, #2
c0d02b7e:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02b80:	7c21      	ldrb	r1, [r4, #16]
c0d02b82:	2900      	cmp	r1, #0
c0d02b84:	d014      	beq.n	c0d02bb0 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02b86:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02b88:	e018      	b.n	c0d02bbc <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02b8a:	7c20      	ldrb	r0, [r4, #16]
c0d02b8c:	2800      	cmp	r0, #0
c0d02b8e:	d107      	bne.n	c0d02ba0 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02b90:	2045      	movs	r0, #69	; 0x45
c0d02b92:	0080      	lsls	r0, r0, #2
c0d02b94:	5820      	ldr	r0, [r4, r0]
c0d02b96:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02b98:	e010      	b.n	c0d02bbc <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02b9a:	7c20      	ldrb	r0, [r4, #16]
c0d02b9c:	2800      	cmp	r0, #0
c0d02b9e:	d009      	beq.n	c0d02bb4 <USBD_GetDescriptor+0xa8>
c0d02ba0:	4620      	mov	r0, r4
c0d02ba2:	f7ff fd5d 	bl	c0d02660 <USBD_LL_StallEP>
c0d02ba6:	2100      	movs	r1, #0
c0d02ba8:	4620      	mov	r0, r4
c0d02baa:	f7ff fd59 	bl	c0d02660 <USBD_LL_StallEP>
c0d02bae:	e01a      	b.n	c0d02be6 <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02bb0:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02bb2:	e003      	b.n	c0d02bbc <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02bb4:	2045      	movs	r0, #69	; 0x45
c0d02bb6:	0080      	lsls	r0, r0, #2
c0d02bb8:	5820      	ldr	r0, [r4, r0]
c0d02bba:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02bbc:	f7ff f93a 	bl	c0d01e34 <pic>
c0d02bc0:	4601      	mov	r1, r0
c0d02bc2:	a801      	add	r0, sp, #4
c0d02bc4:	4788      	blx	r1
c0d02bc6:	4601      	mov	r1, r0
c0d02bc8:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02bca:	8802      	ldrh	r2, [r0, #0]
c0d02bcc:	2a00      	cmp	r2, #0
c0d02bce:	d00a      	beq.n	c0d02be6 <USBD_GetDescriptor+0xda>
c0d02bd0:	88e8      	ldrh	r0, [r5, #6]
c0d02bd2:	2800      	cmp	r0, #0
c0d02bd4:	d007      	beq.n	c0d02be6 <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02bd6:	4282      	cmp	r2, r0
c0d02bd8:	d300      	bcc.n	c0d02bdc <USBD_GetDescriptor+0xd0>
c0d02bda:	4602      	mov	r2, r0
c0d02bdc:	a801      	add	r0, sp, #4
c0d02bde:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02be0:	4620      	mov	r0, r4
c0d02be2:	f000 faf9 	bl	c0d031d8 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02be6:	b002      	add	sp, #8
c0d02be8:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02bea:	2011      	movs	r0, #17
c0d02bec:	0100      	lsls	r0, r0, #4
c0d02bee:	5820      	ldr	r0, [r4, r0]
c0d02bf0:	6880      	ldr	r0, [r0, #8]
c0d02bf2:	e7bb      	b.n	c0d02b6c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02bf4:	2011      	movs	r0, #17
c0d02bf6:	0100      	lsls	r0, r0, #4
c0d02bf8:	5820      	ldr	r0, [r4, r0]
c0d02bfa:	68c0      	ldr	r0, [r0, #12]
c0d02bfc:	e7b6      	b.n	c0d02b6c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02bfe:	2011      	movs	r0, #17
c0d02c00:	0100      	lsls	r0, r0, #4
c0d02c02:	5820      	ldr	r0, [r4, r0]
c0d02c04:	6900      	ldr	r0, [r0, #16]
c0d02c06:	e7b1      	b.n	c0d02b6c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02c08:	2011      	movs	r0, #17
c0d02c0a:	0100      	lsls	r0, r0, #4
c0d02c0c:	5820      	ldr	r0, [r4, r0]
c0d02c0e:	6940      	ldr	r0, [r0, #20]
c0d02c10:	e7ac      	b.n	c0d02b6c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02c12:	2011      	movs	r0, #17
c0d02c14:	0100      	lsls	r0, r0, #4
c0d02c16:	5820      	ldr	r0, [r4, r0]
c0d02c18:	6980      	ldr	r0, [r0, #24]
c0d02c1a:	e7a7      	b.n	c0d02b6c <USBD_GetDescriptor+0x60>

c0d02c1c <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02c1c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c1e:	af03      	add	r7, sp, #12
c0d02c20:	b081      	sub	sp, #4
c0d02c22:	460a      	mov	r2, r1
c0d02c24:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02c26:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02c28:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02c2a:	2800      	cmp	r0, #0
c0d02c2c:	d10b      	bne.n	c0d02c46 <USBD_SetAddress+0x2a>
c0d02c2e:	88d0      	ldrh	r0, [r2, #6]
c0d02c30:	2800      	cmp	r0, #0
c0d02c32:	d108      	bne.n	c0d02c46 <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02c34:	8850      	ldrh	r0, [r2, #2]
c0d02c36:	267f      	movs	r6, #127	; 0x7f
c0d02c38:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02c3a:	20fc      	movs	r0, #252	; 0xfc
c0d02c3c:	5c20      	ldrb	r0, [r4, r0]
c0d02c3e:	4625      	mov	r5, r4
c0d02c40:	35fc      	adds	r5, #252	; 0xfc
c0d02c42:	2803      	cmp	r0, #3
c0d02c44:	d108      	bne.n	c0d02c58 <USBD_SetAddress+0x3c>
c0d02c46:	4620      	mov	r0, r4
c0d02c48:	f7ff fd0a 	bl	c0d02660 <USBD_LL_StallEP>
c0d02c4c:	2100      	movs	r1, #0
c0d02c4e:	4620      	mov	r0, r4
c0d02c50:	f7ff fd06 	bl	c0d02660 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02c54:	b001      	add	sp, #4
c0d02c56:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02c58:	20fe      	movs	r0, #254	; 0xfe
c0d02c5a:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02c5c:	b2f1      	uxtb	r1, r6
c0d02c5e:	4620      	mov	r0, r4
c0d02c60:	f7ff fd5c 	bl	c0d0271c <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02c64:	4620      	mov	r0, r4
c0d02c66:	f000 fae5 	bl	c0d03234 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02c6a:	2002      	movs	r0, #2
c0d02c6c:	2101      	movs	r1, #1
c0d02c6e:	2e00      	cmp	r6, #0
c0d02c70:	d100      	bne.n	c0d02c74 <USBD_SetAddress+0x58>
c0d02c72:	4608      	mov	r0, r1
c0d02c74:	7028      	strb	r0, [r5, #0]
c0d02c76:	e7ed      	b.n	c0d02c54 <USBD_SetAddress+0x38>

c0d02c78 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02c78:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c7a:	af03      	add	r7, sp, #12
c0d02c7c:	b081      	sub	sp, #4
c0d02c7e:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02c80:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02c82:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02c84:	2e02      	cmp	r6, #2
c0d02c86:	d21d      	bcs.n	c0d02cc4 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02c88:	20fc      	movs	r0, #252	; 0xfc
c0d02c8a:	5c21      	ldrb	r1, [r4, r0]
c0d02c8c:	4620      	mov	r0, r4
c0d02c8e:	30fc      	adds	r0, #252	; 0xfc
c0d02c90:	2903      	cmp	r1, #3
c0d02c92:	d007      	beq.n	c0d02ca4 <USBD_SetConfig+0x2c>
c0d02c94:	2902      	cmp	r1, #2
c0d02c96:	d115      	bne.n	c0d02cc4 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02c98:	2e00      	cmp	r6, #0
c0d02c9a:	d026      	beq.n	c0d02cea <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02c9c:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02c9e:	2103      	movs	r1, #3
c0d02ca0:	7001      	strb	r1, [r0, #0]
c0d02ca2:	e009      	b.n	c0d02cb8 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02ca4:	2e00      	cmp	r6, #0
c0d02ca6:	d016      	beq.n	c0d02cd6 <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02ca8:	6860      	ldr	r0, [r4, #4]
c0d02caa:	4286      	cmp	r6, r0
c0d02cac:	d01d      	beq.n	c0d02cea <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02cae:	b2c1      	uxtb	r1, r0
c0d02cb0:	4620      	mov	r0, r4
c0d02cb2:	f7ff fdd3 	bl	c0d0285c <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02cb6:	6066      	str	r6, [r4, #4]
c0d02cb8:	4620      	mov	r0, r4
c0d02cba:	4631      	mov	r1, r6
c0d02cbc:	f7ff fdb6 	bl	c0d0282c <USBD_SetClassConfig>
c0d02cc0:	2802      	cmp	r0, #2
c0d02cc2:	d112      	bne.n	c0d02cea <USBD_SetConfig+0x72>
c0d02cc4:	4620      	mov	r0, r4
c0d02cc6:	4629      	mov	r1, r5
c0d02cc8:	f7ff fcca 	bl	c0d02660 <USBD_LL_StallEP>
c0d02ccc:	2100      	movs	r1, #0
c0d02cce:	4620      	mov	r0, r4
c0d02cd0:	f7ff fcc6 	bl	c0d02660 <USBD_LL_StallEP>
c0d02cd4:	e00c      	b.n	c0d02cf0 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02cd6:	2102      	movs	r1, #2
c0d02cd8:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02cda:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02cdc:	4620      	mov	r0, r4
c0d02cde:	4631      	mov	r1, r6
c0d02ce0:	f7ff fdbc 	bl	c0d0285c <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02ce4:	4620      	mov	r0, r4
c0d02ce6:	f000 faa5 	bl	c0d03234 <USBD_CtlSendStatus>
c0d02cea:	4620      	mov	r0, r4
c0d02cec:	f000 faa2 	bl	c0d03234 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02cf0:	b001      	add	sp, #4
c0d02cf2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02cf4 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02cf4:	b5d0      	push	{r4, r6, r7, lr}
c0d02cf6:	af02      	add	r7, sp, #8
c0d02cf8:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02cfa:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02cfc:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02cfe:	2801      	cmp	r0, #1
c0d02d00:	d10a      	bne.n	c0d02d18 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02d02:	20fc      	movs	r0, #252	; 0xfc
c0d02d04:	5c20      	ldrb	r0, [r4, r0]
c0d02d06:	2803      	cmp	r0, #3
c0d02d08:	d00e      	beq.n	c0d02d28 <USBD_GetConfig+0x34>
c0d02d0a:	2802      	cmp	r0, #2
c0d02d0c:	d104      	bne.n	c0d02d18 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02d0e:	2000      	movs	r0, #0
c0d02d10:	60a0      	str	r0, [r4, #8]
c0d02d12:	4621      	mov	r1, r4
c0d02d14:	3108      	adds	r1, #8
c0d02d16:	e008      	b.n	c0d02d2a <USBD_GetConfig+0x36>
c0d02d18:	4620      	mov	r0, r4
c0d02d1a:	f7ff fca1 	bl	c0d02660 <USBD_LL_StallEP>
c0d02d1e:	2100      	movs	r1, #0
c0d02d20:	4620      	mov	r0, r4
c0d02d22:	f7ff fc9d 	bl	c0d02660 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02d26:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02d28:	1d21      	adds	r1, r4, #4
c0d02d2a:	2201      	movs	r2, #1
c0d02d2c:	4620      	mov	r0, r4
c0d02d2e:	f000 fa53 	bl	c0d031d8 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02d32:	bdd0      	pop	{r4, r6, r7, pc}

c0d02d34 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02d34:	b5b0      	push	{r4, r5, r7, lr}
c0d02d36:	af02      	add	r7, sp, #8
c0d02d38:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02d3a:	20fc      	movs	r0, #252	; 0xfc
c0d02d3c:	5c20      	ldrb	r0, [r4, r0]
c0d02d3e:	21fe      	movs	r1, #254	; 0xfe
c0d02d40:	4001      	ands	r1, r0
c0d02d42:	2902      	cmp	r1, #2
c0d02d44:	d116      	bne.n	c0d02d74 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02d46:	2001      	movs	r0, #1
c0d02d48:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02d4a:	2041      	movs	r0, #65	; 0x41
c0d02d4c:	0080      	lsls	r0, r0, #2
c0d02d4e:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02d50:	4625      	mov	r5, r4
c0d02d52:	350c      	adds	r5, #12
c0d02d54:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02d56:	2900      	cmp	r1, #0
c0d02d58:	d005      	beq.n	c0d02d66 <USBD_GetStatus+0x32>
c0d02d5a:	4620      	mov	r0, r4
c0d02d5c:	f000 fa77 	bl	c0d0324e <USBD_CtlReceiveStatus>
c0d02d60:	68e1      	ldr	r1, [r4, #12]
c0d02d62:	2002      	movs	r0, #2
c0d02d64:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02d66:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02d68:	2202      	movs	r2, #2
c0d02d6a:	4620      	mov	r0, r4
c0d02d6c:	4629      	mov	r1, r5
c0d02d6e:	f000 fa33 	bl	c0d031d8 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02d72:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d74:	2180      	movs	r1, #128	; 0x80
c0d02d76:	4620      	mov	r0, r4
c0d02d78:	f7ff fc72 	bl	c0d02660 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02d7c:	2100      	movs	r1, #0
c0d02d7e:	4620      	mov	r0, r4
c0d02d80:	f7ff fc6e 	bl	c0d02660 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02d84:	bdb0      	pop	{r4, r5, r7, pc}

c0d02d86 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02d86:	b5b0      	push	{r4, r5, r7, lr}
c0d02d88:	af02      	add	r7, sp, #8
c0d02d8a:	460d      	mov	r5, r1
c0d02d8c:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02d8e:	8868      	ldrh	r0, [r5, #2]
c0d02d90:	2801      	cmp	r0, #1
c0d02d92:	d110      	bne.n	c0d02db6 <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02d94:	2041      	movs	r0, #65	; 0x41
c0d02d96:	0080      	lsls	r0, r0, #2
c0d02d98:	2101      	movs	r1, #1
c0d02d9a:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02d9c:	2045      	movs	r0, #69	; 0x45
c0d02d9e:	0080      	lsls	r0, r0, #2
c0d02da0:	5820      	ldr	r0, [r4, r0]
c0d02da2:	6880      	ldr	r0, [r0, #8]
c0d02da4:	f7ff f846 	bl	c0d01e34 <pic>
c0d02da8:	4602      	mov	r2, r0
c0d02daa:	4620      	mov	r0, r4
c0d02dac:	4629      	mov	r1, r5
c0d02dae:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02db0:	4620      	mov	r0, r4
c0d02db2:	f000 fa3f 	bl	c0d03234 <USBD_CtlSendStatus>
  }

}
c0d02db6:	bdb0      	pop	{r4, r5, r7, pc}

c0d02db8 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02db8:	b5b0      	push	{r4, r5, r7, lr}
c0d02dba:	af02      	add	r7, sp, #8
c0d02dbc:	460d      	mov	r5, r1
c0d02dbe:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02dc0:	20fc      	movs	r0, #252	; 0xfc
c0d02dc2:	5c20      	ldrb	r0, [r4, r0]
c0d02dc4:	21fe      	movs	r1, #254	; 0xfe
c0d02dc6:	4001      	ands	r1, r0
c0d02dc8:	2902      	cmp	r1, #2
c0d02dca:	d114      	bne.n	c0d02df6 <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02dcc:	8868      	ldrh	r0, [r5, #2]
c0d02dce:	2801      	cmp	r0, #1
c0d02dd0:	d119      	bne.n	c0d02e06 <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02dd2:	2041      	movs	r0, #65	; 0x41
c0d02dd4:	0080      	lsls	r0, r0, #2
c0d02dd6:	2100      	movs	r1, #0
c0d02dd8:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02dda:	2045      	movs	r0, #69	; 0x45
c0d02ddc:	0080      	lsls	r0, r0, #2
c0d02dde:	5820      	ldr	r0, [r4, r0]
c0d02de0:	6880      	ldr	r0, [r0, #8]
c0d02de2:	f7ff f827 	bl	c0d01e34 <pic>
c0d02de6:	4602      	mov	r2, r0
c0d02de8:	4620      	mov	r0, r4
c0d02dea:	4629      	mov	r1, r5
c0d02dec:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d02dee:	4620      	mov	r0, r4
c0d02df0:	f000 fa20 	bl	c0d03234 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02df4:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02df6:	2180      	movs	r1, #128	; 0x80
c0d02df8:	4620      	mov	r0, r4
c0d02dfa:	f7ff fc31 	bl	c0d02660 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02dfe:	2100      	movs	r1, #0
c0d02e00:	4620      	mov	r0, r4
c0d02e02:	f7ff fc2d 	bl	c0d02660 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02e06:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e08 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02e08:	b5d0      	push	{r4, r6, r7, lr}
c0d02e0a:	af02      	add	r7, sp, #8
c0d02e0c:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e0e:	2180      	movs	r1, #128	; 0x80
c0d02e10:	f7ff fc26 	bl	c0d02660 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02e14:	2100      	movs	r1, #0
c0d02e16:	4620      	mov	r0, r4
c0d02e18:	f7ff fc22 	bl	c0d02660 <USBD_LL_StallEP>
}
c0d02e1c:	bdd0      	pop	{r4, r6, r7, pc}

c0d02e1e <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02e1e:	b5b0      	push	{r4, r5, r7, lr}
c0d02e20:	af02      	add	r7, sp, #8
c0d02e22:	460d      	mov	r5, r1
c0d02e24:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02e26:	20fc      	movs	r0, #252	; 0xfc
c0d02e28:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e2a:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02e2c:	2803      	cmp	r0, #3
c0d02e2e:	d115      	bne.n	c0d02e5c <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02e30:	88a8      	ldrh	r0, [r5, #4]
c0d02e32:	22fe      	movs	r2, #254	; 0xfe
c0d02e34:	4002      	ands	r2, r0
c0d02e36:	2a01      	cmp	r2, #1
c0d02e38:	d810      	bhi.n	c0d02e5c <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d02e3a:	2045      	movs	r0, #69	; 0x45
c0d02e3c:	0080      	lsls	r0, r0, #2
c0d02e3e:	5820      	ldr	r0, [r4, r0]
c0d02e40:	6880      	ldr	r0, [r0, #8]
c0d02e42:	f7fe fff7 	bl	c0d01e34 <pic>
c0d02e46:	4602      	mov	r2, r0
c0d02e48:	4620      	mov	r0, r4
c0d02e4a:	4629      	mov	r1, r5
c0d02e4c:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02e4e:	88e8      	ldrh	r0, [r5, #6]
c0d02e50:	2800      	cmp	r0, #0
c0d02e52:	d10a      	bne.n	c0d02e6a <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02e54:	4620      	mov	r0, r4
c0d02e56:	f000 f9ed 	bl	c0d03234 <USBD_CtlSendStatus>
c0d02e5a:	e006      	b.n	c0d02e6a <USBD_StdItfReq+0x4c>
c0d02e5c:	4620      	mov	r0, r4
c0d02e5e:	f7ff fbff 	bl	c0d02660 <USBD_LL_StallEP>
c0d02e62:	2100      	movs	r1, #0
c0d02e64:	4620      	mov	r0, r4
c0d02e66:	f7ff fbfb 	bl	c0d02660 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02e6a:	2000      	movs	r0, #0
c0d02e6c:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e6e <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02e6e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02e70:	af03      	add	r7, sp, #12
c0d02e72:	b081      	sub	sp, #4
c0d02e74:	460e      	mov	r6, r1
c0d02e76:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02e78:	7830      	ldrb	r0, [r6, #0]
c0d02e7a:	2160      	movs	r1, #96	; 0x60
c0d02e7c:	4001      	ands	r1, r0
c0d02e7e:	2920      	cmp	r1, #32
c0d02e80:	d10a      	bne.n	c0d02e98 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02e82:	2045      	movs	r0, #69	; 0x45
c0d02e84:	0080      	lsls	r0, r0, #2
c0d02e86:	5820      	ldr	r0, [r4, r0]
c0d02e88:	6880      	ldr	r0, [r0, #8]
c0d02e8a:	f7fe ffd3 	bl	c0d01e34 <pic>
c0d02e8e:	4602      	mov	r2, r0
c0d02e90:	4620      	mov	r0, r4
c0d02e92:	4631      	mov	r1, r6
c0d02e94:	4790      	blx	r2
c0d02e96:	e063      	b.n	c0d02f60 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02e98:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02e9a:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e9c:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02e9e:	2800      	cmp	r0, #0
c0d02ea0:	d012      	beq.n	c0d02ec8 <USBD_StdEPReq+0x5a>
c0d02ea2:	2801      	cmp	r0, #1
c0d02ea4:	d019      	beq.n	c0d02eda <USBD_StdEPReq+0x6c>
c0d02ea6:	2803      	cmp	r0, #3
c0d02ea8:	d15a      	bne.n	c0d02f60 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02eaa:	20fc      	movs	r0, #252	; 0xfc
c0d02eac:	5c20      	ldrb	r0, [r4, r0]
c0d02eae:	2803      	cmp	r0, #3
c0d02eb0:	d117      	bne.n	c0d02ee2 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02eb2:	8870      	ldrh	r0, [r6, #2]
c0d02eb4:	2800      	cmp	r0, #0
c0d02eb6:	d12d      	bne.n	c0d02f14 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02eb8:	4329      	orrs	r1, r5
c0d02eba:	2980      	cmp	r1, #128	; 0x80
c0d02ebc:	d02a      	beq.n	c0d02f14 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02ebe:	4620      	mov	r0, r4
c0d02ec0:	4629      	mov	r1, r5
c0d02ec2:	f7ff fbcd 	bl	c0d02660 <USBD_LL_StallEP>
c0d02ec6:	e025      	b.n	c0d02f14 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02ec8:	20fc      	movs	r0, #252	; 0xfc
c0d02eca:	5c20      	ldrb	r0, [r4, r0]
c0d02ecc:	2803      	cmp	r0, #3
c0d02ece:	d02f      	beq.n	c0d02f30 <USBD_StdEPReq+0xc2>
c0d02ed0:	2802      	cmp	r0, #2
c0d02ed2:	d10e      	bne.n	c0d02ef2 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02ed4:	0668      	lsls	r0, r5, #25
c0d02ed6:	d109      	bne.n	c0d02eec <USBD_StdEPReq+0x7e>
c0d02ed8:	e042      	b.n	c0d02f60 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d02eda:	20fc      	movs	r0, #252	; 0xfc
c0d02edc:	5c20      	ldrb	r0, [r4, r0]
c0d02ede:	2803      	cmp	r0, #3
c0d02ee0:	d00f      	beq.n	c0d02f02 <USBD_StdEPReq+0x94>
c0d02ee2:	2802      	cmp	r0, #2
c0d02ee4:	d105      	bne.n	c0d02ef2 <USBD_StdEPReq+0x84>
c0d02ee6:	4329      	orrs	r1, r5
c0d02ee8:	2980      	cmp	r1, #128	; 0x80
c0d02eea:	d039      	beq.n	c0d02f60 <USBD_StdEPReq+0xf2>
c0d02eec:	4620      	mov	r0, r4
c0d02eee:	4629      	mov	r1, r5
c0d02ef0:	e004      	b.n	c0d02efc <USBD_StdEPReq+0x8e>
c0d02ef2:	4620      	mov	r0, r4
c0d02ef4:	f7ff fbb4 	bl	c0d02660 <USBD_LL_StallEP>
c0d02ef8:	2100      	movs	r1, #0
c0d02efa:	4620      	mov	r0, r4
c0d02efc:	f7ff fbb0 	bl	c0d02660 <USBD_LL_StallEP>
c0d02f00:	e02e      	b.n	c0d02f60 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02f02:	8870      	ldrh	r0, [r6, #2]
c0d02f04:	2800      	cmp	r0, #0
c0d02f06:	d12b      	bne.n	c0d02f60 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d02f08:	0668      	lsls	r0, r5, #25
c0d02f0a:	d00d      	beq.n	c0d02f28 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d02f0c:	4620      	mov	r0, r4
c0d02f0e:	4629      	mov	r1, r5
c0d02f10:	f7ff fbcc 	bl	c0d026ac <USBD_LL_ClearStallEP>
c0d02f14:	2045      	movs	r0, #69	; 0x45
c0d02f16:	0080      	lsls	r0, r0, #2
c0d02f18:	5820      	ldr	r0, [r4, r0]
c0d02f1a:	6880      	ldr	r0, [r0, #8]
c0d02f1c:	f7fe ff8a 	bl	c0d01e34 <pic>
c0d02f20:	4602      	mov	r2, r0
c0d02f22:	4620      	mov	r0, r4
c0d02f24:	4631      	mov	r1, r6
c0d02f26:	4790      	blx	r2
c0d02f28:	4620      	mov	r0, r4
c0d02f2a:	f000 f983 	bl	c0d03234 <USBD_CtlSendStatus>
c0d02f2e:	e017      	b.n	c0d02f60 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02f30:	4626      	mov	r6, r4
c0d02f32:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d02f34:	4620      	mov	r0, r4
c0d02f36:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02f38:	420d      	tst	r5, r1
c0d02f3a:	d100      	bne.n	c0d02f3e <USBD_StdEPReq+0xd0>
c0d02f3c:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d02f3e:	4620      	mov	r0, r4
c0d02f40:	4629      	mov	r1, r5
c0d02f42:	f7ff fbd9 	bl	c0d026f8 <USBD_LL_IsStallEP>
c0d02f46:	2101      	movs	r1, #1
c0d02f48:	2800      	cmp	r0, #0
c0d02f4a:	d100      	bne.n	c0d02f4e <USBD_StdEPReq+0xe0>
c0d02f4c:	4601      	mov	r1, r0
c0d02f4e:	207f      	movs	r0, #127	; 0x7f
c0d02f50:	4005      	ands	r5, r0
c0d02f52:	0128      	lsls	r0, r5, #4
c0d02f54:	5031      	str	r1, [r6, r0]
c0d02f56:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d02f58:	2202      	movs	r2, #2
c0d02f5a:	4620      	mov	r0, r4
c0d02f5c:	f000 f93c 	bl	c0d031d8 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d02f60:	2000      	movs	r0, #0
c0d02f62:	b001      	add	sp, #4
c0d02f64:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02f66 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d02f66:	780a      	ldrb	r2, [r1, #0]
c0d02f68:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02f6a:	784a      	ldrb	r2, [r1, #1]
c0d02f6c:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02f6e:	788a      	ldrb	r2, [r1, #2]
c0d02f70:	78cb      	ldrb	r3, [r1, #3]
c0d02f72:	021b      	lsls	r3, r3, #8
c0d02f74:	4313      	orrs	r3, r2
c0d02f76:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02f78:	790a      	ldrb	r2, [r1, #4]
c0d02f7a:	794b      	ldrb	r3, [r1, #5]
c0d02f7c:	021b      	lsls	r3, r3, #8
c0d02f7e:	4313      	orrs	r3, r2
c0d02f80:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02f82:	798a      	ldrb	r2, [r1, #6]
c0d02f84:	79c9      	ldrb	r1, [r1, #7]
c0d02f86:	0209      	lsls	r1, r1, #8
c0d02f88:	4311      	orrs	r1, r2
c0d02f8a:	80c1      	strh	r1, [r0, #6]

}
c0d02f8c:	4770      	bx	lr

c0d02f8e <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02f8e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02f90:	af03      	add	r7, sp, #12
c0d02f92:	b083      	sub	sp, #12
c0d02f94:	460d      	mov	r5, r1
c0d02f96:	4604      	mov	r4, r0
c0d02f98:	a802      	add	r0, sp, #8
c0d02f9a:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d02f9c:	8006      	strh	r6, [r0, #0]
c0d02f9e:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02fa0:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02fa2:	7829      	ldrb	r1, [r5, #0]
c0d02fa4:	2060      	movs	r0, #96	; 0x60
c0d02fa6:	4008      	ands	r0, r1
c0d02fa8:	2800      	cmp	r0, #0
c0d02faa:	d010      	beq.n	c0d02fce <USBD_HID_Setup+0x40>
c0d02fac:	2820      	cmp	r0, #32
c0d02fae:	d139      	bne.n	c0d03024 <USBD_HID_Setup+0x96>
c0d02fb0:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02fb2:	4601      	mov	r1, r0
c0d02fb4:	390a      	subs	r1, #10
c0d02fb6:	2902      	cmp	r1, #2
c0d02fb8:	d334      	bcc.n	c0d03024 <USBD_HID_Setup+0x96>
c0d02fba:	2802      	cmp	r0, #2
c0d02fbc:	d01c      	beq.n	c0d02ff8 <USBD_HID_Setup+0x6a>
c0d02fbe:	2803      	cmp	r0, #3
c0d02fc0:	d01a      	beq.n	c0d02ff8 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02fc2:	4620      	mov	r0, r4
c0d02fc4:	4629      	mov	r1, r5
c0d02fc6:	f7ff ff1f 	bl	c0d02e08 <USBD_CtlError>
c0d02fca:	2602      	movs	r6, #2
c0d02fcc:	e02a      	b.n	c0d03024 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d02fce:	7868      	ldrb	r0, [r5, #1]
c0d02fd0:	280b      	cmp	r0, #11
c0d02fd2:	d014      	beq.n	c0d02ffe <USBD_HID_Setup+0x70>
c0d02fd4:	280a      	cmp	r0, #10
c0d02fd6:	d00f      	beq.n	c0d02ff8 <USBD_HID_Setup+0x6a>
c0d02fd8:	2806      	cmp	r0, #6
c0d02fda:	d123      	bne.n	c0d03024 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d02fdc:	8868      	ldrh	r0, [r5, #2]
c0d02fde:	0a00      	lsrs	r0, r0, #8
c0d02fe0:	2600      	movs	r6, #0
c0d02fe2:	2821      	cmp	r0, #33	; 0x21
c0d02fe4:	d00f      	beq.n	c0d03006 <USBD_HID_Setup+0x78>
c0d02fe6:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02fe8:	4632      	mov	r2, r6
c0d02fea:	4631      	mov	r1, r6
c0d02fec:	d117      	bne.n	c0d0301e <USBD_HID_Setup+0x90>
c0d02fee:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02ff0:	9000      	str	r0, [sp, #0]
c0d02ff2:	f000 f847 	bl	c0d03084 <USBD_HID_GetReportDescriptor_impl>
c0d02ff6:	e00a      	b.n	c0d0300e <USBD_HID_Setup+0x80>
c0d02ff8:	a901      	add	r1, sp, #4
c0d02ffa:	2201      	movs	r2, #1
c0d02ffc:	e00f      	b.n	c0d0301e <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d02ffe:	4620      	mov	r0, r4
c0d03000:	f000 f918 	bl	c0d03234 <USBD_CtlSendStatus>
c0d03004:	e00e      	b.n	c0d03024 <USBD_HID_Setup+0x96>
c0d03006:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d03008:	9000      	str	r0, [sp, #0]
c0d0300a:	f000 f833 	bl	c0d03074 <USBD_HID_GetHidDescriptor_impl>
c0d0300e:	9b00      	ldr	r3, [sp, #0]
c0d03010:	4601      	mov	r1, r0
c0d03012:	881a      	ldrh	r2, [r3, #0]
c0d03014:	88e8      	ldrh	r0, [r5, #6]
c0d03016:	4282      	cmp	r2, r0
c0d03018:	d300      	bcc.n	c0d0301c <USBD_HID_Setup+0x8e>
c0d0301a:	4602      	mov	r2, r0
c0d0301c:	801a      	strh	r2, [r3, #0]
c0d0301e:	4620      	mov	r0, r4
c0d03020:	f000 f8da 	bl	c0d031d8 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d03024:	b2f0      	uxtb	r0, r6
c0d03026:	b003      	add	sp, #12
c0d03028:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0302a <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d0302a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0302c:	af03      	add	r7, sp, #12
c0d0302e:	b081      	sub	sp, #4
c0d03030:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d03032:	2182      	movs	r1, #130	; 0x82
c0d03034:	2502      	movs	r5, #2
c0d03036:	2640      	movs	r6, #64	; 0x40
c0d03038:	462a      	mov	r2, r5
c0d0303a:	4633      	mov	r3, r6
c0d0303c:	f7ff fad0 	bl	c0d025e0 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d03040:	4620      	mov	r0, r4
c0d03042:	4629      	mov	r1, r5
c0d03044:	462a      	mov	r2, r5
c0d03046:	4633      	mov	r3, r6
c0d03048:	f7ff faca 	bl	c0d025e0 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d0304c:	4620      	mov	r0, r4
c0d0304e:	4629      	mov	r1, r5
c0d03050:	4632      	mov	r2, r6
c0d03052:	f7ff fb90 	bl	c0d02776 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d03056:	2000      	movs	r0, #0
c0d03058:	b001      	add	sp, #4
c0d0305a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0305c <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d0305c:	b5d0      	push	{r4, r6, r7, lr}
c0d0305e:	af02      	add	r7, sp, #8
c0d03060:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d03062:	2182      	movs	r1, #130	; 0x82
c0d03064:	f7ff fae4 	bl	c0d02630 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d03068:	2102      	movs	r1, #2
c0d0306a:	4620      	mov	r0, r4
c0d0306c:	f7ff fae0 	bl	c0d02630 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d03070:	2000      	movs	r0, #0
c0d03072:	bdd0      	pop	{r4, r6, r7, pc}

c0d03074 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d03074:	2109      	movs	r1, #9
c0d03076:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d03078:	4801      	ldr	r0, [pc, #4]	; (c0d03080 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d0307a:	4478      	add	r0, pc
c0d0307c:	4770      	bx	lr
c0d0307e:	46c0      	nop			; (mov r8, r8)
c0d03080:	00000bca 	.word	0x00000bca

c0d03084 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d03084:	2122      	movs	r1, #34	; 0x22
c0d03086:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d03088:	4801      	ldr	r0, [pc, #4]	; (c0d03090 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d0308a:	4478      	add	r0, pc
c0d0308c:	4770      	bx	lr
c0d0308e:	46c0      	nop			; (mov r8, r8)
c0d03090:	00000b95 	.word	0x00000b95

c0d03094 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d03094:	b5b0      	push	{r4, r5, r7, lr}
c0d03096:	af02      	add	r7, sp, #8
c0d03098:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d0309a:	2102      	movs	r1, #2
c0d0309c:	2240      	movs	r2, #64	; 0x40
c0d0309e:	f7ff fb6a 	bl	c0d02776 <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d030a2:	4d0d      	ldr	r5, [pc, #52]	; (c0d030d8 <USBD_HID_DataOut_impl+0x44>)
c0d030a4:	7828      	ldrb	r0, [r5, #0]
c0d030a6:	2800      	cmp	r0, #0
c0d030a8:	d113      	bne.n	c0d030d2 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d030aa:	2002      	movs	r0, #2
c0d030ac:	f7fe f928 	bl	c0d01300 <io_seproxyhal_get_ep_rx_size>
c0d030b0:	4602      	mov	r2, r0
c0d030b2:	480d      	ldr	r0, [pc, #52]	; (c0d030e8 <USBD_HID_DataOut_impl+0x54>)
c0d030b4:	4478      	add	r0, pc
c0d030b6:	4621      	mov	r1, r4
c0d030b8:	f7fd ff86 	bl	c0d00fc8 <io_usb_hid_receive>
c0d030bc:	2802      	cmp	r0, #2
c0d030be:	d108      	bne.n	c0d030d2 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d030c0:	2001      	movs	r0, #1
c0d030c2:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d030c4:	4805      	ldr	r0, [pc, #20]	; (c0d030dc <USBD_HID_DataOut_impl+0x48>)
c0d030c6:	2107      	movs	r1, #7
c0d030c8:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d030ca:	4805      	ldr	r0, [pc, #20]	; (c0d030e0 <USBD_HID_DataOut_impl+0x4c>)
c0d030cc:	6800      	ldr	r0, [r0, #0]
c0d030ce:	4905      	ldr	r1, [pc, #20]	; (c0d030e4 <USBD_HID_DataOut_impl+0x50>)
c0d030d0:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d030d2:	2000      	movs	r0, #0
c0d030d4:	bdb0      	pop	{r4, r5, r7, pc}
c0d030d6:	46c0      	nop			; (mov r8, r8)
c0d030d8:	20001d10 	.word	0x20001d10
c0d030dc:	20001d18 	.word	0x20001d18
c0d030e0:	20001c00 	.word	0x20001c00
c0d030e4:	20001d1c 	.word	0x20001d1c
c0d030e8:	ffffe3a1 	.word	0xffffe3a1

c0d030ec <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d030ec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d030ee:	af03      	add	r7, sp, #12
c0d030f0:	b081      	sub	sp, #4
c0d030f2:	4604      	mov	r4, r0
c0d030f4:	2049      	movs	r0, #73	; 0x49
c0d030f6:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d030f8:	4810      	ldr	r0, [pc, #64]	; (c0d0313c <USB_power+0x50>)
c0d030fa:	2100      	movs	r1, #0
c0d030fc:	462a      	mov	r2, r5
c0d030fe:	f7fe f80f 	bl	c0d01120 <os_memset>

  if (enabled) {
c0d03102:	2c00      	cmp	r4, #0
c0d03104:	d015      	beq.n	c0d03132 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d03106:	4c0d      	ldr	r4, [pc, #52]	; (c0d0313c <USB_power+0x50>)
c0d03108:	2600      	movs	r6, #0
c0d0310a:	4620      	mov	r0, r4
c0d0310c:	4631      	mov	r1, r6
c0d0310e:	462a      	mov	r2, r5
c0d03110:	f7fe f806 	bl	c0d01120 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d03114:	490a      	ldr	r1, [pc, #40]	; (c0d03140 <USB_power+0x54>)
c0d03116:	4479      	add	r1, pc
c0d03118:	4620      	mov	r0, r4
c0d0311a:	4632      	mov	r2, r6
c0d0311c:	f7ff fb3f 	bl	c0d0279e <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d03120:	4908      	ldr	r1, [pc, #32]	; (c0d03144 <USB_power+0x58>)
c0d03122:	4479      	add	r1, pc
c0d03124:	4620      	mov	r0, r4
c0d03126:	f7ff fb72 	bl	c0d0280e <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d0312a:	4620      	mov	r0, r4
c0d0312c:	f7ff fb78 	bl	c0d02820 <USBD_Start>
c0d03130:	e002      	b.n	c0d03138 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d03132:	4802      	ldr	r0, [pc, #8]	; (c0d0313c <USB_power+0x50>)
c0d03134:	f7ff fb51 	bl	c0d027da <USBD_DeInit>
  }
}
c0d03138:	b001      	add	sp, #4
c0d0313a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0313c:	20001d34 	.word	0x20001d34
c0d03140:	00000b4a 	.word	0x00000b4a
c0d03144:	00000b7a 	.word	0x00000b7a

c0d03148 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d03148:	2012      	movs	r0, #18
c0d0314a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d0314c:	4801      	ldr	r0, [pc, #4]	; (c0d03154 <USBD_DeviceDescriptor+0xc>)
c0d0314e:	4478      	add	r0, pc
c0d03150:	4770      	bx	lr
c0d03152:	46c0      	nop			; (mov r8, r8)
c0d03154:	00000aff 	.word	0x00000aff

c0d03158 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d03158:	2004      	movs	r0, #4
c0d0315a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d0315c:	4801      	ldr	r0, [pc, #4]	; (c0d03164 <USBD_LangIDStrDescriptor+0xc>)
c0d0315e:	4478      	add	r0, pc
c0d03160:	4770      	bx	lr
c0d03162:	46c0      	nop			; (mov r8, r8)
c0d03164:	00000b22 	.word	0x00000b22

c0d03168 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d03168:	200e      	movs	r0, #14
c0d0316a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d0316c:	4801      	ldr	r0, [pc, #4]	; (c0d03174 <USBD_ManufacturerStrDescriptor+0xc>)
c0d0316e:	4478      	add	r0, pc
c0d03170:	4770      	bx	lr
c0d03172:	46c0      	nop			; (mov r8, r8)
c0d03174:	00000b16 	.word	0x00000b16

c0d03178 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d03178:	200e      	movs	r0, #14
c0d0317a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d0317c:	4801      	ldr	r0, [pc, #4]	; (c0d03184 <USBD_ProductStrDescriptor+0xc>)
c0d0317e:	4478      	add	r0, pc
c0d03180:	4770      	bx	lr
c0d03182:	46c0      	nop			; (mov r8, r8)
c0d03184:	00000a93 	.word	0x00000a93

c0d03188 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d03188:	200a      	movs	r0, #10
c0d0318a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d0318c:	4801      	ldr	r0, [pc, #4]	; (c0d03194 <USBD_SerialStrDescriptor+0xc>)
c0d0318e:	4478      	add	r0, pc
c0d03190:	4770      	bx	lr
c0d03192:	46c0      	nop			; (mov r8, r8)
c0d03194:	00000b04 	.word	0x00000b04

c0d03198 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d03198:	200e      	movs	r0, #14
c0d0319a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d0319c:	4801      	ldr	r0, [pc, #4]	; (c0d031a4 <USBD_ConfigStrDescriptor+0xc>)
c0d0319e:	4478      	add	r0, pc
c0d031a0:	4770      	bx	lr
c0d031a2:	46c0      	nop			; (mov r8, r8)
c0d031a4:	00000a73 	.word	0x00000a73

c0d031a8 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d031a8:	200e      	movs	r0, #14
c0d031aa:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d031ac:	4801      	ldr	r0, [pc, #4]	; (c0d031b4 <USBD_InterfaceStrDescriptor+0xc>)
c0d031ae:	4478      	add	r0, pc
c0d031b0:	4770      	bx	lr
c0d031b2:	46c0      	nop			; (mov r8, r8)
c0d031b4:	00000a63 	.word	0x00000a63

c0d031b8 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d031b8:	2129      	movs	r1, #41	; 0x29
c0d031ba:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d031bc:	4801      	ldr	r0, [pc, #4]	; (c0d031c4 <USBD_GetCfgDesc_impl+0xc>)
c0d031be:	4478      	add	r0, pc
c0d031c0:	4770      	bx	lr
c0d031c2:	46c0      	nop			; (mov r8, r8)
c0d031c4:	00000b16 	.word	0x00000b16

c0d031c8 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d031c8:	210a      	movs	r1, #10
c0d031ca:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d031cc:	4801      	ldr	r0, [pc, #4]	; (c0d031d4 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d031ce:	4478      	add	r0, pc
c0d031d0:	4770      	bx	lr
c0d031d2:	46c0      	nop			; (mov r8, r8)
c0d031d4:	00000b32 	.word	0x00000b32

c0d031d8 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d031d8:	b5b0      	push	{r4, r5, r7, lr}
c0d031da:	af02      	add	r7, sp, #8
c0d031dc:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d031de:	21f4      	movs	r1, #244	; 0xf4
c0d031e0:	2302      	movs	r3, #2
c0d031e2:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d031e4:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d031e6:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d031e8:	2109      	movs	r1, #9
c0d031ea:	0149      	lsls	r1, r1, #5
c0d031ec:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d031ee:	6a01      	ldr	r1, [r0, #32]
c0d031f0:	428a      	cmp	r2, r1
c0d031f2:	d300      	bcc.n	c0d031f6 <USBD_CtlSendData+0x1e>
c0d031f4:	460a      	mov	r2, r1
c0d031f6:	b293      	uxth	r3, r2
c0d031f8:	2500      	movs	r5, #0
c0d031fa:	4629      	mov	r1, r5
c0d031fc:	4622      	mov	r2, r4
c0d031fe:	f7ff faa0 	bl	c0d02742 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03202:	4628      	mov	r0, r5
c0d03204:	bdb0      	pop	{r4, r5, r7, pc}

c0d03206 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d03206:	b5b0      	push	{r4, r5, r7, lr}
c0d03208:	af02      	add	r7, sp, #8
c0d0320a:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d0320c:	6a01      	ldr	r1, [r0, #32]
c0d0320e:	428a      	cmp	r2, r1
c0d03210:	d300      	bcc.n	c0d03214 <USBD_CtlContinueSendData+0xe>
c0d03212:	460a      	mov	r2, r1
c0d03214:	b293      	uxth	r3, r2
c0d03216:	2500      	movs	r5, #0
c0d03218:	4629      	mov	r1, r5
c0d0321a:	4622      	mov	r2, r4
c0d0321c:	f7ff fa91 	bl	c0d02742 <USBD_LL_Transmit>
  return USBD_OK;
c0d03220:	4628      	mov	r0, r5
c0d03222:	bdb0      	pop	{r4, r5, r7, pc}

c0d03224 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d03224:	b5d0      	push	{r4, r6, r7, lr}
c0d03226:	af02      	add	r7, sp, #8
c0d03228:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d0322a:	4621      	mov	r1, r4
c0d0322c:	f7ff faa3 	bl	c0d02776 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d03230:	4620      	mov	r0, r4
c0d03232:	bdd0      	pop	{r4, r6, r7, pc}

c0d03234 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d03234:	b5d0      	push	{r4, r6, r7, lr}
c0d03236:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d03238:	21f4      	movs	r1, #244	; 0xf4
c0d0323a:	2204      	movs	r2, #4
c0d0323c:	5042      	str	r2, [r0, r1]
c0d0323e:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d03240:	4621      	mov	r1, r4
c0d03242:	4622      	mov	r2, r4
c0d03244:	4623      	mov	r3, r4
c0d03246:	f7ff fa7c 	bl	c0d02742 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d0324a:	4620      	mov	r0, r4
c0d0324c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0324e <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d0324e:	b5d0      	push	{r4, r6, r7, lr}
c0d03250:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d03252:	21f4      	movs	r1, #244	; 0xf4
c0d03254:	2205      	movs	r2, #5
c0d03256:	5042      	str	r2, [r0, r1]
c0d03258:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d0325a:	4621      	mov	r1, r4
c0d0325c:	4622      	mov	r2, r4
c0d0325e:	f7ff fa8a 	bl	c0d02776 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d03262:	4620      	mov	r0, r4
c0d03264:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d03268 <__aeabi_uidiv>:
c0d03268:	2200      	movs	r2, #0
c0d0326a:	0843      	lsrs	r3, r0, #1
c0d0326c:	428b      	cmp	r3, r1
c0d0326e:	d374      	bcc.n	c0d0335a <__aeabi_uidiv+0xf2>
c0d03270:	0903      	lsrs	r3, r0, #4
c0d03272:	428b      	cmp	r3, r1
c0d03274:	d35f      	bcc.n	c0d03336 <__aeabi_uidiv+0xce>
c0d03276:	0a03      	lsrs	r3, r0, #8
c0d03278:	428b      	cmp	r3, r1
c0d0327a:	d344      	bcc.n	c0d03306 <__aeabi_uidiv+0x9e>
c0d0327c:	0b03      	lsrs	r3, r0, #12
c0d0327e:	428b      	cmp	r3, r1
c0d03280:	d328      	bcc.n	c0d032d4 <__aeabi_uidiv+0x6c>
c0d03282:	0c03      	lsrs	r3, r0, #16
c0d03284:	428b      	cmp	r3, r1
c0d03286:	d30d      	bcc.n	c0d032a4 <__aeabi_uidiv+0x3c>
c0d03288:	22ff      	movs	r2, #255	; 0xff
c0d0328a:	0209      	lsls	r1, r1, #8
c0d0328c:	ba12      	rev	r2, r2
c0d0328e:	0c03      	lsrs	r3, r0, #16
c0d03290:	428b      	cmp	r3, r1
c0d03292:	d302      	bcc.n	c0d0329a <__aeabi_uidiv+0x32>
c0d03294:	1212      	asrs	r2, r2, #8
c0d03296:	0209      	lsls	r1, r1, #8
c0d03298:	d065      	beq.n	c0d03366 <__aeabi_uidiv+0xfe>
c0d0329a:	0b03      	lsrs	r3, r0, #12
c0d0329c:	428b      	cmp	r3, r1
c0d0329e:	d319      	bcc.n	c0d032d4 <__aeabi_uidiv+0x6c>
c0d032a0:	e000      	b.n	c0d032a4 <__aeabi_uidiv+0x3c>
c0d032a2:	0a09      	lsrs	r1, r1, #8
c0d032a4:	0bc3      	lsrs	r3, r0, #15
c0d032a6:	428b      	cmp	r3, r1
c0d032a8:	d301      	bcc.n	c0d032ae <__aeabi_uidiv+0x46>
c0d032aa:	03cb      	lsls	r3, r1, #15
c0d032ac:	1ac0      	subs	r0, r0, r3
c0d032ae:	4152      	adcs	r2, r2
c0d032b0:	0b83      	lsrs	r3, r0, #14
c0d032b2:	428b      	cmp	r3, r1
c0d032b4:	d301      	bcc.n	c0d032ba <__aeabi_uidiv+0x52>
c0d032b6:	038b      	lsls	r3, r1, #14
c0d032b8:	1ac0      	subs	r0, r0, r3
c0d032ba:	4152      	adcs	r2, r2
c0d032bc:	0b43      	lsrs	r3, r0, #13
c0d032be:	428b      	cmp	r3, r1
c0d032c0:	d301      	bcc.n	c0d032c6 <__aeabi_uidiv+0x5e>
c0d032c2:	034b      	lsls	r3, r1, #13
c0d032c4:	1ac0      	subs	r0, r0, r3
c0d032c6:	4152      	adcs	r2, r2
c0d032c8:	0b03      	lsrs	r3, r0, #12
c0d032ca:	428b      	cmp	r3, r1
c0d032cc:	d301      	bcc.n	c0d032d2 <__aeabi_uidiv+0x6a>
c0d032ce:	030b      	lsls	r3, r1, #12
c0d032d0:	1ac0      	subs	r0, r0, r3
c0d032d2:	4152      	adcs	r2, r2
c0d032d4:	0ac3      	lsrs	r3, r0, #11
c0d032d6:	428b      	cmp	r3, r1
c0d032d8:	d301      	bcc.n	c0d032de <__aeabi_uidiv+0x76>
c0d032da:	02cb      	lsls	r3, r1, #11
c0d032dc:	1ac0      	subs	r0, r0, r3
c0d032de:	4152      	adcs	r2, r2
c0d032e0:	0a83      	lsrs	r3, r0, #10
c0d032e2:	428b      	cmp	r3, r1
c0d032e4:	d301      	bcc.n	c0d032ea <__aeabi_uidiv+0x82>
c0d032e6:	028b      	lsls	r3, r1, #10
c0d032e8:	1ac0      	subs	r0, r0, r3
c0d032ea:	4152      	adcs	r2, r2
c0d032ec:	0a43      	lsrs	r3, r0, #9
c0d032ee:	428b      	cmp	r3, r1
c0d032f0:	d301      	bcc.n	c0d032f6 <__aeabi_uidiv+0x8e>
c0d032f2:	024b      	lsls	r3, r1, #9
c0d032f4:	1ac0      	subs	r0, r0, r3
c0d032f6:	4152      	adcs	r2, r2
c0d032f8:	0a03      	lsrs	r3, r0, #8
c0d032fa:	428b      	cmp	r3, r1
c0d032fc:	d301      	bcc.n	c0d03302 <__aeabi_uidiv+0x9a>
c0d032fe:	020b      	lsls	r3, r1, #8
c0d03300:	1ac0      	subs	r0, r0, r3
c0d03302:	4152      	adcs	r2, r2
c0d03304:	d2cd      	bcs.n	c0d032a2 <__aeabi_uidiv+0x3a>
c0d03306:	09c3      	lsrs	r3, r0, #7
c0d03308:	428b      	cmp	r3, r1
c0d0330a:	d301      	bcc.n	c0d03310 <__aeabi_uidiv+0xa8>
c0d0330c:	01cb      	lsls	r3, r1, #7
c0d0330e:	1ac0      	subs	r0, r0, r3
c0d03310:	4152      	adcs	r2, r2
c0d03312:	0983      	lsrs	r3, r0, #6
c0d03314:	428b      	cmp	r3, r1
c0d03316:	d301      	bcc.n	c0d0331c <__aeabi_uidiv+0xb4>
c0d03318:	018b      	lsls	r3, r1, #6
c0d0331a:	1ac0      	subs	r0, r0, r3
c0d0331c:	4152      	adcs	r2, r2
c0d0331e:	0943      	lsrs	r3, r0, #5
c0d03320:	428b      	cmp	r3, r1
c0d03322:	d301      	bcc.n	c0d03328 <__aeabi_uidiv+0xc0>
c0d03324:	014b      	lsls	r3, r1, #5
c0d03326:	1ac0      	subs	r0, r0, r3
c0d03328:	4152      	adcs	r2, r2
c0d0332a:	0903      	lsrs	r3, r0, #4
c0d0332c:	428b      	cmp	r3, r1
c0d0332e:	d301      	bcc.n	c0d03334 <__aeabi_uidiv+0xcc>
c0d03330:	010b      	lsls	r3, r1, #4
c0d03332:	1ac0      	subs	r0, r0, r3
c0d03334:	4152      	adcs	r2, r2
c0d03336:	08c3      	lsrs	r3, r0, #3
c0d03338:	428b      	cmp	r3, r1
c0d0333a:	d301      	bcc.n	c0d03340 <__aeabi_uidiv+0xd8>
c0d0333c:	00cb      	lsls	r3, r1, #3
c0d0333e:	1ac0      	subs	r0, r0, r3
c0d03340:	4152      	adcs	r2, r2
c0d03342:	0883      	lsrs	r3, r0, #2
c0d03344:	428b      	cmp	r3, r1
c0d03346:	d301      	bcc.n	c0d0334c <__aeabi_uidiv+0xe4>
c0d03348:	008b      	lsls	r3, r1, #2
c0d0334a:	1ac0      	subs	r0, r0, r3
c0d0334c:	4152      	adcs	r2, r2
c0d0334e:	0843      	lsrs	r3, r0, #1
c0d03350:	428b      	cmp	r3, r1
c0d03352:	d301      	bcc.n	c0d03358 <__aeabi_uidiv+0xf0>
c0d03354:	004b      	lsls	r3, r1, #1
c0d03356:	1ac0      	subs	r0, r0, r3
c0d03358:	4152      	adcs	r2, r2
c0d0335a:	1a41      	subs	r1, r0, r1
c0d0335c:	d200      	bcs.n	c0d03360 <__aeabi_uidiv+0xf8>
c0d0335e:	4601      	mov	r1, r0
c0d03360:	4152      	adcs	r2, r2
c0d03362:	4610      	mov	r0, r2
c0d03364:	4770      	bx	lr
c0d03366:	e7ff      	b.n	c0d03368 <__aeabi_uidiv+0x100>
c0d03368:	b501      	push	{r0, lr}
c0d0336a:	2000      	movs	r0, #0
c0d0336c:	f000 f8f0 	bl	c0d03550 <__aeabi_idiv0>
c0d03370:	bd02      	pop	{r1, pc}
c0d03372:	46c0      	nop			; (mov r8, r8)

c0d03374 <__aeabi_uidivmod>:
c0d03374:	2900      	cmp	r1, #0
c0d03376:	d0f7      	beq.n	c0d03368 <__aeabi_uidiv+0x100>
c0d03378:	e776      	b.n	c0d03268 <__aeabi_uidiv>
c0d0337a:	4770      	bx	lr

c0d0337c <__aeabi_idiv>:
c0d0337c:	4603      	mov	r3, r0
c0d0337e:	430b      	orrs	r3, r1
c0d03380:	d47f      	bmi.n	c0d03482 <__aeabi_idiv+0x106>
c0d03382:	2200      	movs	r2, #0
c0d03384:	0843      	lsrs	r3, r0, #1
c0d03386:	428b      	cmp	r3, r1
c0d03388:	d374      	bcc.n	c0d03474 <__aeabi_idiv+0xf8>
c0d0338a:	0903      	lsrs	r3, r0, #4
c0d0338c:	428b      	cmp	r3, r1
c0d0338e:	d35f      	bcc.n	c0d03450 <__aeabi_idiv+0xd4>
c0d03390:	0a03      	lsrs	r3, r0, #8
c0d03392:	428b      	cmp	r3, r1
c0d03394:	d344      	bcc.n	c0d03420 <__aeabi_idiv+0xa4>
c0d03396:	0b03      	lsrs	r3, r0, #12
c0d03398:	428b      	cmp	r3, r1
c0d0339a:	d328      	bcc.n	c0d033ee <__aeabi_idiv+0x72>
c0d0339c:	0c03      	lsrs	r3, r0, #16
c0d0339e:	428b      	cmp	r3, r1
c0d033a0:	d30d      	bcc.n	c0d033be <__aeabi_idiv+0x42>
c0d033a2:	22ff      	movs	r2, #255	; 0xff
c0d033a4:	0209      	lsls	r1, r1, #8
c0d033a6:	ba12      	rev	r2, r2
c0d033a8:	0c03      	lsrs	r3, r0, #16
c0d033aa:	428b      	cmp	r3, r1
c0d033ac:	d302      	bcc.n	c0d033b4 <__aeabi_idiv+0x38>
c0d033ae:	1212      	asrs	r2, r2, #8
c0d033b0:	0209      	lsls	r1, r1, #8
c0d033b2:	d065      	beq.n	c0d03480 <__aeabi_idiv+0x104>
c0d033b4:	0b03      	lsrs	r3, r0, #12
c0d033b6:	428b      	cmp	r3, r1
c0d033b8:	d319      	bcc.n	c0d033ee <__aeabi_idiv+0x72>
c0d033ba:	e000      	b.n	c0d033be <__aeabi_idiv+0x42>
c0d033bc:	0a09      	lsrs	r1, r1, #8
c0d033be:	0bc3      	lsrs	r3, r0, #15
c0d033c0:	428b      	cmp	r3, r1
c0d033c2:	d301      	bcc.n	c0d033c8 <__aeabi_idiv+0x4c>
c0d033c4:	03cb      	lsls	r3, r1, #15
c0d033c6:	1ac0      	subs	r0, r0, r3
c0d033c8:	4152      	adcs	r2, r2
c0d033ca:	0b83      	lsrs	r3, r0, #14
c0d033cc:	428b      	cmp	r3, r1
c0d033ce:	d301      	bcc.n	c0d033d4 <__aeabi_idiv+0x58>
c0d033d0:	038b      	lsls	r3, r1, #14
c0d033d2:	1ac0      	subs	r0, r0, r3
c0d033d4:	4152      	adcs	r2, r2
c0d033d6:	0b43      	lsrs	r3, r0, #13
c0d033d8:	428b      	cmp	r3, r1
c0d033da:	d301      	bcc.n	c0d033e0 <__aeabi_idiv+0x64>
c0d033dc:	034b      	lsls	r3, r1, #13
c0d033de:	1ac0      	subs	r0, r0, r3
c0d033e0:	4152      	adcs	r2, r2
c0d033e2:	0b03      	lsrs	r3, r0, #12
c0d033e4:	428b      	cmp	r3, r1
c0d033e6:	d301      	bcc.n	c0d033ec <__aeabi_idiv+0x70>
c0d033e8:	030b      	lsls	r3, r1, #12
c0d033ea:	1ac0      	subs	r0, r0, r3
c0d033ec:	4152      	adcs	r2, r2
c0d033ee:	0ac3      	lsrs	r3, r0, #11
c0d033f0:	428b      	cmp	r3, r1
c0d033f2:	d301      	bcc.n	c0d033f8 <__aeabi_idiv+0x7c>
c0d033f4:	02cb      	lsls	r3, r1, #11
c0d033f6:	1ac0      	subs	r0, r0, r3
c0d033f8:	4152      	adcs	r2, r2
c0d033fa:	0a83      	lsrs	r3, r0, #10
c0d033fc:	428b      	cmp	r3, r1
c0d033fe:	d301      	bcc.n	c0d03404 <__aeabi_idiv+0x88>
c0d03400:	028b      	lsls	r3, r1, #10
c0d03402:	1ac0      	subs	r0, r0, r3
c0d03404:	4152      	adcs	r2, r2
c0d03406:	0a43      	lsrs	r3, r0, #9
c0d03408:	428b      	cmp	r3, r1
c0d0340a:	d301      	bcc.n	c0d03410 <__aeabi_idiv+0x94>
c0d0340c:	024b      	lsls	r3, r1, #9
c0d0340e:	1ac0      	subs	r0, r0, r3
c0d03410:	4152      	adcs	r2, r2
c0d03412:	0a03      	lsrs	r3, r0, #8
c0d03414:	428b      	cmp	r3, r1
c0d03416:	d301      	bcc.n	c0d0341c <__aeabi_idiv+0xa0>
c0d03418:	020b      	lsls	r3, r1, #8
c0d0341a:	1ac0      	subs	r0, r0, r3
c0d0341c:	4152      	adcs	r2, r2
c0d0341e:	d2cd      	bcs.n	c0d033bc <__aeabi_idiv+0x40>
c0d03420:	09c3      	lsrs	r3, r0, #7
c0d03422:	428b      	cmp	r3, r1
c0d03424:	d301      	bcc.n	c0d0342a <__aeabi_idiv+0xae>
c0d03426:	01cb      	lsls	r3, r1, #7
c0d03428:	1ac0      	subs	r0, r0, r3
c0d0342a:	4152      	adcs	r2, r2
c0d0342c:	0983      	lsrs	r3, r0, #6
c0d0342e:	428b      	cmp	r3, r1
c0d03430:	d301      	bcc.n	c0d03436 <__aeabi_idiv+0xba>
c0d03432:	018b      	lsls	r3, r1, #6
c0d03434:	1ac0      	subs	r0, r0, r3
c0d03436:	4152      	adcs	r2, r2
c0d03438:	0943      	lsrs	r3, r0, #5
c0d0343a:	428b      	cmp	r3, r1
c0d0343c:	d301      	bcc.n	c0d03442 <__aeabi_idiv+0xc6>
c0d0343e:	014b      	lsls	r3, r1, #5
c0d03440:	1ac0      	subs	r0, r0, r3
c0d03442:	4152      	adcs	r2, r2
c0d03444:	0903      	lsrs	r3, r0, #4
c0d03446:	428b      	cmp	r3, r1
c0d03448:	d301      	bcc.n	c0d0344e <__aeabi_idiv+0xd2>
c0d0344a:	010b      	lsls	r3, r1, #4
c0d0344c:	1ac0      	subs	r0, r0, r3
c0d0344e:	4152      	adcs	r2, r2
c0d03450:	08c3      	lsrs	r3, r0, #3
c0d03452:	428b      	cmp	r3, r1
c0d03454:	d301      	bcc.n	c0d0345a <__aeabi_idiv+0xde>
c0d03456:	00cb      	lsls	r3, r1, #3
c0d03458:	1ac0      	subs	r0, r0, r3
c0d0345a:	4152      	adcs	r2, r2
c0d0345c:	0883      	lsrs	r3, r0, #2
c0d0345e:	428b      	cmp	r3, r1
c0d03460:	d301      	bcc.n	c0d03466 <__aeabi_idiv+0xea>
c0d03462:	008b      	lsls	r3, r1, #2
c0d03464:	1ac0      	subs	r0, r0, r3
c0d03466:	4152      	adcs	r2, r2
c0d03468:	0843      	lsrs	r3, r0, #1
c0d0346a:	428b      	cmp	r3, r1
c0d0346c:	d301      	bcc.n	c0d03472 <__aeabi_idiv+0xf6>
c0d0346e:	004b      	lsls	r3, r1, #1
c0d03470:	1ac0      	subs	r0, r0, r3
c0d03472:	4152      	adcs	r2, r2
c0d03474:	1a41      	subs	r1, r0, r1
c0d03476:	d200      	bcs.n	c0d0347a <__aeabi_idiv+0xfe>
c0d03478:	4601      	mov	r1, r0
c0d0347a:	4152      	adcs	r2, r2
c0d0347c:	4610      	mov	r0, r2
c0d0347e:	4770      	bx	lr
c0d03480:	e05d      	b.n	c0d0353e <__aeabi_idiv+0x1c2>
c0d03482:	0fca      	lsrs	r2, r1, #31
c0d03484:	d000      	beq.n	c0d03488 <__aeabi_idiv+0x10c>
c0d03486:	4249      	negs	r1, r1
c0d03488:	1003      	asrs	r3, r0, #32
c0d0348a:	d300      	bcc.n	c0d0348e <__aeabi_idiv+0x112>
c0d0348c:	4240      	negs	r0, r0
c0d0348e:	4053      	eors	r3, r2
c0d03490:	2200      	movs	r2, #0
c0d03492:	469c      	mov	ip, r3
c0d03494:	0903      	lsrs	r3, r0, #4
c0d03496:	428b      	cmp	r3, r1
c0d03498:	d32d      	bcc.n	c0d034f6 <__aeabi_idiv+0x17a>
c0d0349a:	0a03      	lsrs	r3, r0, #8
c0d0349c:	428b      	cmp	r3, r1
c0d0349e:	d312      	bcc.n	c0d034c6 <__aeabi_idiv+0x14a>
c0d034a0:	22fc      	movs	r2, #252	; 0xfc
c0d034a2:	0189      	lsls	r1, r1, #6
c0d034a4:	ba12      	rev	r2, r2
c0d034a6:	0a03      	lsrs	r3, r0, #8
c0d034a8:	428b      	cmp	r3, r1
c0d034aa:	d30c      	bcc.n	c0d034c6 <__aeabi_idiv+0x14a>
c0d034ac:	0189      	lsls	r1, r1, #6
c0d034ae:	1192      	asrs	r2, r2, #6
c0d034b0:	428b      	cmp	r3, r1
c0d034b2:	d308      	bcc.n	c0d034c6 <__aeabi_idiv+0x14a>
c0d034b4:	0189      	lsls	r1, r1, #6
c0d034b6:	1192      	asrs	r2, r2, #6
c0d034b8:	428b      	cmp	r3, r1
c0d034ba:	d304      	bcc.n	c0d034c6 <__aeabi_idiv+0x14a>
c0d034bc:	0189      	lsls	r1, r1, #6
c0d034be:	d03a      	beq.n	c0d03536 <__aeabi_idiv+0x1ba>
c0d034c0:	1192      	asrs	r2, r2, #6
c0d034c2:	e000      	b.n	c0d034c6 <__aeabi_idiv+0x14a>
c0d034c4:	0989      	lsrs	r1, r1, #6
c0d034c6:	09c3      	lsrs	r3, r0, #7
c0d034c8:	428b      	cmp	r3, r1
c0d034ca:	d301      	bcc.n	c0d034d0 <__aeabi_idiv+0x154>
c0d034cc:	01cb      	lsls	r3, r1, #7
c0d034ce:	1ac0      	subs	r0, r0, r3
c0d034d0:	4152      	adcs	r2, r2
c0d034d2:	0983      	lsrs	r3, r0, #6
c0d034d4:	428b      	cmp	r3, r1
c0d034d6:	d301      	bcc.n	c0d034dc <__aeabi_idiv+0x160>
c0d034d8:	018b      	lsls	r3, r1, #6
c0d034da:	1ac0      	subs	r0, r0, r3
c0d034dc:	4152      	adcs	r2, r2
c0d034de:	0943      	lsrs	r3, r0, #5
c0d034e0:	428b      	cmp	r3, r1
c0d034e2:	d301      	bcc.n	c0d034e8 <__aeabi_idiv+0x16c>
c0d034e4:	014b      	lsls	r3, r1, #5
c0d034e6:	1ac0      	subs	r0, r0, r3
c0d034e8:	4152      	adcs	r2, r2
c0d034ea:	0903      	lsrs	r3, r0, #4
c0d034ec:	428b      	cmp	r3, r1
c0d034ee:	d301      	bcc.n	c0d034f4 <__aeabi_idiv+0x178>
c0d034f0:	010b      	lsls	r3, r1, #4
c0d034f2:	1ac0      	subs	r0, r0, r3
c0d034f4:	4152      	adcs	r2, r2
c0d034f6:	08c3      	lsrs	r3, r0, #3
c0d034f8:	428b      	cmp	r3, r1
c0d034fa:	d301      	bcc.n	c0d03500 <__aeabi_idiv+0x184>
c0d034fc:	00cb      	lsls	r3, r1, #3
c0d034fe:	1ac0      	subs	r0, r0, r3
c0d03500:	4152      	adcs	r2, r2
c0d03502:	0883      	lsrs	r3, r0, #2
c0d03504:	428b      	cmp	r3, r1
c0d03506:	d301      	bcc.n	c0d0350c <__aeabi_idiv+0x190>
c0d03508:	008b      	lsls	r3, r1, #2
c0d0350a:	1ac0      	subs	r0, r0, r3
c0d0350c:	4152      	adcs	r2, r2
c0d0350e:	d2d9      	bcs.n	c0d034c4 <__aeabi_idiv+0x148>
c0d03510:	0843      	lsrs	r3, r0, #1
c0d03512:	428b      	cmp	r3, r1
c0d03514:	d301      	bcc.n	c0d0351a <__aeabi_idiv+0x19e>
c0d03516:	004b      	lsls	r3, r1, #1
c0d03518:	1ac0      	subs	r0, r0, r3
c0d0351a:	4152      	adcs	r2, r2
c0d0351c:	1a41      	subs	r1, r0, r1
c0d0351e:	d200      	bcs.n	c0d03522 <__aeabi_idiv+0x1a6>
c0d03520:	4601      	mov	r1, r0
c0d03522:	4663      	mov	r3, ip
c0d03524:	4152      	adcs	r2, r2
c0d03526:	105b      	asrs	r3, r3, #1
c0d03528:	4610      	mov	r0, r2
c0d0352a:	d301      	bcc.n	c0d03530 <__aeabi_idiv+0x1b4>
c0d0352c:	4240      	negs	r0, r0
c0d0352e:	2b00      	cmp	r3, #0
c0d03530:	d500      	bpl.n	c0d03534 <__aeabi_idiv+0x1b8>
c0d03532:	4249      	negs	r1, r1
c0d03534:	4770      	bx	lr
c0d03536:	4663      	mov	r3, ip
c0d03538:	105b      	asrs	r3, r3, #1
c0d0353a:	d300      	bcc.n	c0d0353e <__aeabi_idiv+0x1c2>
c0d0353c:	4240      	negs	r0, r0
c0d0353e:	b501      	push	{r0, lr}
c0d03540:	2000      	movs	r0, #0
c0d03542:	f000 f805 	bl	c0d03550 <__aeabi_idiv0>
c0d03546:	bd02      	pop	{r1, pc}

c0d03548 <__aeabi_idivmod>:
c0d03548:	2900      	cmp	r1, #0
c0d0354a:	d0f8      	beq.n	c0d0353e <__aeabi_idiv+0x1c2>
c0d0354c:	e716      	b.n	c0d0337c <__aeabi_idiv>
c0d0354e:	4770      	bx	lr

c0d03550 <__aeabi_idiv0>:
c0d03550:	4770      	bx	lr
c0d03552:	46c0      	nop			; (mov r8, r8)

c0d03554 <__aeabi_uldivmod>:
c0d03554:	2b00      	cmp	r3, #0
c0d03556:	d111      	bne.n	c0d0357c <__aeabi_uldivmod+0x28>
c0d03558:	2a00      	cmp	r2, #0
c0d0355a:	d10f      	bne.n	c0d0357c <__aeabi_uldivmod+0x28>
c0d0355c:	2900      	cmp	r1, #0
c0d0355e:	d100      	bne.n	c0d03562 <__aeabi_uldivmod+0xe>
c0d03560:	2800      	cmp	r0, #0
c0d03562:	d002      	beq.n	c0d0356a <__aeabi_uldivmod+0x16>
c0d03564:	2100      	movs	r1, #0
c0d03566:	43c9      	mvns	r1, r1
c0d03568:	1c08      	adds	r0, r1, #0
c0d0356a:	b407      	push	{r0, r1, r2}
c0d0356c:	4802      	ldr	r0, [pc, #8]	; (c0d03578 <__aeabi_uldivmod+0x24>)
c0d0356e:	a102      	add	r1, pc, #8	; (adr r1, c0d03578 <__aeabi_uldivmod+0x24>)
c0d03570:	1840      	adds	r0, r0, r1
c0d03572:	9002      	str	r0, [sp, #8]
c0d03574:	bd03      	pop	{r0, r1, pc}
c0d03576:	46c0      	nop			; (mov r8, r8)
c0d03578:	ffffffd9 	.word	0xffffffd9
c0d0357c:	b403      	push	{r0, r1}
c0d0357e:	4668      	mov	r0, sp
c0d03580:	b501      	push	{r0, lr}
c0d03582:	9802      	ldr	r0, [sp, #8]
c0d03584:	f000 f806 	bl	c0d03594 <__udivmoddi4>
c0d03588:	9b01      	ldr	r3, [sp, #4]
c0d0358a:	469e      	mov	lr, r3
c0d0358c:	b002      	add	sp, #8
c0d0358e:	bc0c      	pop	{r2, r3}
c0d03590:	4770      	bx	lr
c0d03592:	46c0      	nop			; (mov r8, r8)

c0d03594 <__udivmoddi4>:
c0d03594:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03596:	464d      	mov	r5, r9
c0d03598:	4656      	mov	r6, sl
c0d0359a:	4644      	mov	r4, r8
c0d0359c:	465f      	mov	r7, fp
c0d0359e:	b4f0      	push	{r4, r5, r6, r7}
c0d035a0:	4692      	mov	sl, r2
c0d035a2:	b083      	sub	sp, #12
c0d035a4:	0004      	movs	r4, r0
c0d035a6:	000d      	movs	r5, r1
c0d035a8:	4699      	mov	r9, r3
c0d035aa:	428b      	cmp	r3, r1
c0d035ac:	d82f      	bhi.n	c0d0360e <__udivmoddi4+0x7a>
c0d035ae:	d02c      	beq.n	c0d0360a <__udivmoddi4+0x76>
c0d035b0:	4649      	mov	r1, r9
c0d035b2:	4650      	mov	r0, sl
c0d035b4:	f000 f8ae 	bl	c0d03714 <__clzdi2>
c0d035b8:	0029      	movs	r1, r5
c0d035ba:	0006      	movs	r6, r0
c0d035bc:	0020      	movs	r0, r4
c0d035be:	f000 f8a9 	bl	c0d03714 <__clzdi2>
c0d035c2:	1a33      	subs	r3, r6, r0
c0d035c4:	4698      	mov	r8, r3
c0d035c6:	3b20      	subs	r3, #32
c0d035c8:	469b      	mov	fp, r3
c0d035ca:	d500      	bpl.n	c0d035ce <__udivmoddi4+0x3a>
c0d035cc:	e074      	b.n	c0d036b8 <__udivmoddi4+0x124>
c0d035ce:	4653      	mov	r3, sl
c0d035d0:	465a      	mov	r2, fp
c0d035d2:	4093      	lsls	r3, r2
c0d035d4:	001f      	movs	r7, r3
c0d035d6:	4653      	mov	r3, sl
c0d035d8:	4642      	mov	r2, r8
c0d035da:	4093      	lsls	r3, r2
c0d035dc:	001e      	movs	r6, r3
c0d035de:	42af      	cmp	r7, r5
c0d035e0:	d829      	bhi.n	c0d03636 <__udivmoddi4+0xa2>
c0d035e2:	d026      	beq.n	c0d03632 <__udivmoddi4+0x9e>
c0d035e4:	465b      	mov	r3, fp
c0d035e6:	1ba4      	subs	r4, r4, r6
c0d035e8:	41bd      	sbcs	r5, r7
c0d035ea:	2b00      	cmp	r3, #0
c0d035ec:	da00      	bge.n	c0d035f0 <__udivmoddi4+0x5c>
c0d035ee:	e079      	b.n	c0d036e4 <__udivmoddi4+0x150>
c0d035f0:	2200      	movs	r2, #0
c0d035f2:	2300      	movs	r3, #0
c0d035f4:	9200      	str	r2, [sp, #0]
c0d035f6:	9301      	str	r3, [sp, #4]
c0d035f8:	2301      	movs	r3, #1
c0d035fa:	465a      	mov	r2, fp
c0d035fc:	4093      	lsls	r3, r2
c0d035fe:	9301      	str	r3, [sp, #4]
c0d03600:	2301      	movs	r3, #1
c0d03602:	4642      	mov	r2, r8
c0d03604:	4093      	lsls	r3, r2
c0d03606:	9300      	str	r3, [sp, #0]
c0d03608:	e019      	b.n	c0d0363e <__udivmoddi4+0xaa>
c0d0360a:	4282      	cmp	r2, r0
c0d0360c:	d9d0      	bls.n	c0d035b0 <__udivmoddi4+0x1c>
c0d0360e:	2200      	movs	r2, #0
c0d03610:	2300      	movs	r3, #0
c0d03612:	9200      	str	r2, [sp, #0]
c0d03614:	9301      	str	r3, [sp, #4]
c0d03616:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d03618:	2b00      	cmp	r3, #0
c0d0361a:	d001      	beq.n	c0d03620 <__udivmoddi4+0x8c>
c0d0361c:	601c      	str	r4, [r3, #0]
c0d0361e:	605d      	str	r5, [r3, #4]
c0d03620:	9800      	ldr	r0, [sp, #0]
c0d03622:	9901      	ldr	r1, [sp, #4]
c0d03624:	b003      	add	sp, #12
c0d03626:	bc3c      	pop	{r2, r3, r4, r5}
c0d03628:	4690      	mov	r8, r2
c0d0362a:	4699      	mov	r9, r3
c0d0362c:	46a2      	mov	sl, r4
c0d0362e:	46ab      	mov	fp, r5
c0d03630:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03632:	42a3      	cmp	r3, r4
c0d03634:	d9d6      	bls.n	c0d035e4 <__udivmoddi4+0x50>
c0d03636:	2200      	movs	r2, #0
c0d03638:	2300      	movs	r3, #0
c0d0363a:	9200      	str	r2, [sp, #0]
c0d0363c:	9301      	str	r3, [sp, #4]
c0d0363e:	4643      	mov	r3, r8
c0d03640:	2b00      	cmp	r3, #0
c0d03642:	d0e8      	beq.n	c0d03616 <__udivmoddi4+0x82>
c0d03644:	07fb      	lsls	r3, r7, #31
c0d03646:	0872      	lsrs	r2, r6, #1
c0d03648:	431a      	orrs	r2, r3
c0d0364a:	4646      	mov	r6, r8
c0d0364c:	087b      	lsrs	r3, r7, #1
c0d0364e:	e00e      	b.n	c0d0366e <__udivmoddi4+0xda>
c0d03650:	42ab      	cmp	r3, r5
c0d03652:	d101      	bne.n	c0d03658 <__udivmoddi4+0xc4>
c0d03654:	42a2      	cmp	r2, r4
c0d03656:	d80c      	bhi.n	c0d03672 <__udivmoddi4+0xde>
c0d03658:	1aa4      	subs	r4, r4, r2
c0d0365a:	419d      	sbcs	r5, r3
c0d0365c:	2001      	movs	r0, #1
c0d0365e:	1924      	adds	r4, r4, r4
c0d03660:	416d      	adcs	r5, r5
c0d03662:	2100      	movs	r1, #0
c0d03664:	3e01      	subs	r6, #1
c0d03666:	1824      	adds	r4, r4, r0
c0d03668:	414d      	adcs	r5, r1
c0d0366a:	2e00      	cmp	r6, #0
c0d0366c:	d006      	beq.n	c0d0367c <__udivmoddi4+0xe8>
c0d0366e:	42ab      	cmp	r3, r5
c0d03670:	d9ee      	bls.n	c0d03650 <__udivmoddi4+0xbc>
c0d03672:	3e01      	subs	r6, #1
c0d03674:	1924      	adds	r4, r4, r4
c0d03676:	416d      	adcs	r5, r5
c0d03678:	2e00      	cmp	r6, #0
c0d0367a:	d1f8      	bne.n	c0d0366e <__udivmoddi4+0xda>
c0d0367c:	465b      	mov	r3, fp
c0d0367e:	9800      	ldr	r0, [sp, #0]
c0d03680:	9901      	ldr	r1, [sp, #4]
c0d03682:	1900      	adds	r0, r0, r4
c0d03684:	4169      	adcs	r1, r5
c0d03686:	2b00      	cmp	r3, #0
c0d03688:	db22      	blt.n	c0d036d0 <__udivmoddi4+0x13c>
c0d0368a:	002b      	movs	r3, r5
c0d0368c:	465a      	mov	r2, fp
c0d0368e:	40d3      	lsrs	r3, r2
c0d03690:	002a      	movs	r2, r5
c0d03692:	4644      	mov	r4, r8
c0d03694:	40e2      	lsrs	r2, r4
c0d03696:	001c      	movs	r4, r3
c0d03698:	465b      	mov	r3, fp
c0d0369a:	0015      	movs	r5, r2
c0d0369c:	2b00      	cmp	r3, #0
c0d0369e:	db2c      	blt.n	c0d036fa <__udivmoddi4+0x166>
c0d036a0:	0026      	movs	r6, r4
c0d036a2:	409e      	lsls	r6, r3
c0d036a4:	0033      	movs	r3, r6
c0d036a6:	0026      	movs	r6, r4
c0d036a8:	4647      	mov	r7, r8
c0d036aa:	40be      	lsls	r6, r7
c0d036ac:	0032      	movs	r2, r6
c0d036ae:	1a80      	subs	r0, r0, r2
c0d036b0:	4199      	sbcs	r1, r3
c0d036b2:	9000      	str	r0, [sp, #0]
c0d036b4:	9101      	str	r1, [sp, #4]
c0d036b6:	e7ae      	b.n	c0d03616 <__udivmoddi4+0x82>
c0d036b8:	4642      	mov	r2, r8
c0d036ba:	2320      	movs	r3, #32
c0d036bc:	1a9b      	subs	r3, r3, r2
c0d036be:	4652      	mov	r2, sl
c0d036c0:	40da      	lsrs	r2, r3
c0d036c2:	4641      	mov	r1, r8
c0d036c4:	0013      	movs	r3, r2
c0d036c6:	464a      	mov	r2, r9
c0d036c8:	408a      	lsls	r2, r1
c0d036ca:	0017      	movs	r7, r2
c0d036cc:	431f      	orrs	r7, r3
c0d036ce:	e782      	b.n	c0d035d6 <__udivmoddi4+0x42>
c0d036d0:	4642      	mov	r2, r8
c0d036d2:	2320      	movs	r3, #32
c0d036d4:	1a9b      	subs	r3, r3, r2
c0d036d6:	002a      	movs	r2, r5
c0d036d8:	4646      	mov	r6, r8
c0d036da:	409a      	lsls	r2, r3
c0d036dc:	0023      	movs	r3, r4
c0d036de:	40f3      	lsrs	r3, r6
c0d036e0:	4313      	orrs	r3, r2
c0d036e2:	e7d5      	b.n	c0d03690 <__udivmoddi4+0xfc>
c0d036e4:	4642      	mov	r2, r8
c0d036e6:	2320      	movs	r3, #32
c0d036e8:	2100      	movs	r1, #0
c0d036ea:	1a9b      	subs	r3, r3, r2
c0d036ec:	2200      	movs	r2, #0
c0d036ee:	9100      	str	r1, [sp, #0]
c0d036f0:	9201      	str	r2, [sp, #4]
c0d036f2:	2201      	movs	r2, #1
c0d036f4:	40da      	lsrs	r2, r3
c0d036f6:	9201      	str	r2, [sp, #4]
c0d036f8:	e782      	b.n	c0d03600 <__udivmoddi4+0x6c>
c0d036fa:	4642      	mov	r2, r8
c0d036fc:	2320      	movs	r3, #32
c0d036fe:	0026      	movs	r6, r4
c0d03700:	1a9b      	subs	r3, r3, r2
c0d03702:	40de      	lsrs	r6, r3
c0d03704:	002f      	movs	r7, r5
c0d03706:	46b4      	mov	ip, r6
c0d03708:	4097      	lsls	r7, r2
c0d0370a:	4666      	mov	r6, ip
c0d0370c:	003b      	movs	r3, r7
c0d0370e:	4333      	orrs	r3, r6
c0d03710:	e7c9      	b.n	c0d036a6 <__udivmoddi4+0x112>
c0d03712:	46c0      	nop			; (mov r8, r8)

c0d03714 <__clzdi2>:
c0d03714:	b510      	push	{r4, lr}
c0d03716:	2900      	cmp	r1, #0
c0d03718:	d103      	bne.n	c0d03722 <__clzdi2+0xe>
c0d0371a:	f000 f807 	bl	c0d0372c <__clzsi2>
c0d0371e:	3020      	adds	r0, #32
c0d03720:	e002      	b.n	c0d03728 <__clzdi2+0x14>
c0d03722:	1c08      	adds	r0, r1, #0
c0d03724:	f000 f802 	bl	c0d0372c <__clzsi2>
c0d03728:	bd10      	pop	{r4, pc}
c0d0372a:	46c0      	nop			; (mov r8, r8)

c0d0372c <__clzsi2>:
c0d0372c:	211c      	movs	r1, #28
c0d0372e:	2301      	movs	r3, #1
c0d03730:	041b      	lsls	r3, r3, #16
c0d03732:	4298      	cmp	r0, r3
c0d03734:	d301      	bcc.n	c0d0373a <__clzsi2+0xe>
c0d03736:	0c00      	lsrs	r0, r0, #16
c0d03738:	3910      	subs	r1, #16
c0d0373a:	0a1b      	lsrs	r3, r3, #8
c0d0373c:	4298      	cmp	r0, r3
c0d0373e:	d301      	bcc.n	c0d03744 <__clzsi2+0x18>
c0d03740:	0a00      	lsrs	r0, r0, #8
c0d03742:	3908      	subs	r1, #8
c0d03744:	091b      	lsrs	r3, r3, #4
c0d03746:	4298      	cmp	r0, r3
c0d03748:	d301      	bcc.n	c0d0374e <__clzsi2+0x22>
c0d0374a:	0900      	lsrs	r0, r0, #4
c0d0374c:	3904      	subs	r1, #4
c0d0374e:	a202      	add	r2, pc, #8	; (adr r2, c0d03758 <__clzsi2+0x2c>)
c0d03750:	5c10      	ldrb	r0, [r2, r0]
c0d03752:	1840      	adds	r0, r0, r1
c0d03754:	4770      	bx	lr
c0d03756:	46c0      	nop			; (mov r8, r8)
c0d03758:	02020304 	.word	0x02020304
c0d0375c:	01010101 	.word	0x01010101
	...

c0d03768 <__aeabi_memclr>:
c0d03768:	b510      	push	{r4, lr}
c0d0376a:	2200      	movs	r2, #0
c0d0376c:	f000 f806 	bl	c0d0377c <__aeabi_memset>
c0d03770:	bd10      	pop	{r4, pc}
c0d03772:	46c0      	nop			; (mov r8, r8)

c0d03774 <__aeabi_memcpy>:
c0d03774:	b510      	push	{r4, lr}
c0d03776:	f000 f809 	bl	c0d0378c <memcpy>
c0d0377a:	bd10      	pop	{r4, pc}

c0d0377c <__aeabi_memset>:
c0d0377c:	0013      	movs	r3, r2
c0d0377e:	b510      	push	{r4, lr}
c0d03780:	000a      	movs	r2, r1
c0d03782:	0019      	movs	r1, r3
c0d03784:	f000 f840 	bl	c0d03808 <memset>
c0d03788:	bd10      	pop	{r4, pc}
c0d0378a:	46c0      	nop			; (mov r8, r8)

c0d0378c <memcpy>:
c0d0378c:	b570      	push	{r4, r5, r6, lr}
c0d0378e:	2a0f      	cmp	r2, #15
c0d03790:	d932      	bls.n	c0d037f8 <memcpy+0x6c>
c0d03792:	000c      	movs	r4, r1
c0d03794:	4304      	orrs	r4, r0
c0d03796:	000b      	movs	r3, r1
c0d03798:	07a4      	lsls	r4, r4, #30
c0d0379a:	d131      	bne.n	c0d03800 <memcpy+0x74>
c0d0379c:	0015      	movs	r5, r2
c0d0379e:	0004      	movs	r4, r0
c0d037a0:	3d10      	subs	r5, #16
c0d037a2:	092d      	lsrs	r5, r5, #4
c0d037a4:	3501      	adds	r5, #1
c0d037a6:	012d      	lsls	r5, r5, #4
c0d037a8:	1949      	adds	r1, r1, r5
c0d037aa:	681e      	ldr	r6, [r3, #0]
c0d037ac:	6026      	str	r6, [r4, #0]
c0d037ae:	685e      	ldr	r6, [r3, #4]
c0d037b0:	6066      	str	r6, [r4, #4]
c0d037b2:	689e      	ldr	r6, [r3, #8]
c0d037b4:	60a6      	str	r6, [r4, #8]
c0d037b6:	68de      	ldr	r6, [r3, #12]
c0d037b8:	3310      	adds	r3, #16
c0d037ba:	60e6      	str	r6, [r4, #12]
c0d037bc:	3410      	adds	r4, #16
c0d037be:	4299      	cmp	r1, r3
c0d037c0:	d1f3      	bne.n	c0d037aa <memcpy+0x1e>
c0d037c2:	230f      	movs	r3, #15
c0d037c4:	1945      	adds	r5, r0, r5
c0d037c6:	4013      	ands	r3, r2
c0d037c8:	2b03      	cmp	r3, #3
c0d037ca:	d91b      	bls.n	c0d03804 <memcpy+0x78>
c0d037cc:	1f1c      	subs	r4, r3, #4
c0d037ce:	2300      	movs	r3, #0
c0d037d0:	08a4      	lsrs	r4, r4, #2
c0d037d2:	3401      	adds	r4, #1
c0d037d4:	00a4      	lsls	r4, r4, #2
c0d037d6:	58ce      	ldr	r6, [r1, r3]
c0d037d8:	50ee      	str	r6, [r5, r3]
c0d037da:	3304      	adds	r3, #4
c0d037dc:	429c      	cmp	r4, r3
c0d037de:	d1fa      	bne.n	c0d037d6 <memcpy+0x4a>
c0d037e0:	2303      	movs	r3, #3
c0d037e2:	192d      	adds	r5, r5, r4
c0d037e4:	1909      	adds	r1, r1, r4
c0d037e6:	401a      	ands	r2, r3
c0d037e8:	d005      	beq.n	c0d037f6 <memcpy+0x6a>
c0d037ea:	2300      	movs	r3, #0
c0d037ec:	5ccc      	ldrb	r4, [r1, r3]
c0d037ee:	54ec      	strb	r4, [r5, r3]
c0d037f0:	3301      	adds	r3, #1
c0d037f2:	429a      	cmp	r2, r3
c0d037f4:	d1fa      	bne.n	c0d037ec <memcpy+0x60>
c0d037f6:	bd70      	pop	{r4, r5, r6, pc}
c0d037f8:	0005      	movs	r5, r0
c0d037fa:	2a00      	cmp	r2, #0
c0d037fc:	d1f5      	bne.n	c0d037ea <memcpy+0x5e>
c0d037fe:	e7fa      	b.n	c0d037f6 <memcpy+0x6a>
c0d03800:	0005      	movs	r5, r0
c0d03802:	e7f2      	b.n	c0d037ea <memcpy+0x5e>
c0d03804:	001a      	movs	r2, r3
c0d03806:	e7f8      	b.n	c0d037fa <memcpy+0x6e>

c0d03808 <memset>:
c0d03808:	b570      	push	{r4, r5, r6, lr}
c0d0380a:	0783      	lsls	r3, r0, #30
c0d0380c:	d03f      	beq.n	c0d0388e <memset+0x86>
c0d0380e:	1e54      	subs	r4, r2, #1
c0d03810:	2a00      	cmp	r2, #0
c0d03812:	d03b      	beq.n	c0d0388c <memset+0x84>
c0d03814:	b2ce      	uxtb	r6, r1
c0d03816:	0003      	movs	r3, r0
c0d03818:	2503      	movs	r5, #3
c0d0381a:	e003      	b.n	c0d03824 <memset+0x1c>
c0d0381c:	1e62      	subs	r2, r4, #1
c0d0381e:	2c00      	cmp	r4, #0
c0d03820:	d034      	beq.n	c0d0388c <memset+0x84>
c0d03822:	0014      	movs	r4, r2
c0d03824:	3301      	adds	r3, #1
c0d03826:	1e5a      	subs	r2, r3, #1
c0d03828:	7016      	strb	r6, [r2, #0]
c0d0382a:	422b      	tst	r3, r5
c0d0382c:	d1f6      	bne.n	c0d0381c <memset+0x14>
c0d0382e:	2c03      	cmp	r4, #3
c0d03830:	d924      	bls.n	c0d0387c <memset+0x74>
c0d03832:	25ff      	movs	r5, #255	; 0xff
c0d03834:	400d      	ands	r5, r1
c0d03836:	022a      	lsls	r2, r5, #8
c0d03838:	4315      	orrs	r5, r2
c0d0383a:	042a      	lsls	r2, r5, #16
c0d0383c:	4315      	orrs	r5, r2
c0d0383e:	2c0f      	cmp	r4, #15
c0d03840:	d911      	bls.n	c0d03866 <memset+0x5e>
c0d03842:	0026      	movs	r6, r4
c0d03844:	3e10      	subs	r6, #16
c0d03846:	0936      	lsrs	r6, r6, #4
c0d03848:	3601      	adds	r6, #1
c0d0384a:	0136      	lsls	r6, r6, #4
c0d0384c:	001a      	movs	r2, r3
c0d0384e:	199b      	adds	r3, r3, r6
c0d03850:	6015      	str	r5, [r2, #0]
c0d03852:	6055      	str	r5, [r2, #4]
c0d03854:	6095      	str	r5, [r2, #8]
c0d03856:	60d5      	str	r5, [r2, #12]
c0d03858:	3210      	adds	r2, #16
c0d0385a:	4293      	cmp	r3, r2
c0d0385c:	d1f8      	bne.n	c0d03850 <memset+0x48>
c0d0385e:	220f      	movs	r2, #15
c0d03860:	4014      	ands	r4, r2
c0d03862:	2c03      	cmp	r4, #3
c0d03864:	d90a      	bls.n	c0d0387c <memset+0x74>
c0d03866:	1f26      	subs	r6, r4, #4
c0d03868:	08b6      	lsrs	r6, r6, #2
c0d0386a:	3601      	adds	r6, #1
c0d0386c:	00b6      	lsls	r6, r6, #2
c0d0386e:	001a      	movs	r2, r3
c0d03870:	199b      	adds	r3, r3, r6
c0d03872:	c220      	stmia	r2!, {r5}
c0d03874:	4293      	cmp	r3, r2
c0d03876:	d1fc      	bne.n	c0d03872 <memset+0x6a>
c0d03878:	2203      	movs	r2, #3
c0d0387a:	4014      	ands	r4, r2
c0d0387c:	2c00      	cmp	r4, #0
c0d0387e:	d005      	beq.n	c0d0388c <memset+0x84>
c0d03880:	b2c9      	uxtb	r1, r1
c0d03882:	191c      	adds	r4, r3, r4
c0d03884:	7019      	strb	r1, [r3, #0]
c0d03886:	3301      	adds	r3, #1
c0d03888:	429c      	cmp	r4, r3
c0d0388a:	d1fb      	bne.n	c0d03884 <memset+0x7c>
c0d0388c:	bd70      	pop	{r4, r5, r6, pc}
c0d0388e:	0014      	movs	r4, r2
c0d03890:	0003      	movs	r3, r0
c0d03892:	e7cc      	b.n	c0d0382e <memset+0x26>

c0d03894 <setjmp>:
c0d03894:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d03896:	4641      	mov	r1, r8
c0d03898:	464a      	mov	r2, r9
c0d0389a:	4653      	mov	r3, sl
c0d0389c:	465c      	mov	r4, fp
c0d0389e:	466d      	mov	r5, sp
c0d038a0:	4676      	mov	r6, lr
c0d038a2:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d038a4:	3828      	subs	r0, #40	; 0x28
c0d038a6:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d038a8:	2000      	movs	r0, #0
c0d038aa:	4770      	bx	lr

c0d038ac <longjmp>:
c0d038ac:	3010      	adds	r0, #16
c0d038ae:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d038b0:	4690      	mov	r8, r2
c0d038b2:	4699      	mov	r9, r3
c0d038b4:	46a2      	mov	sl, r4
c0d038b6:	46ab      	mov	fp, r5
c0d038b8:	46b5      	mov	sp, r6
c0d038ba:	c808      	ldmia	r0!, {r3}
c0d038bc:	3828      	subs	r0, #40	; 0x28
c0d038be:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d038c0:	1c08      	adds	r0, r1, #0
c0d038c2:	d100      	bne.n	c0d038c6 <longjmp+0x1a>
c0d038c4:	2001      	movs	r0, #1
c0d038c6:	4718      	bx	r3

c0d038c8 <strlen>:
c0d038c8:	b510      	push	{r4, lr}
c0d038ca:	0783      	lsls	r3, r0, #30
c0d038cc:	d027      	beq.n	c0d0391e <strlen+0x56>
c0d038ce:	7803      	ldrb	r3, [r0, #0]
c0d038d0:	2b00      	cmp	r3, #0
c0d038d2:	d026      	beq.n	c0d03922 <strlen+0x5a>
c0d038d4:	0003      	movs	r3, r0
c0d038d6:	2103      	movs	r1, #3
c0d038d8:	e002      	b.n	c0d038e0 <strlen+0x18>
c0d038da:	781a      	ldrb	r2, [r3, #0]
c0d038dc:	2a00      	cmp	r2, #0
c0d038de:	d01c      	beq.n	c0d0391a <strlen+0x52>
c0d038e0:	3301      	adds	r3, #1
c0d038e2:	420b      	tst	r3, r1
c0d038e4:	d1f9      	bne.n	c0d038da <strlen+0x12>
c0d038e6:	6819      	ldr	r1, [r3, #0]
c0d038e8:	4a0f      	ldr	r2, [pc, #60]	; (c0d03928 <strlen+0x60>)
c0d038ea:	4c10      	ldr	r4, [pc, #64]	; (c0d0392c <strlen+0x64>)
c0d038ec:	188a      	adds	r2, r1, r2
c0d038ee:	438a      	bics	r2, r1
c0d038f0:	4222      	tst	r2, r4
c0d038f2:	d10f      	bne.n	c0d03914 <strlen+0x4c>
c0d038f4:	3304      	adds	r3, #4
c0d038f6:	6819      	ldr	r1, [r3, #0]
c0d038f8:	4a0b      	ldr	r2, [pc, #44]	; (c0d03928 <strlen+0x60>)
c0d038fa:	188a      	adds	r2, r1, r2
c0d038fc:	438a      	bics	r2, r1
c0d038fe:	4222      	tst	r2, r4
c0d03900:	d108      	bne.n	c0d03914 <strlen+0x4c>
c0d03902:	3304      	adds	r3, #4
c0d03904:	6819      	ldr	r1, [r3, #0]
c0d03906:	4a08      	ldr	r2, [pc, #32]	; (c0d03928 <strlen+0x60>)
c0d03908:	188a      	adds	r2, r1, r2
c0d0390a:	438a      	bics	r2, r1
c0d0390c:	4222      	tst	r2, r4
c0d0390e:	d0f1      	beq.n	c0d038f4 <strlen+0x2c>
c0d03910:	e000      	b.n	c0d03914 <strlen+0x4c>
c0d03912:	3301      	adds	r3, #1
c0d03914:	781a      	ldrb	r2, [r3, #0]
c0d03916:	2a00      	cmp	r2, #0
c0d03918:	d1fb      	bne.n	c0d03912 <strlen+0x4a>
c0d0391a:	1a18      	subs	r0, r3, r0
c0d0391c:	bd10      	pop	{r4, pc}
c0d0391e:	0003      	movs	r3, r0
c0d03920:	e7e1      	b.n	c0d038e6 <strlen+0x1e>
c0d03922:	2000      	movs	r0, #0
c0d03924:	e7fa      	b.n	c0d0391c <strlen+0x54>
c0d03926:	46c0      	nop			; (mov r8, r8)
c0d03928:	fefefeff 	.word	0xfefefeff
c0d0392c:	80808080 	.word	0x80808080

c0d03930 <HALF_3>:
c0d03930:	f16b9c2d dd01633c 3d8cf0ee b09a028b     -.k.<c.....=....
c0d03940:	246cd94a f1c6d805 6cee5506 da330aa3     J.l$.....U.l..3.
c0d03950:	fde381a1 fe13f810 f97f039e 1b3dc3ce     ..............=.
c0d03960:	00000001                                ....

c0d03964 <bagl_ui_nanos_screen1>:
c0d03964:	00000003 00800000 00000020 00000001     ........ .......
c0d03974:	00000000 00ffffff 00000000 00000000     ................
	...
c0d0399c:	00000107 0080000c 00000020 00000000     ........ .......
c0d039ac:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d039d4:	00030005 0007000c 00000007 00000000     ................
	...
c0d039ec:	00070000 00000000 00000000 00000000     ................
	...
c0d03a0c:	00750005 0008000d 00000006 00000000     ..u.............
c0d03a1c:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03a44 <bagl_ui_nanos_screen2>:
c0d03a44:	00000003 00800000 00000020 00000001     ........ .......
c0d03a54:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03a7c:	00000107 00800012 00000020 00000000     ........ .......
c0d03a8c:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03ab4:	00030005 0007000c 00000007 00000000     ................
	...
c0d03acc:	00070000 00000000 00000000 00000000     ................
	...
c0d03aec:	00750005 0008000d 00000006 00000000     ..u.............
c0d03afc:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03b24 <bagl_ui_sample_blue>:
c0d03b24:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03b34:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03b5c:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03b6c:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03b94:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03ba4:	00ffffff 001d2028 00002004 c0d03c04     ....( ... ...<..
	...
c0d03bcc:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03bdc:	0041ccb4 00f9f9f9 0000a004 c0d03c10     ..A..........<..
c0d03bec:	00000000 0037ae99 00f9f9f9 c0d02539     ......7.....9%..
	...
c0d03c04:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03c15 <USBD_PRODUCT_FS_STRING>:
c0d03c15:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d03c23 <HID_ReportDesc>:
c0d03c23:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d03c33:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d03c43:	0000c008 11210900                                .....

c0d03c48 <USBD_HID_Desc>:
c0d03c48:	01112109 22220100 00011200                       .!...."".

c0d03c51 <USBD_DeviceDesc>:
c0d03c51:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03c61:	49000103                                         ...

c0d03c64 <HID_Desc>:
c0d03c64:	c0d03149 c0d03159 c0d03169 c0d03179     I1..Y1..i1..y1..
c0d03c74:	c0d03189 c0d03199 c0d031a9 00000000     .1...1...1......

c0d03c84 <USBD_LangIDDesc>:
c0d03c84:	04090304                                ....

c0d03c88 <USBD_MANUFACTURER_STRING>:
c0d03c88:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03c96 <USB_SERIAL_STRING>:
c0d03c96:	0030030a 00300030 302b0031                       ..0.0.0.1.

c0d03ca0 <USBD_HID>:
c0d03ca0:	c0d0302b c0d0305d c0d02f8f 00000000     +0..]0.../......
	...
c0d03cb8:	c0d03095 00000000 00000000 00000000     .0..............
c0d03cc8:	c0d031b9 c0d031b9 c0d031b9 c0d031c9     .1...1...1...1..

c0d03cd8 <USBD_CfgDesc>:
c0d03cd8:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03ce8:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03cf8:	05070100 00400302 00000001              ......@.....

c0d03d04 <USBD_DeviceQualifierDesc>:
c0d03d04:	0200060a 40000000 00000001              .......@....

c0d03d10 <_etext>:
	...

c0d03d40 <N_storage_real>:
	...
