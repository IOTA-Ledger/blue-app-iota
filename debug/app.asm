
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
c0d00014:	f001 f80e 	bl	c0d01034 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f000 ff5a 	bl	c0d00ed0 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 fbbf 	bl	c0d037a8 <setjmp>
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
c0d00040:	f001 f99e 	bl	c0d01380 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 fe7f 	bl	c0d01d48 <pic>
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
c0d0005a:	f001 fe75 	bl	c0d01d48 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 fec3 	bl	c0d01dec <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f002 ffca 	bl	c0d03000 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f002 ffc7 	bl	c0d03000 <USB_power>

            ui_idle();
c0d00072:	f002 f95b 	bl	c0d0232c <ui_idle>

            IOTA_main();
c0d00076:	f000 fddf 	bl	c0d00c38 <IOTA_main>
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
c0d0008c:	f003 fb98 	bl	c0d037c0 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d03c40 	.word	0xc0d03c40

c0d000a4 <add_index_to_seed_trints>:
// TODO: make sure we can add more index than uint32
// This may be an area where it's better just to have the seed in trits
// while adding index, then convert to trints later.
// Similarly is there no faster way to incr ??
int add_index_to_seed_trints(int8_t *trints, uint32_t index)
{
c0d000a4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d000a6:	af03      	add	r7, sp, #12
c0d000a8:	b089      	sub	sp, #36	; 0x24
c0d000aa:	9005      	str	r0, [sp, #20]
c0d000ac:	9102      	str	r1, [sp, #8]
    int8_t trits[5];
    uint8_t send = 5;
    
    for (uint32_t i = 0; i < index; i++) {
c0d000ae:	2900      	cmp	r1, #0
c0d000b0:	d05a      	beq.n	c0d00168 <add_index_to_seed_trints+0xc4>
c0d000b2:	2005      	movs	r0, #5
c0d000b4:	9004      	str	r0, [sp, #16]
c0d000b6:	2000      	movs	r0, #0
c0d000b8:	9001      	str	r0, [sp, #4]
c0d000ba:	4601      	mov	r1, r0
c0d000bc:	9103      	str	r1, [sp, #12]
c0d000be:	9c01      	ldr	r4, [sp, #4]
        // Add one
        uint8_t offset = 0;
        bool carry = true;
        while(carry && offset < 243) {
            if(offset % 5 == 0) {// we need a new set of trits
c0d000c0:	b2e0      	uxtb	r0, r4
c0d000c2:	2605      	movs	r6, #5
c0d000c4:	9006      	str	r0, [sp, #24]
c0d000c6:	4631      	mov	r1, r6
c0d000c8:	f003 f8de 	bl	c0d03288 <__aeabi_uidivmod>
c0d000cc:	460d      	mov	r5, r1
c0d000ce:	2d00      	cmp	r5, #0
c0d000d0:	d122      	bne.n	c0d00118 <add_index_to_seed_trints+0x74>
                //if offset/5 == 48 we are on last trint of only 3
                // this would be equivalent to if offset == 240;
                send = (offset/5 == 48) ? 3 : 5;
c0d000d2:	4620      	mov	r0, r4
c0d000d4:	3010      	adds	r0, #16
c0d000d6:	b2c0      	uxtb	r0, r0
c0d000d8:	2203      	movs	r2, #3
c0d000da:	2805      	cmp	r0, #5
c0d000dc:	d300      	bcc.n	c0d000e0 <add_index_to_seed_trints+0x3c>
c0d000de:	4632      	mov	r2, r6
c0d000e0:	9806      	ldr	r0, [sp, #24]
c0d000e2:	4631      	mov	r1, r6
c0d000e4:	4616      	mov	r6, r2
c0d000e6:	f003 f849 	bl	c0d0317c <__aeabi_uidiv>
c0d000ea:	4603      	mov	r3, r0
                
                //before we get new trint, write old trint
                if(offset != 0) //if this is the first trint, dont write
c0d000ec:	9806      	ldr	r0, [sp, #24]
c0d000ee:	2800      	cmp	r0, #0
c0d000f0:	9805      	ldr	r0, [sp, #20]
c0d000f2:	d00b      	beq.n	c0d0010c <add_index_to_seed_trints+0x68>
c0d000f4:	a807      	add	r0, sp, #28
                    trints[(offset/5) - 1] = trits_to_trint(&trits[0], send);
c0d000f6:	4631      	mov	r1, r6
c0d000f8:	9304      	str	r3, [sp, #16]
c0d000fa:	f000 f8a7 	bl	c0d0024c <trits_to_trint>
c0d000fe:	9b04      	ldr	r3, [sp, #16]
c0d00100:	9905      	ldr	r1, [sp, #20]
c0d00102:	18c9      	adds	r1, r1, r3
c0d00104:	2200      	movs	r2, #0
c0d00106:	43d2      	mvns	r2, r2
c0d00108:	5488      	strb	r0, [r1, r2]
c0d0010a:	9805      	ldr	r0, [sp, #20]
                
                //get new set of trits
                trint_to_trits(trints[offset/5], &trits[0], send);
c0d0010c:	56c0      	ldrsb	r0, [r0, r3]
c0d0010e:	a907      	add	r1, sp, #28
c0d00110:	9604      	str	r6, [sp, #16]
c0d00112:	4632      	mov	r2, r6
c0d00114:	f000 f8b6 	bl	c0d00284 <trint_to_trits>
c0d00118:	a807      	add	r0, sp, #28
            }
            
            trits[offset % 5] = trits[offset % 5] + 1;
c0d0011a:	5d41      	ldrb	r1, [r0, r5]
c0d0011c:	1c49      	adds	r1, r1, #1
c0d0011e:	5541      	strb	r1, [r0, r5]
c0d00120:	1940      	adds	r0, r0, r5
            if (trits[offset % 5] > 1) {
c0d00122:	0609      	lsls	r1, r1, #24
c0d00124:	2201      	movs	r2, #1
c0d00126:	0612      	lsls	r2, r2, #24
c0d00128:	4291      	cmp	r1, r2
c0d0012a:	dd08      	ble.n	c0d0013e <add_index_to_seed_trints+0x9a>
                trits[offset % 5] = -1;
c0d0012c:	210c      	movs	r1, #12
c0d0012e:	43c9      	mvns	r1, r1
c0d00130:	310c      	adds	r1, #12
c0d00132:	7001      	strb	r1, [r0, #0]
                
                //use (uint8_t) to auto truncate offset/5
                if(offset < 5) trints[0] = trits_to_trint(&trits[0], send);
                else trints[(uint8_t)(offset/5)] = trits_to_trint(&trits[0], send);
            }
            if (carry) {
c0d00134:	1c64      	adds	r4, r4, #1
c0d00136:	b2e0      	uxtb	r0, r4
    
    for (uint32_t i = 0; i < index; i++) {
        // Add one
        uint8_t offset = 0;
        bool carry = true;
        while(carry && offset < 243) {
c0d00138:	28f3      	cmp	r0, #243	; 0xf3
c0d0013a:	d3c1      	bcc.n	c0d000c0 <add_index_to_seed_trints+0x1c>
c0d0013c:	e00f      	b.n	c0d0015e <add_index_to_seed_trints+0xba>
            } else {
                //if we reach here, we are done so let's write the last trint
                carry = false;
                
                //use (uint8_t) to auto truncate offset/5
                if(offset < 5) trints[0] = trits_to_trint(&trits[0], send);
c0d0013e:	9804      	ldr	r0, [sp, #16]
c0d00140:	b241      	sxtb	r1, r0
c0d00142:	a807      	add	r0, sp, #28
c0d00144:	f000 f882 	bl	c0d0024c <trits_to_trint>
c0d00148:	4605      	mov	r5, r0
c0d0014a:	2000      	movs	r0, #0
c0d0014c:	9a06      	ldr	r2, [sp, #24]
c0d0014e:	2a05      	cmp	r2, #5
c0d00150:	d303      	bcc.n	c0d0015a <add_index_to_seed_trints+0xb6>
                else trints[(uint8_t)(offset/5)] = trits_to_trint(&trits[0], send);
c0d00152:	2105      	movs	r1, #5
c0d00154:	4610      	mov	r0, r2
c0d00156:	f003 f811 	bl	c0d0317c <__aeabi_uidiv>
c0d0015a:	9905      	ldr	r1, [sp, #20]
c0d0015c:	540d      	strb	r5, [r1, r0]
c0d0015e:	9903      	ldr	r1, [sp, #12]
int add_index_to_seed_trints(int8_t *trints, uint32_t index)
{
    int8_t trits[5];
    uint8_t send = 5;
    
    for (uint32_t i = 0; i < index; i++) {
c0d00160:	1c49      	adds	r1, r1, #1
c0d00162:	9802      	ldr	r0, [sp, #8]
c0d00164:	4281      	cmp	r1, r0
c0d00166:	d1a9      	bne.n	c0d000bc <add_index_to_seed_trints+0x18>
            }
            
            
        }
    }
    return 0;
c0d00168:	2000      	movs	r0, #0
c0d0016a:	b009      	add	sp, #36	; 0x24
c0d0016c:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00170 <generate_private_key_half>:
}

// generates half of a private key to encoded format of trints
int generate_private_key_half(trint_t *seed_trints, uint32_t index,
                              trint_t *private_key, char *msg)
{
c0d00170:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00172:	af03      	add	r7, sp, #12
c0d00174:	b089      	sub	sp, #36	; 0x24
c0d00176:	9306      	str	r3, [sp, #24]
c0d00178:	4614      	mov	r4, r2
c0d0017a:	4605      	mov	r5, r0
    // Add index -- keep in mind fix index_to_seed
    add_index_to_seed_trints(&seed_trints[0], index);
c0d0017c:	f7ff ff92 	bl	c0d000a4 <add_index_to_seed_trints>
    
    //Printing seed here will show us how our add_index went
    trit_t trits[5];
    trint_to_trits(seed_trints[0], &trits[0], 5);
c0d00180:	7828      	ldrb	r0, [r5, #0]
c0d00182:	b240      	sxtb	r0, r0
c0d00184:	ae07      	add	r6, sp, #28
c0d00186:	2205      	movs	r2, #5
c0d00188:	4631      	mov	r1, r6
c0d0018a:	f000 f87b 	bl	c0d00284 <trint_to_trits>
    
    snprintf(&msg[0], 64, "[%d][%d][%d][%d][%d]\n", trits[0], trits[1],
c0d0018e:	2001      	movs	r0, #1
c0d00190:	5630      	ldrsb	r0, [r6, r0]
             trits[2], trits[3], trits[4]);
c0d00192:	9005      	str	r0, [sp, #20]
c0d00194:	2102      	movs	r1, #2
c0d00196:	5670      	ldrsb	r0, [r6, r1]
c0d00198:	9004      	str	r0, [sp, #16]
c0d0019a:	2203      	movs	r2, #3
c0d0019c:	56b2      	ldrsb	r2, [r6, r2]
c0d0019e:	2304      	movs	r3, #4
c0d001a0:	56f3      	ldrsb	r3, [r6, r3]
    
    //Printing seed here will show us how our add_index went
    trit_t trits[5];
    trint_to_trits(seed_trints[0], &trits[0], 5);
    
    snprintf(&msg[0], 64, "[%d][%d][%d][%d][%d]\n", trits[0], trits[1],
c0d001a2:	7836      	ldrb	r6, [r6, #0]
c0d001a4:	4668      	mov	r0, sp
c0d001a6:	9905      	ldr	r1, [sp, #20]
c0d001a8:	6001      	str	r1, [r0, #0]
c0d001aa:	9904      	ldr	r1, [sp, #16]
c0d001ac:	1d00      	adds	r0, r0, #4
c0d001ae:	c00e      	stmia	r0!, {r1, r2, r3}
c0d001b0:	b273      	sxtb	r3, r6
c0d001b2:	2140      	movs	r1, #64	; 0x40
c0d001b4:	a210      	add	r2, pc, #64	; (adr r2, c0d001f8 <generate_private_key_half+0x88>)
c0d001b6:	9806      	ldr	r0, [sp, #24]
c0d001b8:	f001 fb76 	bl	c0d018a8 <snprintf>
             trits[2], trits[3], trits[4]);
    
    kerl_initialize();
c0d001bc:	f000 fb18 	bl	c0d007f0 <kerl_initialize>
c0d001c0:	2631      	movs	r6, #49	; 0x31
    kerl_absorb_trints(&seed_trints[0], 49);
c0d001c2:	4628      	mov	r0, r5
c0d001c4:	4631      	mov	r1, r6
c0d001c6:	f000 fb33 	bl	c0d00830 <kerl_absorb_trints>
    kerl_squeeze_trints(&private_key[0], 49);
c0d001ca:	4620      	mov	r0, r4
c0d001cc:	4631      	mov	r1, r6
c0d001ce:	f000 fb5f 	bl	c0d00890 <kerl_squeeze_trints>
    
    kerl_initialize();
c0d001d2:	f000 fb0d 	bl	c0d007f0 <kerl_initialize>
    kerl_absorb_trints(&seed_trints[0], 49);
c0d001d6:	4628      	mov	r0, r5
c0d001d8:	4631      	mov	r1, r6
c0d001da:	f000 fb29 	bl	c0d00830 <kerl_absorb_trints>
c0d001de:	251b      	movs	r5, #27
c0d001e0:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < level; i++) {
        for (uint8_t j = 0; j < 27; j++) {
            //27 chunks makes up half the private key
            
            // THIS SHOULD TAKE ROUGHLY 3 SECONDS ELSE IT HUNG
            kerl_squeeze_trints(&private_key[j * 49], 49);
c0d001e2:	4620      	mov	r0, r4
c0d001e4:	f000 fb54 	bl	c0d00890 <kerl_squeeze_trints>
    kerl_absorb_trints(&seed_trints[0], 49);
    
    //Set level to be 1 - only do first half of private key for now
    int8_t level = 1;
    for (uint8_t i = 0; i < level; i++) {
        for (uint8_t j = 0; j < 27; j++) {
c0d001e8:	1e6d      	subs	r5, r5, #1
c0d001ea:	3431      	adds	r4, #49	; 0x31
c0d001ec:	2d00      	cmp	r5, #0
c0d001ee:	d1f7      	bne.n	c0d001e0 <generate_private_key_half+0x70>
            
            // THIS SHOULD TAKE ROUGHLY 3 SECONDS ELSE IT HUNG
            kerl_squeeze_trints(&private_key[j * 49], 49);
        }
    }
    return 0;
c0d001f0:	2000      	movs	r0, #0
c0d001f2:	b009      	add	sp, #36	; 0x24
c0d001f4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d001f6:	46c0      	nop			; (mov r8, r8)
c0d001f8:	5d64255b 	.word	0x5d64255b
c0d001fc:	5d64255b 	.word	0x5d64255b
c0d00200:	5d64255b 	.word	0x5d64255b
c0d00204:	5d64255b 	.word	0x5d64255b
c0d00208:	5d64255b 	.word	0x5d64255b
c0d0020c:	0000000a 	.word	0x0000000a

c0d00210 <write_debug>:

char debug_str[64];

//write_debug(&words, sizeof(words), TYPE_STR);
//write_debug(&int_val, sizeof(int_val), TYPE_INT);
void write_debug(void* o, unsigned int sz, uint8_t t) {
c0d00210:	b580      	push	{r7, lr}
c0d00212:	af00      	add	r7, sp, #0
c0d00214:	4603      	mov	r3, r0

    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
c0d00216:	2a03      	cmp	r2, #3
c0d00218:	d007      	beq.n	c0d0022a <write_debug+0x1a>
c0d0021a:	2a02      	cmp	r2, #2
c0d0021c:	d008      	beq.n	c0d00230 <write_debug+0x20>
c0d0021e:	2a01      	cmp	r2, #1
c0d00220:	d10b      	bne.n	c0d0023a <write_debug+0x2a>
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
c0d00222:	681b      	ldr	r3, [r3, #0]
c0d00224:	4805      	ldr	r0, [pc, #20]	; (c0d0023c <write_debug+0x2c>)
c0d00226:	a208      	add	r2, pc, #32	; (adr r2, c0d00248 <write_debug+0x38>)
c0d00228:	e005      	b.n	c0d00236 <write_debug+0x26>
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
c0d0022a:	4804      	ldr	r0, [pc, #16]	; (c0d0023c <write_debug+0x2c>)
c0d0022c:	a204      	add	r2, pc, #16	; (adr r2, c0d00240 <write_debug+0x30>)
c0d0022e:	e002      	b.n	c0d00236 <write_debug+0x26>
    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
c0d00230:	681b      	ldr	r3, [r3, #0]
c0d00232:	4802      	ldr	r0, [pc, #8]	; (c0d0023c <write_debug+0x2c>)
c0d00234:	a203      	add	r2, pc, #12	; (adr r2, c0d00244 <write_debug+0x34>)
c0d00236:	f001 fb37 	bl	c0d018a8 <snprintf>
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
    }
}
c0d0023a:	bd80      	pop	{r7, pc}
c0d0023c:	20001800 	.word	0x20001800
c0d00240:	00007325 	.word	0x00007325
c0d00244:	00007525 	.word	0x00007525
c0d00248:	00006425 	.word	0x00006425

c0d0024c <trits_to_trint>:
        pow3_val /= 3;
    }
}

//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
c0d0024c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0024e:	af03      	add	r7, sp, #12
c0d00250:	2200      	movs	r2, #0
    int8_t pow3_val = 1;
    int8_t ret = 0;
    
    for(int8_t i=sz-1; i>=0; i--)
c0d00252:	43d3      	mvns	r3, r2
c0d00254:	b2c9      	uxtb	r1, r1
c0d00256:	31ff      	adds	r1, #255	; 0xff
c0d00258:	b24c      	sxtb	r4, r1
c0d0025a:	2c00      	cmp	r4, #0
c0d0025c:	db0f      	blt.n	c0d0027e <trits_to_trint+0x32>
c0d0025e:	1900      	adds	r0, r0, r4
c0d00260:	2401      	movs	r4, #1
c0d00262:	2200      	movs	r2, #0
    {
        ret += trits[i]*pow3_val;
c0d00264:	b265      	sxtb	r5, r4
        pow3_val *= 3;
c0d00266:	2403      	movs	r4, #3
c0d00268:	436c      	muls	r4, r5
    int8_t pow3_val = 1;
    int8_t ret = 0;
    
    for(int8_t i=sz-1; i>=0; i--)
    {
        ret += trits[i]*pow3_val;
c0d0026a:	7806      	ldrb	r6, [r0, #0]
c0d0026c:	b276      	sxtb	r6, r6
c0d0026e:	436e      	muls	r6, r5
c0d00270:	b2d2      	uxtb	r2, r2
c0d00272:	18b2      	adds	r2, r6, r2
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;
    
    for(int8_t i=sz-1; i>=0; i--)
c0d00274:	1e40      	subs	r0, r0, #1
c0d00276:	1e49      	subs	r1, r1, #1
c0d00278:	b249      	sxtb	r1, r1
c0d0027a:	4299      	cmp	r1, r3
c0d0027c:	dcf2      	bgt.n	c0d00264 <trits_to_trint+0x18>
    {
        ret += trits[i]*pow3_val;
        pow3_val *= 3;
    }
    
    return ret;
c0d0027e:	b250      	sxtb	r0, r2
c0d00280:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00284 <trint_to_trits>:
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
c0d00284:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00286:	af03      	add	r7, sp, #12
c0d00288:	b083      	sub	sp, #12
c0d0028a:	9100      	str	r1, [sp, #0]
c0d0028c:	4603      	mov	r3, r0
c0d0028e:	9201      	str	r2, [sp, #4]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;
    
    for(uint8_t j = 0; j<sz; j++) {
c0d00290:	2a01      	cmp	r2, #1
c0d00292:	db2b      	blt.n	c0d002ec <trint_to_trits+0x68>
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
c0d00294:	2009      	movs	r0, #9
c0d00296:	2151      	movs	r1, #81	; 0x51
c0d00298:	9a01      	ldr	r2, [sp, #4]
c0d0029a:	2a03      	cmp	r2, #3
c0d0029c:	d000      	beq.n	c0d002a0 <trint_to_trits+0x1c>
c0d0029e:	4608      	mov	r0, r1
c0d002a0:	2500      	movs	r5, #0
c0d002a2:	462e      	mov	r6, r5
        pow3_val = 9;
    
    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d002a4:	b2c4      	uxtb	r4, r0
c0d002a6:	b258      	sxtb	r0, r3
c0d002a8:	9002      	str	r0, [sp, #8]
c0d002aa:	0040      	lsls	r0, r0, #1
c0d002ac:	4621      	mov	r1, r4
c0d002ae:	f002 ffef 	bl	c0d03290 <__aeabi_idiv>
c0d002b2:	9900      	ldr	r1, [sp, #0]
c0d002b4:	5548      	strb	r0, [r1, r5]
c0d002b6:	194a      	adds	r2, r1, r5
        
        
        if(trits_r[j] > 1) trits_r[j] = 1;
c0d002b8:	0603      	lsls	r3, r0, #24
c0d002ba:	2101      	movs	r1, #1
c0d002bc:	060d      	lsls	r5, r1, #24
c0d002be:	42ab      	cmp	r3, r5
c0d002c0:	dc03      	bgt.n	c0d002ca <trint_to_trits+0x46>
c0d002c2:	21ff      	movs	r1, #255	; 0xff
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d002c4:	4d0a      	ldr	r5, [pc, #40]	; (c0d002f0 <trint_to_trits+0x6c>)
c0d002c6:	42ab      	cmp	r3, r5
c0d002c8:	dc01      	bgt.n	c0d002ce <trint_to_trits+0x4a>
c0d002ca:	7011      	strb	r1, [r2, #0]
c0d002cc:	e000      	b.n	c0d002d0 <trint_to_trits+0x4c>
        
        integ -= trits_r[j] * pow3_val;
c0d002ce:	4601      	mov	r1, r0
c0d002d0:	9a02      	ldr	r2, [sp, #8]
c0d002d2:	b248      	sxtb	r0, r1
c0d002d4:	4360      	muls	r0, r4
c0d002d6:	1a15      	subs	r5, r2, r0
        pow3_val /= 3;
c0d002d8:	2103      	movs	r1, #3
c0d002da:	4620      	mov	r0, r4
c0d002dc:	f002 ff4e 	bl	c0d0317c <__aeabi_uidiv>
c0d002e0:	462b      	mov	r3, r5
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;
    
    for(uint8_t j = 0; j<sz; j++) {
c0d002e2:	1c76      	adds	r6, r6, #1
c0d002e4:	b2f5      	uxtb	r5, r6
c0d002e6:	9901      	ldr	r1, [sp, #4]
c0d002e8:	428d      	cmp	r5, r1
c0d002ea:	dbdb      	blt.n	c0d002a4 <trint_to_trits+0x20>
        else if(trits_r[j] < -1) trits_r[j] = -1;
        
        integ -= trits_r[j] * pow3_val;
        pow3_val /= 3;
    }
}
c0d002ec:	b003      	add	sp, #12
c0d002ee:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d002f0:	feffffff 	.word	0xfeffffff

c0d002f4 <get_seed>:
    return ret;
}

void do_nothing() {}

void get_seed(unsigned char *privateKey, uint8_t sz, char *msg) {
c0d002f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d002f6:	af03      	add	r7, sp, #12
c0d002f8:	b0ff      	sub	sp, #508	; 0x1fc
c0d002fa:	b0ff      	sub	sp, #508	; 0x1fc
c0d002fc:	b0dd      	sub	sp, #372	; 0x174
c0d002fe:	9202      	str	r2, [sp, #8]
c0d00300:	460e      	mov	r6, r1
c0d00302:	4605      	mov	r5, r0
    
    //kerl requires 424 bytes
    kerl_initialize();
c0d00304:	9501      	str	r5, [sp, #4]
c0d00306:	f000 fa73 	bl	c0d007f0 <kerl_initialize>
    
    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d0030a:	f000 fa71 	bl	c0d007f0 <kerl_initialize>
c0d0030e:	ac10      	add	r4, sp, #64	; 0x40

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d00310:	4620      	mov	r0, r4
c0d00312:	4629      	mov	r1, r5
c0d00314:	4632      	mov	r2, r6
c0d00316:	f003 f9b7 	bl	c0d03688 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d0031a:	19a0      	adds	r0, r4, r6
c0d0031c:	2530      	movs	r5, #48	; 0x30
c0d0031e:	1baa      	subs	r2, r5, r6
c0d00320:	9901      	ldr	r1, [sp, #4]
c0d00322:	f003 f9b1 	bl	c0d03688 <__aeabi_memcpy>
        
        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00326:	4620      	mov	r0, r4
c0d00328:	4629      	mov	r1, r5
c0d0032a:	f000 fa6d 	bl	c0d00808 <kerl_absorb_bytes>
c0d0032e:	ac03      	add	r4, sp, #12
    }
    
    trint_t seed_trints[49];
    kerl_squeeze_trints(&seed_trints[0], 49);
c0d00330:	2131      	movs	r1, #49	; 0x31
c0d00332:	4620      	mov	r0, r4
c0d00334:	f000 faac 	bl	c0d00890 <kerl_squeeze_trints>

//write func to get private key
void get_private_key(trint_t *seed_trints, uint32_t idx, char *msg) {
    //currently able to store 29 - [-1][-1][-1][0][-1]
    trint_t private_key_trints[49 * 27]; //trints are still just int8_t but encoded
    generate_private_key_half(seed_trints, idx, &private_key_trints[0], msg);
c0d00338:	2103      	movs	r1, #3
c0d0033a:	aa10      	add	r2, sp, #64	; 0x40
c0d0033c:	4620      	mov	r0, r4
c0d0033e:	9b02      	ldr	r3, [sp, #8]
c0d00340:	f7ff ff16 	bl	c0d00170 <generate_private_key_half>
    //null terminate seed
    //seed_chars[81] = '\0';
    
    //pass trints to private key func and let it handle the response
    get_private_key(&seed_trints[0], 3, msg);
}
c0d00344:	1ffc      	subs	r4, r7, #7
c0d00346:	3c05      	subs	r4, #5
c0d00348:	46a5      	mov	sp, r4
c0d0034a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0034c <bigint_add_int>:
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
    return ret;
}

int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
c0d0034c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0034e:	af03      	add	r7, sp, #12
c0d00350:	b087      	sub	sp, #28
c0d00352:	9105      	str	r1, [sp, #20]
c0d00354:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00356:	2b00      	cmp	r3, #0
c0d00358:	d03a      	beq.n	c0d003d0 <bigint_add_int+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0035a:	2100      	movs	r1, #0
c0d0035c:	43cc      	mvns	r4, r1
c0d0035e:	9400      	str	r4, [sp, #0]
c0d00360:	460e      	mov	r6, r1
c0d00362:	460c      	mov	r4, r1
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_in[i], val.low, val.hi);
c0d00364:	9101      	str	r1, [sp, #4]
c0d00366:	9302      	str	r3, [sp, #8]
c0d00368:	9203      	str	r2, [sp, #12]
c0d0036a:	9b00      	ldr	r3, [sp, #0]
c0d0036c:	460a      	mov	r2, r1
c0d0036e:	4605      	mov	r5, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00370:	cd01      	ldmia	r5!, {r0}
c0d00372:	9504      	str	r5, [sp, #16]
c0d00374:	9905      	ldr	r1, [sp, #20]
c0d00376:	1841      	adds	r1, r0, r1
c0d00378:	4156      	adcs	r6, r2
c0d0037a:	9106      	str	r1, [sp, #24]
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d0037c:	4019      	ands	r1, r3
c0d0037e:	1c49      	adds	r1, r1, #1
c0d00380:	4615      	mov	r5, r2
c0d00382:	416d      	adcs	r5, r5
c0d00384:	2001      	movs	r0, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00386:	4004      	ands	r4, r0
c0d00388:	4622      	mov	r2, r4
c0d0038a:	2c00      	cmp	r4, #0
c0d0038c:	d100      	bne.n	c0d00390 <bigint_add_int+0x44>
c0d0038e:	9906      	ldr	r1, [sp, #24]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00390:	4299      	cmp	r1, r3
c0d00392:	9006      	str	r0, [sp, #24]
c0d00394:	d800      	bhi.n	c0d00398 <bigint_add_int+0x4c>
c0d00396:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00398:	2a00      	cmp	r2, #0
c0d0039a:	4632      	mov	r2, r6
c0d0039c:	d100      	bne.n	c0d003a0 <bigint_add_int+0x54>
c0d0039e:	4615      	mov	r5, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003a0:	2d00      	cmp	r5, #0
c0d003a2:	9e06      	ldr	r6, [sp, #24]
c0d003a4:	d100      	bne.n	c0d003a8 <bigint_add_int+0x5c>
c0d003a6:	462e      	mov	r6, r5
c0d003a8:	2d00      	cmp	r5, #0
c0d003aa:	d000      	beq.n	c0d003ae <bigint_add_int+0x62>
c0d003ac:	4630      	mov	r0, r6
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d003ae:	4310      	orrs	r0, r2
c0d003b0:	b2c0      	uxtb	r0, r0
c0d003b2:	2800      	cmp	r0, #0
c0d003b4:	9b02      	ldr	r3, [sp, #8]
c0d003b6:	9a03      	ldr	r2, [sp, #12]
c0d003b8:	9c01      	ldr	r4, [sp, #4]
c0d003ba:	d100      	bne.n	c0d003be <bigint_add_int+0x72>
c0d003bc:	9006      	str	r0, [sp, #24]
        val = full_add(bigint_in[i], val.low, val.hi);
        bigint_out[i] = val.low;
c0d003be:	c202      	stmia	r2!, {r1}
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d003c0:	1e5b      	subs	r3, r3, #1
c0d003c2:	9405      	str	r4, [sp, #20]
c0d003c4:	4626      	mov	r6, r4
c0d003c6:	9d06      	ldr	r5, [sp, #24]
c0d003c8:	4621      	mov	r1, r4
c0d003ca:	462c      	mov	r4, r5
c0d003cc:	9804      	ldr	r0, [sp, #16]
c0d003ce:	d1ca      	bne.n	c0d00366 <bigint_add_int+0x1a>
        bigint_out[i] = val.low;
        val.low = 0;
    }

    if (val.hi) {
        return -1;
c0d003d0:	4268      	negs	r0, r5
    }
    return 0;
}
c0d003d2:	b007      	add	sp, #28
c0d003d4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d003d6 <bigint_add_bigint>:

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d003d6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003d8:	af03      	add	r7, sp, #12
c0d003da:	b086      	sub	sp, #24
c0d003dc:	461c      	mov	r4, r3
c0d003de:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d003e0:	2c00      	cmp	r4, #0
c0d003e2:	d034      	beq.n	c0d0044e <bigint_add_bigint+0x78>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003e4:	2600      	movs	r6, #0
c0d003e6:	43f3      	mvns	r3, r6
c0d003e8:	9300      	str	r3, [sp, #0]
c0d003ea:	9601      	str	r6, [sp, #4]
c0d003ec:	9202      	str	r2, [sp, #8]
c0d003ee:	9403      	str	r4, [sp, #12]
c0d003f0:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d003f2:	cc01      	ldmia	r4!, {r0}
c0d003f4:	9404      	str	r4, [sp, #16]
c0d003f6:	460c      	mov	r4, r1
c0d003f8:	cc02      	ldmia	r4!, {r1}
c0d003fa:	9405      	str	r4, [sp, #20]
c0d003fc:	180a      	adds	r2, r1, r0
c0d003fe:	9d01      	ldr	r5, [sp, #4]
c0d00400:	462c      	mov	r4, r5
c0d00402:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00404:	4611      	mov	r1, r2
c0d00406:	9800      	ldr	r0, [sp, #0]
c0d00408:	4001      	ands	r1, r0
c0d0040a:	1c4b      	adds	r3, r1, #1
c0d0040c:	4629      	mov	r1, r5
c0d0040e:	4149      	adcs	r1, r1
c0d00410:	2501      	movs	r5, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00412:	402e      	ands	r6, r5
c0d00414:	2e00      	cmp	r6, #0
c0d00416:	d100      	bne.n	c0d0041a <bigint_add_bigint+0x44>
c0d00418:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0041a:	4283      	cmp	r3, r0
c0d0041c:	4628      	mov	r0, r5
c0d0041e:	d800      	bhi.n	c0d00422 <bigint_add_bigint+0x4c>
c0d00420:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00422:	2e00      	cmp	r6, #0
c0d00424:	9a02      	ldr	r2, [sp, #8]
c0d00426:	d100      	bne.n	c0d0042a <bigint_add_bigint+0x54>
c0d00428:	4621      	mov	r1, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0042a:	2900      	cmp	r1, #0
c0d0042c:	462e      	mov	r6, r5
c0d0042e:	d100      	bne.n	c0d00432 <bigint_add_bigint+0x5c>
c0d00430:	460e      	mov	r6, r1
c0d00432:	2900      	cmp	r1, #0
c0d00434:	d000      	beq.n	c0d00438 <bigint_add_bigint+0x62>
c0d00436:	4630      	mov	r0, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d00438:	4320      	orrs	r0, r4

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d0043a:	2800      	cmp	r0, #0
c0d0043c:	9905      	ldr	r1, [sp, #20]
c0d0043e:	d100      	bne.n	c0d00442 <bigint_add_bigint+0x6c>
c0d00440:	4605      	mov	r5, r0
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d00442:	c208      	stmia	r2!, {r3}
c0d00444:	9c03      	ldr	r4, [sp, #12]

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00446:	1e64      	subs	r4, r4, #1
c0d00448:	462e      	mov	r6, r5
c0d0044a:	9804      	ldr	r0, [sp, #16]
c0d0044c:	d1ce      	bne.n	c0d003ec <bigint_add_bigint+0x16>
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }

    if (val.hi) {
        return -1;
c0d0044e:	4268      	negs	r0, r5
    }
    return 0;
}
c0d00450:	b006      	add	sp, #24
c0d00452:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00454 <bigint_sub_bigint>:

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d00454:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00456:	af03      	add	r7, sp, #12
c0d00458:	b087      	sub	sp, #28
c0d0045a:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0045c:	2d00      	cmp	r5, #0
c0d0045e:	d037      	beq.n	c0d004d0 <bigint_sub_bigint+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00460:	2400      	movs	r4, #0
c0d00462:	9402      	str	r4, [sp, #8]
c0d00464:	43e3      	mvns	r3, r4
c0d00466:	9301      	str	r3, [sp, #4]
c0d00468:	2601      	movs	r6, #1
c0d0046a:	9600      	str	r6, [sp, #0]
c0d0046c:	9203      	str	r2, [sp, #12]
c0d0046e:	9504      	str	r5, [sp, #16]
c0d00470:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00472:	cc01      	ldmia	r4!, {r0}
c0d00474:	9405      	str	r4, [sp, #20]
c0d00476:	460c      	mov	r4, r1
int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d00478:	cc02      	ldmia	r4!, {r1}
c0d0047a:	9406      	str	r4, [sp, #24]
c0d0047c:	43c9      	mvns	r1, r1
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0047e:	180a      	adds	r2, r1, r0
c0d00480:	9902      	ldr	r1, [sp, #8]
c0d00482:	460c      	mov	r4, r1
c0d00484:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00486:	4610      	mov	r0, r2
c0d00488:	9d01      	ldr	r5, [sp, #4]
c0d0048a:	4028      	ands	r0, r5
c0d0048c:	1c43      	adds	r3, r0, #1
c0d0048e:	4608      	mov	r0, r1
c0d00490:	4140      	adcs	r0, r0
c0d00492:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00494:	400e      	ands	r6, r1
c0d00496:	2e00      	cmp	r6, #0
c0d00498:	d100      	bne.n	c0d0049c <bigint_sub_bigint+0x48>
c0d0049a:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0049c:	42ab      	cmp	r3, r5
c0d0049e:	460d      	mov	r5, r1
c0d004a0:	d800      	bhi.n	c0d004a4 <bigint_sub_bigint+0x50>
c0d004a2:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d004a4:	2e00      	cmp	r6, #0
c0d004a6:	9a03      	ldr	r2, [sp, #12]
c0d004a8:	d100      	bne.n	c0d004ac <bigint_sub_bigint+0x58>
c0d004aa:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004ac:	2800      	cmp	r0, #0
c0d004ae:	460e      	mov	r6, r1
c0d004b0:	d100      	bne.n	c0d004b4 <bigint_sub_bigint+0x60>
c0d004b2:	4606      	mov	r6, r0
c0d004b4:	2800      	cmp	r0, #0
c0d004b6:	d000      	beq.n	c0d004ba <bigint_sub_bigint+0x66>
c0d004b8:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d004ba:	4325      	orrs	r5, r4

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d004bc:	2d00      	cmp	r5, #0
c0d004be:	460e      	mov	r6, r1
c0d004c0:	9805      	ldr	r0, [sp, #20]
c0d004c2:	d100      	bne.n	c0d004c6 <bigint_sub_bigint+0x72>
c0d004c4:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d004c6:	c208      	stmia	r2!, {r3}
c0d004c8:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d004ca:	1e6d      	subs	r5, r5, #1
c0d004cc:	9906      	ldr	r1, [sp, #24]
c0d004ce:	d1cd      	bne.n	c0d0046c <bigint_sub_bigint+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d004d0:	2000      	movs	r0, #0
c0d004d2:	b007      	add	sp, #28
c0d004d4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d004d6 <bigint_cmp_bigint>:
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
c0d004d6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004d8:	af03      	add	r7, sp, #12
c0d004da:	b081      	sub	sp, #4
c0d004dc:	2400      	movs	r4, #0
c0d004de:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d004e0:	32ff      	adds	r2, #255	; 0xff
c0d004e2:	b253      	sxtb	r3, r2
c0d004e4:	2b00      	cmp	r3, #0
c0d004e6:	db0f      	blt.n	c0d00508 <bigint_cmp_bigint+0x32>
c0d004e8:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d004ea:	009b      	lsls	r3, r3, #2
c0d004ec:	58ce      	ldr	r6, [r1, r3]
c0d004ee:	58c4      	ldr	r4, [r0, r3]
c0d004f0:	2301      	movs	r3, #1
c0d004f2:	42b4      	cmp	r4, r6
c0d004f4:	dc0b      	bgt.n	c0d0050e <bigint_cmp_bigint+0x38>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d004f6:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d004f8:	42b4      	cmp	r4, r6
c0d004fa:	db07      	blt.n	c0d0050c <bigint_cmp_bigint+0x36>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d004fc:	b253      	sxtb	r3, r2
c0d004fe:	42ab      	cmp	r3, r5
c0d00500:	461a      	mov	r2, r3
c0d00502:	dcf2      	bgt.n	c0d004ea <bigint_cmp_bigint+0x14>
c0d00504:	9b00      	ldr	r3, [sp, #0]
c0d00506:	e002      	b.n	c0d0050e <bigint_cmp_bigint+0x38>
c0d00508:	4623      	mov	r3, r4
c0d0050a:	e000      	b.n	c0d0050e <bigint_cmp_bigint+0x38>
c0d0050c:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d0050e:	4618      	mov	r0, r3
c0d00510:	b001      	add	sp, #4
c0d00512:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00514 <bigint_not>:

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00514:	2900      	cmp	r1, #0
c0d00516:	d004      	beq.n	c0d00522 <bigint_not+0xe>
        bigint[i] = ~bigint[i];
c0d00518:	6802      	ldr	r2, [r0, #0]
c0d0051a:	43d2      	mvns	r2, r2
c0d0051c:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0051e:	1e49      	subs	r1, r1, #1
c0d00520:	d1fa      	bne.n	c0d00518 <bigint_not+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d00522:	2000      	movs	r0, #0
c0d00524:	4770      	bx	lr

c0d00526 <words_to_bytes>:

    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
c0d00526:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00528:	af03      	add	r7, sp, #12
c0d0052a:	b082      	sub	sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d0052c:	2a00      	cmp	r2, #0
c0d0052e:	d01a      	beq.n	c0d00566 <words_to_bytes+0x40>
c0d00530:	0093      	lsls	r3, r2, #2
c0d00532:	18c0      	adds	r0, r0, r3
c0d00534:	1f00      	subs	r0, r0, #4
c0d00536:	2303      	movs	r3, #3
c0d00538:	43db      	mvns	r3, r3
c0d0053a:	9301      	str	r3, [sp, #4]
c0d0053c:	4252      	negs	r2, r2
c0d0053e:	9200      	str	r2, [sp, #0]
c0d00540:	2400      	movs	r4, #0
        bytes_out[i*4+0] = (words_in[word_len-1-i] >> 24);
c0d00542:	9d01      	ldr	r5, [sp, #4]
c0d00544:	4365      	muls	r5, r4
c0d00546:	00a6      	lsls	r6, r4, #2
c0d00548:	1983      	adds	r3, r0, r6
c0d0054a:	78da      	ldrb	r2, [r3, #3]
c0d0054c:	554a      	strb	r2, [r1, r5]
c0d0054e:	194a      	adds	r2, r1, r5
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
c0d00550:	885b      	ldrh	r3, [r3, #2]
c0d00552:	7053      	strb	r3, [r2, #1]
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
c0d00554:	5983      	ldr	r3, [r0, r6]
c0d00556:	0a1b      	lsrs	r3, r3, #8
c0d00558:	7093      	strb	r3, [r2, #2]
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
c0d0055a:	5983      	ldr	r3, [r0, r6]
c0d0055c:	70d3      	strb	r3, [r2, #3]
    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d0055e:	1e64      	subs	r4, r4, #1
c0d00560:	9a00      	ldr	r2, [sp, #0]
c0d00562:	42a2      	cmp	r2, r4
c0d00564:	d1ed      	bne.n	c0d00542 <words_to_bytes+0x1c>
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
    }

    return 0;
c0d00566:	2000      	movs	r0, #0
c0d00568:	b002      	add	sp, #8
c0d0056a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0056c <bytes_to_words>:
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
c0d0056c:	b5d0      	push	{r4, r6, r7, lr}
c0d0056e:	af02      	add	r7, sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d00570:	2a00      	cmp	r2, #0
c0d00572:	d015      	beq.n	c0d005a0 <bytes_to_words+0x34>
c0d00574:	0093      	lsls	r3, r2, #2
c0d00576:	18c0      	adds	r0, r0, r3
c0d00578:	1f00      	subs	r0, r0, #4
c0d0057a:	2300      	movs	r3, #0
        words_out[i] = 0;
c0d0057c:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
c0d0057e:	7803      	ldrb	r3, [r0, #0]
c0d00580:	061b      	lsls	r3, r3, #24
c0d00582:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
c0d00584:	7844      	ldrb	r4, [r0, #1]
c0d00586:	0424      	lsls	r4, r4, #16
c0d00588:	431c      	orrs	r4, r3
c0d0058a:	600c      	str	r4, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
c0d0058c:	7883      	ldrb	r3, [r0, #2]
c0d0058e:	021b      	lsls	r3, r3, #8
c0d00590:	4323      	orrs	r3, r4
c0d00592:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
c0d00594:	78c4      	ldrb	r4, [r0, #3]
c0d00596:	431c      	orrs	r4, r3
c0d00598:	c110      	stmia	r1!, {r4}
    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d0059a:	1f00      	subs	r0, r0, #4
c0d0059c:	1e52      	subs	r2, r2, #1
c0d0059e:	d1ec      	bne.n	c0d0057a <bytes_to_words+0xe>
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
    }
    return 0;
c0d005a0:	2000      	movs	r0, #0
c0d005a2:	bdd0      	pop	{r4, r6, r7, pc}

c0d005a4 <trints_to_words>:
}

//custom conversion straight from trints to words
int trints_to_words(trint_t *trints_in, int32_t words_out[])
{
c0d005a4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005a6:	af03      	add	r7, sp, #12
c0d005a8:	b0a1      	sub	sp, #132	; 0x84
c0d005aa:	9101      	str	r1, [sp, #4]
c0d005ac:	9002      	str	r0, [sp, #8]
c0d005ae:	a814      	add	r0, sp, #80	; 0x50
    int32_t base[13] = {0};
c0d005b0:	2134      	movs	r1, #52	; 0x34
c0d005b2:	f003 f863 	bl	c0d0367c <__aeabi_memclr>
c0d005b6:	2430      	movs	r4, #48	; 0x30
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
c0d005b8:	2603      	movs	r6, #3
c0d005ba:	2005      	movs	r0, #5
c0d005bc:	2c30      	cmp	r4, #48	; 0x30
c0d005be:	d000      	beq.n	c0d005c2 <trints_to_words+0x1e>
c0d005c0:	4606      	mov	r6, r0
        trint_to_trits(trints_in[x], &trits[0], get);
c0d005c2:	9802      	ldr	r0, [sp, #8]
c0d005c4:	5700      	ldrsb	r0, [r0, r4]
c0d005c6:	a912      	add	r1, sp, #72	; 0x48
c0d005c8:	4632      	mov	r2, r6
c0d005ca:	f7ff fe5b 	bl	c0d00284 <trint_to_trits>
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d005ce:	4833      	ldr	r0, [pc, #204]	; (c0d0069c <trints_to_words+0xf8>)
c0d005d0:	1832      	adds	r2, r6, r0
c0d005d2:	2006      	movs	r0, #6
c0d005d4:	4010      	ands	r0, r2
            // multiply
            {
                int32_t sz = size;
                int32_t carry = 0;
                
                for (int32_t j = 0; j < sz; j++) {
c0d005d6:	1e76      	subs	r6, r6, #1
c0d005d8:	9403      	str	r4, [sp, #12]
            
            // add
            {
                int32_t tmp[12];
                // Ignore the last trit (48 is last trint, 2 is last trit in that trint)
                if (x == 48 & i == 2) {
c0d005da:	2c30      	cmp	r4, #48	; 0x30
c0d005dc:	9204      	str	r2, [sp, #16]
c0d005de:	d105      	bne.n	c0d005ec <trints_to_words+0x48>
c0d005e0:	b2b1      	uxth	r1, r6
c0d005e2:	2902      	cmp	r1, #2
c0d005e4:	d102      	bne.n	c0d005ec <trints_to_words+0x48>
c0d005e6:	a814      	add	r0, sp, #80	; 0x50
                    bigint_add_int(base, 1, tmp, 13);
c0d005e8:	2101      	movs	r1, #1
c0d005ea:	e003      	b.n	c0d005f4 <trints_to_words+0x50>
c0d005ec:	a912      	add	r1, sp, #72	; 0x48
                } else {
                    bigint_add_int(base, trits[i]+1, tmp, 13);
c0d005ee:	5608      	ldrsb	r0, [r1, r0]
c0d005f0:	1c41      	adds	r1, r0, #1
c0d005f2:	a814      	add	r0, sp, #80	; 0x50
c0d005f4:	aa05      	add	r2, sp, #20
c0d005f6:	230d      	movs	r3, #13
c0d005f8:	f7ff fea8 	bl	c0d0034c <bigint_add_int>
c0d005fc:	a805      	add	r0, sp, #20
c0d005fe:	a914      	add	r1, sp, #80	; 0x50
                }
                memcpy(base, tmp, 52);
c0d00600:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00602:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00604:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00606:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00608:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d0060a:	c11c      	stmia	r1!, {r2, r3, r4}
c0d0060c:	c83c      	ldmia	r0!, {r2, r3, r4, r5}
c0d0060e:	c13c      	stmia	r1!, {r2, r3, r4, r5}
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
        trint_to_trits(trints_in[x], &trits[0], get);
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d00610:	1e76      	subs	r6, r6, #1
c0d00612:	9804      	ldr	r0, [sp, #16]
c0d00614:	1e40      	subs	r0, r0, #1
c0d00616:	b200      	sxth	r0, r0
c0d00618:	2800      	cmp	r0, #0
c0d0061a:	4602      	mov	r2, r0
c0d0061c:	9c03      	ldr	r4, [sp, #12]
c0d0061e:	dadc      	bge.n	c0d005da <trints_to_words+0x36>
    int32_t size = 13;
    trit_t trits[5]; // on final call only left 3 trits matter
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
c0d00620:	1e60      	subs	r0, r4, #1
c0d00622:	2c00      	cmp	r4, #0
c0d00624:	4604      	mov	r4, r0
c0d00626:	dcc7      	bgt.n	c0d005b8 <trints_to_words+0x14>
                // todo sz>size stuff
            }
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
c0d00628:	481d      	ldr	r0, [pc, #116]	; (c0d006a0 <trints_to_words+0xfc>)
c0d0062a:	4478      	add	r0, pc
c0d0062c:	a914      	add	r1, sp, #80	; 0x50
c0d0062e:	220d      	movs	r2, #13
c0d00630:	f7ff ff51 	bl	c0d004d6 <bigint_cmp_bigint>
c0d00634:	2801      	cmp	r0, #1
c0d00636:	db14      	blt.n	c0d00662 <trints_to_words+0xbe>
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d00638:	481b      	ldr	r0, [pc, #108]	; (c0d006a8 <trints_to_words+0x104>)
c0d0063a:	4478      	add	r0, pc
c0d0063c:	ad14      	add	r5, sp, #80	; 0x50
c0d0063e:	ac05      	add	r4, sp, #20
c0d00640:	260d      	movs	r6, #13
c0d00642:	4629      	mov	r1, r5
c0d00644:	4622      	mov	r2, r4
c0d00646:	4633      	mov	r3, r6
c0d00648:	f7ff ff04 	bl	c0d00454 <bigint_sub_bigint>
        bigint_not(tmp, 13);
c0d0064c:	4620      	mov	r0, r4
c0d0064e:	4631      	mov	r1, r6
c0d00650:	f7ff ff60 	bl	c0d00514 <bigint_not>
        bigint_add_int(tmp, 1, base, 13);
c0d00654:	2101      	movs	r1, #1
c0d00656:	4620      	mov	r0, r4
c0d00658:	462a      	mov	r2, r5
c0d0065a:	4633      	mov	r3, r6
c0d0065c:	f7ff fe76 	bl	c0d0034c <bigint_add_int>
c0d00660:	e010      	b.n	c0d00684 <trints_to_words+0xe0>
c0d00662:	ad14      	add	r5, sp, #80	; 0x50
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
c0d00664:	490f      	ldr	r1, [pc, #60]	; (c0d006a4 <trints_to_words+0x100>)
c0d00666:	4479      	add	r1, pc
c0d00668:	ae05      	add	r6, sp, #20
c0d0066a:	230d      	movs	r3, #13
c0d0066c:	4628      	mov	r0, r5
c0d0066e:	4632      	mov	r2, r6
c0d00670:	f7ff fef0 	bl	c0d00454 <bigint_sub_bigint>
        memcpy(base, tmp, 52);
c0d00674:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d00676:	c507      	stmia	r5!, {r0, r1, r2}
c0d00678:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d0067a:	c507      	stmia	r5!, {r0, r1, r2}
c0d0067c:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d0067e:	c507      	stmia	r5!, {r0, r1, r2}
c0d00680:	ce0f      	ldmia	r6!, {r0, r1, r2, r3}
c0d00682:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d00684:	a814      	add	r0, sp, #80	; 0x50
c0d00686:	9d01      	ldr	r5, [sp, #4]
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }
    
    
    memcpy(words_out, base, 48);
c0d00688:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d0068a:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d0068c:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d0068e:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00690:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00692:	c51e      	stmia	r5!, {r1, r2, r3, r4}
    return 0;
c0d00694:	2000      	movs	r0, #0
c0d00696:	b021      	add	sp, #132	; 0x84
c0d00698:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0069a:	46c0      	nop			; (mov r8, r8)
c0d0069c:	0000ffff 	.word	0x0000ffff
c0d006a0:	00003216 	.word	0x00003216
c0d006a4:	000031da 	.word	0x000031da
c0d006a8:	00003206 	.word	0x00003206

c0d006ac <words_to_trints>:
}

//straight from words into trints
int words_to_trints(const int32_t words_in[], trint_t *trints_out)
{
c0d006ac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006ae:	af03      	add	r7, sp, #12
c0d006b0:	b0a5      	sub	sp, #148	; 0x94
c0d006b2:	9100      	str	r1, [sp, #0]
c0d006b4:	4604      	mov	r4, r0
    int32_t base[13] = {0};
c0d006b6:	9408      	str	r4, [sp, #32]
c0d006b8:	a818      	add	r0, sp, #96	; 0x60
c0d006ba:	2134      	movs	r1, #52	; 0x34
c0d006bc:	f002 ffde 	bl	c0d0367c <__aeabi_memclr>
c0d006c0:	2500      	movs	r5, #0
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
c0d006c2:	9517      	str	r5, [sp, #92]	; 0x5c
c0d006c4:	a80b      	add	r0, sp, #44	; 0x2c
c0d006c6:	4621      	mov	r1, r4
c0d006c8:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d006ca:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d006cc:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d006ce:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d006d0:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d006d2:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d006d4:	20fe      	movs	r0, #254	; 0xfe
c0d006d6:	43c1      	mvns	r1, r0
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
c0d006d8:	9808      	ldr	r0, [sp, #32]
c0d006da:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d006dc:	2800      	cmp	r0, #0
c0d006de:	9103      	str	r1, [sp, #12]
c0d006e0:	db08      	blt.n	c0d006f4 <words_to_trints+0x48>
c0d006e2:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
c0d006e4:	4941      	ldr	r1, [pc, #260]	; (c0d007ec <words_to_trints+0x140>)
c0d006e6:	4479      	add	r1, pc
c0d006e8:	aa18      	add	r2, sp, #96	; 0x60
c0d006ea:	230d      	movs	r3, #13
c0d006ec:	f7ff fe73 	bl	c0d003d6 <bigint_add_bigint>
c0d006f0:	9502      	str	r5, [sp, #8]
c0d006f2:	e01b      	b.n	c0d0072c <words_to_trints+0x80>
c0d006f4:	9501      	str	r5, [sp, #4]
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
c0d006f6:	4608      	mov	r0, r1
c0d006f8:	30fe      	adds	r0, #254	; 0xfe
c0d006fa:	9017      	str	r0, [sp, #92]	; 0x5c
c0d006fc:	ad0b      	add	r5, sp, #44	; 0x2c
c0d006fe:	260d      	movs	r6, #13
        bigint_not(tmp, 13);
c0d00700:	4628      	mov	r0, r5
c0d00702:	4631      	mov	r1, r6
c0d00704:	f7ff ff06 	bl	c0d00514 <bigint_not>
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
c0d00708:	4935      	ldr	r1, [pc, #212]	; (c0d007e0 <words_to_trints+0x134>)
c0d0070a:	4479      	add	r1, pc
c0d0070c:	4628      	mov	r0, r5
c0d0070e:	4632      	mov	r2, r6
c0d00710:	f7ff fee1 	bl	c0d004d6 <bigint_cmp_bigint>
c0d00714:	2801      	cmp	r0, #1
c0d00716:	db49      	blt.n	c0d007ac <words_to_trints+0x100>
c0d00718:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(tmp, HALF_3, base, 13);
c0d0071a:	4932      	ldr	r1, [pc, #200]	; (c0d007e4 <words_to_trints+0x138>)
c0d0071c:	4479      	add	r1, pc
c0d0071e:	aa18      	add	r2, sp, #96	; 0x60
c0d00720:	230d      	movs	r3, #13
c0d00722:	f7ff fe97 	bl	c0d00454 <bigint_sub_bigint>
c0d00726:	2001      	movs	r0, #1
c0d00728:	9002      	str	r0, [sp, #8]
c0d0072a:	9d01      	ldr	r5, [sp, #4]
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
c0d0072c:	2403      	movs	r4, #3
c0d0072e:	2005      	movs	r0, #5
c0d00730:	9501      	str	r5, [sp, #4]
c0d00732:	2d30      	cmp	r5, #48	; 0x30
c0d00734:	d000      	beq.n	c0d00738 <words_to_trints+0x8c>
c0d00736:	4604      	mov	r4, r0
c0d00738:	a809      	add	r0, sp, #36	; 0x24
        trits_to_trint(&trits[0], send);
c0d0073a:	4621      	mov	r1, r4
c0d0073c:	f7ff fd86 	bl	c0d0024c <trits_to_trint>
c0d00740:	2000      	movs	r0, #0
c0d00742:	4601      	mov	r1, r0
c0d00744:	9004      	str	r0, [sp, #16]
c0d00746:	9405      	str	r4, [sp, #20]
c0d00748:	9106      	str	r1, [sp, #24]
c0d0074a:	9007      	str	r0, [sp, #28]
c0d0074c:	250c      	movs	r5, #12
c0d0074e:	9a04      	ldr	r2, [sp, #16]
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
                uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
c0d00750:	00a9      	lsls	r1, r5, #2
c0d00752:	ac18      	add	r4, sp, #96	; 0x60
c0d00754:	5860      	ldr	r0, [r4, r1]
c0d00756:	2a00      	cmp	r2, #0
c0d00758:	9108      	str	r1, [sp, #32]
c0d0075a:	2603      	movs	r6, #3
c0d0075c:	2300      	movs	r3, #0
                uint64_t q = (lhs / 3) & 0xFFFFFFFF;
                uint8_t r = lhs % 3;
c0d0075e:	4611      	mov	r1, r2
c0d00760:	4632      	mov	r2, r6
c0d00762:	f002 fe81 	bl	c0d03468 <__aeabi_uldivmod>
                
                base[j] = q;
c0d00766:	9908      	ldr	r1, [sp, #32]
c0d00768:	5060      	str	r0, [r4, r1]
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
c0d0076a:	1e68      	subs	r0, r5, #1
c0d0076c:	2d00      	cmp	r5, #0
c0d0076e:	4605      	mov	r5, r0
c0d00770:	dcee      	bgt.n	c0d00750 <words_to_trints+0xa4>
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
            if (flip_trits) {
                trits[i] = -trits[i];
c0d00772:	9803      	ldr	r0, [sp, #12]
c0d00774:	1a80      	subs	r0, r0, r2
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d00776:	32ff      	adds	r2, #255	; 0xff
            if (flip_trits) {
c0d00778:	9902      	ldr	r1, [sp, #8]
c0d0077a:	2900      	cmp	r1, #0
c0d0077c:	d100      	bne.n	c0d00780 <words_to_trints+0xd4>
c0d0077e:	4610      	mov	r0, r2
c0d00780:	a909      	add	r1, sp, #36	; 0x24
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d00782:	9a06      	ldr	r2, [sp, #24]
c0d00784:	5488      	strb	r0, [r1, r2]
c0d00786:	9807      	ldr	r0, [sp, #28]
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
c0d00788:	1c40      	adds	r0, r0, #1
c0d0078a:	b201      	sxth	r1, r0
c0d0078c:	9c05      	ldr	r4, [sp, #20]
c0d0078e:	42a1      	cmp	r1, r4
c0d00790:	dbda      	blt.n	c0d00748 <words_to_trints+0x9c>
c0d00792:	a809      	add	r0, sp, #36	; 0x24
            if (flip_trits) {
                trits[i] = -trits[i];
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
c0d00794:	4621      	mov	r1, r4
c0d00796:	f7ff fd59 	bl	c0d0024c <trits_to_trint>
c0d0079a:	9900      	ldr	r1, [sp, #0]
c0d0079c:	9d01      	ldr	r5, [sp, #4]
c0d0079e:	5548      	strb	r0, [r1, r5]
    }
    
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
c0d007a0:	1c6d      	adds	r5, r5, #1
c0d007a2:	2d31      	cmp	r5, #49	; 0x31
c0d007a4:	d1c2      	bne.n	c0d0072c <words_to_trints+0x80>
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
    }
    return 0;
c0d007a6:	2000      	movs	r0, #0
c0d007a8:	b025      	add	sp, #148	; 0x94
c0d007aa:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d007ac:	ad0b      	add	r5, sp, #44	; 0x2c
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
c0d007ae:	2101      	movs	r1, #1
c0d007b0:	ae18      	add	r6, sp, #96	; 0x60
c0d007b2:	240d      	movs	r4, #13
c0d007b4:	4628      	mov	r0, r5
c0d007b6:	4632      	mov	r2, r6
c0d007b8:	4623      	mov	r3, r4
c0d007ba:	f7ff fdc7 	bl	c0d0034c <bigint_add_int>
            bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d007be:	480a      	ldr	r0, [pc, #40]	; (c0d007e8 <words_to_trints+0x13c>)
c0d007c0:	4478      	add	r0, pc
c0d007c2:	4631      	mov	r1, r6
c0d007c4:	462a      	mov	r2, r5
c0d007c6:	4623      	mov	r3, r4
c0d007c8:	f7ff fe44 	bl	c0d00454 <bigint_sub_bigint>
            memcpy(base, tmp, 52);
c0d007cc:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d007ce:	c607      	stmia	r6!, {r0, r1, r2}
c0d007d0:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d007d2:	c607      	stmia	r6!, {r0, r1, r2}
c0d007d4:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d007d6:	c607      	stmia	r6!, {r0, r1, r2}
c0d007d8:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d007da:	c60f      	stmia	r6!, {r0, r1, r2, r3}
c0d007dc:	9d01      	ldr	r5, [sp, #4]
c0d007de:	e787      	b.n	c0d006f0 <words_to_trints+0x44>
c0d007e0:	00003136 	.word	0x00003136
c0d007e4:	00003124 	.word	0x00003124
c0d007e8:	00003080 	.word	0x00003080
c0d007ec:	0000315a 	.word	0x0000315a

c0d007f0 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d007f0:	b580      	push	{r7, lr}
c0d007f2:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d007f4:	2003      	movs	r0, #3
c0d007f6:	01c1      	lsls	r1, r0, #7
c0d007f8:	4802      	ldr	r0, [pc, #8]	; (c0d00804 <kerl_initialize+0x14>)
c0d007fa:	f001 fb51 	bl	c0d01ea0 <cx_keccak_init>
    return 0;
c0d007fe:	2000      	movs	r0, #0
c0d00800:	bd80      	pop	{r7, pc}
c0d00802:	46c0      	nop			; (mov r8, r8)
c0d00804:	20001840 	.word	0x20001840

c0d00808 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00808:	b580      	push	{r7, lr}
c0d0080a:	af00      	add	r7, sp, #0
c0d0080c:	b082      	sub	sp, #8
c0d0080e:	460b      	mov	r3, r1
c0d00810:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00812:	4805      	ldr	r0, [pc, #20]	; (c0d00828 <kerl_absorb_bytes+0x20>)
c0d00814:	4669      	mov	r1, sp
c0d00816:	6008      	str	r0, [r1, #0]
c0d00818:	4804      	ldr	r0, [pc, #16]	; (c0d0082c <kerl_absorb_bytes+0x24>)
c0d0081a:	2101      	movs	r1, #1
c0d0081c:	f001 fb5e 	bl	c0d01edc <cx_hash>
c0d00820:	2000      	movs	r0, #0
    return 0;
c0d00822:	b002      	add	sp, #8
c0d00824:	bd80      	pop	{r7, pc}
c0d00826:	46c0      	nop			; (mov r8, r8)
c0d00828:	200019e8 	.word	0x200019e8
c0d0082c:	20001840 	.word	0x20001840

c0d00830 <kerl_absorb_trints>:
    return 0;
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
c0d00830:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00832:	af03      	add	r7, sp, #12
c0d00834:	b09b      	sub	sp, #108	; 0x6c
c0d00836:	460e      	mov	r6, r1
c0d00838:	4604      	mov	r4, r0
c0d0083a:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < (len/49); i++) {
c0d0083c:	4630      	mov	r0, r6
c0d0083e:	f002 fc9d 	bl	c0d0317c <__aeabi_uidiv>
c0d00842:	2e31      	cmp	r6, #49	; 0x31
c0d00844:	d31c      	bcc.n	c0d00880 <kerl_absorb_trints+0x50>
c0d00846:	2500      	movs	r5, #0
c0d00848:	9402      	str	r4, [sp, #8]
c0d0084a:	9001      	str	r0, [sp, #4]
c0d0084c:	ae0f      	add	r6, sp, #60	; 0x3c
        // First, convert to bytes
        int32_t words[12];
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
c0d0084e:	4620      	mov	r0, r4
c0d00850:	4631      	mov	r1, r6
c0d00852:	f7ff fea7 	bl	c0d005a4 <trints_to_words>
c0d00856:	ac03      	add	r4, sp, #12
        words_to_bytes(words, bytes, 12);
c0d00858:	220c      	movs	r2, #12
c0d0085a:	4630      	mov	r0, r6
c0d0085c:	4621      	mov	r1, r4
c0d0085e:	f7ff fe62 	bl	c0d00526 <words_to_bytes>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00862:	4668      	mov	r0, sp
c0d00864:	4908      	ldr	r1, [pc, #32]	; (c0d00888 <kerl_absorb_trints+0x58>)
c0d00866:	6001      	str	r1, [r0, #0]
c0d00868:	2101      	movs	r1, #1
c0d0086a:	2330      	movs	r3, #48	; 0x30
c0d0086c:	4807      	ldr	r0, [pc, #28]	; (c0d0088c <kerl_absorb_trints+0x5c>)
c0d0086e:	4622      	mov	r2, r4
c0d00870:	9c02      	ldr	r4, [sp, #8]
c0d00872:	f001 fb33 	bl	c0d01edc <cx_hash>
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00876:	1c6d      	adds	r5, r5, #1
c0d00878:	b2e8      	uxtb	r0, r5
c0d0087a:	9901      	ldr	r1, [sp, #4]
c0d0087c:	4288      	cmp	r0, r1
c0d0087e:	d3e5      	bcc.n	c0d0084c <kerl_absorb_trints+0x1c>
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
c0d00880:	2000      	movs	r0, #0
c0d00882:	b01b      	add	sp, #108	; 0x6c
c0d00884:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00886:	46c0      	nop			; (mov r8, r8)
c0d00888:	200019e8 	.word	0x200019e8
c0d0088c:	20001840 	.word	0x20001840

c0d00890 <kerl_squeeze_trints>:
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
c0d00890:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00892:	af03      	add	r7, sp, #12
c0d00894:	b091      	sub	sp, #68	; 0x44
c0d00896:	4605      	mov	r5, r0
    (void) len;
    
    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
c0d00898:	4c1b      	ldr	r4, [pc, #108]	; (c0d00908 <kerl_squeeze_trints+0x78>)
c0d0089a:	ae05      	add	r6, sp, #20
c0d0089c:	220c      	movs	r2, #12
c0d0089e:	4620      	mov	r0, r4
c0d008a0:	4631      	mov	r1, r6
c0d008a2:	f7ff fe63 	bl	c0d0056c <bytes_to_words>
    words_to_trints(words, &trints_out[0]);
c0d008a6:	4630      	mov	r0, r6
c0d008a8:	9502      	str	r5, [sp, #8]
c0d008aa:	4629      	mov	r1, r5
c0d008ac:	f7ff fefe 	bl	c0d006ac <words_to_trints>
    
    
    //-- Setting last trit to 0
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
c0d008b0:	2030      	movs	r0, #48	; 0x30
c0d008b2:	9003      	str	r0, [sp, #12]
c0d008b4:	5628      	ldrsb	r0, [r5, r0]
c0d008b6:	ad04      	add	r5, sp, #16
c0d008b8:	2203      	movs	r2, #3
c0d008ba:	9201      	str	r2, [sp, #4]
c0d008bc:	4629      	mov	r1, r5
c0d008be:	f7ff fce1 	bl	c0d00284 <trint_to_trits>
c0d008c2:	2600      	movs	r6, #0
    trits[2] = 0; //set last trit to 0
c0d008c4:	70ae      	strb	r6, [r5, #2]
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d008c6:	4628      	mov	r0, r5
c0d008c8:	9d01      	ldr	r5, [sp, #4]
c0d008ca:	4629      	mov	r1, r5
c0d008cc:	f7ff fcbe 	bl	c0d0024c <trits_to_trint>
c0d008d0:	9903      	ldr	r1, [sp, #12]
c0d008d2:	9a02      	ldr	r2, [sp, #8]
c0d008d4:	5450      	strb	r0, [r2, r1]
    
    // TODO: Check if the following is needed. Seems to do nothing.
    
    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
c0d008d6:	1ba0      	subs	r0, r4, r6
c0d008d8:	7801      	ldrb	r1, [r0, #0]
c0d008da:	43c9      	mvns	r1, r1
c0d008dc:	7001      	strb	r1, [r0, #0]
    trints_out[48] = trits_to_trint(&trits[0], 3);
    
    // TODO: Check if the following is needed. Seems to do nothing.
    
    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d008de:	1e76      	subs	r6, r6, #1
c0d008e0:	4630      	mov	r0, r6
c0d008e2:	3030      	adds	r0, #48	; 0x30
c0d008e4:	d1f7      	bne.n	c0d008d6 <kerl_squeeze_trints+0x46>
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d008e6:	01e9      	lsls	r1, r5, #7
c0d008e8:	4d08      	ldr	r5, [pc, #32]	; (c0d0090c <kerl_squeeze_trints+0x7c>)
c0d008ea:	4628      	mov	r0, r5
c0d008ec:	f001 fad8 	bl	c0d01ea0 <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d008f0:	4668      	mov	r0, sp
c0d008f2:	6004      	str	r4, [r0, #0]
c0d008f4:	2101      	movs	r1, #1
c0d008f6:	2330      	movs	r3, #48	; 0x30
c0d008f8:	4628      	mov	r0, r5
c0d008fa:	4622      	mov	r2, r4
c0d008fc:	f001 faee 	bl	c0d01edc <cx_hash>
c0d00900:	2000      	movs	r0, #0
    }
    
    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);
    
    return 0;
c0d00902:	b011      	add	sp, #68	; 0x44
c0d00904:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00906:	46c0      	nop			; (mov r8, r8)
c0d00908:	200019e8 	.word	0x200019e8
c0d0090c:	20001840 	.word	0x20001840

c0d00910 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00910:	b580      	push	{r7, lr}
c0d00912:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00914:	4804      	ldr	r0, [pc, #16]	; (c0d00928 <nvram_is_init+0x18>)
c0d00916:	f001 fa17 	bl	c0d01d48 <pic>
c0d0091a:	7801      	ldrb	r1, [r0, #0]
c0d0091c:	2000      	movs	r0, #0
c0d0091e:	2901      	cmp	r1, #1
c0d00920:	d100      	bne.n	c0d00924 <nvram_is_init+0x14>
c0d00922:	4608      	mov	r0, r1
    else return true;
}
c0d00924:	bd80      	pop	{r7, pc}
c0d00926:	46c0      	nop			; (mov r8, r8)
c0d00928:	c0d03c40 	.word	0xc0d03c40

c0d0092c <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d0092c:	b5b0      	push	{r4, r5, r7, lr}
c0d0092e:	af02      	add	r7, sp, #8
c0d00930:	4605      	mov	r5, r0
c0d00932:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00934:	4028      	ands	r0, r5
c0d00936:	2400      	movs	r4, #0
c0d00938:	2801      	cmp	r0, #1
c0d0093a:	d013      	beq.n	c0d00964 <io_exchange_al+0x38>
c0d0093c:	2802      	cmp	r0, #2
c0d0093e:	d113      	bne.n	c0d00968 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00940:	2900      	cmp	r1, #0
c0d00942:	d008      	beq.n	c0d00956 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00944:	480b      	ldr	r0, [pc, #44]	; (c0d00974 <io_exchange_al+0x48>)
c0d00946:	f001 fbbb 	bl	c0d020c0 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d0094a:	b268      	sxtb	r0, r5
c0d0094c:	2800      	cmp	r0, #0
c0d0094e:	da09      	bge.n	c0d00964 <io_exchange_al+0x38>
                reset();
c0d00950:	f001 fa30 	bl	c0d01db4 <reset>
c0d00954:	e006      	b.n	c0d00964 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00956:	2041      	movs	r0, #65	; 0x41
c0d00958:	0081      	lsls	r1, r0, #2
c0d0095a:	4806      	ldr	r0, [pc, #24]	; (c0d00974 <io_exchange_al+0x48>)
c0d0095c:	2200      	movs	r2, #0
c0d0095e:	f001 fbe9 	bl	c0d02134 <io_seproxyhal_spi_recv>
c0d00962:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00964:	4620      	mov	r0, r4
c0d00966:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00968:	4803      	ldr	r0, [pc, #12]	; (c0d00978 <io_exchange_al+0x4c>)
c0d0096a:	6800      	ldr	r0, [r0, #0]
c0d0096c:	2102      	movs	r1, #2
c0d0096e:	f002 ff27 	bl	c0d037c0 <longjmp>
c0d00972:	46c0      	nop			; (mov r8, r8)
c0d00974:	20001c08 	.word	0x20001c08
c0d00978:	20001bb8 	.word	0x20001bb8

c0d0097c <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d0097c:	b580      	push	{r7, lr}
c0d0097e:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00980:	f000 fe72 	bl	c0d01668 <io_seproxyhal_display_default>
}
c0d00984:	bd80      	pop	{r7, pc}
	...

c0d00988 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00988:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0098a:	af03      	add	r7, sp, #12
c0d0098c:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d0098e:	48a6      	ldr	r0, [pc, #664]	; (c0d00c28 <io_event+0x2a0>)
c0d00990:	7800      	ldrb	r0, [r0, #0]
c0d00992:	2805      	cmp	r0, #5
c0d00994:	d02e      	beq.n	c0d009f4 <io_event+0x6c>
c0d00996:	280d      	cmp	r0, #13
c0d00998:	d04e      	beq.n	c0d00a38 <io_event+0xb0>
c0d0099a:	280c      	cmp	r0, #12
c0d0099c:	d000      	beq.n	c0d009a0 <io_event+0x18>
c0d0099e:	e13a      	b.n	c0d00c16 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d009a0:	4ea2      	ldr	r6, [pc, #648]	; (c0d00c2c <io_event+0x2a4>)
c0d009a2:	2001      	movs	r0, #1
c0d009a4:	7630      	strb	r0, [r6, #24]
c0d009a6:	2500      	movs	r5, #0
c0d009a8:	61f5      	str	r5, [r6, #28]
c0d009aa:	4634      	mov	r4, r6
c0d009ac:	3418      	adds	r4, #24
c0d009ae:	4620      	mov	r0, r4
c0d009b0:	f001 fb4c 	bl	c0d0204c <os_ux>
c0d009b4:	61f0      	str	r0, [r6, #28]
c0d009b6:	499e      	ldr	r1, [pc, #632]	; (c0d00c30 <io_event+0x2a8>)
c0d009b8:	4288      	cmp	r0, r1
c0d009ba:	d100      	bne.n	c0d009be <io_event+0x36>
c0d009bc:	e12b      	b.n	c0d00c16 <io_event+0x28e>
c0d009be:	2800      	cmp	r0, #0
c0d009c0:	d100      	bne.n	c0d009c4 <io_event+0x3c>
c0d009c2:	e128      	b.n	c0d00c16 <io_event+0x28e>
c0d009c4:	499b      	ldr	r1, [pc, #620]	; (c0d00c34 <io_event+0x2ac>)
c0d009c6:	4288      	cmp	r0, r1
c0d009c8:	d000      	beq.n	c0d009cc <io_event+0x44>
c0d009ca:	e0ac      	b.n	c0d00b26 <io_event+0x19e>
c0d009cc:	2003      	movs	r0, #3
c0d009ce:	7630      	strb	r0, [r6, #24]
c0d009d0:	61f5      	str	r5, [r6, #28]
c0d009d2:	4620      	mov	r0, r4
c0d009d4:	f001 fb3a 	bl	c0d0204c <os_ux>
c0d009d8:	61f0      	str	r0, [r6, #28]
c0d009da:	f000 fcfb 	bl	c0d013d4 <io_seproxyhal_init_ux>
c0d009de:	60b5      	str	r5, [r6, #8]
c0d009e0:	6830      	ldr	r0, [r6, #0]
c0d009e2:	2800      	cmp	r0, #0
c0d009e4:	d100      	bne.n	c0d009e8 <io_event+0x60>
c0d009e6:	e116      	b.n	c0d00c16 <io_event+0x28e>
c0d009e8:	69f0      	ldr	r0, [r6, #28]
c0d009ea:	4991      	ldr	r1, [pc, #580]	; (c0d00c30 <io_event+0x2a8>)
c0d009ec:	4288      	cmp	r0, r1
c0d009ee:	d000      	beq.n	c0d009f2 <io_event+0x6a>
c0d009f0:	e096      	b.n	c0d00b20 <io_event+0x198>
c0d009f2:	e110      	b.n	c0d00c16 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d009f4:	4d8d      	ldr	r5, [pc, #564]	; (c0d00c2c <io_event+0x2a4>)
c0d009f6:	2001      	movs	r0, #1
c0d009f8:	7628      	strb	r0, [r5, #24]
c0d009fa:	2600      	movs	r6, #0
c0d009fc:	61ee      	str	r6, [r5, #28]
c0d009fe:	462c      	mov	r4, r5
c0d00a00:	3418      	adds	r4, #24
c0d00a02:	4620      	mov	r0, r4
c0d00a04:	f001 fb22 	bl	c0d0204c <os_ux>
c0d00a08:	4601      	mov	r1, r0
c0d00a0a:	61e9      	str	r1, [r5, #28]
c0d00a0c:	4889      	ldr	r0, [pc, #548]	; (c0d00c34 <io_event+0x2ac>)
c0d00a0e:	4281      	cmp	r1, r0
c0d00a10:	d15d      	bne.n	c0d00ace <io_event+0x146>
c0d00a12:	2003      	movs	r0, #3
c0d00a14:	7628      	strb	r0, [r5, #24]
c0d00a16:	61ee      	str	r6, [r5, #28]
c0d00a18:	4620      	mov	r0, r4
c0d00a1a:	f001 fb17 	bl	c0d0204c <os_ux>
c0d00a1e:	61e8      	str	r0, [r5, #28]
c0d00a20:	f000 fcd8 	bl	c0d013d4 <io_seproxyhal_init_ux>
c0d00a24:	60ae      	str	r6, [r5, #8]
c0d00a26:	6828      	ldr	r0, [r5, #0]
c0d00a28:	2800      	cmp	r0, #0
c0d00a2a:	d100      	bne.n	c0d00a2e <io_event+0xa6>
c0d00a2c:	e0f3      	b.n	c0d00c16 <io_event+0x28e>
c0d00a2e:	69e8      	ldr	r0, [r5, #28]
c0d00a30:	497f      	ldr	r1, [pc, #508]	; (c0d00c30 <io_event+0x2a8>)
c0d00a32:	4288      	cmp	r0, r1
c0d00a34:	d148      	bne.n	c0d00ac8 <io_event+0x140>
c0d00a36:	e0ee      	b.n	c0d00c16 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00a38:	4d7c      	ldr	r5, [pc, #496]	; (c0d00c2c <io_event+0x2a4>)
c0d00a3a:	6868      	ldr	r0, [r5, #4]
c0d00a3c:	68a9      	ldr	r1, [r5, #8]
c0d00a3e:	4281      	cmp	r1, r0
c0d00a40:	d300      	bcc.n	c0d00a44 <io_event+0xbc>
c0d00a42:	e0e8      	b.n	c0d00c16 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00a44:	2001      	movs	r0, #1
c0d00a46:	7628      	strb	r0, [r5, #24]
c0d00a48:	2600      	movs	r6, #0
c0d00a4a:	61ee      	str	r6, [r5, #28]
c0d00a4c:	462c      	mov	r4, r5
c0d00a4e:	3418      	adds	r4, #24
c0d00a50:	4620      	mov	r0, r4
c0d00a52:	f001 fafb 	bl	c0d0204c <os_ux>
c0d00a56:	61e8      	str	r0, [r5, #28]
c0d00a58:	4975      	ldr	r1, [pc, #468]	; (c0d00c30 <io_event+0x2a8>)
c0d00a5a:	4288      	cmp	r0, r1
c0d00a5c:	d100      	bne.n	c0d00a60 <io_event+0xd8>
c0d00a5e:	e0da      	b.n	c0d00c16 <io_event+0x28e>
c0d00a60:	2800      	cmp	r0, #0
c0d00a62:	d100      	bne.n	c0d00a66 <io_event+0xde>
c0d00a64:	e0d7      	b.n	c0d00c16 <io_event+0x28e>
c0d00a66:	4973      	ldr	r1, [pc, #460]	; (c0d00c34 <io_event+0x2ac>)
c0d00a68:	4288      	cmp	r0, r1
c0d00a6a:	d000      	beq.n	c0d00a6e <io_event+0xe6>
c0d00a6c:	e08d      	b.n	c0d00b8a <io_event+0x202>
c0d00a6e:	2003      	movs	r0, #3
c0d00a70:	7628      	strb	r0, [r5, #24]
c0d00a72:	61ee      	str	r6, [r5, #28]
c0d00a74:	4620      	mov	r0, r4
c0d00a76:	f001 fae9 	bl	c0d0204c <os_ux>
c0d00a7a:	61e8      	str	r0, [r5, #28]
c0d00a7c:	f000 fcaa 	bl	c0d013d4 <io_seproxyhal_init_ux>
c0d00a80:	60ae      	str	r6, [r5, #8]
c0d00a82:	6828      	ldr	r0, [r5, #0]
c0d00a84:	2800      	cmp	r0, #0
c0d00a86:	d100      	bne.n	c0d00a8a <io_event+0x102>
c0d00a88:	e0c5      	b.n	c0d00c16 <io_event+0x28e>
c0d00a8a:	69e8      	ldr	r0, [r5, #28]
c0d00a8c:	4968      	ldr	r1, [pc, #416]	; (c0d00c30 <io_event+0x2a8>)
c0d00a8e:	4288      	cmp	r0, r1
c0d00a90:	d178      	bne.n	c0d00b84 <io_event+0x1fc>
c0d00a92:	e0c0      	b.n	c0d00c16 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00a94:	6868      	ldr	r0, [r5, #4]
c0d00a96:	4286      	cmp	r6, r0
c0d00a98:	d300      	bcc.n	c0d00a9c <io_event+0x114>
c0d00a9a:	e0bc      	b.n	c0d00c16 <io_event+0x28e>
c0d00a9c:	f001 fb2e 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d00aa0:	2800      	cmp	r0, #0
c0d00aa2:	d000      	beq.n	c0d00aa6 <io_event+0x11e>
c0d00aa4:	e0b7      	b.n	c0d00c16 <io_event+0x28e>
c0d00aa6:	68a8      	ldr	r0, [r5, #8]
c0d00aa8:	68e9      	ldr	r1, [r5, #12]
c0d00aaa:	2438      	movs	r4, #56	; 0x38
c0d00aac:	4360      	muls	r0, r4
c0d00aae:	682a      	ldr	r2, [r5, #0]
c0d00ab0:	1810      	adds	r0, r2, r0
c0d00ab2:	2900      	cmp	r1, #0
c0d00ab4:	d100      	bne.n	c0d00ab8 <io_event+0x130>
c0d00ab6:	e085      	b.n	c0d00bc4 <io_event+0x23c>
c0d00ab8:	4788      	blx	r1
c0d00aba:	2800      	cmp	r0, #0
c0d00abc:	d000      	beq.n	c0d00ac0 <io_event+0x138>
c0d00abe:	e081      	b.n	c0d00bc4 <io_event+0x23c>
c0d00ac0:	68a8      	ldr	r0, [r5, #8]
c0d00ac2:	1c46      	adds	r6, r0, #1
c0d00ac4:	60ae      	str	r6, [r5, #8]
c0d00ac6:	6828      	ldr	r0, [r5, #0]
c0d00ac8:	2800      	cmp	r0, #0
c0d00aca:	d1e3      	bne.n	c0d00a94 <io_event+0x10c>
c0d00acc:	e0a3      	b.n	c0d00c16 <io_event+0x28e>
c0d00ace:	6928      	ldr	r0, [r5, #16]
c0d00ad0:	2800      	cmp	r0, #0
c0d00ad2:	d100      	bne.n	c0d00ad6 <io_event+0x14e>
c0d00ad4:	e09f      	b.n	c0d00c16 <io_event+0x28e>
c0d00ad6:	4a56      	ldr	r2, [pc, #344]	; (c0d00c30 <io_event+0x2a8>)
c0d00ad8:	4291      	cmp	r1, r2
c0d00ada:	d100      	bne.n	c0d00ade <io_event+0x156>
c0d00adc:	e09b      	b.n	c0d00c16 <io_event+0x28e>
c0d00ade:	2900      	cmp	r1, #0
c0d00ae0:	d100      	bne.n	c0d00ae4 <io_event+0x15c>
c0d00ae2:	e098      	b.n	c0d00c16 <io_event+0x28e>
c0d00ae4:	4950      	ldr	r1, [pc, #320]	; (c0d00c28 <io_event+0x2a0>)
c0d00ae6:	78c9      	ldrb	r1, [r1, #3]
c0d00ae8:	0849      	lsrs	r1, r1, #1
c0d00aea:	f000 fdff 	bl	c0d016ec <io_seproxyhal_button_push>
c0d00aee:	e092      	b.n	c0d00c16 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00af0:	6870      	ldr	r0, [r6, #4]
c0d00af2:	4285      	cmp	r5, r0
c0d00af4:	d300      	bcc.n	c0d00af8 <io_event+0x170>
c0d00af6:	e08e      	b.n	c0d00c16 <io_event+0x28e>
c0d00af8:	f001 fb00 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d00afc:	2800      	cmp	r0, #0
c0d00afe:	d000      	beq.n	c0d00b02 <io_event+0x17a>
c0d00b00:	e089      	b.n	c0d00c16 <io_event+0x28e>
c0d00b02:	68b0      	ldr	r0, [r6, #8]
c0d00b04:	68f1      	ldr	r1, [r6, #12]
c0d00b06:	2438      	movs	r4, #56	; 0x38
c0d00b08:	4360      	muls	r0, r4
c0d00b0a:	6832      	ldr	r2, [r6, #0]
c0d00b0c:	1810      	adds	r0, r2, r0
c0d00b0e:	2900      	cmp	r1, #0
c0d00b10:	d076      	beq.n	c0d00c00 <io_event+0x278>
c0d00b12:	4788      	blx	r1
c0d00b14:	2800      	cmp	r0, #0
c0d00b16:	d173      	bne.n	c0d00c00 <io_event+0x278>
c0d00b18:	68b0      	ldr	r0, [r6, #8]
c0d00b1a:	1c45      	adds	r5, r0, #1
c0d00b1c:	60b5      	str	r5, [r6, #8]
c0d00b1e:	6830      	ldr	r0, [r6, #0]
c0d00b20:	2800      	cmp	r0, #0
c0d00b22:	d1e5      	bne.n	c0d00af0 <io_event+0x168>
c0d00b24:	e077      	b.n	c0d00c16 <io_event+0x28e>
c0d00b26:	88b0      	ldrh	r0, [r6, #4]
c0d00b28:	9004      	str	r0, [sp, #16]
c0d00b2a:	6830      	ldr	r0, [r6, #0]
c0d00b2c:	9003      	str	r0, [sp, #12]
c0d00b2e:	483e      	ldr	r0, [pc, #248]	; (c0d00c28 <io_event+0x2a0>)
c0d00b30:	4601      	mov	r1, r0
c0d00b32:	79cc      	ldrb	r4, [r1, #7]
c0d00b34:	798b      	ldrb	r3, [r1, #6]
c0d00b36:	794d      	ldrb	r5, [r1, #5]
c0d00b38:	790a      	ldrb	r2, [r1, #4]
c0d00b3a:	4630      	mov	r0, r6
c0d00b3c:	78ce      	ldrb	r6, [r1, #3]
c0d00b3e:	68c1      	ldr	r1, [r0, #12]
c0d00b40:	4668      	mov	r0, sp
c0d00b42:	6006      	str	r6, [r0, #0]
c0d00b44:	6041      	str	r1, [r0, #4]
c0d00b46:	0212      	lsls	r2, r2, #8
c0d00b48:	432a      	orrs	r2, r5
c0d00b4a:	021b      	lsls	r3, r3, #8
c0d00b4c:	4323      	orrs	r3, r4
c0d00b4e:	9803      	ldr	r0, [sp, #12]
c0d00b50:	9904      	ldr	r1, [sp, #16]
c0d00b52:	f000 fcb9 	bl	c0d014c8 <io_seproxyhal_touch_element_callback>
c0d00b56:	e05e      	b.n	c0d00c16 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00b58:	6868      	ldr	r0, [r5, #4]
c0d00b5a:	4286      	cmp	r6, r0
c0d00b5c:	d25b      	bcs.n	c0d00c16 <io_event+0x28e>
c0d00b5e:	f001 facd 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d00b62:	2800      	cmp	r0, #0
c0d00b64:	d157      	bne.n	c0d00c16 <io_event+0x28e>
c0d00b66:	68a8      	ldr	r0, [r5, #8]
c0d00b68:	68e9      	ldr	r1, [r5, #12]
c0d00b6a:	2438      	movs	r4, #56	; 0x38
c0d00b6c:	4360      	muls	r0, r4
c0d00b6e:	682a      	ldr	r2, [r5, #0]
c0d00b70:	1810      	adds	r0, r2, r0
c0d00b72:	2900      	cmp	r1, #0
c0d00b74:	d026      	beq.n	c0d00bc4 <io_event+0x23c>
c0d00b76:	4788      	blx	r1
c0d00b78:	2800      	cmp	r0, #0
c0d00b7a:	d123      	bne.n	c0d00bc4 <io_event+0x23c>
c0d00b7c:	68a8      	ldr	r0, [r5, #8]
c0d00b7e:	1c46      	adds	r6, r0, #1
c0d00b80:	60ae      	str	r6, [r5, #8]
c0d00b82:	6828      	ldr	r0, [r5, #0]
c0d00b84:	2800      	cmp	r0, #0
c0d00b86:	d1e7      	bne.n	c0d00b58 <io_event+0x1d0>
c0d00b88:	e045      	b.n	c0d00c16 <io_event+0x28e>
c0d00b8a:	6828      	ldr	r0, [r5, #0]
c0d00b8c:	2800      	cmp	r0, #0
c0d00b8e:	d030      	beq.n	c0d00bf2 <io_event+0x26a>
c0d00b90:	68a8      	ldr	r0, [r5, #8]
c0d00b92:	6869      	ldr	r1, [r5, #4]
c0d00b94:	4288      	cmp	r0, r1
c0d00b96:	d22c      	bcs.n	c0d00bf2 <io_event+0x26a>
c0d00b98:	f001 fab0 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d00b9c:	2800      	cmp	r0, #0
c0d00b9e:	d128      	bne.n	c0d00bf2 <io_event+0x26a>
c0d00ba0:	68a8      	ldr	r0, [r5, #8]
c0d00ba2:	68e9      	ldr	r1, [r5, #12]
c0d00ba4:	2438      	movs	r4, #56	; 0x38
c0d00ba6:	4360      	muls	r0, r4
c0d00ba8:	682a      	ldr	r2, [r5, #0]
c0d00baa:	1810      	adds	r0, r2, r0
c0d00bac:	2900      	cmp	r1, #0
c0d00bae:	d015      	beq.n	c0d00bdc <io_event+0x254>
c0d00bb0:	4788      	blx	r1
c0d00bb2:	2800      	cmp	r0, #0
c0d00bb4:	d112      	bne.n	c0d00bdc <io_event+0x254>
c0d00bb6:	68a8      	ldr	r0, [r5, #8]
c0d00bb8:	1c40      	adds	r0, r0, #1
c0d00bba:	60a8      	str	r0, [r5, #8]
c0d00bbc:	6829      	ldr	r1, [r5, #0]
c0d00bbe:	2900      	cmp	r1, #0
c0d00bc0:	d1e7      	bne.n	c0d00b92 <io_event+0x20a>
c0d00bc2:	e016      	b.n	c0d00bf2 <io_event+0x26a>
c0d00bc4:	2801      	cmp	r0, #1
c0d00bc6:	d103      	bne.n	c0d00bd0 <io_event+0x248>
c0d00bc8:	68a8      	ldr	r0, [r5, #8]
c0d00bca:	4344      	muls	r4, r0
c0d00bcc:	6828      	ldr	r0, [r5, #0]
c0d00bce:	1900      	adds	r0, r0, r4
c0d00bd0:	f000 fd4a 	bl	c0d01668 <io_seproxyhal_display_default>
c0d00bd4:	68a8      	ldr	r0, [r5, #8]
c0d00bd6:	1c40      	adds	r0, r0, #1
c0d00bd8:	60a8      	str	r0, [r5, #8]
c0d00bda:	e01c      	b.n	c0d00c16 <io_event+0x28e>
c0d00bdc:	2801      	cmp	r0, #1
c0d00bde:	d103      	bne.n	c0d00be8 <io_event+0x260>
c0d00be0:	68a8      	ldr	r0, [r5, #8]
c0d00be2:	4344      	muls	r4, r0
c0d00be4:	6828      	ldr	r0, [r5, #0]
c0d00be6:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00be8:	f000 fd3e 	bl	c0d01668 <io_seproxyhal_display_default>
c0d00bec:	68a8      	ldr	r0, [r5, #8]
c0d00bee:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00bf0:	60a8      	str	r0, [r5, #8]
c0d00bf2:	6868      	ldr	r0, [r5, #4]
c0d00bf4:	68a9      	ldr	r1, [r5, #8]
c0d00bf6:	4281      	cmp	r1, r0
c0d00bf8:	d30d      	bcc.n	c0d00c16 <io_event+0x28e>
c0d00bfa:	f001 fa7f 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d00bfe:	e00a      	b.n	c0d00c16 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c00:	2801      	cmp	r0, #1
c0d00c02:	d103      	bne.n	c0d00c0c <io_event+0x284>
c0d00c04:	68b0      	ldr	r0, [r6, #8]
c0d00c06:	4344      	muls	r4, r0
c0d00c08:	6830      	ldr	r0, [r6, #0]
c0d00c0a:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00c0c:	f000 fd2c 	bl	c0d01668 <io_seproxyhal_display_default>
c0d00c10:	68b0      	ldr	r0, [r6, #8]
c0d00c12:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c14:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00c16:	f001 fa71 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d00c1a:	2800      	cmp	r0, #0
c0d00c1c:	d101      	bne.n	c0d00c22 <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00c1e:	f000 faad 	bl	c0d0117c <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00c22:	2001      	movs	r0, #1
c0d00c24:	b005      	add	sp, #20
c0d00c26:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00c28:	20001a18 	.word	0x20001a18
c0d00c2c:	20001a98 	.word	0x20001a98
c0d00c30:	b0105044 	.word	0xb0105044
c0d00c34:	b0105055 	.word	0xb0105055

c0d00c38 <IOTA_main>:





static void IOTA_main(void) {
c0d00c38:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c3a:	af03      	add	r7, sp, #12
c0d00c3c:	b0dd      	sub	sp, #372	; 0x174
c0d00c3e:	2600      	movs	r6, #0
    volatile unsigned int rx = 0;
c0d00c40:	965c      	str	r6, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00c42:	965b      	str	r6, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00c44:	965a      	str	r6, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00c46:	a093      	add	r0, pc, #588	; (adr r0, c0d00e94 <IOTA_main+0x25c>)
c0d00c48:	2110      	movs	r1, #16
c0d00c4a:	2203      	movs	r2, #3
c0d00c4c:	9109      	str	r1, [sp, #36]	; 0x24
c0d00c4e:	9208      	str	r2, [sp, #32]
c0d00c50:	f7ff fade 	bl	c0d00210 <write_debug>
c0d00c54:	4d93      	ldr	r5, [pc, #588]	; (c0d00ea4 <IOTA_main+0x26c>)
c0d00c56:	6828      	ldr	r0, [r5, #0]
c0d00c58:	960a      	str	r6, [sp, #40]	; 0x28
c0d00c5a:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00c5c:	800e      	strh	r6, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00c5e:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00c60:	ac4d      	add	r4, sp, #308	; 0x134
c0d00c62:	4620      	mov	r0, r4
c0d00c64:	f002 fda0 	bl	c0d037a8 <setjmp>
c0d00c68:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00c6a:	602c      	str	r4, [r5, #0]
c0d00c6c:	498e      	ldr	r1, [pc, #568]	; (c0d00ea8 <IOTA_main+0x270>)
c0d00c6e:	4208      	tst	r0, r1
c0d00c70:	d011      	beq.n	c0d00c96 <IOTA_main+0x5e>
c0d00c72:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00c74:	858e      	strh	r6, [r1, #44]	; 0x2c
c0d00c76:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00c78:	6029      	str	r1, [r5, #0]
c0d00c7a:	210f      	movs	r1, #15
c0d00c7c:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00c7e:	4001      	ands	r1, r0
c0d00c80:	2209      	movs	r2, #9
c0d00c82:	0312      	lsls	r2, r2, #12
c0d00c84:	4291      	cmp	r1, r2
c0d00c86:	d003      	beq.n	c0d00c90 <IOTA_main+0x58>
c0d00c88:	9a08      	ldr	r2, [sp, #32]
c0d00c8a:	0352      	lsls	r2, r2, #13
c0d00c8c:	4291      	cmp	r1, r2
c0d00c8e:	d141      	bne.n	c0d00d14 <IOTA_main+0xdc>
c0d00c90:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00c92:	8008      	strh	r0, [r1, #0]
c0d00c94:	e045      	b.n	c0d00d22 <IOTA_main+0xea>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00c96:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00c98:	905c      	str	r0, [sp, #368]	; 0x170
c0d00c9a:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00c9c:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00c9e:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00ca0:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00ca2:	b2c0      	uxtb	r0, r0
c0d00ca4:	b289      	uxth	r1, r1
c0d00ca6:	f000 fd5d 	bl	c0d01764 <io_exchange>
c0d00caa:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00cac:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00cae:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00cb0:	2800      	cmp	r0, #0
c0d00cb2:	d100      	bne.n	c0d00cb6 <IOTA_main+0x7e>
c0d00cb4:	e0cb      	b.n	c0d00e4e <IOTA_main+0x216>
c0d00cb6:	497e      	ldr	r1, [pc, #504]	; (c0d00eb0 <IOTA_main+0x278>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00cb8:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00cba:	2580      	movs	r5, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00cbc:	2880      	cmp	r0, #128	; 0x80
c0d00cbe:	4e7d      	ldr	r6, [pc, #500]	; (c0d00eb4 <IOTA_main+0x27c>)
c0d00cc0:	d000      	beq.n	c0d00cc4 <IOTA_main+0x8c>
c0d00cc2:	e0cc      	b.n	c0d00e5e <IOTA_main+0x226>
c0d00cc4:	7848      	ldrb	r0, [r1, #1]
c0d00cc6:	216d      	movs	r1, #109	; 0x6d
c0d00cc8:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00cca:	2807      	cmp	r0, #7
c0d00ccc:	dc36      	bgt.n	c0d00d3c <IOTA_main+0x104>
c0d00cce:	2802      	cmp	r0, #2
c0d00cd0:	d04f      	beq.n	c0d00d72 <IOTA_main+0x13a>
c0d00cd2:	2804      	cmp	r0, #4
c0d00cd4:	d000      	beq.n	c0d00cd8 <IOTA_main+0xa0>
c0d00cd6:	e0ca      	b.n	c0d00e6e <IOTA_main+0x236>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00cd8:	210b      	movs	r1, #11
c0d00cda:	2203      	movs	r2, #3
c0d00cdc:	a078      	add	r0, pc, #480	; (adr r0, c0d00ec0 <IOTA_main+0x288>)
c0d00cde:	f7ff fa97 	bl	c0d00210 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d00ce2:	2048      	movs	r0, #72	; 0x48
c0d00ce4:	4972      	ldr	r1, [pc, #456]	; (c0d00eb0 <IOTA_main+0x278>)
c0d00ce6:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00ce8:	2049      	movs	r0, #73	; 0x49
c0d00cea:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d00cec:	2021      	movs	r0, #33	; 0x21
c0d00cee:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00cf0:	3510      	adds	r5, #16
c0d00cf2:	70cd      	strb	r5, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00cf4:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00cf6:	2005      	movs	r0, #5
c0d00cf8:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00cfa:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00cfc:	b281      	uxth	r1, r0
c0d00cfe:	2020      	movs	r0, #32
c0d00d00:	f000 fd30 	bl	c0d01764 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00d04:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00d06:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00d08:	4308      	orrs	r0, r1
c0d00d0a:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d00d0c:	4620      	mov	r0, r4
c0d00d0e:	4621      	mov	r1, r4
c0d00d10:	4622      	mov	r2, r4
c0d00d12:	e08b      	b.n	c0d00e2c <IOTA_main+0x1f4>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00d14:	4965      	ldr	r1, [pc, #404]	; (c0d00eac <IOTA_main+0x274>)
c0d00d16:	4008      	ands	r0, r1
c0d00d18:	210d      	movs	r1, #13
c0d00d1a:	02c9      	lsls	r1, r1, #11
c0d00d1c:	4301      	orrs	r1, r0
c0d00d1e:	a859      	add	r0, sp, #356	; 0x164
c0d00d20:	8001      	strh	r1, [r0, #0]
c0d00d22:	4a63      	ldr	r2, [pc, #396]	; (c0d00eb0 <IOTA_main+0x278>)
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00d24:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00d26:	0a00      	lsrs	r0, r0, #8
c0d00d28:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d00d2a:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00d2c:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00d2e:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00d30:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00d32:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00d34:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00d36:	1c80      	adds	r0, r0, #2
c0d00d38:	905b      	str	r0, [sp, #364]	; 0x16c
c0d00d3a:	e07b      	b.n	c0d00e34 <IOTA_main+0x1fc>
c0d00d3c:	2808      	cmp	r0, #8
c0d00d3e:	d000      	beq.n	c0d00d42 <IOTA_main+0x10a>
c0d00d40:	e081      	b.n	c0d00e46 <IOTA_main+0x20e>
c0d00d42:	485b      	ldr	r0, [pc, #364]	; (c0d00eb0 <IOTA_main+0x278>)
c0d00d44:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00d46:	4328      	orrs	r0, r5
c0d00d48:	2880      	cmp	r0, #128	; 0x80
c0d00d4a:	d000      	beq.n	c0d00d4e <IOTA_main+0x116>
c0d00d4c:	e095      	b.n	c0d00e7a <IOTA_main+0x242>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d00d4e:	7830      	ldrb	r0, [r6, #0]
c0d00d50:	2800      	cmp	r0, #0
c0d00d52:	4d54      	ldr	r5, [pc, #336]	; (c0d00ea4 <IOTA_main+0x26c>)
c0d00d54:	d003      	beq.n	c0d00d5e <IOTA_main+0x126>
                        cx_sha256_init(&hash);
c0d00d56:	4858      	ldr	r0, [pc, #352]	; (c0d00eb8 <IOTA_main+0x280>)
c0d00d58:	f001 f884 	bl	c0d01e64 <cx_sha256_init>
                        hashTainted = 0;
c0d00d5c:	7034      	strb	r4, [r6, #0]
c0d00d5e:	4854      	ldr	r0, [pc, #336]	; (c0d00eb0 <IOTA_main+0x278>)
c0d00d60:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00d62:	7908      	ldrb	r0, [r1, #4]
c0d00d64:	1808      	adds	r0, r1, r0
c0d00d66:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00d68:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00d6a:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00d6c:	4308      	orrs	r0, r1
c0d00d6e:	905a      	str	r0, [sp, #360]	; 0x168
c0d00d70:	e05f      	b.n	c0d00e32 <IOTA_main+0x1fa>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00d72:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00d74:	2818      	cmp	r0, #24
c0d00d76:	d800      	bhi.n	c0d00d7a <IOTA_main+0x142>
c0d00d78:	e084      	b.n	c0d00e84 <IOTA_main+0x24c>
c0d00d7a:	4e4d      	ldr	r6, [pc, #308]	; (c0d00eb0 <IOTA_main+0x278>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00d7c:	00a0      	lsls	r0, r4, #2
c0d00d7e:	1831      	adds	r1, r6, r0
c0d00d80:	794a      	ldrb	r2, [r1, #5]
c0d00d82:	0612      	lsls	r2, r2, #24
c0d00d84:	798b      	ldrb	r3, [r1, #6]
c0d00d86:	041b      	lsls	r3, r3, #16
c0d00d88:	4313      	orrs	r3, r2
c0d00d8a:	79ca      	ldrb	r2, [r1, #7]
c0d00d8c:	0212      	lsls	r2, r2, #8
c0d00d8e:	431a      	orrs	r2, r3
c0d00d90:	7a09      	ldrb	r1, [r1, #8]
c0d00d92:	4311      	orrs	r1, r2
c0d00d94:	aa2b      	add	r2, sp, #172	; 0xac
c0d00d96:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00d98:	1c64      	adds	r4, r4, #1
c0d00d9a:	2c05      	cmp	r4, #5
c0d00d9c:	d1ee      	bne.n	c0d00d7c <IOTA_main+0x144>
c0d00d9e:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00da0:	9106      	str	r1, [sp, #24]
c0d00da2:	4668      	mov	r0, sp
c0d00da4:	6001      	str	r1, [r0, #0]
c0d00da6:	2021      	movs	r0, #33	; 0x21
c0d00da8:	9003      	str	r0, [sp, #12]
c0d00daa:	a92b      	add	r1, sp, #172	; 0xac
c0d00dac:	2205      	movs	r2, #5
c0d00dae:	ac23      	add	r4, sp, #140	; 0x8c
c0d00db0:	9405      	str	r4, [sp, #20]
c0d00db2:	4623      	mov	r3, r4
c0d00db4:	f001 f90c 	bl	c0d01fd0 <os_perso_derive_node_bip32>
c0d00db8:	2220      	movs	r2, #32
c0d00dba:	9207      	str	r2, [sp, #28]
c0d00dbc:	a830      	add	r0, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00dbe:	9004      	str	r0, [sp, #16]
c0d00dc0:	9803      	ldr	r0, [sp, #12]
c0d00dc2:	4621      	mov	r1, r4
c0d00dc4:	9b04      	ldr	r3, [sp, #16]
c0d00dc6:	f001 f8c7 	bl	c0d01f58 <cx_ecfp_init_private_key>
c0d00dca:	ab3a      	add	r3, sp, #232	; 0xe8
c0d00dcc:	9302      	str	r3, [sp, #8]
c0d00dce:	9c03      	ldr	r4, [sp, #12]

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00dd0:	4620      	mov	r0, r4
c0d00dd2:	9906      	ldr	r1, [sp, #24]
c0d00dd4:	460a      	mov	r2, r1
c0d00dd6:	f001 f8a1 	bl	c0d01f1c <cx_ecfp_init_public_key>
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00dda:	2301      	movs	r3, #1
c0d00ddc:	4620      	mov	r0, r4
c0d00dde:	9902      	ldr	r1, [sp, #8]
c0d00de0:	9a04      	ldr	r2, [sp, #16]
c0d00de2:	f001 f8d7 	bl	c0d01f94 <cx_ecfp_generate_pair>
c0d00de6:	aa0e      	add	r2, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00de8:	9201      	str	r2, [sp, #4]
c0d00dea:	9805      	ldr	r0, [sp, #20]
c0d00dec:	9907      	ldr	r1, [sp, #28]
c0d00dee:	f7ff fa81 	bl	c0d002f4 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d00df2:	2452      	movs	r4, #82	; 0x52
c0d00df4:	4630      	mov	r0, r6
c0d00df6:	9901      	ldr	r1, [sp, #4]
c0d00df8:	4622      	mov	r2, r4
c0d00dfa:	f000 f925 	bl	c0d01048 <os_memmove>
                    tx = 82; // ---------CHECK THE SIZE IN BYTES OF KERL_INIT AND CXA_KECCAK SHIT
c0d00dfe:	945b      	str	r4, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d00e00:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00e02:	1c41      	adds	r1, r0, #1
c0d00e04:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00e06:	3510      	adds	r5, #16
c0d00e08:	5435      	strb	r5, [r6, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d00e0a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00e0c:	1c41      	adds	r1, r0, #1
c0d00e0e:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00e10:	9906      	ldr	r1, [sp, #24]
c0d00e12:	5431      	strb	r1, [r6, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00e14:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00e16:	b281      	uxth	r1, r0
c0d00e18:	9807      	ldr	r0, [sp, #28]
c0d00e1a:	f000 fca3 	bl	c0d01764 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00e1e:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00e20:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00e22:	4308      	orrs	r0, r1
c0d00e24:	905a      	str	r0, [sp, #360]	; 0x168
c0d00e26:	a80b      	add	r0, sp, #44	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
                     */
                    

                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d00e28:	2140      	movs	r1, #64	; 0x40
c0d00e2a:	2203      	movs	r2, #3
c0d00e2c:	f001 fa16 	bl	c0d0225c <ui_display_debug>
c0d00e30:	4d1c      	ldr	r5, [pc, #112]	; (c0d00ea4 <IOTA_main+0x26c>)
c0d00e32:	9e0a      	ldr	r6, [sp, #40]	; 0x28
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
                G_io_apdu_buffer[tx + 1] = sw;
                tx += 2;
            }
            FINALLY {
c0d00e34:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d00e36:	6028      	str	r0, [r5, #0]
c0d00e38:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d00e3a:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d00e3c:	2900      	cmp	r1, #0
c0d00e3e:	d100      	bne.n	c0d00e42 <IOTA_main+0x20a>
c0d00e40:	e70b      	b.n	c0d00c5a <IOTA_main+0x22>
c0d00e42:	f002 fcbd 	bl	c0d037c0 <longjmp>
c0d00e46:	28ff      	cmp	r0, #255	; 0xff
c0d00e48:	d111      	bne.n	c0d00e6e <IOTA_main+0x236>
    }

return_to_dashboard:
    return;
}
c0d00e4a:	b05d      	add	sp, #372	; 0x174
c0d00e4c:	bdf0      	pop	{r4, r5, r6, r7, pc}
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d00e4e:	2001      	movs	r0, #1
c0d00e50:	4918      	ldr	r1, [pc, #96]	; (c0d00eb4 <IOTA_main+0x27c>)
c0d00e52:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d00e54:	4813      	ldr	r0, [pc, #76]	; (c0d00ea4 <IOTA_main+0x26c>)
c0d00e56:	6800      	ldr	r0, [r0, #0]
c0d00e58:	491c      	ldr	r1, [pc, #112]	; (c0d00ecc <IOTA_main+0x294>)
c0d00e5a:	f002 fcb1 	bl	c0d037c0 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d00e5e:	2001      	movs	r0, #1
c0d00e60:	7030      	strb	r0, [r6, #0]
                    THROW(0x6E00);
c0d00e62:	4810      	ldr	r0, [pc, #64]	; (c0d00ea4 <IOTA_main+0x26c>)
c0d00e64:	6800      	ldr	r0, [r0, #0]
c0d00e66:	2137      	movs	r1, #55	; 0x37
c0d00e68:	0249      	lsls	r1, r1, #9
c0d00e6a:	f002 fca9 	bl	c0d037c0 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d00e6e:	2001      	movs	r0, #1
c0d00e70:	7030      	strb	r0, [r6, #0]
                    THROW(0x6D00);
c0d00e72:	480c      	ldr	r0, [pc, #48]	; (c0d00ea4 <IOTA_main+0x26c>)
c0d00e74:	6800      	ldr	r0, [r0, #0]
c0d00e76:	f002 fca3 	bl	c0d037c0 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d00e7a:	480a      	ldr	r0, [pc, #40]	; (c0d00ea4 <IOTA_main+0x26c>)
c0d00e7c:	6800      	ldr	r0, [r0, #0]
c0d00e7e:	490f      	ldr	r1, [pc, #60]	; (c0d00ebc <IOTA_main+0x284>)
c0d00e80:	f002 fc9e 	bl	c0d037c0 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d00e84:	2001      	movs	r0, #1
c0d00e86:	7030      	strb	r0, [r6, #0]
                        THROW(0x6D09);
c0d00e88:	4806      	ldr	r0, [pc, #24]	; (c0d00ea4 <IOTA_main+0x26c>)
c0d00e8a:	6800      	ldr	r0, [r0, #0]
c0d00e8c:	3109      	adds	r1, #9
c0d00e8e:	f002 fc97 	bl	c0d037c0 <longjmp>
c0d00e92:	46c0      	nop			; (mov r8, r8)
c0d00e94:	74696157 	.word	0x74696157
c0d00e98:	20676e69 	.word	0x20676e69
c0d00e9c:	20726f66 	.word	0x20726f66
c0d00ea0:	0067736d 	.word	0x0067736d
c0d00ea4:	20001bb8 	.word	0x20001bb8
c0d00ea8:	0000ffff 	.word	0x0000ffff
c0d00eac:	000007ff 	.word	0x000007ff
c0d00eb0:	20001c08 	.word	0x20001c08
c0d00eb4:	20001b48 	.word	0x20001b48
c0d00eb8:	20001b4c 	.word	0x20001b4c
c0d00ebc:	00006a86 	.word	0x00006a86
c0d00ec0:	20646142 	.word	0x20646142
c0d00ec4:	6b627550 	.word	0x6b627550
c0d00ec8:	00007965 	.word	0x00007965
c0d00ecc:	00006982 	.word	0x00006982

c0d00ed0 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00ed0:	4801      	ldr	r0, [pc, #4]	; (c0d00ed8 <os_boot+0x8>)
c0d00ed2:	2100      	movs	r1, #0
c0d00ed4:	6001      	str	r1, [r0, #0]
}
c0d00ed6:	4770      	bx	lr
c0d00ed8:	20001bb8 	.word	0x20001bb8

c0d00edc <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00edc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00ede:	af03      	add	r7, sp, #12
c0d00ee0:	b083      	sub	sp, #12
c0d00ee2:	9202      	str	r2, [sp, #8]
c0d00ee4:	460c      	mov	r4, r1
c0d00ee6:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00ee8:	4d4a      	ldr	r5, [pc, #296]	; (c0d01014 <io_usb_hid_receive+0x138>)
c0d00eea:	42ac      	cmp	r4, r5
c0d00eec:	d00f      	beq.n	c0d00f0e <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00eee:	4e49      	ldr	r6, [pc, #292]	; (c0d01014 <io_usb_hid_receive+0x138>)
c0d00ef0:	2540      	movs	r5, #64	; 0x40
c0d00ef2:	4630      	mov	r0, r6
c0d00ef4:	4629      	mov	r1, r5
c0d00ef6:	f002 fbc1 	bl	c0d0367c <__aeabi_memclr>
c0d00efa:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00efc:	2840      	cmp	r0, #64	; 0x40
c0d00efe:	4602      	mov	r2, r0
c0d00f00:	d300      	bcc.n	c0d00f04 <io_usb_hid_receive+0x28>
c0d00f02:	462a      	mov	r2, r5
c0d00f04:	4630      	mov	r0, r6
c0d00f06:	4621      	mov	r1, r4
c0d00f08:	f000 f89e 	bl	c0d01048 <os_memmove>
c0d00f0c:	4d41      	ldr	r5, [pc, #260]	; (c0d01014 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00f0e:	78a8      	ldrb	r0, [r5, #2]
c0d00f10:	2805      	cmp	r0, #5
c0d00f12:	d900      	bls.n	c0d00f16 <io_usb_hid_receive+0x3a>
c0d00f14:	e076      	b.n	c0d01004 <io_usb_hid_receive+0x128>
c0d00f16:	46c0      	nop			; (mov r8, r8)
c0d00f18:	4478      	add	r0, pc
c0d00f1a:	7900      	ldrb	r0, [r0, #4]
c0d00f1c:	0040      	lsls	r0, r0, #1
c0d00f1e:	4487      	add	pc, r0
c0d00f20:	71130c02 	.word	0x71130c02
c0d00f24:	1f71      	.short	0x1f71
c0d00f26:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00f28:	71ae      	strb	r6, [r5, #6]
c0d00f2a:	716e      	strb	r6, [r5, #5]
c0d00f2c:	712e      	strb	r6, [r5, #4]
c0d00f2e:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00f30:	2140      	movs	r1, #64	; 0x40
c0d00f32:	4628      	mov	r0, r5
c0d00f34:	9a01      	ldr	r2, [sp, #4]
c0d00f36:	4790      	blx	r2
c0d00f38:	e00b      	b.n	c0d00f52 <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d00f3a:	1ce8      	adds	r0, r5, #3
c0d00f3c:	2104      	movs	r1, #4
c0d00f3e:	f000 ff73 	bl	c0d01e28 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00f42:	2140      	movs	r1, #64	; 0x40
c0d00f44:	4628      	mov	r0, r5
c0d00f46:	e001      	b.n	c0d00f4c <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00f48:	4832      	ldr	r0, [pc, #200]	; (c0d01014 <io_usb_hid_receive+0x138>)
c0d00f4a:	2140      	movs	r1, #64	; 0x40
c0d00f4c:	9a01      	ldr	r2, [sp, #4]
c0d00f4e:	4790      	blx	r2
c0d00f50:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00f52:	4831      	ldr	r0, [pc, #196]	; (c0d01018 <io_usb_hid_receive+0x13c>)
c0d00f54:	2100      	movs	r1, #0
c0d00f56:	6001      	str	r1, [r0, #0]
c0d00f58:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d00f5a:	b2c0      	uxtb	r0, r0
c0d00f5c:	b003      	add	sp, #12
c0d00f5e:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d00f60:	78e8      	ldrb	r0, [r5, #3]
c0d00f62:	4c2d      	ldr	r4, [pc, #180]	; (c0d01018 <io_usb_hid_receive+0x13c>)
c0d00f64:	6821      	ldr	r1, [r4, #0]
c0d00f66:	0a09      	lsrs	r1, r1, #8
c0d00f68:	2600      	movs	r6, #0
c0d00f6a:	4288      	cmp	r0, r1
c0d00f6c:	d1f1      	bne.n	c0d00f52 <io_usb_hid_receive+0x76>
c0d00f6e:	7928      	ldrb	r0, [r5, #4]
c0d00f70:	6821      	ldr	r1, [r4, #0]
c0d00f72:	b2c9      	uxtb	r1, r1
c0d00f74:	4288      	cmp	r0, r1
c0d00f76:	d1ec      	bne.n	c0d00f52 <io_usb_hid_receive+0x76>
c0d00f78:	4b28      	ldr	r3, [pc, #160]	; (c0d0101c <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d00f7a:	9802      	ldr	r0, [sp, #8]
c0d00f7c:	18c0      	adds	r0, r0, r3
c0d00f7e:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d00f80:	6820      	ldr	r0, [r4, #0]
c0d00f82:	2800      	cmp	r0, #0
c0d00f84:	d00e      	beq.n	c0d00fa4 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d00f86:	4629      	mov	r1, r5
c0d00f88:	4019      	ands	r1, r3
c0d00f8a:	4825      	ldr	r0, [pc, #148]	; (c0d01020 <io_usb_hid_receive+0x144>)
c0d00f8c:	6802      	ldr	r2, [r0, #0]
c0d00f8e:	4291      	cmp	r1, r2
c0d00f90:	461e      	mov	r6, r3
c0d00f92:	d900      	bls.n	c0d00f96 <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d00f94:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d00f96:	462a      	mov	r2, r5
c0d00f98:	4032      	ands	r2, r6
c0d00f9a:	4822      	ldr	r0, [pc, #136]	; (c0d01024 <io_usb_hid_receive+0x148>)
c0d00f9c:	6800      	ldr	r0, [r0, #0]
c0d00f9e:	491d      	ldr	r1, [pc, #116]	; (c0d01014 <io_usb_hid_receive+0x138>)
c0d00fa0:	1d49      	adds	r1, r1, #5
c0d00fa2:	e021      	b.n	c0d00fe8 <io_usb_hid_receive+0x10c>
c0d00fa4:	9301      	str	r3, [sp, #4]
c0d00fa6:	491b      	ldr	r1, [pc, #108]	; (c0d01014 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d00fa8:	7988      	ldrb	r0, [r1, #6]
c0d00faa:	7949      	ldrb	r1, [r1, #5]
c0d00fac:	0209      	lsls	r1, r1, #8
c0d00fae:	4301      	orrs	r1, r0
c0d00fb0:	481d      	ldr	r0, [pc, #116]	; (c0d01028 <io_usb_hid_receive+0x14c>)
c0d00fb2:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d00fb4:	6801      	ldr	r1, [r0, #0]
c0d00fb6:	2241      	movs	r2, #65	; 0x41
c0d00fb8:	0092      	lsls	r2, r2, #2
c0d00fba:	4291      	cmp	r1, r2
c0d00fbc:	d8c9      	bhi.n	c0d00f52 <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d00fbe:	6801      	ldr	r1, [r0, #0]
c0d00fc0:	4817      	ldr	r0, [pc, #92]	; (c0d01020 <io_usb_hid_receive+0x144>)
c0d00fc2:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00fc4:	4917      	ldr	r1, [pc, #92]	; (c0d01024 <io_usb_hid_receive+0x148>)
c0d00fc6:	4a19      	ldr	r2, [pc, #100]	; (c0d0102c <io_usb_hid_receive+0x150>)
c0d00fc8:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00fca:	4919      	ldr	r1, [pc, #100]	; (c0d01030 <io_usb_hid_receive+0x154>)
c0d00fcc:	9a02      	ldr	r2, [sp, #8]
c0d00fce:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00fd0:	4629      	mov	r1, r5
c0d00fd2:	9e01      	ldr	r6, [sp, #4]
c0d00fd4:	4031      	ands	r1, r6
c0d00fd6:	6802      	ldr	r2, [r0, #0]
c0d00fd8:	4291      	cmp	r1, r2
c0d00fda:	d900      	bls.n	c0d00fde <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00fdc:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00fde:	462a      	mov	r2, r5
c0d00fe0:	4032      	ands	r2, r6
c0d00fe2:	480c      	ldr	r0, [pc, #48]	; (c0d01014 <io_usb_hid_receive+0x138>)
c0d00fe4:	1dc1      	adds	r1, r0, #7
c0d00fe6:	4811      	ldr	r0, [pc, #68]	; (c0d0102c <io_usb_hid_receive+0x150>)
c0d00fe8:	f000 f82e 	bl	c0d01048 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00fec:	4035      	ands	r5, r6
c0d00fee:	480d      	ldr	r0, [pc, #52]	; (c0d01024 <io_usb_hid_receive+0x148>)
c0d00ff0:	6801      	ldr	r1, [r0, #0]
c0d00ff2:	1949      	adds	r1, r1, r5
c0d00ff4:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d00ff6:	480a      	ldr	r0, [pc, #40]	; (c0d01020 <io_usb_hid_receive+0x144>)
c0d00ff8:	6801      	ldr	r1, [r0, #0]
c0d00ffa:	1b49      	subs	r1, r1, r5
c0d00ffc:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00ffe:	6820      	ldr	r0, [r4, #0]
c0d01000:	1c40      	adds	r0, r0, #1
c0d01002:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d01004:	4806      	ldr	r0, [pc, #24]	; (c0d01020 <io_usb_hid_receive+0x144>)
c0d01006:	6801      	ldr	r1, [r0, #0]
c0d01008:	2001      	movs	r0, #1
c0d0100a:	2602      	movs	r6, #2
c0d0100c:	2900      	cmp	r1, #0
c0d0100e:	d1a4      	bne.n	c0d00f5a <io_usb_hid_receive+0x7e>
c0d01010:	e79f      	b.n	c0d00f52 <io_usb_hid_receive+0x76>
c0d01012:	46c0      	nop			; (mov r8, r8)
c0d01014:	20001bbc 	.word	0x20001bbc
c0d01018:	20001bfc 	.word	0x20001bfc
c0d0101c:	0000ffff 	.word	0x0000ffff
c0d01020:	20001c04 	.word	0x20001c04
c0d01024:	20001d0c 	.word	0x20001d0c
c0d01028:	20001c00 	.word	0x20001c00
c0d0102c:	20001c08 	.word	0x20001c08
c0d01030:	0001fff9 	.word	0x0001fff9

c0d01034 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d01034:	b580      	push	{r7, lr}
c0d01036:	af00      	add	r7, sp, #0
c0d01038:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d0103a:	2a00      	cmp	r2, #0
c0d0103c:	d003      	beq.n	c0d01046 <os_memset+0x12>
    DSTCHAR[length] = c;
c0d0103e:	4611      	mov	r1, r2
c0d01040:	461a      	mov	r2, r3
c0d01042:	f002 fb25 	bl	c0d03690 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d01046:	bd80      	pop	{r7, pc}

c0d01048 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d01048:	b5b0      	push	{r4, r5, r7, lr}
c0d0104a:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d0104c:	4288      	cmp	r0, r1
c0d0104e:	d90d      	bls.n	c0d0106c <os_memmove+0x24>
    while(length--) {
c0d01050:	2a00      	cmp	r2, #0
c0d01052:	d014      	beq.n	c0d0107e <os_memmove+0x36>
c0d01054:	1e49      	subs	r1, r1, #1
c0d01056:	4252      	negs	r2, r2
c0d01058:	1e40      	subs	r0, r0, #1
c0d0105a:	2300      	movs	r3, #0
c0d0105c:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d0105e:	461c      	mov	r4, r3
c0d01060:	4354      	muls	r4, r2
c0d01062:	5d0d      	ldrb	r5, [r1, r4]
c0d01064:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d01066:	1c52      	adds	r2, r2, #1
c0d01068:	d1f9      	bne.n	c0d0105e <os_memmove+0x16>
c0d0106a:	e008      	b.n	c0d0107e <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d0106c:	2a00      	cmp	r2, #0
c0d0106e:	d006      	beq.n	c0d0107e <os_memmove+0x36>
c0d01070:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d01072:	b29c      	uxth	r4, r3
c0d01074:	5d0d      	ldrb	r5, [r1, r4]
c0d01076:	5505      	strb	r5, [r0, r4]
      l++;
c0d01078:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d0107a:	1e52      	subs	r2, r2, #1
c0d0107c:	d1f9      	bne.n	c0d01072 <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d0107e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01080 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01080:	4801      	ldr	r0, [pc, #4]	; (c0d01088 <io_usb_hid_init+0x8>)
c0d01082:	2100      	movs	r1, #0
c0d01084:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d01086:	4770      	bx	lr
c0d01088:	20001bfc 	.word	0x20001bfc

c0d0108c <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d0108c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0108e:	af03      	add	r7, sp, #12
c0d01090:	b087      	sub	sp, #28
c0d01092:	9301      	str	r3, [sp, #4]
c0d01094:	9203      	str	r2, [sp, #12]
c0d01096:	460e      	mov	r6, r1
c0d01098:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d0109a:	2e00      	cmp	r6, #0
c0d0109c:	d042      	beq.n	c0d01124 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d0109e:	4d31      	ldr	r5, [pc, #196]	; (c0d01164 <io_usb_hid_exchange+0xd8>)
c0d010a0:	2000      	movs	r0, #0
c0d010a2:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d010a4:	4930      	ldr	r1, [pc, #192]	; (c0d01168 <io_usb_hid_exchange+0xdc>)
c0d010a6:	4831      	ldr	r0, [pc, #196]	; (c0d0116c <io_usb_hid_exchange+0xe0>)
c0d010a8:	6008      	str	r0, [r1, #0]
c0d010aa:	4c31      	ldr	r4, [pc, #196]	; (c0d01170 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d010ac:	1d60      	adds	r0, r4, #5
c0d010ae:	213b      	movs	r1, #59	; 0x3b
c0d010b0:	9005      	str	r0, [sp, #20]
c0d010b2:	9102      	str	r1, [sp, #8]
c0d010b4:	f002 fae2 	bl	c0d0367c <__aeabi_memclr>
c0d010b8:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d010ba:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d010bc:	6828      	ldr	r0, [r5, #0]
c0d010be:	0a00      	lsrs	r0, r0, #8
c0d010c0:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d010c2:	6828      	ldr	r0, [r5, #0]
c0d010c4:	7120      	strb	r0, [r4, #4]
c0d010c6:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d010c8:	6828      	ldr	r0, [r5, #0]
c0d010ca:	2800      	cmp	r0, #0
c0d010cc:	9106      	str	r1, [sp, #24]
c0d010ce:	d009      	beq.n	c0d010e4 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d010d0:	293b      	cmp	r1, #59	; 0x3b
c0d010d2:	460a      	mov	r2, r1
c0d010d4:	d300      	bcc.n	c0d010d8 <io_usb_hid_exchange+0x4c>
c0d010d6:	9a02      	ldr	r2, [sp, #8]
c0d010d8:	4823      	ldr	r0, [pc, #140]	; (c0d01168 <io_usb_hid_exchange+0xdc>)
c0d010da:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d010dc:	6819      	ldr	r1, [r3, #0]
c0d010de:	9805      	ldr	r0, [sp, #20]
c0d010e0:	461e      	mov	r6, r3
c0d010e2:	e00a      	b.n	c0d010fa <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d010e4:	0a30      	lsrs	r0, r6, #8
c0d010e6:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d010e8:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d010ea:	2039      	movs	r0, #57	; 0x39
c0d010ec:	2939      	cmp	r1, #57	; 0x39
c0d010ee:	460a      	mov	r2, r1
c0d010f0:	d300      	bcc.n	c0d010f4 <io_usb_hid_exchange+0x68>
c0d010f2:	4602      	mov	r2, r0
c0d010f4:	4e1c      	ldr	r6, [pc, #112]	; (c0d01168 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d010f6:	6831      	ldr	r1, [r6, #0]
c0d010f8:	1de0      	adds	r0, r4, #7
c0d010fa:	9205      	str	r2, [sp, #20]
c0d010fc:	f7ff ffa4 	bl	c0d01048 <os_memmove>
c0d01100:	4d18      	ldr	r5, [pc, #96]	; (c0d01164 <io_usb_hid_exchange+0xd8>)
c0d01102:	6830      	ldr	r0, [r6, #0]
c0d01104:	4631      	mov	r1, r6
c0d01106:	9e05      	ldr	r6, [sp, #20]
c0d01108:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d0110a:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d0110c:	6828      	ldr	r0, [r5, #0]
c0d0110e:	1c40      	adds	r0, r0, #1
c0d01110:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d01112:	2140      	movs	r1, #64	; 0x40
c0d01114:	4620      	mov	r0, r4
c0d01116:	9a04      	ldr	r2, [sp, #16]
c0d01118:	4790      	blx	r2
c0d0111a:	9806      	ldr	r0, [sp, #24]
c0d0111c:	1b86      	subs	r6, r0, r6
c0d0111e:	4815      	ldr	r0, [pc, #84]	; (c0d01174 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d01120:	4206      	tst	r6, r0
c0d01122:	d1c3      	bne.n	c0d010ac <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01124:	480f      	ldr	r0, [pc, #60]	; (c0d01164 <io_usb_hid_exchange+0xd8>)
c0d01126:	2400      	movs	r4, #0
c0d01128:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d0112a:	2080      	movs	r0, #128	; 0x80
c0d0112c:	9901      	ldr	r1, [sp, #4]
c0d0112e:	4201      	tst	r1, r0
c0d01130:	d001      	beq.n	c0d01136 <io_usb_hid_exchange+0xaa>
    reset();
c0d01132:	f000 fe3f 	bl	c0d01db4 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d01136:	9801      	ldr	r0, [sp, #4]
c0d01138:	0680      	lsls	r0, r0, #26
c0d0113a:	d40f      	bmi.n	c0d0115c <io_usb_hid_exchange+0xd0>
c0d0113c:	4c0c      	ldr	r4, [pc, #48]	; (c0d01170 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d0113e:	2140      	movs	r1, #64	; 0x40
c0d01140:	4620      	mov	r0, r4
c0d01142:	9a03      	ldr	r2, [sp, #12]
c0d01144:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d01146:	b2c2      	uxtb	r2, r0
c0d01148:	2a40      	cmp	r2, #64	; 0x40
c0d0114a:	d8f8      	bhi.n	c0d0113e <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d0114c:	9804      	ldr	r0, [sp, #16]
c0d0114e:	4621      	mov	r1, r4
c0d01150:	f7ff fec4 	bl	c0d00edc <io_usb_hid_receive>
c0d01154:	2802      	cmp	r0, #2
c0d01156:	d1f2      	bne.n	c0d0113e <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d01158:	4807      	ldr	r0, [pc, #28]	; (c0d01178 <io_usb_hid_exchange+0xec>)
c0d0115a:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d0115c:	b2a0      	uxth	r0, r4
c0d0115e:	b007      	add	sp, #28
c0d01160:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01162:	46c0      	nop			; (mov r8, r8)
c0d01164:	20001bfc 	.word	0x20001bfc
c0d01168:	20001d0c 	.word	0x20001d0c
c0d0116c:	20001c08 	.word	0x20001c08
c0d01170:	20001bbc 	.word	0x20001bbc
c0d01174:	0000ffff 	.word	0x0000ffff
c0d01178:	20001c00 	.word	0x20001c00

c0d0117c <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d0117c:	b580      	push	{r7, lr}
c0d0117e:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d01180:	f000 ffbc 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d01184:	2800      	cmp	r0, #0
c0d01186:	d10b      	bne.n	c0d011a0 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d01188:	4806      	ldr	r0, [pc, #24]	; (c0d011a4 <io_seproxyhal_general_status+0x28>)
c0d0118a:	2160      	movs	r1, #96	; 0x60
c0d0118c:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d0118e:	2100      	movs	r1, #0
c0d01190:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d01192:	2202      	movs	r2, #2
c0d01194:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d01196:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d01198:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d0119a:	2105      	movs	r1, #5
c0d0119c:	f000 ff90 	bl	c0d020c0 <io_seproxyhal_spi_send>
}
c0d011a0:	bd80      	pop	{r7, pc}
c0d011a2:	46c0      	nop			; (mov r8, r8)
c0d011a4:	20001a18 	.word	0x20001a18

c0d011a8 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d011a8:	b5d0      	push	{r4, r6, r7, lr}
c0d011aa:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d011ac:	4815      	ldr	r0, [pc, #84]	; (c0d01204 <io_seproxyhal_handle_usb_event+0x5c>)
c0d011ae:	78c0      	ldrb	r0, [r0, #3]
c0d011b0:	1e40      	subs	r0, r0, #1
c0d011b2:	2807      	cmp	r0, #7
c0d011b4:	d824      	bhi.n	c0d01200 <io_seproxyhal_handle_usb_event+0x58>
c0d011b6:	46c0      	nop			; (mov r8, r8)
c0d011b8:	4478      	add	r0, pc
c0d011ba:	7900      	ldrb	r0, [r0, #4]
c0d011bc:	0040      	lsls	r0, r0, #1
c0d011be:	4487      	add	pc, r0
c0d011c0:	141f1803 	.word	0x141f1803
c0d011c4:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d011c8:	4c0f      	ldr	r4, [pc, #60]	; (c0d01208 <io_seproxyhal_handle_usb_event+0x60>)
c0d011ca:	2101      	movs	r1, #1
c0d011cc:	4620      	mov	r0, r4
c0d011ce:	f001 fbd5 	bl	c0d0297c <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d011d2:	4620      	mov	r0, r4
c0d011d4:	f001 fbba 	bl	c0d0294c <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d011d8:	480c      	ldr	r0, [pc, #48]	; (c0d0120c <io_seproxyhal_handle_usb_event+0x64>)
c0d011da:	7800      	ldrb	r0, [r0, #0]
c0d011dc:	2801      	cmp	r0, #1
c0d011de:	d10f      	bne.n	c0d01200 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d011e0:	480b      	ldr	r0, [pc, #44]	; (c0d01210 <io_seproxyhal_handle_usb_event+0x68>)
c0d011e2:	6800      	ldr	r0, [r0, #0]
c0d011e4:	2110      	movs	r1, #16
c0d011e6:	f002 faeb 	bl	c0d037c0 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d011ea:	4807      	ldr	r0, [pc, #28]	; (c0d01208 <io_seproxyhal_handle_usb_event+0x60>)
c0d011ec:	f001 fbc9 	bl	c0d02982 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d011f0:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d011f2:	4805      	ldr	r0, [pc, #20]	; (c0d01208 <io_seproxyhal_handle_usb_event+0x60>)
c0d011f4:	f001 fbc9 	bl	c0d0298a <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d011f8:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d011fa:	4803      	ldr	r0, [pc, #12]	; (c0d01208 <io_seproxyhal_handle_usb_event+0x60>)
c0d011fc:	f001 fbc3 	bl	c0d02986 <USBD_LL_Resume>
      break;
  }
}
c0d01200:	bdd0      	pop	{r4, r6, r7, pc}
c0d01202:	46c0      	nop			; (mov r8, r8)
c0d01204:	20001a18 	.word	0x20001a18
c0d01208:	20001d34 	.word	0x20001d34
c0d0120c:	20001d10 	.word	0x20001d10
c0d01210:	20001bb8 	.word	0x20001bb8

c0d01214 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d01214:	217f      	movs	r1, #127	; 0x7f
c0d01216:	4001      	ands	r1, r0
c0d01218:	4801      	ldr	r0, [pc, #4]	; (c0d01220 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d0121a:	5c40      	ldrb	r0, [r0, r1]
c0d0121c:	4770      	bx	lr
c0d0121e:	46c0      	nop			; (mov r8, r8)
c0d01220:	20001d11 	.word	0x20001d11

c0d01224 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d01224:	b580      	push	{r7, lr}
c0d01226:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d01228:	480f      	ldr	r0, [pc, #60]	; (c0d01268 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d0122a:	7901      	ldrb	r1, [r0, #4]
c0d0122c:	2904      	cmp	r1, #4
c0d0122e:	d008      	beq.n	c0d01242 <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d01230:	2902      	cmp	r1, #2
c0d01232:	d011      	beq.n	c0d01258 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d01234:	2901      	cmp	r1, #1
c0d01236:	d10e      	bne.n	c0d01256 <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d01238:	1d81      	adds	r1, r0, #6
c0d0123a:	480d      	ldr	r0, [pc, #52]	; (c0d01270 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d0123c:	f001 faaa 	bl	c0d02794 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d01240:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d01242:	78c2      	ldrb	r2, [r0, #3]
c0d01244:	217f      	movs	r1, #127	; 0x7f
c0d01246:	4011      	ands	r1, r2
c0d01248:	7942      	ldrb	r2, [r0, #5]
c0d0124a:	4b08      	ldr	r3, [pc, #32]	; (c0d0126c <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d0124c:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d0124e:	1d82      	adds	r2, r0, #6
c0d01250:	4807      	ldr	r0, [pc, #28]	; (c0d01270 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01252:	f001 fad1 	bl	c0d027f8 <USBD_LL_DataOutStage>
      break;
  }
}
c0d01256:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01258:	78c2      	ldrb	r2, [r0, #3]
c0d0125a:	217f      	movs	r1, #127	; 0x7f
c0d0125c:	4011      	ands	r1, r2
c0d0125e:	1d82      	adds	r2, r0, #6
c0d01260:	4803      	ldr	r0, [pc, #12]	; (c0d01270 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01262:	f001 fb0f 	bl	c0d02884 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d01266:	bd80      	pop	{r7, pc}
c0d01268:	20001a18 	.word	0x20001a18
c0d0126c:	20001d11 	.word	0x20001d11
c0d01270:	20001d34 	.word	0x20001d34

c0d01274 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d01274:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01276:	af03      	add	r7, sp, #12
c0d01278:	b083      	sub	sp, #12
c0d0127a:	9201      	str	r2, [sp, #4]
c0d0127c:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d0127e:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d01280:	2b00      	cmp	r3, #0
c0d01282:	d100      	bne.n	c0d01286 <io_usb_send_ep+0x12>
c0d01284:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d01286:	9801      	ldr	r0, [sp, #4]
c0d01288:	28ff      	cmp	r0, #255	; 0xff
c0d0128a:	d843      	bhi.n	c0d01314 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0128c:	4e25      	ldr	r6, [pc, #148]	; (c0d01324 <io_usb_send_ep+0xb0>)
c0d0128e:	2050      	movs	r0, #80	; 0x50
c0d01290:	7030      	strb	r0, [r6, #0]
c0d01292:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d01294:	1ce0      	adds	r0, r4, #3
c0d01296:	9100      	str	r1, [sp, #0]
c0d01298:	0a01      	lsrs	r1, r0, #8
c0d0129a:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d0129c:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d0129e:	2080      	movs	r0, #128	; 0x80
c0d012a0:	4302      	orrs	r2, r0
c0d012a2:	9202      	str	r2, [sp, #8]
c0d012a4:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d012a6:	2020      	movs	r0, #32
c0d012a8:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d012aa:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d012ac:	2106      	movs	r1, #6
c0d012ae:	4630      	mov	r0, r6
c0d012b0:	f000 ff06 	bl	c0d020c0 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d012b4:	9800      	ldr	r0, [sp, #0]
c0d012b6:	4621      	mov	r1, r4
c0d012b8:	f000 ff02 	bl	c0d020c0 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d012bc:	2d00      	cmp	r5, #0
c0d012be:	d10d      	bne.n	c0d012dc <io_usb_send_ep+0x68>
c0d012c0:	e028      	b.n	c0d01314 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d012c2:	2d00      	cmp	r5, #0
c0d012c4:	d002      	beq.n	c0d012cc <io_usb_send_ep+0x58>
c0d012c6:	1e6c      	subs	r4, r5, #1
c0d012c8:	2d01      	cmp	r5, #1
c0d012ca:	d025      	beq.n	c0d01318 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d012cc:	2915      	cmp	r1, #21
c0d012ce:	d102      	bne.n	c0d012d6 <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d012d0:	79b0      	ldrb	r0, [r6, #6]
c0d012d2:	0700      	lsls	r0, r0, #28
c0d012d4:	d520      	bpl.n	c0d01318 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d012d6:	f000 f829 	bl	c0d0132c <io_seproxyhal_handle_event>
c0d012da:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d012dc:	f000 ff0e 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d012e0:	2800      	cmp	r0, #0
c0d012e2:	d101      	bne.n	c0d012e8 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d012e4:	f7ff ff4a 	bl	c0d0117c <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d012e8:	2180      	movs	r1, #128	; 0x80
c0d012ea:	2400      	movs	r4, #0
c0d012ec:	4630      	mov	r0, r6
c0d012ee:	4622      	mov	r2, r4
c0d012f0:	f000 ff20 	bl	c0d02134 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d012f4:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d012f6:	2806      	cmp	r0, #6
c0d012f8:	d1e3      	bne.n	c0d012c2 <io_usb_send_ep+0x4e>
c0d012fa:	2910      	cmp	r1, #16
c0d012fc:	d1e1      	bne.n	c0d012c2 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d012fe:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d01300:	9a02      	ldr	r2, [sp, #8]
c0d01302:	4290      	cmp	r0, r2
c0d01304:	d1dd      	bne.n	c0d012c2 <io_usb_send_ep+0x4e>
c0d01306:	7930      	ldrb	r0, [r6, #4]
c0d01308:	2802      	cmp	r0, #2
c0d0130a:	d1da      	bne.n	c0d012c2 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d0130c:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d0130e:	9a01      	ldr	r2, [sp, #4]
c0d01310:	4290      	cmp	r0, r2
c0d01312:	d1d6      	bne.n	c0d012c2 <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d01314:	b003      	add	sp, #12
c0d01316:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01318:	4803      	ldr	r0, [pc, #12]	; (c0d01328 <io_usb_send_ep+0xb4>)
c0d0131a:	6800      	ldr	r0, [r0, #0]
c0d0131c:	2110      	movs	r1, #16
c0d0131e:	f002 fa4f 	bl	c0d037c0 <longjmp>
c0d01322:	46c0      	nop			; (mov r8, r8)
c0d01324:	20001a18 	.word	0x20001a18
c0d01328:	20001bb8 	.word	0x20001bb8

c0d0132c <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d0132c:	b580      	push	{r7, lr}
c0d0132e:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d01330:	480d      	ldr	r0, [pc, #52]	; (c0d01368 <io_seproxyhal_handle_event+0x3c>)
c0d01332:	7882      	ldrb	r2, [r0, #2]
c0d01334:	7841      	ldrb	r1, [r0, #1]
c0d01336:	0209      	lsls	r1, r1, #8
c0d01338:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d0133a:	7800      	ldrb	r0, [r0, #0]
c0d0133c:	2810      	cmp	r0, #16
c0d0133e:	d008      	beq.n	c0d01352 <io_seproxyhal_handle_event+0x26>
c0d01340:	280f      	cmp	r0, #15
c0d01342:	d10d      	bne.n	c0d01360 <io_seproxyhal_handle_event+0x34>
c0d01344:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d01346:	2904      	cmp	r1, #4
c0d01348:	d10d      	bne.n	c0d01366 <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d0134a:	f7ff ff2d 	bl	c0d011a8 <io_seproxyhal_handle_usb_event>
c0d0134e:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01350:	bd80      	pop	{r7, pc}
c0d01352:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d01354:	2906      	cmp	r1, #6
c0d01356:	d306      	bcc.n	c0d01366 <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d01358:	f7ff ff64 	bl	c0d01224 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d0135c:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d0135e:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d01360:	2002      	movs	r0, #2
c0d01362:	f7ff fb11 	bl	c0d00988 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d01366:	bd80      	pop	{r7, pc}
c0d01368:	20001a18 	.word	0x20001a18

c0d0136c <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d0136c:	b580      	push	{r7, lr}
c0d0136e:	af00      	add	r7, sp, #0
c0d01370:	460a      	mov	r2, r1
c0d01372:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01374:	2082      	movs	r0, #130	; 0x82
c0d01376:	2314      	movs	r3, #20
c0d01378:	f7ff ff7c 	bl	c0d01274 <io_usb_send_ep>
}
c0d0137c:	bd80      	pop	{r7, pc}
	...

c0d01380 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01380:	b5d0      	push	{r4, r6, r7, lr}
c0d01382:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01384:	2007      	movs	r0, #7
c0d01386:	f000 fcf7 	bl	c0d01d78 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d0138a:	480a      	ldr	r0, [pc, #40]	; (c0d013b4 <io_seproxyhal_init+0x34>)
c0d0138c:	2400      	movs	r4, #0
c0d0138e:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01390:	4809      	ldr	r0, [pc, #36]	; (c0d013b8 <io_seproxyhal_init+0x38>)
c0d01392:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d01394:	4809      	ldr	r0, [pc, #36]	; (c0d013bc <io_seproxyhal_init+0x3c>)
c0d01396:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d01398:	4809      	ldr	r0, [pc, #36]	; (c0d013c0 <io_seproxyhal_init+0x40>)
c0d0139a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0139c:	4809      	ldr	r0, [pc, #36]	; (c0d013c4 <io_seproxyhal_init+0x44>)
c0d0139e:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d013a0:	f7ff fe6e 	bl	c0d01080 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d013a4:	4808      	ldr	r0, [pc, #32]	; (c0d013c8 <io_seproxyhal_init+0x48>)
c0d013a6:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d013a8:	4808      	ldr	r0, [pc, #32]	; (c0d013cc <io_seproxyhal_init+0x4c>)
c0d013aa:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d013ac:	4808      	ldr	r0, [pc, #32]	; (c0d013d0 <io_seproxyhal_init+0x50>)
c0d013ae:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d013b0:	bdd0      	pop	{r4, r6, r7, pc}
c0d013b2:	46c0      	nop			; (mov r8, r8)
c0d013b4:	20001d18 	.word	0x20001d18
c0d013b8:	20001d1a 	.word	0x20001d1a
c0d013bc:	20001d1c 	.word	0x20001d1c
c0d013c0:	20001d1e 	.word	0x20001d1e
c0d013c4:	20001d10 	.word	0x20001d10
c0d013c8:	20001d20 	.word	0x20001d20
c0d013cc:	20001d24 	.word	0x20001d24
c0d013d0:	20001d28 	.word	0x20001d28

c0d013d4 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d013d4:	4801      	ldr	r0, [pc, #4]	; (c0d013dc <io_seproxyhal_init_ux+0x8>)
c0d013d6:	2100      	movs	r1, #0
c0d013d8:	6001      	str	r1, [r0, #0]

}
c0d013da:	4770      	bx	lr
c0d013dc:	20001d20 	.word	0x20001d20

c0d013e0 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d013e0:	b5b0      	push	{r4, r5, r7, lr}
c0d013e2:	af02      	add	r7, sp, #8
c0d013e4:	460d      	mov	r5, r1
c0d013e6:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d013e8:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d013ea:	2800      	cmp	r0, #0
c0d013ec:	d00c      	beq.n	c0d01408 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d013ee:	f000 fcab 	bl	c0d01d48 <pic>
c0d013f2:	4601      	mov	r1, r0
c0d013f4:	4620      	mov	r0, r4
c0d013f6:	4788      	blx	r1
c0d013f8:	f000 fca6 	bl	c0d01d48 <pic>
c0d013fc:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d013fe:	2800      	cmp	r0, #0
c0d01400:	d010      	beq.n	c0d01424 <io_seproxyhal_touch_out+0x44>
c0d01402:	2801      	cmp	r0, #1
c0d01404:	d000      	beq.n	c0d01408 <io_seproxyhal_touch_out+0x28>
c0d01406:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01408:	2d00      	cmp	r5, #0
c0d0140a:	d007      	beq.n	c0d0141c <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d0140c:	4620      	mov	r0, r4
c0d0140e:	47a8      	blx	r5
c0d01410:	2100      	movs	r1, #0
    if (!el) {
c0d01412:	2800      	cmp	r0, #0
c0d01414:	d006      	beq.n	c0d01424 <io_seproxyhal_touch_out+0x44>
c0d01416:	2801      	cmp	r0, #1
c0d01418:	d000      	beq.n	c0d0141c <io_seproxyhal_touch_out+0x3c>
c0d0141a:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d0141c:	4620      	mov	r0, r4
c0d0141e:	f7ff faad 	bl	c0d0097c <io_seproxyhal_display>
c0d01422:	2101      	movs	r1, #1
  return 1;
}
c0d01424:	4608      	mov	r0, r1
c0d01426:	bdb0      	pop	{r4, r5, r7, pc}

c0d01428 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01428:	b5b0      	push	{r4, r5, r7, lr}
c0d0142a:	af02      	add	r7, sp, #8
c0d0142c:	b08e      	sub	sp, #56	; 0x38
c0d0142e:	460c      	mov	r4, r1
c0d01430:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d01432:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d01434:	2800      	cmp	r0, #0
c0d01436:	d00c      	beq.n	c0d01452 <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d01438:	f000 fc86 	bl	c0d01d48 <pic>
c0d0143c:	4601      	mov	r1, r0
c0d0143e:	4628      	mov	r0, r5
c0d01440:	4788      	blx	r1
c0d01442:	f000 fc81 	bl	c0d01d48 <pic>
c0d01446:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01448:	2800      	cmp	r0, #0
c0d0144a:	d016      	beq.n	c0d0147a <io_seproxyhal_touch_over+0x52>
c0d0144c:	2801      	cmp	r0, #1
c0d0144e:	d000      	beq.n	c0d01452 <io_seproxyhal_touch_over+0x2a>
c0d01450:	4605      	mov	r5, r0
c0d01452:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d01454:	2238      	movs	r2, #56	; 0x38
c0d01456:	4629      	mov	r1, r5
c0d01458:	f7ff fdf6 	bl	c0d01048 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d0145c:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d0145e:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01460:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d01462:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d01464:	2c00      	cmp	r4, #0
c0d01466:	d004      	beq.n	c0d01472 <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01468:	4628      	mov	r0, r5
c0d0146a:	47a0      	blx	r4
c0d0146c:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d0146e:	2800      	cmp	r0, #0
c0d01470:	d003      	beq.n	c0d0147a <io_seproxyhal_touch_over+0x52>
c0d01472:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01474:	f7ff fa82 	bl	c0d0097c <io_seproxyhal_display>
c0d01478:	2101      	movs	r1, #1
  return 1;
}
c0d0147a:	4608      	mov	r0, r1
c0d0147c:	b00e      	add	sp, #56	; 0x38
c0d0147e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01480 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01480:	b5b0      	push	{r4, r5, r7, lr}
c0d01482:	af02      	add	r7, sp, #8
c0d01484:	460d      	mov	r5, r1
c0d01486:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01488:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d0148a:	2800      	cmp	r0, #0
c0d0148c:	d00c      	beq.n	c0d014a8 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d0148e:	f000 fc5b 	bl	c0d01d48 <pic>
c0d01492:	4601      	mov	r1, r0
c0d01494:	4620      	mov	r0, r4
c0d01496:	4788      	blx	r1
c0d01498:	f000 fc56 	bl	c0d01d48 <pic>
c0d0149c:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0149e:	2800      	cmp	r0, #0
c0d014a0:	d010      	beq.n	c0d014c4 <io_seproxyhal_touch_tap+0x44>
c0d014a2:	2801      	cmp	r0, #1
c0d014a4:	d000      	beq.n	c0d014a8 <io_seproxyhal_touch_tap+0x28>
c0d014a6:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d014a8:	2d00      	cmp	r5, #0
c0d014aa:	d007      	beq.n	c0d014bc <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d014ac:	4620      	mov	r0, r4
c0d014ae:	47a8      	blx	r5
c0d014b0:	2100      	movs	r1, #0
    if (!el) {
c0d014b2:	2800      	cmp	r0, #0
c0d014b4:	d006      	beq.n	c0d014c4 <io_seproxyhal_touch_tap+0x44>
c0d014b6:	2801      	cmp	r0, #1
c0d014b8:	d000      	beq.n	c0d014bc <io_seproxyhal_touch_tap+0x3c>
c0d014ba:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d014bc:	4620      	mov	r0, r4
c0d014be:	f7ff fa5d 	bl	c0d0097c <io_seproxyhal_display>
c0d014c2:	2101      	movs	r1, #1
  return 1;
}
c0d014c4:	4608      	mov	r0, r1
c0d014c6:	bdb0      	pop	{r4, r5, r7, pc}

c0d014c8 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d014c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d014ca:	af03      	add	r7, sp, #12
c0d014cc:	b087      	sub	sp, #28
c0d014ce:	9302      	str	r3, [sp, #8]
c0d014d0:	9203      	str	r2, [sp, #12]
c0d014d2:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d014d4:	2900      	cmp	r1, #0
c0d014d6:	d076      	beq.n	c0d015c6 <io_seproxyhal_touch_element_callback+0xfe>
c0d014d8:	9004      	str	r0, [sp, #16]
c0d014da:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d014dc:	9001      	str	r0, [sp, #4]
c0d014de:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d014e0:	9000      	str	r0, [sp, #0]
c0d014e2:	2600      	movs	r6, #0
c0d014e4:	9606      	str	r6, [sp, #24]
c0d014e6:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d014e8:	f000 fe08 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d014ec:	2800      	cmp	r0, #0
c0d014ee:	d155      	bne.n	c0d0159c <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d014f0:	2038      	movs	r0, #56	; 0x38
c0d014f2:	4370      	muls	r0, r6
c0d014f4:	9d04      	ldr	r5, [sp, #16]
c0d014f6:	182e      	adds	r6, r5, r0
c0d014f8:	4b36      	ldr	r3, [pc, #216]	; (c0d015d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d014fa:	681a      	ldr	r2, [r3, #0]
c0d014fc:	2101      	movs	r1, #1
c0d014fe:	4296      	cmp	r6, r2
c0d01500:	d000      	beq.n	c0d01504 <io_seproxyhal_touch_element_callback+0x3c>
c0d01502:	9906      	ldr	r1, [sp, #24]
c0d01504:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01506:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d01508:	2800      	cmp	r0, #0
c0d0150a:	da41      	bge.n	c0d01590 <io_seproxyhal_touch_element_callback+0xc8>
c0d0150c:	2020      	movs	r0, #32
c0d0150e:	5c35      	ldrb	r5, [r6, r0]
c0d01510:	2102      	movs	r1, #2
c0d01512:	5e71      	ldrsh	r1, [r6, r1]
c0d01514:	1b4a      	subs	r2, r1, r5
c0d01516:	9803      	ldr	r0, [sp, #12]
c0d01518:	4282      	cmp	r2, r0
c0d0151a:	dc39      	bgt.n	c0d01590 <io_seproxyhal_touch_element_callback+0xc8>
c0d0151c:	1869      	adds	r1, r5, r1
c0d0151e:	88f2      	ldrh	r2, [r6, #6]
c0d01520:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d01522:	9803      	ldr	r0, [sp, #12]
c0d01524:	4288      	cmp	r0, r1
c0d01526:	da33      	bge.n	c0d01590 <io_seproxyhal_touch_element_callback+0xc8>
c0d01528:	2104      	movs	r1, #4
c0d0152a:	5e70      	ldrsh	r0, [r6, r1]
c0d0152c:	1b42      	subs	r2, r0, r5
c0d0152e:	9902      	ldr	r1, [sp, #8]
c0d01530:	428a      	cmp	r2, r1
c0d01532:	dc2d      	bgt.n	c0d01590 <io_seproxyhal_touch_element_callback+0xc8>
c0d01534:	1940      	adds	r0, r0, r5
c0d01536:	8931      	ldrh	r1, [r6, #8]
c0d01538:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d0153a:	9902      	ldr	r1, [sp, #8]
c0d0153c:	4281      	cmp	r1, r0
c0d0153e:	da27      	bge.n	c0d01590 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01540:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d01542:	4286      	cmp	r6, r0
c0d01544:	d010      	beq.n	c0d01568 <io_seproxyhal_touch_element_callback+0xa0>
c0d01546:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01548:	2800      	cmp	r0, #0
c0d0154a:	d00d      	beq.n	c0d01568 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d0154c:	9801      	ldr	r0, [sp, #4]
c0d0154e:	2800      	cmp	r0, #0
c0d01550:	d005      	beq.n	c0d0155e <io_seproxyhal_touch_element_callback+0x96>
c0d01552:	4630      	mov	r0, r6
c0d01554:	9901      	ldr	r1, [sp, #4]
c0d01556:	4788      	blx	r1
c0d01558:	4b1e      	ldr	r3, [pc, #120]	; (c0d015d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0155a:	2800      	cmp	r0, #0
c0d0155c:	d018      	beq.n	c0d01590 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d0155e:	6818      	ldr	r0, [r3, #0]
c0d01560:	9901      	ldr	r1, [sp, #4]
c0d01562:	f7ff ff3d 	bl	c0d013e0 <io_seproxyhal_touch_out>
c0d01566:	e008      	b.n	c0d0157a <io_seproxyhal_touch_element_callback+0xb2>
c0d01568:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d0156a:	2801      	cmp	r0, #1
c0d0156c:	d009      	beq.n	c0d01582 <io_seproxyhal_touch_element_callback+0xba>
c0d0156e:	2802      	cmp	r0, #2
c0d01570:	d10e      	bne.n	c0d01590 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d01572:	4630      	mov	r0, r6
c0d01574:	9901      	ldr	r1, [sp, #4]
c0d01576:	f7ff ff83 	bl	c0d01480 <io_seproxyhal_touch_tap>
c0d0157a:	4b16      	ldr	r3, [pc, #88]	; (c0d015d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0157c:	2800      	cmp	r0, #0
c0d0157e:	d007      	beq.n	c0d01590 <io_seproxyhal_touch_element_callback+0xc8>
c0d01580:	e023      	b.n	c0d015ca <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d01582:	4630      	mov	r0, r6
c0d01584:	9901      	ldr	r1, [sp, #4]
c0d01586:	f7ff ff4f 	bl	c0d01428 <io_seproxyhal_touch_over>
c0d0158a:	4b12      	ldr	r3, [pc, #72]	; (c0d015d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0158c:	2800      	cmp	r0, #0
c0d0158e:	d11f      	bne.n	c0d015d0 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01590:	1c64      	adds	r4, r4, #1
c0d01592:	b2e6      	uxtb	r6, r4
c0d01594:	9805      	ldr	r0, [sp, #20]
c0d01596:	4286      	cmp	r6, r0
c0d01598:	d3a6      	bcc.n	c0d014e8 <io_seproxyhal_touch_element_callback+0x20>
c0d0159a:	e000      	b.n	c0d0159e <io_seproxyhal_touch_element_callback+0xd6>
c0d0159c:	4b0d      	ldr	r3, [pc, #52]	; (c0d015d4 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d0159e:	9806      	ldr	r0, [sp, #24]
c0d015a0:	0600      	lsls	r0, r0, #24
c0d015a2:	d010      	beq.n	c0d015c6 <io_seproxyhal_touch_element_callback+0xfe>
c0d015a4:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d015a6:	2800      	cmp	r0, #0
c0d015a8:	d00d      	beq.n	c0d015c6 <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d015aa:	f000 fda7 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d015ae:	4909      	ldr	r1, [pc, #36]	; (c0d015d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d015b0:	2800      	cmp	r0, #0
c0d015b2:	d108      	bne.n	c0d015c6 <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d015b4:	6808      	ldr	r0, [r1, #0]
c0d015b6:	9901      	ldr	r1, [sp, #4]
c0d015b8:	f7ff ff12 	bl	c0d013e0 <io_seproxyhal_touch_out>
c0d015bc:	4d05      	ldr	r5, [pc, #20]	; (c0d015d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d015be:	2800      	cmp	r0, #0
c0d015c0:	d001      	beq.n	c0d015c6 <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d015c2:	2000      	movs	r0, #0
c0d015c4:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d015c6:	b007      	add	sp, #28
c0d015c8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d015ca:	2000      	movs	r0, #0
c0d015cc:	6018      	str	r0, [r3, #0]
c0d015ce:	e7fa      	b.n	c0d015c6 <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d015d0:	601e      	str	r6, [r3, #0]
c0d015d2:	e7f8      	b.n	c0d015c6 <io_seproxyhal_touch_element_callback+0xfe>
c0d015d4:	20001d20 	.word	0x20001d20

c0d015d8 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d015d8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d015da:	af03      	add	r7, sp, #12
c0d015dc:	b08b      	sub	sp, #44	; 0x2c
c0d015de:	460c      	mov	r4, r1
c0d015e0:	4601      	mov	r1, r0
c0d015e2:	ad04      	add	r5, sp, #16
c0d015e4:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d015e6:	4628      	mov	r0, r5
c0d015e8:	9203      	str	r2, [sp, #12]
c0d015ea:	f7ff fd2d 	bl	c0d01048 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d015ee:	6821      	ldr	r1, [r4, #0]
c0d015f0:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d015f2:	6862      	ldr	r2, [r4, #4]
c0d015f4:	9502      	str	r5, [sp, #8]
c0d015f6:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d015f8:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d015fa:	4e1a      	ldr	r6, [pc, #104]	; (c0d01664 <io_seproxyhal_display_icon+0x8c>)
c0d015fc:	2365      	movs	r3, #101	; 0x65
c0d015fe:	4635      	mov	r5, r6
c0d01600:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d01602:	b292      	uxth	r2, r2
c0d01604:	4342      	muls	r2, r0
c0d01606:	b28b      	uxth	r3, r1
c0d01608:	4353      	muls	r3, r2
c0d0160a:	08d9      	lsrs	r1, r3, #3
c0d0160c:	1c4e      	adds	r6, r1, #1
c0d0160e:	2207      	movs	r2, #7
c0d01610:	4213      	tst	r3, r2
c0d01612:	d100      	bne.n	c0d01616 <io_seproxyhal_display_icon+0x3e>
c0d01614:	460e      	mov	r6, r1
c0d01616:	4631      	mov	r1, r6
c0d01618:	9101      	str	r1, [sp, #4]
c0d0161a:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d0161c:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d0161e:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d01620:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01622:	0a01      	lsrs	r1, r0, #8
c0d01624:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d01626:	70a8      	strb	r0, [r5, #2]
c0d01628:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0162a:	4628      	mov	r0, r5
c0d0162c:	f000 fd48 	bl	c0d020c0 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01630:	9802      	ldr	r0, [sp, #8]
c0d01632:	9903      	ldr	r1, [sp, #12]
c0d01634:	f000 fd44 	bl	c0d020c0 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01638:	68a0      	ldr	r0, [r4, #8]
c0d0163a:	7028      	strb	r0, [r5, #0]
c0d0163c:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d0163e:	4628      	mov	r0, r5
c0d01640:	f000 fd3e 	bl	c0d020c0 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d01644:	68e0      	ldr	r0, [r4, #12]
c0d01646:	f000 fb7f 	bl	c0d01d48 <pic>
c0d0164a:	b2b1      	uxth	r1, r6
c0d0164c:	f000 fd38 	bl	c0d020c0 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01650:	9801      	ldr	r0, [sp, #4]
c0d01652:	b285      	uxth	r5, r0
c0d01654:	6920      	ldr	r0, [r4, #16]
c0d01656:	f000 fb77 	bl	c0d01d48 <pic>
c0d0165a:	4629      	mov	r1, r5
c0d0165c:	f000 fd30 	bl	c0d020c0 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01660:	b00b      	add	sp, #44	; 0x2c
c0d01662:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01664:	20001a18 	.word	0x20001a18

c0d01668 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01668:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0166a:	af03      	add	r7, sp, #12
c0d0166c:	b081      	sub	sp, #4
c0d0166e:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01670:	7820      	ldrb	r0, [r4, #0]
c0d01672:	267f      	movs	r6, #127	; 0x7f
c0d01674:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d01676:	2e00      	cmp	r6, #0
c0d01678:	d02e      	beq.n	c0d016d8 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d0167a:	69e0      	ldr	r0, [r4, #28]
c0d0167c:	2800      	cmp	r0, #0
c0d0167e:	d01d      	beq.n	c0d016bc <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01680:	f000 fb62 	bl	c0d01d48 <pic>
c0d01684:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d01686:	2e05      	cmp	r6, #5
c0d01688:	d102      	bne.n	c0d01690 <io_seproxyhal_display_default+0x28>
c0d0168a:	7ea0      	ldrb	r0, [r4, #26]
c0d0168c:	2800      	cmp	r0, #0
c0d0168e:	d025      	beq.n	c0d016dc <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01690:	4628      	mov	r0, r5
c0d01692:	f002 f8a3 	bl	c0d037dc <strlen>
c0d01696:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01698:	4813      	ldr	r0, [pc, #76]	; (c0d016e8 <io_seproxyhal_display_default+0x80>)
c0d0169a:	2165      	movs	r1, #101	; 0x65
c0d0169c:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0169e:	4631      	mov	r1, r6
c0d016a0:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d016a2:	0a0a      	lsrs	r2, r1, #8
c0d016a4:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d016a6:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d016a8:	2103      	movs	r1, #3
c0d016aa:	f000 fd09 	bl	c0d020c0 <io_seproxyhal_spi_send>
c0d016ae:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d016b0:	4620      	mov	r0, r4
c0d016b2:	f000 fd05 	bl	c0d020c0 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d016b6:	b2b1      	uxth	r1, r6
c0d016b8:	4628      	mov	r0, r5
c0d016ba:	e00b      	b.n	c0d016d4 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d016bc:	480a      	ldr	r0, [pc, #40]	; (c0d016e8 <io_seproxyhal_display_default+0x80>)
c0d016be:	2165      	movs	r1, #101	; 0x65
c0d016c0:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d016c2:	2100      	movs	r1, #0
c0d016c4:	7041      	strb	r1, [r0, #1]
c0d016c6:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d016c8:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d016ca:	2103      	movs	r1, #3
c0d016cc:	f000 fcf8 	bl	c0d020c0 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d016d0:	4620      	mov	r0, r4
c0d016d2:	4629      	mov	r1, r5
c0d016d4:	f000 fcf4 	bl	c0d020c0 <io_seproxyhal_spi_send>
    }
  }
}
c0d016d8:	b001      	add	sp, #4
c0d016da:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d016dc:	4620      	mov	r0, r4
c0d016de:	4629      	mov	r1, r5
c0d016e0:	f7ff ff7a 	bl	c0d015d8 <io_seproxyhal_display_icon>
c0d016e4:	e7f8      	b.n	c0d016d8 <io_seproxyhal_display_default+0x70>
c0d016e6:	46c0      	nop			; (mov r8, r8)
c0d016e8:	20001a18 	.word	0x20001a18

c0d016ec <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d016ec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d016ee:	af03      	add	r7, sp, #12
c0d016f0:	b081      	sub	sp, #4
c0d016f2:	4604      	mov	r4, r0
  if (button_callback) {
c0d016f4:	2c00      	cmp	r4, #0
c0d016f6:	d02e      	beq.n	c0d01756 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d016f8:	4818      	ldr	r0, [pc, #96]	; (c0d0175c <io_seproxyhal_button_push+0x70>)
c0d016fa:	6802      	ldr	r2, [r0, #0]
c0d016fc:	428a      	cmp	r2, r1
c0d016fe:	d103      	bne.n	c0d01708 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01700:	4a17      	ldr	r2, [pc, #92]	; (c0d01760 <io_seproxyhal_button_push+0x74>)
c0d01702:	6813      	ldr	r3, [r2, #0]
c0d01704:	1c5b      	adds	r3, r3, #1
c0d01706:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01708:	6806      	ldr	r6, [r0, #0]
c0d0170a:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d0170c:	4a14      	ldr	r2, [pc, #80]	; (c0d01760 <io_seproxyhal_button_push+0x74>)
c0d0170e:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01710:	2900      	cmp	r1, #0
c0d01712:	d001      	beq.n	c0d01718 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01714:	6006      	str	r6, [r0, #0]
c0d01716:	e005      	b.n	c0d01724 <io_seproxyhal_button_push+0x38>
c0d01718:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d0171a:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d0171c:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d0171e:	2301      	movs	r3, #1
c0d01720:	07db      	lsls	r3, r3, #31
c0d01722:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d01724:	6800      	ldr	r0, [r0, #0]
c0d01726:	4288      	cmp	r0, r1
c0d01728:	d001      	beq.n	c0d0172e <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d0172a:	2000      	movs	r0, #0
c0d0172c:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d0172e:	2d08      	cmp	r5, #8
c0d01730:	d30e      	bcc.n	c0d01750 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01732:	2103      	movs	r1, #3
c0d01734:	4628      	mov	r0, r5
c0d01736:	f001 fda7 	bl	c0d03288 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d0173a:	2001      	movs	r0, #1
c0d0173c:	0780      	lsls	r0, r0, #30
c0d0173e:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01740:	2900      	cmp	r1, #0
c0d01742:	4601      	mov	r1, r0
c0d01744:	d000      	beq.n	c0d01748 <io_seproxyhal_button_push+0x5c>
c0d01746:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01748:	2900      	cmp	r1, #0
c0d0174a:	db02      	blt.n	c0d01752 <io_seproxyhal_button_push+0x66>
c0d0174c:	4608      	mov	r0, r1
c0d0174e:	e000      	b.n	c0d01752 <io_seproxyhal_button_push+0x66>
c0d01750:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01752:	4629      	mov	r1, r5
c0d01754:	47a0      	blx	r4
  }
}
c0d01756:	b001      	add	sp, #4
c0d01758:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0175a:	46c0      	nop			; (mov r8, r8)
c0d0175c:	20001d24 	.word	0x20001d24
c0d01760:	20001d28 	.word	0x20001d28

c0d01764 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01764:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01766:	af03      	add	r7, sp, #12
c0d01768:	b081      	sub	sp, #4
c0d0176a:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d0176c:	200f      	movs	r0, #15
c0d0176e:	4204      	tst	r4, r0
c0d01770:	d006      	beq.n	c0d01780 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01772:	4620      	mov	r0, r4
c0d01774:	f7ff f8da 	bl	c0d0092c <io_exchange_al>
c0d01778:	4605      	mov	r5, r0
  }
}
c0d0177a:	b2a8      	uxth	r0, r5
c0d0177c:	b001      	add	sp, #4
c0d0177e:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01780:	2610      	movs	r6, #16
c0d01782:	4026      	ands	r6, r4
c0d01784:	2900      	cmp	r1, #0
c0d01786:	d02a      	beq.n	c0d017de <io_exchange+0x7a>
c0d01788:	2e00      	cmp	r6, #0
c0d0178a:	d128      	bne.n	c0d017de <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d0178c:	483d      	ldr	r0, [pc, #244]	; (c0d01884 <io_exchange+0x120>)
c0d0178e:	7800      	ldrb	r0, [r0, #0]
c0d01790:	2807      	cmp	r0, #7
c0d01792:	d00b      	beq.n	c0d017ac <io_exchange+0x48>
c0d01794:	2800      	cmp	r0, #0
c0d01796:	d004      	beq.n	c0d017a2 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01798:	4620      	mov	r0, r4
c0d0179a:	f7ff f8c7 	bl	c0d0092c <io_exchange_al>
c0d0179e:	2800      	cmp	r0, #0
c0d017a0:	d00a      	beq.n	c0d017b8 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d017a2:	4839      	ldr	r0, [pc, #228]	; (c0d01888 <io_exchange+0x124>)
c0d017a4:	6800      	ldr	r0, [r0, #0]
c0d017a6:	2109      	movs	r1, #9
c0d017a8:	f002 f80a 	bl	c0d037c0 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d017ac:	483d      	ldr	r0, [pc, #244]	; (c0d018a4 <io_exchange+0x140>)
c0d017ae:	4478      	add	r0, pc
c0d017b0:	2200      	movs	r2, #0
c0d017b2:	2320      	movs	r3, #32
c0d017b4:	f7ff fc6a 	bl	c0d0108c <io_usb_hid_exchange>
c0d017b8:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d017ba:	4832      	ldr	r0, [pc, #200]	; (c0d01884 <io_exchange+0x120>)
c0d017bc:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d017be:	4833      	ldr	r0, [pc, #204]	; (c0d0188c <io_exchange+0x128>)
c0d017c0:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d017c2:	4833      	ldr	r0, [pc, #204]	; (c0d01890 <io_exchange+0x12c>)
c0d017c4:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d017c6:	4833      	ldr	r0, [pc, #204]	; (c0d01894 <io_exchange+0x130>)
c0d017c8:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d017ca:	4833      	ldr	r0, [pc, #204]	; (c0d01898 <io_exchange+0x134>)
c0d017cc:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d017ce:	06a0      	lsls	r0, r4, #26
c0d017d0:	d4d3      	bmi.n	c0d0177a <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d017d2:	f7ff fcd3 	bl	c0d0117c <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d017d6:	0620      	lsls	r0, r4, #24
c0d017d8:	d501      	bpl.n	c0d017de <io_exchange+0x7a>
        reset();
c0d017da:	f000 faeb 	bl	c0d01db4 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d017de:	2e00      	cmp	r6, #0
c0d017e0:	d10c      	bne.n	c0d017fc <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d017e2:	0660      	lsls	r0, r4, #25
c0d017e4:	d448      	bmi.n	c0d01878 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d017e6:	4827      	ldr	r0, [pc, #156]	; (c0d01884 <io_exchange+0x120>)
c0d017e8:	2100      	movs	r1, #0
c0d017ea:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d017ec:	4827      	ldr	r0, [pc, #156]	; (c0d0188c <io_exchange+0x128>)
c0d017ee:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d017f0:	4827      	ldr	r0, [pc, #156]	; (c0d01890 <io_exchange+0x12c>)
c0d017f2:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d017f4:	4827      	ldr	r0, [pc, #156]	; (c0d01894 <io_exchange+0x130>)
c0d017f6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d017f8:	4827      	ldr	r0, [pc, #156]	; (c0d01898 <io_exchange+0x134>)
c0d017fa:	7001      	strb	r1, [r0, #0]
c0d017fc:	4c28      	ldr	r4, [pc, #160]	; (c0d018a0 <io_exchange+0x13c>)
c0d017fe:	4e24      	ldr	r6, [pc, #144]	; (c0d01890 <io_exchange+0x12c>)
c0d01800:	e008      	b.n	c0d01814 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d01802:	f7ff fd0f 	bl	c0d01224 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01806:	8830      	ldrh	r0, [r6, #0]
c0d01808:	2800      	cmp	r0, #0
c0d0180a:	d003      	beq.n	c0d01814 <io_exchange+0xb0>
c0d0180c:	e032      	b.n	c0d01874 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d0180e:	2002      	movs	r0, #2
c0d01810:	f7ff f8ba 	bl	c0d00988 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01814:	f000 fc72 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d01818:	2800      	cmp	r0, #0
c0d0181a:	d101      	bne.n	c0d01820 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d0181c:	f7ff fcae 	bl	c0d0117c <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01820:	2180      	movs	r1, #128	; 0x80
c0d01822:	2500      	movs	r5, #0
c0d01824:	4620      	mov	r0, r4
c0d01826:	462a      	mov	r2, r5
c0d01828:	f000 fc84 	bl	c0d02134 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d0182c:	1ec1      	subs	r1, r0, #3
c0d0182e:	78a2      	ldrb	r2, [r4, #2]
c0d01830:	7863      	ldrb	r3, [r4, #1]
c0d01832:	021b      	lsls	r3, r3, #8
c0d01834:	4313      	orrs	r3, r2
c0d01836:	4299      	cmp	r1, r3
c0d01838:	d110      	bne.n	c0d0185c <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d0183a:	4917      	ldr	r1, [pc, #92]	; (c0d01898 <io_exchange+0x134>)
c0d0183c:	7809      	ldrb	r1, [r1, #0]
c0d0183e:	2900      	cmp	r1, #0
c0d01840:	d002      	beq.n	c0d01848 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01842:	f7ff fd73 	bl	c0d0132c <io_seproxyhal_handle_event>
c0d01846:	e7e5      	b.n	c0d01814 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01848:	7821      	ldrb	r1, [r4, #0]
c0d0184a:	2910      	cmp	r1, #16
c0d0184c:	d00f      	beq.n	c0d0186e <io_exchange+0x10a>
c0d0184e:	290f      	cmp	r1, #15
c0d01850:	d1dd      	bne.n	c0d0180e <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01852:	2804      	cmp	r0, #4
c0d01854:	d102      	bne.n	c0d0185c <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01856:	f7ff fca7 	bl	c0d011a8 <io_seproxyhal_handle_usb_event>
c0d0185a:	e7db      	b.n	c0d01814 <io_exchange+0xb0>
c0d0185c:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d0185e:	4909      	ldr	r1, [pc, #36]	; (c0d01884 <io_exchange+0x120>)
c0d01860:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01862:	490a      	ldr	r1, [pc, #40]	; (c0d0188c <io_exchange+0x128>)
c0d01864:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01866:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01868:	490a      	ldr	r1, [pc, #40]	; (c0d01894 <io_exchange+0x130>)
c0d0186a:	8008      	strh	r0, [r1, #0]
c0d0186c:	e7d2      	b.n	c0d01814 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d0186e:	2806      	cmp	r0, #6
c0d01870:	d2c7      	bcs.n	c0d01802 <io_exchange+0x9e>
c0d01872:	e782      	b.n	c0d0177a <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01874:	8835      	ldrh	r5, [r6, #0]
c0d01876:	e780      	b.n	c0d0177a <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01878:	4805      	ldr	r0, [pc, #20]	; (c0d01890 <io_exchange+0x12c>)
c0d0187a:	8800      	ldrh	r0, [r0, #0]
c0d0187c:	4907      	ldr	r1, [pc, #28]	; (c0d0189c <io_exchange+0x138>)
c0d0187e:	1845      	adds	r5, r0, r1
c0d01880:	e77b      	b.n	c0d0177a <io_exchange+0x16>
c0d01882:	46c0      	nop			; (mov r8, r8)
c0d01884:	20001d18 	.word	0x20001d18
c0d01888:	20001bb8 	.word	0x20001bb8
c0d0188c:	20001d1a 	.word	0x20001d1a
c0d01890:	20001d1c 	.word	0x20001d1c
c0d01894:	20001d1e 	.word	0x20001d1e
c0d01898:	20001d10 	.word	0x20001d10
c0d0189c:	0000fffb 	.word	0x0000fffb
c0d018a0:	20001a18 	.word	0x20001a18
c0d018a4:	fffffbbb 	.word	0xfffffbbb

c0d018a8 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d018a8:	b081      	sub	sp, #4
c0d018aa:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d018ac:	af03      	add	r7, sp, #12
c0d018ae:	b094      	sub	sp, #80	; 0x50
c0d018b0:	4616      	mov	r6, r2
c0d018b2:	460d      	mov	r5, r1
c0d018b4:	900e      	str	r0, [sp, #56]	; 0x38
c0d018b6:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d018b8:	2d02      	cmp	r5, #2
c0d018ba:	d200      	bcs.n	c0d018be <snprintf+0x16>
c0d018bc:	e22a      	b.n	c0d01d14 <snprintf+0x46c>
c0d018be:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d018c0:	2800      	cmp	r0, #0
c0d018c2:	d100      	bne.n	c0d018c6 <snprintf+0x1e>
c0d018c4:	e226      	b.n	c0d01d14 <snprintf+0x46c>
c0d018c6:	2e00      	cmp	r6, #0
c0d018c8:	d100      	bne.n	c0d018cc <snprintf+0x24>
c0d018ca:	e223      	b.n	c0d01d14 <snprintf+0x46c>
c0d018cc:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d018ce:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d018d0:	9109      	str	r1, [sp, #36]	; 0x24
c0d018d2:	462a      	mov	r2, r5
c0d018d4:	f7ff fbae 	bl	c0d01034 <os_memset>
c0d018d8:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d018da:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d018dc:	7830      	ldrb	r0, [r6, #0]
c0d018de:	2800      	cmp	r0, #0
c0d018e0:	d100      	bne.n	c0d018e4 <snprintf+0x3c>
c0d018e2:	e217      	b.n	c0d01d14 <snprintf+0x46c>
c0d018e4:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d018e6:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d018e8:	1e6b      	subs	r3, r5, #1
c0d018ea:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d018ec:	460a      	mov	r2, r1
c0d018ee:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d018f0:	e003      	b.n	c0d018fa <snprintf+0x52>
c0d018f2:	1970      	adds	r0, r6, r5
c0d018f4:	7840      	ldrb	r0, [r0, #1]
c0d018f6:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d018f8:	1c6d      	adds	r5, r5, #1
c0d018fa:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d018fc:	2800      	cmp	r0, #0
c0d018fe:	d001      	beq.n	c0d01904 <snprintf+0x5c>
c0d01900:	2825      	cmp	r0, #37	; 0x25
c0d01902:	d1f6      	bne.n	c0d018f2 <snprintf+0x4a>
c0d01904:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01906:	429d      	cmp	r5, r3
c0d01908:	d300      	bcc.n	c0d0190c <snprintf+0x64>
c0d0190a:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d0190c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0190e:	4631      	mov	r1, r6
c0d01910:	462a      	mov	r2, r5
c0d01912:	461c      	mov	r4, r3
c0d01914:	f7ff fb98 	bl	c0d01048 <os_memmove>
c0d01918:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d0191a:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d0191c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0191e:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01920:	2b00      	cmp	r3, #0
c0d01922:	d100      	bne.n	c0d01926 <snprintf+0x7e>
c0d01924:	e1f6      	b.n	c0d01d14 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01926:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01928:	5d71      	ldrb	r1, [r6, r5]
c0d0192a:	2925      	cmp	r1, #37	; 0x25
c0d0192c:	d000      	beq.n	c0d01930 <snprintf+0x88>
c0d0192e:	e0ab      	b.n	c0d01a88 <snprintf+0x1e0>
c0d01930:	9304      	str	r3, [sp, #16]
c0d01932:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01934:	1c40      	adds	r0, r0, #1
c0d01936:	2100      	movs	r1, #0
c0d01938:	2220      	movs	r2, #32
c0d0193a:	920a      	str	r2, [sp, #40]	; 0x28
c0d0193c:	220a      	movs	r2, #10
c0d0193e:	9203      	str	r2, [sp, #12]
c0d01940:	9102      	str	r1, [sp, #8]
c0d01942:	9106      	str	r1, [sp, #24]
c0d01944:	910d      	str	r1, [sp, #52]	; 0x34
c0d01946:	460b      	mov	r3, r1
c0d01948:	2102      	movs	r1, #2
c0d0194a:	910c      	str	r1, [sp, #48]	; 0x30
c0d0194c:	4606      	mov	r6, r0
c0d0194e:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01950:	7831      	ldrb	r1, [r6, #0]
c0d01952:	1c76      	adds	r6, r6, #1
c0d01954:	2300      	movs	r3, #0
c0d01956:	2962      	cmp	r1, #98	; 0x62
c0d01958:	dc41      	bgt.n	c0d019de <snprintf+0x136>
c0d0195a:	4608      	mov	r0, r1
c0d0195c:	3825      	subs	r0, #37	; 0x25
c0d0195e:	2823      	cmp	r0, #35	; 0x23
c0d01960:	d900      	bls.n	c0d01964 <snprintf+0xbc>
c0d01962:	e094      	b.n	c0d01a8e <snprintf+0x1e6>
c0d01964:	0040      	lsls	r0, r0, #1
c0d01966:	46c0      	nop			; (mov r8, r8)
c0d01968:	4478      	add	r0, pc
c0d0196a:	8880      	ldrh	r0, [r0, #4]
c0d0196c:	0040      	lsls	r0, r0, #1
c0d0196e:	4487      	add	pc, r0
c0d01970:	0186012d 	.word	0x0186012d
c0d01974:	01860186 	.word	0x01860186
c0d01978:	00510186 	.word	0x00510186
c0d0197c:	01860186 	.word	0x01860186
c0d01980:	00580023 	.word	0x00580023
c0d01984:	00240186 	.word	0x00240186
c0d01988:	00240024 	.word	0x00240024
c0d0198c:	00240024 	.word	0x00240024
c0d01990:	00240024 	.word	0x00240024
c0d01994:	00240024 	.word	0x00240024
c0d01998:	01860024 	.word	0x01860024
c0d0199c:	01860186 	.word	0x01860186
c0d019a0:	01860186 	.word	0x01860186
c0d019a4:	01860186 	.word	0x01860186
c0d019a8:	01860186 	.word	0x01860186
c0d019ac:	01860186 	.word	0x01860186
c0d019b0:	01860186 	.word	0x01860186
c0d019b4:	006c0186 	.word	0x006c0186
c0d019b8:	e7c9      	b.n	c0d0194e <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d019ba:	2930      	cmp	r1, #48	; 0x30
c0d019bc:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d019be:	4603      	mov	r3, r0
c0d019c0:	d100      	bne.n	c0d019c4 <snprintf+0x11c>
c0d019c2:	460b      	mov	r3, r1
c0d019c4:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d019c6:	2c00      	cmp	r4, #0
c0d019c8:	d000      	beq.n	c0d019cc <snprintf+0x124>
c0d019ca:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d019cc:	200a      	movs	r0, #10
c0d019ce:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d019d0:	1840      	adds	r0, r0, r1
c0d019d2:	3830      	subs	r0, #48	; 0x30
c0d019d4:	900d      	str	r0, [sp, #52]	; 0x34
c0d019d6:	4630      	mov	r0, r6
c0d019d8:	930a      	str	r3, [sp, #40]	; 0x28
c0d019da:	4613      	mov	r3, r2
c0d019dc:	e7b4      	b.n	c0d01948 <snprintf+0xa0>
c0d019de:	296f      	cmp	r1, #111	; 0x6f
c0d019e0:	dd11      	ble.n	c0d01a06 <snprintf+0x15e>
c0d019e2:	3970      	subs	r1, #112	; 0x70
c0d019e4:	2908      	cmp	r1, #8
c0d019e6:	d900      	bls.n	c0d019ea <snprintf+0x142>
c0d019e8:	e149      	b.n	c0d01c7e <snprintf+0x3d6>
c0d019ea:	0049      	lsls	r1, r1, #1
c0d019ec:	4479      	add	r1, pc
c0d019ee:	8889      	ldrh	r1, [r1, #4]
c0d019f0:	0049      	lsls	r1, r1, #1
c0d019f2:	448f      	add	pc, r1
c0d019f4:	01440051 	.word	0x01440051
c0d019f8:	002e0144 	.word	0x002e0144
c0d019fc:	00590144 	.word	0x00590144
c0d01a00:	01440144 	.word	0x01440144
c0d01a04:	0051      	.short	0x0051
c0d01a06:	2963      	cmp	r1, #99	; 0x63
c0d01a08:	d054      	beq.n	c0d01ab4 <snprintf+0x20c>
c0d01a0a:	2964      	cmp	r1, #100	; 0x64
c0d01a0c:	d057      	beq.n	c0d01abe <snprintf+0x216>
c0d01a0e:	2968      	cmp	r1, #104	; 0x68
c0d01a10:	d01d      	beq.n	c0d01a4e <snprintf+0x1a6>
c0d01a12:	e134      	b.n	c0d01c7e <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01a14:	7830      	ldrb	r0, [r6, #0]
c0d01a16:	2873      	cmp	r0, #115	; 0x73
c0d01a18:	d000      	beq.n	c0d01a1c <snprintf+0x174>
c0d01a1a:	e130      	b.n	c0d01c7e <snprintf+0x3d6>
c0d01a1c:	4630      	mov	r0, r6
c0d01a1e:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01a20:	e00d      	b.n	c0d01a3e <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01a22:	7830      	ldrb	r0, [r6, #0]
c0d01a24:	282a      	cmp	r0, #42	; 0x2a
c0d01a26:	d000      	beq.n	c0d01a2a <snprintf+0x182>
c0d01a28:	e129      	b.n	c0d01c7e <snprintf+0x3d6>
c0d01a2a:	7871      	ldrb	r1, [r6, #1]
c0d01a2c:	1c70      	adds	r0, r6, #1
c0d01a2e:	2301      	movs	r3, #1
c0d01a30:	2948      	cmp	r1, #72	; 0x48
c0d01a32:	d004      	beq.n	c0d01a3e <snprintf+0x196>
c0d01a34:	2968      	cmp	r1, #104	; 0x68
c0d01a36:	d002      	beq.n	c0d01a3e <snprintf+0x196>
c0d01a38:	2973      	cmp	r1, #115	; 0x73
c0d01a3a:	d000      	beq.n	c0d01a3e <snprintf+0x196>
c0d01a3c:	e11f      	b.n	c0d01c7e <snprintf+0x3d6>
c0d01a3e:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01a40:	1d0a      	adds	r2, r1, #4
c0d01a42:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01a44:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01a46:	9102      	str	r1, [sp, #8]
c0d01a48:	e77e      	b.n	c0d01948 <snprintf+0xa0>
c0d01a4a:	2001      	movs	r0, #1
c0d01a4c:	9006      	str	r0, [sp, #24]
c0d01a4e:	2010      	movs	r0, #16
c0d01a50:	9003      	str	r0, [sp, #12]
c0d01a52:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01a54:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01a56:	1d01      	adds	r1, r0, #4
c0d01a58:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01a5a:	2103      	movs	r1, #3
c0d01a5c:	400a      	ands	r2, r1
c0d01a5e:	1c5b      	adds	r3, r3, #1
c0d01a60:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01a62:	2a01      	cmp	r2, #1
c0d01a64:	d100      	bne.n	c0d01a68 <snprintf+0x1c0>
c0d01a66:	e0b8      	b.n	c0d01bda <snprintf+0x332>
c0d01a68:	2a02      	cmp	r2, #2
c0d01a6a:	d100      	bne.n	c0d01a6e <snprintf+0x1c6>
c0d01a6c:	e104      	b.n	c0d01c78 <snprintf+0x3d0>
c0d01a6e:	2a03      	cmp	r2, #3
c0d01a70:	4630      	mov	r0, r6
c0d01a72:	d100      	bne.n	c0d01a76 <snprintf+0x1ce>
c0d01a74:	e768      	b.n	c0d01948 <snprintf+0xa0>
c0d01a76:	9c08      	ldr	r4, [sp, #32]
c0d01a78:	4625      	mov	r5, r4
c0d01a7a:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01a7c:	1948      	adds	r0, r1, r5
c0d01a7e:	7840      	ldrb	r0, [r0, #1]
c0d01a80:	1c6d      	adds	r5, r5, #1
c0d01a82:	2800      	cmp	r0, #0
c0d01a84:	d1fa      	bne.n	c0d01a7c <snprintf+0x1d4>
c0d01a86:	e0ab      	b.n	c0d01be0 <snprintf+0x338>
c0d01a88:	4606      	mov	r6, r0
c0d01a8a:	920e      	str	r2, [sp, #56]	; 0x38
c0d01a8c:	e109      	b.n	c0d01ca2 <snprintf+0x3fa>
c0d01a8e:	2958      	cmp	r1, #88	; 0x58
c0d01a90:	d000      	beq.n	c0d01a94 <snprintf+0x1ec>
c0d01a92:	e0f4      	b.n	c0d01c7e <snprintf+0x3d6>
c0d01a94:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01a96:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01a98:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01a9a:	1d01      	adds	r1, r0, #4
c0d01a9c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01a9e:	6802      	ldr	r2, [r0, #0]
c0d01aa0:	2000      	movs	r0, #0
c0d01aa2:	9005      	str	r0, [sp, #20]
c0d01aa4:	2510      	movs	r5, #16
c0d01aa6:	e014      	b.n	c0d01ad2 <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01aa8:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01aaa:	1d01      	adds	r1, r0, #4
c0d01aac:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01aae:	6802      	ldr	r2, [r0, #0]
c0d01ab0:	2000      	movs	r0, #0
c0d01ab2:	e00c      	b.n	c0d01ace <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01ab4:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01ab6:	1d01      	adds	r1, r0, #4
c0d01ab8:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01aba:	6800      	ldr	r0, [r0, #0]
c0d01abc:	e087      	b.n	c0d01bce <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01abe:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01ac0:	1d01      	adds	r1, r0, #4
c0d01ac2:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01ac4:	6800      	ldr	r0, [r0, #0]
c0d01ac6:	17c1      	asrs	r1, r0, #31
c0d01ac8:	1842      	adds	r2, r0, r1
c0d01aca:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01acc:	0fc0      	lsrs	r0, r0, #31
c0d01ace:	9005      	str	r0, [sp, #20]
c0d01ad0:	250a      	movs	r5, #10
c0d01ad2:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01ad4:	4295      	cmp	r5, r2
c0d01ad6:	920e      	str	r2, [sp, #56]	; 0x38
c0d01ad8:	d814      	bhi.n	c0d01b04 <snprintf+0x25c>
c0d01ada:	2201      	movs	r2, #1
c0d01adc:	4628      	mov	r0, r5
c0d01ade:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01ae0:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01ae2:	4629      	mov	r1, r5
c0d01ae4:	f001 fb4a 	bl	c0d0317c <__aeabi_uidiv>
c0d01ae8:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01aea:	4288      	cmp	r0, r1
c0d01aec:	d109      	bne.n	c0d01b02 <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01aee:	4628      	mov	r0, r5
c0d01af0:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01af2:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01af4:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01af6:	910d      	str	r1, [sp, #52]	; 0x34
c0d01af8:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01afa:	4288      	cmp	r0, r1
c0d01afc:	4622      	mov	r2, r4
c0d01afe:	d9ee      	bls.n	c0d01ade <snprintf+0x236>
c0d01b00:	e000      	b.n	c0d01b04 <snprintf+0x25c>
c0d01b02:	460c      	mov	r4, r1
c0d01b04:	950c      	str	r5, [sp, #48]	; 0x30
c0d01b06:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01b08:	2000      	movs	r0, #0
c0d01b0a:	4603      	mov	r3, r0
c0d01b0c:	43c1      	mvns	r1, r0
c0d01b0e:	9c05      	ldr	r4, [sp, #20]
c0d01b10:	2c00      	cmp	r4, #0
c0d01b12:	d100      	bne.n	c0d01b16 <snprintf+0x26e>
c0d01b14:	4621      	mov	r1, r4
c0d01b16:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01b18:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01b1a:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01b1c:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01b1e:	b2ca      	uxtb	r2, r1
c0d01b20:	2a30      	cmp	r2, #48	; 0x30
c0d01b22:	d106      	bne.n	c0d01b32 <snprintf+0x28a>
c0d01b24:	2c00      	cmp	r4, #0
c0d01b26:	d004      	beq.n	c0d01b32 <snprintf+0x28a>
c0d01b28:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01b2a:	232d      	movs	r3, #45	; 0x2d
c0d01b2c:	700b      	strb	r3, [r1, #0]
c0d01b2e:	2400      	movs	r4, #0
c0d01b30:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01b32:	1e81      	subs	r1, r0, #2
c0d01b34:	290d      	cmp	r1, #13
c0d01b36:	d80d      	bhi.n	c0d01b54 <snprintf+0x2ac>
c0d01b38:	1e41      	subs	r1, r0, #1
c0d01b3a:	d00b      	beq.n	c0d01b54 <snprintf+0x2ac>
c0d01b3c:	a810      	add	r0, sp, #64	; 0x40
c0d01b3e:	9405      	str	r4, [sp, #20]
c0d01b40:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01b42:	4320      	orrs	r0, r4
c0d01b44:	f001 fda4 	bl	c0d03690 <__aeabi_memset>
c0d01b48:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01b4a:	1900      	adds	r0, r0, r4
c0d01b4c:	9c05      	ldr	r4, [sp, #20]
c0d01b4e:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01b50:	1840      	adds	r0, r0, r1
c0d01b52:	1e43      	subs	r3, r0, #1
c0d01b54:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01b56:	2c00      	cmp	r4, #0
c0d01b58:	9601      	str	r6, [sp, #4]
c0d01b5a:	d003      	beq.n	c0d01b64 <snprintf+0x2bc>
c0d01b5c:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01b5e:	222d      	movs	r2, #45	; 0x2d
c0d01b60:	54c2      	strb	r2, [r0, r3]
c0d01b62:	1c5b      	adds	r3, r3, #1
c0d01b64:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01b66:	2900      	cmp	r1, #0
c0d01b68:	d003      	beq.n	c0d01b72 <snprintf+0x2ca>
c0d01b6a:	2800      	cmp	r0, #0
c0d01b6c:	d003      	beq.n	c0d01b76 <snprintf+0x2ce>
c0d01b6e:	a06c      	add	r0, pc, #432	; (adr r0, c0d01d20 <g_pcHex_cap>)
c0d01b70:	e002      	b.n	c0d01b78 <snprintf+0x2d0>
c0d01b72:	461c      	mov	r4, r3
c0d01b74:	e016      	b.n	c0d01ba4 <snprintf+0x2fc>
c0d01b76:	a06e      	add	r0, pc, #440	; (adr r0, c0d01d30 <g_pcHex>)
c0d01b78:	900d      	str	r0, [sp, #52]	; 0x34
c0d01b7a:	461c      	mov	r4, r3
c0d01b7c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01b7e:	460e      	mov	r6, r1
c0d01b80:	f001 fafc 	bl	c0d0317c <__aeabi_uidiv>
c0d01b84:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01b86:	4629      	mov	r1, r5
c0d01b88:	f001 fb7e 	bl	c0d03288 <__aeabi_uidivmod>
c0d01b8c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01b8e:	5c40      	ldrb	r0, [r0, r1]
c0d01b90:	a910      	add	r1, sp, #64	; 0x40
c0d01b92:	5508      	strb	r0, [r1, r4]
c0d01b94:	4630      	mov	r0, r6
c0d01b96:	4629      	mov	r1, r5
c0d01b98:	f001 faf0 	bl	c0d0317c <__aeabi_uidiv>
c0d01b9c:	1c64      	adds	r4, r4, #1
c0d01b9e:	42b5      	cmp	r5, r6
c0d01ba0:	4601      	mov	r1, r0
c0d01ba2:	d9eb      	bls.n	c0d01b7c <snprintf+0x2d4>
c0d01ba4:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01ba6:	429c      	cmp	r4, r3
c0d01ba8:	4625      	mov	r5, r4
c0d01baa:	d300      	bcc.n	c0d01bae <snprintf+0x306>
c0d01bac:	461d      	mov	r5, r3
c0d01bae:	a910      	add	r1, sp, #64	; 0x40
c0d01bb0:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01bb2:	4620      	mov	r0, r4
c0d01bb4:	462a      	mov	r2, r5
c0d01bb6:	461e      	mov	r6, r3
c0d01bb8:	f7ff fa46 	bl	c0d01048 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01bbc:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d01bbe:	1961      	adds	r1, r4, r5
c0d01bc0:	910e      	str	r1, [sp, #56]	; 0x38
c0d01bc2:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01bc4:	2800      	cmp	r0, #0
c0d01bc6:	9e01      	ldr	r6, [sp, #4]
c0d01bc8:	d16b      	bne.n	c0d01ca2 <snprintf+0x3fa>
c0d01bca:	e0a3      	b.n	c0d01d14 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01bcc:	2025      	movs	r0, #37	; 0x25
c0d01bce:	9907      	ldr	r1, [sp, #28]
c0d01bd0:	7008      	strb	r0, [r1, #0]
c0d01bd2:	9804      	ldr	r0, [sp, #16]
c0d01bd4:	1e40      	subs	r0, r0, #1
c0d01bd6:	1c49      	adds	r1, r1, #1
c0d01bd8:	e05f      	b.n	c0d01c9a <snprintf+0x3f2>
c0d01bda:	9d02      	ldr	r5, [sp, #8]
c0d01bdc:	9c08      	ldr	r4, [sp, #32]
c0d01bde:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01be0:	9803      	ldr	r0, [sp, #12]
c0d01be2:	2810      	cmp	r0, #16
c0d01be4:	9807      	ldr	r0, [sp, #28]
c0d01be6:	d161      	bne.n	c0d01cac <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01be8:	2d00      	cmp	r5, #0
c0d01bea:	d06a      	beq.n	c0d01cc2 <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01bec:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01bee:	1900      	adds	r0, r0, r4
c0d01bf0:	900e      	str	r0, [sp, #56]	; 0x38
c0d01bf2:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01bf4:	1aa0      	subs	r0, r4, r2
c0d01bf6:	9b05      	ldr	r3, [sp, #20]
c0d01bf8:	4283      	cmp	r3, r0
c0d01bfa:	d800      	bhi.n	c0d01bfe <snprintf+0x356>
c0d01bfc:	4603      	mov	r3, r0
c0d01bfe:	930c      	str	r3, [sp, #48]	; 0x30
c0d01c00:	435c      	muls	r4, r3
c0d01c02:	940a      	str	r4, [sp, #40]	; 0x28
c0d01c04:	1c60      	adds	r0, r4, #1
c0d01c06:	9007      	str	r0, [sp, #28]
c0d01c08:	2000      	movs	r0, #0
c0d01c0a:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01c0c:	9100      	str	r1, [sp, #0]
c0d01c0e:	940e      	str	r4, [sp, #56]	; 0x38
c0d01c10:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01c12:	18e3      	adds	r3, r4, r3
c0d01c14:	900d      	str	r0, [sp, #52]	; 0x34
c0d01c16:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01c18:	200f      	movs	r0, #15
c0d01c1a:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01c1c:	0909      	lsrs	r1, r1, #4
c0d01c1e:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01c20:	18a4      	adds	r4, r4, r2
c0d01c22:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01c24:	2c02      	cmp	r4, #2
c0d01c26:	d375      	bcc.n	c0d01d14 <snprintf+0x46c>
c0d01c28:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01c2a:	2c01      	cmp	r4, #1
c0d01c2c:	d003      	beq.n	c0d01c36 <snprintf+0x38e>
c0d01c2e:	2c00      	cmp	r4, #0
c0d01c30:	d108      	bne.n	c0d01c44 <snprintf+0x39c>
c0d01c32:	a43f      	add	r4, pc, #252	; (adr r4, c0d01d30 <g_pcHex>)
c0d01c34:	e000      	b.n	c0d01c38 <snprintf+0x390>
c0d01c36:	a43a      	add	r4, pc, #232	; (adr r4, c0d01d20 <g_pcHex_cap>)
c0d01c38:	b2c9      	uxtb	r1, r1
c0d01c3a:	5c61      	ldrb	r1, [r4, r1]
c0d01c3c:	7019      	strb	r1, [r3, #0]
c0d01c3e:	b2c0      	uxtb	r0, r0
c0d01c40:	5c20      	ldrb	r0, [r4, r0]
c0d01c42:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01c44:	9807      	ldr	r0, [sp, #28]
c0d01c46:	4290      	cmp	r0, r2
c0d01c48:	d064      	beq.n	c0d01d14 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01c4a:	1e92      	subs	r2, r2, #2
c0d01c4c:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01c4e:	1ca4      	adds	r4, r4, #2
c0d01c50:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01c52:	1c40      	adds	r0, r0, #1
c0d01c54:	42a8      	cmp	r0, r5
c0d01c56:	9900      	ldr	r1, [sp, #0]
c0d01c58:	d3d9      	bcc.n	c0d01c0e <snprintf+0x366>
c0d01c5a:	900d      	str	r0, [sp, #52]	; 0x34
c0d01c5c:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01c5e:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01c60:	1a08      	subs	r0, r1, r0
c0d01c62:	9b05      	ldr	r3, [sp, #20]
c0d01c64:	4283      	cmp	r3, r0
c0d01c66:	d800      	bhi.n	c0d01c6a <snprintf+0x3c2>
c0d01c68:	4603      	mov	r3, r0
c0d01c6a:	4608      	mov	r0, r1
c0d01c6c:	4358      	muls	r0, r3
c0d01c6e:	1820      	adds	r0, r4, r0
c0d01c70:	900e      	str	r0, [sp, #56]	; 0x38
c0d01c72:	1898      	adds	r0, r3, r2
c0d01c74:	1c43      	adds	r3, r0, #1
c0d01c76:	e038      	b.n	c0d01cea <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01c78:	7808      	ldrb	r0, [r1, #0]
c0d01c7a:	2800      	cmp	r0, #0
c0d01c7c:	d023      	beq.n	c0d01cc6 <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d01c7e:	2005      	movs	r0, #5
c0d01c80:	9d04      	ldr	r5, [sp, #16]
c0d01c82:	2d05      	cmp	r5, #5
c0d01c84:	462c      	mov	r4, r5
c0d01c86:	d300      	bcc.n	c0d01c8a <snprintf+0x3e2>
c0d01c88:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01c8a:	9807      	ldr	r0, [sp, #28]
c0d01c8c:	a12c      	add	r1, pc, #176	; (adr r1, c0d01d40 <g_pcHex+0x10>)
c0d01c8e:	4622      	mov	r2, r4
c0d01c90:	f7ff f9da 	bl	c0d01048 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01c94:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01c96:	9907      	ldr	r1, [sp, #28]
c0d01c98:	1909      	adds	r1, r1, r4
c0d01c9a:	910e      	str	r1, [sp, #56]	; 0x38
c0d01c9c:	4603      	mov	r3, r0
c0d01c9e:	2800      	cmp	r0, #0
c0d01ca0:	d038      	beq.n	c0d01d14 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01ca2:	7830      	ldrb	r0, [r6, #0]
c0d01ca4:	2800      	cmp	r0, #0
c0d01ca6:	9908      	ldr	r1, [sp, #32]
c0d01ca8:	d034      	beq.n	c0d01d14 <snprintf+0x46c>
c0d01caa:	e61f      	b.n	c0d018ec <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01cac:	429d      	cmp	r5, r3
c0d01cae:	d300      	bcc.n	c0d01cb2 <snprintf+0x40a>
c0d01cb0:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01cb2:	462a      	mov	r2, r5
c0d01cb4:	461c      	mov	r4, r3
c0d01cb6:	f7ff f9c7 	bl	c0d01048 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01cba:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01cbc:	9907      	ldr	r1, [sp, #28]
c0d01cbe:	1949      	adds	r1, r1, r5
c0d01cc0:	e00f      	b.n	c0d01ce2 <snprintf+0x43a>
c0d01cc2:	900e      	str	r0, [sp, #56]	; 0x38
c0d01cc4:	e7ed      	b.n	c0d01ca2 <snprintf+0x3fa>
c0d01cc6:	9b04      	ldr	r3, [sp, #16]
c0d01cc8:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01cca:	429c      	cmp	r4, r3
c0d01ccc:	d300      	bcc.n	c0d01cd0 <snprintf+0x428>
c0d01cce:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d01cd0:	2120      	movs	r1, #32
c0d01cd2:	9807      	ldr	r0, [sp, #28]
c0d01cd4:	4622      	mov	r2, r4
c0d01cd6:	f7ff f9ad 	bl	c0d01034 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d01cda:	9804      	ldr	r0, [sp, #16]
c0d01cdc:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d01cde:	9907      	ldr	r1, [sp, #28]
c0d01ce0:	1909      	adds	r1, r1, r4
c0d01ce2:	910e      	str	r1, [sp, #56]	; 0x38
c0d01ce4:	4603      	mov	r3, r0
c0d01ce6:	2800      	cmp	r0, #0
c0d01ce8:	d014      	beq.n	c0d01d14 <snprintf+0x46c>
c0d01cea:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01cec:	42a8      	cmp	r0, r5
c0d01cee:	d9d8      	bls.n	c0d01ca2 <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d01cf0:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d01cf2:	429a      	cmp	r2, r3
c0d01cf4:	d300      	bcc.n	c0d01cf8 <snprintf+0x450>
c0d01cf6:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d01cf8:	2120      	movs	r1, #32
c0d01cfa:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01cfc:	4628      	mov	r0, r5
c0d01cfe:	920d      	str	r2, [sp, #52]	; 0x34
c0d01d00:	461c      	mov	r4, r3
c0d01d02:	f7ff f997 	bl	c0d01034 <os_memset>
c0d01d06:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01d08:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01d0a:	182d      	adds	r5, r5, r0
c0d01d0c:	950e      	str	r5, [sp, #56]	; 0x38
c0d01d0e:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d01d10:	2c00      	cmp	r4, #0
c0d01d12:	d1c6      	bne.n	c0d01ca2 <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01d14:	2000      	movs	r0, #0
c0d01d16:	b014      	add	sp, #80	; 0x50
c0d01d18:	bcf0      	pop	{r4, r5, r6, r7}
c0d01d1a:	bc02      	pop	{r1}
c0d01d1c:	b001      	add	sp, #4
c0d01d1e:	4708      	bx	r1

c0d01d20 <g_pcHex_cap>:
c0d01d20:	33323130 	.word	0x33323130
c0d01d24:	37363534 	.word	0x37363534
c0d01d28:	42413938 	.word	0x42413938
c0d01d2c:	46454443 	.word	0x46454443

c0d01d30 <g_pcHex>:
c0d01d30:	33323130 	.word	0x33323130
c0d01d34:	37363534 	.word	0x37363534
c0d01d38:	62613938 	.word	0x62613938
c0d01d3c:	66656463 	.word	0x66656463
c0d01d40:	4f525245 	.word	0x4f525245
c0d01d44:	00000052 	.word	0x00000052

c0d01d48 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01d48:	b580      	push	{r7, lr}
c0d01d4a:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01d4c:	4904      	ldr	r1, [pc, #16]	; (c0d01d60 <pic+0x18>)
c0d01d4e:	4288      	cmp	r0, r1
c0d01d50:	d304      	bcc.n	c0d01d5c <pic+0x14>
c0d01d52:	4904      	ldr	r1, [pc, #16]	; (c0d01d64 <pic+0x1c>)
c0d01d54:	4288      	cmp	r0, r1
c0d01d56:	d201      	bcs.n	c0d01d5c <pic+0x14>
		link_address = pic_internal(link_address);
c0d01d58:	f000 f806 	bl	c0d01d68 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01d5c:	bd80      	pop	{r7, pc}
c0d01d5e:	46c0      	nop			; (mov r8, r8)
c0d01d60:	c0d00000 	.word	0xc0d00000
c0d01d64:	c0d03c80 	.word	0xc0d03c80

c0d01d68 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01d68:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01d6a:	4902      	ldr	r1, [pc, #8]	; (c0d01d74 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01d6c:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01d6e:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01d70:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01d72:	4770      	bx	lr
c0d01d74:	c0d01d69 	.word	0xc0d01d69

c0d01d78 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01d78:	b580      	push	{r7, lr}
c0d01d7a:	af00      	add	r7, sp, #0
c0d01d7c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01d7e:	490a      	ldr	r1, [pc, #40]	; (c0d01da8 <check_api_level+0x30>)
c0d01d80:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d82:	490a      	ldr	r1, [pc, #40]	; (c0d01dac <check_api_level+0x34>)
c0d01d84:	680a      	ldr	r2, [r1, #0]
c0d01d86:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01d88:	9003      	str	r0, [sp, #12]
c0d01d8a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d8c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d8e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d90:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01d92:	4807      	ldr	r0, [pc, #28]	; (c0d01db0 <check_api_level+0x38>)
c0d01d94:	9a01      	ldr	r2, [sp, #4]
c0d01d96:	4282      	cmp	r2, r0
c0d01d98:	d101      	bne.n	c0d01d9e <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01d9a:	b004      	add	sp, #16
c0d01d9c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d9e:	6808      	ldr	r0, [r1, #0]
c0d01da0:	2104      	movs	r1, #4
c0d01da2:	f001 fd0d 	bl	c0d037c0 <longjmp>
c0d01da6:	46c0      	nop			; (mov r8, r8)
c0d01da8:	60000137 	.word	0x60000137
c0d01dac:	20001bb8 	.word	0x20001bb8
c0d01db0:	900001c6 	.word	0x900001c6

c0d01db4 <reset>:
  }
}

void reset ( void ) 
{
c0d01db4:	b580      	push	{r7, lr}
c0d01db6:	af00      	add	r7, sp, #0
c0d01db8:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d01dba:	4809      	ldr	r0, [pc, #36]	; (c0d01de0 <reset+0x2c>)
c0d01dbc:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01dbe:	4809      	ldr	r0, [pc, #36]	; (c0d01de4 <reset+0x30>)
c0d01dc0:	6801      	ldr	r1, [r0, #0]
c0d01dc2:	9101      	str	r1, [sp, #4]
c0d01dc4:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01dc6:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01dc8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01dca:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01dcc:	4906      	ldr	r1, [pc, #24]	; (c0d01de8 <reset+0x34>)
c0d01dce:	9a00      	ldr	r2, [sp, #0]
c0d01dd0:	428a      	cmp	r2, r1
c0d01dd2:	d101      	bne.n	c0d01dd8 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01dd4:	b002      	add	sp, #8
c0d01dd6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01dd8:	6800      	ldr	r0, [r0, #0]
c0d01dda:	2104      	movs	r1, #4
c0d01ddc:	f001 fcf0 	bl	c0d037c0 <longjmp>
c0d01de0:	60000200 	.word	0x60000200
c0d01de4:	20001bb8 	.word	0x20001bb8
c0d01de8:	900002f1 	.word	0x900002f1

c0d01dec <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01dec:	b5d0      	push	{r4, r6, r7, lr}
c0d01dee:	af02      	add	r7, sp, #8
c0d01df0:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d01df2:	4b0a      	ldr	r3, [pc, #40]	; (c0d01e1c <nvm_write+0x30>)
c0d01df4:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01df6:	4b0a      	ldr	r3, [pc, #40]	; (c0d01e20 <nvm_write+0x34>)
c0d01df8:	681c      	ldr	r4, [r3, #0]
c0d01dfa:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d01dfc:	ac03      	add	r4, sp, #12
c0d01dfe:	c407      	stmia	r4!, {r0, r1, r2}
c0d01e00:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e02:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e04:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e06:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01e08:	4806      	ldr	r0, [pc, #24]	; (c0d01e24 <nvm_write+0x38>)
c0d01e0a:	9901      	ldr	r1, [sp, #4]
c0d01e0c:	4281      	cmp	r1, r0
c0d01e0e:	d101      	bne.n	c0d01e14 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01e10:	b006      	add	sp, #24
c0d01e12:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e14:	6818      	ldr	r0, [r3, #0]
c0d01e16:	2104      	movs	r1, #4
c0d01e18:	f001 fcd2 	bl	c0d037c0 <longjmp>
c0d01e1c:	6000037f 	.word	0x6000037f
c0d01e20:	20001bb8 	.word	0x20001bb8
c0d01e24:	900003bc 	.word	0x900003bc

c0d01e28 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01e28:	b580      	push	{r7, lr}
c0d01e2a:	af00      	add	r7, sp, #0
c0d01e2c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d01e2e:	4a0a      	ldr	r2, [pc, #40]	; (c0d01e58 <cx_rng+0x30>)
c0d01e30:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e32:	4a0a      	ldr	r2, [pc, #40]	; (c0d01e5c <cx_rng+0x34>)
c0d01e34:	6813      	ldr	r3, [r2, #0]
c0d01e36:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01e38:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d01e3a:	9103      	str	r1, [sp, #12]
c0d01e3c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e3e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e40:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e42:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d01e44:	4906      	ldr	r1, [pc, #24]	; (c0d01e60 <cx_rng+0x38>)
c0d01e46:	9b00      	ldr	r3, [sp, #0]
c0d01e48:	428b      	cmp	r3, r1
c0d01e4a:	d101      	bne.n	c0d01e50 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d01e4c:	b004      	add	sp, #16
c0d01e4e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e50:	6810      	ldr	r0, [r2, #0]
c0d01e52:	2104      	movs	r1, #4
c0d01e54:	f001 fcb4 	bl	c0d037c0 <longjmp>
c0d01e58:	6000052c 	.word	0x6000052c
c0d01e5c:	20001bb8 	.word	0x20001bb8
c0d01e60:	90000567 	.word	0x90000567

c0d01e64 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d01e64:	b580      	push	{r7, lr}
c0d01e66:	af00      	add	r7, sp, #0
c0d01e68:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d01e6a:	490a      	ldr	r1, [pc, #40]	; (c0d01e94 <cx_sha256_init+0x30>)
c0d01e6c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e6e:	490a      	ldr	r1, [pc, #40]	; (c0d01e98 <cx_sha256_init+0x34>)
c0d01e70:	680a      	ldr	r2, [r1, #0]
c0d01e72:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01e74:	9003      	str	r0, [sp, #12]
c0d01e76:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e78:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e7a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e7c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01e7e:	4a07      	ldr	r2, [pc, #28]	; (c0d01e9c <cx_sha256_init+0x38>)
c0d01e80:	9b01      	ldr	r3, [sp, #4]
c0d01e82:	4293      	cmp	r3, r2
c0d01e84:	d101      	bne.n	c0d01e8a <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01e86:	b004      	add	sp, #16
c0d01e88:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e8a:	6808      	ldr	r0, [r1, #0]
c0d01e8c:	2104      	movs	r1, #4
c0d01e8e:	f001 fc97 	bl	c0d037c0 <longjmp>
c0d01e92:	46c0      	nop			; (mov r8, r8)
c0d01e94:	600008db 	.word	0x600008db
c0d01e98:	20001bb8 	.word	0x20001bb8
c0d01e9c:	90000864 	.word	0x90000864

c0d01ea0 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d01ea0:	b580      	push	{r7, lr}
c0d01ea2:	af00      	add	r7, sp, #0
c0d01ea4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d01ea6:	4a0a      	ldr	r2, [pc, #40]	; (c0d01ed0 <cx_keccak_init+0x30>)
c0d01ea8:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01eaa:	4a0a      	ldr	r2, [pc, #40]	; (c0d01ed4 <cx_keccak_init+0x34>)
c0d01eac:	6813      	ldr	r3, [r2, #0]
c0d01eae:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d01eb0:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d01eb2:	9103      	str	r1, [sp, #12]
c0d01eb4:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01eb6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01eb8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01eba:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d01ebc:	4906      	ldr	r1, [pc, #24]	; (c0d01ed8 <cx_keccak_init+0x38>)
c0d01ebe:	9b00      	ldr	r3, [sp, #0]
c0d01ec0:	428b      	cmp	r3, r1
c0d01ec2:	d101      	bne.n	c0d01ec8 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01ec4:	b004      	add	sp, #16
c0d01ec6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ec8:	6810      	ldr	r0, [r2, #0]
c0d01eca:	2104      	movs	r1, #4
c0d01ecc:	f001 fc78 	bl	c0d037c0 <longjmp>
c0d01ed0:	60000c3c 	.word	0x60000c3c
c0d01ed4:	20001bb8 	.word	0x20001bb8
c0d01ed8:	90000c39 	.word	0x90000c39

c0d01edc <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01edc:	b5b0      	push	{r4, r5, r7, lr}
c0d01ede:	af02      	add	r7, sp, #8
c0d01ee0:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d01ee2:	4c0b      	ldr	r4, [pc, #44]	; (c0d01f10 <cx_hash+0x34>)
c0d01ee4:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ee6:	4c0b      	ldr	r4, [pc, #44]	; (c0d01f14 <cx_hash+0x38>)
c0d01ee8:	6825      	ldr	r5, [r4, #0]
c0d01eea:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01eec:	ad03      	add	r5, sp, #12
c0d01eee:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01ef0:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d01ef2:	9007      	str	r0, [sp, #28]
c0d01ef4:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ef6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ef8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01efa:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01efc:	4906      	ldr	r1, [pc, #24]	; (c0d01f18 <cx_hash+0x3c>)
c0d01efe:	9a01      	ldr	r2, [sp, #4]
c0d01f00:	428a      	cmp	r2, r1
c0d01f02:	d101      	bne.n	c0d01f08 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01f04:	b008      	add	sp, #32
c0d01f06:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f08:	6820      	ldr	r0, [r4, #0]
c0d01f0a:	2104      	movs	r1, #4
c0d01f0c:	f001 fc58 	bl	c0d037c0 <longjmp>
c0d01f10:	60000ea6 	.word	0x60000ea6
c0d01f14:	20001bb8 	.word	0x20001bb8
c0d01f18:	90000e46 	.word	0x90000e46

c0d01f1c <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d01f1c:	b5b0      	push	{r4, r5, r7, lr}
c0d01f1e:	af02      	add	r7, sp, #8
c0d01f20:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d01f22:	4c0a      	ldr	r4, [pc, #40]	; (c0d01f4c <cx_ecfp_init_public_key+0x30>)
c0d01f24:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f26:	4c0a      	ldr	r4, [pc, #40]	; (c0d01f50 <cx_ecfp_init_public_key+0x34>)
c0d01f28:	6825      	ldr	r5, [r4, #0]
c0d01f2a:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01f2c:	ad02      	add	r5, sp, #8
c0d01f2e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01f30:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f32:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01f34:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f36:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d01f38:	4906      	ldr	r1, [pc, #24]	; (c0d01f54 <cx_ecfp_init_public_key+0x38>)
c0d01f3a:	9a00      	ldr	r2, [sp, #0]
c0d01f3c:	428a      	cmp	r2, r1
c0d01f3e:	d101      	bne.n	c0d01f44 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01f40:	b006      	add	sp, #24
c0d01f42:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f44:	6820      	ldr	r0, [r4, #0]
c0d01f46:	2104      	movs	r1, #4
c0d01f48:	f001 fc3a 	bl	c0d037c0 <longjmp>
c0d01f4c:	60002835 	.word	0x60002835
c0d01f50:	20001bb8 	.word	0x20001bb8
c0d01f54:	900028f0 	.word	0x900028f0

c0d01f58 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d01f58:	b5b0      	push	{r4, r5, r7, lr}
c0d01f5a:	af02      	add	r7, sp, #8
c0d01f5c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d01f5e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01f88 <cx_ecfp_init_private_key+0x30>)
c0d01f60:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f62:	4c0a      	ldr	r4, [pc, #40]	; (c0d01f8c <cx_ecfp_init_private_key+0x34>)
c0d01f64:	6825      	ldr	r5, [r4, #0]
c0d01f66:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01f68:	ad02      	add	r5, sp, #8
c0d01f6a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01f6c:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f6e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01f70:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f72:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d01f74:	4906      	ldr	r1, [pc, #24]	; (c0d01f90 <cx_ecfp_init_private_key+0x38>)
c0d01f76:	9a00      	ldr	r2, [sp, #0]
c0d01f78:	428a      	cmp	r2, r1
c0d01f7a:	d101      	bne.n	c0d01f80 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01f7c:	b006      	add	sp, #24
c0d01f7e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f80:	6820      	ldr	r0, [r4, #0]
c0d01f82:	2104      	movs	r1, #4
c0d01f84:	f001 fc1c 	bl	c0d037c0 <longjmp>
c0d01f88:	600029ed 	.word	0x600029ed
c0d01f8c:	20001bb8 	.word	0x20001bb8
c0d01f90:	900029ae 	.word	0x900029ae

c0d01f94 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01f94:	b5b0      	push	{r4, r5, r7, lr}
c0d01f96:	af02      	add	r7, sp, #8
c0d01f98:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d01f9a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01fc4 <cx_ecfp_generate_pair+0x30>)
c0d01f9c:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f9e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01fc8 <cx_ecfp_generate_pair+0x34>)
c0d01fa0:	6825      	ldr	r5, [r4, #0]
c0d01fa2:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01fa4:	ad02      	add	r5, sp, #8
c0d01fa6:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01fa8:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01faa:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01fac:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01fae:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d01fb0:	4906      	ldr	r1, [pc, #24]	; (c0d01fcc <cx_ecfp_generate_pair+0x38>)
c0d01fb2:	9a00      	ldr	r2, [sp, #0]
c0d01fb4:	428a      	cmp	r2, r1
c0d01fb6:	d101      	bne.n	c0d01fbc <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01fb8:	b006      	add	sp, #24
c0d01fba:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01fbc:	6820      	ldr	r0, [r4, #0]
c0d01fbe:	2104      	movs	r1, #4
c0d01fc0:	f001 fbfe 	bl	c0d037c0 <longjmp>
c0d01fc4:	60002a2e 	.word	0x60002a2e
c0d01fc8:	20001bb8 	.word	0x20001bb8
c0d01fcc:	90002a74 	.word	0x90002a74

c0d01fd0 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d01fd0:	b5b0      	push	{r4, r5, r7, lr}
c0d01fd2:	af02      	add	r7, sp, #8
c0d01fd4:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d01fd6:	4c0b      	ldr	r4, [pc, #44]	; (c0d02004 <os_perso_derive_node_bip32+0x34>)
c0d01fd8:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01fda:	4c0b      	ldr	r4, [pc, #44]	; (c0d02008 <os_perso_derive_node_bip32+0x38>)
c0d01fdc:	6825      	ldr	r5, [r4, #0]
c0d01fde:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d01fe0:	ad03      	add	r5, sp, #12
c0d01fe2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01fe4:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d01fe6:	9007      	str	r0, [sp, #28]
c0d01fe8:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01fea:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01fec:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01fee:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d01ff0:	4806      	ldr	r0, [pc, #24]	; (c0d0200c <os_perso_derive_node_bip32+0x3c>)
c0d01ff2:	9901      	ldr	r1, [sp, #4]
c0d01ff4:	4281      	cmp	r1, r0
c0d01ff6:	d101      	bne.n	c0d01ffc <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01ff8:	b008      	add	sp, #32
c0d01ffa:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ffc:	6820      	ldr	r0, [r4, #0]
c0d01ffe:	2104      	movs	r1, #4
c0d02000:	f001 fbde 	bl	c0d037c0 <longjmp>
c0d02004:	6000512b 	.word	0x6000512b
c0d02008:	20001bb8 	.word	0x20001bb8
c0d0200c:	9000517f 	.word	0x9000517f

c0d02010 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d02010:	b580      	push	{r7, lr}
c0d02012:	af00      	add	r7, sp, #0
c0d02014:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d02016:	490a      	ldr	r1, [pc, #40]	; (c0d02040 <os_sched_exit+0x30>)
c0d02018:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0201a:	490a      	ldr	r1, [pc, #40]	; (c0d02044 <os_sched_exit+0x34>)
c0d0201c:	680a      	ldr	r2, [r1, #0]
c0d0201e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d02020:	9003      	str	r0, [sp, #12]
c0d02022:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02024:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02026:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02028:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d0202a:	4807      	ldr	r0, [pc, #28]	; (c0d02048 <os_sched_exit+0x38>)
c0d0202c:	9a01      	ldr	r2, [sp, #4]
c0d0202e:	4282      	cmp	r2, r0
c0d02030:	d101      	bne.n	c0d02036 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02032:	b004      	add	sp, #16
c0d02034:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02036:	6808      	ldr	r0, [r1, #0]
c0d02038:	2104      	movs	r1, #4
c0d0203a:	f001 fbc1 	bl	c0d037c0 <longjmp>
c0d0203e:	46c0      	nop			; (mov r8, r8)
c0d02040:	60005fe1 	.word	0x60005fe1
c0d02044:	20001bb8 	.word	0x20001bb8
c0d02048:	90005f6f 	.word	0x90005f6f

c0d0204c <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d0204c:	b580      	push	{r7, lr}
c0d0204e:	af00      	add	r7, sp, #0
c0d02050:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d02052:	490a      	ldr	r1, [pc, #40]	; (c0d0207c <os_ux+0x30>)
c0d02054:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02056:	490a      	ldr	r1, [pc, #40]	; (c0d02080 <os_ux+0x34>)
c0d02058:	680a      	ldr	r2, [r1, #0]
c0d0205a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d0205c:	9003      	str	r0, [sp, #12]
c0d0205e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02060:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02062:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02064:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d02066:	4a07      	ldr	r2, [pc, #28]	; (c0d02084 <os_ux+0x38>)
c0d02068:	9b01      	ldr	r3, [sp, #4]
c0d0206a:	4293      	cmp	r3, r2
c0d0206c:	d101      	bne.n	c0d02072 <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0206e:	b004      	add	sp, #16
c0d02070:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02072:	6808      	ldr	r0, [r1, #0]
c0d02074:	2104      	movs	r1, #4
c0d02076:	f001 fba3 	bl	c0d037c0 <longjmp>
c0d0207a:	46c0      	nop			; (mov r8, r8)
c0d0207c:	60006158 	.word	0x60006158
c0d02080:	20001bb8 	.word	0x20001bb8
c0d02084:	9000611f 	.word	0x9000611f

c0d02088 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d02088:	b580      	push	{r7, lr}
c0d0208a:	af00      	add	r7, sp, #0
c0d0208c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d0208e:	4809      	ldr	r0, [pc, #36]	; (c0d020b4 <os_seph_features+0x2c>)
c0d02090:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02092:	4909      	ldr	r1, [pc, #36]	; (c0d020b8 <os_seph_features+0x30>)
c0d02094:	6808      	ldr	r0, [r1, #0]
c0d02096:	9001      	str	r0, [sp, #4]
c0d02098:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0209a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0209c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0209e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d020a0:	4a06      	ldr	r2, [pc, #24]	; (c0d020bc <os_seph_features+0x34>)
c0d020a2:	9b00      	ldr	r3, [sp, #0]
c0d020a4:	4293      	cmp	r3, r2
c0d020a6:	d101      	bne.n	c0d020ac <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d020a8:	b002      	add	sp, #8
c0d020aa:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020ac:	6808      	ldr	r0, [r1, #0]
c0d020ae:	2104      	movs	r1, #4
c0d020b0:	f001 fb86 	bl	c0d037c0 <longjmp>
c0d020b4:	600064d6 	.word	0x600064d6
c0d020b8:	20001bb8 	.word	0x20001bb8
c0d020bc:	90006444 	.word	0x90006444

c0d020c0 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d020c0:	b580      	push	{r7, lr}
c0d020c2:	af00      	add	r7, sp, #0
c0d020c4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d020c6:	4a0a      	ldr	r2, [pc, #40]	; (c0d020f0 <io_seproxyhal_spi_send+0x30>)
c0d020c8:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d020ca:	4a0a      	ldr	r2, [pc, #40]	; (c0d020f4 <io_seproxyhal_spi_send+0x34>)
c0d020cc:	6813      	ldr	r3, [r2, #0]
c0d020ce:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d020d0:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d020d2:	9103      	str	r1, [sp, #12]
c0d020d4:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d020d6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d020d8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d020da:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d020dc:	4806      	ldr	r0, [pc, #24]	; (c0d020f8 <io_seproxyhal_spi_send+0x38>)
c0d020de:	9900      	ldr	r1, [sp, #0]
c0d020e0:	4281      	cmp	r1, r0
c0d020e2:	d101      	bne.n	c0d020e8 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d020e4:	b004      	add	sp, #16
c0d020e6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020e8:	6810      	ldr	r0, [r2, #0]
c0d020ea:	2104      	movs	r1, #4
c0d020ec:	f001 fb68 	bl	c0d037c0 <longjmp>
c0d020f0:	60006a1c 	.word	0x60006a1c
c0d020f4:	20001bb8 	.word	0x20001bb8
c0d020f8:	90006af3 	.word	0x90006af3

c0d020fc <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d020fc:	b580      	push	{r7, lr}
c0d020fe:	af00      	add	r7, sp, #0
c0d02100:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d02102:	4809      	ldr	r0, [pc, #36]	; (c0d02128 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d02104:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02106:	4909      	ldr	r1, [pc, #36]	; (c0d0212c <io_seproxyhal_spi_is_status_sent+0x30>)
c0d02108:	6808      	ldr	r0, [r1, #0]
c0d0210a:	9001      	str	r0, [sp, #4]
c0d0210c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0210e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02110:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02112:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d02114:	4a06      	ldr	r2, [pc, #24]	; (c0d02130 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d02116:	9b00      	ldr	r3, [sp, #0]
c0d02118:	4293      	cmp	r3, r2
c0d0211a:	d101      	bne.n	c0d02120 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0211c:	b002      	add	sp, #8
c0d0211e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02120:	6808      	ldr	r0, [r1, #0]
c0d02122:	2104      	movs	r1, #4
c0d02124:	f001 fb4c 	bl	c0d037c0 <longjmp>
c0d02128:	60006bcf 	.word	0x60006bcf
c0d0212c:	20001bb8 	.word	0x20001bb8
c0d02130:	90006b7f 	.word	0x90006b7f

c0d02134 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d02134:	b5d0      	push	{r4, r6, r7, lr}
c0d02136:	af02      	add	r7, sp, #8
c0d02138:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d0213a:	4b0b      	ldr	r3, [pc, #44]	; (c0d02168 <io_seproxyhal_spi_recv+0x34>)
c0d0213c:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0213e:	4b0b      	ldr	r3, [pc, #44]	; (c0d0216c <io_seproxyhal_spi_recv+0x38>)
c0d02140:	681c      	ldr	r4, [r3, #0]
c0d02142:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d02144:	ac03      	add	r4, sp, #12
c0d02146:	c407      	stmia	r4!, {r0, r1, r2}
c0d02148:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0214a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0214c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0214e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d02150:	4907      	ldr	r1, [pc, #28]	; (c0d02170 <io_seproxyhal_spi_recv+0x3c>)
c0d02152:	9a01      	ldr	r2, [sp, #4]
c0d02154:	428a      	cmp	r2, r1
c0d02156:	d102      	bne.n	c0d0215e <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d02158:	b280      	uxth	r0, r0
c0d0215a:	b006      	add	sp, #24
c0d0215c:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0215e:	6818      	ldr	r0, [r3, #0]
c0d02160:	2104      	movs	r1, #4
c0d02162:	f001 fb2d 	bl	c0d037c0 <longjmp>
c0d02166:	46c0      	nop			; (mov r8, r8)
c0d02168:	60006cd1 	.word	0x60006cd1
c0d0216c:	20001bb8 	.word	0x20001bb8
c0d02170:	90006c2b 	.word	0x90006c2b

c0d02174 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02174:	b5b0      	push	{r4, r5, r7, lr}
c0d02176:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d02178:	492c      	ldr	r1, [pc, #176]	; (c0d0222c <bagl_ui_nanos_screen1_button+0xb8>)
c0d0217a:	4288      	cmp	r0, r1
c0d0217c:	d006      	beq.n	c0d0218c <bagl_ui_nanos_screen1_button+0x18>
c0d0217e:	492c      	ldr	r1, [pc, #176]	; (c0d02230 <bagl_ui_nanos_screen1_button+0xbc>)
c0d02180:	4288      	cmp	r0, r1
c0d02182:	d151      	bne.n	c0d02228 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d02184:	2000      	movs	r0, #0
c0d02186:	f7ff ff43 	bl	c0d02010 <os_sched_exit>
c0d0218a:	e04d      	b.n	c0d02228 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d0218c:	f7fe fbc0 	bl	c0d00910 <nvram_is_init>
c0d02190:	2801      	cmp	r0, #1
c0d02192:	d102      	bne.n	c0d0219a <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d02194:	a029      	add	r0, pc, #164	; (adr r0, c0d0223c <bagl_ui_nanos_screen1_button+0xc8>)
c0d02196:	210d      	movs	r1, #13
c0d02198:	e001      	b.n	c0d0219e <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d0219a:	a026      	add	r0, pc, #152	; (adr r0, c0d02234 <bagl_ui_nanos_screen1_button+0xc0>)
c0d0219c:	2105      	movs	r1, #5
c0d0219e:	2203      	movs	r2, #3
c0d021a0:	f7fe f836 	bl	c0d00210 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d021a4:	4c29      	ldr	r4, [pc, #164]	; (c0d0224c <bagl_ui_nanos_screen1_button+0xd8>)
c0d021a6:	482b      	ldr	r0, [pc, #172]	; (c0d02254 <bagl_ui_nanos_screen1_button+0xe0>)
c0d021a8:	4478      	add	r0, pc
c0d021aa:	6020      	str	r0, [r4, #0]
c0d021ac:	2004      	movs	r0, #4
c0d021ae:	6060      	str	r0, [r4, #4]
c0d021b0:	4829      	ldr	r0, [pc, #164]	; (c0d02258 <bagl_ui_nanos_screen1_button+0xe4>)
c0d021b2:	4478      	add	r0, pc
c0d021b4:	6120      	str	r0, [r4, #16]
c0d021b6:	2500      	movs	r5, #0
c0d021b8:	60e5      	str	r5, [r4, #12]
c0d021ba:	2003      	movs	r0, #3
c0d021bc:	7620      	strb	r0, [r4, #24]
c0d021be:	61e5      	str	r5, [r4, #28]
c0d021c0:	4620      	mov	r0, r4
c0d021c2:	3018      	adds	r0, #24
c0d021c4:	f7ff ff42 	bl	c0d0204c <os_ux>
c0d021c8:	61e0      	str	r0, [r4, #28]
c0d021ca:	f7ff f903 	bl	c0d013d4 <io_seproxyhal_init_ux>
c0d021ce:	60a5      	str	r5, [r4, #8]
c0d021d0:	6820      	ldr	r0, [r4, #0]
c0d021d2:	2800      	cmp	r0, #0
c0d021d4:	d028      	beq.n	c0d02228 <bagl_ui_nanos_screen1_button+0xb4>
c0d021d6:	69e0      	ldr	r0, [r4, #28]
c0d021d8:	491d      	ldr	r1, [pc, #116]	; (c0d02250 <bagl_ui_nanos_screen1_button+0xdc>)
c0d021da:	4288      	cmp	r0, r1
c0d021dc:	d116      	bne.n	c0d0220c <bagl_ui_nanos_screen1_button+0x98>
c0d021de:	e023      	b.n	c0d02228 <bagl_ui_nanos_screen1_button+0xb4>
c0d021e0:	6860      	ldr	r0, [r4, #4]
c0d021e2:	4285      	cmp	r5, r0
c0d021e4:	d220      	bcs.n	c0d02228 <bagl_ui_nanos_screen1_button+0xb4>
c0d021e6:	f7ff ff89 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d021ea:	2800      	cmp	r0, #0
c0d021ec:	d11c      	bne.n	c0d02228 <bagl_ui_nanos_screen1_button+0xb4>
c0d021ee:	68a0      	ldr	r0, [r4, #8]
c0d021f0:	68e1      	ldr	r1, [r4, #12]
c0d021f2:	2538      	movs	r5, #56	; 0x38
c0d021f4:	4368      	muls	r0, r5
c0d021f6:	6822      	ldr	r2, [r4, #0]
c0d021f8:	1810      	adds	r0, r2, r0
c0d021fa:	2900      	cmp	r1, #0
c0d021fc:	d009      	beq.n	c0d02212 <bagl_ui_nanos_screen1_button+0x9e>
c0d021fe:	4788      	blx	r1
c0d02200:	2800      	cmp	r0, #0
c0d02202:	d106      	bne.n	c0d02212 <bagl_ui_nanos_screen1_button+0x9e>
c0d02204:	68a0      	ldr	r0, [r4, #8]
c0d02206:	1c45      	adds	r5, r0, #1
c0d02208:	60a5      	str	r5, [r4, #8]
c0d0220a:	6820      	ldr	r0, [r4, #0]
c0d0220c:	2800      	cmp	r0, #0
c0d0220e:	d1e7      	bne.n	c0d021e0 <bagl_ui_nanos_screen1_button+0x6c>
c0d02210:	e00a      	b.n	c0d02228 <bagl_ui_nanos_screen1_button+0xb4>
c0d02212:	2801      	cmp	r0, #1
c0d02214:	d103      	bne.n	c0d0221e <bagl_ui_nanos_screen1_button+0xaa>
c0d02216:	68a0      	ldr	r0, [r4, #8]
c0d02218:	4345      	muls	r5, r0
c0d0221a:	6820      	ldr	r0, [r4, #0]
c0d0221c:	1940      	adds	r0, r0, r5
c0d0221e:	f7fe fbad 	bl	c0d0097c <io_seproxyhal_display>
c0d02222:	68a0      	ldr	r0, [r4, #8]
c0d02224:	1c40      	adds	r0, r0, #1
c0d02226:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d02228:	2000      	movs	r0, #0
c0d0222a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0222c:	80000002 	.word	0x80000002
c0d02230:	80000001 	.word	0x80000001
c0d02234:	54494e49 	.word	0x54494e49
c0d02238:	00000000 	.word	0x00000000
c0d0223c:	6c697453 	.word	0x6c697453
c0d02240:	6e75206c 	.word	0x6e75206c
c0d02244:	74696e69 	.word	0x74696e69
c0d02248:	00000000 	.word	0x00000000
c0d0224c:	20001a98 	.word	0x20001a98
c0d02250:	b0105044 	.word	0xb0105044
c0d02254:	000017ac 	.word	0x000017ac
c0d02258:	00000153 	.word	0x00000153

c0d0225c <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d0225c:	b5b0      	push	{r4, r5, r7, lr}
c0d0225e:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d02260:	2800      	cmp	r0, #0
c0d02262:	d005      	beq.n	c0d02270 <ui_display_debug+0x14>
c0d02264:	2900      	cmp	r1, #0
c0d02266:	d003      	beq.n	c0d02270 <ui_display_debug+0x14>
c0d02268:	2a00      	cmp	r2, #0
c0d0226a:	d001      	beq.n	c0d02270 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d0226c:	f7fd ffd0 	bl	c0d00210 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02270:	4c21      	ldr	r4, [pc, #132]	; (c0d022f8 <ui_display_debug+0x9c>)
c0d02272:	4823      	ldr	r0, [pc, #140]	; (c0d02300 <ui_display_debug+0xa4>)
c0d02274:	4478      	add	r0, pc
c0d02276:	6020      	str	r0, [r4, #0]
c0d02278:	2004      	movs	r0, #4
c0d0227a:	6060      	str	r0, [r4, #4]
c0d0227c:	4821      	ldr	r0, [pc, #132]	; (c0d02304 <ui_display_debug+0xa8>)
c0d0227e:	4478      	add	r0, pc
c0d02280:	6120      	str	r0, [r4, #16]
c0d02282:	2500      	movs	r5, #0
c0d02284:	60e5      	str	r5, [r4, #12]
c0d02286:	2003      	movs	r0, #3
c0d02288:	7620      	strb	r0, [r4, #24]
c0d0228a:	61e5      	str	r5, [r4, #28]
c0d0228c:	4620      	mov	r0, r4
c0d0228e:	3018      	adds	r0, #24
c0d02290:	f7ff fedc 	bl	c0d0204c <os_ux>
c0d02294:	61e0      	str	r0, [r4, #28]
c0d02296:	f7ff f89d 	bl	c0d013d4 <io_seproxyhal_init_ux>
c0d0229a:	60a5      	str	r5, [r4, #8]
c0d0229c:	6820      	ldr	r0, [r4, #0]
c0d0229e:	2800      	cmp	r0, #0
c0d022a0:	d028      	beq.n	c0d022f4 <ui_display_debug+0x98>
c0d022a2:	69e0      	ldr	r0, [r4, #28]
c0d022a4:	4915      	ldr	r1, [pc, #84]	; (c0d022fc <ui_display_debug+0xa0>)
c0d022a6:	4288      	cmp	r0, r1
c0d022a8:	d116      	bne.n	c0d022d8 <ui_display_debug+0x7c>
c0d022aa:	e023      	b.n	c0d022f4 <ui_display_debug+0x98>
c0d022ac:	6860      	ldr	r0, [r4, #4]
c0d022ae:	4285      	cmp	r5, r0
c0d022b0:	d220      	bcs.n	c0d022f4 <ui_display_debug+0x98>
c0d022b2:	f7ff ff23 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d022b6:	2800      	cmp	r0, #0
c0d022b8:	d11c      	bne.n	c0d022f4 <ui_display_debug+0x98>
c0d022ba:	68a0      	ldr	r0, [r4, #8]
c0d022bc:	68e1      	ldr	r1, [r4, #12]
c0d022be:	2538      	movs	r5, #56	; 0x38
c0d022c0:	4368      	muls	r0, r5
c0d022c2:	6822      	ldr	r2, [r4, #0]
c0d022c4:	1810      	adds	r0, r2, r0
c0d022c6:	2900      	cmp	r1, #0
c0d022c8:	d009      	beq.n	c0d022de <ui_display_debug+0x82>
c0d022ca:	4788      	blx	r1
c0d022cc:	2800      	cmp	r0, #0
c0d022ce:	d106      	bne.n	c0d022de <ui_display_debug+0x82>
c0d022d0:	68a0      	ldr	r0, [r4, #8]
c0d022d2:	1c45      	adds	r5, r0, #1
c0d022d4:	60a5      	str	r5, [r4, #8]
c0d022d6:	6820      	ldr	r0, [r4, #0]
c0d022d8:	2800      	cmp	r0, #0
c0d022da:	d1e7      	bne.n	c0d022ac <ui_display_debug+0x50>
c0d022dc:	e00a      	b.n	c0d022f4 <ui_display_debug+0x98>
c0d022de:	2801      	cmp	r0, #1
c0d022e0:	d103      	bne.n	c0d022ea <ui_display_debug+0x8e>
c0d022e2:	68a0      	ldr	r0, [r4, #8]
c0d022e4:	4345      	muls	r5, r0
c0d022e6:	6820      	ldr	r0, [r4, #0]
c0d022e8:	1940      	adds	r0, r0, r5
c0d022ea:	f7fe fb47 	bl	c0d0097c <io_seproxyhal_display>
c0d022ee:	68a0      	ldr	r0, [r4, #8]
c0d022f0:	1c40      	adds	r0, r0, #1
c0d022f2:	60a0      	str	r0, [r4, #8]
}
c0d022f4:	bdb0      	pop	{r4, r5, r7, pc}
c0d022f6:	46c0      	nop			; (mov r8, r8)
c0d022f8:	20001a98 	.word	0x20001a98
c0d022fc:	b0105044 	.word	0xb0105044
c0d02300:	000016e0 	.word	0x000016e0
c0d02304:	00000087 	.word	0x00000087

c0d02308 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02308:	b580      	push	{r7, lr}
c0d0230a:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d0230c:	4905      	ldr	r1, [pc, #20]	; (c0d02324 <bagl_ui_nanos_screen2_button+0x1c>)
c0d0230e:	4288      	cmp	r0, r1
c0d02310:	d002      	beq.n	c0d02318 <bagl_ui_nanos_screen2_button+0x10>
c0d02312:	4905      	ldr	r1, [pc, #20]	; (c0d02328 <bagl_ui_nanos_screen2_button+0x20>)
c0d02314:	4288      	cmp	r0, r1
c0d02316:	d102      	bne.n	c0d0231e <bagl_ui_nanos_screen2_button+0x16>
c0d02318:	2000      	movs	r0, #0
c0d0231a:	f7ff fe79 	bl	c0d02010 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d0231e:	2000      	movs	r0, #0
c0d02320:	bd80      	pop	{r7, pc}
c0d02322:	46c0      	nop			; (mov r8, r8)
c0d02324:	80000002 	.word	0x80000002
c0d02328:	80000001 	.word	0x80000001

c0d0232c <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d0232c:	b5b0      	push	{r4, r5, r7, lr}
c0d0232e:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d02330:	2001      	movs	r0, #1
c0d02332:	0204      	lsls	r4, r0, #8
c0d02334:	f7ff fea8 	bl	c0d02088 <os_seph_features>
c0d02338:	4220      	tst	r0, r4
c0d0233a:	d136      	bne.n	c0d023aa <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d0233c:	4c3c      	ldr	r4, [pc, #240]	; (c0d02430 <ui_idle+0x104>)
c0d0233e:	4840      	ldr	r0, [pc, #256]	; (c0d02440 <ui_idle+0x114>)
c0d02340:	4478      	add	r0, pc
c0d02342:	6020      	str	r0, [r4, #0]
c0d02344:	2004      	movs	r0, #4
c0d02346:	6060      	str	r0, [r4, #4]
c0d02348:	483e      	ldr	r0, [pc, #248]	; (c0d02444 <ui_idle+0x118>)
c0d0234a:	4478      	add	r0, pc
c0d0234c:	6120      	str	r0, [r4, #16]
c0d0234e:	2500      	movs	r5, #0
c0d02350:	60e5      	str	r5, [r4, #12]
c0d02352:	2003      	movs	r0, #3
c0d02354:	7620      	strb	r0, [r4, #24]
c0d02356:	61e5      	str	r5, [r4, #28]
c0d02358:	4620      	mov	r0, r4
c0d0235a:	3018      	adds	r0, #24
c0d0235c:	f7ff fe76 	bl	c0d0204c <os_ux>
c0d02360:	61e0      	str	r0, [r4, #28]
c0d02362:	f7ff f837 	bl	c0d013d4 <io_seproxyhal_init_ux>
c0d02366:	60a5      	str	r5, [r4, #8]
c0d02368:	6820      	ldr	r0, [r4, #0]
c0d0236a:	2800      	cmp	r0, #0
c0d0236c:	d05f      	beq.n	c0d0242e <ui_idle+0x102>
c0d0236e:	69e0      	ldr	r0, [r4, #28]
c0d02370:	4930      	ldr	r1, [pc, #192]	; (c0d02434 <ui_idle+0x108>)
c0d02372:	4288      	cmp	r0, r1
c0d02374:	d116      	bne.n	c0d023a4 <ui_idle+0x78>
c0d02376:	e05a      	b.n	c0d0242e <ui_idle+0x102>
c0d02378:	6860      	ldr	r0, [r4, #4]
c0d0237a:	4285      	cmp	r5, r0
c0d0237c:	d257      	bcs.n	c0d0242e <ui_idle+0x102>
c0d0237e:	f7ff febd 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d02382:	2800      	cmp	r0, #0
c0d02384:	d153      	bne.n	c0d0242e <ui_idle+0x102>
c0d02386:	68a0      	ldr	r0, [r4, #8]
c0d02388:	68e1      	ldr	r1, [r4, #12]
c0d0238a:	2538      	movs	r5, #56	; 0x38
c0d0238c:	4368      	muls	r0, r5
c0d0238e:	6822      	ldr	r2, [r4, #0]
c0d02390:	1810      	adds	r0, r2, r0
c0d02392:	2900      	cmp	r1, #0
c0d02394:	d040      	beq.n	c0d02418 <ui_idle+0xec>
c0d02396:	4788      	blx	r1
c0d02398:	2800      	cmp	r0, #0
c0d0239a:	d13d      	bne.n	c0d02418 <ui_idle+0xec>
c0d0239c:	68a0      	ldr	r0, [r4, #8]
c0d0239e:	1c45      	adds	r5, r0, #1
c0d023a0:	60a5      	str	r5, [r4, #8]
c0d023a2:	6820      	ldr	r0, [r4, #0]
c0d023a4:	2800      	cmp	r0, #0
c0d023a6:	d1e7      	bne.n	c0d02378 <ui_idle+0x4c>
c0d023a8:	e041      	b.n	c0d0242e <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d023aa:	4c21      	ldr	r4, [pc, #132]	; (c0d02430 <ui_idle+0x104>)
c0d023ac:	4822      	ldr	r0, [pc, #136]	; (c0d02438 <ui_idle+0x10c>)
c0d023ae:	4478      	add	r0, pc
c0d023b0:	6020      	str	r0, [r4, #0]
c0d023b2:	2004      	movs	r0, #4
c0d023b4:	6060      	str	r0, [r4, #4]
c0d023b6:	4821      	ldr	r0, [pc, #132]	; (c0d0243c <ui_idle+0x110>)
c0d023b8:	4478      	add	r0, pc
c0d023ba:	6120      	str	r0, [r4, #16]
c0d023bc:	2500      	movs	r5, #0
c0d023be:	60e5      	str	r5, [r4, #12]
c0d023c0:	2003      	movs	r0, #3
c0d023c2:	7620      	strb	r0, [r4, #24]
c0d023c4:	61e5      	str	r5, [r4, #28]
c0d023c6:	4620      	mov	r0, r4
c0d023c8:	3018      	adds	r0, #24
c0d023ca:	f7ff fe3f 	bl	c0d0204c <os_ux>
c0d023ce:	61e0      	str	r0, [r4, #28]
c0d023d0:	f7ff f800 	bl	c0d013d4 <io_seproxyhal_init_ux>
c0d023d4:	60a5      	str	r5, [r4, #8]
c0d023d6:	6820      	ldr	r0, [r4, #0]
c0d023d8:	2800      	cmp	r0, #0
c0d023da:	d028      	beq.n	c0d0242e <ui_idle+0x102>
c0d023dc:	69e0      	ldr	r0, [r4, #28]
c0d023de:	4915      	ldr	r1, [pc, #84]	; (c0d02434 <ui_idle+0x108>)
c0d023e0:	4288      	cmp	r0, r1
c0d023e2:	d116      	bne.n	c0d02412 <ui_idle+0xe6>
c0d023e4:	e023      	b.n	c0d0242e <ui_idle+0x102>
c0d023e6:	6860      	ldr	r0, [r4, #4]
c0d023e8:	4285      	cmp	r5, r0
c0d023ea:	d220      	bcs.n	c0d0242e <ui_idle+0x102>
c0d023ec:	f7ff fe86 	bl	c0d020fc <io_seproxyhal_spi_is_status_sent>
c0d023f0:	2800      	cmp	r0, #0
c0d023f2:	d11c      	bne.n	c0d0242e <ui_idle+0x102>
c0d023f4:	68a0      	ldr	r0, [r4, #8]
c0d023f6:	68e1      	ldr	r1, [r4, #12]
c0d023f8:	2538      	movs	r5, #56	; 0x38
c0d023fa:	4368      	muls	r0, r5
c0d023fc:	6822      	ldr	r2, [r4, #0]
c0d023fe:	1810      	adds	r0, r2, r0
c0d02400:	2900      	cmp	r1, #0
c0d02402:	d009      	beq.n	c0d02418 <ui_idle+0xec>
c0d02404:	4788      	blx	r1
c0d02406:	2800      	cmp	r0, #0
c0d02408:	d106      	bne.n	c0d02418 <ui_idle+0xec>
c0d0240a:	68a0      	ldr	r0, [r4, #8]
c0d0240c:	1c45      	adds	r5, r0, #1
c0d0240e:	60a5      	str	r5, [r4, #8]
c0d02410:	6820      	ldr	r0, [r4, #0]
c0d02412:	2800      	cmp	r0, #0
c0d02414:	d1e7      	bne.n	c0d023e6 <ui_idle+0xba>
c0d02416:	e00a      	b.n	c0d0242e <ui_idle+0x102>
c0d02418:	2801      	cmp	r0, #1
c0d0241a:	d103      	bne.n	c0d02424 <ui_idle+0xf8>
c0d0241c:	68a0      	ldr	r0, [r4, #8]
c0d0241e:	4345      	muls	r5, r0
c0d02420:	6820      	ldr	r0, [r4, #0]
c0d02422:	1940      	adds	r0, r0, r5
c0d02424:	f7fe faaa 	bl	c0d0097c <io_seproxyhal_display>
c0d02428:	68a0      	ldr	r0, [r4, #8]
c0d0242a:	1c40      	adds	r0, r0, #1
c0d0242c:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d0242e:	bdb0      	pop	{r4, r5, r7, pc}
c0d02430:	20001a98 	.word	0x20001a98
c0d02434:	b0105044 	.word	0xb0105044
c0d02438:	00001686 	.word	0x00001686
c0d0243c:	0000008d 	.word	0x0000008d
c0d02440:	00001534 	.word	0x00001534
c0d02444:	fffffe27 	.word	0xfffffe27

c0d02448 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d02448:	2000      	movs	r0, #0
c0d0244a:	4770      	bx	lr

c0d0244c <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d0244c:	b5d0      	push	{r4, r6, r7, lr}
c0d0244e:	af02      	add	r7, sp, #8
c0d02450:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d02452:	4620      	mov	r0, r4
c0d02454:	f7ff fddc 	bl	c0d02010 <os_sched_exit>
    return NULL;
c0d02458:	4620      	mov	r0, r4
c0d0245a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0245c <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d0245c:	4902      	ldr	r1, [pc, #8]	; (c0d02468 <USBD_LL_Init+0xc>)
c0d0245e:	2000      	movs	r0, #0
c0d02460:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d02462:	4902      	ldr	r1, [pc, #8]	; (c0d0246c <USBD_LL_Init+0x10>)
c0d02464:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d02466:	4770      	bx	lr
c0d02468:	20001d2c 	.word	0x20001d2c
c0d0246c:	20001d30 	.word	0x20001d30

c0d02470 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02470:	b5d0      	push	{r4, r6, r7, lr}
c0d02472:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02474:	4806      	ldr	r0, [pc, #24]	; (c0d02490 <USBD_LL_DeInit+0x20>)
c0d02476:	214f      	movs	r1, #79	; 0x4f
c0d02478:	7001      	strb	r1, [r0, #0]
c0d0247a:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d0247c:	7044      	strb	r4, [r0, #1]
c0d0247e:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02480:	7081      	strb	r1, [r0, #2]
c0d02482:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02484:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d02486:	2104      	movs	r1, #4
c0d02488:	f7ff fe1a 	bl	c0d020c0 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d0248c:	4620      	mov	r0, r4
c0d0248e:	bdd0      	pop	{r4, r6, r7, pc}
c0d02490:	20001a18 	.word	0x20001a18

c0d02494 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02494:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02496:	af03      	add	r7, sp, #12
c0d02498:	b083      	sub	sp, #12
c0d0249a:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0249c:	264f      	movs	r6, #79	; 0x4f
c0d0249e:	702e      	strb	r6, [r5, #0]
c0d024a0:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d024a2:	706c      	strb	r4, [r5, #1]
c0d024a4:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d024a6:	70a8      	strb	r0, [r5, #2]
c0d024a8:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d024aa:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d024ac:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d024ae:	2105      	movs	r1, #5
c0d024b0:	4628      	mov	r0, r5
c0d024b2:	f7ff fe05 	bl	c0d020c0 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d024b6:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d024b8:	706c      	strb	r4, [r5, #1]
c0d024ba:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d024bc:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d024be:	70e8      	strb	r0, [r5, #3]
c0d024c0:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d024c2:	4628      	mov	r0, r5
c0d024c4:	f7ff fdfc 	bl	c0d020c0 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d024c8:	4620      	mov	r0, r4
c0d024ca:	b003      	add	sp, #12
c0d024cc:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d024ce <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d024ce:	b5d0      	push	{r4, r6, r7, lr}
c0d024d0:	af02      	add	r7, sp, #8
c0d024d2:	b082      	sub	sp, #8
c0d024d4:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d024d6:	214f      	movs	r1, #79	; 0x4f
c0d024d8:	7001      	strb	r1, [r0, #0]
c0d024da:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d024dc:	7044      	strb	r4, [r0, #1]
c0d024de:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d024e0:	7081      	strb	r1, [r0, #2]
c0d024e2:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d024e4:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d024e6:	2104      	movs	r1, #4
c0d024e8:	f7ff fdea 	bl	c0d020c0 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d024ec:	4620      	mov	r0, r4
c0d024ee:	b002      	add	sp, #8
c0d024f0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d024f4 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d024f4:	b5b0      	push	{r4, r5, r7, lr}
c0d024f6:	af02      	add	r7, sp, #8
c0d024f8:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d024fa:	480f      	ldr	r0, [pc, #60]	; (c0d02538 <USBD_LL_OpenEP+0x44>)
c0d024fc:	2400      	movs	r4, #0
c0d024fe:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d02500:	480e      	ldr	r0, [pc, #56]	; (c0d0253c <USBD_LL_OpenEP+0x48>)
c0d02502:	6004      	str	r4, [r0, #0]
c0d02504:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02506:	254f      	movs	r5, #79	; 0x4f
c0d02508:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d0250a:	7044      	strb	r4, [r0, #1]
c0d0250c:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d0250e:	7085      	strb	r5, [r0, #2]
c0d02510:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02512:	70c5      	strb	r5, [r0, #3]
c0d02514:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d02516:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d02518:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d0251a:	2a03      	cmp	r2, #3
c0d0251c:	d802      	bhi.n	c0d02524 <USBD_LL_OpenEP+0x30>
c0d0251e:	00d0      	lsls	r0, r2, #3
c0d02520:	4c07      	ldr	r4, [pc, #28]	; (c0d02540 <USBD_LL_OpenEP+0x4c>)
c0d02522:	40c4      	lsrs	r4, r0
c0d02524:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d02526:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d02528:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d0252a:	2108      	movs	r1, #8
c0d0252c:	f7ff fdc8 	bl	c0d020c0 <io_seproxyhal_spi_send>
c0d02530:	2000      	movs	r0, #0
  return USBD_OK; 
c0d02532:	b002      	add	sp, #8
c0d02534:	bdb0      	pop	{r4, r5, r7, pc}
c0d02536:	46c0      	nop			; (mov r8, r8)
c0d02538:	20001d2c 	.word	0x20001d2c
c0d0253c:	20001d30 	.word	0x20001d30
c0d02540:	02030401 	.word	0x02030401

c0d02544 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02544:	b5d0      	push	{r4, r6, r7, lr}
c0d02546:	af02      	add	r7, sp, #8
c0d02548:	b082      	sub	sp, #8
c0d0254a:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0254c:	224f      	movs	r2, #79	; 0x4f
c0d0254e:	7002      	strb	r2, [r0, #0]
c0d02550:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02552:	7044      	strb	r4, [r0, #1]
c0d02554:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d02556:	7082      	strb	r2, [r0, #2]
c0d02558:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0255a:	70c2      	strb	r2, [r0, #3]
c0d0255c:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d0255e:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02560:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02562:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02564:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02566:	2108      	movs	r1, #8
c0d02568:	f7ff fdaa 	bl	c0d020c0 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0256c:	4620      	mov	r0, r4
c0d0256e:	b002      	add	sp, #8
c0d02570:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02574 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02574:	b5b0      	push	{r4, r5, r7, lr}
c0d02576:	af02      	add	r7, sp, #8
c0d02578:	b082      	sub	sp, #8
c0d0257a:	460d      	mov	r5, r1
c0d0257c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0257e:	2150      	movs	r1, #80	; 0x50
c0d02580:	7001      	strb	r1, [r0, #0]
c0d02582:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02584:	7044      	strb	r4, [r0, #1]
c0d02586:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02588:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0258a:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d0258c:	2140      	movs	r1, #64	; 0x40
c0d0258e:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02590:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02592:	2106      	movs	r1, #6
c0d02594:	f7ff fd94 	bl	c0d020c0 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02598:	2080      	movs	r0, #128	; 0x80
c0d0259a:	4205      	tst	r5, r0
c0d0259c:	d101      	bne.n	c0d025a2 <USBD_LL_StallEP+0x2e>
c0d0259e:	4807      	ldr	r0, [pc, #28]	; (c0d025bc <USBD_LL_StallEP+0x48>)
c0d025a0:	e000      	b.n	c0d025a4 <USBD_LL_StallEP+0x30>
c0d025a2:	4805      	ldr	r0, [pc, #20]	; (c0d025b8 <USBD_LL_StallEP+0x44>)
c0d025a4:	6801      	ldr	r1, [r0, #0]
c0d025a6:	227f      	movs	r2, #127	; 0x7f
c0d025a8:	4015      	ands	r5, r2
c0d025aa:	2201      	movs	r2, #1
c0d025ac:	40aa      	lsls	r2, r5
c0d025ae:	430a      	orrs	r2, r1
c0d025b0:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d025b2:	4620      	mov	r0, r4
c0d025b4:	b002      	add	sp, #8
c0d025b6:	bdb0      	pop	{r4, r5, r7, pc}
c0d025b8:	20001d2c 	.word	0x20001d2c
c0d025bc:	20001d30 	.word	0x20001d30

c0d025c0 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d025c0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d025c2:	af03      	add	r7, sp, #12
c0d025c4:	b083      	sub	sp, #12
c0d025c6:	460d      	mov	r5, r1
c0d025c8:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d025ca:	2150      	movs	r1, #80	; 0x50
c0d025cc:	7001      	strb	r1, [r0, #0]
c0d025ce:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d025d0:	7044      	strb	r4, [r0, #1]
c0d025d2:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d025d4:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d025d6:	70c5      	strb	r5, [r0, #3]
c0d025d8:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d025da:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d025dc:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d025de:	2106      	movs	r1, #6
c0d025e0:	f7ff fd6e 	bl	c0d020c0 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d025e4:	4235      	tst	r5, r6
c0d025e6:	d101      	bne.n	c0d025ec <USBD_LL_ClearStallEP+0x2c>
c0d025e8:	4807      	ldr	r0, [pc, #28]	; (c0d02608 <USBD_LL_ClearStallEP+0x48>)
c0d025ea:	e000      	b.n	c0d025ee <USBD_LL_ClearStallEP+0x2e>
c0d025ec:	4805      	ldr	r0, [pc, #20]	; (c0d02604 <USBD_LL_ClearStallEP+0x44>)
c0d025ee:	6801      	ldr	r1, [r0, #0]
c0d025f0:	227f      	movs	r2, #127	; 0x7f
c0d025f2:	4015      	ands	r5, r2
c0d025f4:	2201      	movs	r2, #1
c0d025f6:	40aa      	lsls	r2, r5
c0d025f8:	4391      	bics	r1, r2
c0d025fa:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d025fc:	4620      	mov	r0, r4
c0d025fe:	b003      	add	sp, #12
c0d02600:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02602:	46c0      	nop			; (mov r8, r8)
c0d02604:	20001d2c 	.word	0x20001d2c
c0d02608:	20001d30 	.word	0x20001d30

c0d0260c <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d0260c:	2080      	movs	r0, #128	; 0x80
c0d0260e:	4201      	tst	r1, r0
c0d02610:	d001      	beq.n	c0d02616 <USBD_LL_IsStallEP+0xa>
c0d02612:	4806      	ldr	r0, [pc, #24]	; (c0d0262c <USBD_LL_IsStallEP+0x20>)
c0d02614:	e000      	b.n	c0d02618 <USBD_LL_IsStallEP+0xc>
c0d02616:	4804      	ldr	r0, [pc, #16]	; (c0d02628 <USBD_LL_IsStallEP+0x1c>)
c0d02618:	6800      	ldr	r0, [r0, #0]
c0d0261a:	227f      	movs	r2, #127	; 0x7f
c0d0261c:	4011      	ands	r1, r2
c0d0261e:	2201      	movs	r2, #1
c0d02620:	408a      	lsls	r2, r1
c0d02622:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d02624:	b2d0      	uxtb	r0, r2
c0d02626:	4770      	bx	lr
c0d02628:	20001d30 	.word	0x20001d30
c0d0262c:	20001d2c 	.word	0x20001d2c

c0d02630 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02630:	b5d0      	push	{r4, r6, r7, lr}
c0d02632:	af02      	add	r7, sp, #8
c0d02634:	b082      	sub	sp, #8
c0d02636:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02638:	224f      	movs	r2, #79	; 0x4f
c0d0263a:	7002      	strb	r2, [r0, #0]
c0d0263c:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0263e:	7044      	strb	r4, [r0, #1]
c0d02640:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d02642:	7082      	strb	r2, [r0, #2]
c0d02644:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02646:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02648:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0264a:	2105      	movs	r1, #5
c0d0264c:	f7ff fd38 	bl	c0d020c0 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02650:	4620      	mov	r0, r4
c0d02652:	b002      	add	sp, #8
c0d02654:	bdd0      	pop	{r4, r6, r7, pc}

c0d02656 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d02656:	b5b0      	push	{r4, r5, r7, lr}
c0d02658:	af02      	add	r7, sp, #8
c0d0265a:	b082      	sub	sp, #8
c0d0265c:	461c      	mov	r4, r3
c0d0265e:	4615      	mov	r5, r2
c0d02660:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02662:	2250      	movs	r2, #80	; 0x50
c0d02664:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d02666:	1ce2      	adds	r2, r4, #3
c0d02668:	0a13      	lsrs	r3, r2, #8
c0d0266a:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d0266c:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d0266e:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02670:	2120      	movs	r1, #32
c0d02672:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02674:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02676:	2106      	movs	r1, #6
c0d02678:	f7ff fd22 	bl	c0d020c0 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d0267c:	4628      	mov	r0, r5
c0d0267e:	4621      	mov	r1, r4
c0d02680:	f7ff fd1e 	bl	c0d020c0 <io_seproxyhal_spi_send>
c0d02684:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02686:	b002      	add	sp, #8
c0d02688:	bdb0      	pop	{r4, r5, r7, pc}

c0d0268a <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d0268a:	b5d0      	push	{r4, r6, r7, lr}
c0d0268c:	af02      	add	r7, sp, #8
c0d0268e:	b082      	sub	sp, #8
c0d02690:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02692:	2350      	movs	r3, #80	; 0x50
c0d02694:	7003      	strb	r3, [r0, #0]
c0d02696:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02698:	7044      	strb	r4, [r0, #1]
c0d0269a:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d0269c:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d0269e:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d026a0:	2130      	movs	r1, #48	; 0x30
c0d026a2:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d026a4:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d026a6:	2106      	movs	r1, #6
c0d026a8:	f7ff fd0a 	bl	c0d020c0 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d026ac:	4620      	mov	r0, r4
c0d026ae:	b002      	add	sp, #8
c0d026b0:	bdd0      	pop	{r4, r6, r7, pc}

c0d026b2 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d026b2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d026b4:	af03      	add	r7, sp, #12
c0d026b6:	b081      	sub	sp, #4
c0d026b8:	4615      	mov	r5, r2
c0d026ba:	460e      	mov	r6, r1
c0d026bc:	4604      	mov	r4, r0
c0d026be:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d026c0:	2c00      	cmp	r4, #0
c0d026c2:	d011      	beq.n	c0d026e8 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d026c4:	2049      	movs	r0, #73	; 0x49
c0d026c6:	0081      	lsls	r1, r0, #2
c0d026c8:	4620      	mov	r0, r4
c0d026ca:	f000 ffd7 	bl	c0d0367c <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d026ce:	2e00      	cmp	r6, #0
c0d026d0:	d002      	beq.n	c0d026d8 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d026d2:	2011      	movs	r0, #17
c0d026d4:	0100      	lsls	r0, r0, #4
c0d026d6:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d026d8:	20fc      	movs	r0, #252	; 0xfc
c0d026da:	2101      	movs	r1, #1
c0d026dc:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d026de:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d026e0:	4620      	mov	r0, r4
c0d026e2:	f7ff febb 	bl	c0d0245c <USBD_LL_Init>
c0d026e6:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d026e8:	b2c0      	uxtb	r0, r0
c0d026ea:	b001      	add	sp, #4
c0d026ec:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d026ee <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d026ee:	b5d0      	push	{r4, r6, r7, lr}
c0d026f0:	af02      	add	r7, sp, #8
c0d026f2:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d026f4:	20fc      	movs	r0, #252	; 0xfc
c0d026f6:	2101      	movs	r1, #1
c0d026f8:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d026fa:	2045      	movs	r0, #69	; 0x45
c0d026fc:	0080      	lsls	r0, r0, #2
c0d026fe:	5820      	ldr	r0, [r4, r0]
c0d02700:	2800      	cmp	r0, #0
c0d02702:	d006      	beq.n	c0d02712 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02704:	6840      	ldr	r0, [r0, #4]
c0d02706:	f7ff fb1f 	bl	c0d01d48 <pic>
c0d0270a:	4602      	mov	r2, r0
c0d0270c:	7921      	ldrb	r1, [r4, #4]
c0d0270e:	4620      	mov	r0, r4
c0d02710:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d02712:	4620      	mov	r0, r4
c0d02714:	f7ff fedb 	bl	c0d024ce <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02718:	4620      	mov	r0, r4
c0d0271a:	f7ff fea9 	bl	c0d02470 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d0271e:	2000      	movs	r0, #0
c0d02720:	bdd0      	pop	{r4, r6, r7, pc}

c0d02722 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d02722:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d02724:	2900      	cmp	r1, #0
c0d02726:	d003      	beq.n	c0d02730 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02728:	2245      	movs	r2, #69	; 0x45
c0d0272a:	0092      	lsls	r2, r2, #2
c0d0272c:	5081      	str	r1, [r0, r2]
c0d0272e:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02730:	b2d0      	uxtb	r0, r2
c0d02732:	4770      	bx	lr

c0d02734 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02734:	b580      	push	{r7, lr}
c0d02736:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02738:	f7ff feac 	bl	c0d02494 <USBD_LL_Start>
  
  return USBD_OK;  
c0d0273c:	2000      	movs	r0, #0
c0d0273e:	bd80      	pop	{r7, pc}

c0d02740 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02740:	b5b0      	push	{r4, r5, r7, lr}
c0d02742:	af02      	add	r7, sp, #8
c0d02744:	460c      	mov	r4, r1
c0d02746:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02748:	2045      	movs	r0, #69	; 0x45
c0d0274a:	0080      	lsls	r0, r0, #2
c0d0274c:	5828      	ldr	r0, [r5, r0]
c0d0274e:	2800      	cmp	r0, #0
c0d02750:	d00c      	beq.n	c0d0276c <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d02752:	6800      	ldr	r0, [r0, #0]
c0d02754:	f7ff faf8 	bl	c0d01d48 <pic>
c0d02758:	4602      	mov	r2, r0
c0d0275a:	4628      	mov	r0, r5
c0d0275c:	4621      	mov	r1, r4
c0d0275e:	4790      	blx	r2
c0d02760:	4601      	mov	r1, r0
c0d02762:	2002      	movs	r0, #2
c0d02764:	2900      	cmp	r1, #0
c0d02766:	d100      	bne.n	c0d0276a <USBD_SetClassConfig+0x2a>
c0d02768:	4608      	mov	r0, r1
c0d0276a:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d0276c:	2002      	movs	r0, #2
c0d0276e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02770 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02770:	b5b0      	push	{r4, r5, r7, lr}
c0d02772:	af02      	add	r7, sp, #8
c0d02774:	460c      	mov	r4, r1
c0d02776:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02778:	2045      	movs	r0, #69	; 0x45
c0d0277a:	0080      	lsls	r0, r0, #2
c0d0277c:	5828      	ldr	r0, [r5, r0]
c0d0277e:	2800      	cmp	r0, #0
c0d02780:	d006      	beq.n	c0d02790 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02782:	6840      	ldr	r0, [r0, #4]
c0d02784:	f7ff fae0 	bl	c0d01d48 <pic>
c0d02788:	4602      	mov	r2, r0
c0d0278a:	4628      	mov	r0, r5
c0d0278c:	4621      	mov	r1, r4
c0d0278e:	4790      	blx	r2
  }
  return USBD_OK;
c0d02790:	2000      	movs	r0, #0
c0d02792:	bdb0      	pop	{r4, r5, r7, pc}

c0d02794 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02794:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02796:	af03      	add	r7, sp, #12
c0d02798:	b081      	sub	sp, #4
c0d0279a:	4604      	mov	r4, r0
c0d0279c:	2021      	movs	r0, #33	; 0x21
c0d0279e:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d027a0:	19a5      	adds	r5, r4, r6
c0d027a2:	4628      	mov	r0, r5
c0d027a4:	f000 fb69 	bl	c0d02e7a <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d027a8:	20f4      	movs	r0, #244	; 0xf4
c0d027aa:	2101      	movs	r1, #1
c0d027ac:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d027ae:	2087      	movs	r0, #135	; 0x87
c0d027b0:	0040      	lsls	r0, r0, #1
c0d027b2:	5a20      	ldrh	r0, [r4, r0]
c0d027b4:	21f8      	movs	r1, #248	; 0xf8
c0d027b6:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d027b8:	5da1      	ldrb	r1, [r4, r6]
c0d027ba:	201f      	movs	r0, #31
c0d027bc:	4008      	ands	r0, r1
c0d027be:	2802      	cmp	r0, #2
c0d027c0:	d008      	beq.n	c0d027d4 <USBD_LL_SetupStage+0x40>
c0d027c2:	2801      	cmp	r0, #1
c0d027c4:	d00b      	beq.n	c0d027de <USBD_LL_SetupStage+0x4a>
c0d027c6:	2800      	cmp	r0, #0
c0d027c8:	d10e      	bne.n	c0d027e8 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d027ca:	4620      	mov	r0, r4
c0d027cc:	4629      	mov	r1, r5
c0d027ce:	f000 f8f1 	bl	c0d029b4 <USBD_StdDevReq>
c0d027d2:	e00e      	b.n	c0d027f2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d027d4:	4620      	mov	r0, r4
c0d027d6:	4629      	mov	r1, r5
c0d027d8:	f000 fad3 	bl	c0d02d82 <USBD_StdEPReq>
c0d027dc:	e009      	b.n	c0d027f2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d027de:	4620      	mov	r0, r4
c0d027e0:	4629      	mov	r1, r5
c0d027e2:	f000 faa6 	bl	c0d02d32 <USBD_StdItfReq>
c0d027e6:	e004      	b.n	c0d027f2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d027e8:	2080      	movs	r0, #128	; 0x80
c0d027ea:	4001      	ands	r1, r0
c0d027ec:	4620      	mov	r0, r4
c0d027ee:	f7ff fec1 	bl	c0d02574 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d027f2:	2000      	movs	r0, #0
c0d027f4:	b001      	add	sp, #4
c0d027f6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d027f8 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d027f8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d027fa:	af03      	add	r7, sp, #12
c0d027fc:	b081      	sub	sp, #4
c0d027fe:	4615      	mov	r5, r2
c0d02800:	460e      	mov	r6, r1
c0d02802:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02804:	2e00      	cmp	r6, #0
c0d02806:	d011      	beq.n	c0d0282c <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02808:	2045      	movs	r0, #69	; 0x45
c0d0280a:	0080      	lsls	r0, r0, #2
c0d0280c:	5820      	ldr	r0, [r4, r0]
c0d0280e:	6980      	ldr	r0, [r0, #24]
c0d02810:	2800      	cmp	r0, #0
c0d02812:	d034      	beq.n	c0d0287e <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02814:	21fc      	movs	r1, #252	; 0xfc
c0d02816:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02818:	2903      	cmp	r1, #3
c0d0281a:	d130      	bne.n	c0d0287e <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d0281c:	f7ff fa94 	bl	c0d01d48 <pic>
c0d02820:	4603      	mov	r3, r0
c0d02822:	4620      	mov	r0, r4
c0d02824:	4631      	mov	r1, r6
c0d02826:	462a      	mov	r2, r5
c0d02828:	4798      	blx	r3
c0d0282a:	e028      	b.n	c0d0287e <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d0282c:	20f4      	movs	r0, #244	; 0xf4
c0d0282e:	5820      	ldr	r0, [r4, r0]
c0d02830:	2803      	cmp	r0, #3
c0d02832:	d124      	bne.n	c0d0287e <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02834:	2090      	movs	r0, #144	; 0x90
c0d02836:	5820      	ldr	r0, [r4, r0]
c0d02838:	218c      	movs	r1, #140	; 0x8c
c0d0283a:	5861      	ldr	r1, [r4, r1]
c0d0283c:	4622      	mov	r2, r4
c0d0283e:	328c      	adds	r2, #140	; 0x8c
c0d02840:	4281      	cmp	r1, r0
c0d02842:	d90a      	bls.n	c0d0285a <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02844:	1a09      	subs	r1, r1, r0
c0d02846:	6011      	str	r1, [r2, #0]
c0d02848:	4281      	cmp	r1, r0
c0d0284a:	d300      	bcc.n	c0d0284e <USBD_LL_DataOutStage+0x56>
c0d0284c:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d0284e:	b28a      	uxth	r2, r1
c0d02850:	4620      	mov	r0, r4
c0d02852:	4629      	mov	r1, r5
c0d02854:	f000 fc70 	bl	c0d03138 <USBD_CtlContinueRx>
c0d02858:	e011      	b.n	c0d0287e <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d0285a:	2045      	movs	r0, #69	; 0x45
c0d0285c:	0080      	lsls	r0, r0, #2
c0d0285e:	5820      	ldr	r0, [r4, r0]
c0d02860:	6900      	ldr	r0, [r0, #16]
c0d02862:	2800      	cmp	r0, #0
c0d02864:	d008      	beq.n	c0d02878 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02866:	21fc      	movs	r1, #252	; 0xfc
c0d02868:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d0286a:	2903      	cmp	r1, #3
c0d0286c:	d104      	bne.n	c0d02878 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d0286e:	f7ff fa6b 	bl	c0d01d48 <pic>
c0d02872:	4601      	mov	r1, r0
c0d02874:	4620      	mov	r0, r4
c0d02876:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02878:	4620      	mov	r0, r4
c0d0287a:	f000 fc65 	bl	c0d03148 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d0287e:	2000      	movs	r0, #0
c0d02880:	b001      	add	sp, #4
c0d02882:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02884 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02884:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02886:	af03      	add	r7, sp, #12
c0d02888:	b081      	sub	sp, #4
c0d0288a:	460d      	mov	r5, r1
c0d0288c:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d0288e:	2d00      	cmp	r5, #0
c0d02890:	d012      	beq.n	c0d028b8 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02892:	2045      	movs	r0, #69	; 0x45
c0d02894:	0080      	lsls	r0, r0, #2
c0d02896:	5820      	ldr	r0, [r4, r0]
c0d02898:	2800      	cmp	r0, #0
c0d0289a:	d054      	beq.n	c0d02946 <USBD_LL_DataInStage+0xc2>
c0d0289c:	6940      	ldr	r0, [r0, #20]
c0d0289e:	2800      	cmp	r0, #0
c0d028a0:	d051      	beq.n	c0d02946 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d028a2:	21fc      	movs	r1, #252	; 0xfc
c0d028a4:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d028a6:	2903      	cmp	r1, #3
c0d028a8:	d14d      	bne.n	c0d02946 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d028aa:	f7ff fa4d 	bl	c0d01d48 <pic>
c0d028ae:	4602      	mov	r2, r0
c0d028b0:	4620      	mov	r0, r4
c0d028b2:	4629      	mov	r1, r5
c0d028b4:	4790      	blx	r2
c0d028b6:	e046      	b.n	c0d02946 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d028b8:	20f4      	movs	r0, #244	; 0xf4
c0d028ba:	5820      	ldr	r0, [r4, r0]
c0d028bc:	2802      	cmp	r0, #2
c0d028be:	d13a      	bne.n	c0d02936 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d028c0:	69e0      	ldr	r0, [r4, #28]
c0d028c2:	6a25      	ldr	r5, [r4, #32]
c0d028c4:	42a8      	cmp	r0, r5
c0d028c6:	d90b      	bls.n	c0d028e0 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d028c8:	1b40      	subs	r0, r0, r5
c0d028ca:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d028cc:	2109      	movs	r1, #9
c0d028ce:	014a      	lsls	r2, r1, #5
c0d028d0:	58a1      	ldr	r1, [r4, r2]
c0d028d2:	1949      	adds	r1, r1, r5
c0d028d4:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d028d6:	b282      	uxth	r2, r0
c0d028d8:	4620      	mov	r0, r4
c0d028da:	f000 fc1e 	bl	c0d0311a <USBD_CtlContinueSendData>
c0d028de:	e02a      	b.n	c0d02936 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d028e0:	69a6      	ldr	r6, [r4, #24]
c0d028e2:	4630      	mov	r0, r6
c0d028e4:	4629      	mov	r1, r5
c0d028e6:	f000 fccf 	bl	c0d03288 <__aeabi_uidivmod>
c0d028ea:	42ae      	cmp	r6, r5
c0d028ec:	d30f      	bcc.n	c0d0290e <USBD_LL_DataInStage+0x8a>
c0d028ee:	2900      	cmp	r1, #0
c0d028f0:	d10d      	bne.n	c0d0290e <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d028f2:	20f8      	movs	r0, #248	; 0xf8
c0d028f4:	5820      	ldr	r0, [r4, r0]
c0d028f6:	4625      	mov	r5, r4
c0d028f8:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d028fa:	4286      	cmp	r6, r0
c0d028fc:	d207      	bcs.n	c0d0290e <USBD_LL_DataInStage+0x8a>
c0d028fe:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02900:	4620      	mov	r0, r4
c0d02902:	4631      	mov	r1, r6
c0d02904:	4632      	mov	r2, r6
c0d02906:	f000 fc08 	bl	c0d0311a <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d0290a:	602e      	str	r6, [r5, #0]
c0d0290c:	e013      	b.n	c0d02936 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d0290e:	2045      	movs	r0, #69	; 0x45
c0d02910:	0080      	lsls	r0, r0, #2
c0d02912:	5820      	ldr	r0, [r4, r0]
c0d02914:	2800      	cmp	r0, #0
c0d02916:	d00b      	beq.n	c0d02930 <USBD_LL_DataInStage+0xac>
c0d02918:	68c0      	ldr	r0, [r0, #12]
c0d0291a:	2800      	cmp	r0, #0
c0d0291c:	d008      	beq.n	c0d02930 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0291e:	21fc      	movs	r1, #252	; 0xfc
c0d02920:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02922:	2903      	cmp	r1, #3
c0d02924:	d104      	bne.n	c0d02930 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02926:	f7ff fa0f 	bl	c0d01d48 <pic>
c0d0292a:	4601      	mov	r1, r0
c0d0292c:	4620      	mov	r0, r4
c0d0292e:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02930:	4620      	mov	r0, r4
c0d02932:	f000 fc16 	bl	c0d03162 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02936:	2001      	movs	r0, #1
c0d02938:	0201      	lsls	r1, r0, #8
c0d0293a:	1860      	adds	r0, r4, r1
c0d0293c:	5c61      	ldrb	r1, [r4, r1]
c0d0293e:	2901      	cmp	r1, #1
c0d02940:	d101      	bne.n	c0d02946 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02942:	2100      	movs	r1, #0
c0d02944:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02946:	2000      	movs	r0, #0
c0d02948:	b001      	add	sp, #4
c0d0294a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0294c <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d0294c:	b5d0      	push	{r4, r6, r7, lr}
c0d0294e:	af02      	add	r7, sp, #8
c0d02950:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02952:	2090      	movs	r0, #144	; 0x90
c0d02954:	2140      	movs	r1, #64	; 0x40
c0d02956:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02958:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d0295a:	20fc      	movs	r0, #252	; 0xfc
c0d0295c:	2101      	movs	r1, #1
c0d0295e:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02960:	2045      	movs	r0, #69	; 0x45
c0d02962:	0080      	lsls	r0, r0, #2
c0d02964:	5820      	ldr	r0, [r4, r0]
c0d02966:	2800      	cmp	r0, #0
c0d02968:	d006      	beq.n	c0d02978 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d0296a:	6840      	ldr	r0, [r0, #4]
c0d0296c:	f7ff f9ec 	bl	c0d01d48 <pic>
c0d02970:	4602      	mov	r2, r0
c0d02972:	7921      	ldrb	r1, [r4, #4]
c0d02974:	4620      	mov	r0, r4
c0d02976:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02978:	2000      	movs	r0, #0
c0d0297a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0297c <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d0297c:	7401      	strb	r1, [r0, #16]
c0d0297e:	2000      	movs	r0, #0
  return USBD_OK;
c0d02980:	4770      	bx	lr

c0d02982 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02982:	2000      	movs	r0, #0
c0d02984:	4770      	bx	lr

c0d02986 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02986:	2000      	movs	r0, #0
c0d02988:	4770      	bx	lr

c0d0298a <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d0298a:	b5d0      	push	{r4, r6, r7, lr}
c0d0298c:	af02      	add	r7, sp, #8
c0d0298e:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02990:	20fc      	movs	r0, #252	; 0xfc
c0d02992:	5c20      	ldrb	r0, [r4, r0]
c0d02994:	2803      	cmp	r0, #3
c0d02996:	d10a      	bne.n	c0d029ae <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02998:	2045      	movs	r0, #69	; 0x45
c0d0299a:	0080      	lsls	r0, r0, #2
c0d0299c:	5820      	ldr	r0, [r4, r0]
c0d0299e:	69c0      	ldr	r0, [r0, #28]
c0d029a0:	2800      	cmp	r0, #0
c0d029a2:	d004      	beq.n	c0d029ae <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d029a4:	f7ff f9d0 	bl	c0d01d48 <pic>
c0d029a8:	4601      	mov	r1, r0
c0d029aa:	4620      	mov	r0, r4
c0d029ac:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d029ae:	2000      	movs	r0, #0
c0d029b0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d029b4 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d029b4:	b5d0      	push	{r4, r6, r7, lr}
c0d029b6:	af02      	add	r7, sp, #8
c0d029b8:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d029ba:	7848      	ldrb	r0, [r1, #1]
c0d029bc:	2809      	cmp	r0, #9
c0d029be:	d810      	bhi.n	c0d029e2 <USBD_StdDevReq+0x2e>
c0d029c0:	4478      	add	r0, pc
c0d029c2:	7900      	ldrb	r0, [r0, #4]
c0d029c4:	0040      	lsls	r0, r0, #1
c0d029c6:	4487      	add	pc, r0
c0d029c8:	150c0804 	.word	0x150c0804
c0d029cc:	0c25190c 	.word	0x0c25190c
c0d029d0:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d029d2:	4620      	mov	r0, r4
c0d029d4:	f000 f938 	bl	c0d02c48 <USBD_GetStatus>
c0d029d8:	e01f      	b.n	c0d02a1a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d029da:	4620      	mov	r0, r4
c0d029dc:	f000 f976 	bl	c0d02ccc <USBD_ClrFeature>
c0d029e0:	e01b      	b.n	c0d02a1a <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d029e2:	2180      	movs	r1, #128	; 0x80
c0d029e4:	4620      	mov	r0, r4
c0d029e6:	f7ff fdc5 	bl	c0d02574 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d029ea:	2100      	movs	r1, #0
c0d029ec:	4620      	mov	r0, r4
c0d029ee:	f7ff fdc1 	bl	c0d02574 <USBD_LL_StallEP>
c0d029f2:	e012      	b.n	c0d02a1a <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d029f4:	4620      	mov	r0, r4
c0d029f6:	f000 f950 	bl	c0d02c9a <USBD_SetFeature>
c0d029fa:	e00e      	b.n	c0d02a1a <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d029fc:	4620      	mov	r0, r4
c0d029fe:	f000 f897 	bl	c0d02b30 <USBD_SetAddress>
c0d02a02:	e00a      	b.n	c0d02a1a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02a04:	4620      	mov	r0, r4
c0d02a06:	f000 f8ff 	bl	c0d02c08 <USBD_GetConfig>
c0d02a0a:	e006      	b.n	c0d02a1a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02a0c:	4620      	mov	r0, r4
c0d02a0e:	f000 f8bd 	bl	c0d02b8c <USBD_SetConfig>
c0d02a12:	e002      	b.n	c0d02a1a <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02a14:	4620      	mov	r0, r4
c0d02a16:	f000 f803 	bl	c0d02a20 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02a1a:	2000      	movs	r0, #0
c0d02a1c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02a20 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02a20:	b5b0      	push	{r4, r5, r7, lr}
c0d02a22:	af02      	add	r7, sp, #8
c0d02a24:	b082      	sub	sp, #8
c0d02a26:	460d      	mov	r5, r1
c0d02a28:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02a2a:	8868      	ldrh	r0, [r5, #2]
c0d02a2c:	0a01      	lsrs	r1, r0, #8
c0d02a2e:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a30:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02a32:	2a0e      	cmp	r2, #14
c0d02a34:	d83e      	bhi.n	c0d02ab4 <USBD_GetDescriptor+0x94>
c0d02a36:	46c0      	nop			; (mov r8, r8)
c0d02a38:	447a      	add	r2, pc
c0d02a3a:	7912      	ldrb	r2, [r2, #4]
c0d02a3c:	0052      	lsls	r2, r2, #1
c0d02a3e:	4497      	add	pc, r2
c0d02a40:	390c2607 	.word	0x390c2607
c0d02a44:	39362e39 	.word	0x39362e39
c0d02a48:	39393939 	.word	0x39393939
c0d02a4c:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02a50:	2011      	movs	r0, #17
c0d02a52:	0100      	lsls	r0, r0, #4
c0d02a54:	5820      	ldr	r0, [r4, r0]
c0d02a56:	6800      	ldr	r0, [r0, #0]
c0d02a58:	e012      	b.n	c0d02a80 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02a5a:	b2c0      	uxtb	r0, r0
c0d02a5c:	2805      	cmp	r0, #5
c0d02a5e:	d829      	bhi.n	c0d02ab4 <USBD_GetDescriptor+0x94>
c0d02a60:	4478      	add	r0, pc
c0d02a62:	7900      	ldrb	r0, [r0, #4]
c0d02a64:	0040      	lsls	r0, r0, #1
c0d02a66:	4487      	add	pc, r0
c0d02a68:	544f4a02 	.word	0x544f4a02
c0d02a6c:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02a6e:	2011      	movs	r0, #17
c0d02a70:	0100      	lsls	r0, r0, #4
c0d02a72:	5820      	ldr	r0, [r4, r0]
c0d02a74:	6840      	ldr	r0, [r0, #4]
c0d02a76:	e003      	b.n	c0d02a80 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02a78:	2011      	movs	r0, #17
c0d02a7a:	0100      	lsls	r0, r0, #4
c0d02a7c:	5820      	ldr	r0, [r4, r0]
c0d02a7e:	69c0      	ldr	r0, [r0, #28]
c0d02a80:	f7ff f962 	bl	c0d01d48 <pic>
c0d02a84:	4602      	mov	r2, r0
c0d02a86:	7c20      	ldrb	r0, [r4, #16]
c0d02a88:	a901      	add	r1, sp, #4
c0d02a8a:	4790      	blx	r2
c0d02a8c:	e025      	b.n	c0d02ada <USBD_GetDescriptor+0xba>
c0d02a8e:	2045      	movs	r0, #69	; 0x45
c0d02a90:	0080      	lsls	r0, r0, #2
c0d02a92:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02a94:	7c21      	ldrb	r1, [r4, #16]
c0d02a96:	2900      	cmp	r1, #0
c0d02a98:	d014      	beq.n	c0d02ac4 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02a9a:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02a9c:	e018      	b.n	c0d02ad0 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02a9e:	7c20      	ldrb	r0, [r4, #16]
c0d02aa0:	2800      	cmp	r0, #0
c0d02aa2:	d107      	bne.n	c0d02ab4 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02aa4:	2045      	movs	r0, #69	; 0x45
c0d02aa6:	0080      	lsls	r0, r0, #2
c0d02aa8:	5820      	ldr	r0, [r4, r0]
c0d02aaa:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02aac:	e010      	b.n	c0d02ad0 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02aae:	7c20      	ldrb	r0, [r4, #16]
c0d02ab0:	2800      	cmp	r0, #0
c0d02ab2:	d009      	beq.n	c0d02ac8 <USBD_GetDescriptor+0xa8>
c0d02ab4:	4620      	mov	r0, r4
c0d02ab6:	f7ff fd5d 	bl	c0d02574 <USBD_LL_StallEP>
c0d02aba:	2100      	movs	r1, #0
c0d02abc:	4620      	mov	r0, r4
c0d02abe:	f7ff fd59 	bl	c0d02574 <USBD_LL_StallEP>
c0d02ac2:	e01a      	b.n	c0d02afa <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02ac4:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02ac6:	e003      	b.n	c0d02ad0 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02ac8:	2045      	movs	r0, #69	; 0x45
c0d02aca:	0080      	lsls	r0, r0, #2
c0d02acc:	5820      	ldr	r0, [r4, r0]
c0d02ace:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02ad0:	f7ff f93a 	bl	c0d01d48 <pic>
c0d02ad4:	4601      	mov	r1, r0
c0d02ad6:	a801      	add	r0, sp, #4
c0d02ad8:	4788      	blx	r1
c0d02ada:	4601      	mov	r1, r0
c0d02adc:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02ade:	8802      	ldrh	r2, [r0, #0]
c0d02ae0:	2a00      	cmp	r2, #0
c0d02ae2:	d00a      	beq.n	c0d02afa <USBD_GetDescriptor+0xda>
c0d02ae4:	88e8      	ldrh	r0, [r5, #6]
c0d02ae6:	2800      	cmp	r0, #0
c0d02ae8:	d007      	beq.n	c0d02afa <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02aea:	4282      	cmp	r2, r0
c0d02aec:	d300      	bcc.n	c0d02af0 <USBD_GetDescriptor+0xd0>
c0d02aee:	4602      	mov	r2, r0
c0d02af0:	a801      	add	r0, sp, #4
c0d02af2:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02af4:	4620      	mov	r0, r4
c0d02af6:	f000 faf9 	bl	c0d030ec <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02afa:	b002      	add	sp, #8
c0d02afc:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02afe:	2011      	movs	r0, #17
c0d02b00:	0100      	lsls	r0, r0, #4
c0d02b02:	5820      	ldr	r0, [r4, r0]
c0d02b04:	6880      	ldr	r0, [r0, #8]
c0d02b06:	e7bb      	b.n	c0d02a80 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02b08:	2011      	movs	r0, #17
c0d02b0a:	0100      	lsls	r0, r0, #4
c0d02b0c:	5820      	ldr	r0, [r4, r0]
c0d02b0e:	68c0      	ldr	r0, [r0, #12]
c0d02b10:	e7b6      	b.n	c0d02a80 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02b12:	2011      	movs	r0, #17
c0d02b14:	0100      	lsls	r0, r0, #4
c0d02b16:	5820      	ldr	r0, [r4, r0]
c0d02b18:	6900      	ldr	r0, [r0, #16]
c0d02b1a:	e7b1      	b.n	c0d02a80 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02b1c:	2011      	movs	r0, #17
c0d02b1e:	0100      	lsls	r0, r0, #4
c0d02b20:	5820      	ldr	r0, [r4, r0]
c0d02b22:	6940      	ldr	r0, [r0, #20]
c0d02b24:	e7ac      	b.n	c0d02a80 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02b26:	2011      	movs	r0, #17
c0d02b28:	0100      	lsls	r0, r0, #4
c0d02b2a:	5820      	ldr	r0, [r4, r0]
c0d02b2c:	6980      	ldr	r0, [r0, #24]
c0d02b2e:	e7a7      	b.n	c0d02a80 <USBD_GetDescriptor+0x60>

c0d02b30 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02b30:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b32:	af03      	add	r7, sp, #12
c0d02b34:	b081      	sub	sp, #4
c0d02b36:	460a      	mov	r2, r1
c0d02b38:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02b3a:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02b3c:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02b3e:	2800      	cmp	r0, #0
c0d02b40:	d10b      	bne.n	c0d02b5a <USBD_SetAddress+0x2a>
c0d02b42:	88d0      	ldrh	r0, [r2, #6]
c0d02b44:	2800      	cmp	r0, #0
c0d02b46:	d108      	bne.n	c0d02b5a <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02b48:	8850      	ldrh	r0, [r2, #2]
c0d02b4a:	267f      	movs	r6, #127	; 0x7f
c0d02b4c:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02b4e:	20fc      	movs	r0, #252	; 0xfc
c0d02b50:	5c20      	ldrb	r0, [r4, r0]
c0d02b52:	4625      	mov	r5, r4
c0d02b54:	35fc      	adds	r5, #252	; 0xfc
c0d02b56:	2803      	cmp	r0, #3
c0d02b58:	d108      	bne.n	c0d02b6c <USBD_SetAddress+0x3c>
c0d02b5a:	4620      	mov	r0, r4
c0d02b5c:	f7ff fd0a 	bl	c0d02574 <USBD_LL_StallEP>
c0d02b60:	2100      	movs	r1, #0
c0d02b62:	4620      	mov	r0, r4
c0d02b64:	f7ff fd06 	bl	c0d02574 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02b68:	b001      	add	sp, #4
c0d02b6a:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02b6c:	20fe      	movs	r0, #254	; 0xfe
c0d02b6e:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02b70:	b2f1      	uxtb	r1, r6
c0d02b72:	4620      	mov	r0, r4
c0d02b74:	f7ff fd5c 	bl	c0d02630 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02b78:	4620      	mov	r0, r4
c0d02b7a:	f000 fae5 	bl	c0d03148 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02b7e:	2002      	movs	r0, #2
c0d02b80:	2101      	movs	r1, #1
c0d02b82:	2e00      	cmp	r6, #0
c0d02b84:	d100      	bne.n	c0d02b88 <USBD_SetAddress+0x58>
c0d02b86:	4608      	mov	r0, r1
c0d02b88:	7028      	strb	r0, [r5, #0]
c0d02b8a:	e7ed      	b.n	c0d02b68 <USBD_SetAddress+0x38>

c0d02b8c <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02b8c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b8e:	af03      	add	r7, sp, #12
c0d02b90:	b081      	sub	sp, #4
c0d02b92:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02b94:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02b96:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02b98:	2e02      	cmp	r6, #2
c0d02b9a:	d21d      	bcs.n	c0d02bd8 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02b9c:	20fc      	movs	r0, #252	; 0xfc
c0d02b9e:	5c21      	ldrb	r1, [r4, r0]
c0d02ba0:	4620      	mov	r0, r4
c0d02ba2:	30fc      	adds	r0, #252	; 0xfc
c0d02ba4:	2903      	cmp	r1, #3
c0d02ba6:	d007      	beq.n	c0d02bb8 <USBD_SetConfig+0x2c>
c0d02ba8:	2902      	cmp	r1, #2
c0d02baa:	d115      	bne.n	c0d02bd8 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02bac:	2e00      	cmp	r6, #0
c0d02bae:	d026      	beq.n	c0d02bfe <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02bb0:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02bb2:	2103      	movs	r1, #3
c0d02bb4:	7001      	strb	r1, [r0, #0]
c0d02bb6:	e009      	b.n	c0d02bcc <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02bb8:	2e00      	cmp	r6, #0
c0d02bba:	d016      	beq.n	c0d02bea <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02bbc:	6860      	ldr	r0, [r4, #4]
c0d02bbe:	4286      	cmp	r6, r0
c0d02bc0:	d01d      	beq.n	c0d02bfe <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02bc2:	b2c1      	uxtb	r1, r0
c0d02bc4:	4620      	mov	r0, r4
c0d02bc6:	f7ff fdd3 	bl	c0d02770 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02bca:	6066      	str	r6, [r4, #4]
c0d02bcc:	4620      	mov	r0, r4
c0d02bce:	4631      	mov	r1, r6
c0d02bd0:	f7ff fdb6 	bl	c0d02740 <USBD_SetClassConfig>
c0d02bd4:	2802      	cmp	r0, #2
c0d02bd6:	d112      	bne.n	c0d02bfe <USBD_SetConfig+0x72>
c0d02bd8:	4620      	mov	r0, r4
c0d02bda:	4629      	mov	r1, r5
c0d02bdc:	f7ff fcca 	bl	c0d02574 <USBD_LL_StallEP>
c0d02be0:	2100      	movs	r1, #0
c0d02be2:	4620      	mov	r0, r4
c0d02be4:	f7ff fcc6 	bl	c0d02574 <USBD_LL_StallEP>
c0d02be8:	e00c      	b.n	c0d02c04 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02bea:	2102      	movs	r1, #2
c0d02bec:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02bee:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02bf0:	4620      	mov	r0, r4
c0d02bf2:	4631      	mov	r1, r6
c0d02bf4:	f7ff fdbc 	bl	c0d02770 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02bf8:	4620      	mov	r0, r4
c0d02bfa:	f000 faa5 	bl	c0d03148 <USBD_CtlSendStatus>
c0d02bfe:	4620      	mov	r0, r4
c0d02c00:	f000 faa2 	bl	c0d03148 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02c04:	b001      	add	sp, #4
c0d02c06:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c08 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02c08:	b5d0      	push	{r4, r6, r7, lr}
c0d02c0a:	af02      	add	r7, sp, #8
c0d02c0c:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02c0e:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02c10:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02c12:	2801      	cmp	r0, #1
c0d02c14:	d10a      	bne.n	c0d02c2c <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02c16:	20fc      	movs	r0, #252	; 0xfc
c0d02c18:	5c20      	ldrb	r0, [r4, r0]
c0d02c1a:	2803      	cmp	r0, #3
c0d02c1c:	d00e      	beq.n	c0d02c3c <USBD_GetConfig+0x34>
c0d02c1e:	2802      	cmp	r0, #2
c0d02c20:	d104      	bne.n	c0d02c2c <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02c22:	2000      	movs	r0, #0
c0d02c24:	60a0      	str	r0, [r4, #8]
c0d02c26:	4621      	mov	r1, r4
c0d02c28:	3108      	adds	r1, #8
c0d02c2a:	e008      	b.n	c0d02c3e <USBD_GetConfig+0x36>
c0d02c2c:	4620      	mov	r0, r4
c0d02c2e:	f7ff fca1 	bl	c0d02574 <USBD_LL_StallEP>
c0d02c32:	2100      	movs	r1, #0
c0d02c34:	4620      	mov	r0, r4
c0d02c36:	f7ff fc9d 	bl	c0d02574 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02c3a:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02c3c:	1d21      	adds	r1, r4, #4
c0d02c3e:	2201      	movs	r2, #1
c0d02c40:	4620      	mov	r0, r4
c0d02c42:	f000 fa53 	bl	c0d030ec <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02c46:	bdd0      	pop	{r4, r6, r7, pc}

c0d02c48 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02c48:	b5b0      	push	{r4, r5, r7, lr}
c0d02c4a:	af02      	add	r7, sp, #8
c0d02c4c:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02c4e:	20fc      	movs	r0, #252	; 0xfc
c0d02c50:	5c20      	ldrb	r0, [r4, r0]
c0d02c52:	21fe      	movs	r1, #254	; 0xfe
c0d02c54:	4001      	ands	r1, r0
c0d02c56:	2902      	cmp	r1, #2
c0d02c58:	d116      	bne.n	c0d02c88 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02c5a:	2001      	movs	r0, #1
c0d02c5c:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02c5e:	2041      	movs	r0, #65	; 0x41
c0d02c60:	0080      	lsls	r0, r0, #2
c0d02c62:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02c64:	4625      	mov	r5, r4
c0d02c66:	350c      	adds	r5, #12
c0d02c68:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02c6a:	2900      	cmp	r1, #0
c0d02c6c:	d005      	beq.n	c0d02c7a <USBD_GetStatus+0x32>
c0d02c6e:	4620      	mov	r0, r4
c0d02c70:	f000 fa77 	bl	c0d03162 <USBD_CtlReceiveStatus>
c0d02c74:	68e1      	ldr	r1, [r4, #12]
c0d02c76:	2002      	movs	r0, #2
c0d02c78:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02c7a:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02c7c:	2202      	movs	r2, #2
c0d02c7e:	4620      	mov	r0, r4
c0d02c80:	4629      	mov	r1, r5
c0d02c82:	f000 fa33 	bl	c0d030ec <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02c86:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02c88:	2180      	movs	r1, #128	; 0x80
c0d02c8a:	4620      	mov	r0, r4
c0d02c8c:	f7ff fc72 	bl	c0d02574 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02c90:	2100      	movs	r1, #0
c0d02c92:	4620      	mov	r0, r4
c0d02c94:	f7ff fc6e 	bl	c0d02574 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02c98:	bdb0      	pop	{r4, r5, r7, pc}

c0d02c9a <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02c9a:	b5b0      	push	{r4, r5, r7, lr}
c0d02c9c:	af02      	add	r7, sp, #8
c0d02c9e:	460d      	mov	r5, r1
c0d02ca0:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02ca2:	8868      	ldrh	r0, [r5, #2]
c0d02ca4:	2801      	cmp	r0, #1
c0d02ca6:	d110      	bne.n	c0d02cca <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02ca8:	2041      	movs	r0, #65	; 0x41
c0d02caa:	0080      	lsls	r0, r0, #2
c0d02cac:	2101      	movs	r1, #1
c0d02cae:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02cb0:	2045      	movs	r0, #69	; 0x45
c0d02cb2:	0080      	lsls	r0, r0, #2
c0d02cb4:	5820      	ldr	r0, [r4, r0]
c0d02cb6:	6880      	ldr	r0, [r0, #8]
c0d02cb8:	f7ff f846 	bl	c0d01d48 <pic>
c0d02cbc:	4602      	mov	r2, r0
c0d02cbe:	4620      	mov	r0, r4
c0d02cc0:	4629      	mov	r1, r5
c0d02cc2:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02cc4:	4620      	mov	r0, r4
c0d02cc6:	f000 fa3f 	bl	c0d03148 <USBD_CtlSendStatus>
  }

}
c0d02cca:	bdb0      	pop	{r4, r5, r7, pc}

c0d02ccc <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02ccc:	b5b0      	push	{r4, r5, r7, lr}
c0d02cce:	af02      	add	r7, sp, #8
c0d02cd0:	460d      	mov	r5, r1
c0d02cd2:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02cd4:	20fc      	movs	r0, #252	; 0xfc
c0d02cd6:	5c20      	ldrb	r0, [r4, r0]
c0d02cd8:	21fe      	movs	r1, #254	; 0xfe
c0d02cda:	4001      	ands	r1, r0
c0d02cdc:	2902      	cmp	r1, #2
c0d02cde:	d114      	bne.n	c0d02d0a <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02ce0:	8868      	ldrh	r0, [r5, #2]
c0d02ce2:	2801      	cmp	r0, #1
c0d02ce4:	d119      	bne.n	c0d02d1a <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02ce6:	2041      	movs	r0, #65	; 0x41
c0d02ce8:	0080      	lsls	r0, r0, #2
c0d02cea:	2100      	movs	r1, #0
c0d02cec:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02cee:	2045      	movs	r0, #69	; 0x45
c0d02cf0:	0080      	lsls	r0, r0, #2
c0d02cf2:	5820      	ldr	r0, [r4, r0]
c0d02cf4:	6880      	ldr	r0, [r0, #8]
c0d02cf6:	f7ff f827 	bl	c0d01d48 <pic>
c0d02cfa:	4602      	mov	r2, r0
c0d02cfc:	4620      	mov	r0, r4
c0d02cfe:	4629      	mov	r1, r5
c0d02d00:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d02d02:	4620      	mov	r0, r4
c0d02d04:	f000 fa20 	bl	c0d03148 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02d08:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d0a:	2180      	movs	r1, #128	; 0x80
c0d02d0c:	4620      	mov	r0, r4
c0d02d0e:	f7ff fc31 	bl	c0d02574 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02d12:	2100      	movs	r1, #0
c0d02d14:	4620      	mov	r0, r4
c0d02d16:	f7ff fc2d 	bl	c0d02574 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02d1a:	bdb0      	pop	{r4, r5, r7, pc}

c0d02d1c <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02d1c:	b5d0      	push	{r4, r6, r7, lr}
c0d02d1e:	af02      	add	r7, sp, #8
c0d02d20:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d22:	2180      	movs	r1, #128	; 0x80
c0d02d24:	f7ff fc26 	bl	c0d02574 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02d28:	2100      	movs	r1, #0
c0d02d2a:	4620      	mov	r0, r4
c0d02d2c:	f7ff fc22 	bl	c0d02574 <USBD_LL_StallEP>
}
c0d02d30:	bdd0      	pop	{r4, r6, r7, pc}

c0d02d32 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02d32:	b5b0      	push	{r4, r5, r7, lr}
c0d02d34:	af02      	add	r7, sp, #8
c0d02d36:	460d      	mov	r5, r1
c0d02d38:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02d3a:	20fc      	movs	r0, #252	; 0xfc
c0d02d3c:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d3e:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02d40:	2803      	cmp	r0, #3
c0d02d42:	d115      	bne.n	c0d02d70 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02d44:	88a8      	ldrh	r0, [r5, #4]
c0d02d46:	22fe      	movs	r2, #254	; 0xfe
c0d02d48:	4002      	ands	r2, r0
c0d02d4a:	2a01      	cmp	r2, #1
c0d02d4c:	d810      	bhi.n	c0d02d70 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d02d4e:	2045      	movs	r0, #69	; 0x45
c0d02d50:	0080      	lsls	r0, r0, #2
c0d02d52:	5820      	ldr	r0, [r4, r0]
c0d02d54:	6880      	ldr	r0, [r0, #8]
c0d02d56:	f7fe fff7 	bl	c0d01d48 <pic>
c0d02d5a:	4602      	mov	r2, r0
c0d02d5c:	4620      	mov	r0, r4
c0d02d5e:	4629      	mov	r1, r5
c0d02d60:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02d62:	88e8      	ldrh	r0, [r5, #6]
c0d02d64:	2800      	cmp	r0, #0
c0d02d66:	d10a      	bne.n	c0d02d7e <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02d68:	4620      	mov	r0, r4
c0d02d6a:	f000 f9ed 	bl	c0d03148 <USBD_CtlSendStatus>
c0d02d6e:	e006      	b.n	c0d02d7e <USBD_StdItfReq+0x4c>
c0d02d70:	4620      	mov	r0, r4
c0d02d72:	f7ff fbff 	bl	c0d02574 <USBD_LL_StallEP>
c0d02d76:	2100      	movs	r1, #0
c0d02d78:	4620      	mov	r0, r4
c0d02d7a:	f7ff fbfb 	bl	c0d02574 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02d7e:	2000      	movs	r0, #0
c0d02d80:	bdb0      	pop	{r4, r5, r7, pc}

c0d02d82 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02d82:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02d84:	af03      	add	r7, sp, #12
c0d02d86:	b081      	sub	sp, #4
c0d02d88:	460e      	mov	r6, r1
c0d02d8a:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02d8c:	7830      	ldrb	r0, [r6, #0]
c0d02d8e:	2160      	movs	r1, #96	; 0x60
c0d02d90:	4001      	ands	r1, r0
c0d02d92:	2920      	cmp	r1, #32
c0d02d94:	d10a      	bne.n	c0d02dac <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02d96:	2045      	movs	r0, #69	; 0x45
c0d02d98:	0080      	lsls	r0, r0, #2
c0d02d9a:	5820      	ldr	r0, [r4, r0]
c0d02d9c:	6880      	ldr	r0, [r0, #8]
c0d02d9e:	f7fe ffd3 	bl	c0d01d48 <pic>
c0d02da2:	4602      	mov	r2, r0
c0d02da4:	4620      	mov	r0, r4
c0d02da6:	4631      	mov	r1, r6
c0d02da8:	4790      	blx	r2
c0d02daa:	e063      	b.n	c0d02e74 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02dac:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02dae:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02db0:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02db2:	2800      	cmp	r0, #0
c0d02db4:	d012      	beq.n	c0d02ddc <USBD_StdEPReq+0x5a>
c0d02db6:	2801      	cmp	r0, #1
c0d02db8:	d019      	beq.n	c0d02dee <USBD_StdEPReq+0x6c>
c0d02dba:	2803      	cmp	r0, #3
c0d02dbc:	d15a      	bne.n	c0d02e74 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02dbe:	20fc      	movs	r0, #252	; 0xfc
c0d02dc0:	5c20      	ldrb	r0, [r4, r0]
c0d02dc2:	2803      	cmp	r0, #3
c0d02dc4:	d117      	bne.n	c0d02df6 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02dc6:	8870      	ldrh	r0, [r6, #2]
c0d02dc8:	2800      	cmp	r0, #0
c0d02dca:	d12d      	bne.n	c0d02e28 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02dcc:	4329      	orrs	r1, r5
c0d02dce:	2980      	cmp	r1, #128	; 0x80
c0d02dd0:	d02a      	beq.n	c0d02e28 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02dd2:	4620      	mov	r0, r4
c0d02dd4:	4629      	mov	r1, r5
c0d02dd6:	f7ff fbcd 	bl	c0d02574 <USBD_LL_StallEP>
c0d02dda:	e025      	b.n	c0d02e28 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02ddc:	20fc      	movs	r0, #252	; 0xfc
c0d02dde:	5c20      	ldrb	r0, [r4, r0]
c0d02de0:	2803      	cmp	r0, #3
c0d02de2:	d02f      	beq.n	c0d02e44 <USBD_StdEPReq+0xc2>
c0d02de4:	2802      	cmp	r0, #2
c0d02de6:	d10e      	bne.n	c0d02e06 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02de8:	0668      	lsls	r0, r5, #25
c0d02dea:	d109      	bne.n	c0d02e00 <USBD_StdEPReq+0x7e>
c0d02dec:	e042      	b.n	c0d02e74 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d02dee:	20fc      	movs	r0, #252	; 0xfc
c0d02df0:	5c20      	ldrb	r0, [r4, r0]
c0d02df2:	2803      	cmp	r0, #3
c0d02df4:	d00f      	beq.n	c0d02e16 <USBD_StdEPReq+0x94>
c0d02df6:	2802      	cmp	r0, #2
c0d02df8:	d105      	bne.n	c0d02e06 <USBD_StdEPReq+0x84>
c0d02dfa:	4329      	orrs	r1, r5
c0d02dfc:	2980      	cmp	r1, #128	; 0x80
c0d02dfe:	d039      	beq.n	c0d02e74 <USBD_StdEPReq+0xf2>
c0d02e00:	4620      	mov	r0, r4
c0d02e02:	4629      	mov	r1, r5
c0d02e04:	e004      	b.n	c0d02e10 <USBD_StdEPReq+0x8e>
c0d02e06:	4620      	mov	r0, r4
c0d02e08:	f7ff fbb4 	bl	c0d02574 <USBD_LL_StallEP>
c0d02e0c:	2100      	movs	r1, #0
c0d02e0e:	4620      	mov	r0, r4
c0d02e10:	f7ff fbb0 	bl	c0d02574 <USBD_LL_StallEP>
c0d02e14:	e02e      	b.n	c0d02e74 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02e16:	8870      	ldrh	r0, [r6, #2]
c0d02e18:	2800      	cmp	r0, #0
c0d02e1a:	d12b      	bne.n	c0d02e74 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d02e1c:	0668      	lsls	r0, r5, #25
c0d02e1e:	d00d      	beq.n	c0d02e3c <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d02e20:	4620      	mov	r0, r4
c0d02e22:	4629      	mov	r1, r5
c0d02e24:	f7ff fbcc 	bl	c0d025c0 <USBD_LL_ClearStallEP>
c0d02e28:	2045      	movs	r0, #69	; 0x45
c0d02e2a:	0080      	lsls	r0, r0, #2
c0d02e2c:	5820      	ldr	r0, [r4, r0]
c0d02e2e:	6880      	ldr	r0, [r0, #8]
c0d02e30:	f7fe ff8a 	bl	c0d01d48 <pic>
c0d02e34:	4602      	mov	r2, r0
c0d02e36:	4620      	mov	r0, r4
c0d02e38:	4631      	mov	r1, r6
c0d02e3a:	4790      	blx	r2
c0d02e3c:	4620      	mov	r0, r4
c0d02e3e:	f000 f983 	bl	c0d03148 <USBD_CtlSendStatus>
c0d02e42:	e017      	b.n	c0d02e74 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02e44:	4626      	mov	r6, r4
c0d02e46:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d02e48:	4620      	mov	r0, r4
c0d02e4a:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02e4c:	420d      	tst	r5, r1
c0d02e4e:	d100      	bne.n	c0d02e52 <USBD_StdEPReq+0xd0>
c0d02e50:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d02e52:	4620      	mov	r0, r4
c0d02e54:	4629      	mov	r1, r5
c0d02e56:	f7ff fbd9 	bl	c0d0260c <USBD_LL_IsStallEP>
c0d02e5a:	2101      	movs	r1, #1
c0d02e5c:	2800      	cmp	r0, #0
c0d02e5e:	d100      	bne.n	c0d02e62 <USBD_StdEPReq+0xe0>
c0d02e60:	4601      	mov	r1, r0
c0d02e62:	207f      	movs	r0, #127	; 0x7f
c0d02e64:	4005      	ands	r5, r0
c0d02e66:	0128      	lsls	r0, r5, #4
c0d02e68:	5031      	str	r1, [r6, r0]
c0d02e6a:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d02e6c:	2202      	movs	r2, #2
c0d02e6e:	4620      	mov	r0, r4
c0d02e70:	f000 f93c 	bl	c0d030ec <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d02e74:	2000      	movs	r0, #0
c0d02e76:	b001      	add	sp, #4
c0d02e78:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02e7a <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d02e7a:	780a      	ldrb	r2, [r1, #0]
c0d02e7c:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02e7e:	784a      	ldrb	r2, [r1, #1]
c0d02e80:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02e82:	788a      	ldrb	r2, [r1, #2]
c0d02e84:	78cb      	ldrb	r3, [r1, #3]
c0d02e86:	021b      	lsls	r3, r3, #8
c0d02e88:	4313      	orrs	r3, r2
c0d02e8a:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02e8c:	790a      	ldrb	r2, [r1, #4]
c0d02e8e:	794b      	ldrb	r3, [r1, #5]
c0d02e90:	021b      	lsls	r3, r3, #8
c0d02e92:	4313      	orrs	r3, r2
c0d02e94:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02e96:	798a      	ldrb	r2, [r1, #6]
c0d02e98:	79c9      	ldrb	r1, [r1, #7]
c0d02e9a:	0209      	lsls	r1, r1, #8
c0d02e9c:	4311      	orrs	r1, r2
c0d02e9e:	80c1      	strh	r1, [r0, #6]

}
c0d02ea0:	4770      	bx	lr

c0d02ea2 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02ea2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02ea4:	af03      	add	r7, sp, #12
c0d02ea6:	b083      	sub	sp, #12
c0d02ea8:	460d      	mov	r5, r1
c0d02eaa:	4604      	mov	r4, r0
c0d02eac:	a802      	add	r0, sp, #8
c0d02eae:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d02eb0:	8006      	strh	r6, [r0, #0]
c0d02eb2:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02eb4:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02eb6:	7829      	ldrb	r1, [r5, #0]
c0d02eb8:	2060      	movs	r0, #96	; 0x60
c0d02eba:	4008      	ands	r0, r1
c0d02ebc:	2800      	cmp	r0, #0
c0d02ebe:	d010      	beq.n	c0d02ee2 <USBD_HID_Setup+0x40>
c0d02ec0:	2820      	cmp	r0, #32
c0d02ec2:	d139      	bne.n	c0d02f38 <USBD_HID_Setup+0x96>
c0d02ec4:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02ec6:	4601      	mov	r1, r0
c0d02ec8:	390a      	subs	r1, #10
c0d02eca:	2902      	cmp	r1, #2
c0d02ecc:	d334      	bcc.n	c0d02f38 <USBD_HID_Setup+0x96>
c0d02ece:	2802      	cmp	r0, #2
c0d02ed0:	d01c      	beq.n	c0d02f0c <USBD_HID_Setup+0x6a>
c0d02ed2:	2803      	cmp	r0, #3
c0d02ed4:	d01a      	beq.n	c0d02f0c <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02ed6:	4620      	mov	r0, r4
c0d02ed8:	4629      	mov	r1, r5
c0d02eda:	f7ff ff1f 	bl	c0d02d1c <USBD_CtlError>
c0d02ede:	2602      	movs	r6, #2
c0d02ee0:	e02a      	b.n	c0d02f38 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d02ee2:	7868      	ldrb	r0, [r5, #1]
c0d02ee4:	280b      	cmp	r0, #11
c0d02ee6:	d014      	beq.n	c0d02f12 <USBD_HID_Setup+0x70>
c0d02ee8:	280a      	cmp	r0, #10
c0d02eea:	d00f      	beq.n	c0d02f0c <USBD_HID_Setup+0x6a>
c0d02eec:	2806      	cmp	r0, #6
c0d02eee:	d123      	bne.n	c0d02f38 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d02ef0:	8868      	ldrh	r0, [r5, #2]
c0d02ef2:	0a00      	lsrs	r0, r0, #8
c0d02ef4:	2600      	movs	r6, #0
c0d02ef6:	2821      	cmp	r0, #33	; 0x21
c0d02ef8:	d00f      	beq.n	c0d02f1a <USBD_HID_Setup+0x78>
c0d02efa:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02efc:	4632      	mov	r2, r6
c0d02efe:	4631      	mov	r1, r6
c0d02f00:	d117      	bne.n	c0d02f32 <USBD_HID_Setup+0x90>
c0d02f02:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02f04:	9000      	str	r0, [sp, #0]
c0d02f06:	f000 f847 	bl	c0d02f98 <USBD_HID_GetReportDescriptor_impl>
c0d02f0a:	e00a      	b.n	c0d02f22 <USBD_HID_Setup+0x80>
c0d02f0c:	a901      	add	r1, sp, #4
c0d02f0e:	2201      	movs	r2, #1
c0d02f10:	e00f      	b.n	c0d02f32 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d02f12:	4620      	mov	r0, r4
c0d02f14:	f000 f918 	bl	c0d03148 <USBD_CtlSendStatus>
c0d02f18:	e00e      	b.n	c0d02f38 <USBD_HID_Setup+0x96>
c0d02f1a:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02f1c:	9000      	str	r0, [sp, #0]
c0d02f1e:	f000 f833 	bl	c0d02f88 <USBD_HID_GetHidDescriptor_impl>
c0d02f22:	9b00      	ldr	r3, [sp, #0]
c0d02f24:	4601      	mov	r1, r0
c0d02f26:	881a      	ldrh	r2, [r3, #0]
c0d02f28:	88e8      	ldrh	r0, [r5, #6]
c0d02f2a:	4282      	cmp	r2, r0
c0d02f2c:	d300      	bcc.n	c0d02f30 <USBD_HID_Setup+0x8e>
c0d02f2e:	4602      	mov	r2, r0
c0d02f30:	801a      	strh	r2, [r3, #0]
c0d02f32:	4620      	mov	r0, r4
c0d02f34:	f000 f8da 	bl	c0d030ec <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02f38:	b2f0      	uxtb	r0, r6
c0d02f3a:	b003      	add	sp, #12
c0d02f3c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02f3e <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d02f3e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02f40:	af03      	add	r7, sp, #12
c0d02f42:	b081      	sub	sp, #4
c0d02f44:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02f46:	2182      	movs	r1, #130	; 0x82
c0d02f48:	2502      	movs	r5, #2
c0d02f4a:	2640      	movs	r6, #64	; 0x40
c0d02f4c:	462a      	mov	r2, r5
c0d02f4e:	4633      	mov	r3, r6
c0d02f50:	f7ff fad0 	bl	c0d024f4 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d02f54:	4620      	mov	r0, r4
c0d02f56:	4629      	mov	r1, r5
c0d02f58:	462a      	mov	r2, r5
c0d02f5a:	4633      	mov	r3, r6
c0d02f5c:	f7ff faca 	bl	c0d024f4 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d02f60:	4620      	mov	r0, r4
c0d02f62:	4629      	mov	r1, r5
c0d02f64:	4632      	mov	r2, r6
c0d02f66:	f7ff fb90 	bl	c0d0268a <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d02f6a:	2000      	movs	r0, #0
c0d02f6c:	b001      	add	sp, #4
c0d02f6e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02f70 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d02f70:	b5d0      	push	{r4, r6, r7, lr}
c0d02f72:	af02      	add	r7, sp, #8
c0d02f74:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d02f76:	2182      	movs	r1, #130	; 0x82
c0d02f78:	f7ff fae4 	bl	c0d02544 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d02f7c:	2102      	movs	r1, #2
c0d02f7e:	4620      	mov	r0, r4
c0d02f80:	f7ff fae0 	bl	c0d02544 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02f84:	2000      	movs	r0, #0
c0d02f86:	bdd0      	pop	{r4, r6, r7, pc}

c0d02f88 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d02f88:	2109      	movs	r1, #9
c0d02f8a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d02f8c:	4801      	ldr	r0, [pc, #4]	; (c0d02f94 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d02f8e:	4478      	add	r0, pc
c0d02f90:	4770      	bx	lr
c0d02f92:	46c0      	nop			; (mov r8, r8)
c0d02f94:	00000bca 	.word	0x00000bca

c0d02f98 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d02f98:	2122      	movs	r1, #34	; 0x22
c0d02f9a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d02f9c:	4801      	ldr	r0, [pc, #4]	; (c0d02fa4 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d02f9e:	4478      	add	r0, pc
c0d02fa0:	4770      	bx	lr
c0d02fa2:	46c0      	nop			; (mov r8, r8)
c0d02fa4:	00000b95 	.word	0x00000b95

c0d02fa8 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02fa8:	b5b0      	push	{r4, r5, r7, lr}
c0d02faa:	af02      	add	r7, sp, #8
c0d02fac:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d02fae:	2102      	movs	r1, #2
c0d02fb0:	2240      	movs	r2, #64	; 0x40
c0d02fb2:	f7ff fb6a 	bl	c0d0268a <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02fb6:	4d0d      	ldr	r5, [pc, #52]	; (c0d02fec <USBD_HID_DataOut_impl+0x44>)
c0d02fb8:	7828      	ldrb	r0, [r5, #0]
c0d02fba:	2800      	cmp	r0, #0
c0d02fbc:	d113      	bne.n	c0d02fe6 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d02fbe:	2002      	movs	r0, #2
c0d02fc0:	f7fe f928 	bl	c0d01214 <io_seproxyhal_get_ep_rx_size>
c0d02fc4:	4602      	mov	r2, r0
c0d02fc6:	480d      	ldr	r0, [pc, #52]	; (c0d02ffc <USBD_HID_DataOut_impl+0x54>)
c0d02fc8:	4478      	add	r0, pc
c0d02fca:	4621      	mov	r1, r4
c0d02fcc:	f7fd ff86 	bl	c0d00edc <io_usb_hid_receive>
c0d02fd0:	2802      	cmp	r0, #2
c0d02fd2:	d108      	bne.n	c0d02fe6 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02fd4:	2001      	movs	r0, #1
c0d02fd6:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02fd8:	4805      	ldr	r0, [pc, #20]	; (c0d02ff0 <USBD_HID_DataOut_impl+0x48>)
c0d02fda:	2107      	movs	r1, #7
c0d02fdc:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d02fde:	4805      	ldr	r0, [pc, #20]	; (c0d02ff4 <USBD_HID_DataOut_impl+0x4c>)
c0d02fe0:	6800      	ldr	r0, [r0, #0]
c0d02fe2:	4905      	ldr	r1, [pc, #20]	; (c0d02ff8 <USBD_HID_DataOut_impl+0x50>)
c0d02fe4:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02fe6:	2000      	movs	r0, #0
c0d02fe8:	bdb0      	pop	{r4, r5, r7, pc}
c0d02fea:	46c0      	nop			; (mov r8, r8)
c0d02fec:	20001d10 	.word	0x20001d10
c0d02ff0:	20001d18 	.word	0x20001d18
c0d02ff4:	20001c00 	.word	0x20001c00
c0d02ff8:	20001d1c 	.word	0x20001d1c
c0d02ffc:	ffffe3a1 	.word	0xffffe3a1

c0d03000 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d03000:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03002:	af03      	add	r7, sp, #12
c0d03004:	b081      	sub	sp, #4
c0d03006:	4604      	mov	r4, r0
c0d03008:	2049      	movs	r0, #73	; 0x49
c0d0300a:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d0300c:	4810      	ldr	r0, [pc, #64]	; (c0d03050 <USB_power+0x50>)
c0d0300e:	2100      	movs	r1, #0
c0d03010:	462a      	mov	r2, r5
c0d03012:	f7fe f80f 	bl	c0d01034 <os_memset>

  if (enabled) {
c0d03016:	2c00      	cmp	r4, #0
c0d03018:	d015      	beq.n	c0d03046 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d0301a:	4c0d      	ldr	r4, [pc, #52]	; (c0d03050 <USB_power+0x50>)
c0d0301c:	2600      	movs	r6, #0
c0d0301e:	4620      	mov	r0, r4
c0d03020:	4631      	mov	r1, r6
c0d03022:	462a      	mov	r2, r5
c0d03024:	f7fe f806 	bl	c0d01034 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d03028:	490a      	ldr	r1, [pc, #40]	; (c0d03054 <USB_power+0x54>)
c0d0302a:	4479      	add	r1, pc
c0d0302c:	4620      	mov	r0, r4
c0d0302e:	4632      	mov	r2, r6
c0d03030:	f7ff fb3f 	bl	c0d026b2 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d03034:	4908      	ldr	r1, [pc, #32]	; (c0d03058 <USB_power+0x58>)
c0d03036:	4479      	add	r1, pc
c0d03038:	4620      	mov	r0, r4
c0d0303a:	f7ff fb72 	bl	c0d02722 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d0303e:	4620      	mov	r0, r4
c0d03040:	f7ff fb78 	bl	c0d02734 <USBD_Start>
c0d03044:	e002      	b.n	c0d0304c <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d03046:	4802      	ldr	r0, [pc, #8]	; (c0d03050 <USB_power+0x50>)
c0d03048:	f7ff fb51 	bl	c0d026ee <USBD_DeInit>
  }
}
c0d0304c:	b001      	add	sp, #4
c0d0304e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03050:	20001d34 	.word	0x20001d34
c0d03054:	00000b4a 	.word	0x00000b4a
c0d03058:	00000b7a 	.word	0x00000b7a

c0d0305c <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d0305c:	2012      	movs	r0, #18
c0d0305e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d03060:	4801      	ldr	r0, [pc, #4]	; (c0d03068 <USBD_DeviceDescriptor+0xc>)
c0d03062:	4478      	add	r0, pc
c0d03064:	4770      	bx	lr
c0d03066:	46c0      	nop			; (mov r8, r8)
c0d03068:	00000aff 	.word	0x00000aff

c0d0306c <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d0306c:	2004      	movs	r0, #4
c0d0306e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d03070:	4801      	ldr	r0, [pc, #4]	; (c0d03078 <USBD_LangIDStrDescriptor+0xc>)
c0d03072:	4478      	add	r0, pc
c0d03074:	4770      	bx	lr
c0d03076:	46c0      	nop			; (mov r8, r8)
c0d03078:	00000b22 	.word	0x00000b22

c0d0307c <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d0307c:	200e      	movs	r0, #14
c0d0307e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d03080:	4801      	ldr	r0, [pc, #4]	; (c0d03088 <USBD_ManufacturerStrDescriptor+0xc>)
c0d03082:	4478      	add	r0, pc
c0d03084:	4770      	bx	lr
c0d03086:	46c0      	nop			; (mov r8, r8)
c0d03088:	00000b16 	.word	0x00000b16

c0d0308c <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d0308c:	200e      	movs	r0, #14
c0d0308e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d03090:	4801      	ldr	r0, [pc, #4]	; (c0d03098 <USBD_ProductStrDescriptor+0xc>)
c0d03092:	4478      	add	r0, pc
c0d03094:	4770      	bx	lr
c0d03096:	46c0      	nop			; (mov r8, r8)
c0d03098:	00000a93 	.word	0x00000a93

c0d0309c <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d0309c:	200a      	movs	r0, #10
c0d0309e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d030a0:	4801      	ldr	r0, [pc, #4]	; (c0d030a8 <USBD_SerialStrDescriptor+0xc>)
c0d030a2:	4478      	add	r0, pc
c0d030a4:	4770      	bx	lr
c0d030a6:	46c0      	nop			; (mov r8, r8)
c0d030a8:	00000b04 	.word	0x00000b04

c0d030ac <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d030ac:	200e      	movs	r0, #14
c0d030ae:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d030b0:	4801      	ldr	r0, [pc, #4]	; (c0d030b8 <USBD_ConfigStrDescriptor+0xc>)
c0d030b2:	4478      	add	r0, pc
c0d030b4:	4770      	bx	lr
c0d030b6:	46c0      	nop			; (mov r8, r8)
c0d030b8:	00000a73 	.word	0x00000a73

c0d030bc <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d030bc:	200e      	movs	r0, #14
c0d030be:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d030c0:	4801      	ldr	r0, [pc, #4]	; (c0d030c8 <USBD_InterfaceStrDescriptor+0xc>)
c0d030c2:	4478      	add	r0, pc
c0d030c4:	4770      	bx	lr
c0d030c6:	46c0      	nop			; (mov r8, r8)
c0d030c8:	00000a63 	.word	0x00000a63

c0d030cc <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d030cc:	2129      	movs	r1, #41	; 0x29
c0d030ce:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d030d0:	4801      	ldr	r0, [pc, #4]	; (c0d030d8 <USBD_GetCfgDesc_impl+0xc>)
c0d030d2:	4478      	add	r0, pc
c0d030d4:	4770      	bx	lr
c0d030d6:	46c0      	nop			; (mov r8, r8)
c0d030d8:	00000b16 	.word	0x00000b16

c0d030dc <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d030dc:	210a      	movs	r1, #10
c0d030de:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d030e0:	4801      	ldr	r0, [pc, #4]	; (c0d030e8 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d030e2:	4478      	add	r0, pc
c0d030e4:	4770      	bx	lr
c0d030e6:	46c0      	nop			; (mov r8, r8)
c0d030e8:	00000b32 	.word	0x00000b32

c0d030ec <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d030ec:	b5b0      	push	{r4, r5, r7, lr}
c0d030ee:	af02      	add	r7, sp, #8
c0d030f0:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d030f2:	21f4      	movs	r1, #244	; 0xf4
c0d030f4:	2302      	movs	r3, #2
c0d030f6:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d030f8:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d030fa:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d030fc:	2109      	movs	r1, #9
c0d030fe:	0149      	lsls	r1, r1, #5
c0d03100:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d03102:	6a01      	ldr	r1, [r0, #32]
c0d03104:	428a      	cmp	r2, r1
c0d03106:	d300      	bcc.n	c0d0310a <USBD_CtlSendData+0x1e>
c0d03108:	460a      	mov	r2, r1
c0d0310a:	b293      	uxth	r3, r2
c0d0310c:	2500      	movs	r5, #0
c0d0310e:	4629      	mov	r1, r5
c0d03110:	4622      	mov	r2, r4
c0d03112:	f7ff faa0 	bl	c0d02656 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03116:	4628      	mov	r0, r5
c0d03118:	bdb0      	pop	{r4, r5, r7, pc}

c0d0311a <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d0311a:	b5b0      	push	{r4, r5, r7, lr}
c0d0311c:	af02      	add	r7, sp, #8
c0d0311e:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d03120:	6a01      	ldr	r1, [r0, #32]
c0d03122:	428a      	cmp	r2, r1
c0d03124:	d300      	bcc.n	c0d03128 <USBD_CtlContinueSendData+0xe>
c0d03126:	460a      	mov	r2, r1
c0d03128:	b293      	uxth	r3, r2
c0d0312a:	2500      	movs	r5, #0
c0d0312c:	4629      	mov	r1, r5
c0d0312e:	4622      	mov	r2, r4
c0d03130:	f7ff fa91 	bl	c0d02656 <USBD_LL_Transmit>
  return USBD_OK;
c0d03134:	4628      	mov	r0, r5
c0d03136:	bdb0      	pop	{r4, r5, r7, pc}

c0d03138 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d03138:	b5d0      	push	{r4, r6, r7, lr}
c0d0313a:	af02      	add	r7, sp, #8
c0d0313c:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d0313e:	4621      	mov	r1, r4
c0d03140:	f7ff faa3 	bl	c0d0268a <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d03144:	4620      	mov	r0, r4
c0d03146:	bdd0      	pop	{r4, r6, r7, pc}

c0d03148 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d03148:	b5d0      	push	{r4, r6, r7, lr}
c0d0314a:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d0314c:	21f4      	movs	r1, #244	; 0xf4
c0d0314e:	2204      	movs	r2, #4
c0d03150:	5042      	str	r2, [r0, r1]
c0d03152:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d03154:	4621      	mov	r1, r4
c0d03156:	4622      	mov	r2, r4
c0d03158:	4623      	mov	r3, r4
c0d0315a:	f7ff fa7c 	bl	c0d02656 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d0315e:	4620      	mov	r0, r4
c0d03160:	bdd0      	pop	{r4, r6, r7, pc}

c0d03162 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d03162:	b5d0      	push	{r4, r6, r7, lr}
c0d03164:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d03166:	21f4      	movs	r1, #244	; 0xf4
c0d03168:	2205      	movs	r2, #5
c0d0316a:	5042      	str	r2, [r0, r1]
c0d0316c:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d0316e:	4621      	mov	r1, r4
c0d03170:	4622      	mov	r2, r4
c0d03172:	f7ff fa8a 	bl	c0d0268a <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d03176:	4620      	mov	r0, r4
c0d03178:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d0317c <__aeabi_uidiv>:
c0d0317c:	2200      	movs	r2, #0
c0d0317e:	0843      	lsrs	r3, r0, #1
c0d03180:	428b      	cmp	r3, r1
c0d03182:	d374      	bcc.n	c0d0326e <__aeabi_uidiv+0xf2>
c0d03184:	0903      	lsrs	r3, r0, #4
c0d03186:	428b      	cmp	r3, r1
c0d03188:	d35f      	bcc.n	c0d0324a <__aeabi_uidiv+0xce>
c0d0318a:	0a03      	lsrs	r3, r0, #8
c0d0318c:	428b      	cmp	r3, r1
c0d0318e:	d344      	bcc.n	c0d0321a <__aeabi_uidiv+0x9e>
c0d03190:	0b03      	lsrs	r3, r0, #12
c0d03192:	428b      	cmp	r3, r1
c0d03194:	d328      	bcc.n	c0d031e8 <__aeabi_uidiv+0x6c>
c0d03196:	0c03      	lsrs	r3, r0, #16
c0d03198:	428b      	cmp	r3, r1
c0d0319a:	d30d      	bcc.n	c0d031b8 <__aeabi_uidiv+0x3c>
c0d0319c:	22ff      	movs	r2, #255	; 0xff
c0d0319e:	0209      	lsls	r1, r1, #8
c0d031a0:	ba12      	rev	r2, r2
c0d031a2:	0c03      	lsrs	r3, r0, #16
c0d031a4:	428b      	cmp	r3, r1
c0d031a6:	d302      	bcc.n	c0d031ae <__aeabi_uidiv+0x32>
c0d031a8:	1212      	asrs	r2, r2, #8
c0d031aa:	0209      	lsls	r1, r1, #8
c0d031ac:	d065      	beq.n	c0d0327a <__aeabi_uidiv+0xfe>
c0d031ae:	0b03      	lsrs	r3, r0, #12
c0d031b0:	428b      	cmp	r3, r1
c0d031b2:	d319      	bcc.n	c0d031e8 <__aeabi_uidiv+0x6c>
c0d031b4:	e000      	b.n	c0d031b8 <__aeabi_uidiv+0x3c>
c0d031b6:	0a09      	lsrs	r1, r1, #8
c0d031b8:	0bc3      	lsrs	r3, r0, #15
c0d031ba:	428b      	cmp	r3, r1
c0d031bc:	d301      	bcc.n	c0d031c2 <__aeabi_uidiv+0x46>
c0d031be:	03cb      	lsls	r3, r1, #15
c0d031c0:	1ac0      	subs	r0, r0, r3
c0d031c2:	4152      	adcs	r2, r2
c0d031c4:	0b83      	lsrs	r3, r0, #14
c0d031c6:	428b      	cmp	r3, r1
c0d031c8:	d301      	bcc.n	c0d031ce <__aeabi_uidiv+0x52>
c0d031ca:	038b      	lsls	r3, r1, #14
c0d031cc:	1ac0      	subs	r0, r0, r3
c0d031ce:	4152      	adcs	r2, r2
c0d031d0:	0b43      	lsrs	r3, r0, #13
c0d031d2:	428b      	cmp	r3, r1
c0d031d4:	d301      	bcc.n	c0d031da <__aeabi_uidiv+0x5e>
c0d031d6:	034b      	lsls	r3, r1, #13
c0d031d8:	1ac0      	subs	r0, r0, r3
c0d031da:	4152      	adcs	r2, r2
c0d031dc:	0b03      	lsrs	r3, r0, #12
c0d031de:	428b      	cmp	r3, r1
c0d031e0:	d301      	bcc.n	c0d031e6 <__aeabi_uidiv+0x6a>
c0d031e2:	030b      	lsls	r3, r1, #12
c0d031e4:	1ac0      	subs	r0, r0, r3
c0d031e6:	4152      	adcs	r2, r2
c0d031e8:	0ac3      	lsrs	r3, r0, #11
c0d031ea:	428b      	cmp	r3, r1
c0d031ec:	d301      	bcc.n	c0d031f2 <__aeabi_uidiv+0x76>
c0d031ee:	02cb      	lsls	r3, r1, #11
c0d031f0:	1ac0      	subs	r0, r0, r3
c0d031f2:	4152      	adcs	r2, r2
c0d031f4:	0a83      	lsrs	r3, r0, #10
c0d031f6:	428b      	cmp	r3, r1
c0d031f8:	d301      	bcc.n	c0d031fe <__aeabi_uidiv+0x82>
c0d031fa:	028b      	lsls	r3, r1, #10
c0d031fc:	1ac0      	subs	r0, r0, r3
c0d031fe:	4152      	adcs	r2, r2
c0d03200:	0a43      	lsrs	r3, r0, #9
c0d03202:	428b      	cmp	r3, r1
c0d03204:	d301      	bcc.n	c0d0320a <__aeabi_uidiv+0x8e>
c0d03206:	024b      	lsls	r3, r1, #9
c0d03208:	1ac0      	subs	r0, r0, r3
c0d0320a:	4152      	adcs	r2, r2
c0d0320c:	0a03      	lsrs	r3, r0, #8
c0d0320e:	428b      	cmp	r3, r1
c0d03210:	d301      	bcc.n	c0d03216 <__aeabi_uidiv+0x9a>
c0d03212:	020b      	lsls	r3, r1, #8
c0d03214:	1ac0      	subs	r0, r0, r3
c0d03216:	4152      	adcs	r2, r2
c0d03218:	d2cd      	bcs.n	c0d031b6 <__aeabi_uidiv+0x3a>
c0d0321a:	09c3      	lsrs	r3, r0, #7
c0d0321c:	428b      	cmp	r3, r1
c0d0321e:	d301      	bcc.n	c0d03224 <__aeabi_uidiv+0xa8>
c0d03220:	01cb      	lsls	r3, r1, #7
c0d03222:	1ac0      	subs	r0, r0, r3
c0d03224:	4152      	adcs	r2, r2
c0d03226:	0983      	lsrs	r3, r0, #6
c0d03228:	428b      	cmp	r3, r1
c0d0322a:	d301      	bcc.n	c0d03230 <__aeabi_uidiv+0xb4>
c0d0322c:	018b      	lsls	r3, r1, #6
c0d0322e:	1ac0      	subs	r0, r0, r3
c0d03230:	4152      	adcs	r2, r2
c0d03232:	0943      	lsrs	r3, r0, #5
c0d03234:	428b      	cmp	r3, r1
c0d03236:	d301      	bcc.n	c0d0323c <__aeabi_uidiv+0xc0>
c0d03238:	014b      	lsls	r3, r1, #5
c0d0323a:	1ac0      	subs	r0, r0, r3
c0d0323c:	4152      	adcs	r2, r2
c0d0323e:	0903      	lsrs	r3, r0, #4
c0d03240:	428b      	cmp	r3, r1
c0d03242:	d301      	bcc.n	c0d03248 <__aeabi_uidiv+0xcc>
c0d03244:	010b      	lsls	r3, r1, #4
c0d03246:	1ac0      	subs	r0, r0, r3
c0d03248:	4152      	adcs	r2, r2
c0d0324a:	08c3      	lsrs	r3, r0, #3
c0d0324c:	428b      	cmp	r3, r1
c0d0324e:	d301      	bcc.n	c0d03254 <__aeabi_uidiv+0xd8>
c0d03250:	00cb      	lsls	r3, r1, #3
c0d03252:	1ac0      	subs	r0, r0, r3
c0d03254:	4152      	adcs	r2, r2
c0d03256:	0883      	lsrs	r3, r0, #2
c0d03258:	428b      	cmp	r3, r1
c0d0325a:	d301      	bcc.n	c0d03260 <__aeabi_uidiv+0xe4>
c0d0325c:	008b      	lsls	r3, r1, #2
c0d0325e:	1ac0      	subs	r0, r0, r3
c0d03260:	4152      	adcs	r2, r2
c0d03262:	0843      	lsrs	r3, r0, #1
c0d03264:	428b      	cmp	r3, r1
c0d03266:	d301      	bcc.n	c0d0326c <__aeabi_uidiv+0xf0>
c0d03268:	004b      	lsls	r3, r1, #1
c0d0326a:	1ac0      	subs	r0, r0, r3
c0d0326c:	4152      	adcs	r2, r2
c0d0326e:	1a41      	subs	r1, r0, r1
c0d03270:	d200      	bcs.n	c0d03274 <__aeabi_uidiv+0xf8>
c0d03272:	4601      	mov	r1, r0
c0d03274:	4152      	adcs	r2, r2
c0d03276:	4610      	mov	r0, r2
c0d03278:	4770      	bx	lr
c0d0327a:	e7ff      	b.n	c0d0327c <__aeabi_uidiv+0x100>
c0d0327c:	b501      	push	{r0, lr}
c0d0327e:	2000      	movs	r0, #0
c0d03280:	f000 f8f0 	bl	c0d03464 <__aeabi_idiv0>
c0d03284:	bd02      	pop	{r1, pc}
c0d03286:	46c0      	nop			; (mov r8, r8)

c0d03288 <__aeabi_uidivmod>:
c0d03288:	2900      	cmp	r1, #0
c0d0328a:	d0f7      	beq.n	c0d0327c <__aeabi_uidiv+0x100>
c0d0328c:	e776      	b.n	c0d0317c <__aeabi_uidiv>
c0d0328e:	4770      	bx	lr

c0d03290 <__aeabi_idiv>:
c0d03290:	4603      	mov	r3, r0
c0d03292:	430b      	orrs	r3, r1
c0d03294:	d47f      	bmi.n	c0d03396 <__aeabi_idiv+0x106>
c0d03296:	2200      	movs	r2, #0
c0d03298:	0843      	lsrs	r3, r0, #1
c0d0329a:	428b      	cmp	r3, r1
c0d0329c:	d374      	bcc.n	c0d03388 <__aeabi_idiv+0xf8>
c0d0329e:	0903      	lsrs	r3, r0, #4
c0d032a0:	428b      	cmp	r3, r1
c0d032a2:	d35f      	bcc.n	c0d03364 <__aeabi_idiv+0xd4>
c0d032a4:	0a03      	lsrs	r3, r0, #8
c0d032a6:	428b      	cmp	r3, r1
c0d032a8:	d344      	bcc.n	c0d03334 <__aeabi_idiv+0xa4>
c0d032aa:	0b03      	lsrs	r3, r0, #12
c0d032ac:	428b      	cmp	r3, r1
c0d032ae:	d328      	bcc.n	c0d03302 <__aeabi_idiv+0x72>
c0d032b0:	0c03      	lsrs	r3, r0, #16
c0d032b2:	428b      	cmp	r3, r1
c0d032b4:	d30d      	bcc.n	c0d032d2 <__aeabi_idiv+0x42>
c0d032b6:	22ff      	movs	r2, #255	; 0xff
c0d032b8:	0209      	lsls	r1, r1, #8
c0d032ba:	ba12      	rev	r2, r2
c0d032bc:	0c03      	lsrs	r3, r0, #16
c0d032be:	428b      	cmp	r3, r1
c0d032c0:	d302      	bcc.n	c0d032c8 <__aeabi_idiv+0x38>
c0d032c2:	1212      	asrs	r2, r2, #8
c0d032c4:	0209      	lsls	r1, r1, #8
c0d032c6:	d065      	beq.n	c0d03394 <__aeabi_idiv+0x104>
c0d032c8:	0b03      	lsrs	r3, r0, #12
c0d032ca:	428b      	cmp	r3, r1
c0d032cc:	d319      	bcc.n	c0d03302 <__aeabi_idiv+0x72>
c0d032ce:	e000      	b.n	c0d032d2 <__aeabi_idiv+0x42>
c0d032d0:	0a09      	lsrs	r1, r1, #8
c0d032d2:	0bc3      	lsrs	r3, r0, #15
c0d032d4:	428b      	cmp	r3, r1
c0d032d6:	d301      	bcc.n	c0d032dc <__aeabi_idiv+0x4c>
c0d032d8:	03cb      	lsls	r3, r1, #15
c0d032da:	1ac0      	subs	r0, r0, r3
c0d032dc:	4152      	adcs	r2, r2
c0d032de:	0b83      	lsrs	r3, r0, #14
c0d032e0:	428b      	cmp	r3, r1
c0d032e2:	d301      	bcc.n	c0d032e8 <__aeabi_idiv+0x58>
c0d032e4:	038b      	lsls	r3, r1, #14
c0d032e6:	1ac0      	subs	r0, r0, r3
c0d032e8:	4152      	adcs	r2, r2
c0d032ea:	0b43      	lsrs	r3, r0, #13
c0d032ec:	428b      	cmp	r3, r1
c0d032ee:	d301      	bcc.n	c0d032f4 <__aeabi_idiv+0x64>
c0d032f0:	034b      	lsls	r3, r1, #13
c0d032f2:	1ac0      	subs	r0, r0, r3
c0d032f4:	4152      	adcs	r2, r2
c0d032f6:	0b03      	lsrs	r3, r0, #12
c0d032f8:	428b      	cmp	r3, r1
c0d032fa:	d301      	bcc.n	c0d03300 <__aeabi_idiv+0x70>
c0d032fc:	030b      	lsls	r3, r1, #12
c0d032fe:	1ac0      	subs	r0, r0, r3
c0d03300:	4152      	adcs	r2, r2
c0d03302:	0ac3      	lsrs	r3, r0, #11
c0d03304:	428b      	cmp	r3, r1
c0d03306:	d301      	bcc.n	c0d0330c <__aeabi_idiv+0x7c>
c0d03308:	02cb      	lsls	r3, r1, #11
c0d0330a:	1ac0      	subs	r0, r0, r3
c0d0330c:	4152      	adcs	r2, r2
c0d0330e:	0a83      	lsrs	r3, r0, #10
c0d03310:	428b      	cmp	r3, r1
c0d03312:	d301      	bcc.n	c0d03318 <__aeabi_idiv+0x88>
c0d03314:	028b      	lsls	r3, r1, #10
c0d03316:	1ac0      	subs	r0, r0, r3
c0d03318:	4152      	adcs	r2, r2
c0d0331a:	0a43      	lsrs	r3, r0, #9
c0d0331c:	428b      	cmp	r3, r1
c0d0331e:	d301      	bcc.n	c0d03324 <__aeabi_idiv+0x94>
c0d03320:	024b      	lsls	r3, r1, #9
c0d03322:	1ac0      	subs	r0, r0, r3
c0d03324:	4152      	adcs	r2, r2
c0d03326:	0a03      	lsrs	r3, r0, #8
c0d03328:	428b      	cmp	r3, r1
c0d0332a:	d301      	bcc.n	c0d03330 <__aeabi_idiv+0xa0>
c0d0332c:	020b      	lsls	r3, r1, #8
c0d0332e:	1ac0      	subs	r0, r0, r3
c0d03330:	4152      	adcs	r2, r2
c0d03332:	d2cd      	bcs.n	c0d032d0 <__aeabi_idiv+0x40>
c0d03334:	09c3      	lsrs	r3, r0, #7
c0d03336:	428b      	cmp	r3, r1
c0d03338:	d301      	bcc.n	c0d0333e <__aeabi_idiv+0xae>
c0d0333a:	01cb      	lsls	r3, r1, #7
c0d0333c:	1ac0      	subs	r0, r0, r3
c0d0333e:	4152      	adcs	r2, r2
c0d03340:	0983      	lsrs	r3, r0, #6
c0d03342:	428b      	cmp	r3, r1
c0d03344:	d301      	bcc.n	c0d0334a <__aeabi_idiv+0xba>
c0d03346:	018b      	lsls	r3, r1, #6
c0d03348:	1ac0      	subs	r0, r0, r3
c0d0334a:	4152      	adcs	r2, r2
c0d0334c:	0943      	lsrs	r3, r0, #5
c0d0334e:	428b      	cmp	r3, r1
c0d03350:	d301      	bcc.n	c0d03356 <__aeabi_idiv+0xc6>
c0d03352:	014b      	lsls	r3, r1, #5
c0d03354:	1ac0      	subs	r0, r0, r3
c0d03356:	4152      	adcs	r2, r2
c0d03358:	0903      	lsrs	r3, r0, #4
c0d0335a:	428b      	cmp	r3, r1
c0d0335c:	d301      	bcc.n	c0d03362 <__aeabi_idiv+0xd2>
c0d0335e:	010b      	lsls	r3, r1, #4
c0d03360:	1ac0      	subs	r0, r0, r3
c0d03362:	4152      	adcs	r2, r2
c0d03364:	08c3      	lsrs	r3, r0, #3
c0d03366:	428b      	cmp	r3, r1
c0d03368:	d301      	bcc.n	c0d0336e <__aeabi_idiv+0xde>
c0d0336a:	00cb      	lsls	r3, r1, #3
c0d0336c:	1ac0      	subs	r0, r0, r3
c0d0336e:	4152      	adcs	r2, r2
c0d03370:	0883      	lsrs	r3, r0, #2
c0d03372:	428b      	cmp	r3, r1
c0d03374:	d301      	bcc.n	c0d0337a <__aeabi_idiv+0xea>
c0d03376:	008b      	lsls	r3, r1, #2
c0d03378:	1ac0      	subs	r0, r0, r3
c0d0337a:	4152      	adcs	r2, r2
c0d0337c:	0843      	lsrs	r3, r0, #1
c0d0337e:	428b      	cmp	r3, r1
c0d03380:	d301      	bcc.n	c0d03386 <__aeabi_idiv+0xf6>
c0d03382:	004b      	lsls	r3, r1, #1
c0d03384:	1ac0      	subs	r0, r0, r3
c0d03386:	4152      	adcs	r2, r2
c0d03388:	1a41      	subs	r1, r0, r1
c0d0338a:	d200      	bcs.n	c0d0338e <__aeabi_idiv+0xfe>
c0d0338c:	4601      	mov	r1, r0
c0d0338e:	4152      	adcs	r2, r2
c0d03390:	4610      	mov	r0, r2
c0d03392:	4770      	bx	lr
c0d03394:	e05d      	b.n	c0d03452 <__aeabi_idiv+0x1c2>
c0d03396:	0fca      	lsrs	r2, r1, #31
c0d03398:	d000      	beq.n	c0d0339c <__aeabi_idiv+0x10c>
c0d0339a:	4249      	negs	r1, r1
c0d0339c:	1003      	asrs	r3, r0, #32
c0d0339e:	d300      	bcc.n	c0d033a2 <__aeabi_idiv+0x112>
c0d033a0:	4240      	negs	r0, r0
c0d033a2:	4053      	eors	r3, r2
c0d033a4:	2200      	movs	r2, #0
c0d033a6:	469c      	mov	ip, r3
c0d033a8:	0903      	lsrs	r3, r0, #4
c0d033aa:	428b      	cmp	r3, r1
c0d033ac:	d32d      	bcc.n	c0d0340a <__aeabi_idiv+0x17a>
c0d033ae:	0a03      	lsrs	r3, r0, #8
c0d033b0:	428b      	cmp	r3, r1
c0d033b2:	d312      	bcc.n	c0d033da <__aeabi_idiv+0x14a>
c0d033b4:	22fc      	movs	r2, #252	; 0xfc
c0d033b6:	0189      	lsls	r1, r1, #6
c0d033b8:	ba12      	rev	r2, r2
c0d033ba:	0a03      	lsrs	r3, r0, #8
c0d033bc:	428b      	cmp	r3, r1
c0d033be:	d30c      	bcc.n	c0d033da <__aeabi_idiv+0x14a>
c0d033c0:	0189      	lsls	r1, r1, #6
c0d033c2:	1192      	asrs	r2, r2, #6
c0d033c4:	428b      	cmp	r3, r1
c0d033c6:	d308      	bcc.n	c0d033da <__aeabi_idiv+0x14a>
c0d033c8:	0189      	lsls	r1, r1, #6
c0d033ca:	1192      	asrs	r2, r2, #6
c0d033cc:	428b      	cmp	r3, r1
c0d033ce:	d304      	bcc.n	c0d033da <__aeabi_idiv+0x14a>
c0d033d0:	0189      	lsls	r1, r1, #6
c0d033d2:	d03a      	beq.n	c0d0344a <__aeabi_idiv+0x1ba>
c0d033d4:	1192      	asrs	r2, r2, #6
c0d033d6:	e000      	b.n	c0d033da <__aeabi_idiv+0x14a>
c0d033d8:	0989      	lsrs	r1, r1, #6
c0d033da:	09c3      	lsrs	r3, r0, #7
c0d033dc:	428b      	cmp	r3, r1
c0d033de:	d301      	bcc.n	c0d033e4 <__aeabi_idiv+0x154>
c0d033e0:	01cb      	lsls	r3, r1, #7
c0d033e2:	1ac0      	subs	r0, r0, r3
c0d033e4:	4152      	adcs	r2, r2
c0d033e6:	0983      	lsrs	r3, r0, #6
c0d033e8:	428b      	cmp	r3, r1
c0d033ea:	d301      	bcc.n	c0d033f0 <__aeabi_idiv+0x160>
c0d033ec:	018b      	lsls	r3, r1, #6
c0d033ee:	1ac0      	subs	r0, r0, r3
c0d033f0:	4152      	adcs	r2, r2
c0d033f2:	0943      	lsrs	r3, r0, #5
c0d033f4:	428b      	cmp	r3, r1
c0d033f6:	d301      	bcc.n	c0d033fc <__aeabi_idiv+0x16c>
c0d033f8:	014b      	lsls	r3, r1, #5
c0d033fa:	1ac0      	subs	r0, r0, r3
c0d033fc:	4152      	adcs	r2, r2
c0d033fe:	0903      	lsrs	r3, r0, #4
c0d03400:	428b      	cmp	r3, r1
c0d03402:	d301      	bcc.n	c0d03408 <__aeabi_idiv+0x178>
c0d03404:	010b      	lsls	r3, r1, #4
c0d03406:	1ac0      	subs	r0, r0, r3
c0d03408:	4152      	adcs	r2, r2
c0d0340a:	08c3      	lsrs	r3, r0, #3
c0d0340c:	428b      	cmp	r3, r1
c0d0340e:	d301      	bcc.n	c0d03414 <__aeabi_idiv+0x184>
c0d03410:	00cb      	lsls	r3, r1, #3
c0d03412:	1ac0      	subs	r0, r0, r3
c0d03414:	4152      	adcs	r2, r2
c0d03416:	0883      	lsrs	r3, r0, #2
c0d03418:	428b      	cmp	r3, r1
c0d0341a:	d301      	bcc.n	c0d03420 <__aeabi_idiv+0x190>
c0d0341c:	008b      	lsls	r3, r1, #2
c0d0341e:	1ac0      	subs	r0, r0, r3
c0d03420:	4152      	adcs	r2, r2
c0d03422:	d2d9      	bcs.n	c0d033d8 <__aeabi_idiv+0x148>
c0d03424:	0843      	lsrs	r3, r0, #1
c0d03426:	428b      	cmp	r3, r1
c0d03428:	d301      	bcc.n	c0d0342e <__aeabi_idiv+0x19e>
c0d0342a:	004b      	lsls	r3, r1, #1
c0d0342c:	1ac0      	subs	r0, r0, r3
c0d0342e:	4152      	adcs	r2, r2
c0d03430:	1a41      	subs	r1, r0, r1
c0d03432:	d200      	bcs.n	c0d03436 <__aeabi_idiv+0x1a6>
c0d03434:	4601      	mov	r1, r0
c0d03436:	4663      	mov	r3, ip
c0d03438:	4152      	adcs	r2, r2
c0d0343a:	105b      	asrs	r3, r3, #1
c0d0343c:	4610      	mov	r0, r2
c0d0343e:	d301      	bcc.n	c0d03444 <__aeabi_idiv+0x1b4>
c0d03440:	4240      	negs	r0, r0
c0d03442:	2b00      	cmp	r3, #0
c0d03444:	d500      	bpl.n	c0d03448 <__aeabi_idiv+0x1b8>
c0d03446:	4249      	negs	r1, r1
c0d03448:	4770      	bx	lr
c0d0344a:	4663      	mov	r3, ip
c0d0344c:	105b      	asrs	r3, r3, #1
c0d0344e:	d300      	bcc.n	c0d03452 <__aeabi_idiv+0x1c2>
c0d03450:	4240      	negs	r0, r0
c0d03452:	b501      	push	{r0, lr}
c0d03454:	2000      	movs	r0, #0
c0d03456:	f000 f805 	bl	c0d03464 <__aeabi_idiv0>
c0d0345a:	bd02      	pop	{r1, pc}

c0d0345c <__aeabi_idivmod>:
c0d0345c:	2900      	cmp	r1, #0
c0d0345e:	d0f8      	beq.n	c0d03452 <__aeabi_idiv+0x1c2>
c0d03460:	e716      	b.n	c0d03290 <__aeabi_idiv>
c0d03462:	4770      	bx	lr

c0d03464 <__aeabi_idiv0>:
c0d03464:	4770      	bx	lr
c0d03466:	46c0      	nop			; (mov r8, r8)

c0d03468 <__aeabi_uldivmod>:
c0d03468:	2b00      	cmp	r3, #0
c0d0346a:	d111      	bne.n	c0d03490 <__aeabi_uldivmod+0x28>
c0d0346c:	2a00      	cmp	r2, #0
c0d0346e:	d10f      	bne.n	c0d03490 <__aeabi_uldivmod+0x28>
c0d03470:	2900      	cmp	r1, #0
c0d03472:	d100      	bne.n	c0d03476 <__aeabi_uldivmod+0xe>
c0d03474:	2800      	cmp	r0, #0
c0d03476:	d002      	beq.n	c0d0347e <__aeabi_uldivmod+0x16>
c0d03478:	2100      	movs	r1, #0
c0d0347a:	43c9      	mvns	r1, r1
c0d0347c:	1c08      	adds	r0, r1, #0
c0d0347e:	b407      	push	{r0, r1, r2}
c0d03480:	4802      	ldr	r0, [pc, #8]	; (c0d0348c <__aeabi_uldivmod+0x24>)
c0d03482:	a102      	add	r1, pc, #8	; (adr r1, c0d0348c <__aeabi_uldivmod+0x24>)
c0d03484:	1840      	adds	r0, r0, r1
c0d03486:	9002      	str	r0, [sp, #8]
c0d03488:	bd03      	pop	{r0, r1, pc}
c0d0348a:	46c0      	nop			; (mov r8, r8)
c0d0348c:	ffffffd9 	.word	0xffffffd9
c0d03490:	b403      	push	{r0, r1}
c0d03492:	4668      	mov	r0, sp
c0d03494:	b501      	push	{r0, lr}
c0d03496:	9802      	ldr	r0, [sp, #8]
c0d03498:	f000 f806 	bl	c0d034a8 <__udivmoddi4>
c0d0349c:	9b01      	ldr	r3, [sp, #4]
c0d0349e:	469e      	mov	lr, r3
c0d034a0:	b002      	add	sp, #8
c0d034a2:	bc0c      	pop	{r2, r3}
c0d034a4:	4770      	bx	lr
c0d034a6:	46c0      	nop			; (mov r8, r8)

c0d034a8 <__udivmoddi4>:
c0d034a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d034aa:	464d      	mov	r5, r9
c0d034ac:	4656      	mov	r6, sl
c0d034ae:	4644      	mov	r4, r8
c0d034b0:	465f      	mov	r7, fp
c0d034b2:	b4f0      	push	{r4, r5, r6, r7}
c0d034b4:	4692      	mov	sl, r2
c0d034b6:	b083      	sub	sp, #12
c0d034b8:	0004      	movs	r4, r0
c0d034ba:	000d      	movs	r5, r1
c0d034bc:	4699      	mov	r9, r3
c0d034be:	428b      	cmp	r3, r1
c0d034c0:	d82f      	bhi.n	c0d03522 <__udivmoddi4+0x7a>
c0d034c2:	d02c      	beq.n	c0d0351e <__udivmoddi4+0x76>
c0d034c4:	4649      	mov	r1, r9
c0d034c6:	4650      	mov	r0, sl
c0d034c8:	f000 f8ae 	bl	c0d03628 <__clzdi2>
c0d034cc:	0029      	movs	r1, r5
c0d034ce:	0006      	movs	r6, r0
c0d034d0:	0020      	movs	r0, r4
c0d034d2:	f000 f8a9 	bl	c0d03628 <__clzdi2>
c0d034d6:	1a33      	subs	r3, r6, r0
c0d034d8:	4698      	mov	r8, r3
c0d034da:	3b20      	subs	r3, #32
c0d034dc:	469b      	mov	fp, r3
c0d034de:	d500      	bpl.n	c0d034e2 <__udivmoddi4+0x3a>
c0d034e0:	e074      	b.n	c0d035cc <__udivmoddi4+0x124>
c0d034e2:	4653      	mov	r3, sl
c0d034e4:	465a      	mov	r2, fp
c0d034e6:	4093      	lsls	r3, r2
c0d034e8:	001f      	movs	r7, r3
c0d034ea:	4653      	mov	r3, sl
c0d034ec:	4642      	mov	r2, r8
c0d034ee:	4093      	lsls	r3, r2
c0d034f0:	001e      	movs	r6, r3
c0d034f2:	42af      	cmp	r7, r5
c0d034f4:	d829      	bhi.n	c0d0354a <__udivmoddi4+0xa2>
c0d034f6:	d026      	beq.n	c0d03546 <__udivmoddi4+0x9e>
c0d034f8:	465b      	mov	r3, fp
c0d034fa:	1ba4      	subs	r4, r4, r6
c0d034fc:	41bd      	sbcs	r5, r7
c0d034fe:	2b00      	cmp	r3, #0
c0d03500:	da00      	bge.n	c0d03504 <__udivmoddi4+0x5c>
c0d03502:	e079      	b.n	c0d035f8 <__udivmoddi4+0x150>
c0d03504:	2200      	movs	r2, #0
c0d03506:	2300      	movs	r3, #0
c0d03508:	9200      	str	r2, [sp, #0]
c0d0350a:	9301      	str	r3, [sp, #4]
c0d0350c:	2301      	movs	r3, #1
c0d0350e:	465a      	mov	r2, fp
c0d03510:	4093      	lsls	r3, r2
c0d03512:	9301      	str	r3, [sp, #4]
c0d03514:	2301      	movs	r3, #1
c0d03516:	4642      	mov	r2, r8
c0d03518:	4093      	lsls	r3, r2
c0d0351a:	9300      	str	r3, [sp, #0]
c0d0351c:	e019      	b.n	c0d03552 <__udivmoddi4+0xaa>
c0d0351e:	4282      	cmp	r2, r0
c0d03520:	d9d0      	bls.n	c0d034c4 <__udivmoddi4+0x1c>
c0d03522:	2200      	movs	r2, #0
c0d03524:	2300      	movs	r3, #0
c0d03526:	9200      	str	r2, [sp, #0]
c0d03528:	9301      	str	r3, [sp, #4]
c0d0352a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d0352c:	2b00      	cmp	r3, #0
c0d0352e:	d001      	beq.n	c0d03534 <__udivmoddi4+0x8c>
c0d03530:	601c      	str	r4, [r3, #0]
c0d03532:	605d      	str	r5, [r3, #4]
c0d03534:	9800      	ldr	r0, [sp, #0]
c0d03536:	9901      	ldr	r1, [sp, #4]
c0d03538:	b003      	add	sp, #12
c0d0353a:	bc3c      	pop	{r2, r3, r4, r5}
c0d0353c:	4690      	mov	r8, r2
c0d0353e:	4699      	mov	r9, r3
c0d03540:	46a2      	mov	sl, r4
c0d03542:	46ab      	mov	fp, r5
c0d03544:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03546:	42a3      	cmp	r3, r4
c0d03548:	d9d6      	bls.n	c0d034f8 <__udivmoddi4+0x50>
c0d0354a:	2200      	movs	r2, #0
c0d0354c:	2300      	movs	r3, #0
c0d0354e:	9200      	str	r2, [sp, #0]
c0d03550:	9301      	str	r3, [sp, #4]
c0d03552:	4643      	mov	r3, r8
c0d03554:	2b00      	cmp	r3, #0
c0d03556:	d0e8      	beq.n	c0d0352a <__udivmoddi4+0x82>
c0d03558:	07fb      	lsls	r3, r7, #31
c0d0355a:	0872      	lsrs	r2, r6, #1
c0d0355c:	431a      	orrs	r2, r3
c0d0355e:	4646      	mov	r6, r8
c0d03560:	087b      	lsrs	r3, r7, #1
c0d03562:	e00e      	b.n	c0d03582 <__udivmoddi4+0xda>
c0d03564:	42ab      	cmp	r3, r5
c0d03566:	d101      	bne.n	c0d0356c <__udivmoddi4+0xc4>
c0d03568:	42a2      	cmp	r2, r4
c0d0356a:	d80c      	bhi.n	c0d03586 <__udivmoddi4+0xde>
c0d0356c:	1aa4      	subs	r4, r4, r2
c0d0356e:	419d      	sbcs	r5, r3
c0d03570:	2001      	movs	r0, #1
c0d03572:	1924      	adds	r4, r4, r4
c0d03574:	416d      	adcs	r5, r5
c0d03576:	2100      	movs	r1, #0
c0d03578:	3e01      	subs	r6, #1
c0d0357a:	1824      	adds	r4, r4, r0
c0d0357c:	414d      	adcs	r5, r1
c0d0357e:	2e00      	cmp	r6, #0
c0d03580:	d006      	beq.n	c0d03590 <__udivmoddi4+0xe8>
c0d03582:	42ab      	cmp	r3, r5
c0d03584:	d9ee      	bls.n	c0d03564 <__udivmoddi4+0xbc>
c0d03586:	3e01      	subs	r6, #1
c0d03588:	1924      	adds	r4, r4, r4
c0d0358a:	416d      	adcs	r5, r5
c0d0358c:	2e00      	cmp	r6, #0
c0d0358e:	d1f8      	bne.n	c0d03582 <__udivmoddi4+0xda>
c0d03590:	465b      	mov	r3, fp
c0d03592:	9800      	ldr	r0, [sp, #0]
c0d03594:	9901      	ldr	r1, [sp, #4]
c0d03596:	1900      	adds	r0, r0, r4
c0d03598:	4169      	adcs	r1, r5
c0d0359a:	2b00      	cmp	r3, #0
c0d0359c:	db22      	blt.n	c0d035e4 <__udivmoddi4+0x13c>
c0d0359e:	002b      	movs	r3, r5
c0d035a0:	465a      	mov	r2, fp
c0d035a2:	40d3      	lsrs	r3, r2
c0d035a4:	002a      	movs	r2, r5
c0d035a6:	4644      	mov	r4, r8
c0d035a8:	40e2      	lsrs	r2, r4
c0d035aa:	001c      	movs	r4, r3
c0d035ac:	465b      	mov	r3, fp
c0d035ae:	0015      	movs	r5, r2
c0d035b0:	2b00      	cmp	r3, #0
c0d035b2:	db2c      	blt.n	c0d0360e <__udivmoddi4+0x166>
c0d035b4:	0026      	movs	r6, r4
c0d035b6:	409e      	lsls	r6, r3
c0d035b8:	0033      	movs	r3, r6
c0d035ba:	0026      	movs	r6, r4
c0d035bc:	4647      	mov	r7, r8
c0d035be:	40be      	lsls	r6, r7
c0d035c0:	0032      	movs	r2, r6
c0d035c2:	1a80      	subs	r0, r0, r2
c0d035c4:	4199      	sbcs	r1, r3
c0d035c6:	9000      	str	r0, [sp, #0]
c0d035c8:	9101      	str	r1, [sp, #4]
c0d035ca:	e7ae      	b.n	c0d0352a <__udivmoddi4+0x82>
c0d035cc:	4642      	mov	r2, r8
c0d035ce:	2320      	movs	r3, #32
c0d035d0:	1a9b      	subs	r3, r3, r2
c0d035d2:	4652      	mov	r2, sl
c0d035d4:	40da      	lsrs	r2, r3
c0d035d6:	4641      	mov	r1, r8
c0d035d8:	0013      	movs	r3, r2
c0d035da:	464a      	mov	r2, r9
c0d035dc:	408a      	lsls	r2, r1
c0d035de:	0017      	movs	r7, r2
c0d035e0:	431f      	orrs	r7, r3
c0d035e2:	e782      	b.n	c0d034ea <__udivmoddi4+0x42>
c0d035e4:	4642      	mov	r2, r8
c0d035e6:	2320      	movs	r3, #32
c0d035e8:	1a9b      	subs	r3, r3, r2
c0d035ea:	002a      	movs	r2, r5
c0d035ec:	4646      	mov	r6, r8
c0d035ee:	409a      	lsls	r2, r3
c0d035f0:	0023      	movs	r3, r4
c0d035f2:	40f3      	lsrs	r3, r6
c0d035f4:	4313      	orrs	r3, r2
c0d035f6:	e7d5      	b.n	c0d035a4 <__udivmoddi4+0xfc>
c0d035f8:	4642      	mov	r2, r8
c0d035fa:	2320      	movs	r3, #32
c0d035fc:	2100      	movs	r1, #0
c0d035fe:	1a9b      	subs	r3, r3, r2
c0d03600:	2200      	movs	r2, #0
c0d03602:	9100      	str	r1, [sp, #0]
c0d03604:	9201      	str	r2, [sp, #4]
c0d03606:	2201      	movs	r2, #1
c0d03608:	40da      	lsrs	r2, r3
c0d0360a:	9201      	str	r2, [sp, #4]
c0d0360c:	e782      	b.n	c0d03514 <__udivmoddi4+0x6c>
c0d0360e:	4642      	mov	r2, r8
c0d03610:	2320      	movs	r3, #32
c0d03612:	0026      	movs	r6, r4
c0d03614:	1a9b      	subs	r3, r3, r2
c0d03616:	40de      	lsrs	r6, r3
c0d03618:	002f      	movs	r7, r5
c0d0361a:	46b4      	mov	ip, r6
c0d0361c:	4097      	lsls	r7, r2
c0d0361e:	4666      	mov	r6, ip
c0d03620:	003b      	movs	r3, r7
c0d03622:	4333      	orrs	r3, r6
c0d03624:	e7c9      	b.n	c0d035ba <__udivmoddi4+0x112>
c0d03626:	46c0      	nop			; (mov r8, r8)

c0d03628 <__clzdi2>:
c0d03628:	b510      	push	{r4, lr}
c0d0362a:	2900      	cmp	r1, #0
c0d0362c:	d103      	bne.n	c0d03636 <__clzdi2+0xe>
c0d0362e:	f000 f807 	bl	c0d03640 <__clzsi2>
c0d03632:	3020      	adds	r0, #32
c0d03634:	e002      	b.n	c0d0363c <__clzdi2+0x14>
c0d03636:	1c08      	adds	r0, r1, #0
c0d03638:	f000 f802 	bl	c0d03640 <__clzsi2>
c0d0363c:	bd10      	pop	{r4, pc}
c0d0363e:	46c0      	nop			; (mov r8, r8)

c0d03640 <__clzsi2>:
c0d03640:	211c      	movs	r1, #28
c0d03642:	2301      	movs	r3, #1
c0d03644:	041b      	lsls	r3, r3, #16
c0d03646:	4298      	cmp	r0, r3
c0d03648:	d301      	bcc.n	c0d0364e <__clzsi2+0xe>
c0d0364a:	0c00      	lsrs	r0, r0, #16
c0d0364c:	3910      	subs	r1, #16
c0d0364e:	0a1b      	lsrs	r3, r3, #8
c0d03650:	4298      	cmp	r0, r3
c0d03652:	d301      	bcc.n	c0d03658 <__clzsi2+0x18>
c0d03654:	0a00      	lsrs	r0, r0, #8
c0d03656:	3908      	subs	r1, #8
c0d03658:	091b      	lsrs	r3, r3, #4
c0d0365a:	4298      	cmp	r0, r3
c0d0365c:	d301      	bcc.n	c0d03662 <__clzsi2+0x22>
c0d0365e:	0900      	lsrs	r0, r0, #4
c0d03660:	3904      	subs	r1, #4
c0d03662:	a202      	add	r2, pc, #8	; (adr r2, c0d0366c <__clzsi2+0x2c>)
c0d03664:	5c10      	ldrb	r0, [r2, r0]
c0d03666:	1840      	adds	r0, r0, r1
c0d03668:	4770      	bx	lr
c0d0366a:	46c0      	nop			; (mov r8, r8)
c0d0366c:	02020304 	.word	0x02020304
c0d03670:	01010101 	.word	0x01010101
	...

c0d0367c <__aeabi_memclr>:
c0d0367c:	b510      	push	{r4, lr}
c0d0367e:	2200      	movs	r2, #0
c0d03680:	f000 f806 	bl	c0d03690 <__aeabi_memset>
c0d03684:	bd10      	pop	{r4, pc}
c0d03686:	46c0      	nop			; (mov r8, r8)

c0d03688 <__aeabi_memcpy>:
c0d03688:	b510      	push	{r4, lr}
c0d0368a:	f000 f809 	bl	c0d036a0 <memcpy>
c0d0368e:	bd10      	pop	{r4, pc}

c0d03690 <__aeabi_memset>:
c0d03690:	0013      	movs	r3, r2
c0d03692:	b510      	push	{r4, lr}
c0d03694:	000a      	movs	r2, r1
c0d03696:	0019      	movs	r1, r3
c0d03698:	f000 f840 	bl	c0d0371c <memset>
c0d0369c:	bd10      	pop	{r4, pc}
c0d0369e:	46c0      	nop			; (mov r8, r8)

c0d036a0 <memcpy>:
c0d036a0:	b570      	push	{r4, r5, r6, lr}
c0d036a2:	2a0f      	cmp	r2, #15
c0d036a4:	d932      	bls.n	c0d0370c <memcpy+0x6c>
c0d036a6:	000c      	movs	r4, r1
c0d036a8:	4304      	orrs	r4, r0
c0d036aa:	000b      	movs	r3, r1
c0d036ac:	07a4      	lsls	r4, r4, #30
c0d036ae:	d131      	bne.n	c0d03714 <memcpy+0x74>
c0d036b0:	0015      	movs	r5, r2
c0d036b2:	0004      	movs	r4, r0
c0d036b4:	3d10      	subs	r5, #16
c0d036b6:	092d      	lsrs	r5, r5, #4
c0d036b8:	3501      	adds	r5, #1
c0d036ba:	012d      	lsls	r5, r5, #4
c0d036bc:	1949      	adds	r1, r1, r5
c0d036be:	681e      	ldr	r6, [r3, #0]
c0d036c0:	6026      	str	r6, [r4, #0]
c0d036c2:	685e      	ldr	r6, [r3, #4]
c0d036c4:	6066      	str	r6, [r4, #4]
c0d036c6:	689e      	ldr	r6, [r3, #8]
c0d036c8:	60a6      	str	r6, [r4, #8]
c0d036ca:	68de      	ldr	r6, [r3, #12]
c0d036cc:	3310      	adds	r3, #16
c0d036ce:	60e6      	str	r6, [r4, #12]
c0d036d0:	3410      	adds	r4, #16
c0d036d2:	4299      	cmp	r1, r3
c0d036d4:	d1f3      	bne.n	c0d036be <memcpy+0x1e>
c0d036d6:	230f      	movs	r3, #15
c0d036d8:	1945      	adds	r5, r0, r5
c0d036da:	4013      	ands	r3, r2
c0d036dc:	2b03      	cmp	r3, #3
c0d036de:	d91b      	bls.n	c0d03718 <memcpy+0x78>
c0d036e0:	1f1c      	subs	r4, r3, #4
c0d036e2:	2300      	movs	r3, #0
c0d036e4:	08a4      	lsrs	r4, r4, #2
c0d036e6:	3401      	adds	r4, #1
c0d036e8:	00a4      	lsls	r4, r4, #2
c0d036ea:	58ce      	ldr	r6, [r1, r3]
c0d036ec:	50ee      	str	r6, [r5, r3]
c0d036ee:	3304      	adds	r3, #4
c0d036f0:	429c      	cmp	r4, r3
c0d036f2:	d1fa      	bne.n	c0d036ea <memcpy+0x4a>
c0d036f4:	2303      	movs	r3, #3
c0d036f6:	192d      	adds	r5, r5, r4
c0d036f8:	1909      	adds	r1, r1, r4
c0d036fa:	401a      	ands	r2, r3
c0d036fc:	d005      	beq.n	c0d0370a <memcpy+0x6a>
c0d036fe:	2300      	movs	r3, #0
c0d03700:	5ccc      	ldrb	r4, [r1, r3]
c0d03702:	54ec      	strb	r4, [r5, r3]
c0d03704:	3301      	adds	r3, #1
c0d03706:	429a      	cmp	r2, r3
c0d03708:	d1fa      	bne.n	c0d03700 <memcpy+0x60>
c0d0370a:	bd70      	pop	{r4, r5, r6, pc}
c0d0370c:	0005      	movs	r5, r0
c0d0370e:	2a00      	cmp	r2, #0
c0d03710:	d1f5      	bne.n	c0d036fe <memcpy+0x5e>
c0d03712:	e7fa      	b.n	c0d0370a <memcpy+0x6a>
c0d03714:	0005      	movs	r5, r0
c0d03716:	e7f2      	b.n	c0d036fe <memcpy+0x5e>
c0d03718:	001a      	movs	r2, r3
c0d0371a:	e7f8      	b.n	c0d0370e <memcpy+0x6e>

c0d0371c <memset>:
c0d0371c:	b570      	push	{r4, r5, r6, lr}
c0d0371e:	0783      	lsls	r3, r0, #30
c0d03720:	d03f      	beq.n	c0d037a2 <memset+0x86>
c0d03722:	1e54      	subs	r4, r2, #1
c0d03724:	2a00      	cmp	r2, #0
c0d03726:	d03b      	beq.n	c0d037a0 <memset+0x84>
c0d03728:	b2ce      	uxtb	r6, r1
c0d0372a:	0003      	movs	r3, r0
c0d0372c:	2503      	movs	r5, #3
c0d0372e:	e003      	b.n	c0d03738 <memset+0x1c>
c0d03730:	1e62      	subs	r2, r4, #1
c0d03732:	2c00      	cmp	r4, #0
c0d03734:	d034      	beq.n	c0d037a0 <memset+0x84>
c0d03736:	0014      	movs	r4, r2
c0d03738:	3301      	adds	r3, #1
c0d0373a:	1e5a      	subs	r2, r3, #1
c0d0373c:	7016      	strb	r6, [r2, #0]
c0d0373e:	422b      	tst	r3, r5
c0d03740:	d1f6      	bne.n	c0d03730 <memset+0x14>
c0d03742:	2c03      	cmp	r4, #3
c0d03744:	d924      	bls.n	c0d03790 <memset+0x74>
c0d03746:	25ff      	movs	r5, #255	; 0xff
c0d03748:	400d      	ands	r5, r1
c0d0374a:	022a      	lsls	r2, r5, #8
c0d0374c:	4315      	orrs	r5, r2
c0d0374e:	042a      	lsls	r2, r5, #16
c0d03750:	4315      	orrs	r5, r2
c0d03752:	2c0f      	cmp	r4, #15
c0d03754:	d911      	bls.n	c0d0377a <memset+0x5e>
c0d03756:	0026      	movs	r6, r4
c0d03758:	3e10      	subs	r6, #16
c0d0375a:	0936      	lsrs	r6, r6, #4
c0d0375c:	3601      	adds	r6, #1
c0d0375e:	0136      	lsls	r6, r6, #4
c0d03760:	001a      	movs	r2, r3
c0d03762:	199b      	adds	r3, r3, r6
c0d03764:	6015      	str	r5, [r2, #0]
c0d03766:	6055      	str	r5, [r2, #4]
c0d03768:	6095      	str	r5, [r2, #8]
c0d0376a:	60d5      	str	r5, [r2, #12]
c0d0376c:	3210      	adds	r2, #16
c0d0376e:	4293      	cmp	r3, r2
c0d03770:	d1f8      	bne.n	c0d03764 <memset+0x48>
c0d03772:	220f      	movs	r2, #15
c0d03774:	4014      	ands	r4, r2
c0d03776:	2c03      	cmp	r4, #3
c0d03778:	d90a      	bls.n	c0d03790 <memset+0x74>
c0d0377a:	1f26      	subs	r6, r4, #4
c0d0377c:	08b6      	lsrs	r6, r6, #2
c0d0377e:	3601      	adds	r6, #1
c0d03780:	00b6      	lsls	r6, r6, #2
c0d03782:	001a      	movs	r2, r3
c0d03784:	199b      	adds	r3, r3, r6
c0d03786:	c220      	stmia	r2!, {r5}
c0d03788:	4293      	cmp	r3, r2
c0d0378a:	d1fc      	bne.n	c0d03786 <memset+0x6a>
c0d0378c:	2203      	movs	r2, #3
c0d0378e:	4014      	ands	r4, r2
c0d03790:	2c00      	cmp	r4, #0
c0d03792:	d005      	beq.n	c0d037a0 <memset+0x84>
c0d03794:	b2c9      	uxtb	r1, r1
c0d03796:	191c      	adds	r4, r3, r4
c0d03798:	7019      	strb	r1, [r3, #0]
c0d0379a:	3301      	adds	r3, #1
c0d0379c:	429c      	cmp	r4, r3
c0d0379e:	d1fb      	bne.n	c0d03798 <memset+0x7c>
c0d037a0:	bd70      	pop	{r4, r5, r6, pc}
c0d037a2:	0014      	movs	r4, r2
c0d037a4:	0003      	movs	r3, r0
c0d037a6:	e7cc      	b.n	c0d03742 <memset+0x26>

c0d037a8 <setjmp>:
c0d037a8:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d037aa:	4641      	mov	r1, r8
c0d037ac:	464a      	mov	r2, r9
c0d037ae:	4653      	mov	r3, sl
c0d037b0:	465c      	mov	r4, fp
c0d037b2:	466d      	mov	r5, sp
c0d037b4:	4676      	mov	r6, lr
c0d037b6:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d037b8:	3828      	subs	r0, #40	; 0x28
c0d037ba:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d037bc:	2000      	movs	r0, #0
c0d037be:	4770      	bx	lr

c0d037c0 <longjmp>:
c0d037c0:	3010      	adds	r0, #16
c0d037c2:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d037c4:	4690      	mov	r8, r2
c0d037c6:	4699      	mov	r9, r3
c0d037c8:	46a2      	mov	sl, r4
c0d037ca:	46ab      	mov	fp, r5
c0d037cc:	46b5      	mov	sp, r6
c0d037ce:	c808      	ldmia	r0!, {r3}
c0d037d0:	3828      	subs	r0, #40	; 0x28
c0d037d2:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d037d4:	1c08      	adds	r0, r1, #0
c0d037d6:	d100      	bne.n	c0d037da <longjmp+0x1a>
c0d037d8:	2001      	movs	r0, #1
c0d037da:	4718      	bx	r3

c0d037dc <strlen>:
c0d037dc:	b510      	push	{r4, lr}
c0d037de:	0783      	lsls	r3, r0, #30
c0d037e0:	d027      	beq.n	c0d03832 <strlen+0x56>
c0d037e2:	7803      	ldrb	r3, [r0, #0]
c0d037e4:	2b00      	cmp	r3, #0
c0d037e6:	d026      	beq.n	c0d03836 <strlen+0x5a>
c0d037e8:	0003      	movs	r3, r0
c0d037ea:	2103      	movs	r1, #3
c0d037ec:	e002      	b.n	c0d037f4 <strlen+0x18>
c0d037ee:	781a      	ldrb	r2, [r3, #0]
c0d037f0:	2a00      	cmp	r2, #0
c0d037f2:	d01c      	beq.n	c0d0382e <strlen+0x52>
c0d037f4:	3301      	adds	r3, #1
c0d037f6:	420b      	tst	r3, r1
c0d037f8:	d1f9      	bne.n	c0d037ee <strlen+0x12>
c0d037fa:	6819      	ldr	r1, [r3, #0]
c0d037fc:	4a0f      	ldr	r2, [pc, #60]	; (c0d0383c <strlen+0x60>)
c0d037fe:	4c10      	ldr	r4, [pc, #64]	; (c0d03840 <strlen+0x64>)
c0d03800:	188a      	adds	r2, r1, r2
c0d03802:	438a      	bics	r2, r1
c0d03804:	4222      	tst	r2, r4
c0d03806:	d10f      	bne.n	c0d03828 <strlen+0x4c>
c0d03808:	3304      	adds	r3, #4
c0d0380a:	6819      	ldr	r1, [r3, #0]
c0d0380c:	4a0b      	ldr	r2, [pc, #44]	; (c0d0383c <strlen+0x60>)
c0d0380e:	188a      	adds	r2, r1, r2
c0d03810:	438a      	bics	r2, r1
c0d03812:	4222      	tst	r2, r4
c0d03814:	d108      	bne.n	c0d03828 <strlen+0x4c>
c0d03816:	3304      	adds	r3, #4
c0d03818:	6819      	ldr	r1, [r3, #0]
c0d0381a:	4a08      	ldr	r2, [pc, #32]	; (c0d0383c <strlen+0x60>)
c0d0381c:	188a      	adds	r2, r1, r2
c0d0381e:	438a      	bics	r2, r1
c0d03820:	4222      	tst	r2, r4
c0d03822:	d0f1      	beq.n	c0d03808 <strlen+0x2c>
c0d03824:	e000      	b.n	c0d03828 <strlen+0x4c>
c0d03826:	3301      	adds	r3, #1
c0d03828:	781a      	ldrb	r2, [r3, #0]
c0d0382a:	2a00      	cmp	r2, #0
c0d0382c:	d1fb      	bne.n	c0d03826 <strlen+0x4a>
c0d0382e:	1a18      	subs	r0, r3, r0
c0d03830:	bd10      	pop	{r4, pc}
c0d03832:	0003      	movs	r3, r0
c0d03834:	e7e1      	b.n	c0d037fa <strlen+0x1e>
c0d03836:	2000      	movs	r0, #0
c0d03838:	e7fa      	b.n	c0d03830 <strlen+0x54>
c0d0383a:	46c0      	nop			; (mov r8, r8)
c0d0383c:	fefefeff 	.word	0xfefefeff
c0d03840:	80808080 	.word	0x80808080

c0d03844 <HALF_3>:
c0d03844:	f16b9c2d dd01633c 3d8cf0ee b09a028b     -.k.<c.....=....
c0d03854:	246cd94a f1c6d805 6cee5506 da330aa3     J.l$.....U.l..3.
c0d03864:	fde381a1 fe13f810 f97f039e 1b3dc3ce     ..............=.
c0d03874:	00000001                                ....

c0d03878 <bagl_ui_nanos_screen1>:
c0d03878:	00000003 00800000 00000020 00000001     ........ .......
c0d03888:	00000000 00ffffff 00000000 00000000     ................
	...
c0d038b0:	00000107 0080000c 00000020 00000000     ........ .......
c0d038c0:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d038e8:	00030005 0007000c 00000007 00000000     ................
	...
c0d03900:	00070000 00000000 00000000 00000000     ................
	...
c0d03920:	00750005 0008000d 00000006 00000000     ..u.............
c0d03930:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03958 <bagl_ui_nanos_screen2>:
c0d03958:	00000003 00800000 00000020 00000001     ........ .......
c0d03968:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03990:	00000107 00800012 00000020 00000000     ........ .......
c0d039a0:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d039c8:	00030005 0007000c 00000007 00000000     ................
	...
c0d039e0:	00070000 00000000 00000000 00000000     ................
	...
c0d03a00:	00750005 0008000d 00000006 00000000     ..u.............
c0d03a10:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03a38 <bagl_ui_sample_blue>:
c0d03a38:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03a48:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03a70:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03a80:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03aa8:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03ab8:	00ffffff 001d2028 00002004 c0d03b18     ....( ... ...;..
	...
c0d03ae0:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03af0:	0041ccb4 00f9f9f9 0000a004 c0d03b24     ..A.........$;..
c0d03b00:	00000000 0037ae99 00f9f9f9 c0d0244d     ......7.....M$..
	...
c0d03b18:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03b29 <USBD_PRODUCT_FS_STRING>:
c0d03b29:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d03b37 <HID_ReportDesc>:
c0d03b37:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d03b47:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d03b57:	0000c008 11210900                                .....

c0d03b5c <USBD_HID_Desc>:
c0d03b5c:	01112109 22220100 00011200                       .!...."".

c0d03b65 <USBD_DeviceDesc>:
c0d03b65:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03b75:	5d000103                                         ...

c0d03b78 <HID_Desc>:
c0d03b78:	c0d0305d c0d0306d c0d0307d c0d0308d     ]0..m0..}0...0..
c0d03b88:	c0d0309d c0d030ad c0d030bd 00000000     .0...0...0......

c0d03b98 <USBD_LangIDDesc>:
c0d03b98:	04090304                                ....

c0d03b9c <USBD_MANUFACTURER_STRING>:
c0d03b9c:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03baa <USB_SERIAL_STRING>:
c0d03baa:	0030030a 00300030 2f3f0031                       ..0.0.0.1.

c0d03bb4 <USBD_HID>:
c0d03bb4:	c0d02f3f c0d02f71 c0d02ea3 00000000     ?/..q/..........
	...
c0d03bcc:	c0d02fa9 00000000 00000000 00000000     ./..............
c0d03bdc:	c0d030cd c0d030cd c0d030cd c0d030dd     .0...0...0...0..

c0d03bec <USBD_CfgDesc>:
c0d03bec:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03bfc:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03c0c:	05070100 00400302 00000001              ......@.....

c0d03c18 <USBD_DeviceQualifierDesc>:
c0d03c18:	0200060a 40000000 00000001              .......@....

c0d03c24 <_etext>:
	...

c0d03c40 <N_storage_real>:
	...
