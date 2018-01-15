
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
    
    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

__attribute__((section(".boot"))) int main(void) {
c0d00000:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00002:	af03      	add	r7, sp, #12
c0d00004:	b0a3      	sub	sp, #140	; 0x8c
    // exit critical section
    __asm volatile("cpsie i");
c0d00006:	b662      	cpsie	i
    
    hashTainted = 1;
c0d00008:	4827      	ldr	r0, [pc, #156]	; (c0d000a8 <main+0xa8>)
c0d0000a:	2101      	movs	r1, #1
c0d0000c:	9100      	str	r1, [sp, #0]
c0d0000e:	7001      	strb	r1, [r0, #0]
    
    UX_INIT();
c0d00010:	4826      	ldr	r0, [pc, #152]	; (c0d000ac <main+0xac>)
c0d00012:	2400      	movs	r4, #0
c0d00014:	22b0      	movs	r2, #176	; 0xb0
c0d00016:	4621      	mov	r1, r4
c0d00018:	f001 f9da 	bl	c0d013d0 <os_memset>
    
    // ensure exception will work as planned
    os_boot();
c0d0001c:	f001 f926 	bl	c0d0126c <os_boot>
    
    BEGIN_TRY {
        TRY {
c0d00020:	4e23      	ldr	r6, [pc, #140]	; (c0d000b0 <main+0xb0>)
c0d00022:	6830      	ldr	r0, [r6, #0]
c0d00024:	9021      	str	r0, [sp, #132]	; 0x84
c0d00026:	ad17      	add	r5, sp, #92	; 0x5c
c0d00028:	4628      	mov	r0, r5
c0d0002a:	f003 fd7d 	bl	c0d03b28 <setjmp>
c0d0002e:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d00030:	6035      	str	r5, [r6, #0]
c0d00032:	4635      	mov	r5, r6
c0d00034:	491f      	ldr	r1, [pc, #124]	; (c0d000b4 <main+0xb4>)
c0d00036:	4208      	tst	r0, r1
c0d00038:	d005      	beq.n	c0d00046 <main+0x46>
c0d0003a:	a817      	add	r0, sp, #92	; 0x5c
            
            ui_idle();
            
            IOTA_main();
        }
        CATCH_OTHER(e) {
c0d0003c:	2100      	movs	r1, #0
c0d0003e:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d00040:	9821      	ldr	r0, [sp, #132]	; 0x84
        }
        FINALLY {
c0d00042:	6028      	str	r0, [r5, #0]
c0d00044:	e02a      	b.n	c0d0009c <main+0x9c>
c0d00046:	4626      	mov	r6, r4
c0d00048:	9c00      	ldr	r4, [sp, #0]
    // ensure exception will work as planned
    os_boot();
    
    BEGIN_TRY {
        TRY {
            io_seproxyhal_init();
c0d0004a:	f001 fb67 	bl	c0d0171c <io_seproxyhal_init>
            
            if (N_storage.initialized != 0x01) {
c0d0004e:	481a      	ldr	r0, [pc, #104]	; (c0d000b8 <main+0xb8>)
c0d00050:	f002 f848 	bl	c0d020e4 <pic>
c0d00054:	7800      	ldrb	r0, [r0, #0]
c0d00056:	2801      	cmp	r0, #1
c0d00058:	d00a      	beq.n	c0d00070 <main+0x70>
c0d0005a:	ad01      	add	r5, sp, #4
                internalStorage_t storage;
                storage.initialized = 0x01;
c0d0005c:	702c      	strb	r4, [r5, #0]
                storage.seed_key = 0;
c0d0005e:	9616      	str	r6, [sp, #88]	; 0x58
                
                nvm_write(&N_storage, (void *)&storage,
c0d00060:	4815      	ldr	r0, [pc, #84]	; (c0d000b8 <main+0xb8>)
c0d00062:	f002 f83f 	bl	c0d020e4 <pic>
c0d00066:	2258      	movs	r2, #88	; 0x58
c0d00068:	4629      	mov	r1, r5
c0d0006a:	4d11      	ldr	r5, [pc, #68]	; (c0d000b0 <main+0xb0>)
c0d0006c:	f002 f88c 	bl	c0d02188 <nvm_write>
                          sizeof(internalStorage_t));
            }
            
            global_seed_key = N_storage.seed_key;
c0d00070:	4811      	ldr	r0, [pc, #68]	; (c0d000b8 <main+0xb8>)
c0d00072:	f002 f837 	bl	c0d020e4 <pic>
c0d00076:	6d40      	ldr	r0, [r0, #84]	; 0x54
c0d00078:	4910      	ldr	r1, [pc, #64]	; (c0d000bc <main+0xbc>)
c0d0007a:	6008      	str	r0, [r1, #0]
c0d0007c:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif
            
            USB_power(0);
c0d0007e:	f003 f97f 	bl	c0d03380 <USB_power>
            USB_power(1);
c0d00082:	2001      	movs	r0, #1
c0d00084:	f003 f97c 	bl	c0d03380 <USB_power>
            
            ui_idle();
c0d00088:	f002 fb10 	bl	c0d026ac <ui_idle>
            
            IOTA_main();
c0d0008c:	f000 fef8 	bl	c0d00e80 <IOTA_main>
c0d00090:	a817      	add	r0, sp, #92	; 0x5c
c0d00092:	8d81      	ldrh	r1, [r0, #44]	; 0x2c
c0d00094:	9821      	ldr	r0, [sp, #132]	; 0x84
        }
        CATCH_OTHER(e) {
        }
        FINALLY {
c0d00096:	6028      	str	r0, [r5, #0]
        }
    }
    END_TRY;
c0d00098:	2900      	cmp	r1, #0
c0d0009a:	d102      	bne.n	c0d000a2 <main+0xa2>
}
c0d0009c:	2000      	movs	r0, #0
c0d0009e:	b023      	add	sp, #140	; 0x8c
c0d000a0:	bdf0      	pop	{r4, r5, r6, r7, pc}
        CATCH_OTHER(e) {
        }
        FINALLY {
        }
    }
    END_TRY;
c0d000a2:	f003 fd4d 	bl	c0d03b40 <longjmp>
c0d000a6:	46c0      	nop			; (mov r8, r8)
c0d000a8:	20001b08 	.word	0x20001b08
c0d000ac:	20001a58 	.word	0x20001a58
c0d000b0:	20001b7c 	.word	0x20001b7c
c0d000b4:	0000ffff 	.word	0x0000ffff
c0d000b8:	c0d03f00 	.word	0xc0d03f00
c0d000bc:	20001b0c 	.word	0x20001b0c

c0d000c0 <add_index_to_seed_trints>:
// TODO: make sure we can add more index than uint32
// This may be an area where it's better just to have the seed in trits
// while adding index, then convert to trints later.
// Similarly is there no faster way to incr ??
int add_index_to_seed_trints(int8_t *trints, uint32_t index)
{
c0d000c0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d000c2:	af03      	add	r7, sp, #12
c0d000c4:	b089      	sub	sp, #36	; 0x24
c0d000c6:	9005      	str	r0, [sp, #20]
c0d000c8:	9102      	str	r1, [sp, #8]
    int8_t trits[5];
    uint8_t send = 5;

    for (uint32_t i = 0; i < index; i++) {
c0d000ca:	2900      	cmp	r1, #0
c0d000cc:	d05a      	beq.n	c0d00184 <add_index_to_seed_trints+0xc4>
c0d000ce:	2005      	movs	r0, #5
c0d000d0:	9004      	str	r0, [sp, #16]
c0d000d2:	2000      	movs	r0, #0
c0d000d4:	9001      	str	r0, [sp, #4]
c0d000d6:	4601      	mov	r1, r0
c0d000d8:	9103      	str	r1, [sp, #12]
c0d000da:	9c01      	ldr	r4, [sp, #4]
        // Add one
        uint8_t offset = 0;
        bool carry = true;
        while(carry && offset < 243) {
            if(offset % 5 == 0) {// we need a new set of trits
c0d000dc:	b2e0      	uxtb	r0, r4
c0d000de:	2605      	movs	r6, #5
c0d000e0:	9006      	str	r0, [sp, #24]
c0d000e2:	4631      	mov	r1, r6
c0d000e4:	f003 fa90 	bl	c0d03608 <__aeabi_uidivmod>
c0d000e8:	460d      	mov	r5, r1
c0d000ea:	2d00      	cmp	r5, #0
c0d000ec:	d122      	bne.n	c0d00134 <add_index_to_seed_trints+0x74>
                //if offset/5 == 48 we are on last trint of only 3
                // this would be equivalent to if offset == 240;
                send = (offset/5 == 48) ? 3 : 5;
c0d000ee:	4620      	mov	r0, r4
c0d000f0:	3010      	adds	r0, #16
c0d000f2:	b2c0      	uxtb	r0, r0
c0d000f4:	2203      	movs	r2, #3
c0d000f6:	2805      	cmp	r0, #5
c0d000f8:	d300      	bcc.n	c0d000fc <add_index_to_seed_trints+0x3c>
c0d000fa:	4632      	mov	r2, r6
c0d000fc:	9806      	ldr	r0, [sp, #24]
c0d000fe:	4631      	mov	r1, r6
c0d00100:	4616      	mov	r6, r2
c0d00102:	f003 f9fb 	bl	c0d034fc <__aeabi_uidiv>
c0d00106:	4603      	mov	r3, r0

                //before we get new trint, write old trint
                if(offset != 0) //if this is the first trint, dont write
c0d00108:	9806      	ldr	r0, [sp, #24]
c0d0010a:	2800      	cmp	r0, #0
c0d0010c:	9805      	ldr	r0, [sp, #20]
c0d0010e:	d00b      	beq.n	c0d00128 <add_index_to_seed_trints+0x68>
c0d00110:	a807      	add	r0, sp, #28
                    trints[(offset/5) - 1] = trits_to_trint(&trits[0], send);
c0d00112:	4631      	mov	r1, r6
c0d00114:	9304      	str	r3, [sp, #16]
c0d00116:	f000 f90f 	bl	c0d00338 <trits_to_trint>
c0d0011a:	9b04      	ldr	r3, [sp, #16]
c0d0011c:	9905      	ldr	r1, [sp, #20]
c0d0011e:	18c9      	adds	r1, r1, r3
c0d00120:	2200      	movs	r2, #0
c0d00122:	43d2      	mvns	r2, r2
c0d00124:	5488      	strb	r0, [r1, r2]
c0d00126:	9805      	ldr	r0, [sp, #20]

                //get new set of trits
                trint_to_trits(trints[offset/5], &trits[0], send);
c0d00128:	56c0      	ldrsb	r0, [r0, r3]
c0d0012a:	a907      	add	r1, sp, #28
c0d0012c:	9604      	str	r6, [sp, #16]
c0d0012e:	4632      	mov	r2, r6
c0d00130:	f000 f93a 	bl	c0d003a8 <trint_to_trits>
c0d00134:	a807      	add	r0, sp, #28
            }

            trits[offset % 5] = trits[offset % 5] + 1;
c0d00136:	5d41      	ldrb	r1, [r0, r5]
c0d00138:	1c49      	adds	r1, r1, #1
c0d0013a:	5541      	strb	r1, [r0, r5]
c0d0013c:	1940      	adds	r0, r0, r5
            if (trits[offset % 5] > 1) {
c0d0013e:	0609      	lsls	r1, r1, #24
c0d00140:	2201      	movs	r2, #1
c0d00142:	0612      	lsls	r2, r2, #24
c0d00144:	4291      	cmp	r1, r2
c0d00146:	dd08      	ble.n	c0d0015a <add_index_to_seed_trints+0x9a>
                trits[offset % 5] = -1;
c0d00148:	210c      	movs	r1, #12
c0d0014a:	43c9      	mvns	r1, r1
c0d0014c:	310c      	adds	r1, #12
c0d0014e:	7001      	strb	r1, [r0, #0]

                //use (uint8_t) to auto truncate offset/5
                if(offset < 5) trints[0] = trits_to_trint(&trits[0], send);
                else trints[(uint8_t)(offset/5)] = trits_to_trint(&trits[0], send);
            }
            if (carry) {
c0d00150:	1c64      	adds	r4, r4, #1
c0d00152:	b2e0      	uxtb	r0, r4

    for (uint32_t i = 0; i < index; i++) {
        // Add one
        uint8_t offset = 0;
        bool carry = true;
        while(carry && offset < 243) {
c0d00154:	28f3      	cmp	r0, #243	; 0xf3
c0d00156:	d3c1      	bcc.n	c0d000dc <add_index_to_seed_trints+0x1c>
c0d00158:	e00f      	b.n	c0d0017a <add_index_to_seed_trints+0xba>
            } else {
                //if we reach here, we are done so let's write the last trint
                carry = false;

                //use (uint8_t) to auto truncate offset/5
                if(offset < 5) trints[0] = trits_to_trint(&trits[0], send);
c0d0015a:	9804      	ldr	r0, [sp, #16]
c0d0015c:	b241      	sxtb	r1, r0
c0d0015e:	a807      	add	r0, sp, #28
c0d00160:	f000 f8ea 	bl	c0d00338 <trits_to_trint>
c0d00164:	4605      	mov	r5, r0
c0d00166:	2000      	movs	r0, #0
c0d00168:	9a06      	ldr	r2, [sp, #24]
c0d0016a:	2a05      	cmp	r2, #5
c0d0016c:	d303      	bcc.n	c0d00176 <add_index_to_seed_trints+0xb6>
                else trints[(uint8_t)(offset/5)] = trits_to_trint(&trits[0], send);
c0d0016e:	2105      	movs	r1, #5
c0d00170:	4610      	mov	r0, r2
c0d00172:	f003 f9c3 	bl	c0d034fc <__aeabi_uidiv>
c0d00176:	9905      	ldr	r1, [sp, #20]
c0d00178:	540d      	strb	r5, [r1, r0]
c0d0017a:	9903      	ldr	r1, [sp, #12]
int add_index_to_seed_trints(int8_t *trints, uint32_t index)
{
    int8_t trits[5];
    uint8_t send = 5;

    for (uint32_t i = 0; i < index; i++) {
c0d0017c:	1c49      	adds	r1, r1, #1
c0d0017e:	9802      	ldr	r0, [sp, #8]
c0d00180:	4281      	cmp	r1, r0
c0d00182:	d1a9      	bne.n	c0d000d8 <add_index_to_seed_trints+0x18>
            }


        }
    }
    return 0;
c0d00184:	2000      	movs	r0, #0
c0d00186:	b009      	add	sp, #36	; 0x24
c0d00188:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0018a <generate_private_key_half>:

// generates half of a private key to encoded format of trints
// use level 1 for first half, level 2 for second half
int generate_private_key_half(trint_t *seed_trints, uint32_t index,
                              trint_t *private_key, uint8_t level, char *msg)
{
c0d0018a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0018c:	af03      	add	r7, sp, #12
c0d0018e:	b083      	sub	sp, #12
c0d00190:	9302      	str	r3, [sp, #8]
c0d00192:	4614      	mov	r4, r2
c0d00194:	4605      	mov	r5, r0
    // Add index -- keep in mind fix index_to_seed
    add_index_to_seed_trints(&seed_trints[0], index);
c0d00196:	f7ff ff93 	bl	c0d000c0 <add_index_to_seed_trints>

    snprintf(&msg[0], 64, "[%d][%d][%d][%d][%d]\n", trits[0], trits[1],
             trits[2], trits[3], trits[4]);
 /* */

    kerl_initialize();
c0d0019a:	f000 fc4d 	bl	c0d00a38 <kerl_initialize>
c0d0019e:	2631      	movs	r6, #49	; 0x31
    kerl_absorb_trints(&seed_trints[0], 49);
c0d001a0:	4628      	mov	r0, r5
c0d001a2:	4631      	mov	r1, r6
c0d001a4:	f000 fc68 	bl	c0d00a78 <kerl_absorb_trints>
c0d001a8:	9400      	str	r4, [sp, #0]
    kerl_squeeze_trints(&private_key[0], 49);
c0d001aa:	4620      	mov	r0, r4
c0d001ac:	4631      	mov	r1, r6
c0d001ae:	f000 fc93 	bl	c0d00ad8 <kerl_squeeze_trints>

    kerl_initialize();
c0d001b2:	f000 fc41 	bl	c0d00a38 <kerl_initialize>
    kerl_absorb_trints(&seed_trints[0], 49);
c0d001b6:	4628      	mov	r0, r5
c0d001b8:	4631      	mov	r1, r6
c0d001ba:	f000 fc5d 	bl	c0d00a78 <kerl_absorb_trints>
c0d001be:	2500      	movs	r5, #0
c0d001c0:	9501      	str	r5, [sp, #4]

    //level == 1 means generate first half of private key
    for (uint8_t j = 0; j < 27; j++) {
c0d001c2:	b2ec      	uxtb	r4, r5
        //27 chunks makes up half the private key

        // THIS SHOULD TAKE ROUGHLY 3 SECONDS ELSE IT HUNG
        kerl_squeeze_trints(&private_key[j * 49], 49);
c0d001c4:	4630      	mov	r0, r6
c0d001c6:	4360      	muls	r0, r4
c0d001c8:	9900      	ldr	r1, [sp, #0]
c0d001ca:	1808      	adds	r0, r1, r0
c0d001cc:	4631      	mov	r1, r6
c0d001ce:	f000 fc83 	bl	c0d00ad8 <kerl_squeeze_trints>
c0d001d2:	2001      	movs	r0, #1

        //the first level just store it, if second half, discard
        //entire first half (OPTIMIZE!!!)
        if(j == 26 && level != 1) {
c0d001d4:	2c1a      	cmp	r4, #26
c0d001d6:	4602      	mov	r2, r0
c0d001d8:	d100      	bne.n	c0d001dc <generate_private_key_half+0x52>
c0d001da:	9a01      	ldr	r2, [sp, #4]
c0d001dc:	9902      	ldr	r1, [sp, #8]
c0d001de:	b2cb      	uxtb	r3, r1
c0d001e0:	2b01      	cmp	r3, #1
c0d001e2:	9901      	ldr	r1, [sp, #4]
c0d001e4:	d100      	bne.n	c0d001e8 <generate_private_key_half+0x5e>
c0d001e6:	4619      	mov	r1, r3
c0d001e8:	4311      	orrs	r1, r2
c0d001ea:	2900      	cmp	r1, #0
c0d001ec:	d100      	bne.n	c0d001f0 <generate_private_key_half+0x66>
c0d001ee:	9002      	str	r0, [sp, #8]

    kerl_initialize();
    kerl_absorb_trints(&seed_trints[0], 49);

    //level == 1 means generate first half of private key
    for (uint8_t j = 0; j < 27; j++) {
c0d001f0:	1c6d      	adds	r5, r5, #1
c0d001f2:	2900      	cmp	r1, #0
c0d001f4:	d100      	bne.n	c0d001f8 <generate_private_key_half+0x6e>
c0d001f6:	4605      	mov	r5, r0
c0d001f8:	b2e8      	uxtb	r0, r5
c0d001fa:	281b      	cmp	r0, #27
c0d001fc:	d3e1      	bcc.n	c0d001c2 <generate_private_key_half+0x38>
            j = 0;  //reset j so it can just go again,
                    //overwriting first half with second half
            level = 1; // use this as a flag to tell it to not enter infinite loop
        }
    }
    return 0;
c0d001fe:	2000      	movs	r0, #0
c0d00200:	b003      	add	sp, #12
c0d00202:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00204 <generate_public_address_half>:
}

//Generate the public key half at a time
//Use level 1 to generate first half, level 2 to generate second half
int generate_public_address_half(trint_t *private_key, trint_t *address_out, uint8_t level)
{
c0d00204:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00206:	af03      	add	r7, sp, #12
c0d00208:	b085      	sub	sp, #20
c0d0020a:	9200      	str	r2, [sp, #0]
c0d0020c:	9101      	str	r1, [sp, #4]
c0d0020e:	4606      	mov	r6, r0
c0d00210:	2000      	movs	r0, #0
c0d00212:	9002      	str	r0, [sp, #8]
c0d00214:	4601      	mov	r1, r0
c0d00216:	9603      	str	r6, [sp, #12]
c0d00218:	2031      	movs	r0, #49	; 0x31
c0d0021a:	9104      	str	r1, [sp, #16]
c0d0021c:	4348      	muls	r0, r1
c0d0021e:	1834      	adds	r4, r6, r0
c0d00220:	9d02      	ldr	r5, [sp, #8]
    for(uint8_t j = 0; j < 27; j++) {
        // each piece get's kerl'd 26 times(?)
        for(uint8_t k = 0; k < 26; k++) {
            //temp set k=25 to make this a LOT faster
            //k = 25;
            kerl_initialize();
c0d00222:	f000 fc09 	bl	c0d00a38 <kerl_initialize>
c0d00226:	2631      	movs	r6, #49	; 0x31
            kerl_absorb_trints(&private_key[j*49], 49);
c0d00228:	4620      	mov	r0, r4
c0d0022a:	4631      	mov	r1, r6
c0d0022c:	f000 fc24 	bl	c0d00a78 <kerl_absorb_trints>
            kerl_squeeze_trints(&private_key[j*49], 49);
c0d00230:	4620      	mov	r0, r4
c0d00232:	4631      	mov	r1, r6
c0d00234:	f000 fc50 	bl	c0d00ad8 <kerl_squeeze_trints>
//Use level 1 to generate first half, level 2 to generate second half
int generate_public_address_half(trint_t *private_key, trint_t *address_out, uint8_t level)
{
    for(uint8_t j = 0; j < 27; j++) {
        // each piece get's kerl'd 26 times(?)
        for(uint8_t k = 0; k < 26; k++) {
c0d00238:	1c6d      	adds	r5, r5, #1
c0d0023a:	b2e8      	uxtb	r0, r5
c0d0023c:	281a      	cmp	r0, #26
c0d0023e:	d3f0      	bcc.n	c0d00222 <generate_public_address_half+0x1e>
c0d00240:	9904      	ldr	r1, [sp, #16]

//Generate the public key half at a time
//Use level 1 to generate first half, level 2 to generate second half
int generate_public_address_half(trint_t *private_key, trint_t *address_out, uint8_t level)
{
    for(uint8_t j = 0; j < 27; j++) {
c0d00242:	1c49      	adds	r1, r1, #1
c0d00244:	291b      	cmp	r1, #27
c0d00246:	9e03      	ldr	r6, [sp, #12]
c0d00248:	d1e6      	bne.n	c0d00218 <generate_public_address_half+0x14>
            kerl_squeeze_trints(&private_key[j*49], 49);
        }
    }

    //the 27th kerl generates the digests
    kerl_initialize();
c0d0024a:	f000 fbf5 	bl	c0d00a38 <kerl_initialize>
    kerl_absorb_trints(private_key, 49*27); // re-absorb the entire private key
c0d0024e:	4910      	ldr	r1, [pc, #64]	; (c0d00290 <generate_public_address_half+0x8c>)
c0d00250:	4630      	mov	r0, r6
c0d00252:	f000 fc11 	bl	c0d00a78 <kerl_absorb_trints>

    // use level 1 to pass the first half of the private key, store
    // digest in public key for now to save RAM
    if(level == 1)
c0d00256:	9800      	ldr	r0, [sp, #0]
c0d00258:	2801      	cmp	r0, #1
c0d0025a:	d102      	bne.n	c0d00262 <generate_public_address_half+0x5e>
        kerl_squeeze_trints(address_out, 49); // Store the first digest just in address_out{
c0d0025c:	2131      	movs	r1, #49	; 0x31
c0d0025e:	9801      	ldr	r0, [sp, #4]
c0d00260:	e011      	b.n	c0d00286 <generate_public_address_half+0x82>
c0d00262:	2431      	movs	r4, #49	; 0x31
    else {
        //done with private key, so store the second digest in private key
        kerl_squeeze_trints(private_key, 49);
c0d00264:	4630      	mov	r0, r6
c0d00266:	4621      	mov	r1, r4
c0d00268:	f000 fc36 	bl	c0d00ad8 <kerl_squeeze_trints>

        //now get address
        kerl_initialize();
c0d0026c:	f000 fbe4 	bl	c0d00a38 <kerl_initialize>
c0d00270:	9d01      	ldr	r5, [sp, #4]
        //address out stores first half, private key stores second half
        kerl_absorb_trints(address_out, 49);
c0d00272:	4628      	mov	r0, r5
c0d00274:	4621      	mov	r1, r4
c0d00276:	f000 fbff 	bl	c0d00a78 <kerl_absorb_trints>
        kerl_absorb_trints(private_key, 49);
c0d0027a:	4630      	mov	r0, r6
c0d0027c:	4621      	mov	r1, r4
c0d0027e:	f000 fbfb 	bl	c0d00a78 <kerl_absorb_trints>
        //finally publish the public key
        kerl_squeeze_trints(address_out, 49);
c0d00282:	4628      	mov	r0, r5
c0d00284:	4621      	mov	r1, r4
c0d00286:	f000 fc27 	bl	c0d00ad8 <kerl_squeeze_trints>
    }

    return 0;
c0d0028a:	2000      	movs	r0, #0
c0d0028c:	b005      	add	sp, #20
c0d0028e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00290:	0000052b 	.word	0x0000052b

c0d00294 <uint_to_str>:
#include "vendor/iota/conversion.h"
#include "vendor/iota/transaction.h"
#include "vendor/iota/addresses.h"

// Ideally include room for the null terminator
void uint_to_str(uint32_t i, char *str, uint8_t len) {
c0d00294:	b5d0      	push	{r4, r6, r7, lr}
c0d00296:	af02      	add	r7, sp, #8
c0d00298:	4603      	mov	r3, r0
    snprintf(str, len, "%u", i);
c0d0029a:	a403      	add	r4, pc, #12	; (adr r4, c0d002a8 <uint_to_str+0x14>)
c0d0029c:	4608      	mov	r0, r1
c0d0029e:	4611      	mov	r1, r2
c0d002a0:	4622      	mov	r2, r4
c0d002a2:	f001 fccf 	bl	c0d01c44 <snprintf>
}
c0d002a6:	bdd0      	pop	{r4, r6, r7, pc}
c0d002a8:	00007525 	.word	0x00007525

c0d002ac <str_to_int>:
// Ideally include room for null terminator
void int_to_str(int i, char *str, uint8_t len) {
    snprintf(str, len, "%d", i);
}

uint32_t str_to_int(char *str, uint8_t len) {
c0d002ac:	b5b0      	push	{r4, r5, r7, lr}
c0d002ae:	af02      	add	r7, sp, #8
    uint32_t num = 0;
    //don't attempt to store more than 10 characters in a 32bit unsigned
    if(len > 10) len = 10;
c0d002b0:	220a      	movs	r2, #10
c0d002b2:	290a      	cmp	r1, #10
c0d002b4:	d300      	bcc.n	c0d002b8 <str_to_int+0xc>
c0d002b6:	4611      	mov	r1, r2
c0d002b8:	2200      	movs	r2, #0
    
    for(uint8_t i=0; i<len; i++){
c0d002ba:	2900      	cmp	r1, #0
c0d002bc:	d03a      	beq.n	c0d00334 <str_to_int+0x88>
c0d002be:	2300      	movs	r3, #0
c0d002c0:	461a      	mov	r2, r3
c0d002c2:	5cc4      	ldrb	r4, [r0, r3]
        switch(str[i]) {
c0d002c4:	3c30      	subs	r4, #48	; 0x30
c0d002c6:	2c09      	cmp	r4, #9
c0d002c8:	d834      	bhi.n	c0d00334 <str_to_int+0x88>
c0d002ca:	46c0      	nop			; (mov r8, r8)
c0d002cc:	447c      	add	r4, pc
c0d002ce:	7924      	ldrb	r4, [r4, #4]
c0d002d0:	0064      	lsls	r4, r4, #1
c0d002d2:	44a7      	add	pc, r4
c0d002d4:	100c0704 	.word	0x100c0704
c0d002d8:	201c1814 	.word	0x201c1814
c0d002dc:	2824      	.short	0x2824
            case '0':
                num = (num * 10) + 0;
c0d002de:	240a      	movs	r4, #10
c0d002e0:	4362      	muls	r2, r4
c0d002e2:	e024      	b.n	c0d0032e <str_to_int+0x82>
                break;
            case '1':
                num = (num * 10) + 1;
c0d002e4:	240a      	movs	r4, #10
c0d002e6:	4354      	muls	r4, r2
c0d002e8:	2201      	movs	r2, #1
c0d002ea:	4322      	orrs	r2, r4
c0d002ec:	e01f      	b.n	c0d0032e <str_to_int+0x82>
                break;
            case '2':
                num = (num * 10) + 2;
c0d002ee:	240a      	movs	r4, #10
c0d002f0:	4354      	muls	r4, r2
c0d002f2:	1ca2      	adds	r2, r4, #2
c0d002f4:	e01b      	b.n	c0d0032e <str_to_int+0x82>
                break;
            case '3':
                num = (num * 10) + 3;
c0d002f6:	240a      	movs	r4, #10
c0d002f8:	4354      	muls	r4, r2
c0d002fa:	1ce2      	adds	r2, r4, #3
c0d002fc:	e017      	b.n	c0d0032e <str_to_int+0x82>
                break;
            case '4':
                num = (num * 10) + 4;
c0d002fe:	240a      	movs	r4, #10
c0d00300:	4354      	muls	r4, r2
c0d00302:	1d22      	adds	r2, r4, #4
c0d00304:	e013      	b.n	c0d0032e <str_to_int+0x82>
                break;
            case '5':
                num = (num * 10) + 5;
c0d00306:	240a      	movs	r4, #10
c0d00308:	4354      	muls	r4, r2
c0d0030a:	1d62      	adds	r2, r4, #5
c0d0030c:	e00f      	b.n	c0d0032e <str_to_int+0x82>
                break;
            case '6':
                num = (num * 10) + 6;
c0d0030e:	240a      	movs	r4, #10
c0d00310:	4354      	muls	r4, r2
c0d00312:	1da2      	adds	r2, r4, #6
c0d00314:	e00b      	b.n	c0d0032e <str_to_int+0x82>
                break;
            case '7':
                num = (num * 10) + 7;
c0d00316:	240a      	movs	r4, #10
c0d00318:	4354      	muls	r4, r2
c0d0031a:	1de2      	adds	r2, r4, #7
c0d0031c:	e007      	b.n	c0d0032e <str_to_int+0x82>
                break;
            case '8':
                num = (num * 10) + 8;
c0d0031e:	240a      	movs	r4, #10
c0d00320:	4354      	muls	r4, r2
c0d00322:	3408      	adds	r4, #8
c0d00324:	e002      	b.n	c0d0032c <str_to_int+0x80>
                break;
            case '9':
                num = (num * 10) + 9;
c0d00326:	240a      	movs	r4, #10
c0d00328:	4354      	muls	r4, r2
c0d0032a:	3409      	adds	r4, #9
c0d0032c:	4622      	mov	r2, r4
uint32_t str_to_int(char *str, uint8_t len) {
    uint32_t num = 0;
    //don't attempt to store more than 10 characters in a 32bit unsigned
    if(len > 10) len = 10;
    
    for(uint8_t i=0; i<len; i++){
c0d0032e:	1c5b      	adds	r3, r3, #1
c0d00330:	428b      	cmp	r3, r1
c0d00332:	d3c6      	bcc.n	c0d002c2 <str_to_int+0x16>
            default:
                return num;
        }
    }
    return num;
}
c0d00334:	4610      	mov	r0, r2
c0d00336:	bdb0      	pop	{r4, r5, r7, pc}

c0d00338 <trits_to_trint>:
        pow3_val /= 3;
    }
}

//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
c0d00338:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0033a:	af03      	add	r7, sp, #12
c0d0033c:	2200      	movs	r2, #0
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d0033e:	43d3      	mvns	r3, r2
c0d00340:	b2c9      	uxtb	r1, r1
c0d00342:	31ff      	adds	r1, #255	; 0xff
c0d00344:	b24c      	sxtb	r4, r1
c0d00346:	2c00      	cmp	r4, #0
c0d00348:	db0f      	blt.n	c0d0036a <trits_to_trint+0x32>
c0d0034a:	1900      	adds	r0, r0, r4
c0d0034c:	2401      	movs	r4, #1
c0d0034e:	2200      	movs	r2, #0
    {
        ret += trits[i]*pow3_val;
c0d00350:	b265      	sxtb	r5, r4
        pow3_val *= 3;
c0d00352:	2403      	movs	r4, #3
c0d00354:	436c      	muls	r4, r5
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
    {
        ret += trits[i]*pow3_val;
c0d00356:	7806      	ldrb	r6, [r0, #0]
c0d00358:	b276      	sxtb	r6, r6
c0d0035a:	436e      	muls	r6, r5
c0d0035c:	b2d2      	uxtb	r2, r2
c0d0035e:	18b2      	adds	r2, r6, r2
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d00360:	1e40      	subs	r0, r0, #1
c0d00362:	1e49      	subs	r1, r1, #1
c0d00364:	b249      	sxtb	r1, r1
c0d00366:	4299      	cmp	r1, r3
c0d00368:	dcf2      	bgt.n	c0d00350 <trits_to_trint+0x18>
    {
        ret += trits[i]*pow3_val;
        pow3_val *= 3;
    }

    return ret;
c0d0036a:	b250      	sxtb	r0, r2
c0d0036c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0036e <specific_49trints_to_243trits>:
        //incr count as we get trints
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
c0d0036e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00370:	af03      	add	r7, sp, #12
c0d00372:	b081      	sub	sp, #4
c0d00374:	460e      	mov	r6, r1
c0d00376:	4605      	mov	r5, r0
c0d00378:	2400      	movs	r4, #0
c0d0037a:	9600      	str	r6, [sp, #0]
    for(uint8_t i = 0; i < 48; i++) {
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
c0d0037c:	1b28      	subs	r0, r5, r4
c0d0037e:	7800      	ldrb	r0, [r0, #0]
c0d00380:	b240      	sxtb	r0, r0
c0d00382:	2205      	movs	r2, #5
c0d00384:	4631      	mov	r1, r6
c0d00386:	f000 f80f 	bl	c0d003a8 <trint_to_trits>
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
    for(uint8_t i = 0; i < 48; i++) {
c0d0038a:	1d76      	adds	r6, r6, #5
c0d0038c:	1e64      	subs	r4, r4, #1
c0d0038e:	4620      	mov	r0, r4
c0d00390:	3030      	adds	r0, #48	; 0x30
c0d00392:	d1f3      	bne.n	c0d0037c <specific_49trints_to_243trits+0xe>
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
c0d00394:	2030      	movs	r0, #48	; 0x30
c0d00396:	5628      	ldrsb	r0, [r5, r0]
c0d00398:	9900      	ldr	r1, [sp, #0]
c0d0039a:	31f0      	adds	r1, #240	; 0xf0
c0d0039c:	2203      	movs	r2, #3
c0d0039e:	f000 f803 	bl	c0d003a8 <trint_to_trits>
}
c0d003a2:	b001      	add	sp, #4
c0d003a4:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d003a8 <trint_to_trits>:

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
c0d003a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003aa:	af03      	add	r7, sp, #12
c0d003ac:	b083      	sub	sp, #12
c0d003ae:	9100      	str	r1, [sp, #0]
c0d003b0:	4603      	mov	r3, r0
c0d003b2:	9201      	str	r2, [sp, #4]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d003b4:	2a01      	cmp	r2, #1
c0d003b6:	db2b      	blt.n	c0d00410 <trint_to_trits+0x68>
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
c0d003b8:	2009      	movs	r0, #9
c0d003ba:	2151      	movs	r1, #81	; 0x51
c0d003bc:	9a01      	ldr	r2, [sp, #4]
c0d003be:	2a03      	cmp	r2, #3
c0d003c0:	d000      	beq.n	c0d003c4 <trint_to_trits+0x1c>
c0d003c2:	4608      	mov	r0, r1
c0d003c4:	2500      	movs	r5, #0
c0d003c6:	462e      	mov	r6, r5
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d003c8:	b2c4      	uxtb	r4, r0
c0d003ca:	b258      	sxtb	r0, r3
c0d003cc:	9002      	str	r0, [sp, #8]
c0d003ce:	0040      	lsls	r0, r0, #1
c0d003d0:	4621      	mov	r1, r4
c0d003d2:	f003 f91d 	bl	c0d03610 <__aeabi_idiv>
c0d003d6:	9900      	ldr	r1, [sp, #0]
c0d003d8:	5548      	strb	r0, [r1, r5]
c0d003da:	194a      	adds	r2, r1, r5


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d003dc:	0603      	lsls	r3, r0, #24
c0d003de:	2101      	movs	r1, #1
c0d003e0:	060d      	lsls	r5, r1, #24
c0d003e2:	42ab      	cmp	r3, r5
c0d003e4:	dc03      	bgt.n	c0d003ee <trint_to_trits+0x46>
c0d003e6:	21ff      	movs	r1, #255	; 0xff
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d003e8:	4d0a      	ldr	r5, [pc, #40]	; (c0d00414 <trint_to_trits+0x6c>)
c0d003ea:	42ab      	cmp	r3, r5
c0d003ec:	dc01      	bgt.n	c0d003f2 <trint_to_trits+0x4a>
c0d003ee:	7011      	strb	r1, [r2, #0]
c0d003f0:	e000      	b.n	c0d003f4 <trint_to_trits+0x4c>

        integ -= trits_r[j] * pow3_val;
c0d003f2:	4601      	mov	r1, r0
c0d003f4:	9a02      	ldr	r2, [sp, #8]
c0d003f6:	b248      	sxtb	r0, r1
c0d003f8:	4360      	muls	r0, r4
c0d003fa:	1a15      	subs	r5, r2, r0
        pow3_val /= 3;
c0d003fc:	2103      	movs	r1, #3
c0d003fe:	4620      	mov	r0, r4
c0d00400:	f003 f87c 	bl	c0d034fc <__aeabi_uidiv>
c0d00404:	462b      	mov	r3, r5
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d00406:	1c76      	adds	r6, r6, #1
c0d00408:	b2f5      	uxtb	r5, r6
c0d0040a:	9901      	ldr	r1, [sp, #4]
c0d0040c:	428d      	cmp	r5, r1
c0d0040e:	dbdb      	blt.n	c0d003c8 <trint_to_trits+0x20>
        else if(trits_r[j] < -1) trits_r[j] = -1;

        integ -= trits_r[j] * pow3_val;
        pow3_val /= 3;
    }
}
c0d00410:	b003      	add	sp, #12
c0d00412:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00414:	feffffff 	.word	0xfeffffff

c0d00418 <get_seed>:
    }

    return ret;
}

void get_seed(unsigned char *privateKey, uint8_t sz, char *msg) {
c0d00418:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0041a:	af03      	add	r7, sp, #12
c0d0041c:	b08f      	sub	sp, #60	; 0x3c
c0d0041e:	9201      	str	r2, [sp, #4]
c0d00420:	460e      	mov	r6, r1
c0d00422:	4605      	mov	r5, r0

    //kerl requires 424 bytes
    kerl_initialize();
c0d00424:	9500      	str	r5, [sp, #0]
c0d00426:	f000 fb07 	bl	c0d00a38 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d0042a:	f000 fb05 	bl	c0d00a38 <kerl_initialize>
c0d0042e:	ac02      	add	r4, sp, #8

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d00430:	4620      	mov	r0, r4
c0d00432:	4629      	mov	r1, r5
c0d00434:	4632      	mov	r2, r6
c0d00436:	f003 fae7 	bl	c0d03a08 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d0043a:	19a0      	adds	r0, r4, r6
c0d0043c:	2530      	movs	r5, #48	; 0x30
c0d0043e:	1baa      	subs	r2, r5, r6
c0d00440:	9900      	ldr	r1, [sp, #0]
c0d00442:	f003 fae1 	bl	c0d03a08 <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00446:	4620      	mov	r0, r4
c0d00448:	4629      	mov	r1, r5
c0d0044a:	f000 fb01 	bl	c0d00a50 <kerl_absorb_bytes>
c0d0044e:	ac02      	add	r4, sp, #8
    }

    // A trint_t is 5 trits encoded as 1 int8_t - Used to massively
    // reduce RAM required
    trint_t seed_trints[49];
    kerl_squeeze_trints(&seed_trints[0], 49);
c0d00450:	2131      	movs	r1, #49	; 0x31
c0d00452:	4620      	mov	r0, r4
c0d00454:	f000 fb40 	bl	c0d00ad8 <kerl_squeeze_trints>

    //null terminate seed
    //seed_chars[81] = '\0';

    //pass trints to private key func and let it handle the response
    get_private_key(&seed_trints[0], 0, msg);
c0d00458:	2100      	movs	r1, #0
c0d0045a:	4620      	mov	r0, r4
c0d0045c:	9a01      	ldr	r2, [sp, #4]
c0d0045e:	f000 f803 	bl	c0d00468 <get_private_key>
}
c0d00462:	b00f      	add	sp, #60	; 0x3c
c0d00464:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00468 <get_private_key>:

//write func to get private key
void get_private_key(trint_t *seed_trints, uint32_t idx, char *msg) {
c0d00468:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0046a:	af03      	add	r7, sp, #12
c0d0046c:	b0ff      	sub	sp, #508	; 0x1fc
c0d0046e:	b0ff      	sub	sp, #508	; 0x1fc
c0d00470:	b0f3      	sub	sp, #460	; 0x1cc
    { // localize the memory for private key
        //currently able to store 31 - [-1][-1][-1][0][-1]
        trint_t private_key_trints[49 * 27]; //trints are still just int8_t but encoded

        //generate private key using level 1 for first half
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 1, msg);
c0d00472:	ab01      	add	r3, sp, #4
c0d00474:	c307      	stmia	r3!, {r0, r1, r2}
c0d00476:	466b      	mov	r3, sp
c0d00478:	601a      	str	r2, [r3, #0]
c0d0047a:	ad19      	add	r5, sp, #100	; 0x64
c0d0047c:	2601      	movs	r6, #1
c0d0047e:	462a      	mov	r2, r5
c0d00480:	4633      	mov	r3, r6
c0d00482:	f7ff fe82 	bl	c0d0018a <generate_private_key_half>
c0d00486:	4c17      	ldr	r4, [pc, #92]	; (c0d004e4 <get_private_key+0x7c>)
c0d00488:	446c      	add	r4, sp
        //use this half to generate half public key 1
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 1);
c0d0048a:	4628      	mov	r0, r5
c0d0048c:	4621      	mov	r1, r4
c0d0048e:	4632      	mov	r2, r6
c0d00490:	f7ff feb8 	bl	c0d00204 <generate_public_address_half>

        //use level 2 to generate second half of private key
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 2, msg);
c0d00494:	4668      	mov	r0, sp
c0d00496:	9903      	ldr	r1, [sp, #12]
c0d00498:	6001      	str	r1, [r0, #0]
c0d0049a:	2602      	movs	r6, #2
c0d0049c:	9801      	ldr	r0, [sp, #4]
c0d0049e:	9902      	ldr	r1, [sp, #8]
c0d004a0:	462a      	mov	r2, r5
c0d004a2:	4633      	mov	r3, r6
c0d004a4:	f7ff fe71 	bl	c0d0018a <generate_private_key_half>

        //finally level 2 to generate second half of public key (and then digests both)
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 2);
c0d004a8:	4628      	mov	r0, r5
c0d004aa:	4621      	mov	r1, r4
c0d004ac:	4632      	mov	r2, r6
c0d004ae:	f7ff fea9 	bl	c0d00204 <generate_public_address_half>
c0d004b2:	ad19      	add	r5, sp, #100	; 0x64
    }
    // 12s to get here if k=25, 2min otherwise
    //now public key will hold the actual public address
    trit_t pub_trits[243];
    specific_49trints_to_243trits(&public_key_trints[0], &pub_trits[0]);
c0d004b4:	4620      	mov	r0, r4
c0d004b6:	4629      	mov	r1, r5
c0d004b8:	f7ff ff59 	bl	c0d0036e <specific_49trints_to_243trits>
c0d004bc:	ac04      	add	r4, sp, #16

    tryte_t seed_trytes[81];
    trits_to_trytes(pub_trits, seed_trytes, 243);
c0d004be:	22f3      	movs	r2, #243	; 0xf3
c0d004c0:	4628      	mov	r0, r5
c0d004c2:	4621      	mov	r1, r4
c0d004c4:	f000 f8fd 	bl	c0d006c2 <trits_to_trytes>
c0d004c8:	2551      	movs	r5, #81	; 0x51

    trytes_to_chars(seed_trytes, msg, 81);
c0d004ca:	4620      	mov	r0, r4
c0d004cc:	9c03      	ldr	r4, [sp, #12]
c0d004ce:	4621      	mov	r1, r4
c0d004d0:	462a      	mov	r2, r5
c0d004d2:	f000 f92b 	bl	c0d0072c <trytes_to_chars>

    //null terminate the public key
    msg[81] = '\0';
c0d004d6:	2000      	movs	r0, #0
c0d004d8:	5560      	strb	r0, [r4, r5]
}
c0d004da:	1ffc      	subs	r4, r7, #7
c0d004dc:	3c05      	subs	r4, #5
c0d004de:	46a5      	mov	sp, r4
c0d004e0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d004e2:	46c0      	nop			; (mov r8, r8)
c0d004e4:	00000590 	.word	0x00000590

c0d004e8 <bigint_add_int>:
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
    return ret;
}

int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
c0d004e8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004ea:	af03      	add	r7, sp, #12
c0d004ec:	b087      	sub	sp, #28
c0d004ee:	9105      	str	r1, [sp, #20]
c0d004f0:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d004f2:	2b00      	cmp	r3, #0
c0d004f4:	d03a      	beq.n	c0d0056c <bigint_add_int+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004f6:	2100      	movs	r1, #0
c0d004f8:	43cc      	mvns	r4, r1
c0d004fa:	9400      	str	r4, [sp, #0]
c0d004fc:	460e      	mov	r6, r1
c0d004fe:	460c      	mov	r4, r1
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_in[i], val.low, val.hi);
c0d00500:	9101      	str	r1, [sp, #4]
c0d00502:	9302      	str	r3, [sp, #8]
c0d00504:	9203      	str	r2, [sp, #12]
c0d00506:	9b00      	ldr	r3, [sp, #0]
c0d00508:	460a      	mov	r2, r1
c0d0050a:	4605      	mov	r5, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0050c:	cd01      	ldmia	r5!, {r0}
c0d0050e:	9504      	str	r5, [sp, #16]
c0d00510:	9905      	ldr	r1, [sp, #20]
c0d00512:	1841      	adds	r1, r0, r1
c0d00514:	4156      	adcs	r6, r2
c0d00516:	9106      	str	r1, [sp, #24]
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00518:	4019      	ands	r1, r3
c0d0051a:	1c49      	adds	r1, r1, #1
c0d0051c:	4615      	mov	r5, r2
c0d0051e:	416d      	adcs	r5, r5
c0d00520:	2001      	movs	r0, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00522:	4004      	ands	r4, r0
c0d00524:	4622      	mov	r2, r4
c0d00526:	2c00      	cmp	r4, #0
c0d00528:	d100      	bne.n	c0d0052c <bigint_add_int+0x44>
c0d0052a:	9906      	ldr	r1, [sp, #24]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0052c:	4299      	cmp	r1, r3
c0d0052e:	9006      	str	r0, [sp, #24]
c0d00530:	d800      	bhi.n	c0d00534 <bigint_add_int+0x4c>
c0d00532:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00534:	2a00      	cmp	r2, #0
c0d00536:	4632      	mov	r2, r6
c0d00538:	d100      	bne.n	c0d0053c <bigint_add_int+0x54>
c0d0053a:	4615      	mov	r5, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0053c:	2d00      	cmp	r5, #0
c0d0053e:	9e06      	ldr	r6, [sp, #24]
c0d00540:	d100      	bne.n	c0d00544 <bigint_add_int+0x5c>
c0d00542:	462e      	mov	r6, r5
c0d00544:	2d00      	cmp	r5, #0
c0d00546:	d000      	beq.n	c0d0054a <bigint_add_int+0x62>
c0d00548:	4630      	mov	r0, r6
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d0054a:	4310      	orrs	r0, r2
c0d0054c:	b2c0      	uxtb	r0, r0
c0d0054e:	2800      	cmp	r0, #0
c0d00550:	9b02      	ldr	r3, [sp, #8]
c0d00552:	9a03      	ldr	r2, [sp, #12]
c0d00554:	9c01      	ldr	r4, [sp, #4]
c0d00556:	d100      	bne.n	c0d0055a <bigint_add_int+0x72>
c0d00558:	9006      	str	r0, [sp, #24]
        val = full_add(bigint_in[i], val.low, val.hi);
        bigint_out[i] = val.low;
c0d0055a:	c202      	stmia	r2!, {r1}
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d0055c:	1e5b      	subs	r3, r3, #1
c0d0055e:	9405      	str	r4, [sp, #20]
c0d00560:	4626      	mov	r6, r4
c0d00562:	9d06      	ldr	r5, [sp, #24]
c0d00564:	4621      	mov	r1, r4
c0d00566:	462c      	mov	r4, r5
c0d00568:	9804      	ldr	r0, [sp, #16]
c0d0056a:	d1ca      	bne.n	c0d00502 <bigint_add_int+0x1a>
        bigint_out[i] = val.low;
        val.low = 0;
    }

    if (val.hi) {
        return -1;
c0d0056c:	4268      	negs	r0, r5
    }
    return 0;
}
c0d0056e:	b007      	add	sp, #28
c0d00570:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00572 <bigint_add_bigint>:

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d00572:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00574:	af03      	add	r7, sp, #12
c0d00576:	b086      	sub	sp, #24
c0d00578:	461c      	mov	r4, r3
c0d0057a:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d0057c:	2c00      	cmp	r4, #0
c0d0057e:	d034      	beq.n	c0d005ea <bigint_add_bigint+0x78>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00580:	2600      	movs	r6, #0
c0d00582:	43f3      	mvns	r3, r6
c0d00584:	9300      	str	r3, [sp, #0]
c0d00586:	9601      	str	r6, [sp, #4]
c0d00588:	9202      	str	r2, [sp, #8]
c0d0058a:	9403      	str	r4, [sp, #12]
c0d0058c:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0058e:	cc01      	ldmia	r4!, {r0}
c0d00590:	9404      	str	r4, [sp, #16]
c0d00592:	460c      	mov	r4, r1
c0d00594:	cc02      	ldmia	r4!, {r1}
c0d00596:	9405      	str	r4, [sp, #20]
c0d00598:	180a      	adds	r2, r1, r0
c0d0059a:	9d01      	ldr	r5, [sp, #4]
c0d0059c:	462c      	mov	r4, r5
c0d0059e:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d005a0:	4611      	mov	r1, r2
c0d005a2:	9800      	ldr	r0, [sp, #0]
c0d005a4:	4001      	ands	r1, r0
c0d005a6:	1c4b      	adds	r3, r1, #1
c0d005a8:	4629      	mov	r1, r5
c0d005aa:	4149      	adcs	r1, r1
c0d005ac:	2501      	movs	r5, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d005ae:	402e      	ands	r6, r5
c0d005b0:	2e00      	cmp	r6, #0
c0d005b2:	d100      	bne.n	c0d005b6 <bigint_add_bigint+0x44>
c0d005b4:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005b6:	4283      	cmp	r3, r0
c0d005b8:	4628      	mov	r0, r5
c0d005ba:	d800      	bhi.n	c0d005be <bigint_add_bigint+0x4c>
c0d005bc:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d005be:	2e00      	cmp	r6, #0
c0d005c0:	9a02      	ldr	r2, [sp, #8]
c0d005c2:	d100      	bne.n	c0d005c6 <bigint_add_bigint+0x54>
c0d005c4:	4621      	mov	r1, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005c6:	2900      	cmp	r1, #0
c0d005c8:	462e      	mov	r6, r5
c0d005ca:	d100      	bne.n	c0d005ce <bigint_add_bigint+0x5c>
c0d005cc:	460e      	mov	r6, r1
c0d005ce:	2900      	cmp	r1, #0
c0d005d0:	d000      	beq.n	c0d005d4 <bigint_add_bigint+0x62>
c0d005d2:	4630      	mov	r0, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d005d4:	4320      	orrs	r0, r4

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d005d6:	2800      	cmp	r0, #0
c0d005d8:	9905      	ldr	r1, [sp, #20]
c0d005da:	d100      	bne.n	c0d005de <bigint_add_bigint+0x6c>
c0d005dc:	4605      	mov	r5, r0
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d005de:	c208      	stmia	r2!, {r3}
c0d005e0:	9c03      	ldr	r4, [sp, #12]

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d005e2:	1e64      	subs	r4, r4, #1
c0d005e4:	462e      	mov	r6, r5
c0d005e6:	9804      	ldr	r0, [sp, #16]
c0d005e8:	d1ce      	bne.n	c0d00588 <bigint_add_bigint+0x16>
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }

    if (val.hi) {
        return -1;
c0d005ea:	4268      	negs	r0, r5
    }
    return 0;
}
c0d005ec:	b006      	add	sp, #24
c0d005ee:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d005f0 <bigint_sub_bigint>:

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d005f0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005f2:	af03      	add	r7, sp, #12
c0d005f4:	b087      	sub	sp, #28
c0d005f6:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d005f8:	2d00      	cmp	r5, #0
c0d005fa:	d037      	beq.n	c0d0066c <bigint_sub_bigint+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005fc:	2400      	movs	r4, #0
c0d005fe:	9402      	str	r4, [sp, #8]
c0d00600:	43e3      	mvns	r3, r4
c0d00602:	9301      	str	r3, [sp, #4]
c0d00604:	2601      	movs	r6, #1
c0d00606:	9600      	str	r6, [sp, #0]
c0d00608:	9203      	str	r2, [sp, #12]
c0d0060a:	9504      	str	r5, [sp, #16]
c0d0060c:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0060e:	cc01      	ldmia	r4!, {r0}
c0d00610:	9405      	str	r4, [sp, #20]
c0d00612:	460c      	mov	r4, r1
int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d00614:	cc02      	ldmia	r4!, {r1}
c0d00616:	9406      	str	r4, [sp, #24]
c0d00618:	43c9      	mvns	r1, r1
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0061a:	180a      	adds	r2, r1, r0
c0d0061c:	9902      	ldr	r1, [sp, #8]
c0d0061e:	460c      	mov	r4, r1
c0d00620:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00622:	4610      	mov	r0, r2
c0d00624:	9d01      	ldr	r5, [sp, #4]
c0d00626:	4028      	ands	r0, r5
c0d00628:	1c43      	adds	r3, r0, #1
c0d0062a:	4608      	mov	r0, r1
c0d0062c:	4140      	adcs	r0, r0
c0d0062e:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00630:	400e      	ands	r6, r1
c0d00632:	2e00      	cmp	r6, #0
c0d00634:	d100      	bne.n	c0d00638 <bigint_sub_bigint+0x48>
c0d00636:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00638:	42ab      	cmp	r3, r5
c0d0063a:	460d      	mov	r5, r1
c0d0063c:	d800      	bhi.n	c0d00640 <bigint_sub_bigint+0x50>
c0d0063e:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00640:	2e00      	cmp	r6, #0
c0d00642:	9a03      	ldr	r2, [sp, #12]
c0d00644:	d100      	bne.n	c0d00648 <bigint_sub_bigint+0x58>
c0d00646:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00648:	2800      	cmp	r0, #0
c0d0064a:	460e      	mov	r6, r1
c0d0064c:	d100      	bne.n	c0d00650 <bigint_sub_bigint+0x60>
c0d0064e:	4606      	mov	r6, r0
c0d00650:	2800      	cmp	r0, #0
c0d00652:	d000      	beq.n	c0d00656 <bigint_sub_bigint+0x66>
c0d00654:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d00656:	4325      	orrs	r5, r4

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00658:	2d00      	cmp	r5, #0
c0d0065a:	460e      	mov	r6, r1
c0d0065c:	9805      	ldr	r0, [sp, #20]
c0d0065e:	d100      	bne.n	c0d00662 <bigint_sub_bigint+0x72>
c0d00660:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d00662:	c208      	stmia	r2!, {r3}
c0d00664:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00666:	1e6d      	subs	r5, r5, #1
c0d00668:	9906      	ldr	r1, [sp, #24]
c0d0066a:	d1cd      	bne.n	c0d00608 <bigint_sub_bigint+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d0066c:	2000      	movs	r0, #0
c0d0066e:	b007      	add	sp, #28
c0d00670:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00672 <bigint_cmp_bigint>:
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
c0d00672:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00674:	af03      	add	r7, sp, #12
c0d00676:	b081      	sub	sp, #4
c0d00678:	2400      	movs	r4, #0
c0d0067a:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d0067c:	32ff      	adds	r2, #255	; 0xff
c0d0067e:	b253      	sxtb	r3, r2
c0d00680:	2b00      	cmp	r3, #0
c0d00682:	db0f      	blt.n	c0d006a4 <bigint_cmp_bigint+0x32>
c0d00684:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d00686:	009b      	lsls	r3, r3, #2
c0d00688:	58ce      	ldr	r6, [r1, r3]
c0d0068a:	58c4      	ldr	r4, [r0, r3]
c0d0068c:	2301      	movs	r3, #1
c0d0068e:	42b4      	cmp	r4, r6
c0d00690:	dc0b      	bgt.n	c0d006aa <bigint_cmp_bigint+0x38>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00692:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d00694:	42b4      	cmp	r4, r6
c0d00696:	db07      	blt.n	c0d006a8 <bigint_cmp_bigint+0x36>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00698:	b253      	sxtb	r3, r2
c0d0069a:	42ab      	cmp	r3, r5
c0d0069c:	461a      	mov	r2, r3
c0d0069e:	dcf2      	bgt.n	c0d00686 <bigint_cmp_bigint+0x14>
c0d006a0:	9b00      	ldr	r3, [sp, #0]
c0d006a2:	e002      	b.n	c0d006aa <bigint_cmp_bigint+0x38>
c0d006a4:	4623      	mov	r3, r4
c0d006a6:	e000      	b.n	c0d006aa <bigint_cmp_bigint+0x38>
c0d006a8:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d006aa:	4618      	mov	r0, r3
c0d006ac:	b001      	add	sp, #4
c0d006ae:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d006b0 <bigint_not>:

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d006b0:	2900      	cmp	r1, #0
c0d006b2:	d004      	beq.n	c0d006be <bigint_not+0xe>
        bigint[i] = ~bigint[i];
c0d006b4:	6802      	ldr	r2, [r0, #0]
c0d006b6:	43d2      	mvns	r2, r2
c0d006b8:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d006ba:	1e49      	subs	r1, r1, #1
c0d006bc:	d1fa      	bne.n	c0d006b4 <bigint_not+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d006be:	2000      	movs	r0, #0
c0d006c0:	4770      	bx	lr

c0d006c2 <trits_to_trytes>:

static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";


int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len)
{
c0d006c2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006c4:	af03      	add	r7, sp, #12
c0d006c6:	b083      	sub	sp, #12
c0d006c8:	4616      	mov	r6, r2
c0d006ca:	460c      	mov	r4, r1
c0d006cc:	4605      	mov	r5, r0
    if (trit_len % 3 != 0) {
c0d006ce:	2103      	movs	r1, #3
c0d006d0:	4630      	mov	r0, r6
c0d006d2:	f002 ff99 	bl	c0d03608 <__aeabi_uidivmod>
c0d006d6:	2000      	movs	r0, #0
c0d006d8:	43c2      	mvns	r2, r0
c0d006da:	2900      	cmp	r1, #0
c0d006dc:	d123      	bne.n	c0d00726 <trits_to_trytes+0x64>
c0d006de:	9502      	str	r5, [sp, #8]
c0d006e0:	4635      	mov	r5, r6
c0d006e2:	2603      	movs	r6, #3
c0d006e4:	9001      	str	r0, [sp, #4]
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;
c0d006e6:	4628      	mov	r0, r5
c0d006e8:	4631      	mov	r1, r6
c0d006ea:	f002 ff07 	bl	c0d034fc <__aeabi_uidiv>

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d006ee:	2d03      	cmp	r5, #3
c0d006f0:	9a01      	ldr	r2, [sp, #4]
c0d006f2:	d318      	bcc.n	c0d00726 <trits_to_trytes+0x64>
c0d006f4:	2200      	movs	r2, #0
c0d006f6:	9200      	str	r2, [sp, #0]
c0d006f8:	9601      	str	r6, [sp, #4]
c0d006fa:	9e01      	ldr	r6, [sp, #4]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
c0d006fc:	4633      	mov	r3, r6
c0d006fe:	4353      	muls	r3, r2
c0d00700:	4625      	mov	r5, r4
c0d00702:	9902      	ldr	r1, [sp, #8]
c0d00704:	5ccc      	ldrb	r4, [r1, r3]
c0d00706:	18cb      	adds	r3, r1, r3
c0d00708:	2101      	movs	r1, #1
c0d0070a:	5659      	ldrsb	r1, [r3, r1]
c0d0070c:	4371      	muls	r1, r6
c0d0070e:	1909      	adds	r1, r1, r4
c0d00710:	2402      	movs	r4, #2
c0d00712:	571b      	ldrsb	r3, [r3, r4]
c0d00714:	2409      	movs	r4, #9
c0d00716:	435c      	muls	r4, r3
c0d00718:	1909      	adds	r1, r1, r4
c0d0071a:	462c      	mov	r4, r5
c0d0071c:	54a1      	strb	r1, [r4, r2]
    if (trit_len % 3 != 0) {
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d0071e:	1c52      	adds	r2, r2, #1
c0d00720:	4282      	cmp	r2, r0
c0d00722:	d3eb      	bcc.n	c0d006fc <trits_to_trytes+0x3a>
c0d00724:	9a00      	ldr	r2, [sp, #0]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
    }
    return 0;
}
c0d00726:	4610      	mov	r0, r2
c0d00728:	b003      	add	sp, #12
c0d0072a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0072c <trytes_to_chars>:
    }
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
c0d0072c:	b5d0      	push	{r4, r6, r7, lr}
c0d0072e:	af02      	add	r7, sp, #8
    for (uint16_t i = 0; i < len; i++) {
c0d00730:	2a00      	cmp	r2, #0
c0d00732:	d00a      	beq.n	c0d0074a <trytes_to_chars+0x1e>
c0d00734:	a306      	add	r3, pc, #24	; (adr r3, c0d00750 <tryte_to_char_mapping>)
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
c0d00736:	7804      	ldrb	r4, [r0, #0]
c0d00738:	b264      	sxtb	r4, r4
c0d0073a:	191c      	adds	r4, r3, r4
c0d0073c:	7b64      	ldrb	r4, [r4, #13]
c0d0073e:	700c      	strb	r4, [r1, #0]
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
    for (uint16_t i = 0; i < len; i++) {
c0d00740:	1e52      	subs	r2, r2, #1
c0d00742:	1c40      	adds	r0, r0, #1
c0d00744:	1c49      	adds	r1, r1, #1
c0d00746:	2a00      	cmp	r2, #0
c0d00748:	d1f5      	bne.n	c0d00736 <trytes_to_chars+0xa>
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
    }

    return 0;
c0d0074a:	2000      	movs	r0, #0
c0d0074c:	bdd0      	pop	{r4, r6, r7, pc}
c0d0074e:	46c0      	nop			; (mov r8, r8)

c0d00750 <tryte_to_char_mapping>:
c0d00750:	51504f4e 	.word	0x51504f4e
c0d00754:	55545352 	.word	0x55545352
c0d00758:	59585756 	.word	0x59585756
c0d0075c:	4241395a 	.word	0x4241395a
c0d00760:	46454443 	.word	0x46454443
c0d00764:	4a494847 	.word	0x4a494847
c0d00768:	004d4c4b 	.word	0x004d4c4b

c0d0076c <words_to_bytes>:
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
c0d0076c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0076e:	af03      	add	r7, sp, #12
c0d00770:	b082      	sub	sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d00772:	2a00      	cmp	r2, #0
c0d00774:	d01a      	beq.n	c0d007ac <words_to_bytes+0x40>
c0d00776:	0093      	lsls	r3, r2, #2
c0d00778:	18c0      	adds	r0, r0, r3
c0d0077a:	1f00      	subs	r0, r0, #4
c0d0077c:	2303      	movs	r3, #3
c0d0077e:	43db      	mvns	r3, r3
c0d00780:	9301      	str	r3, [sp, #4]
c0d00782:	4252      	negs	r2, r2
c0d00784:	9200      	str	r2, [sp, #0]
c0d00786:	2400      	movs	r4, #0
        bytes_out[i*4+0] = (words_in[word_len-1-i] >> 24);
c0d00788:	9d01      	ldr	r5, [sp, #4]
c0d0078a:	4365      	muls	r5, r4
c0d0078c:	00a6      	lsls	r6, r4, #2
c0d0078e:	1983      	adds	r3, r0, r6
c0d00790:	78da      	ldrb	r2, [r3, #3]
c0d00792:	554a      	strb	r2, [r1, r5]
c0d00794:	194a      	adds	r2, r1, r5
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
c0d00796:	885b      	ldrh	r3, [r3, #2]
c0d00798:	7053      	strb	r3, [r2, #1]
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
c0d0079a:	5983      	ldr	r3, [r0, r6]
c0d0079c:	0a1b      	lsrs	r3, r3, #8
c0d0079e:	7093      	strb	r3, [r2, #2]
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
c0d007a0:	5983      	ldr	r3, [r0, r6]
c0d007a2:	70d3      	strb	r3, [r2, #3]
    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d007a4:	1e64      	subs	r4, r4, #1
c0d007a6:	9a00      	ldr	r2, [sp, #0]
c0d007a8:	42a2      	cmp	r2, r4
c0d007aa:	d1ed      	bne.n	c0d00788 <words_to_bytes+0x1c>
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
    }

    return 0;
c0d007ac:	2000      	movs	r0, #0
c0d007ae:	b002      	add	sp, #8
c0d007b0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d007b2 <bytes_to_words>:
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
c0d007b2:	b5d0      	push	{r4, r6, r7, lr}
c0d007b4:	af02      	add	r7, sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d007b6:	2a00      	cmp	r2, #0
c0d007b8:	d015      	beq.n	c0d007e6 <bytes_to_words+0x34>
c0d007ba:	0093      	lsls	r3, r2, #2
c0d007bc:	18c0      	adds	r0, r0, r3
c0d007be:	1f00      	subs	r0, r0, #4
c0d007c0:	2300      	movs	r3, #0
        words_out[i] = 0;
c0d007c2:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
c0d007c4:	7803      	ldrb	r3, [r0, #0]
c0d007c6:	061b      	lsls	r3, r3, #24
c0d007c8:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
c0d007ca:	7844      	ldrb	r4, [r0, #1]
c0d007cc:	0424      	lsls	r4, r4, #16
c0d007ce:	431c      	orrs	r4, r3
c0d007d0:	600c      	str	r4, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
c0d007d2:	7883      	ldrb	r3, [r0, #2]
c0d007d4:	021b      	lsls	r3, r3, #8
c0d007d6:	4323      	orrs	r3, r4
c0d007d8:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
c0d007da:	78c4      	ldrb	r4, [r0, #3]
c0d007dc:	431c      	orrs	r4, r3
c0d007de:	c110      	stmia	r1!, {r4}
    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d007e0:	1f00      	subs	r0, r0, #4
c0d007e2:	1e52      	subs	r2, r2, #1
c0d007e4:	d1ec      	bne.n	c0d007c0 <bytes_to_words+0xe>
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
    }
    return 0;
c0d007e6:	2000      	movs	r0, #0
c0d007e8:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d007ec <trints_to_words>:
}

//custom conversion straight from trints to words
int trints_to_words(trint_t *trints_in, int32_t words_out[])
{
c0d007ec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007ee:	af03      	add	r7, sp, #12
c0d007f0:	b0a1      	sub	sp, #132	; 0x84
c0d007f2:	9101      	str	r1, [sp, #4]
c0d007f4:	9002      	str	r0, [sp, #8]
c0d007f6:	a814      	add	r0, sp, #80	; 0x50
    int32_t base[13] = {0};
c0d007f8:	2134      	movs	r1, #52	; 0x34
c0d007fa:	f003 f8ff 	bl	c0d039fc <__aeabi_memclr>
c0d007fe:	2430      	movs	r4, #48	; 0x30
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
c0d00800:	2603      	movs	r6, #3
c0d00802:	2005      	movs	r0, #5
c0d00804:	2c30      	cmp	r4, #48	; 0x30
c0d00806:	d000      	beq.n	c0d0080a <trints_to_words+0x1e>
c0d00808:	4606      	mov	r6, r0
        trint_to_trits(trints_in[x], &trits[0], get);
c0d0080a:	9802      	ldr	r0, [sp, #8]
c0d0080c:	5700      	ldrsb	r0, [r0, r4]
c0d0080e:	a912      	add	r1, sp, #72	; 0x48
c0d00810:	4632      	mov	r2, r6
c0d00812:	f7ff fdc9 	bl	c0d003a8 <trint_to_trits>
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d00816:	4833      	ldr	r0, [pc, #204]	; (c0d008e4 <trints_to_words+0xf8>)
c0d00818:	1832      	adds	r2, r6, r0
c0d0081a:	2006      	movs	r0, #6
c0d0081c:	4010      	ands	r0, r2
            // multiply
            {
                int32_t sz = size;
                int32_t carry = 0;
                
                for (int32_t j = 0; j < sz; j++) {
c0d0081e:	1e76      	subs	r6, r6, #1
c0d00820:	9403      	str	r4, [sp, #12]
            
            // add
            {
                int32_t tmp[12];
                // Ignore the last trit (48 is last trint, 2 is last trit in that trint)
                if (x == 48 & i == 2) {
c0d00822:	2c30      	cmp	r4, #48	; 0x30
c0d00824:	9204      	str	r2, [sp, #16]
c0d00826:	d105      	bne.n	c0d00834 <trints_to_words+0x48>
c0d00828:	b2b1      	uxth	r1, r6
c0d0082a:	2902      	cmp	r1, #2
c0d0082c:	d102      	bne.n	c0d00834 <trints_to_words+0x48>
c0d0082e:	a814      	add	r0, sp, #80	; 0x50
                    bigint_add_int(base, 1, tmp, 13);
c0d00830:	2101      	movs	r1, #1
c0d00832:	e003      	b.n	c0d0083c <trints_to_words+0x50>
c0d00834:	a912      	add	r1, sp, #72	; 0x48
                } else {
                    bigint_add_int(base, trits[i]+1, tmp, 13);
c0d00836:	5608      	ldrsb	r0, [r1, r0]
c0d00838:	1c41      	adds	r1, r0, #1
c0d0083a:	a814      	add	r0, sp, #80	; 0x50
c0d0083c:	aa05      	add	r2, sp, #20
c0d0083e:	230d      	movs	r3, #13
c0d00840:	f7ff fe52 	bl	c0d004e8 <bigint_add_int>
c0d00844:	a805      	add	r0, sp, #20
c0d00846:	a914      	add	r1, sp, #80	; 0x50
                }
                memcpy(base, tmp, 52);
c0d00848:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d0084a:	c11c      	stmia	r1!, {r2, r3, r4}
c0d0084c:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d0084e:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00850:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00852:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00854:	c83c      	ldmia	r0!, {r2, r3, r4, r5}
c0d00856:	c13c      	stmia	r1!, {r2, r3, r4, r5}
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
        trint_to_trits(trints_in[x], &trits[0], get);
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d00858:	1e76      	subs	r6, r6, #1
c0d0085a:	9804      	ldr	r0, [sp, #16]
c0d0085c:	1e40      	subs	r0, r0, #1
c0d0085e:	b200      	sxth	r0, r0
c0d00860:	2800      	cmp	r0, #0
c0d00862:	4602      	mov	r2, r0
c0d00864:	9c03      	ldr	r4, [sp, #12]
c0d00866:	dadc      	bge.n	c0d00822 <trints_to_words+0x36>
    int32_t size = 13;
    trit_t trits[5]; // on final call only left 3 trits matter
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
c0d00868:	1e60      	subs	r0, r4, #1
c0d0086a:	2c00      	cmp	r4, #0
c0d0086c:	4604      	mov	r4, r0
c0d0086e:	dcc7      	bgt.n	c0d00800 <trints_to_words+0x14>
                // todo sz>size stuff
            }
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
c0d00870:	481d      	ldr	r0, [pc, #116]	; (c0d008e8 <trints_to_words+0xfc>)
c0d00872:	4478      	add	r0, pc
c0d00874:	a914      	add	r1, sp, #80	; 0x50
c0d00876:	220d      	movs	r2, #13
c0d00878:	f7ff fefb 	bl	c0d00672 <bigint_cmp_bigint>
c0d0087c:	2801      	cmp	r0, #1
c0d0087e:	db14      	blt.n	c0d008aa <trints_to_words+0xbe>
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d00880:	481b      	ldr	r0, [pc, #108]	; (c0d008f0 <trints_to_words+0x104>)
c0d00882:	4478      	add	r0, pc
c0d00884:	ad14      	add	r5, sp, #80	; 0x50
c0d00886:	ac05      	add	r4, sp, #20
c0d00888:	260d      	movs	r6, #13
c0d0088a:	4629      	mov	r1, r5
c0d0088c:	4622      	mov	r2, r4
c0d0088e:	4633      	mov	r3, r6
c0d00890:	f7ff feae 	bl	c0d005f0 <bigint_sub_bigint>
        bigint_not(tmp, 13);
c0d00894:	4620      	mov	r0, r4
c0d00896:	4631      	mov	r1, r6
c0d00898:	f7ff ff0a 	bl	c0d006b0 <bigint_not>
        bigint_add_int(tmp, 1, base, 13);
c0d0089c:	2101      	movs	r1, #1
c0d0089e:	4620      	mov	r0, r4
c0d008a0:	462a      	mov	r2, r5
c0d008a2:	4633      	mov	r3, r6
c0d008a4:	f7ff fe20 	bl	c0d004e8 <bigint_add_int>
c0d008a8:	e010      	b.n	c0d008cc <trints_to_words+0xe0>
c0d008aa:	ad14      	add	r5, sp, #80	; 0x50
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
c0d008ac:	490f      	ldr	r1, [pc, #60]	; (c0d008ec <trints_to_words+0x100>)
c0d008ae:	4479      	add	r1, pc
c0d008b0:	ae05      	add	r6, sp, #20
c0d008b2:	230d      	movs	r3, #13
c0d008b4:	4628      	mov	r0, r5
c0d008b6:	4632      	mov	r2, r6
c0d008b8:	f7ff fe9a 	bl	c0d005f0 <bigint_sub_bigint>
        memcpy(base, tmp, 52);
c0d008bc:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d008be:	c507      	stmia	r5!, {r0, r1, r2}
c0d008c0:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d008c2:	c507      	stmia	r5!, {r0, r1, r2}
c0d008c4:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d008c6:	c507      	stmia	r5!, {r0, r1, r2}
c0d008c8:	ce0f      	ldmia	r6!, {r0, r1, r2, r3}
c0d008ca:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d008cc:	a814      	add	r0, sp, #80	; 0x50
c0d008ce:	9d01      	ldr	r5, [sp, #4]
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }
    
    
    memcpy(words_out, base, 48);
c0d008d0:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d008d2:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d008d4:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d008d6:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d008d8:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d008da:	c51e      	stmia	r5!, {r1, r2, r3, r4}
    return 0;
c0d008dc:	2000      	movs	r0, #0
c0d008de:	b021      	add	sp, #132	; 0x84
c0d008e0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d008e2:	46c0      	nop			; (mov r8, r8)
c0d008e4:	0000ffff 	.word	0x0000ffff
c0d008e8:	0000334e 	.word	0x0000334e
c0d008ec:	00003312 	.word	0x00003312
c0d008f0:	0000333e 	.word	0x0000333e

c0d008f4 <words_to_trints>:
}

//straight from words into trints
int words_to_trints(const int32_t words_in[], trint_t *trints_out)
{
c0d008f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d008f6:	af03      	add	r7, sp, #12
c0d008f8:	b0a5      	sub	sp, #148	; 0x94
c0d008fa:	9100      	str	r1, [sp, #0]
c0d008fc:	4604      	mov	r4, r0
    int32_t base[13] = {0};
c0d008fe:	9408      	str	r4, [sp, #32]
c0d00900:	a818      	add	r0, sp, #96	; 0x60
c0d00902:	2134      	movs	r1, #52	; 0x34
c0d00904:	f003 f87a 	bl	c0d039fc <__aeabi_memclr>
c0d00908:	2500      	movs	r5, #0
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
c0d0090a:	9517      	str	r5, [sp, #92]	; 0x5c
c0d0090c:	a80b      	add	r0, sp, #44	; 0x2c
c0d0090e:	4621      	mov	r1, r4
c0d00910:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d00912:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00914:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d00916:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00918:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d0091a:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d0091c:	20fe      	movs	r0, #254	; 0xfe
c0d0091e:	43c1      	mvns	r1, r0
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
c0d00920:	9808      	ldr	r0, [sp, #32]
c0d00922:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d00924:	2800      	cmp	r0, #0
c0d00926:	9103      	str	r1, [sp, #12]
c0d00928:	db08      	blt.n	c0d0093c <words_to_trints+0x48>
c0d0092a:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
c0d0092c:	4941      	ldr	r1, [pc, #260]	; (c0d00a34 <words_to_trints+0x140>)
c0d0092e:	4479      	add	r1, pc
c0d00930:	aa18      	add	r2, sp, #96	; 0x60
c0d00932:	230d      	movs	r3, #13
c0d00934:	f7ff fe1d 	bl	c0d00572 <bigint_add_bigint>
c0d00938:	9502      	str	r5, [sp, #8]
c0d0093a:	e01b      	b.n	c0d00974 <words_to_trints+0x80>
c0d0093c:	9501      	str	r5, [sp, #4]
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
c0d0093e:	4608      	mov	r0, r1
c0d00940:	30fe      	adds	r0, #254	; 0xfe
c0d00942:	9017      	str	r0, [sp, #92]	; 0x5c
c0d00944:	ad0b      	add	r5, sp, #44	; 0x2c
c0d00946:	260d      	movs	r6, #13
        bigint_not(tmp, 13);
c0d00948:	4628      	mov	r0, r5
c0d0094a:	4631      	mov	r1, r6
c0d0094c:	f7ff feb0 	bl	c0d006b0 <bigint_not>
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
c0d00950:	4935      	ldr	r1, [pc, #212]	; (c0d00a28 <words_to_trints+0x134>)
c0d00952:	4479      	add	r1, pc
c0d00954:	4628      	mov	r0, r5
c0d00956:	4632      	mov	r2, r6
c0d00958:	f7ff fe8b 	bl	c0d00672 <bigint_cmp_bigint>
c0d0095c:	2801      	cmp	r0, #1
c0d0095e:	db49      	blt.n	c0d009f4 <words_to_trints+0x100>
c0d00960:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(tmp, HALF_3, base, 13);
c0d00962:	4932      	ldr	r1, [pc, #200]	; (c0d00a2c <words_to_trints+0x138>)
c0d00964:	4479      	add	r1, pc
c0d00966:	aa18      	add	r2, sp, #96	; 0x60
c0d00968:	230d      	movs	r3, #13
c0d0096a:	f7ff fe41 	bl	c0d005f0 <bigint_sub_bigint>
c0d0096e:	2001      	movs	r0, #1
c0d00970:	9002      	str	r0, [sp, #8]
c0d00972:	9d01      	ldr	r5, [sp, #4]
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
c0d00974:	2403      	movs	r4, #3
c0d00976:	2005      	movs	r0, #5
c0d00978:	9501      	str	r5, [sp, #4]
c0d0097a:	2d30      	cmp	r5, #48	; 0x30
c0d0097c:	d000      	beq.n	c0d00980 <words_to_trints+0x8c>
c0d0097e:	4604      	mov	r4, r0
c0d00980:	a809      	add	r0, sp, #36	; 0x24
        trits_to_trint(&trits[0], send);
c0d00982:	4621      	mov	r1, r4
c0d00984:	f7ff fcd8 	bl	c0d00338 <trits_to_trint>
c0d00988:	2000      	movs	r0, #0
c0d0098a:	4601      	mov	r1, r0
c0d0098c:	9004      	str	r0, [sp, #16]
c0d0098e:	9405      	str	r4, [sp, #20]
c0d00990:	9106      	str	r1, [sp, #24]
c0d00992:	9007      	str	r0, [sp, #28]
c0d00994:	250c      	movs	r5, #12
c0d00996:	9a04      	ldr	r2, [sp, #16]
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
                uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
c0d00998:	00a9      	lsls	r1, r5, #2
c0d0099a:	ac18      	add	r4, sp, #96	; 0x60
c0d0099c:	5860      	ldr	r0, [r4, r1]
c0d0099e:	2a00      	cmp	r2, #0
c0d009a0:	9108      	str	r1, [sp, #32]
c0d009a2:	2603      	movs	r6, #3
c0d009a4:	2300      	movs	r3, #0
                uint64_t q = (lhs / 3) & 0xFFFFFFFF;
                uint8_t r = lhs % 3;
c0d009a6:	4611      	mov	r1, r2
c0d009a8:	4632      	mov	r2, r6
c0d009aa:	f002 ff1d 	bl	c0d037e8 <__aeabi_uldivmod>
                
                base[j] = q;
c0d009ae:	9908      	ldr	r1, [sp, #32]
c0d009b0:	5060      	str	r0, [r4, r1]
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
c0d009b2:	1e68      	subs	r0, r5, #1
c0d009b4:	2d00      	cmp	r5, #0
c0d009b6:	4605      	mov	r5, r0
c0d009b8:	dcee      	bgt.n	c0d00998 <words_to_trints+0xa4>
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
            if (flip_trits) {
                trits[i] = -trits[i];
c0d009ba:	9803      	ldr	r0, [sp, #12]
c0d009bc:	1a80      	subs	r0, r0, r2
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d009be:	32ff      	adds	r2, #255	; 0xff
            if (flip_trits) {
c0d009c0:	9902      	ldr	r1, [sp, #8]
c0d009c2:	2900      	cmp	r1, #0
c0d009c4:	d100      	bne.n	c0d009c8 <words_to_trints+0xd4>
c0d009c6:	4610      	mov	r0, r2
c0d009c8:	a909      	add	r1, sp, #36	; 0x24
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d009ca:	9a06      	ldr	r2, [sp, #24]
c0d009cc:	5488      	strb	r0, [r1, r2]
c0d009ce:	9807      	ldr	r0, [sp, #28]
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
c0d009d0:	1c40      	adds	r0, r0, #1
c0d009d2:	b201      	sxth	r1, r0
c0d009d4:	9c05      	ldr	r4, [sp, #20]
c0d009d6:	42a1      	cmp	r1, r4
c0d009d8:	dbda      	blt.n	c0d00990 <words_to_trints+0x9c>
c0d009da:	a809      	add	r0, sp, #36	; 0x24
            if (flip_trits) {
                trits[i] = -trits[i];
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
c0d009dc:	4621      	mov	r1, r4
c0d009de:	f7ff fcab 	bl	c0d00338 <trits_to_trint>
c0d009e2:	9900      	ldr	r1, [sp, #0]
c0d009e4:	9d01      	ldr	r5, [sp, #4]
c0d009e6:	5548      	strb	r0, [r1, r5]
    }
    
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
c0d009e8:	1c6d      	adds	r5, r5, #1
c0d009ea:	2d31      	cmp	r5, #49	; 0x31
c0d009ec:	d1c2      	bne.n	c0d00974 <words_to_trints+0x80>
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
    }
    return 0;
c0d009ee:	2000      	movs	r0, #0
c0d009f0:	b025      	add	sp, #148	; 0x94
c0d009f2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d009f4:	ad0b      	add	r5, sp, #44	; 0x2c
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
c0d009f6:	2101      	movs	r1, #1
c0d009f8:	ae18      	add	r6, sp, #96	; 0x60
c0d009fa:	240d      	movs	r4, #13
c0d009fc:	4628      	mov	r0, r5
c0d009fe:	4632      	mov	r2, r6
c0d00a00:	4623      	mov	r3, r4
c0d00a02:	f7ff fd71 	bl	c0d004e8 <bigint_add_int>
            bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d00a06:	480a      	ldr	r0, [pc, #40]	; (c0d00a30 <words_to_trints+0x13c>)
c0d00a08:	4478      	add	r0, pc
c0d00a0a:	4631      	mov	r1, r6
c0d00a0c:	462a      	mov	r2, r5
c0d00a0e:	4623      	mov	r3, r4
c0d00a10:	f7ff fdee 	bl	c0d005f0 <bigint_sub_bigint>
            memcpy(base, tmp, 52);
c0d00a14:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00a16:	c607      	stmia	r6!, {r0, r1, r2}
c0d00a18:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00a1a:	c607      	stmia	r6!, {r0, r1, r2}
c0d00a1c:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00a1e:	c607      	stmia	r6!, {r0, r1, r2}
c0d00a20:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00a22:	c60f      	stmia	r6!, {r0, r1, r2, r3}
c0d00a24:	9d01      	ldr	r5, [sp, #4]
c0d00a26:	e787      	b.n	c0d00938 <words_to_trints+0x44>
c0d00a28:	0000326e 	.word	0x0000326e
c0d00a2c:	0000325c 	.word	0x0000325c
c0d00a30:	000031b8 	.word	0x000031b8
c0d00a34:	00003292 	.word	0x00003292

c0d00a38 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00a38:	b580      	push	{r7, lr}
c0d00a3a:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00a3c:	2003      	movs	r0, #3
c0d00a3e:	01c1      	lsls	r1, r0, #7
c0d00a40:	4802      	ldr	r0, [pc, #8]	; (c0d00a4c <kerl_initialize+0x14>)
c0d00a42:	f001 fbfb 	bl	c0d0223c <cx_keccak_init>
    return 0;
c0d00a46:	2000      	movs	r0, #0
c0d00a48:	bd80      	pop	{r7, pc}
c0d00a4a:	46c0      	nop			; (mov r8, r8)
c0d00a4c:	20001800 	.word	0x20001800

c0d00a50 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00a50:	b580      	push	{r7, lr}
c0d00a52:	af00      	add	r7, sp, #0
c0d00a54:	b082      	sub	sp, #8
c0d00a56:	460b      	mov	r3, r1
c0d00a58:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00a5a:	4805      	ldr	r0, [pc, #20]	; (c0d00a70 <kerl_absorb_bytes+0x20>)
c0d00a5c:	4669      	mov	r1, sp
c0d00a5e:	6008      	str	r0, [r1, #0]
c0d00a60:	4804      	ldr	r0, [pc, #16]	; (c0d00a74 <kerl_absorb_bytes+0x24>)
c0d00a62:	2101      	movs	r1, #1
c0d00a64:	f001 fc08 	bl	c0d02278 <cx_hash>
c0d00a68:	2000      	movs	r0, #0
    return 0;
c0d00a6a:	b002      	add	sp, #8
c0d00a6c:	bd80      	pop	{r7, pc}
c0d00a6e:	46c0      	nop			; (mov r8, r8)
c0d00a70:	200019a8 	.word	0x200019a8
c0d00a74:	20001800 	.word	0x20001800

c0d00a78 <kerl_absorb_trints>:
    return 0;
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
c0d00a78:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a7a:	af03      	add	r7, sp, #12
c0d00a7c:	b09b      	sub	sp, #108	; 0x6c
c0d00a7e:	460e      	mov	r6, r1
c0d00a80:	4604      	mov	r4, r0
c0d00a82:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00a84:	4630      	mov	r0, r6
c0d00a86:	f002 fd39 	bl	c0d034fc <__aeabi_uidiv>
c0d00a8a:	2e31      	cmp	r6, #49	; 0x31
c0d00a8c:	d31c      	bcc.n	c0d00ac8 <kerl_absorb_trints+0x50>
c0d00a8e:	2500      	movs	r5, #0
c0d00a90:	9402      	str	r4, [sp, #8]
c0d00a92:	9001      	str	r0, [sp, #4]
c0d00a94:	ae0f      	add	r6, sp, #60	; 0x3c
        // First, convert to bytes
        int32_t words[12];
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
c0d00a96:	4620      	mov	r0, r4
c0d00a98:	4631      	mov	r1, r6
c0d00a9a:	f7ff fea7 	bl	c0d007ec <trints_to_words>
c0d00a9e:	ac03      	add	r4, sp, #12
        words_to_bytes(words, bytes, 12);
c0d00aa0:	220c      	movs	r2, #12
c0d00aa2:	4630      	mov	r0, r6
c0d00aa4:	4621      	mov	r1, r4
c0d00aa6:	f7ff fe61 	bl	c0d0076c <words_to_bytes>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00aaa:	4668      	mov	r0, sp
c0d00aac:	4908      	ldr	r1, [pc, #32]	; (c0d00ad0 <kerl_absorb_trints+0x58>)
c0d00aae:	6001      	str	r1, [r0, #0]
c0d00ab0:	2101      	movs	r1, #1
c0d00ab2:	2330      	movs	r3, #48	; 0x30
c0d00ab4:	4807      	ldr	r0, [pc, #28]	; (c0d00ad4 <kerl_absorb_trints+0x5c>)
c0d00ab6:	4622      	mov	r2, r4
c0d00ab8:	9c02      	ldr	r4, [sp, #8]
c0d00aba:	f001 fbdd 	bl	c0d02278 <cx_hash>
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00abe:	1c6d      	adds	r5, r5, #1
c0d00ac0:	b2e8      	uxtb	r0, r5
c0d00ac2:	9901      	ldr	r1, [sp, #4]
c0d00ac4:	4288      	cmp	r0, r1
c0d00ac6:	d3e5      	bcc.n	c0d00a94 <kerl_absorb_trints+0x1c>
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
c0d00ac8:	2000      	movs	r0, #0
c0d00aca:	b01b      	add	sp, #108	; 0x6c
c0d00acc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ace:	46c0      	nop			; (mov r8, r8)
c0d00ad0:	200019a8 	.word	0x200019a8
c0d00ad4:	20001800 	.word	0x20001800

c0d00ad8 <kerl_squeeze_trints>:
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
c0d00ad8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00ada:	af03      	add	r7, sp, #12
c0d00adc:	b091      	sub	sp, #68	; 0x44
c0d00ade:	4605      	mov	r5, r0
    (void) len;

    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
c0d00ae0:	4c1b      	ldr	r4, [pc, #108]	; (c0d00b50 <kerl_squeeze_trints+0x78>)
c0d00ae2:	ae05      	add	r6, sp, #20
c0d00ae4:	220c      	movs	r2, #12
c0d00ae6:	4620      	mov	r0, r4
c0d00ae8:	4631      	mov	r1, r6
c0d00aea:	f7ff fe62 	bl	c0d007b2 <bytes_to_words>
    words_to_trints(words, &trints_out[0]);
c0d00aee:	4630      	mov	r0, r6
c0d00af0:	9502      	str	r5, [sp, #8]
c0d00af2:	4629      	mov	r1, r5
c0d00af4:	f7ff fefe 	bl	c0d008f4 <words_to_trints>


    //-- Setting last trit to 0
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
c0d00af8:	2030      	movs	r0, #48	; 0x30
c0d00afa:	9003      	str	r0, [sp, #12]
c0d00afc:	5628      	ldrsb	r0, [r5, r0]
c0d00afe:	ad04      	add	r5, sp, #16
c0d00b00:	2203      	movs	r2, #3
c0d00b02:	9201      	str	r2, [sp, #4]
c0d00b04:	4629      	mov	r1, r5
c0d00b06:	f7ff fc4f 	bl	c0d003a8 <trint_to_trits>
c0d00b0a:	2600      	movs	r6, #0
    trits[2] = 0; //set last trit to 0
c0d00b0c:	70ae      	strb	r6, [r5, #2]
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00b0e:	4628      	mov	r0, r5
c0d00b10:	9d01      	ldr	r5, [sp, #4]
c0d00b12:	4629      	mov	r1, r5
c0d00b14:	f7ff fc10 	bl	c0d00338 <trits_to_trint>
c0d00b18:	9903      	ldr	r1, [sp, #12]
c0d00b1a:	9a02      	ldr	r2, [sp, #8]
c0d00b1c:	5450      	strb	r0, [r2, r1]

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
c0d00b1e:	1ba0      	subs	r0, r4, r6
c0d00b20:	7801      	ldrb	r1, [r0, #0]
c0d00b22:	43c9      	mvns	r1, r1
c0d00b24:	7001      	strb	r1, [r0, #0]
    trints_out[48] = trits_to_trint(&trits[0], 3);

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d00b26:	1e76      	subs	r6, r6, #1
c0d00b28:	4630      	mov	r0, r6
c0d00b2a:	3030      	adds	r0, #48	; 0x30
c0d00b2c:	d1f7      	bne.n	c0d00b1e <kerl_squeeze_trints+0x46>
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d00b2e:	01e9      	lsls	r1, r5, #7
c0d00b30:	4d08      	ldr	r5, [pc, #32]	; (c0d00b54 <kerl_squeeze_trints+0x7c>)
c0d00b32:	4628      	mov	r0, r5
c0d00b34:	f001 fb82 	bl	c0d0223c <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00b38:	4668      	mov	r0, sp
c0d00b3a:	6004      	str	r4, [r0, #0]
c0d00b3c:	2101      	movs	r1, #1
c0d00b3e:	2330      	movs	r3, #48	; 0x30
c0d00b40:	4628      	mov	r0, r5
c0d00b42:	4622      	mov	r2, r4
c0d00b44:	f001 fb98 	bl	c0d02278 <cx_hash>
c0d00b48:	2000      	movs	r0, #0
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
c0d00b4a:	b011      	add	sp, #68	; 0x44
c0d00b4c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00b4e:	46c0      	nop			; (mov r8, r8)
c0d00b50:	200019a8 	.word	0x200019a8
c0d00b54:	20001800 	.word	0x20001800

c0d00b58 <nvram_is_init>:
    
return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00b58:	b580      	push	{r7, lr}
c0d00b5a:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00b5c:	4804      	ldr	r0, [pc, #16]	; (c0d00b70 <nvram_is_init+0x18>)
c0d00b5e:	f001 fac1 	bl	c0d020e4 <pic>
c0d00b62:	7801      	ldrb	r1, [r0, #0]
c0d00b64:	2000      	movs	r0, #0
c0d00b66:	2901      	cmp	r1, #1
c0d00b68:	d100      	bne.n	c0d00b6c <nvram_is_init+0x14>
c0d00b6a:	4608      	mov	r0, r1
    else return true;
}
c0d00b6c:	bd80      	pop	{r7, pc}
c0d00b6e:	46c0      	nop			; (mov r8, r8)
c0d00b70:	c0d03f00 	.word	0xc0d03f00

c0d00b74 <io_exchange_al>:
 ------------------- Not Modified ------------------
 --------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00b74:	b5b0      	push	{r4, r5, r7, lr}
c0d00b76:	af02      	add	r7, sp, #8
c0d00b78:	4605      	mov	r5, r0
c0d00b7a:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00b7c:	4028      	ands	r0, r5
c0d00b7e:	2400      	movs	r4, #0
c0d00b80:	2801      	cmp	r0, #1
c0d00b82:	d013      	beq.n	c0d00bac <io_exchange_al+0x38>
c0d00b84:	2802      	cmp	r0, #2
c0d00b86:	d113      	bne.n	c0d00bb0 <io_exchange_al+0x3c>
        case CHANNEL_KEYBOARD:
            break;
            
            // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
        case CHANNEL_SPI:
            if (tx_len) {
c0d00b88:	2900      	cmp	r1, #0
c0d00b8a:	d008      	beq.n	c0d00b9e <io_exchange_al+0x2a>
                io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00b8c:	480b      	ldr	r0, [pc, #44]	; (c0d00bbc <io_exchange_al+0x48>)
c0d00b8e:	f001 fc65 	bl	c0d0245c <io_seproxyhal_spi_send>
                
                if (channel & IO_RESET_AFTER_REPLIED) {
c0d00b92:	b268      	sxtb	r0, r5
c0d00b94:	2800      	cmp	r0, #0
c0d00b96:	da09      	bge.n	c0d00bac <io_exchange_al+0x38>
                    reset();
c0d00b98:	f001 fada 	bl	c0d02150 <reset>
c0d00b9c:	e006      	b.n	c0d00bac <io_exchange_al+0x38>
                }
                return 0; // nothing received from the master so far (it's a tx
                // transaction)
            } else {
                return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00b9e:	2041      	movs	r0, #65	; 0x41
c0d00ba0:	0081      	lsls	r1, r0, #2
c0d00ba2:	4806      	ldr	r0, [pc, #24]	; (c0d00bbc <io_exchange_al+0x48>)
c0d00ba4:	2200      	movs	r2, #0
c0d00ba6:	f001 fc93 	bl	c0d024d0 <io_seproxyhal_spi_recv>
c0d00baa:	4604      	mov	r4, r0
            
        default:
            THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00bac:	4620      	mov	r0, r4
c0d00bae:	bdb0      	pop	{r4, r5, r7, pc}
                return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                              sizeof(G_io_apdu_buffer), 0);
            }
            
        default:
            THROW(INVALID_PARAMETER);
c0d00bb0:	4803      	ldr	r0, [pc, #12]	; (c0d00bc0 <io_exchange_al+0x4c>)
c0d00bb2:	6800      	ldr	r0, [r0, #0]
c0d00bb4:	2102      	movs	r1, #2
c0d00bb6:	f002 ffc3 	bl	c0d03b40 <longjmp>
c0d00bba:	46c0      	nop			; (mov r8, r8)
c0d00bbc:	20001bcc 	.word	0x20001bcc
c0d00bc0:	20001b7c 	.word	0x20001b7c

c0d00bc4 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00bc4:	b580      	push	{r7, lr}
c0d00bc6:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00bc8:	f000 ff1c 	bl	c0d01a04 <io_seproxyhal_display_default>
}
c0d00bcc:	bd80      	pop	{r7, pc}
	...

c0d00bd0 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00bd0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00bd2:	af03      	add	r7, sp, #12
c0d00bd4:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed
    
    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00bd6:	48a6      	ldr	r0, [pc, #664]	; (c0d00e70 <io_event+0x2a0>)
c0d00bd8:	7800      	ldrb	r0, [r0, #0]
c0d00bda:	2805      	cmp	r0, #5
c0d00bdc:	d02e      	beq.n	c0d00c3c <io_event+0x6c>
c0d00bde:	280d      	cmp	r0, #13
c0d00be0:	d04e      	beq.n	c0d00c80 <io_event+0xb0>
c0d00be2:	280c      	cmp	r0, #12
c0d00be4:	d000      	beq.n	c0d00be8 <io_event+0x18>
c0d00be6:	e13a      	b.n	c0d00e5e <io_event+0x28e>
        case SEPROXYHAL_TAG_FINGER_EVENT:
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00be8:	4ea2      	ldr	r6, [pc, #648]	; (c0d00e74 <io_event+0x2a4>)
c0d00bea:	2001      	movs	r0, #1
c0d00bec:	7630      	strb	r0, [r6, #24]
c0d00bee:	2500      	movs	r5, #0
c0d00bf0:	61f5      	str	r5, [r6, #28]
c0d00bf2:	4634      	mov	r4, r6
c0d00bf4:	3418      	adds	r4, #24
c0d00bf6:	4620      	mov	r0, r4
c0d00bf8:	f001 fbf6 	bl	c0d023e8 <os_ux>
c0d00bfc:	61f0      	str	r0, [r6, #28]
c0d00bfe:	499e      	ldr	r1, [pc, #632]	; (c0d00e78 <io_event+0x2a8>)
c0d00c00:	4288      	cmp	r0, r1
c0d00c02:	d100      	bne.n	c0d00c06 <io_event+0x36>
c0d00c04:	e12b      	b.n	c0d00e5e <io_event+0x28e>
c0d00c06:	2800      	cmp	r0, #0
c0d00c08:	d100      	bne.n	c0d00c0c <io_event+0x3c>
c0d00c0a:	e128      	b.n	c0d00e5e <io_event+0x28e>
c0d00c0c:	499b      	ldr	r1, [pc, #620]	; (c0d00e7c <io_event+0x2ac>)
c0d00c0e:	4288      	cmp	r0, r1
c0d00c10:	d000      	beq.n	c0d00c14 <io_event+0x44>
c0d00c12:	e0ac      	b.n	c0d00d6e <io_event+0x19e>
c0d00c14:	2003      	movs	r0, #3
c0d00c16:	7630      	strb	r0, [r6, #24]
c0d00c18:	61f5      	str	r5, [r6, #28]
c0d00c1a:	4620      	mov	r0, r4
c0d00c1c:	f001 fbe4 	bl	c0d023e8 <os_ux>
c0d00c20:	61f0      	str	r0, [r6, #28]
c0d00c22:	f000 fda5 	bl	c0d01770 <io_seproxyhal_init_ux>
c0d00c26:	60b5      	str	r5, [r6, #8]
c0d00c28:	6830      	ldr	r0, [r6, #0]
c0d00c2a:	2800      	cmp	r0, #0
c0d00c2c:	d100      	bne.n	c0d00c30 <io_event+0x60>
c0d00c2e:	e116      	b.n	c0d00e5e <io_event+0x28e>
c0d00c30:	69f0      	ldr	r0, [r6, #28]
c0d00c32:	4991      	ldr	r1, [pc, #580]	; (c0d00e78 <io_event+0x2a8>)
c0d00c34:	4288      	cmp	r0, r1
c0d00c36:	d000      	beq.n	c0d00c3a <io_event+0x6a>
c0d00c38:	e096      	b.n	c0d00d68 <io_event+0x198>
c0d00c3a:	e110      	b.n	c0d00e5e <io_event+0x28e>
            break;
            
        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c3c:	4d8d      	ldr	r5, [pc, #564]	; (c0d00e74 <io_event+0x2a4>)
c0d00c3e:	2001      	movs	r0, #1
c0d00c40:	7628      	strb	r0, [r5, #24]
c0d00c42:	2600      	movs	r6, #0
c0d00c44:	61ee      	str	r6, [r5, #28]
c0d00c46:	462c      	mov	r4, r5
c0d00c48:	3418      	adds	r4, #24
c0d00c4a:	4620      	mov	r0, r4
c0d00c4c:	f001 fbcc 	bl	c0d023e8 <os_ux>
c0d00c50:	4601      	mov	r1, r0
c0d00c52:	61e9      	str	r1, [r5, #28]
c0d00c54:	4889      	ldr	r0, [pc, #548]	; (c0d00e7c <io_event+0x2ac>)
c0d00c56:	4281      	cmp	r1, r0
c0d00c58:	d15d      	bne.n	c0d00d16 <io_event+0x146>
c0d00c5a:	2003      	movs	r0, #3
c0d00c5c:	7628      	strb	r0, [r5, #24]
c0d00c5e:	61ee      	str	r6, [r5, #28]
c0d00c60:	4620      	mov	r0, r4
c0d00c62:	f001 fbc1 	bl	c0d023e8 <os_ux>
c0d00c66:	61e8      	str	r0, [r5, #28]
c0d00c68:	f000 fd82 	bl	c0d01770 <io_seproxyhal_init_ux>
c0d00c6c:	60ae      	str	r6, [r5, #8]
c0d00c6e:	6828      	ldr	r0, [r5, #0]
c0d00c70:	2800      	cmp	r0, #0
c0d00c72:	d100      	bne.n	c0d00c76 <io_event+0xa6>
c0d00c74:	e0f3      	b.n	c0d00e5e <io_event+0x28e>
c0d00c76:	69e8      	ldr	r0, [r5, #28]
c0d00c78:	497f      	ldr	r1, [pc, #508]	; (c0d00e78 <io_event+0x2a8>)
c0d00c7a:	4288      	cmp	r0, r1
c0d00c7c:	d148      	bne.n	c0d00d10 <io_event+0x140>
c0d00c7e:	e0ee      	b.n	c0d00e5e <io_event+0x28e>
            break;
            
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            if (UX_DISPLAYED()) {
c0d00c80:	4d7c      	ldr	r5, [pc, #496]	; (c0d00e74 <io_event+0x2a4>)
c0d00c82:	6868      	ldr	r0, [r5, #4]
c0d00c84:	68a9      	ldr	r1, [r5, #8]
c0d00c86:	4281      	cmp	r1, r0
c0d00c88:	d300      	bcc.n	c0d00c8c <io_event+0xbc>
c0d00c8a:	e0e8      	b.n	c0d00e5e <io_event+0x28e>
                // TODO perform actions after all screen elements have been
                // displayed
            } else {
                UX_DISPLAYED_EVENT();
c0d00c8c:	2001      	movs	r0, #1
c0d00c8e:	7628      	strb	r0, [r5, #24]
c0d00c90:	2600      	movs	r6, #0
c0d00c92:	61ee      	str	r6, [r5, #28]
c0d00c94:	462c      	mov	r4, r5
c0d00c96:	3418      	adds	r4, #24
c0d00c98:	4620      	mov	r0, r4
c0d00c9a:	f001 fba5 	bl	c0d023e8 <os_ux>
c0d00c9e:	61e8      	str	r0, [r5, #28]
c0d00ca0:	4975      	ldr	r1, [pc, #468]	; (c0d00e78 <io_event+0x2a8>)
c0d00ca2:	4288      	cmp	r0, r1
c0d00ca4:	d100      	bne.n	c0d00ca8 <io_event+0xd8>
c0d00ca6:	e0da      	b.n	c0d00e5e <io_event+0x28e>
c0d00ca8:	2800      	cmp	r0, #0
c0d00caa:	d100      	bne.n	c0d00cae <io_event+0xde>
c0d00cac:	e0d7      	b.n	c0d00e5e <io_event+0x28e>
c0d00cae:	4973      	ldr	r1, [pc, #460]	; (c0d00e7c <io_event+0x2ac>)
c0d00cb0:	4288      	cmp	r0, r1
c0d00cb2:	d000      	beq.n	c0d00cb6 <io_event+0xe6>
c0d00cb4:	e08d      	b.n	c0d00dd2 <io_event+0x202>
c0d00cb6:	2003      	movs	r0, #3
c0d00cb8:	7628      	strb	r0, [r5, #24]
c0d00cba:	61ee      	str	r6, [r5, #28]
c0d00cbc:	4620      	mov	r0, r4
c0d00cbe:	f001 fb93 	bl	c0d023e8 <os_ux>
c0d00cc2:	61e8      	str	r0, [r5, #28]
c0d00cc4:	f000 fd54 	bl	c0d01770 <io_seproxyhal_init_ux>
c0d00cc8:	60ae      	str	r6, [r5, #8]
c0d00cca:	6828      	ldr	r0, [r5, #0]
c0d00ccc:	2800      	cmp	r0, #0
c0d00cce:	d100      	bne.n	c0d00cd2 <io_event+0x102>
c0d00cd0:	e0c5      	b.n	c0d00e5e <io_event+0x28e>
c0d00cd2:	69e8      	ldr	r0, [r5, #28]
c0d00cd4:	4968      	ldr	r1, [pc, #416]	; (c0d00e78 <io_event+0x2a8>)
c0d00cd6:	4288      	cmp	r0, r1
c0d00cd8:	d178      	bne.n	c0d00dcc <io_event+0x1fc>
c0d00cda:	e0c0      	b.n	c0d00e5e <io_event+0x28e>
        case SEPROXYHAL_TAG_FINGER_EVENT:
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
            break;
            
        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00cdc:	6868      	ldr	r0, [r5, #4]
c0d00cde:	4286      	cmp	r6, r0
c0d00ce0:	d300      	bcc.n	c0d00ce4 <io_event+0x114>
c0d00ce2:	e0bc      	b.n	c0d00e5e <io_event+0x28e>
c0d00ce4:	f001 fbd8 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d00ce8:	2800      	cmp	r0, #0
c0d00cea:	d000      	beq.n	c0d00cee <io_event+0x11e>
c0d00cec:	e0b7      	b.n	c0d00e5e <io_event+0x28e>
c0d00cee:	68a8      	ldr	r0, [r5, #8]
c0d00cf0:	68e9      	ldr	r1, [r5, #12]
c0d00cf2:	2438      	movs	r4, #56	; 0x38
c0d00cf4:	4360      	muls	r0, r4
c0d00cf6:	682a      	ldr	r2, [r5, #0]
c0d00cf8:	1810      	adds	r0, r2, r0
c0d00cfa:	2900      	cmp	r1, #0
c0d00cfc:	d100      	bne.n	c0d00d00 <io_event+0x130>
c0d00cfe:	e085      	b.n	c0d00e0c <io_event+0x23c>
c0d00d00:	4788      	blx	r1
c0d00d02:	2800      	cmp	r0, #0
c0d00d04:	d000      	beq.n	c0d00d08 <io_event+0x138>
c0d00d06:	e081      	b.n	c0d00e0c <io_event+0x23c>
c0d00d08:	68a8      	ldr	r0, [r5, #8]
c0d00d0a:	1c46      	adds	r6, r0, #1
c0d00d0c:	60ae      	str	r6, [r5, #8]
c0d00d0e:	6828      	ldr	r0, [r5, #0]
c0d00d10:	2800      	cmp	r0, #0
c0d00d12:	d1e3      	bne.n	c0d00cdc <io_event+0x10c>
c0d00d14:	e0a3      	b.n	c0d00e5e <io_event+0x28e>
c0d00d16:	6928      	ldr	r0, [r5, #16]
c0d00d18:	2800      	cmp	r0, #0
c0d00d1a:	d100      	bne.n	c0d00d1e <io_event+0x14e>
c0d00d1c:	e09f      	b.n	c0d00e5e <io_event+0x28e>
c0d00d1e:	4a56      	ldr	r2, [pc, #344]	; (c0d00e78 <io_event+0x2a8>)
c0d00d20:	4291      	cmp	r1, r2
c0d00d22:	d100      	bne.n	c0d00d26 <io_event+0x156>
c0d00d24:	e09b      	b.n	c0d00e5e <io_event+0x28e>
c0d00d26:	2900      	cmp	r1, #0
c0d00d28:	d100      	bne.n	c0d00d2c <io_event+0x15c>
c0d00d2a:	e098      	b.n	c0d00e5e <io_event+0x28e>
c0d00d2c:	4950      	ldr	r1, [pc, #320]	; (c0d00e70 <io_event+0x2a0>)
c0d00d2e:	78c9      	ldrb	r1, [r1, #3]
c0d00d30:	0849      	lsrs	r1, r1, #1
c0d00d32:	f000 fea9 	bl	c0d01a88 <io_seproxyhal_button_push>
c0d00d36:	e092      	b.n	c0d00e5e <io_event+0x28e>
    // needed
    
    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
        case SEPROXYHAL_TAG_FINGER_EVENT:
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00d38:	6870      	ldr	r0, [r6, #4]
c0d00d3a:	4285      	cmp	r5, r0
c0d00d3c:	d300      	bcc.n	c0d00d40 <io_event+0x170>
c0d00d3e:	e08e      	b.n	c0d00e5e <io_event+0x28e>
c0d00d40:	f001 fbaa 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d00d44:	2800      	cmp	r0, #0
c0d00d46:	d000      	beq.n	c0d00d4a <io_event+0x17a>
c0d00d48:	e089      	b.n	c0d00e5e <io_event+0x28e>
c0d00d4a:	68b0      	ldr	r0, [r6, #8]
c0d00d4c:	68f1      	ldr	r1, [r6, #12]
c0d00d4e:	2438      	movs	r4, #56	; 0x38
c0d00d50:	4360      	muls	r0, r4
c0d00d52:	6832      	ldr	r2, [r6, #0]
c0d00d54:	1810      	adds	r0, r2, r0
c0d00d56:	2900      	cmp	r1, #0
c0d00d58:	d076      	beq.n	c0d00e48 <io_event+0x278>
c0d00d5a:	4788      	blx	r1
c0d00d5c:	2800      	cmp	r0, #0
c0d00d5e:	d173      	bne.n	c0d00e48 <io_event+0x278>
c0d00d60:	68b0      	ldr	r0, [r6, #8]
c0d00d62:	1c45      	adds	r5, r0, #1
c0d00d64:	60b5      	str	r5, [r6, #8]
c0d00d66:	6830      	ldr	r0, [r6, #0]
c0d00d68:	2800      	cmp	r0, #0
c0d00d6a:	d1e5      	bne.n	c0d00d38 <io_event+0x168>
c0d00d6c:	e077      	b.n	c0d00e5e <io_event+0x28e>
c0d00d6e:	88b0      	ldrh	r0, [r6, #4]
c0d00d70:	9004      	str	r0, [sp, #16]
c0d00d72:	6830      	ldr	r0, [r6, #0]
c0d00d74:	9003      	str	r0, [sp, #12]
c0d00d76:	483e      	ldr	r0, [pc, #248]	; (c0d00e70 <io_event+0x2a0>)
c0d00d78:	4601      	mov	r1, r0
c0d00d7a:	79cc      	ldrb	r4, [r1, #7]
c0d00d7c:	798b      	ldrb	r3, [r1, #6]
c0d00d7e:	794d      	ldrb	r5, [r1, #5]
c0d00d80:	790a      	ldrb	r2, [r1, #4]
c0d00d82:	4630      	mov	r0, r6
c0d00d84:	78ce      	ldrb	r6, [r1, #3]
c0d00d86:	68c1      	ldr	r1, [r0, #12]
c0d00d88:	4668      	mov	r0, sp
c0d00d8a:	6006      	str	r6, [r0, #0]
c0d00d8c:	6041      	str	r1, [r0, #4]
c0d00d8e:	0212      	lsls	r2, r2, #8
c0d00d90:	432a      	orrs	r2, r5
c0d00d92:	021b      	lsls	r3, r3, #8
c0d00d94:	4323      	orrs	r3, r4
c0d00d96:	9803      	ldr	r0, [sp, #12]
c0d00d98:	9904      	ldr	r1, [sp, #16]
c0d00d9a:	f000 fd63 	bl	c0d01864 <io_seproxyhal_touch_element_callback>
c0d00d9e:	e05e      	b.n	c0d00e5e <io_event+0x28e>
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            if (UX_DISPLAYED()) {
                // TODO perform actions after all screen elements have been
                // displayed
            } else {
                UX_DISPLAYED_EVENT();
c0d00da0:	6868      	ldr	r0, [r5, #4]
c0d00da2:	4286      	cmp	r6, r0
c0d00da4:	d25b      	bcs.n	c0d00e5e <io_event+0x28e>
c0d00da6:	f001 fb77 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d00daa:	2800      	cmp	r0, #0
c0d00dac:	d157      	bne.n	c0d00e5e <io_event+0x28e>
c0d00dae:	68a8      	ldr	r0, [r5, #8]
c0d00db0:	68e9      	ldr	r1, [r5, #12]
c0d00db2:	2438      	movs	r4, #56	; 0x38
c0d00db4:	4360      	muls	r0, r4
c0d00db6:	682a      	ldr	r2, [r5, #0]
c0d00db8:	1810      	adds	r0, r2, r0
c0d00dba:	2900      	cmp	r1, #0
c0d00dbc:	d026      	beq.n	c0d00e0c <io_event+0x23c>
c0d00dbe:	4788      	blx	r1
c0d00dc0:	2800      	cmp	r0, #0
c0d00dc2:	d123      	bne.n	c0d00e0c <io_event+0x23c>
c0d00dc4:	68a8      	ldr	r0, [r5, #8]
c0d00dc6:	1c46      	adds	r6, r0, #1
c0d00dc8:	60ae      	str	r6, [r5, #8]
c0d00dca:	6828      	ldr	r0, [r5, #0]
c0d00dcc:	2800      	cmp	r0, #0
c0d00dce:	d1e7      	bne.n	c0d00da0 <io_event+0x1d0>
c0d00dd0:	e045      	b.n	c0d00e5e <io_event+0x28e>
c0d00dd2:	6828      	ldr	r0, [r5, #0]
c0d00dd4:	2800      	cmp	r0, #0
c0d00dd6:	d030      	beq.n	c0d00e3a <io_event+0x26a>
c0d00dd8:	68a8      	ldr	r0, [r5, #8]
c0d00dda:	6869      	ldr	r1, [r5, #4]
c0d00ddc:	4288      	cmp	r0, r1
c0d00dde:	d22c      	bcs.n	c0d00e3a <io_event+0x26a>
c0d00de0:	f001 fb5a 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d00de4:	2800      	cmp	r0, #0
c0d00de6:	d128      	bne.n	c0d00e3a <io_event+0x26a>
c0d00de8:	68a8      	ldr	r0, [r5, #8]
c0d00dea:	68e9      	ldr	r1, [r5, #12]
c0d00dec:	2438      	movs	r4, #56	; 0x38
c0d00dee:	4360      	muls	r0, r4
c0d00df0:	682a      	ldr	r2, [r5, #0]
c0d00df2:	1810      	adds	r0, r2, r0
c0d00df4:	2900      	cmp	r1, #0
c0d00df6:	d015      	beq.n	c0d00e24 <io_event+0x254>
c0d00df8:	4788      	blx	r1
c0d00dfa:	2800      	cmp	r0, #0
c0d00dfc:	d112      	bne.n	c0d00e24 <io_event+0x254>
c0d00dfe:	68a8      	ldr	r0, [r5, #8]
c0d00e00:	1c40      	adds	r0, r0, #1
c0d00e02:	60a8      	str	r0, [r5, #8]
c0d00e04:	6829      	ldr	r1, [r5, #0]
c0d00e06:	2900      	cmp	r1, #0
c0d00e08:	d1e7      	bne.n	c0d00dda <io_event+0x20a>
c0d00e0a:	e016      	b.n	c0d00e3a <io_event+0x26a>
c0d00e0c:	2801      	cmp	r0, #1
c0d00e0e:	d103      	bne.n	c0d00e18 <io_event+0x248>
c0d00e10:	68a8      	ldr	r0, [r5, #8]
c0d00e12:	4344      	muls	r4, r0
c0d00e14:	6828      	ldr	r0, [r5, #0]
c0d00e16:	1900      	adds	r0, r0, r4
c0d00e18:	f000 fdf4 	bl	c0d01a04 <io_seproxyhal_display_default>
c0d00e1c:	68a8      	ldr	r0, [r5, #8]
c0d00e1e:	1c40      	adds	r0, r0, #1
c0d00e20:	60a8      	str	r0, [r5, #8]
c0d00e22:	e01c      	b.n	c0d00e5e <io_event+0x28e>
c0d00e24:	2801      	cmp	r0, #1
c0d00e26:	d103      	bne.n	c0d00e30 <io_event+0x260>
c0d00e28:	68a8      	ldr	r0, [r5, #8]
c0d00e2a:	4344      	muls	r4, r0
c0d00e2c:	6828      	ldr	r0, [r5, #0]
c0d00e2e:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00e30:	f000 fde8 	bl	c0d01a04 <io_seproxyhal_display_default>
c0d00e34:	68a8      	ldr	r0, [r5, #8]
c0d00e36:	1c40      	adds	r0, r0, #1
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            if (UX_DISPLAYED()) {
                // TODO perform actions after all screen elements have been
                // displayed
            } else {
                UX_DISPLAYED_EVENT();
c0d00e38:	60a8      	str	r0, [r5, #8]
c0d00e3a:	6868      	ldr	r0, [r5, #4]
c0d00e3c:	68a9      	ldr	r1, [r5, #8]
c0d00e3e:	4281      	cmp	r1, r0
c0d00e40:	d30d      	bcc.n	c0d00e5e <io_event+0x28e>
c0d00e42:	f001 fb29 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d00e46:	e00a      	b.n	c0d00e5e <io_event+0x28e>
    // needed
    
    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
        case SEPROXYHAL_TAG_FINGER_EVENT:
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00e48:	2801      	cmp	r0, #1
c0d00e4a:	d103      	bne.n	c0d00e54 <io_event+0x284>
c0d00e4c:	68b0      	ldr	r0, [r6, #8]
c0d00e4e:	4344      	muls	r4, r0
c0d00e50:	6830      	ldr	r0, [r6, #0]
c0d00e52:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00e54:	f000 fdd6 	bl	c0d01a04 <io_seproxyhal_display_default>
c0d00e58:	68b0      	ldr	r0, [r6, #8]
c0d00e5a:	1c40      	adds	r0, r0, #1
    // needed
    
    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
        case SEPROXYHAL_TAG_FINGER_EVENT:
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00e5c:	60b0      	str	r0, [r6, #8]
        default:
            break;
    }
    
    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00e5e:	f001 fb1b 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d00e62:	2800      	cmp	r0, #0
c0d00e64:	d101      	bne.n	c0d00e6a <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00e66:	f000 fb57 	bl	c0d01518 <io_seproxyhal_general_status>
    }
    
    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00e6a:	2001      	movs	r0, #1
c0d00e6c:	b005      	add	sp, #20
c0d00e6e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00e70:	200019d8 	.word	0x200019d8
c0d00e74:	20001a58 	.word	0x20001a58
c0d00e78:	b0105044 	.word	0xb0105044
c0d00e7c:	b0105055 	.word	0xb0105055

c0d00e80 <IOTA_main>:
ux_state_t ux;




static void IOTA_main(void) {
c0d00e80:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e82:	af03      	add	r7, sp, #12
c0d00e84:	b0cb      	sub	sp, #300	; 0x12c
c0d00e86:	2600      	movs	r6, #0
    volatile unsigned int rx = 0;
c0d00e88:	964a      	str	r6, [sp, #296]	; 0x128
    volatile unsigned int tx = 0;
c0d00e8a:	9649      	str	r6, [sp, #292]	; 0x124
    volatile unsigned int flags = 0;
c0d00e8c:	9648      	str	r6, [sp, #288]	; 0x120
    
    //initialize the UI
    initUImsg();
c0d00e8e:	f001 fb6b 	bl	c0d02568 <initUImsg>
c0d00e92:	a90e      	add	r1, sp, #56	; 0x38
c0d00e94:	4608      	mov	r0, r1
c0d00e96:	304d      	adds	r0, #77	; 0x4d
c0d00e98:	900b      	str	r0, [sp, #44]	; 0x2c
c0d00e9a:	a829      	add	r0, sp, #164	; 0xa4
c0d00e9c:	1dc2      	adds	r2, r0, #7
c0d00e9e:	920a      	str	r2, [sp, #40]	; 0x28
c0d00ea0:	1d00      	adds	r0, r0, #4
c0d00ea2:	9009      	str	r0, [sp, #36]	; 0x24
c0d00ea4:	3151      	adds	r1, #81	; 0x51
c0d00ea6:	910c      	str	r1, [sp, #48]	; 0x30
c0d00ea8:	48e6      	ldr	r0, [pc, #920]	; (c0d01244 <IOTA_main+0x3c4>)
c0d00eaa:	6800      	ldr	r0, [r0, #0]
c0d00eac:	960d      	str	r6, [sp, #52]	; 0x34
c0d00eae:	a947      	add	r1, sp, #284	; 0x11c
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00eb0:	800e      	strh	r6, [r1, #0]
        
        BEGIN_TRY {
            TRY {
c0d00eb2:	9045      	str	r0, [sp, #276]	; 0x114
c0d00eb4:	ad3b      	add	r5, sp, #236	; 0xec
c0d00eb6:	4628      	mov	r0, r5
c0d00eb8:	f002 fe36 	bl	c0d03b28 <setjmp>
c0d00ebc:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d00ebe:	49e1      	ldr	r1, [pc, #900]	; (c0d01244 <IOTA_main+0x3c4>)
c0d00ec0:	600d      	str	r5, [r1, #0]
c0d00ec2:	49e1      	ldr	r1, [pc, #900]	; (c0d01248 <IOTA_main+0x3c8>)
c0d00ec4:	4208      	tst	r0, r1
c0d00ec6:	d013      	beq.n	c0d00ef0 <IOTA_main+0x70>
c0d00ec8:	a93b      	add	r1, sp, #236	; 0xec
                        hashTainted = 1;
                        THROW(0x6D00);
                        break;
                }
            }
            CATCH_OTHER(e) {
c0d00eca:	858e      	strh	r6, [r1, #44]	; 0x2c
c0d00ecc:	9945      	ldr	r1, [sp, #276]	; 0x114
c0d00ece:	4add      	ldr	r2, [pc, #884]	; (c0d01244 <IOTA_main+0x3c4>)
c0d00ed0:	6011      	str	r1, [r2, #0]
c0d00ed2:	210f      	movs	r1, #15
c0d00ed4:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00ed6:	4001      	ands	r1, r0
c0d00ed8:	2209      	movs	r2, #9
c0d00eda:	0312      	lsls	r2, r2, #12
c0d00edc:	4291      	cmp	r1, r2
c0d00ede:	d004      	beq.n	c0d00eea <IOTA_main+0x6a>
c0d00ee0:	2203      	movs	r2, #3
c0d00ee2:	0352      	lsls	r2, r2, #13
c0d00ee4:	4291      	cmp	r1, r2
c0d00ee6:	d000      	beq.n	c0d00eea <IOTA_main+0x6a>
c0d00ee8:	e0ad      	b.n	c0d01046 <IOTA_main+0x1c6>
c0d00eea:	a947      	add	r1, sp, #284	; 0x11c
                    case 0x6000:
                    case 0x9000:
                        sw = e;
c0d00eec:	8008      	strh	r0, [r1, #0]
c0d00eee:	e0b1      	b.n	c0d01054 <IOTA_main+0x1d4>
    for (;;) {
        volatile unsigned short sw = 0;
        
        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00ef0:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d00ef2:	904a      	str	r0, [sp, #296]	; 0x128
c0d00ef4:	2500      	movs	r5, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00ef6:	9549      	str	r5, [sp, #292]	; 0x124
                // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00ef8:	9848      	ldr	r0, [sp, #288]	; 0x120
c0d00efa:	994a      	ldr	r1, [sp, #296]	; 0x128
c0d00efc:	b2c0      	uxtb	r0, r0
c0d00efe:	b289      	uxth	r1, r1
c0d00f00:	f000 fdfe 	bl	c0d01b00 <io_exchange>
c0d00f04:	904a      	str	r0, [sp, #296]	; 0x128
                
                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00f06:	9548      	str	r5, [sp, #288]	; 0x120
                
                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00f08:	984a      	ldr	r0, [sp, #296]	; 0x128
c0d00f0a:	2800      	cmp	r0, #0
c0d00f0c:	d100      	bne.n	c0d00f10 <IOTA_main+0x90>
c0d00f0e:	e17b      	b.n	c0d01208 <IOTA_main+0x388>
c0d00f10:	4acf      	ldr	r2, [pc, #828]	; (c0d01250 <IOTA_main+0x3d0>)
                    THROW(0x6982);
                }
                
                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00f12:	7810      	ldrb	r0, [r2, #0]
c0d00f14:	216f      	movs	r1, #111	; 0x6f
c0d00f16:	43c9      	mvns	r1, r1
c0d00f18:	3910      	subs	r1, #16
c0d00f1a:	b2c9      	uxtb	r1, r1
                            
                            // push the response onto the response buffer.
                            os_memmove(G_io_apdu_buffer, msg, tx);
                            //Manually send back failure
                            //TODO MODIFY FAILURE RETURN CODE
                            G_io_apdu_buffer[tx++] = 0x90;
c0d00f1c:	2390      	movs	r3, #144	; 0x90
                    THROW(0x6982);
                }
                
                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00f1e:	4288      	cmp	r0, r1
c0d00f20:	d000      	beq.n	c0d00f24 <IOTA_main+0xa4>
c0d00f22:	e179      	b.n	c0d01218 <IOTA_main+0x398>
c0d00f24:	206d      	movs	r0, #109	; 0x6d
c0d00f26:	0201      	lsls	r1, r0, #8
c0d00f28:	7850      	ldrb	r0, [r2, #1]
                    hashTainted = 1;
                    THROW(0x6E00);
                }
                
                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00f2a:	1e42      	subs	r2, r0, #1
c0d00f2c:	2a07      	cmp	r2, #7
c0d00f2e:	d900      	bls.n	c0d00f32 <IOTA_main+0xb2>
c0d00f30:	e09d      	b.n	c0d0106e <IOTA_main+0x1ee>
c0d00f32:	9308      	str	r3, [sp, #32]
c0d00f34:	0052      	lsls	r2, r2, #1
c0d00f36:	46c0      	nop			; (mov r8, r8)
c0d00f38:	447a      	add	r2, pc
c0d00f3a:	8892      	ldrh	r2, [r2, #4]
c0d00f3c:	0052      	lsls	r2, r2, #1
c0d00f3e:	4497      	add	pc, r2
c0d00f40:	00b40007 	.word	0x00b40007
c0d00f44:	00e1015c 	.word	0x00e1015c
c0d00f48:	015c015c 	.word	0x015c015c
c0d00f4c:	0117015c 	.word	0x0117015c
                            
                            //sizeof = 76 publicKey, 40 privateKey
                            cx_ecfp_public_key_t publicKey;
                            cx_ecfp_private_key_t privateKey;
                            
                            if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00f50:	984a      	ldr	r0, [sp, #296]	; 0x128
c0d00f52:	2818      	cmp	r0, #24
c0d00f54:	d800      	bhi.n	c0d00f58 <IOTA_main+0xd8>
c0d00f56:	e168      	b.n	c0d0122a <IOTA_main+0x3aa>
c0d00f58:	4ebd      	ldr	r6, [pc, #756]	; (c0d01250 <IOTA_main+0x3d0>)
                            unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;
                            
                            unsigned int bip44_path[BIP44_PATH_LEN];
                            uint32_t i;
                            for (i = 0; i < BIP44_PATH_LEN; i++) {
                                bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00f5a:	00a8      	lsls	r0, r5, #2
c0d00f5c:	1831      	adds	r1, r6, r0
c0d00f5e:	794a      	ldrb	r2, [r1, #5]
c0d00f60:	0612      	lsls	r2, r2, #24
c0d00f62:	798b      	ldrb	r3, [r1, #6]
c0d00f64:	041b      	lsls	r3, r3, #16
c0d00f66:	4313      	orrs	r3, r2
c0d00f68:	79ca      	ldrb	r2, [r1, #7]
c0d00f6a:	0212      	lsls	r2, r2, #8
c0d00f6c:	431a      	orrs	r2, r3
c0d00f6e:	7a09      	ldrb	r1, [r1, #8]
c0d00f70:	4311      	orrs	r1, r2
c0d00f72:	aa24      	add	r2, sp, #144	; 0x90
c0d00f74:	5011      	str	r1, [r2, r0]
                            /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                            unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;
                            
                            unsigned int bip44_path[BIP44_PATH_LEN];
                            uint32_t i;
                            for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00f76:	1c6d      	adds	r5, r5, #1
c0d00f78:	2d05      	cmp	r5, #5
c0d00f7a:	d1ee      	bne.n	c0d00f5a <IOTA_main+0xda>
c0d00f7c:	2100      	movs	r1, #0
                                bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                                bip44_in += 4;
                            }
                            
                            os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00f7e:	9105      	str	r1, [sp, #20]
c0d00f80:	4668      	mov	r0, sp
c0d00f82:	6001      	str	r1, [r0, #0]
c0d00f84:	2621      	movs	r6, #33	; 0x21
c0d00f86:	a924      	add	r1, sp, #144	; 0x90
c0d00f88:	2205      	movs	r2, #5
c0d00f8a:	ac33      	add	r4, sp, #204	; 0xcc
c0d00f8c:	9406      	str	r4, [sp, #24]
c0d00f8e:	4630      	mov	r0, r6
c0d00f90:	4623      	mov	r3, r4
c0d00f92:	f001 f9eb 	bl	c0d0236c <os_perso_derive_node_bip32>
c0d00f96:	2220      	movs	r2, #32
c0d00f98:	9207      	str	r2, [sp, #28]
c0d00f9a:	ab29      	add	r3, sp, #164	; 0xa4
                            cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00f9c:	9304      	str	r3, [sp, #16]
c0d00f9e:	4630      	mov	r0, r6
c0d00fa0:	4621      	mov	r1, r4
c0d00fa2:	f001 f9a7 	bl	c0d022f4 <cx_ecfp_init_private_key>
c0d00fa6:	ad0e      	add	r5, sp, #56	; 0x38
                            
                            // generate the public key. (stored in publicKey.W)
                            cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00fa8:	4630      	mov	r0, r6
c0d00faa:	9c05      	ldr	r4, [sp, #20]
c0d00fac:	4621      	mov	r1, r4
c0d00fae:	4622      	mov	r2, r4
c0d00fb0:	462b      	mov	r3, r5
c0d00fb2:	f001 f981 	bl	c0d022b8 <cx_ecfp_init_public_key>
c0d00fb6:	2301      	movs	r3, #1
                            cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00fb8:	4630      	mov	r0, r6
c0d00fba:	4629      	mov	r1, r5
c0d00fbc:	9a04      	ldr	r2, [sp, #16]
c0d00fbe:	f001 f9b7 	bl	c0d02330 <cx_ecfp_generate_pair>
c0d00fc2:	ad0e      	add	r5, sp, #56	; 0x38
                        }
                        
                        char key[82];
                        key[0] = 'K';
c0d00fc4:	204b      	movs	r0, #75	; 0x4b
c0d00fc6:	7028      	strb	r0, [r5, #0]
                        get_seed(privateKeyData, sizeof(privateKeyData), &key[0]);
c0d00fc8:	9806      	ldr	r0, [sp, #24]
c0d00fca:	9907      	ldr	r1, [sp, #28]
c0d00fcc:	462a      	mov	r2, r5
c0d00fce:	f7ff fa23 	bl	c0d00418 <get_seed>
                        // push the response onto the response buffer.
                        
                        //terminate the key
                        key[81] = '\0';
c0d00fd2:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00fd4:	7004      	strb	r4, [r0, #0]
                        os_memmove(G_io_apdu_buffer, key, 82);
c0d00fd6:	2652      	movs	r6, #82	; 0x52
c0d00fd8:	489d      	ldr	r0, [pc, #628]	; (c0d01250 <IOTA_main+0x3d0>)
c0d00fda:	4629      	mov	r1, r5
c0d00fdc:	4632      	mov	r2, r6
c0d00fde:	f000 fa01 	bl	c0d013e4 <os_memmove>
                        
                        tx = 82;
c0d00fe2:	9649      	str	r6, [sp, #292]	; 0x124
                        //Manually send back success 0x9000 at end
                        G_io_apdu_buffer[tx++] = 0x90;
c0d00fe4:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d00fe6:	1c41      	adds	r1, r0, #1
c0d00fe8:	9149      	str	r1, [sp, #292]	; 0x124
c0d00fea:	9908      	ldr	r1, [sp, #32]
c0d00fec:	4a98      	ldr	r2, [pc, #608]	; (c0d01250 <IOTA_main+0x3d0>)
c0d00fee:	5411      	strb	r1, [r2, r0]
                        G_io_apdu_buffer[tx++] = 0x00;
c0d00ff0:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d00ff2:	1c41      	adds	r1, r0, #1
c0d00ff4:	9149      	str	r1, [sp, #292]	; 0x124
c0d00ff6:	5414      	strb	r4, [r2, r0]
                        
                        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00ff8:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d00ffa:	b281      	uxth	r1, r0
c0d00ffc:	9807      	ldr	r0, [sp, #28]
c0d00ffe:	f000 fd7f 	bl	c0d01b00 <io_exchange>
c0d01002:	2010      	movs	r0, #16
                        
                        flags |= IO_ASYNCH_REPLY;
c0d01004:	9948      	ldr	r1, [sp, #288]	; 0x120
c0d01006:	4301      	orrs	r1, r0
c0d01008:	9148      	str	r1, [sp, #288]	; 0x120
                        
                        
                        char key_abbrv[12];
                        
                        // - Convert into abbreviated seeed (first 4 and last 4 characters)
                        memcpy(&key_abbrv[0], &key[0], 4); // first 4 chars of seed
c0d0100a:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0100c:	9029      	str	r0, [sp, #164]	; 0xa4
                        memcpy(&key_abbrv[4], "...", 3); // copy ...
c0d0100e:	202e      	movs	r0, #46	; 0x2e
c0d01010:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01012:	7048      	strb	r0, [r1, #1]
c0d01014:	7008      	strb	r0, [r1, #0]
c0d01016:	7088      	strb	r0, [r1, #2]
c0d01018:	990b      	ldr	r1, [sp, #44]	; 0x2c
                        memcpy(&key_abbrv[7], &key[77], 5); //copy last 4 chars + null
c0d0101a:	78c8      	ldrb	r0, [r1, #3]
c0d0101c:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d0101e:	70d0      	strb	r0, [r2, #3]
c0d01020:	7888      	ldrb	r0, [r1, #2]
c0d01022:	7090      	strb	r0, [r2, #2]
c0d01024:	7848      	ldrb	r0, [r1, #1]
c0d01026:	7050      	strb	r0, [r2, #1]
c0d01028:	7808      	ldrb	r0, [r1, #0]
c0d0102a:	7010      	strb	r0, [r2, #0]
c0d0102c:	7908      	ldrb	r0, [r1, #4]
c0d0102e:	7110      	strb	r0, [r2, #4]
                        
                        
                        ui_display_debug(&key_abbrv[0], 12, TYPE_STR, NULL, 0, 0);
c0d01030:	4668      	mov	r0, sp
c0d01032:	6004      	str	r4, [r0, #0]
c0d01034:	6044      	str	r4, [r0, #4]
c0d01036:	a829      	add	r0, sp, #164	; 0xa4
c0d01038:	210c      	movs	r1, #12
c0d0103a:	2203      	movs	r2, #3
c0d0103c:	4623      	mov	r3, r4
c0d0103e:	f001 facb 	bl	c0d025d8 <ui_display_debug>
c0d01042:	9e0d      	ldr	r6, [sp, #52]	; 0x34
c0d01044:	e0cb      	b.n	c0d011de <IOTA_main+0x35e>
                    case 0x6000:
                    case 0x9000:
                        sw = e;
                        break;
                    default:
                        sw = 0x6800 | (e & 0x7FF);
c0d01046:	4981      	ldr	r1, [pc, #516]	; (c0d0124c <IOTA_main+0x3cc>)
c0d01048:	4008      	ands	r0, r1
c0d0104a:	210d      	movs	r1, #13
c0d0104c:	02c9      	lsls	r1, r1, #11
c0d0104e:	4301      	orrs	r1, r0
c0d01050:	a847      	add	r0, sp, #284	; 0x11c
c0d01052:	8001      	strh	r1, [r0, #0]
                        break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d01054:	9847      	ldr	r0, [sp, #284]	; 0x11c
c0d01056:	0a00      	lsrs	r0, r0, #8
c0d01058:	9949      	ldr	r1, [sp, #292]	; 0x124
c0d0105a:	4a7d      	ldr	r2, [pc, #500]	; (c0d01250 <IOTA_main+0x3d0>)
c0d0105c:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d0105e:	9847      	ldr	r0, [sp, #284]	; 0x11c
c0d01060:	9949      	ldr	r1, [sp, #292]	; 0x124
                    default:
                        sw = 0x6800 | (e & 0x7FF);
                        break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d01062:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d01064:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d01066:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d01068:	1c80      	adds	r0, r0, #2
c0d0106a:	9049      	str	r0, [sp, #292]	; 0x124
c0d0106c:	e0b7      	b.n	c0d011de <IOTA_main+0x35e>
c0d0106e:	2810      	cmp	r0, #16
c0d01070:	d000      	beq.n	c0d01074 <IOTA_main+0x1f4>
c0d01072:	e0be      	b.n	c0d011f2 <IOTA_main+0x372>
c0d01074:	4876      	ldr	r0, [pc, #472]	; (c0d01250 <IOTA_main+0x3d0>)
c0d01076:	7880      	ldrb	r0, [r0, #2]
                         ------------------- SIGN TX -------------------
                         -----------------------------------------------
                         ----------------------------------------------- */
                    case INS_SIGN: {
                        //check third byte for instruction type
                        if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d01078:	2180      	movs	r1, #128	; 0x80
c0d0107a:	4301      	orrs	r1, r0
c0d0107c:	2980      	cmp	r1, #128	; 0x80
c0d0107e:	d000      	beq.n	c0d01082 <IOTA_main+0x202>
c0d01080:	e0db      	b.n	c0d0123a <IOTA_main+0x3ba>
c0d01082:	4d74      	ldr	r5, [pc, #464]	; (c0d01254 <IOTA_main+0x3d4>)
                            (G_io_apdu_buffer[2] != P1_LAST)) {
                            THROW(0x6A86);
                        }
                        
                        //if first part reset hash and all other tmp var's
                        if (hashTainted) {
c0d01084:	7828      	ldrb	r0, [r5, #0]
c0d01086:	2800      	cmp	r0, #0
c0d01088:	d004      	beq.n	c0d01094 <IOTA_main+0x214>
                            cx_sha256_init(&hash);
c0d0108a:	4873      	ldr	r0, [pc, #460]	; (c0d01258 <IOTA_main+0x3d8>)
c0d0108c:	f001 f8b8 	bl	c0d02200 <cx_sha256_init>
                            hashTainted = 0;
c0d01090:	2000      	movs	r0, #0
c0d01092:	7028      	strb	r0, [r5, #0]
c0d01094:	486e      	ldr	r0, [pc, #440]	; (c0d01250 <IOTA_main+0x3d0>)
c0d01096:	4601      	mov	r1, r0
                        }
                        
                        // Position 5 is the start of the real data, pos 4 is
                        // the length of the data, flag off end with nullchar
                        G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d01098:	7908      	ldrb	r0, [r1, #4]
c0d0109a:	1808      	adds	r0, r1, r0
c0d0109c:	2100      	movs	r1, #0
c0d0109e:	7141      	strb	r1, [r0, #5]
                        
                        flags |= IO_ASYNCH_REPLY;
c0d010a0:	2010      	movs	r0, #16
c0d010a2:	9948      	ldr	r1, [sp, #288]	; 0x120
c0d010a4:	4301      	orrs	r1, r0
c0d010a6:	9148      	str	r1, [sp, #288]	; 0x120
c0d010a8:	e099      	b.n	c0d011de <IOTA_main+0x35e>
c0d010aa:	486d      	ldr	r0, [pc, #436]	; (c0d01260 <IOTA_main+0x3e0>)
c0d010ac:	4601      	mov	r1, r0
                         -----------------------------------------------
                         ---------------- BAD PUBLIC KEY ---------------
                         -----------------------------------------------
                         ----------------------------------------------- */
                    case INS_BAD_PUBKEY: {
                        global_seed_key++;
c0d010ae:	6808      	ldr	r0, [r1, #0]
c0d010b0:	1c40      	adds	r0, r0, #1
c0d010b2:	6008      	str	r0, [r1, #0]
c0d010b4:	ae0e      	add	r6, sp, #56	; 0x38
c0d010b6:	240b      	movs	r4, #11
                        
                        char msg[11];
                        //10 characters is largest uint32 num, might need to go higher
                        //once larger indices are allowed
                        uint_to_str(global_seed_key, &msg[0], 11);
c0d010b8:	9403      	str	r4, [sp, #12]
c0d010ba:	4631      	mov	r1, r6
c0d010bc:	4622      	mov	r2, r4
c0d010be:	f7ff f8e9 	bl	c0d00294 <uint_to_str>
                        tx = 11;
c0d010c2:	9449      	str	r4, [sp, #292]	; 0x124
                        
                        
                        // push the response onto the response buffer.
                        os_memmove(G_io_apdu_buffer, msg, tx);
c0d010c4:	9a49      	ldr	r2, [sp, #292]	; 0x124
c0d010c6:	4862      	ldr	r0, [pc, #392]	; (c0d01250 <IOTA_main+0x3d0>)
c0d010c8:	4604      	mov	r4, r0
c0d010ca:	4631      	mov	r1, r6
c0d010cc:	f000 f98a 	bl	c0d013e4 <os_memmove>
                        
                        //Manually send back success 0x9000 at end
                        G_io_apdu_buffer[tx++] = 0x90;
c0d010d0:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d010d2:	1c41      	adds	r1, r0, #1
c0d010d4:	9149      	str	r1, [sp, #292]	; 0x124
c0d010d6:	9908      	ldr	r1, [sp, #32]
c0d010d8:	5421      	strb	r1, [r4, r0]
                        G_io_apdu_buffer[tx++] = 0x00;
c0d010da:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d010dc:	1c41      	adds	r1, r0, #1
c0d010de:	9149      	str	r1, [sp, #292]	; 0x124
c0d010e0:	5425      	strb	r5, [r4, r0]
                        
                        //send back response
                        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d010e2:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d010e4:	b281      	uxth	r1, r0
c0d010e6:	2020      	movs	r0, #32
c0d010e8:	f000 fd0a 	bl	c0d01b00 <io_exchange>
                        
                        flags |= IO_ASYNCH_REPLY;
c0d010ec:	2010      	movs	r0, #16
c0d010ee:	9948      	ldr	r1, [sp, #288]	; 0x120
c0d010f0:	4301      	orrs	r1, r0
c0d010f2:	9148      	str	r1, [sp, #288]	; 0x120
                        
                        ui_display_debug(&msg[0], 11, TYPE_STR, NULL, 0, 0);
c0d010f4:	4668      	mov	r0, sp
c0d010f6:	6005      	str	r5, [r0, #0]
c0d010f8:	6045      	str	r5, [r0, #4]
c0d010fa:	2203      	movs	r2, #3
c0d010fc:	4630      	mov	r0, r6
c0d010fe:	9e0d      	ldr	r6, [sp, #52]	; 0x34
c0d01100:	9903      	ldr	r1, [sp, #12]
c0d01102:	e069      	b.n	c0d011d8 <IOTA_main+0x358>
c0d01104:	ae0e      	add	r6, sp, #56	; 0x38
c0d01106:	2001      	movs	r0, #1
                         -----------------------------------------------
                         ----------------------------------------------- */
                    case INS_GOOD_PUBKEY: {
                        //Just use this to write to NVRAM the new seed key
                        internalStorage_t storage;
                        storage.initialized = 0x01;
c0d01108:	7030      	strb	r0, [r6, #0]
c0d0110a:	4855      	ldr	r0, [pc, #340]	; (c0d01260 <IOTA_main+0x3e0>)
c0d0110c:	4604      	mov	r4, r0
                        //get the global seed key and write it as the new key
                        storage.seed_key = global_seed_key;
c0d0110e:	6820      	ldr	r0, [r4, #0]
c0d01110:	9023      	str	r0, [sp, #140]	; 0x8c
                        
                        nvm_write(&N_storage, (void *)&storage,
c0d01112:	4854      	ldr	r0, [pc, #336]	; (c0d01264 <IOTA_main+0x3e4>)
c0d01114:	f000 ffe6 	bl	c0d020e4 <pic>
c0d01118:	2258      	movs	r2, #88	; 0x58
c0d0111a:	4631      	mov	r1, r6
c0d0111c:	f001 f834 	bl	c0d02188 <nvm_write>
                                  sizeof(internalStorage_t));
                        
                        char msg[11];
                        //10 characters is largest uint32 num, might need to go higher
                        //once larger indices are allowed
                        uint_to_str(global_seed_key, &msg[0], 11);
c0d01120:	6820      	ldr	r0, [r4, #0]
c0d01122:	ae29      	add	r6, sp, #164	; 0xa4
c0d01124:	240b      	movs	r4, #11
c0d01126:	4631      	mov	r1, r6
c0d01128:	4622      	mov	r2, r4
c0d0112a:	f7ff f8b3 	bl	c0d00294 <uint_to_str>
                        tx = 11;
c0d0112e:	9449      	str	r4, [sp, #292]	; 0x124
                        
                        // push the response onto the response buffer.
                        os_memmove(G_io_apdu_buffer, msg, tx);
c0d01130:	9a49      	ldr	r2, [sp, #292]	; 0x124
c0d01132:	4847      	ldr	r0, [pc, #284]	; (c0d01250 <IOTA_main+0x3d0>)
c0d01134:	4631      	mov	r1, r6
c0d01136:	f000 f955 	bl	c0d013e4 <os_memmove>
                        
                        //Manually send back success 0x9000 at end
                        G_io_apdu_buffer[tx++] = 0x90;
c0d0113a:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d0113c:	1c41      	adds	r1, r0, #1
c0d0113e:	9149      	str	r1, [sp, #292]	; 0x124
c0d01140:	9908      	ldr	r1, [sp, #32]
c0d01142:	4a43      	ldr	r2, [pc, #268]	; (c0d01250 <IOTA_main+0x3d0>)
c0d01144:	5411      	strb	r1, [r2, r0]
                        G_io_apdu_buffer[tx++] = 0x00;
c0d01146:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d01148:	1c41      	adds	r1, r0, #1
c0d0114a:	9149      	str	r1, [sp, #292]	; 0x124
c0d0114c:	5415      	strb	r5, [r2, r0]
                        
                        //send back response
                        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d0114e:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d01150:	b281      	uxth	r1, r0
c0d01152:	2020      	movs	r0, #32
c0d01154:	f000 fcd4 	bl	c0d01b00 <io_exchange>
                        
                        flags |= IO_ASYNCH_REPLY;
c0d01158:	2010      	movs	r0, #16
c0d0115a:	9948      	ldr	r1, [sp, #288]	; 0x120
c0d0115c:	4301      	orrs	r1, r0
c0d0115e:	9148      	str	r1, [sp, #288]	; 0x120
                        //Nothing to display, this is purely behind the scenes
                        ui_display_debug(&msg[0], 11, TYPE_STR, NULL, 0, 0);
c0d01160:	4668      	mov	r0, sp
c0d01162:	6005      	str	r5, [r0, #0]
c0d01164:	6045      	str	r5, [r0, #4]
c0d01166:	2203      	movs	r2, #3
c0d01168:	4630      	mov	r0, r6
c0d0116a:	9e0d      	ldr	r6, [sp, #52]	; 0x34
c0d0116c:	4621      	mov	r1, r4
c0d0116e:	e033      	b.n	c0d011d8 <IOTA_main+0x358>
c0d01170:	4837      	ldr	r0, [pc, #220]	; (c0d01250 <IOTA_main+0x3d0>)
                        // Notify good_pub_key to write (after verifying its good)
                    case INS_CHANGE_INDEX: {
                        //largest uint32 is 10 characters long
                        //might need more if if we support larger than uint32
                        char msg[11];
                        memcpy(&msg[0], &G_io_apdu_buffer[5], 10);
c0d01172:	1d41      	adds	r1, r0, #5
c0d01174:	ae0e      	add	r6, sp, #56	; 0x38
c0d01176:	240a      	movs	r4, #10
c0d01178:	4630      	mov	r0, r6
c0d0117a:	4622      	mov	r2, r4
c0d0117c:	f002 fc44 	bl	c0d03a08 <__aeabi_memcpy>
                        
                        uint32_t new_index = str_to_int(&msg[0], 10);
c0d01180:	4630      	mov	r0, r6
c0d01182:	4621      	mov	r1, r4
c0d01184:	f7ff f892 	bl	c0d002ac <str_to_int>
c0d01188:	9029      	str	r0, [sp, #164]	; 0xa4
                        
                        tx = 11;
c0d0118a:	210b      	movs	r1, #11
c0d0118c:	9149      	str	r1, [sp, #292]	; 0x124
c0d0118e:	4a34      	ldr	r2, [pc, #208]	; (c0d01260 <IOTA_main+0x3e0>)
                        
                        //only update global_seed_key if we increment
                        //don't allow reducing seed_key (vulnerability)
                        if(new_index > global_seed_key) {
c0d01190:	6811      	ldr	r1, [r2, #0]
c0d01192:	4288      	cmp	r0, r1
c0d01194:	d900      	bls.n	c0d01198 <IOTA_main+0x318>
                            global_seed_key = new_index;
c0d01196:	6010      	str	r0, [r2, #0]
c0d01198:	9a49      	ldr	r2, [sp, #292]	; 0x124
c0d0119a:	a90e      	add	r1, sp, #56	; 0x38
c0d0119c:	4c2c      	ldr	r4, [pc, #176]	; (c0d01250 <IOTA_main+0x3d0>)
c0d0119e:	4620      	mov	r0, r4
c0d011a0:	f000 f920 	bl	c0d013e4 <os_memmove>
c0d011a4:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d011a6:	1c41      	adds	r1, r0, #1
c0d011a8:	9149      	str	r1, [sp, #292]	; 0x124
c0d011aa:	9908      	ldr	r1, [sp, #32]
c0d011ac:	5421      	strb	r1, [r4, r0]
c0d011ae:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d011b0:	1c41      	adds	r1, r0, #1
c0d011b2:	9149      	str	r1, [sp, #292]	; 0x124
c0d011b4:	9e0d      	ldr	r6, [sp, #52]	; 0x34
c0d011b6:	4926      	ldr	r1, [pc, #152]	; (c0d01250 <IOTA_main+0x3d0>)
c0d011b8:	540d      	strb	r5, [r1, r0]
                            G_io_apdu_buffer[tx++] = 0x00;
                        }
                        
                        
                        //send back response
                        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d011ba:	9849      	ldr	r0, [sp, #292]	; 0x124
c0d011bc:	b281      	uxth	r1, r0
c0d011be:	2020      	movs	r0, #32
c0d011c0:	f000 fc9e 	bl	c0d01b00 <io_exchange>
                        
                        flags |= IO_ASYNCH_REPLY;
c0d011c4:	2010      	movs	r0, #16
c0d011c6:	9948      	ldr	r1, [sp, #288]	; 0x120
c0d011c8:	4301      	orrs	r1, r0
c0d011ca:	9148      	str	r1, [sp, #288]	; 0x120
                        //Nothing to display, this is purely behind the scenes
                        ui_display_debug(&new_index, 11, TYPE_INT, NULL, 0, 0);
c0d011cc:	4668      	mov	r0, sp
c0d011ce:	6005      	str	r5, [r0, #0]
c0d011d0:	6045      	str	r5, [r0, #4]
c0d011d2:	a829      	add	r0, sp, #164	; 0xa4
c0d011d4:	210b      	movs	r1, #11
c0d011d6:	2201      	movs	r2, #1
c0d011d8:	462b      	mov	r3, r5
c0d011da:	f001 f9fd 	bl	c0d025d8 <ui_display_debug>
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
                G_io_apdu_buffer[tx + 1] = sw;
                tx += 2;
            }
            FINALLY {
c0d011de:	9845      	ldr	r0, [sp, #276]	; 0x114
c0d011e0:	4918      	ldr	r1, [pc, #96]	; (c0d01244 <IOTA_main+0x3c4>)
c0d011e2:	6008      	str	r0, [r1, #0]
c0d011e4:	a93b      	add	r1, sp, #236	; 0xec
            }
        }
        END_TRY;
c0d011e6:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d011e8:	2900      	cmp	r1, #0
c0d011ea:	d100      	bne.n	c0d011ee <IOTA_main+0x36e>
c0d011ec:	e65f      	b.n	c0d00eae <IOTA_main+0x2e>
c0d011ee:	f002 fca7 	bl	c0d03b40 <longjmp>
c0d011f2:	28ff      	cmp	r0, #255	; 0xff
c0d011f4:	d101      	bne.n	c0d011fa <IOTA_main+0x37a>
    }
    
return_to_dashboard:
    return;
}
c0d011f6:	b04b      	add	sp, #300	; 0x12c
c0d011f8:	bdf0      	pop	{r4, r5, r6, r7, pc}
                    case 0xFF: // return to dashboard
                        goto return_to_dashboard;
                        
                        //unknown command ??
                    default:
                        hashTainted = 1;
c0d011fa:	2001      	movs	r0, #1
c0d011fc:	4a15      	ldr	r2, [pc, #84]	; (c0d01254 <IOTA_main+0x3d4>)
c0d011fe:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D00);
c0d01200:	4810      	ldr	r0, [pc, #64]	; (c0d01244 <IOTA_main+0x3c4>)
c0d01202:	6800      	ldr	r0, [r0, #0]
c0d01204:	f002 fc9c 	bl	c0d03b40 <longjmp>
                flags = 0;
                
                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d01208:	2001      	movs	r0, #1
c0d0120a:	4912      	ldr	r1, [pc, #72]	; (c0d01254 <IOTA_main+0x3d4>)
c0d0120c:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d0120e:	480d      	ldr	r0, [pc, #52]	; (c0d01244 <IOTA_main+0x3c4>)
c0d01210:	6800      	ldr	r0, [r0, #0]
c0d01212:	4915      	ldr	r1, [pc, #84]	; (c0d01268 <IOTA_main+0x3e8>)
c0d01214:	f002 fc94 	bl	c0d03b40 <longjmp>
                }
                
                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d01218:	2001      	movs	r0, #1
c0d0121a:	490e      	ldr	r1, [pc, #56]	; (c0d01254 <IOTA_main+0x3d4>)
c0d0121c:	7008      	strb	r0, [r1, #0]
                    THROW(0x6E00);
c0d0121e:	4809      	ldr	r0, [pc, #36]	; (c0d01244 <IOTA_main+0x3c4>)
c0d01220:	6800      	ldr	r0, [r0, #0]
c0d01222:	2137      	movs	r1, #55	; 0x37
c0d01224:	0249      	lsls	r1, r1, #9
c0d01226:	f002 fc8b 	bl	c0d03b40 <longjmp>
                            //sizeof = 76 publicKey, 40 privateKey
                            cx_ecfp_public_key_t publicKey;
                            cx_ecfp_private_key_t privateKey;
                            
                            if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                                hashTainted = 1;
c0d0122a:	2001      	movs	r0, #1
c0d0122c:	4a09      	ldr	r2, [pc, #36]	; (c0d01254 <IOTA_main+0x3d4>)
c0d0122e:	7010      	strb	r0, [r2, #0]
                                THROW(0x6D09);
c0d01230:	4804      	ldr	r0, [pc, #16]	; (c0d01244 <IOTA_main+0x3c4>)
c0d01232:	6800      	ldr	r0, [r0, #0]
c0d01234:	3109      	adds	r1, #9
c0d01236:	f002 fc83 	bl	c0d03b40 <longjmp>
                         ----------------------------------------------- */
                    case INS_SIGN: {
                        //check third byte for instruction type
                        if ((G_io_apdu_buffer[2] != P1_MORE) &&
                            (G_io_apdu_buffer[2] != P1_LAST)) {
                            THROW(0x6A86);
c0d0123a:	4802      	ldr	r0, [pc, #8]	; (c0d01244 <IOTA_main+0x3c4>)
c0d0123c:	6800      	ldr	r0, [r0, #0]
c0d0123e:	4907      	ldr	r1, [pc, #28]	; (c0d0125c <IOTA_main+0x3dc>)
c0d01240:	f002 fc7e 	bl	c0d03b40 <longjmp>
c0d01244:	20001b7c 	.word	0x20001b7c
c0d01248:	0000ffff 	.word	0x0000ffff
c0d0124c:	000007ff 	.word	0x000007ff
c0d01250:	20001bcc 	.word	0x20001bcc
c0d01254:	20001b08 	.word	0x20001b08
c0d01258:	20001b10 	.word	0x20001b10
c0d0125c:	00006a86 	.word	0x00006a86
c0d01260:	20001b0c 	.word	0x20001b0c
c0d01264:	c0d03f00 	.word	0xc0d03f00
c0d01268:	00006982 	.word	0x00006982

c0d0126c <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d0126c:	4801      	ldr	r0, [pc, #4]	; (c0d01274 <os_boot+0x8>)
c0d0126e:	2100      	movs	r1, #0
c0d01270:	6001      	str	r1, [r0, #0]
}
c0d01272:	4770      	bx	lr
c0d01274:	20001b7c 	.word	0x20001b7c

c0d01278 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d01278:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0127a:	af03      	add	r7, sp, #12
c0d0127c:	b083      	sub	sp, #12
c0d0127e:	9202      	str	r2, [sp, #8]
c0d01280:	460c      	mov	r4, r1
c0d01282:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d01284:	4d4a      	ldr	r5, [pc, #296]	; (c0d013b0 <io_usb_hid_receive+0x138>)
c0d01286:	42ac      	cmp	r4, r5
c0d01288:	d00f      	beq.n	c0d012aa <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d0128a:	4e49      	ldr	r6, [pc, #292]	; (c0d013b0 <io_usb_hid_receive+0x138>)
c0d0128c:	2540      	movs	r5, #64	; 0x40
c0d0128e:	4630      	mov	r0, r6
c0d01290:	4629      	mov	r1, r5
c0d01292:	f002 fbb3 	bl	c0d039fc <__aeabi_memclr>
c0d01296:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d01298:	2840      	cmp	r0, #64	; 0x40
c0d0129a:	4602      	mov	r2, r0
c0d0129c:	d300      	bcc.n	c0d012a0 <io_usb_hid_receive+0x28>
c0d0129e:	462a      	mov	r2, r5
c0d012a0:	4630      	mov	r0, r6
c0d012a2:	4621      	mov	r1, r4
c0d012a4:	f000 f89e 	bl	c0d013e4 <os_memmove>
c0d012a8:	4d41      	ldr	r5, [pc, #260]	; (c0d013b0 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d012aa:	78a8      	ldrb	r0, [r5, #2]
c0d012ac:	2805      	cmp	r0, #5
c0d012ae:	d900      	bls.n	c0d012b2 <io_usb_hid_receive+0x3a>
c0d012b0:	e076      	b.n	c0d013a0 <io_usb_hid_receive+0x128>
c0d012b2:	46c0      	nop			; (mov r8, r8)
c0d012b4:	4478      	add	r0, pc
c0d012b6:	7900      	ldrb	r0, [r0, #4]
c0d012b8:	0040      	lsls	r0, r0, #1
c0d012ba:	4487      	add	pc, r0
c0d012bc:	71130c02 	.word	0x71130c02
c0d012c0:	1f71      	.short	0x1f71
c0d012c2:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d012c4:	71ae      	strb	r6, [r5, #6]
c0d012c6:	716e      	strb	r6, [r5, #5]
c0d012c8:	712e      	strb	r6, [r5, #4]
c0d012ca:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d012cc:	2140      	movs	r1, #64	; 0x40
c0d012ce:	4628      	mov	r0, r5
c0d012d0:	9a01      	ldr	r2, [sp, #4]
c0d012d2:	4790      	blx	r2
c0d012d4:	e00b      	b.n	c0d012ee <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d012d6:	1ce8      	adds	r0, r5, #3
c0d012d8:	2104      	movs	r1, #4
c0d012da:	f000 ff73 	bl	c0d021c4 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d012de:	2140      	movs	r1, #64	; 0x40
c0d012e0:	4628      	mov	r0, r5
c0d012e2:	e001      	b.n	c0d012e8 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d012e4:	4832      	ldr	r0, [pc, #200]	; (c0d013b0 <io_usb_hid_receive+0x138>)
c0d012e6:	2140      	movs	r1, #64	; 0x40
c0d012e8:	9a01      	ldr	r2, [sp, #4]
c0d012ea:	4790      	blx	r2
c0d012ec:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d012ee:	4831      	ldr	r0, [pc, #196]	; (c0d013b4 <io_usb_hid_receive+0x13c>)
c0d012f0:	2100      	movs	r1, #0
c0d012f2:	6001      	str	r1, [r0, #0]
c0d012f4:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d012f6:	b2c0      	uxtb	r0, r0
c0d012f8:	b003      	add	sp, #12
c0d012fa:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d012fc:	78e8      	ldrb	r0, [r5, #3]
c0d012fe:	4c2d      	ldr	r4, [pc, #180]	; (c0d013b4 <io_usb_hid_receive+0x13c>)
c0d01300:	6821      	ldr	r1, [r4, #0]
c0d01302:	0a09      	lsrs	r1, r1, #8
c0d01304:	2600      	movs	r6, #0
c0d01306:	4288      	cmp	r0, r1
c0d01308:	d1f1      	bne.n	c0d012ee <io_usb_hid_receive+0x76>
c0d0130a:	7928      	ldrb	r0, [r5, #4]
c0d0130c:	6821      	ldr	r1, [r4, #0]
c0d0130e:	b2c9      	uxtb	r1, r1
c0d01310:	4288      	cmp	r0, r1
c0d01312:	d1ec      	bne.n	c0d012ee <io_usb_hid_receive+0x76>
c0d01314:	4b28      	ldr	r3, [pc, #160]	; (c0d013b8 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d01316:	9802      	ldr	r0, [sp, #8]
c0d01318:	18c0      	adds	r0, r0, r3
c0d0131a:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d0131c:	6820      	ldr	r0, [r4, #0]
c0d0131e:	2800      	cmp	r0, #0
c0d01320:	d00e      	beq.n	c0d01340 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d01322:	4629      	mov	r1, r5
c0d01324:	4019      	ands	r1, r3
c0d01326:	4825      	ldr	r0, [pc, #148]	; (c0d013bc <io_usb_hid_receive+0x144>)
c0d01328:	6802      	ldr	r2, [r0, #0]
c0d0132a:	4291      	cmp	r1, r2
c0d0132c:	461e      	mov	r6, r3
c0d0132e:	d900      	bls.n	c0d01332 <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d01330:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d01332:	462a      	mov	r2, r5
c0d01334:	4032      	ands	r2, r6
c0d01336:	4822      	ldr	r0, [pc, #136]	; (c0d013c0 <io_usb_hid_receive+0x148>)
c0d01338:	6800      	ldr	r0, [r0, #0]
c0d0133a:	491d      	ldr	r1, [pc, #116]	; (c0d013b0 <io_usb_hid_receive+0x138>)
c0d0133c:	1d49      	adds	r1, r1, #5
c0d0133e:	e021      	b.n	c0d01384 <io_usb_hid_receive+0x10c>
c0d01340:	9301      	str	r3, [sp, #4]
c0d01342:	491b      	ldr	r1, [pc, #108]	; (c0d013b0 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d01344:	7988      	ldrb	r0, [r1, #6]
c0d01346:	7949      	ldrb	r1, [r1, #5]
c0d01348:	0209      	lsls	r1, r1, #8
c0d0134a:	4301      	orrs	r1, r0
c0d0134c:	481d      	ldr	r0, [pc, #116]	; (c0d013c4 <io_usb_hid_receive+0x14c>)
c0d0134e:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d01350:	6801      	ldr	r1, [r0, #0]
c0d01352:	2241      	movs	r2, #65	; 0x41
c0d01354:	0092      	lsls	r2, r2, #2
c0d01356:	4291      	cmp	r1, r2
c0d01358:	d8c9      	bhi.n	c0d012ee <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d0135a:	6801      	ldr	r1, [r0, #0]
c0d0135c:	4817      	ldr	r0, [pc, #92]	; (c0d013bc <io_usb_hid_receive+0x144>)
c0d0135e:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01360:	4917      	ldr	r1, [pc, #92]	; (c0d013c0 <io_usb_hid_receive+0x148>)
c0d01362:	4a19      	ldr	r2, [pc, #100]	; (c0d013c8 <io_usb_hid_receive+0x150>)
c0d01364:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d01366:	4919      	ldr	r1, [pc, #100]	; (c0d013cc <io_usb_hid_receive+0x154>)
c0d01368:	9a02      	ldr	r2, [sp, #8]
c0d0136a:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d0136c:	4629      	mov	r1, r5
c0d0136e:	9e01      	ldr	r6, [sp, #4]
c0d01370:	4031      	ands	r1, r6
c0d01372:	6802      	ldr	r2, [r0, #0]
c0d01374:	4291      	cmp	r1, r2
c0d01376:	d900      	bls.n	c0d0137a <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d01378:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d0137a:	462a      	mov	r2, r5
c0d0137c:	4032      	ands	r2, r6
c0d0137e:	480c      	ldr	r0, [pc, #48]	; (c0d013b0 <io_usb_hid_receive+0x138>)
c0d01380:	1dc1      	adds	r1, r0, #7
c0d01382:	4811      	ldr	r0, [pc, #68]	; (c0d013c8 <io_usb_hid_receive+0x150>)
c0d01384:	f000 f82e 	bl	c0d013e4 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d01388:	4035      	ands	r5, r6
c0d0138a:	480d      	ldr	r0, [pc, #52]	; (c0d013c0 <io_usb_hid_receive+0x148>)
c0d0138c:	6801      	ldr	r1, [r0, #0]
c0d0138e:	1949      	adds	r1, r1, r5
c0d01390:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d01392:	480a      	ldr	r0, [pc, #40]	; (c0d013bc <io_usb_hid_receive+0x144>)
c0d01394:	6801      	ldr	r1, [r0, #0]
c0d01396:	1b49      	subs	r1, r1, r5
c0d01398:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d0139a:	6820      	ldr	r0, [r4, #0]
c0d0139c:	1c40      	adds	r0, r0, #1
c0d0139e:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d013a0:	4806      	ldr	r0, [pc, #24]	; (c0d013bc <io_usb_hid_receive+0x144>)
c0d013a2:	6801      	ldr	r1, [r0, #0]
c0d013a4:	2001      	movs	r0, #1
c0d013a6:	2602      	movs	r6, #2
c0d013a8:	2900      	cmp	r1, #0
c0d013aa:	d1a4      	bne.n	c0d012f6 <io_usb_hid_receive+0x7e>
c0d013ac:	e79f      	b.n	c0d012ee <io_usb_hid_receive+0x76>
c0d013ae:	46c0      	nop			; (mov r8, r8)
c0d013b0:	20001b80 	.word	0x20001b80
c0d013b4:	20001bc0 	.word	0x20001bc0
c0d013b8:	0000ffff 	.word	0x0000ffff
c0d013bc:	20001bc8 	.word	0x20001bc8
c0d013c0:	20001cd0 	.word	0x20001cd0
c0d013c4:	20001bc4 	.word	0x20001bc4
c0d013c8:	20001bcc 	.word	0x20001bcc
c0d013cc:	0001fff9 	.word	0x0001fff9

c0d013d0 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d013d0:	b580      	push	{r7, lr}
c0d013d2:	af00      	add	r7, sp, #0
c0d013d4:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d013d6:	2a00      	cmp	r2, #0
c0d013d8:	d003      	beq.n	c0d013e2 <os_memset+0x12>
    DSTCHAR[length] = c;
c0d013da:	4611      	mov	r1, r2
c0d013dc:	461a      	mov	r2, r3
c0d013de:	f002 fb17 	bl	c0d03a10 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d013e2:	bd80      	pop	{r7, pc}

c0d013e4 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d013e4:	b5b0      	push	{r4, r5, r7, lr}
c0d013e6:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d013e8:	4288      	cmp	r0, r1
c0d013ea:	d90d      	bls.n	c0d01408 <os_memmove+0x24>
    while(length--) {
c0d013ec:	2a00      	cmp	r2, #0
c0d013ee:	d014      	beq.n	c0d0141a <os_memmove+0x36>
c0d013f0:	1e49      	subs	r1, r1, #1
c0d013f2:	4252      	negs	r2, r2
c0d013f4:	1e40      	subs	r0, r0, #1
c0d013f6:	2300      	movs	r3, #0
c0d013f8:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d013fa:	461c      	mov	r4, r3
c0d013fc:	4354      	muls	r4, r2
c0d013fe:	5d0d      	ldrb	r5, [r1, r4]
c0d01400:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d01402:	1c52      	adds	r2, r2, #1
c0d01404:	d1f9      	bne.n	c0d013fa <os_memmove+0x16>
c0d01406:	e008      	b.n	c0d0141a <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01408:	2a00      	cmp	r2, #0
c0d0140a:	d006      	beq.n	c0d0141a <os_memmove+0x36>
c0d0140c:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d0140e:	b29c      	uxth	r4, r3
c0d01410:	5d0d      	ldrb	r5, [r1, r4]
c0d01412:	5505      	strb	r5, [r0, r4]
      l++;
c0d01414:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01416:	1e52      	subs	r2, r2, #1
c0d01418:	d1f9      	bne.n	c0d0140e <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d0141a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0141c <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d0141c:	4801      	ldr	r0, [pc, #4]	; (c0d01424 <io_usb_hid_init+0x8>)
c0d0141e:	2100      	movs	r1, #0
c0d01420:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d01422:	4770      	bx	lr
c0d01424:	20001bc0 	.word	0x20001bc0

c0d01428 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d01428:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0142a:	af03      	add	r7, sp, #12
c0d0142c:	b087      	sub	sp, #28
c0d0142e:	9301      	str	r3, [sp, #4]
c0d01430:	9203      	str	r2, [sp, #12]
c0d01432:	460e      	mov	r6, r1
c0d01434:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d01436:	2e00      	cmp	r6, #0
c0d01438:	d042      	beq.n	c0d014c0 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d0143a:	4d31      	ldr	r5, [pc, #196]	; (c0d01500 <io_usb_hid_exchange+0xd8>)
c0d0143c:	2000      	movs	r0, #0
c0d0143e:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01440:	4930      	ldr	r1, [pc, #192]	; (c0d01504 <io_usb_hid_exchange+0xdc>)
c0d01442:	4831      	ldr	r0, [pc, #196]	; (c0d01508 <io_usb_hid_exchange+0xe0>)
c0d01444:	6008      	str	r0, [r1, #0]
c0d01446:	4c31      	ldr	r4, [pc, #196]	; (c0d0150c <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01448:	1d60      	adds	r0, r4, #5
c0d0144a:	213b      	movs	r1, #59	; 0x3b
c0d0144c:	9005      	str	r0, [sp, #20]
c0d0144e:	9102      	str	r1, [sp, #8]
c0d01450:	f002 fad4 	bl	c0d039fc <__aeabi_memclr>
c0d01454:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d01456:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d01458:	6828      	ldr	r0, [r5, #0]
c0d0145a:	0a00      	lsrs	r0, r0, #8
c0d0145c:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d0145e:	6828      	ldr	r0, [r5, #0]
c0d01460:	7120      	strb	r0, [r4, #4]
c0d01462:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d01464:	6828      	ldr	r0, [r5, #0]
c0d01466:	2800      	cmp	r0, #0
c0d01468:	9106      	str	r1, [sp, #24]
c0d0146a:	d009      	beq.n	c0d01480 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d0146c:	293b      	cmp	r1, #59	; 0x3b
c0d0146e:	460a      	mov	r2, r1
c0d01470:	d300      	bcc.n	c0d01474 <io_usb_hid_exchange+0x4c>
c0d01472:	9a02      	ldr	r2, [sp, #8]
c0d01474:	4823      	ldr	r0, [pc, #140]	; (c0d01504 <io_usb_hid_exchange+0xdc>)
c0d01476:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d01478:	6819      	ldr	r1, [r3, #0]
c0d0147a:	9805      	ldr	r0, [sp, #20]
c0d0147c:	461e      	mov	r6, r3
c0d0147e:	e00a      	b.n	c0d01496 <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d01480:	0a30      	lsrs	r0, r6, #8
c0d01482:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d01484:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d01486:	2039      	movs	r0, #57	; 0x39
c0d01488:	2939      	cmp	r1, #57	; 0x39
c0d0148a:	460a      	mov	r2, r1
c0d0148c:	d300      	bcc.n	c0d01490 <io_usb_hid_exchange+0x68>
c0d0148e:	4602      	mov	r2, r0
c0d01490:	4e1c      	ldr	r6, [pc, #112]	; (c0d01504 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d01492:	6831      	ldr	r1, [r6, #0]
c0d01494:	1de0      	adds	r0, r4, #7
c0d01496:	9205      	str	r2, [sp, #20]
c0d01498:	f7ff ffa4 	bl	c0d013e4 <os_memmove>
c0d0149c:	4d18      	ldr	r5, [pc, #96]	; (c0d01500 <io_usb_hid_exchange+0xd8>)
c0d0149e:	6830      	ldr	r0, [r6, #0]
c0d014a0:	4631      	mov	r1, r6
c0d014a2:	9e05      	ldr	r6, [sp, #20]
c0d014a4:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d014a6:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d014a8:	6828      	ldr	r0, [r5, #0]
c0d014aa:	1c40      	adds	r0, r0, #1
c0d014ac:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d014ae:	2140      	movs	r1, #64	; 0x40
c0d014b0:	4620      	mov	r0, r4
c0d014b2:	9a04      	ldr	r2, [sp, #16]
c0d014b4:	4790      	blx	r2
c0d014b6:	9806      	ldr	r0, [sp, #24]
c0d014b8:	1b86      	subs	r6, r0, r6
c0d014ba:	4815      	ldr	r0, [pc, #84]	; (c0d01510 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d014bc:	4206      	tst	r6, r0
c0d014be:	d1c3      	bne.n	c0d01448 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d014c0:	480f      	ldr	r0, [pc, #60]	; (c0d01500 <io_usb_hid_exchange+0xd8>)
c0d014c2:	2400      	movs	r4, #0
c0d014c4:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d014c6:	2080      	movs	r0, #128	; 0x80
c0d014c8:	9901      	ldr	r1, [sp, #4]
c0d014ca:	4201      	tst	r1, r0
c0d014cc:	d001      	beq.n	c0d014d2 <io_usb_hid_exchange+0xaa>
    reset();
c0d014ce:	f000 fe3f 	bl	c0d02150 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d014d2:	9801      	ldr	r0, [sp, #4]
c0d014d4:	0680      	lsls	r0, r0, #26
c0d014d6:	d40f      	bmi.n	c0d014f8 <io_usb_hid_exchange+0xd0>
c0d014d8:	4c0c      	ldr	r4, [pc, #48]	; (c0d0150c <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d014da:	2140      	movs	r1, #64	; 0x40
c0d014dc:	4620      	mov	r0, r4
c0d014de:	9a03      	ldr	r2, [sp, #12]
c0d014e0:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d014e2:	b2c2      	uxtb	r2, r0
c0d014e4:	2a40      	cmp	r2, #64	; 0x40
c0d014e6:	d8f8      	bhi.n	c0d014da <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d014e8:	9804      	ldr	r0, [sp, #16]
c0d014ea:	4621      	mov	r1, r4
c0d014ec:	f7ff fec4 	bl	c0d01278 <io_usb_hid_receive>
c0d014f0:	2802      	cmp	r0, #2
c0d014f2:	d1f2      	bne.n	c0d014da <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d014f4:	4807      	ldr	r0, [pc, #28]	; (c0d01514 <io_usb_hid_exchange+0xec>)
c0d014f6:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d014f8:	b2a0      	uxth	r0, r4
c0d014fa:	b007      	add	sp, #28
c0d014fc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d014fe:	46c0      	nop			; (mov r8, r8)
c0d01500:	20001bc0 	.word	0x20001bc0
c0d01504:	20001cd0 	.word	0x20001cd0
c0d01508:	20001bcc 	.word	0x20001bcc
c0d0150c:	20001b80 	.word	0x20001b80
c0d01510:	0000ffff 	.word	0x0000ffff
c0d01514:	20001bc4 	.word	0x20001bc4

c0d01518 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d01518:	b580      	push	{r7, lr}
c0d0151a:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d0151c:	f000 ffbc 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d01520:	2800      	cmp	r0, #0
c0d01522:	d10b      	bne.n	c0d0153c <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d01524:	4806      	ldr	r0, [pc, #24]	; (c0d01540 <io_seproxyhal_general_status+0x28>)
c0d01526:	2160      	movs	r1, #96	; 0x60
c0d01528:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d0152a:	2100      	movs	r1, #0
c0d0152c:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d0152e:	2202      	movs	r2, #2
c0d01530:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d01532:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d01534:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d01536:	2105      	movs	r1, #5
c0d01538:	f000 ff90 	bl	c0d0245c <io_seproxyhal_spi_send>
}
c0d0153c:	bd80      	pop	{r7, pc}
c0d0153e:	46c0      	nop			; (mov r8, r8)
c0d01540:	200019d8 	.word	0x200019d8

c0d01544 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d01544:	b5d0      	push	{r4, r6, r7, lr}
c0d01546:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d01548:	4815      	ldr	r0, [pc, #84]	; (c0d015a0 <io_seproxyhal_handle_usb_event+0x5c>)
c0d0154a:	78c0      	ldrb	r0, [r0, #3]
c0d0154c:	1e40      	subs	r0, r0, #1
c0d0154e:	2807      	cmp	r0, #7
c0d01550:	d824      	bhi.n	c0d0159c <io_seproxyhal_handle_usb_event+0x58>
c0d01552:	46c0      	nop			; (mov r8, r8)
c0d01554:	4478      	add	r0, pc
c0d01556:	7900      	ldrb	r0, [r0, #4]
c0d01558:	0040      	lsls	r0, r0, #1
c0d0155a:	4487      	add	pc, r0
c0d0155c:	141f1803 	.word	0x141f1803
c0d01560:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d01564:	4c0f      	ldr	r4, [pc, #60]	; (c0d015a4 <io_seproxyhal_handle_usb_event+0x60>)
c0d01566:	2101      	movs	r1, #1
c0d01568:	4620      	mov	r0, r4
c0d0156a:	f001 fbc7 	bl	c0d02cfc <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d0156e:	4620      	mov	r0, r4
c0d01570:	f001 fbac 	bl	c0d02ccc <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d01574:	480c      	ldr	r0, [pc, #48]	; (c0d015a8 <io_seproxyhal_handle_usb_event+0x64>)
c0d01576:	7800      	ldrb	r0, [r0, #0]
c0d01578:	2801      	cmp	r0, #1
c0d0157a:	d10f      	bne.n	c0d0159c <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d0157c:	480b      	ldr	r0, [pc, #44]	; (c0d015ac <io_seproxyhal_handle_usb_event+0x68>)
c0d0157e:	6800      	ldr	r0, [r0, #0]
c0d01580:	2110      	movs	r1, #16
c0d01582:	f002 fadd 	bl	c0d03b40 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d01586:	4807      	ldr	r0, [pc, #28]	; (c0d015a4 <io_seproxyhal_handle_usb_event+0x60>)
c0d01588:	f001 fbbb 	bl	c0d02d02 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d0158c:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d0158e:	4805      	ldr	r0, [pc, #20]	; (c0d015a4 <io_seproxyhal_handle_usb_event+0x60>)
c0d01590:	f001 fbbb 	bl	c0d02d0a <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d01594:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d01596:	4803      	ldr	r0, [pc, #12]	; (c0d015a4 <io_seproxyhal_handle_usb_event+0x60>)
c0d01598:	f001 fbb5 	bl	c0d02d06 <USBD_LL_Resume>
      break;
  }
}
c0d0159c:	bdd0      	pop	{r4, r6, r7, pc}
c0d0159e:	46c0      	nop			; (mov r8, r8)
c0d015a0:	200019d8 	.word	0x200019d8
c0d015a4:	20001d24 	.word	0x20001d24
c0d015a8:	20001cd4 	.word	0x20001cd4
c0d015ac:	20001b7c 	.word	0x20001b7c

c0d015b0 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d015b0:	217f      	movs	r1, #127	; 0x7f
c0d015b2:	4001      	ands	r1, r0
c0d015b4:	4801      	ldr	r0, [pc, #4]	; (c0d015bc <io_seproxyhal_get_ep_rx_size+0xc>)
c0d015b6:	5c40      	ldrb	r0, [r0, r1]
c0d015b8:	4770      	bx	lr
c0d015ba:	46c0      	nop			; (mov r8, r8)
c0d015bc:	20001cd5 	.word	0x20001cd5

c0d015c0 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d015c0:	b580      	push	{r7, lr}
c0d015c2:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d015c4:	480f      	ldr	r0, [pc, #60]	; (c0d01604 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d015c6:	7901      	ldrb	r1, [r0, #4]
c0d015c8:	2904      	cmp	r1, #4
c0d015ca:	d008      	beq.n	c0d015de <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d015cc:	2902      	cmp	r1, #2
c0d015ce:	d011      	beq.n	c0d015f4 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d015d0:	2901      	cmp	r1, #1
c0d015d2:	d10e      	bne.n	c0d015f2 <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d015d4:	1d81      	adds	r1, r0, #6
c0d015d6:	480d      	ldr	r0, [pc, #52]	; (c0d0160c <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d015d8:	f001 fa9c 	bl	c0d02b14 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d015dc:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d015de:	78c2      	ldrb	r2, [r0, #3]
c0d015e0:	217f      	movs	r1, #127	; 0x7f
c0d015e2:	4011      	ands	r1, r2
c0d015e4:	7942      	ldrb	r2, [r0, #5]
c0d015e6:	4b08      	ldr	r3, [pc, #32]	; (c0d01608 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d015e8:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d015ea:	1d82      	adds	r2, r0, #6
c0d015ec:	4807      	ldr	r0, [pc, #28]	; (c0d0160c <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d015ee:	f001 fac3 	bl	c0d02b78 <USBD_LL_DataOutStage>
      break;
  }
}
c0d015f2:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d015f4:	78c2      	ldrb	r2, [r0, #3]
c0d015f6:	217f      	movs	r1, #127	; 0x7f
c0d015f8:	4011      	ands	r1, r2
c0d015fa:	1d82      	adds	r2, r0, #6
c0d015fc:	4803      	ldr	r0, [pc, #12]	; (c0d0160c <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d015fe:	f001 fb01 	bl	c0d02c04 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d01602:	bd80      	pop	{r7, pc}
c0d01604:	200019d8 	.word	0x200019d8
c0d01608:	20001cd5 	.word	0x20001cd5
c0d0160c:	20001d24 	.word	0x20001d24

c0d01610 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d01610:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01612:	af03      	add	r7, sp, #12
c0d01614:	b083      	sub	sp, #12
c0d01616:	9201      	str	r2, [sp, #4]
c0d01618:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d0161a:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d0161c:	2b00      	cmp	r3, #0
c0d0161e:	d100      	bne.n	c0d01622 <io_usb_send_ep+0x12>
c0d01620:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d01622:	9801      	ldr	r0, [sp, #4]
c0d01624:	28ff      	cmp	r0, #255	; 0xff
c0d01626:	d843      	bhi.n	c0d016b0 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01628:	4e25      	ldr	r6, [pc, #148]	; (c0d016c0 <io_usb_send_ep+0xb0>)
c0d0162a:	2050      	movs	r0, #80	; 0x50
c0d0162c:	7030      	strb	r0, [r6, #0]
c0d0162e:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d01630:	1ce0      	adds	r0, r4, #3
c0d01632:	9100      	str	r1, [sp, #0]
c0d01634:	0a01      	lsrs	r1, r0, #8
c0d01636:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d01638:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d0163a:	2080      	movs	r0, #128	; 0x80
c0d0163c:	4302      	orrs	r2, r0
c0d0163e:	9202      	str	r2, [sp, #8]
c0d01640:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d01642:	2020      	movs	r0, #32
c0d01644:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d01646:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d01648:	2106      	movs	r1, #6
c0d0164a:	4630      	mov	r0, r6
c0d0164c:	f000 ff06 	bl	c0d0245c <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d01650:	9800      	ldr	r0, [sp, #0]
c0d01652:	4621      	mov	r1, r4
c0d01654:	f000 ff02 	bl	c0d0245c <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d01658:	2d00      	cmp	r5, #0
c0d0165a:	d10d      	bne.n	c0d01678 <io_usb_send_ep+0x68>
c0d0165c:	e028      	b.n	c0d016b0 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d0165e:	2d00      	cmp	r5, #0
c0d01660:	d002      	beq.n	c0d01668 <io_usb_send_ep+0x58>
c0d01662:	1e6c      	subs	r4, r5, #1
c0d01664:	2d01      	cmp	r5, #1
c0d01666:	d025      	beq.n	c0d016b4 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d01668:	2915      	cmp	r1, #21
c0d0166a:	d102      	bne.n	c0d01672 <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d0166c:	79b0      	ldrb	r0, [r6, #6]
c0d0166e:	0700      	lsls	r0, r0, #28
c0d01670:	d520      	bpl.n	c0d016b4 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d01672:	f000 f829 	bl	c0d016c8 <io_seproxyhal_handle_event>
c0d01676:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01678:	f000 ff0e 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d0167c:	2800      	cmp	r0, #0
c0d0167e:	d101      	bne.n	c0d01684 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d01680:	f7ff ff4a 	bl	c0d01518 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01684:	2180      	movs	r1, #128	; 0x80
c0d01686:	2400      	movs	r4, #0
c0d01688:	4630      	mov	r0, r6
c0d0168a:	4622      	mov	r2, r4
c0d0168c:	f000 ff20 	bl	c0d024d0 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d01690:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d01692:	2806      	cmp	r0, #6
c0d01694:	d1e3      	bne.n	c0d0165e <io_usb_send_ep+0x4e>
c0d01696:	2910      	cmp	r1, #16
c0d01698:	d1e1      	bne.n	c0d0165e <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d0169a:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d0169c:	9a02      	ldr	r2, [sp, #8]
c0d0169e:	4290      	cmp	r0, r2
c0d016a0:	d1dd      	bne.n	c0d0165e <io_usb_send_ep+0x4e>
c0d016a2:	7930      	ldrb	r0, [r6, #4]
c0d016a4:	2802      	cmp	r0, #2
c0d016a6:	d1da      	bne.n	c0d0165e <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d016a8:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d016aa:	9a01      	ldr	r2, [sp, #4]
c0d016ac:	4290      	cmp	r0, r2
c0d016ae:	d1d6      	bne.n	c0d0165e <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d016b0:	b003      	add	sp, #12
c0d016b2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d016b4:	4803      	ldr	r0, [pc, #12]	; (c0d016c4 <io_usb_send_ep+0xb4>)
c0d016b6:	6800      	ldr	r0, [r0, #0]
c0d016b8:	2110      	movs	r1, #16
c0d016ba:	f002 fa41 	bl	c0d03b40 <longjmp>
c0d016be:	46c0      	nop			; (mov r8, r8)
c0d016c0:	200019d8 	.word	0x200019d8
c0d016c4:	20001b7c 	.word	0x20001b7c

c0d016c8 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d016c8:	b580      	push	{r7, lr}
c0d016ca:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d016cc:	480d      	ldr	r0, [pc, #52]	; (c0d01704 <io_seproxyhal_handle_event+0x3c>)
c0d016ce:	7882      	ldrb	r2, [r0, #2]
c0d016d0:	7841      	ldrb	r1, [r0, #1]
c0d016d2:	0209      	lsls	r1, r1, #8
c0d016d4:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d016d6:	7800      	ldrb	r0, [r0, #0]
c0d016d8:	2810      	cmp	r0, #16
c0d016da:	d008      	beq.n	c0d016ee <io_seproxyhal_handle_event+0x26>
c0d016dc:	280f      	cmp	r0, #15
c0d016de:	d10d      	bne.n	c0d016fc <io_seproxyhal_handle_event+0x34>
c0d016e0:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d016e2:	2904      	cmp	r1, #4
c0d016e4:	d10d      	bne.n	c0d01702 <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d016e6:	f7ff ff2d 	bl	c0d01544 <io_seproxyhal_handle_usb_event>
c0d016ea:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d016ec:	bd80      	pop	{r7, pc}
c0d016ee:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d016f0:	2906      	cmp	r1, #6
c0d016f2:	d306      	bcc.n	c0d01702 <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d016f4:	f7ff ff64 	bl	c0d015c0 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d016f8:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d016fa:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d016fc:	2002      	movs	r0, #2
c0d016fe:	f7ff fa67 	bl	c0d00bd0 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d01702:	bd80      	pop	{r7, pc}
c0d01704:	200019d8 	.word	0x200019d8

c0d01708 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01708:	b580      	push	{r7, lr}
c0d0170a:	af00      	add	r7, sp, #0
c0d0170c:	460a      	mov	r2, r1
c0d0170e:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01710:	2082      	movs	r0, #130	; 0x82
c0d01712:	2314      	movs	r3, #20
c0d01714:	f7ff ff7c 	bl	c0d01610 <io_usb_send_ep>
}
c0d01718:	bd80      	pop	{r7, pc}
	...

c0d0171c <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d0171c:	b5d0      	push	{r4, r6, r7, lr}
c0d0171e:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01720:	2007      	movs	r0, #7
c0d01722:	f000 fcf7 	bl	c0d02114 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d01726:	480a      	ldr	r0, [pc, #40]	; (c0d01750 <io_seproxyhal_init+0x34>)
c0d01728:	2400      	movs	r4, #0
c0d0172a:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d0172c:	4809      	ldr	r0, [pc, #36]	; (c0d01754 <io_seproxyhal_init+0x38>)
c0d0172e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d01730:	4809      	ldr	r0, [pc, #36]	; (c0d01758 <io_seproxyhal_init+0x3c>)
c0d01732:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d01734:	4809      	ldr	r0, [pc, #36]	; (c0d0175c <io_seproxyhal_init+0x40>)
c0d01736:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01738:	4809      	ldr	r0, [pc, #36]	; (c0d01760 <io_seproxyhal_init+0x44>)
c0d0173a:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d0173c:	f7ff fe6e 	bl	c0d0141c <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01740:	4808      	ldr	r0, [pc, #32]	; (c0d01764 <io_seproxyhal_init+0x48>)
c0d01742:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d01744:	4808      	ldr	r0, [pc, #32]	; (c0d01768 <io_seproxyhal_init+0x4c>)
c0d01746:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d01748:	4808      	ldr	r0, [pc, #32]	; (c0d0176c <io_seproxyhal_init+0x50>)
c0d0174a:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d0174c:	bdd0      	pop	{r4, r6, r7, pc}
c0d0174e:	46c0      	nop			; (mov r8, r8)
c0d01750:	20001cdc 	.word	0x20001cdc
c0d01754:	20001cde 	.word	0x20001cde
c0d01758:	20001ce0 	.word	0x20001ce0
c0d0175c:	20001ce2 	.word	0x20001ce2
c0d01760:	20001cd4 	.word	0x20001cd4
c0d01764:	20001ce4 	.word	0x20001ce4
c0d01768:	20001ce8 	.word	0x20001ce8
c0d0176c:	20001cec 	.word	0x20001cec

c0d01770 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01770:	4801      	ldr	r0, [pc, #4]	; (c0d01778 <io_seproxyhal_init_ux+0x8>)
c0d01772:	2100      	movs	r1, #0
c0d01774:	6001      	str	r1, [r0, #0]

}
c0d01776:	4770      	bx	lr
c0d01778:	20001ce4 	.word	0x20001ce4

c0d0177c <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d0177c:	b5b0      	push	{r4, r5, r7, lr}
c0d0177e:	af02      	add	r7, sp, #8
c0d01780:	460d      	mov	r5, r1
c0d01782:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d01784:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d01786:	2800      	cmp	r0, #0
c0d01788:	d00c      	beq.n	c0d017a4 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d0178a:	f000 fcab 	bl	c0d020e4 <pic>
c0d0178e:	4601      	mov	r1, r0
c0d01790:	4620      	mov	r0, r4
c0d01792:	4788      	blx	r1
c0d01794:	f000 fca6 	bl	c0d020e4 <pic>
c0d01798:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d0179a:	2800      	cmp	r0, #0
c0d0179c:	d010      	beq.n	c0d017c0 <io_seproxyhal_touch_out+0x44>
c0d0179e:	2801      	cmp	r0, #1
c0d017a0:	d000      	beq.n	c0d017a4 <io_seproxyhal_touch_out+0x28>
c0d017a2:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d017a4:	2d00      	cmp	r5, #0
c0d017a6:	d007      	beq.n	c0d017b8 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d017a8:	4620      	mov	r0, r4
c0d017aa:	47a8      	blx	r5
c0d017ac:	2100      	movs	r1, #0
    if (!el) {
c0d017ae:	2800      	cmp	r0, #0
c0d017b0:	d006      	beq.n	c0d017c0 <io_seproxyhal_touch_out+0x44>
c0d017b2:	2801      	cmp	r0, #1
c0d017b4:	d000      	beq.n	c0d017b8 <io_seproxyhal_touch_out+0x3c>
c0d017b6:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d017b8:	4620      	mov	r0, r4
c0d017ba:	f7ff fa03 	bl	c0d00bc4 <io_seproxyhal_display>
c0d017be:	2101      	movs	r1, #1
  return 1;
}
c0d017c0:	4608      	mov	r0, r1
c0d017c2:	bdb0      	pop	{r4, r5, r7, pc}

c0d017c4 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d017c4:	b5b0      	push	{r4, r5, r7, lr}
c0d017c6:	af02      	add	r7, sp, #8
c0d017c8:	b08e      	sub	sp, #56	; 0x38
c0d017ca:	460c      	mov	r4, r1
c0d017cc:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d017ce:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d017d0:	2800      	cmp	r0, #0
c0d017d2:	d00c      	beq.n	c0d017ee <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d017d4:	f000 fc86 	bl	c0d020e4 <pic>
c0d017d8:	4601      	mov	r1, r0
c0d017da:	4628      	mov	r0, r5
c0d017dc:	4788      	blx	r1
c0d017de:	f000 fc81 	bl	c0d020e4 <pic>
c0d017e2:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d017e4:	2800      	cmp	r0, #0
c0d017e6:	d016      	beq.n	c0d01816 <io_seproxyhal_touch_over+0x52>
c0d017e8:	2801      	cmp	r0, #1
c0d017ea:	d000      	beq.n	c0d017ee <io_seproxyhal_touch_over+0x2a>
c0d017ec:	4605      	mov	r5, r0
c0d017ee:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d017f0:	2238      	movs	r2, #56	; 0x38
c0d017f2:	4629      	mov	r1, r5
c0d017f4:	f7ff fdf6 	bl	c0d013e4 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d017f8:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d017fa:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d017fc:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d017fe:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d01800:	2c00      	cmp	r4, #0
c0d01802:	d004      	beq.n	c0d0180e <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01804:	4628      	mov	r0, r5
c0d01806:	47a0      	blx	r4
c0d01808:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d0180a:	2800      	cmp	r0, #0
c0d0180c:	d003      	beq.n	c0d01816 <io_seproxyhal_touch_over+0x52>
c0d0180e:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01810:	f7ff f9d8 	bl	c0d00bc4 <io_seproxyhal_display>
c0d01814:	2101      	movs	r1, #1
  return 1;
}
c0d01816:	4608      	mov	r0, r1
c0d01818:	b00e      	add	sp, #56	; 0x38
c0d0181a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0181c <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d0181c:	b5b0      	push	{r4, r5, r7, lr}
c0d0181e:	af02      	add	r7, sp, #8
c0d01820:	460d      	mov	r5, r1
c0d01822:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01824:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d01826:	2800      	cmp	r0, #0
c0d01828:	d00c      	beq.n	c0d01844 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d0182a:	f000 fc5b 	bl	c0d020e4 <pic>
c0d0182e:	4601      	mov	r1, r0
c0d01830:	4620      	mov	r0, r4
c0d01832:	4788      	blx	r1
c0d01834:	f000 fc56 	bl	c0d020e4 <pic>
c0d01838:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0183a:	2800      	cmp	r0, #0
c0d0183c:	d010      	beq.n	c0d01860 <io_seproxyhal_touch_tap+0x44>
c0d0183e:	2801      	cmp	r0, #1
c0d01840:	d000      	beq.n	c0d01844 <io_seproxyhal_touch_tap+0x28>
c0d01842:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01844:	2d00      	cmp	r5, #0
c0d01846:	d007      	beq.n	c0d01858 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d01848:	4620      	mov	r0, r4
c0d0184a:	47a8      	blx	r5
c0d0184c:	2100      	movs	r1, #0
    if (!el) {
c0d0184e:	2800      	cmp	r0, #0
c0d01850:	d006      	beq.n	c0d01860 <io_seproxyhal_touch_tap+0x44>
c0d01852:	2801      	cmp	r0, #1
c0d01854:	d000      	beq.n	c0d01858 <io_seproxyhal_touch_tap+0x3c>
c0d01856:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d01858:	4620      	mov	r0, r4
c0d0185a:	f7ff f9b3 	bl	c0d00bc4 <io_seproxyhal_display>
c0d0185e:	2101      	movs	r1, #1
  return 1;
}
c0d01860:	4608      	mov	r0, r1
c0d01862:	bdb0      	pop	{r4, r5, r7, pc}

c0d01864 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d01864:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01866:	af03      	add	r7, sp, #12
c0d01868:	b087      	sub	sp, #28
c0d0186a:	9302      	str	r3, [sp, #8]
c0d0186c:	9203      	str	r2, [sp, #12]
c0d0186e:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01870:	2900      	cmp	r1, #0
c0d01872:	d076      	beq.n	c0d01962 <io_seproxyhal_touch_element_callback+0xfe>
c0d01874:	9004      	str	r0, [sp, #16]
c0d01876:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01878:	9001      	str	r0, [sp, #4]
c0d0187a:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d0187c:	9000      	str	r0, [sp, #0]
c0d0187e:	2600      	movs	r6, #0
c0d01880:	9606      	str	r6, [sp, #24]
c0d01882:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01884:	f000 fe08 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d01888:	2800      	cmp	r0, #0
c0d0188a:	d155      	bne.n	c0d01938 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d0188c:	2038      	movs	r0, #56	; 0x38
c0d0188e:	4370      	muls	r0, r6
c0d01890:	9d04      	ldr	r5, [sp, #16]
c0d01892:	182e      	adds	r6, r5, r0
c0d01894:	4b36      	ldr	r3, [pc, #216]	; (c0d01970 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01896:	681a      	ldr	r2, [r3, #0]
c0d01898:	2101      	movs	r1, #1
c0d0189a:	4296      	cmp	r6, r2
c0d0189c:	d000      	beq.n	c0d018a0 <io_seproxyhal_touch_element_callback+0x3c>
c0d0189e:	9906      	ldr	r1, [sp, #24]
c0d018a0:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d018a2:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d018a4:	2800      	cmp	r0, #0
c0d018a6:	da41      	bge.n	c0d0192c <io_seproxyhal_touch_element_callback+0xc8>
c0d018a8:	2020      	movs	r0, #32
c0d018aa:	5c35      	ldrb	r5, [r6, r0]
c0d018ac:	2102      	movs	r1, #2
c0d018ae:	5e71      	ldrsh	r1, [r6, r1]
c0d018b0:	1b4a      	subs	r2, r1, r5
c0d018b2:	9803      	ldr	r0, [sp, #12]
c0d018b4:	4282      	cmp	r2, r0
c0d018b6:	dc39      	bgt.n	c0d0192c <io_seproxyhal_touch_element_callback+0xc8>
c0d018b8:	1869      	adds	r1, r5, r1
c0d018ba:	88f2      	ldrh	r2, [r6, #6]
c0d018bc:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d018be:	9803      	ldr	r0, [sp, #12]
c0d018c0:	4288      	cmp	r0, r1
c0d018c2:	da33      	bge.n	c0d0192c <io_seproxyhal_touch_element_callback+0xc8>
c0d018c4:	2104      	movs	r1, #4
c0d018c6:	5e70      	ldrsh	r0, [r6, r1]
c0d018c8:	1b42      	subs	r2, r0, r5
c0d018ca:	9902      	ldr	r1, [sp, #8]
c0d018cc:	428a      	cmp	r2, r1
c0d018ce:	dc2d      	bgt.n	c0d0192c <io_seproxyhal_touch_element_callback+0xc8>
c0d018d0:	1940      	adds	r0, r0, r5
c0d018d2:	8931      	ldrh	r1, [r6, #8]
c0d018d4:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d018d6:	9902      	ldr	r1, [sp, #8]
c0d018d8:	4281      	cmp	r1, r0
c0d018da:	da27      	bge.n	c0d0192c <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d018dc:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d018de:	4286      	cmp	r6, r0
c0d018e0:	d010      	beq.n	c0d01904 <io_seproxyhal_touch_element_callback+0xa0>
c0d018e2:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d018e4:	2800      	cmp	r0, #0
c0d018e6:	d00d      	beq.n	c0d01904 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d018e8:	9801      	ldr	r0, [sp, #4]
c0d018ea:	2800      	cmp	r0, #0
c0d018ec:	d005      	beq.n	c0d018fa <io_seproxyhal_touch_element_callback+0x96>
c0d018ee:	4630      	mov	r0, r6
c0d018f0:	9901      	ldr	r1, [sp, #4]
c0d018f2:	4788      	blx	r1
c0d018f4:	4b1e      	ldr	r3, [pc, #120]	; (c0d01970 <io_seproxyhal_touch_element_callback+0x10c>)
c0d018f6:	2800      	cmp	r0, #0
c0d018f8:	d018      	beq.n	c0d0192c <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d018fa:	6818      	ldr	r0, [r3, #0]
c0d018fc:	9901      	ldr	r1, [sp, #4]
c0d018fe:	f7ff ff3d 	bl	c0d0177c <io_seproxyhal_touch_out>
c0d01902:	e008      	b.n	c0d01916 <io_seproxyhal_touch_element_callback+0xb2>
c0d01904:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d01906:	2801      	cmp	r0, #1
c0d01908:	d009      	beq.n	c0d0191e <io_seproxyhal_touch_element_callback+0xba>
c0d0190a:	2802      	cmp	r0, #2
c0d0190c:	d10e      	bne.n	c0d0192c <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d0190e:	4630      	mov	r0, r6
c0d01910:	9901      	ldr	r1, [sp, #4]
c0d01912:	f7ff ff83 	bl	c0d0181c <io_seproxyhal_touch_tap>
c0d01916:	4b16      	ldr	r3, [pc, #88]	; (c0d01970 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01918:	2800      	cmp	r0, #0
c0d0191a:	d007      	beq.n	c0d0192c <io_seproxyhal_touch_element_callback+0xc8>
c0d0191c:	e023      	b.n	c0d01966 <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d0191e:	4630      	mov	r0, r6
c0d01920:	9901      	ldr	r1, [sp, #4]
c0d01922:	f7ff ff4f 	bl	c0d017c4 <io_seproxyhal_touch_over>
c0d01926:	4b12      	ldr	r3, [pc, #72]	; (c0d01970 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01928:	2800      	cmp	r0, #0
c0d0192a:	d11f      	bne.n	c0d0196c <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d0192c:	1c64      	adds	r4, r4, #1
c0d0192e:	b2e6      	uxtb	r6, r4
c0d01930:	9805      	ldr	r0, [sp, #20]
c0d01932:	4286      	cmp	r6, r0
c0d01934:	d3a6      	bcc.n	c0d01884 <io_seproxyhal_touch_element_callback+0x20>
c0d01936:	e000      	b.n	c0d0193a <io_seproxyhal_touch_element_callback+0xd6>
c0d01938:	4b0d      	ldr	r3, [pc, #52]	; (c0d01970 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d0193a:	9806      	ldr	r0, [sp, #24]
c0d0193c:	0600      	lsls	r0, r0, #24
c0d0193e:	d010      	beq.n	c0d01962 <io_seproxyhal_touch_element_callback+0xfe>
c0d01940:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d01942:	2800      	cmp	r0, #0
c0d01944:	d00d      	beq.n	c0d01962 <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01946:	f000 fda7 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d0194a:	4909      	ldr	r1, [pc, #36]	; (c0d01970 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0194c:	2800      	cmp	r0, #0
c0d0194e:	d108      	bne.n	c0d01962 <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01950:	6808      	ldr	r0, [r1, #0]
c0d01952:	9901      	ldr	r1, [sp, #4]
c0d01954:	f7ff ff12 	bl	c0d0177c <io_seproxyhal_touch_out>
c0d01958:	4d05      	ldr	r5, [pc, #20]	; (c0d01970 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0195a:	2800      	cmp	r0, #0
c0d0195c:	d001      	beq.n	c0d01962 <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d0195e:	2000      	movs	r0, #0
c0d01960:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d01962:	b007      	add	sp, #28
c0d01964:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01966:	2000      	movs	r0, #0
c0d01968:	6018      	str	r0, [r3, #0]
c0d0196a:	e7fa      	b.n	c0d01962 <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d0196c:	601e      	str	r6, [r3, #0]
c0d0196e:	e7f8      	b.n	c0d01962 <io_seproxyhal_touch_element_callback+0xfe>
c0d01970:	20001ce4 	.word	0x20001ce4

c0d01974 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d01974:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01976:	af03      	add	r7, sp, #12
c0d01978:	b08b      	sub	sp, #44	; 0x2c
c0d0197a:	460c      	mov	r4, r1
c0d0197c:	4601      	mov	r1, r0
c0d0197e:	ad04      	add	r5, sp, #16
c0d01980:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d01982:	4628      	mov	r0, r5
c0d01984:	9203      	str	r2, [sp, #12]
c0d01986:	f7ff fd2d 	bl	c0d013e4 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d0198a:	6821      	ldr	r1, [r4, #0]
c0d0198c:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d0198e:	6862      	ldr	r2, [r4, #4]
c0d01990:	9502      	str	r5, [sp, #8]
c0d01992:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01994:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01996:	4e1a      	ldr	r6, [pc, #104]	; (c0d01a00 <io_seproxyhal_display_icon+0x8c>)
c0d01998:	2365      	movs	r3, #101	; 0x65
c0d0199a:	4635      	mov	r5, r6
c0d0199c:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d0199e:	b292      	uxth	r2, r2
c0d019a0:	4342      	muls	r2, r0
c0d019a2:	b28b      	uxth	r3, r1
c0d019a4:	4353      	muls	r3, r2
c0d019a6:	08d9      	lsrs	r1, r3, #3
c0d019a8:	1c4e      	adds	r6, r1, #1
c0d019aa:	2207      	movs	r2, #7
c0d019ac:	4213      	tst	r3, r2
c0d019ae:	d100      	bne.n	c0d019b2 <io_seproxyhal_display_icon+0x3e>
c0d019b0:	460e      	mov	r6, r1
c0d019b2:	4631      	mov	r1, r6
c0d019b4:	9101      	str	r1, [sp, #4]
c0d019b6:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d019b8:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d019ba:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d019bc:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d019be:	0a01      	lsrs	r1, r0, #8
c0d019c0:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d019c2:	70a8      	strb	r0, [r5, #2]
c0d019c4:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d019c6:	4628      	mov	r0, r5
c0d019c8:	f000 fd48 	bl	c0d0245c <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d019cc:	9802      	ldr	r0, [sp, #8]
c0d019ce:	9903      	ldr	r1, [sp, #12]
c0d019d0:	f000 fd44 	bl	c0d0245c <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d019d4:	68a0      	ldr	r0, [r4, #8]
c0d019d6:	7028      	strb	r0, [r5, #0]
c0d019d8:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d019da:	4628      	mov	r0, r5
c0d019dc:	f000 fd3e 	bl	c0d0245c <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d019e0:	68e0      	ldr	r0, [r4, #12]
c0d019e2:	f000 fb7f 	bl	c0d020e4 <pic>
c0d019e6:	b2b1      	uxth	r1, r6
c0d019e8:	f000 fd38 	bl	c0d0245c <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d019ec:	9801      	ldr	r0, [sp, #4]
c0d019ee:	b285      	uxth	r5, r0
c0d019f0:	6920      	ldr	r0, [r4, #16]
c0d019f2:	f000 fb77 	bl	c0d020e4 <pic>
c0d019f6:	4629      	mov	r1, r5
c0d019f8:	f000 fd30 	bl	c0d0245c <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d019fc:	b00b      	add	sp, #44	; 0x2c
c0d019fe:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01a00:	200019d8 	.word	0x200019d8

c0d01a04 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01a04:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a06:	af03      	add	r7, sp, #12
c0d01a08:	b081      	sub	sp, #4
c0d01a0a:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01a0c:	7820      	ldrb	r0, [r4, #0]
c0d01a0e:	267f      	movs	r6, #127	; 0x7f
c0d01a10:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d01a12:	2e00      	cmp	r6, #0
c0d01a14:	d02e      	beq.n	c0d01a74 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d01a16:	69e0      	ldr	r0, [r4, #28]
c0d01a18:	2800      	cmp	r0, #0
c0d01a1a:	d01d      	beq.n	c0d01a58 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01a1c:	f000 fb62 	bl	c0d020e4 <pic>
c0d01a20:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d01a22:	2e05      	cmp	r6, #5
c0d01a24:	d102      	bne.n	c0d01a2c <io_seproxyhal_display_default+0x28>
c0d01a26:	7ea0      	ldrb	r0, [r4, #26]
c0d01a28:	2800      	cmp	r0, #0
c0d01a2a:	d025      	beq.n	c0d01a78 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01a2c:	4628      	mov	r0, r5
c0d01a2e:	f002 f895 	bl	c0d03b5c <strlen>
c0d01a32:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01a34:	4813      	ldr	r0, [pc, #76]	; (c0d01a84 <io_seproxyhal_display_default+0x80>)
c0d01a36:	2165      	movs	r1, #101	; 0x65
c0d01a38:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01a3a:	4631      	mov	r1, r6
c0d01a3c:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01a3e:	0a0a      	lsrs	r2, r1, #8
c0d01a40:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d01a42:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01a44:	2103      	movs	r1, #3
c0d01a46:	f000 fd09 	bl	c0d0245c <io_seproxyhal_spi_send>
c0d01a4a:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01a4c:	4620      	mov	r0, r4
c0d01a4e:	f000 fd05 	bl	c0d0245c <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d01a52:	b2b1      	uxth	r1, r6
c0d01a54:	4628      	mov	r0, r5
c0d01a56:	e00b      	b.n	c0d01a70 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01a58:	480a      	ldr	r0, [pc, #40]	; (c0d01a84 <io_seproxyhal_display_default+0x80>)
c0d01a5a:	2165      	movs	r1, #101	; 0x65
c0d01a5c:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01a5e:	2100      	movs	r1, #0
c0d01a60:	7041      	strb	r1, [r0, #1]
c0d01a62:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01a64:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01a66:	2103      	movs	r1, #3
c0d01a68:	f000 fcf8 	bl	c0d0245c <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01a6c:	4620      	mov	r0, r4
c0d01a6e:	4629      	mov	r1, r5
c0d01a70:	f000 fcf4 	bl	c0d0245c <io_seproxyhal_spi_send>
    }
  }
}
c0d01a74:	b001      	add	sp, #4
c0d01a76:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d01a78:	4620      	mov	r0, r4
c0d01a7a:	4629      	mov	r1, r5
c0d01a7c:	f7ff ff7a 	bl	c0d01974 <io_seproxyhal_display_icon>
c0d01a80:	e7f8      	b.n	c0d01a74 <io_seproxyhal_display_default+0x70>
c0d01a82:	46c0      	nop			; (mov r8, r8)
c0d01a84:	200019d8 	.word	0x200019d8

c0d01a88 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d01a88:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a8a:	af03      	add	r7, sp, #12
c0d01a8c:	b081      	sub	sp, #4
c0d01a8e:	4604      	mov	r4, r0
  if (button_callback) {
c0d01a90:	2c00      	cmp	r4, #0
c0d01a92:	d02e      	beq.n	c0d01af2 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d01a94:	4818      	ldr	r0, [pc, #96]	; (c0d01af8 <io_seproxyhal_button_push+0x70>)
c0d01a96:	6802      	ldr	r2, [r0, #0]
c0d01a98:	428a      	cmp	r2, r1
c0d01a9a:	d103      	bne.n	c0d01aa4 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01a9c:	4a17      	ldr	r2, [pc, #92]	; (c0d01afc <io_seproxyhal_button_push+0x74>)
c0d01a9e:	6813      	ldr	r3, [r2, #0]
c0d01aa0:	1c5b      	adds	r3, r3, #1
c0d01aa2:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01aa4:	6806      	ldr	r6, [r0, #0]
c0d01aa6:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d01aa8:	4a14      	ldr	r2, [pc, #80]	; (c0d01afc <io_seproxyhal_button_push+0x74>)
c0d01aaa:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01aac:	2900      	cmp	r1, #0
c0d01aae:	d001      	beq.n	c0d01ab4 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01ab0:	6006      	str	r6, [r0, #0]
c0d01ab2:	e005      	b.n	c0d01ac0 <io_seproxyhal_button_push+0x38>
c0d01ab4:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d01ab6:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d01ab8:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d01aba:	2301      	movs	r3, #1
c0d01abc:	07db      	lsls	r3, r3, #31
c0d01abe:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d01ac0:	6800      	ldr	r0, [r0, #0]
c0d01ac2:	4288      	cmp	r0, r1
c0d01ac4:	d001      	beq.n	c0d01aca <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d01ac6:	2000      	movs	r0, #0
c0d01ac8:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d01aca:	2d08      	cmp	r5, #8
c0d01acc:	d30e      	bcc.n	c0d01aec <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01ace:	2103      	movs	r1, #3
c0d01ad0:	4628      	mov	r0, r5
c0d01ad2:	f001 fd99 	bl	c0d03608 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d01ad6:	2001      	movs	r0, #1
c0d01ad8:	0780      	lsls	r0, r0, #30
c0d01ada:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01adc:	2900      	cmp	r1, #0
c0d01ade:	4601      	mov	r1, r0
c0d01ae0:	d000      	beq.n	c0d01ae4 <io_seproxyhal_button_push+0x5c>
c0d01ae2:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01ae4:	2900      	cmp	r1, #0
c0d01ae6:	db02      	blt.n	c0d01aee <io_seproxyhal_button_push+0x66>
c0d01ae8:	4608      	mov	r0, r1
c0d01aea:	e000      	b.n	c0d01aee <io_seproxyhal_button_push+0x66>
c0d01aec:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01aee:	4629      	mov	r1, r5
c0d01af0:	47a0      	blx	r4
  }
}
c0d01af2:	b001      	add	sp, #4
c0d01af4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01af6:	46c0      	nop			; (mov r8, r8)
c0d01af8:	20001ce8 	.word	0x20001ce8
c0d01afc:	20001cec 	.word	0x20001cec

c0d01b00 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01b00:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01b02:	af03      	add	r7, sp, #12
c0d01b04:	b081      	sub	sp, #4
c0d01b06:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01b08:	200f      	movs	r0, #15
c0d01b0a:	4204      	tst	r4, r0
c0d01b0c:	d006      	beq.n	c0d01b1c <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01b0e:	4620      	mov	r0, r4
c0d01b10:	f7ff f830 	bl	c0d00b74 <io_exchange_al>
c0d01b14:	4605      	mov	r5, r0
  }
}
c0d01b16:	b2a8      	uxth	r0, r5
c0d01b18:	b001      	add	sp, #4
c0d01b1a:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01b1c:	2610      	movs	r6, #16
c0d01b1e:	4026      	ands	r6, r4
c0d01b20:	2900      	cmp	r1, #0
c0d01b22:	d02a      	beq.n	c0d01b7a <io_exchange+0x7a>
c0d01b24:	2e00      	cmp	r6, #0
c0d01b26:	d128      	bne.n	c0d01b7a <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01b28:	483d      	ldr	r0, [pc, #244]	; (c0d01c20 <io_exchange+0x120>)
c0d01b2a:	7800      	ldrb	r0, [r0, #0]
c0d01b2c:	2807      	cmp	r0, #7
c0d01b2e:	d00b      	beq.n	c0d01b48 <io_exchange+0x48>
c0d01b30:	2800      	cmp	r0, #0
c0d01b32:	d004      	beq.n	c0d01b3e <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01b34:	4620      	mov	r0, r4
c0d01b36:	f7ff f81d 	bl	c0d00b74 <io_exchange_al>
c0d01b3a:	2800      	cmp	r0, #0
c0d01b3c:	d00a      	beq.n	c0d01b54 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01b3e:	4839      	ldr	r0, [pc, #228]	; (c0d01c24 <io_exchange+0x124>)
c0d01b40:	6800      	ldr	r0, [r0, #0]
c0d01b42:	2109      	movs	r1, #9
c0d01b44:	f001 fffc 	bl	c0d03b40 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01b48:	483d      	ldr	r0, [pc, #244]	; (c0d01c40 <io_exchange+0x140>)
c0d01b4a:	4478      	add	r0, pc
c0d01b4c:	2200      	movs	r2, #0
c0d01b4e:	2320      	movs	r3, #32
c0d01b50:	f7ff fc6a 	bl	c0d01428 <io_usb_hid_exchange>
c0d01b54:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d01b56:	4832      	ldr	r0, [pc, #200]	; (c0d01c20 <io_exchange+0x120>)
c0d01b58:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d01b5a:	4833      	ldr	r0, [pc, #204]	; (c0d01c28 <io_exchange+0x128>)
c0d01b5c:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01b5e:	4833      	ldr	r0, [pc, #204]	; (c0d01c2c <io_exchange+0x12c>)
c0d01b60:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01b62:	4833      	ldr	r0, [pc, #204]	; (c0d01c30 <io_exchange+0x130>)
c0d01b64:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01b66:	4833      	ldr	r0, [pc, #204]	; (c0d01c34 <io_exchange+0x134>)
c0d01b68:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d01b6a:	06a0      	lsls	r0, r4, #26
c0d01b6c:	d4d3      	bmi.n	c0d01b16 <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01b6e:	f7ff fcd3 	bl	c0d01518 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01b72:	0620      	lsls	r0, r4, #24
c0d01b74:	d501      	bpl.n	c0d01b7a <io_exchange+0x7a>
        reset();
c0d01b76:	f000 faeb 	bl	c0d02150 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d01b7a:	2e00      	cmp	r6, #0
c0d01b7c:	d10c      	bne.n	c0d01b98 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01b7e:	0660      	lsls	r0, r4, #25
c0d01b80:	d448      	bmi.n	c0d01c14 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d01b82:	4827      	ldr	r0, [pc, #156]	; (c0d01c20 <io_exchange+0x120>)
c0d01b84:	2100      	movs	r1, #0
c0d01b86:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d01b88:	4827      	ldr	r0, [pc, #156]	; (c0d01c28 <io_exchange+0x128>)
c0d01b8a:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d01b8c:	4827      	ldr	r0, [pc, #156]	; (c0d01c2c <io_exchange+0x12c>)
c0d01b8e:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d01b90:	4827      	ldr	r0, [pc, #156]	; (c0d01c30 <io_exchange+0x130>)
c0d01b92:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01b94:	4827      	ldr	r0, [pc, #156]	; (c0d01c34 <io_exchange+0x134>)
c0d01b96:	7001      	strb	r1, [r0, #0]
c0d01b98:	4c28      	ldr	r4, [pc, #160]	; (c0d01c3c <io_exchange+0x13c>)
c0d01b9a:	4e24      	ldr	r6, [pc, #144]	; (c0d01c2c <io_exchange+0x12c>)
c0d01b9c:	e008      	b.n	c0d01bb0 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d01b9e:	f7ff fd0f 	bl	c0d015c0 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01ba2:	8830      	ldrh	r0, [r6, #0]
c0d01ba4:	2800      	cmp	r0, #0
c0d01ba6:	d003      	beq.n	c0d01bb0 <io_exchange+0xb0>
c0d01ba8:	e032      	b.n	c0d01c10 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d01baa:	2002      	movs	r0, #2
c0d01bac:	f7ff f810 	bl	c0d00bd0 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01bb0:	f000 fc72 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d01bb4:	2800      	cmp	r0, #0
c0d01bb6:	d101      	bne.n	c0d01bbc <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01bb8:	f7ff fcae 	bl	c0d01518 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01bbc:	2180      	movs	r1, #128	; 0x80
c0d01bbe:	2500      	movs	r5, #0
c0d01bc0:	4620      	mov	r0, r4
c0d01bc2:	462a      	mov	r2, r5
c0d01bc4:	f000 fc84 	bl	c0d024d0 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01bc8:	1ec1      	subs	r1, r0, #3
c0d01bca:	78a2      	ldrb	r2, [r4, #2]
c0d01bcc:	7863      	ldrb	r3, [r4, #1]
c0d01bce:	021b      	lsls	r3, r3, #8
c0d01bd0:	4313      	orrs	r3, r2
c0d01bd2:	4299      	cmp	r1, r3
c0d01bd4:	d110      	bne.n	c0d01bf8 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01bd6:	4917      	ldr	r1, [pc, #92]	; (c0d01c34 <io_exchange+0x134>)
c0d01bd8:	7809      	ldrb	r1, [r1, #0]
c0d01bda:	2900      	cmp	r1, #0
c0d01bdc:	d002      	beq.n	c0d01be4 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01bde:	f7ff fd73 	bl	c0d016c8 <io_seproxyhal_handle_event>
c0d01be2:	e7e5      	b.n	c0d01bb0 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01be4:	7821      	ldrb	r1, [r4, #0]
c0d01be6:	2910      	cmp	r1, #16
c0d01be8:	d00f      	beq.n	c0d01c0a <io_exchange+0x10a>
c0d01bea:	290f      	cmp	r1, #15
c0d01bec:	d1dd      	bne.n	c0d01baa <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01bee:	2804      	cmp	r0, #4
c0d01bf0:	d102      	bne.n	c0d01bf8 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01bf2:	f7ff fca7 	bl	c0d01544 <io_seproxyhal_handle_usb_event>
c0d01bf6:	e7db      	b.n	c0d01bb0 <io_exchange+0xb0>
c0d01bf8:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d01bfa:	4909      	ldr	r1, [pc, #36]	; (c0d01c20 <io_exchange+0x120>)
c0d01bfc:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01bfe:	490a      	ldr	r1, [pc, #40]	; (c0d01c28 <io_exchange+0x128>)
c0d01c00:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01c02:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01c04:	490a      	ldr	r1, [pc, #40]	; (c0d01c30 <io_exchange+0x130>)
c0d01c06:	8008      	strh	r0, [r1, #0]
c0d01c08:	e7d2      	b.n	c0d01bb0 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01c0a:	2806      	cmp	r0, #6
c0d01c0c:	d2c7      	bcs.n	c0d01b9e <io_exchange+0x9e>
c0d01c0e:	e782      	b.n	c0d01b16 <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01c10:	8835      	ldrh	r5, [r6, #0]
c0d01c12:	e780      	b.n	c0d01b16 <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01c14:	4805      	ldr	r0, [pc, #20]	; (c0d01c2c <io_exchange+0x12c>)
c0d01c16:	8800      	ldrh	r0, [r0, #0]
c0d01c18:	4907      	ldr	r1, [pc, #28]	; (c0d01c38 <io_exchange+0x138>)
c0d01c1a:	1845      	adds	r5, r0, r1
c0d01c1c:	e77b      	b.n	c0d01b16 <io_exchange+0x16>
c0d01c1e:	46c0      	nop			; (mov r8, r8)
c0d01c20:	20001cdc 	.word	0x20001cdc
c0d01c24:	20001b7c 	.word	0x20001b7c
c0d01c28:	20001cde 	.word	0x20001cde
c0d01c2c:	20001ce0 	.word	0x20001ce0
c0d01c30:	20001ce2 	.word	0x20001ce2
c0d01c34:	20001cd4 	.word	0x20001cd4
c0d01c38:	0000fffb 	.word	0x0000fffb
c0d01c3c:	200019d8 	.word	0x200019d8
c0d01c40:	fffffbbb 	.word	0xfffffbbb

c0d01c44 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01c44:	b081      	sub	sp, #4
c0d01c46:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c48:	af03      	add	r7, sp, #12
c0d01c4a:	b094      	sub	sp, #80	; 0x50
c0d01c4c:	4616      	mov	r6, r2
c0d01c4e:	460d      	mov	r5, r1
c0d01c50:	900e      	str	r0, [sp, #56]	; 0x38
c0d01c52:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01c54:	2d02      	cmp	r5, #2
c0d01c56:	d200      	bcs.n	c0d01c5a <snprintf+0x16>
c0d01c58:	e22a      	b.n	c0d020b0 <snprintf+0x46c>
c0d01c5a:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01c5c:	2800      	cmp	r0, #0
c0d01c5e:	d100      	bne.n	c0d01c62 <snprintf+0x1e>
c0d01c60:	e226      	b.n	c0d020b0 <snprintf+0x46c>
c0d01c62:	2e00      	cmp	r6, #0
c0d01c64:	d100      	bne.n	c0d01c68 <snprintf+0x24>
c0d01c66:	e223      	b.n	c0d020b0 <snprintf+0x46c>
c0d01c68:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d01c6a:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01c6c:	9109      	str	r1, [sp, #36]	; 0x24
c0d01c6e:	462a      	mov	r2, r5
c0d01c70:	f7ff fbae 	bl	c0d013d0 <os_memset>
c0d01c74:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01c76:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01c78:	7830      	ldrb	r0, [r6, #0]
c0d01c7a:	2800      	cmp	r0, #0
c0d01c7c:	d100      	bne.n	c0d01c80 <snprintf+0x3c>
c0d01c7e:	e217      	b.n	c0d020b0 <snprintf+0x46c>
c0d01c80:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01c82:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01c84:	1e6b      	subs	r3, r5, #1
c0d01c86:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01c88:	460a      	mov	r2, r1
c0d01c8a:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01c8c:	e003      	b.n	c0d01c96 <snprintf+0x52>
c0d01c8e:	1970      	adds	r0, r6, r5
c0d01c90:	7840      	ldrb	r0, [r0, #1]
c0d01c92:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01c94:	1c6d      	adds	r5, r5, #1
c0d01c96:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01c98:	2800      	cmp	r0, #0
c0d01c9a:	d001      	beq.n	c0d01ca0 <snprintf+0x5c>
c0d01c9c:	2825      	cmp	r0, #37	; 0x25
c0d01c9e:	d1f6      	bne.n	c0d01c8e <snprintf+0x4a>
c0d01ca0:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01ca2:	429d      	cmp	r5, r3
c0d01ca4:	d300      	bcc.n	c0d01ca8 <snprintf+0x64>
c0d01ca6:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01ca8:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01caa:	4631      	mov	r1, r6
c0d01cac:	462a      	mov	r2, r5
c0d01cae:	461c      	mov	r4, r3
c0d01cb0:	f7ff fb98 	bl	c0d013e4 <os_memmove>
c0d01cb4:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01cb6:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01cb8:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01cba:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01cbc:	2b00      	cmp	r3, #0
c0d01cbe:	d100      	bne.n	c0d01cc2 <snprintf+0x7e>
c0d01cc0:	e1f6      	b.n	c0d020b0 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01cc2:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01cc4:	5d71      	ldrb	r1, [r6, r5]
c0d01cc6:	2925      	cmp	r1, #37	; 0x25
c0d01cc8:	d000      	beq.n	c0d01ccc <snprintf+0x88>
c0d01cca:	e0ab      	b.n	c0d01e24 <snprintf+0x1e0>
c0d01ccc:	9304      	str	r3, [sp, #16]
c0d01cce:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01cd0:	1c40      	adds	r0, r0, #1
c0d01cd2:	2100      	movs	r1, #0
c0d01cd4:	2220      	movs	r2, #32
c0d01cd6:	920a      	str	r2, [sp, #40]	; 0x28
c0d01cd8:	220a      	movs	r2, #10
c0d01cda:	9203      	str	r2, [sp, #12]
c0d01cdc:	9102      	str	r1, [sp, #8]
c0d01cde:	9106      	str	r1, [sp, #24]
c0d01ce0:	910d      	str	r1, [sp, #52]	; 0x34
c0d01ce2:	460b      	mov	r3, r1
c0d01ce4:	2102      	movs	r1, #2
c0d01ce6:	910c      	str	r1, [sp, #48]	; 0x30
c0d01ce8:	4606      	mov	r6, r0
c0d01cea:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01cec:	7831      	ldrb	r1, [r6, #0]
c0d01cee:	1c76      	adds	r6, r6, #1
c0d01cf0:	2300      	movs	r3, #0
c0d01cf2:	2962      	cmp	r1, #98	; 0x62
c0d01cf4:	dc41      	bgt.n	c0d01d7a <snprintf+0x136>
c0d01cf6:	4608      	mov	r0, r1
c0d01cf8:	3825      	subs	r0, #37	; 0x25
c0d01cfa:	2823      	cmp	r0, #35	; 0x23
c0d01cfc:	d900      	bls.n	c0d01d00 <snprintf+0xbc>
c0d01cfe:	e094      	b.n	c0d01e2a <snprintf+0x1e6>
c0d01d00:	0040      	lsls	r0, r0, #1
c0d01d02:	46c0      	nop			; (mov r8, r8)
c0d01d04:	4478      	add	r0, pc
c0d01d06:	8880      	ldrh	r0, [r0, #4]
c0d01d08:	0040      	lsls	r0, r0, #1
c0d01d0a:	4487      	add	pc, r0
c0d01d0c:	0186012d 	.word	0x0186012d
c0d01d10:	01860186 	.word	0x01860186
c0d01d14:	00510186 	.word	0x00510186
c0d01d18:	01860186 	.word	0x01860186
c0d01d1c:	00580023 	.word	0x00580023
c0d01d20:	00240186 	.word	0x00240186
c0d01d24:	00240024 	.word	0x00240024
c0d01d28:	00240024 	.word	0x00240024
c0d01d2c:	00240024 	.word	0x00240024
c0d01d30:	00240024 	.word	0x00240024
c0d01d34:	01860024 	.word	0x01860024
c0d01d38:	01860186 	.word	0x01860186
c0d01d3c:	01860186 	.word	0x01860186
c0d01d40:	01860186 	.word	0x01860186
c0d01d44:	01860186 	.word	0x01860186
c0d01d48:	01860186 	.word	0x01860186
c0d01d4c:	01860186 	.word	0x01860186
c0d01d50:	006c0186 	.word	0x006c0186
c0d01d54:	e7c9      	b.n	c0d01cea <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01d56:	2930      	cmp	r1, #48	; 0x30
c0d01d58:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01d5a:	4603      	mov	r3, r0
c0d01d5c:	d100      	bne.n	c0d01d60 <snprintf+0x11c>
c0d01d5e:	460b      	mov	r3, r1
c0d01d60:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01d62:	2c00      	cmp	r4, #0
c0d01d64:	d000      	beq.n	c0d01d68 <snprintf+0x124>
c0d01d66:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01d68:	200a      	movs	r0, #10
c0d01d6a:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01d6c:	1840      	adds	r0, r0, r1
c0d01d6e:	3830      	subs	r0, #48	; 0x30
c0d01d70:	900d      	str	r0, [sp, #52]	; 0x34
c0d01d72:	4630      	mov	r0, r6
c0d01d74:	930a      	str	r3, [sp, #40]	; 0x28
c0d01d76:	4613      	mov	r3, r2
c0d01d78:	e7b4      	b.n	c0d01ce4 <snprintf+0xa0>
c0d01d7a:	296f      	cmp	r1, #111	; 0x6f
c0d01d7c:	dd11      	ble.n	c0d01da2 <snprintf+0x15e>
c0d01d7e:	3970      	subs	r1, #112	; 0x70
c0d01d80:	2908      	cmp	r1, #8
c0d01d82:	d900      	bls.n	c0d01d86 <snprintf+0x142>
c0d01d84:	e149      	b.n	c0d0201a <snprintf+0x3d6>
c0d01d86:	0049      	lsls	r1, r1, #1
c0d01d88:	4479      	add	r1, pc
c0d01d8a:	8889      	ldrh	r1, [r1, #4]
c0d01d8c:	0049      	lsls	r1, r1, #1
c0d01d8e:	448f      	add	pc, r1
c0d01d90:	01440051 	.word	0x01440051
c0d01d94:	002e0144 	.word	0x002e0144
c0d01d98:	00590144 	.word	0x00590144
c0d01d9c:	01440144 	.word	0x01440144
c0d01da0:	0051      	.short	0x0051
c0d01da2:	2963      	cmp	r1, #99	; 0x63
c0d01da4:	d054      	beq.n	c0d01e50 <snprintf+0x20c>
c0d01da6:	2964      	cmp	r1, #100	; 0x64
c0d01da8:	d057      	beq.n	c0d01e5a <snprintf+0x216>
c0d01daa:	2968      	cmp	r1, #104	; 0x68
c0d01dac:	d01d      	beq.n	c0d01dea <snprintf+0x1a6>
c0d01dae:	e134      	b.n	c0d0201a <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01db0:	7830      	ldrb	r0, [r6, #0]
c0d01db2:	2873      	cmp	r0, #115	; 0x73
c0d01db4:	d000      	beq.n	c0d01db8 <snprintf+0x174>
c0d01db6:	e130      	b.n	c0d0201a <snprintf+0x3d6>
c0d01db8:	4630      	mov	r0, r6
c0d01dba:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01dbc:	e00d      	b.n	c0d01dda <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01dbe:	7830      	ldrb	r0, [r6, #0]
c0d01dc0:	282a      	cmp	r0, #42	; 0x2a
c0d01dc2:	d000      	beq.n	c0d01dc6 <snprintf+0x182>
c0d01dc4:	e129      	b.n	c0d0201a <snprintf+0x3d6>
c0d01dc6:	7871      	ldrb	r1, [r6, #1]
c0d01dc8:	1c70      	adds	r0, r6, #1
c0d01dca:	2301      	movs	r3, #1
c0d01dcc:	2948      	cmp	r1, #72	; 0x48
c0d01dce:	d004      	beq.n	c0d01dda <snprintf+0x196>
c0d01dd0:	2968      	cmp	r1, #104	; 0x68
c0d01dd2:	d002      	beq.n	c0d01dda <snprintf+0x196>
c0d01dd4:	2973      	cmp	r1, #115	; 0x73
c0d01dd6:	d000      	beq.n	c0d01dda <snprintf+0x196>
c0d01dd8:	e11f      	b.n	c0d0201a <snprintf+0x3d6>
c0d01dda:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01ddc:	1d0a      	adds	r2, r1, #4
c0d01dde:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01de0:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01de2:	9102      	str	r1, [sp, #8]
c0d01de4:	e77e      	b.n	c0d01ce4 <snprintf+0xa0>
c0d01de6:	2001      	movs	r0, #1
c0d01de8:	9006      	str	r0, [sp, #24]
c0d01dea:	2010      	movs	r0, #16
c0d01dec:	9003      	str	r0, [sp, #12]
c0d01dee:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01df0:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01df2:	1d01      	adds	r1, r0, #4
c0d01df4:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01df6:	2103      	movs	r1, #3
c0d01df8:	400a      	ands	r2, r1
c0d01dfa:	1c5b      	adds	r3, r3, #1
c0d01dfc:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01dfe:	2a01      	cmp	r2, #1
c0d01e00:	d100      	bne.n	c0d01e04 <snprintf+0x1c0>
c0d01e02:	e0b8      	b.n	c0d01f76 <snprintf+0x332>
c0d01e04:	2a02      	cmp	r2, #2
c0d01e06:	d100      	bne.n	c0d01e0a <snprintf+0x1c6>
c0d01e08:	e104      	b.n	c0d02014 <snprintf+0x3d0>
c0d01e0a:	2a03      	cmp	r2, #3
c0d01e0c:	4630      	mov	r0, r6
c0d01e0e:	d100      	bne.n	c0d01e12 <snprintf+0x1ce>
c0d01e10:	e768      	b.n	c0d01ce4 <snprintf+0xa0>
c0d01e12:	9c08      	ldr	r4, [sp, #32]
c0d01e14:	4625      	mov	r5, r4
c0d01e16:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01e18:	1948      	adds	r0, r1, r5
c0d01e1a:	7840      	ldrb	r0, [r0, #1]
c0d01e1c:	1c6d      	adds	r5, r5, #1
c0d01e1e:	2800      	cmp	r0, #0
c0d01e20:	d1fa      	bne.n	c0d01e18 <snprintf+0x1d4>
c0d01e22:	e0ab      	b.n	c0d01f7c <snprintf+0x338>
c0d01e24:	4606      	mov	r6, r0
c0d01e26:	920e      	str	r2, [sp, #56]	; 0x38
c0d01e28:	e109      	b.n	c0d0203e <snprintf+0x3fa>
c0d01e2a:	2958      	cmp	r1, #88	; 0x58
c0d01e2c:	d000      	beq.n	c0d01e30 <snprintf+0x1ec>
c0d01e2e:	e0f4      	b.n	c0d0201a <snprintf+0x3d6>
c0d01e30:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01e32:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01e34:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01e36:	1d01      	adds	r1, r0, #4
c0d01e38:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01e3a:	6802      	ldr	r2, [r0, #0]
c0d01e3c:	2000      	movs	r0, #0
c0d01e3e:	9005      	str	r0, [sp, #20]
c0d01e40:	2510      	movs	r5, #16
c0d01e42:	e014      	b.n	c0d01e6e <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01e44:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01e46:	1d01      	adds	r1, r0, #4
c0d01e48:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01e4a:	6802      	ldr	r2, [r0, #0]
c0d01e4c:	2000      	movs	r0, #0
c0d01e4e:	e00c      	b.n	c0d01e6a <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01e50:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01e52:	1d01      	adds	r1, r0, #4
c0d01e54:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01e56:	6800      	ldr	r0, [r0, #0]
c0d01e58:	e087      	b.n	c0d01f6a <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01e5a:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01e5c:	1d01      	adds	r1, r0, #4
c0d01e5e:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01e60:	6800      	ldr	r0, [r0, #0]
c0d01e62:	17c1      	asrs	r1, r0, #31
c0d01e64:	1842      	adds	r2, r0, r1
c0d01e66:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01e68:	0fc0      	lsrs	r0, r0, #31
c0d01e6a:	9005      	str	r0, [sp, #20]
c0d01e6c:	250a      	movs	r5, #10
c0d01e6e:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01e70:	4295      	cmp	r5, r2
c0d01e72:	920e      	str	r2, [sp, #56]	; 0x38
c0d01e74:	d814      	bhi.n	c0d01ea0 <snprintf+0x25c>
c0d01e76:	2201      	movs	r2, #1
c0d01e78:	4628      	mov	r0, r5
c0d01e7a:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01e7c:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01e7e:	4629      	mov	r1, r5
c0d01e80:	f001 fb3c 	bl	c0d034fc <__aeabi_uidiv>
c0d01e84:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01e86:	4288      	cmp	r0, r1
c0d01e88:	d109      	bne.n	c0d01e9e <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01e8a:	4628      	mov	r0, r5
c0d01e8c:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01e8e:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01e90:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01e92:	910d      	str	r1, [sp, #52]	; 0x34
c0d01e94:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01e96:	4288      	cmp	r0, r1
c0d01e98:	4622      	mov	r2, r4
c0d01e9a:	d9ee      	bls.n	c0d01e7a <snprintf+0x236>
c0d01e9c:	e000      	b.n	c0d01ea0 <snprintf+0x25c>
c0d01e9e:	460c      	mov	r4, r1
c0d01ea0:	950c      	str	r5, [sp, #48]	; 0x30
c0d01ea2:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01ea4:	2000      	movs	r0, #0
c0d01ea6:	4603      	mov	r3, r0
c0d01ea8:	43c1      	mvns	r1, r0
c0d01eaa:	9c05      	ldr	r4, [sp, #20]
c0d01eac:	2c00      	cmp	r4, #0
c0d01eae:	d100      	bne.n	c0d01eb2 <snprintf+0x26e>
c0d01eb0:	4621      	mov	r1, r4
c0d01eb2:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01eb4:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01eb6:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01eb8:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01eba:	b2ca      	uxtb	r2, r1
c0d01ebc:	2a30      	cmp	r2, #48	; 0x30
c0d01ebe:	d106      	bne.n	c0d01ece <snprintf+0x28a>
c0d01ec0:	2c00      	cmp	r4, #0
c0d01ec2:	d004      	beq.n	c0d01ece <snprintf+0x28a>
c0d01ec4:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01ec6:	232d      	movs	r3, #45	; 0x2d
c0d01ec8:	700b      	strb	r3, [r1, #0]
c0d01eca:	2400      	movs	r4, #0
c0d01ecc:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01ece:	1e81      	subs	r1, r0, #2
c0d01ed0:	290d      	cmp	r1, #13
c0d01ed2:	d80d      	bhi.n	c0d01ef0 <snprintf+0x2ac>
c0d01ed4:	1e41      	subs	r1, r0, #1
c0d01ed6:	d00b      	beq.n	c0d01ef0 <snprintf+0x2ac>
c0d01ed8:	a810      	add	r0, sp, #64	; 0x40
c0d01eda:	9405      	str	r4, [sp, #20]
c0d01edc:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01ede:	4320      	orrs	r0, r4
c0d01ee0:	f001 fd96 	bl	c0d03a10 <__aeabi_memset>
c0d01ee4:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01ee6:	1900      	adds	r0, r0, r4
c0d01ee8:	9c05      	ldr	r4, [sp, #20]
c0d01eea:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01eec:	1840      	adds	r0, r0, r1
c0d01eee:	1e43      	subs	r3, r0, #1
c0d01ef0:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01ef2:	2c00      	cmp	r4, #0
c0d01ef4:	9601      	str	r6, [sp, #4]
c0d01ef6:	d003      	beq.n	c0d01f00 <snprintf+0x2bc>
c0d01ef8:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01efa:	222d      	movs	r2, #45	; 0x2d
c0d01efc:	54c2      	strb	r2, [r0, r3]
c0d01efe:	1c5b      	adds	r3, r3, #1
c0d01f00:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01f02:	2900      	cmp	r1, #0
c0d01f04:	d003      	beq.n	c0d01f0e <snprintf+0x2ca>
c0d01f06:	2800      	cmp	r0, #0
c0d01f08:	d003      	beq.n	c0d01f12 <snprintf+0x2ce>
c0d01f0a:	a06c      	add	r0, pc, #432	; (adr r0, c0d020bc <g_pcHex_cap>)
c0d01f0c:	e002      	b.n	c0d01f14 <snprintf+0x2d0>
c0d01f0e:	461c      	mov	r4, r3
c0d01f10:	e016      	b.n	c0d01f40 <snprintf+0x2fc>
c0d01f12:	a06e      	add	r0, pc, #440	; (adr r0, c0d020cc <g_pcHex>)
c0d01f14:	900d      	str	r0, [sp, #52]	; 0x34
c0d01f16:	461c      	mov	r4, r3
c0d01f18:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01f1a:	460e      	mov	r6, r1
c0d01f1c:	f001 faee 	bl	c0d034fc <__aeabi_uidiv>
c0d01f20:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01f22:	4629      	mov	r1, r5
c0d01f24:	f001 fb70 	bl	c0d03608 <__aeabi_uidivmod>
c0d01f28:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01f2a:	5c40      	ldrb	r0, [r0, r1]
c0d01f2c:	a910      	add	r1, sp, #64	; 0x40
c0d01f2e:	5508      	strb	r0, [r1, r4]
c0d01f30:	4630      	mov	r0, r6
c0d01f32:	4629      	mov	r1, r5
c0d01f34:	f001 fae2 	bl	c0d034fc <__aeabi_uidiv>
c0d01f38:	1c64      	adds	r4, r4, #1
c0d01f3a:	42b5      	cmp	r5, r6
c0d01f3c:	4601      	mov	r1, r0
c0d01f3e:	d9eb      	bls.n	c0d01f18 <snprintf+0x2d4>
c0d01f40:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01f42:	429c      	cmp	r4, r3
c0d01f44:	4625      	mov	r5, r4
c0d01f46:	d300      	bcc.n	c0d01f4a <snprintf+0x306>
c0d01f48:	461d      	mov	r5, r3
c0d01f4a:	a910      	add	r1, sp, #64	; 0x40
c0d01f4c:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01f4e:	4620      	mov	r0, r4
c0d01f50:	462a      	mov	r2, r5
c0d01f52:	461e      	mov	r6, r3
c0d01f54:	f7ff fa46 	bl	c0d013e4 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01f58:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d01f5a:	1961      	adds	r1, r4, r5
c0d01f5c:	910e      	str	r1, [sp, #56]	; 0x38
c0d01f5e:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01f60:	2800      	cmp	r0, #0
c0d01f62:	9e01      	ldr	r6, [sp, #4]
c0d01f64:	d16b      	bne.n	c0d0203e <snprintf+0x3fa>
c0d01f66:	e0a3      	b.n	c0d020b0 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01f68:	2025      	movs	r0, #37	; 0x25
c0d01f6a:	9907      	ldr	r1, [sp, #28]
c0d01f6c:	7008      	strb	r0, [r1, #0]
c0d01f6e:	9804      	ldr	r0, [sp, #16]
c0d01f70:	1e40      	subs	r0, r0, #1
c0d01f72:	1c49      	adds	r1, r1, #1
c0d01f74:	e05f      	b.n	c0d02036 <snprintf+0x3f2>
c0d01f76:	9d02      	ldr	r5, [sp, #8]
c0d01f78:	9c08      	ldr	r4, [sp, #32]
c0d01f7a:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01f7c:	9803      	ldr	r0, [sp, #12]
c0d01f7e:	2810      	cmp	r0, #16
c0d01f80:	9807      	ldr	r0, [sp, #28]
c0d01f82:	d161      	bne.n	c0d02048 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01f84:	2d00      	cmp	r5, #0
c0d01f86:	d06a      	beq.n	c0d0205e <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01f88:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01f8a:	1900      	adds	r0, r0, r4
c0d01f8c:	900e      	str	r0, [sp, #56]	; 0x38
c0d01f8e:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01f90:	1aa0      	subs	r0, r4, r2
c0d01f92:	9b05      	ldr	r3, [sp, #20]
c0d01f94:	4283      	cmp	r3, r0
c0d01f96:	d800      	bhi.n	c0d01f9a <snprintf+0x356>
c0d01f98:	4603      	mov	r3, r0
c0d01f9a:	930c      	str	r3, [sp, #48]	; 0x30
c0d01f9c:	435c      	muls	r4, r3
c0d01f9e:	940a      	str	r4, [sp, #40]	; 0x28
c0d01fa0:	1c60      	adds	r0, r4, #1
c0d01fa2:	9007      	str	r0, [sp, #28]
c0d01fa4:	2000      	movs	r0, #0
c0d01fa6:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01fa8:	9100      	str	r1, [sp, #0]
c0d01faa:	940e      	str	r4, [sp, #56]	; 0x38
c0d01fac:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01fae:	18e3      	adds	r3, r4, r3
c0d01fb0:	900d      	str	r0, [sp, #52]	; 0x34
c0d01fb2:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01fb4:	200f      	movs	r0, #15
c0d01fb6:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01fb8:	0909      	lsrs	r1, r1, #4
c0d01fba:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01fbc:	18a4      	adds	r4, r4, r2
c0d01fbe:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01fc0:	2c02      	cmp	r4, #2
c0d01fc2:	d375      	bcc.n	c0d020b0 <snprintf+0x46c>
c0d01fc4:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01fc6:	2c01      	cmp	r4, #1
c0d01fc8:	d003      	beq.n	c0d01fd2 <snprintf+0x38e>
c0d01fca:	2c00      	cmp	r4, #0
c0d01fcc:	d108      	bne.n	c0d01fe0 <snprintf+0x39c>
c0d01fce:	a43f      	add	r4, pc, #252	; (adr r4, c0d020cc <g_pcHex>)
c0d01fd0:	e000      	b.n	c0d01fd4 <snprintf+0x390>
c0d01fd2:	a43a      	add	r4, pc, #232	; (adr r4, c0d020bc <g_pcHex_cap>)
c0d01fd4:	b2c9      	uxtb	r1, r1
c0d01fd6:	5c61      	ldrb	r1, [r4, r1]
c0d01fd8:	7019      	strb	r1, [r3, #0]
c0d01fda:	b2c0      	uxtb	r0, r0
c0d01fdc:	5c20      	ldrb	r0, [r4, r0]
c0d01fde:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01fe0:	9807      	ldr	r0, [sp, #28]
c0d01fe2:	4290      	cmp	r0, r2
c0d01fe4:	d064      	beq.n	c0d020b0 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01fe6:	1e92      	subs	r2, r2, #2
c0d01fe8:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01fea:	1ca4      	adds	r4, r4, #2
c0d01fec:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01fee:	1c40      	adds	r0, r0, #1
c0d01ff0:	42a8      	cmp	r0, r5
c0d01ff2:	9900      	ldr	r1, [sp, #0]
c0d01ff4:	d3d9      	bcc.n	c0d01faa <snprintf+0x366>
c0d01ff6:	900d      	str	r0, [sp, #52]	; 0x34
c0d01ff8:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01ffa:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01ffc:	1a08      	subs	r0, r1, r0
c0d01ffe:	9b05      	ldr	r3, [sp, #20]
c0d02000:	4283      	cmp	r3, r0
c0d02002:	d800      	bhi.n	c0d02006 <snprintf+0x3c2>
c0d02004:	4603      	mov	r3, r0
c0d02006:	4608      	mov	r0, r1
c0d02008:	4358      	muls	r0, r3
c0d0200a:	1820      	adds	r0, r4, r0
c0d0200c:	900e      	str	r0, [sp, #56]	; 0x38
c0d0200e:	1898      	adds	r0, r3, r2
c0d02010:	1c43      	adds	r3, r0, #1
c0d02012:	e038      	b.n	c0d02086 <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d02014:	7808      	ldrb	r0, [r1, #0]
c0d02016:	2800      	cmp	r0, #0
c0d02018:	d023      	beq.n	c0d02062 <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d0201a:	2005      	movs	r0, #5
c0d0201c:	9d04      	ldr	r5, [sp, #16]
c0d0201e:	2d05      	cmp	r5, #5
c0d02020:	462c      	mov	r4, r5
c0d02022:	d300      	bcc.n	c0d02026 <snprintf+0x3e2>
c0d02024:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d02026:	9807      	ldr	r0, [sp, #28]
c0d02028:	a12c      	add	r1, pc, #176	; (adr r1, c0d020dc <g_pcHex+0x10>)
c0d0202a:	4622      	mov	r2, r4
c0d0202c:	f7ff f9da 	bl	c0d013e4 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d02030:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d02032:	9907      	ldr	r1, [sp, #28]
c0d02034:	1909      	adds	r1, r1, r4
c0d02036:	910e      	str	r1, [sp, #56]	; 0x38
c0d02038:	4603      	mov	r3, r0
c0d0203a:	2800      	cmp	r0, #0
c0d0203c:	d038      	beq.n	c0d020b0 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d0203e:	7830      	ldrb	r0, [r6, #0]
c0d02040:	2800      	cmp	r0, #0
c0d02042:	9908      	ldr	r1, [sp, #32]
c0d02044:	d034      	beq.n	c0d020b0 <snprintf+0x46c>
c0d02046:	e61f      	b.n	c0d01c88 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d02048:	429d      	cmp	r5, r3
c0d0204a:	d300      	bcc.n	c0d0204e <snprintf+0x40a>
c0d0204c:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d0204e:	462a      	mov	r2, r5
c0d02050:	461c      	mov	r4, r3
c0d02052:	f7ff f9c7 	bl	c0d013e4 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d02056:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d02058:	9907      	ldr	r1, [sp, #28]
c0d0205a:	1949      	adds	r1, r1, r5
c0d0205c:	e00f      	b.n	c0d0207e <snprintf+0x43a>
c0d0205e:	900e      	str	r0, [sp, #56]	; 0x38
c0d02060:	e7ed      	b.n	c0d0203e <snprintf+0x3fa>
c0d02062:	9b04      	ldr	r3, [sp, #16]
c0d02064:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d02066:	429c      	cmp	r4, r3
c0d02068:	d300      	bcc.n	c0d0206c <snprintf+0x428>
c0d0206a:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d0206c:	2120      	movs	r1, #32
c0d0206e:	9807      	ldr	r0, [sp, #28]
c0d02070:	4622      	mov	r2, r4
c0d02072:	f7ff f9ad 	bl	c0d013d0 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d02076:	9804      	ldr	r0, [sp, #16]
c0d02078:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d0207a:	9907      	ldr	r1, [sp, #28]
c0d0207c:	1909      	adds	r1, r1, r4
c0d0207e:	910e      	str	r1, [sp, #56]	; 0x38
c0d02080:	4603      	mov	r3, r0
c0d02082:	2800      	cmp	r0, #0
c0d02084:	d014      	beq.n	c0d020b0 <snprintf+0x46c>
c0d02086:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d02088:	42a8      	cmp	r0, r5
c0d0208a:	d9d8      	bls.n	c0d0203e <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d0208c:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d0208e:	429a      	cmp	r2, r3
c0d02090:	d300      	bcc.n	c0d02094 <snprintf+0x450>
c0d02092:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d02094:	2120      	movs	r1, #32
c0d02096:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d02098:	4628      	mov	r0, r5
c0d0209a:	920d      	str	r2, [sp, #52]	; 0x34
c0d0209c:	461c      	mov	r4, r3
c0d0209e:	f7ff f997 	bl	c0d013d0 <os_memset>
c0d020a2:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d020a4:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d020a6:	182d      	adds	r5, r5, r0
c0d020a8:	950e      	str	r5, [sp, #56]	; 0x38
c0d020aa:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d020ac:	2c00      	cmp	r4, #0
c0d020ae:	d1c6      	bne.n	c0d0203e <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d020b0:	2000      	movs	r0, #0
c0d020b2:	b014      	add	sp, #80	; 0x50
c0d020b4:	bcf0      	pop	{r4, r5, r6, r7}
c0d020b6:	bc02      	pop	{r1}
c0d020b8:	b001      	add	sp, #4
c0d020ba:	4708      	bx	r1

c0d020bc <g_pcHex_cap>:
c0d020bc:	33323130 	.word	0x33323130
c0d020c0:	37363534 	.word	0x37363534
c0d020c4:	42413938 	.word	0x42413938
c0d020c8:	46454443 	.word	0x46454443

c0d020cc <g_pcHex>:
c0d020cc:	33323130 	.word	0x33323130
c0d020d0:	37363534 	.word	0x37363534
c0d020d4:	62613938 	.word	0x62613938
c0d020d8:	66656463 	.word	0x66656463
c0d020dc:	4f525245 	.word	0x4f525245
c0d020e0:	00000052 	.word	0x00000052

c0d020e4 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d020e4:	b580      	push	{r7, lr}
c0d020e6:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d020e8:	4904      	ldr	r1, [pc, #16]	; (c0d020fc <pic+0x18>)
c0d020ea:	4288      	cmp	r0, r1
c0d020ec:	d304      	bcc.n	c0d020f8 <pic+0x14>
c0d020ee:	4904      	ldr	r1, [pc, #16]	; (c0d02100 <pic+0x1c>)
c0d020f0:	4288      	cmp	r0, r1
c0d020f2:	d201      	bcs.n	c0d020f8 <pic+0x14>
		link_address = pic_internal(link_address);
c0d020f4:	f000 f806 	bl	c0d02104 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d020f8:	bd80      	pop	{r7, pc}
c0d020fa:	46c0      	nop			; (mov r8, r8)
c0d020fc:	c0d00000 	.word	0xc0d00000
c0d02100:	c0d03f80 	.word	0xc0d03f80

c0d02104 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d02104:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d02106:	4902      	ldr	r1, [pc, #8]	; (c0d02110 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d02108:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d0210a:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d0210c:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d0210e:	4770      	bx	lr
c0d02110:	c0d02105 	.word	0xc0d02105

c0d02114 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d02114:	b580      	push	{r7, lr}
c0d02116:	af00      	add	r7, sp, #0
c0d02118:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d0211a:	490a      	ldr	r1, [pc, #40]	; (c0d02144 <check_api_level+0x30>)
c0d0211c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0211e:	490a      	ldr	r1, [pc, #40]	; (c0d02148 <check_api_level+0x34>)
c0d02120:	680a      	ldr	r2, [r1, #0]
c0d02122:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d02124:	9003      	str	r0, [sp, #12]
c0d02126:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02128:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0212a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0212c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d0212e:	4807      	ldr	r0, [pc, #28]	; (c0d0214c <check_api_level+0x38>)
c0d02130:	9a01      	ldr	r2, [sp, #4]
c0d02132:	4282      	cmp	r2, r0
c0d02134:	d101      	bne.n	c0d0213a <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02136:	b004      	add	sp, #16
c0d02138:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0213a:	6808      	ldr	r0, [r1, #0]
c0d0213c:	2104      	movs	r1, #4
c0d0213e:	f001 fcff 	bl	c0d03b40 <longjmp>
c0d02142:	46c0      	nop			; (mov r8, r8)
c0d02144:	60000137 	.word	0x60000137
c0d02148:	20001b7c 	.word	0x20001b7c
c0d0214c:	900001c6 	.word	0x900001c6

c0d02150 <reset>:
  }
}

void reset ( void ) 
{
c0d02150:	b580      	push	{r7, lr}
c0d02152:	af00      	add	r7, sp, #0
c0d02154:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d02156:	4809      	ldr	r0, [pc, #36]	; (c0d0217c <reset+0x2c>)
c0d02158:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0215a:	4809      	ldr	r0, [pc, #36]	; (c0d02180 <reset+0x30>)
c0d0215c:	6801      	ldr	r1, [r0, #0]
c0d0215e:	9101      	str	r1, [sp, #4]
c0d02160:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02162:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d02164:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02166:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d02168:	4906      	ldr	r1, [pc, #24]	; (c0d02184 <reset+0x34>)
c0d0216a:	9a00      	ldr	r2, [sp, #0]
c0d0216c:	428a      	cmp	r2, r1
c0d0216e:	d101      	bne.n	c0d02174 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02170:	b002      	add	sp, #8
c0d02172:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02174:	6800      	ldr	r0, [r0, #0]
c0d02176:	2104      	movs	r1, #4
c0d02178:	f001 fce2 	bl	c0d03b40 <longjmp>
c0d0217c:	60000200 	.word	0x60000200
c0d02180:	20001b7c 	.word	0x20001b7c
c0d02184:	900002f1 	.word	0x900002f1

c0d02188 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d02188:	b5d0      	push	{r4, r6, r7, lr}
c0d0218a:	af02      	add	r7, sp, #8
c0d0218c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d0218e:	4b0a      	ldr	r3, [pc, #40]	; (c0d021b8 <nvm_write+0x30>)
c0d02190:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02192:	4b0a      	ldr	r3, [pc, #40]	; (c0d021bc <nvm_write+0x34>)
c0d02194:	681c      	ldr	r4, [r3, #0]
c0d02196:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d02198:	ac03      	add	r4, sp, #12
c0d0219a:	c407      	stmia	r4!, {r0, r1, r2}
c0d0219c:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0219e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021a0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021a2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d021a4:	4806      	ldr	r0, [pc, #24]	; (c0d021c0 <nvm_write+0x38>)
c0d021a6:	9901      	ldr	r1, [sp, #4]
c0d021a8:	4281      	cmp	r1, r0
c0d021aa:	d101      	bne.n	c0d021b0 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d021ac:	b006      	add	sp, #24
c0d021ae:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021b0:	6818      	ldr	r0, [r3, #0]
c0d021b2:	2104      	movs	r1, #4
c0d021b4:	f001 fcc4 	bl	c0d03b40 <longjmp>
c0d021b8:	6000037f 	.word	0x6000037f
c0d021bc:	20001b7c 	.word	0x20001b7c
c0d021c0:	900003bc 	.word	0x900003bc

c0d021c4 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d021c4:	b580      	push	{r7, lr}
c0d021c6:	af00      	add	r7, sp, #0
c0d021c8:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d021ca:	4a0a      	ldr	r2, [pc, #40]	; (c0d021f4 <cx_rng+0x30>)
c0d021cc:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021ce:	4a0a      	ldr	r2, [pc, #40]	; (c0d021f8 <cx_rng+0x34>)
c0d021d0:	6813      	ldr	r3, [r2, #0]
c0d021d2:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d021d4:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d021d6:	9103      	str	r1, [sp, #12]
c0d021d8:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021da:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021dc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021de:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d021e0:	4906      	ldr	r1, [pc, #24]	; (c0d021fc <cx_rng+0x38>)
c0d021e2:	9b00      	ldr	r3, [sp, #0]
c0d021e4:	428b      	cmp	r3, r1
c0d021e6:	d101      	bne.n	c0d021ec <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d021e8:	b004      	add	sp, #16
c0d021ea:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021ec:	6810      	ldr	r0, [r2, #0]
c0d021ee:	2104      	movs	r1, #4
c0d021f0:	f001 fca6 	bl	c0d03b40 <longjmp>
c0d021f4:	6000052c 	.word	0x6000052c
c0d021f8:	20001b7c 	.word	0x20001b7c
c0d021fc:	90000567 	.word	0x90000567

c0d02200 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d02200:	b580      	push	{r7, lr}
c0d02202:	af00      	add	r7, sp, #0
c0d02204:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d02206:	490a      	ldr	r1, [pc, #40]	; (c0d02230 <cx_sha256_init+0x30>)
c0d02208:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0220a:	490a      	ldr	r1, [pc, #40]	; (c0d02234 <cx_sha256_init+0x34>)
c0d0220c:	680a      	ldr	r2, [r1, #0]
c0d0220e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d02210:	9003      	str	r0, [sp, #12]
c0d02212:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02214:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02216:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02218:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d0221a:	4a07      	ldr	r2, [pc, #28]	; (c0d02238 <cx_sha256_init+0x38>)
c0d0221c:	9b01      	ldr	r3, [sp, #4]
c0d0221e:	4293      	cmp	r3, r2
c0d02220:	d101      	bne.n	c0d02226 <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02222:	b004      	add	sp, #16
c0d02224:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02226:	6808      	ldr	r0, [r1, #0]
c0d02228:	2104      	movs	r1, #4
c0d0222a:	f001 fc89 	bl	c0d03b40 <longjmp>
c0d0222e:	46c0      	nop			; (mov r8, r8)
c0d02230:	600008db 	.word	0x600008db
c0d02234:	20001b7c 	.word	0x20001b7c
c0d02238:	90000864 	.word	0x90000864

c0d0223c <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d0223c:	b580      	push	{r7, lr}
c0d0223e:	af00      	add	r7, sp, #0
c0d02240:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d02242:	4a0a      	ldr	r2, [pc, #40]	; (c0d0226c <cx_keccak_init+0x30>)
c0d02244:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02246:	4a0a      	ldr	r2, [pc, #40]	; (c0d02270 <cx_keccak_init+0x34>)
c0d02248:	6813      	ldr	r3, [r2, #0]
c0d0224a:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d0224c:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d0224e:	9103      	str	r1, [sp, #12]
c0d02250:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02252:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02254:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02256:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d02258:	4906      	ldr	r1, [pc, #24]	; (c0d02274 <cx_keccak_init+0x38>)
c0d0225a:	9b00      	ldr	r3, [sp, #0]
c0d0225c:	428b      	cmp	r3, r1
c0d0225e:	d101      	bne.n	c0d02264 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02260:	b004      	add	sp, #16
c0d02262:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02264:	6810      	ldr	r0, [r2, #0]
c0d02266:	2104      	movs	r1, #4
c0d02268:	f001 fc6a 	bl	c0d03b40 <longjmp>
c0d0226c:	60000c3c 	.word	0x60000c3c
c0d02270:	20001b7c 	.word	0x20001b7c
c0d02274:	90000c39 	.word	0x90000c39

c0d02278 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d02278:	b5b0      	push	{r4, r5, r7, lr}
c0d0227a:	af02      	add	r7, sp, #8
c0d0227c:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d0227e:	4c0b      	ldr	r4, [pc, #44]	; (c0d022ac <cx_hash+0x34>)
c0d02280:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02282:	4c0b      	ldr	r4, [pc, #44]	; (c0d022b0 <cx_hash+0x38>)
c0d02284:	6825      	ldr	r5, [r4, #0]
c0d02286:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d02288:	ad03      	add	r5, sp, #12
c0d0228a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d0228c:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d0228e:	9007      	str	r0, [sp, #28]
c0d02290:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02292:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02294:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02296:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d02298:	4906      	ldr	r1, [pc, #24]	; (c0d022b4 <cx_hash+0x3c>)
c0d0229a:	9a01      	ldr	r2, [sp, #4]
c0d0229c:	428a      	cmp	r2, r1
c0d0229e:	d101      	bne.n	c0d022a4 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d022a0:	b008      	add	sp, #32
c0d022a2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022a4:	6820      	ldr	r0, [r4, #0]
c0d022a6:	2104      	movs	r1, #4
c0d022a8:	f001 fc4a 	bl	c0d03b40 <longjmp>
c0d022ac:	60000ea6 	.word	0x60000ea6
c0d022b0:	20001b7c 	.word	0x20001b7c
c0d022b4:	90000e46 	.word	0x90000e46

c0d022b8 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d022b8:	b5b0      	push	{r4, r5, r7, lr}
c0d022ba:	af02      	add	r7, sp, #8
c0d022bc:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d022be:	4c0a      	ldr	r4, [pc, #40]	; (c0d022e8 <cx_ecfp_init_public_key+0x30>)
c0d022c0:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022c2:	4c0a      	ldr	r4, [pc, #40]	; (c0d022ec <cx_ecfp_init_public_key+0x34>)
c0d022c4:	6825      	ldr	r5, [r4, #0]
c0d022c6:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d022c8:	ad02      	add	r5, sp, #8
c0d022ca:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d022cc:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022ce:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022d0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022d2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d022d4:	4906      	ldr	r1, [pc, #24]	; (c0d022f0 <cx_ecfp_init_public_key+0x38>)
c0d022d6:	9a00      	ldr	r2, [sp, #0]
c0d022d8:	428a      	cmp	r2, r1
c0d022da:	d101      	bne.n	c0d022e0 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d022dc:	b006      	add	sp, #24
c0d022de:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022e0:	6820      	ldr	r0, [r4, #0]
c0d022e2:	2104      	movs	r1, #4
c0d022e4:	f001 fc2c 	bl	c0d03b40 <longjmp>
c0d022e8:	60002835 	.word	0x60002835
c0d022ec:	20001b7c 	.word	0x20001b7c
c0d022f0:	900028f0 	.word	0x900028f0

c0d022f4 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d022f4:	b5b0      	push	{r4, r5, r7, lr}
c0d022f6:	af02      	add	r7, sp, #8
c0d022f8:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d022fa:	4c0a      	ldr	r4, [pc, #40]	; (c0d02324 <cx_ecfp_init_private_key+0x30>)
c0d022fc:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022fe:	4c0a      	ldr	r4, [pc, #40]	; (c0d02328 <cx_ecfp_init_private_key+0x34>)
c0d02300:	6825      	ldr	r5, [r4, #0]
c0d02302:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02304:	ad02      	add	r5, sp, #8
c0d02306:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02308:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0230a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0230c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0230e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d02310:	4906      	ldr	r1, [pc, #24]	; (c0d0232c <cx_ecfp_init_private_key+0x38>)
c0d02312:	9a00      	ldr	r2, [sp, #0]
c0d02314:	428a      	cmp	r2, r1
c0d02316:	d101      	bne.n	c0d0231c <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02318:	b006      	add	sp, #24
c0d0231a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0231c:	6820      	ldr	r0, [r4, #0]
c0d0231e:	2104      	movs	r1, #4
c0d02320:	f001 fc0e 	bl	c0d03b40 <longjmp>
c0d02324:	600029ed 	.word	0x600029ed
c0d02328:	20001b7c 	.word	0x20001b7c
c0d0232c:	900029ae 	.word	0x900029ae

c0d02330 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d02330:	b5b0      	push	{r4, r5, r7, lr}
c0d02332:	af02      	add	r7, sp, #8
c0d02334:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d02336:	4c0a      	ldr	r4, [pc, #40]	; (c0d02360 <cx_ecfp_generate_pair+0x30>)
c0d02338:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0233a:	4c0a      	ldr	r4, [pc, #40]	; (c0d02364 <cx_ecfp_generate_pair+0x34>)
c0d0233c:	6825      	ldr	r5, [r4, #0]
c0d0233e:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02340:	ad02      	add	r5, sp, #8
c0d02342:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02344:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02346:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02348:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0234a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d0234c:	4906      	ldr	r1, [pc, #24]	; (c0d02368 <cx_ecfp_generate_pair+0x38>)
c0d0234e:	9a00      	ldr	r2, [sp, #0]
c0d02350:	428a      	cmp	r2, r1
c0d02352:	d101      	bne.n	c0d02358 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02354:	b006      	add	sp, #24
c0d02356:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02358:	6820      	ldr	r0, [r4, #0]
c0d0235a:	2104      	movs	r1, #4
c0d0235c:	f001 fbf0 	bl	c0d03b40 <longjmp>
c0d02360:	60002a2e 	.word	0x60002a2e
c0d02364:	20001b7c 	.word	0x20001b7c
c0d02368:	90002a74 	.word	0x90002a74

c0d0236c <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d0236c:	b5b0      	push	{r4, r5, r7, lr}
c0d0236e:	af02      	add	r7, sp, #8
c0d02370:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d02372:	4c0b      	ldr	r4, [pc, #44]	; (c0d023a0 <os_perso_derive_node_bip32+0x34>)
c0d02374:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02376:	4c0b      	ldr	r4, [pc, #44]	; (c0d023a4 <os_perso_derive_node_bip32+0x38>)
c0d02378:	6825      	ldr	r5, [r4, #0]
c0d0237a:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d0237c:	ad03      	add	r5, sp, #12
c0d0237e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02380:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d02382:	9007      	str	r0, [sp, #28]
c0d02384:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02386:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02388:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0238a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d0238c:	4806      	ldr	r0, [pc, #24]	; (c0d023a8 <os_perso_derive_node_bip32+0x3c>)
c0d0238e:	9901      	ldr	r1, [sp, #4]
c0d02390:	4281      	cmp	r1, r0
c0d02392:	d101      	bne.n	c0d02398 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02394:	b008      	add	sp, #32
c0d02396:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02398:	6820      	ldr	r0, [r4, #0]
c0d0239a:	2104      	movs	r1, #4
c0d0239c:	f001 fbd0 	bl	c0d03b40 <longjmp>
c0d023a0:	6000512b 	.word	0x6000512b
c0d023a4:	20001b7c 	.word	0x20001b7c
c0d023a8:	9000517f 	.word	0x9000517f

c0d023ac <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d023ac:	b580      	push	{r7, lr}
c0d023ae:	af00      	add	r7, sp, #0
c0d023b0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d023b2:	490a      	ldr	r1, [pc, #40]	; (c0d023dc <os_sched_exit+0x30>)
c0d023b4:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d023b6:	490a      	ldr	r1, [pc, #40]	; (c0d023e0 <os_sched_exit+0x34>)
c0d023b8:	680a      	ldr	r2, [r1, #0]
c0d023ba:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d023bc:	9003      	str	r0, [sp, #12]
c0d023be:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d023c0:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d023c2:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d023c4:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d023c6:	4807      	ldr	r0, [pc, #28]	; (c0d023e4 <os_sched_exit+0x38>)
c0d023c8:	9a01      	ldr	r2, [sp, #4]
c0d023ca:	4282      	cmp	r2, r0
c0d023cc:	d101      	bne.n	c0d023d2 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d023ce:	b004      	add	sp, #16
c0d023d0:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023d2:	6808      	ldr	r0, [r1, #0]
c0d023d4:	2104      	movs	r1, #4
c0d023d6:	f001 fbb3 	bl	c0d03b40 <longjmp>
c0d023da:	46c0      	nop			; (mov r8, r8)
c0d023dc:	60005fe1 	.word	0x60005fe1
c0d023e0:	20001b7c 	.word	0x20001b7c
c0d023e4:	90005f6f 	.word	0x90005f6f

c0d023e8 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d023e8:	b580      	push	{r7, lr}
c0d023ea:	af00      	add	r7, sp, #0
c0d023ec:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d023ee:	490a      	ldr	r1, [pc, #40]	; (c0d02418 <os_ux+0x30>)
c0d023f0:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d023f2:	490a      	ldr	r1, [pc, #40]	; (c0d0241c <os_ux+0x34>)
c0d023f4:	680a      	ldr	r2, [r1, #0]
c0d023f6:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d023f8:	9003      	str	r0, [sp, #12]
c0d023fa:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d023fc:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d023fe:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02400:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d02402:	4a07      	ldr	r2, [pc, #28]	; (c0d02420 <os_ux+0x38>)
c0d02404:	9b01      	ldr	r3, [sp, #4]
c0d02406:	4293      	cmp	r3, r2
c0d02408:	d101      	bne.n	c0d0240e <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0240a:	b004      	add	sp, #16
c0d0240c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0240e:	6808      	ldr	r0, [r1, #0]
c0d02410:	2104      	movs	r1, #4
c0d02412:	f001 fb95 	bl	c0d03b40 <longjmp>
c0d02416:	46c0      	nop			; (mov r8, r8)
c0d02418:	60006158 	.word	0x60006158
c0d0241c:	20001b7c 	.word	0x20001b7c
c0d02420:	9000611f 	.word	0x9000611f

c0d02424 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d02424:	b580      	push	{r7, lr}
c0d02426:	af00      	add	r7, sp, #0
c0d02428:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d0242a:	4809      	ldr	r0, [pc, #36]	; (c0d02450 <os_seph_features+0x2c>)
c0d0242c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0242e:	4909      	ldr	r1, [pc, #36]	; (c0d02454 <os_seph_features+0x30>)
c0d02430:	6808      	ldr	r0, [r1, #0]
c0d02432:	9001      	str	r0, [sp, #4]
c0d02434:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02436:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02438:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0243a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d0243c:	4a06      	ldr	r2, [pc, #24]	; (c0d02458 <os_seph_features+0x34>)
c0d0243e:	9b00      	ldr	r3, [sp, #0]
c0d02440:	4293      	cmp	r3, r2
c0d02442:	d101      	bne.n	c0d02448 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02444:	b002      	add	sp, #8
c0d02446:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02448:	6808      	ldr	r0, [r1, #0]
c0d0244a:	2104      	movs	r1, #4
c0d0244c:	f001 fb78 	bl	c0d03b40 <longjmp>
c0d02450:	600064d6 	.word	0x600064d6
c0d02454:	20001b7c 	.word	0x20001b7c
c0d02458:	90006444 	.word	0x90006444

c0d0245c <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d0245c:	b580      	push	{r7, lr}
c0d0245e:	af00      	add	r7, sp, #0
c0d02460:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d02462:	4a0a      	ldr	r2, [pc, #40]	; (c0d0248c <io_seproxyhal_spi_send+0x30>)
c0d02464:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02466:	4a0a      	ldr	r2, [pc, #40]	; (c0d02490 <io_seproxyhal_spi_send+0x34>)
c0d02468:	6813      	ldr	r3, [r2, #0]
c0d0246a:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d0246c:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d0246e:	9103      	str	r1, [sp, #12]
c0d02470:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02472:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02474:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02476:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d02478:	4806      	ldr	r0, [pc, #24]	; (c0d02494 <io_seproxyhal_spi_send+0x38>)
c0d0247a:	9900      	ldr	r1, [sp, #0]
c0d0247c:	4281      	cmp	r1, r0
c0d0247e:	d101      	bne.n	c0d02484 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02480:	b004      	add	sp, #16
c0d02482:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02484:	6810      	ldr	r0, [r2, #0]
c0d02486:	2104      	movs	r1, #4
c0d02488:	f001 fb5a 	bl	c0d03b40 <longjmp>
c0d0248c:	60006a1c 	.word	0x60006a1c
c0d02490:	20001b7c 	.word	0x20001b7c
c0d02494:	90006af3 	.word	0x90006af3

c0d02498 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d02498:	b580      	push	{r7, lr}
c0d0249a:	af00      	add	r7, sp, #0
c0d0249c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d0249e:	4809      	ldr	r0, [pc, #36]	; (c0d024c4 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d024a0:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d024a2:	4909      	ldr	r1, [pc, #36]	; (c0d024c8 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d024a4:	6808      	ldr	r0, [r1, #0]
c0d024a6:	9001      	str	r0, [sp, #4]
c0d024a8:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d024aa:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d024ac:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d024ae:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d024b0:	4a06      	ldr	r2, [pc, #24]	; (c0d024cc <io_seproxyhal_spi_is_status_sent+0x34>)
c0d024b2:	9b00      	ldr	r3, [sp, #0]
c0d024b4:	4293      	cmp	r3, r2
c0d024b6:	d101      	bne.n	c0d024bc <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d024b8:	b002      	add	sp, #8
c0d024ba:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d024bc:	6808      	ldr	r0, [r1, #0]
c0d024be:	2104      	movs	r1, #4
c0d024c0:	f001 fb3e 	bl	c0d03b40 <longjmp>
c0d024c4:	60006bcf 	.word	0x60006bcf
c0d024c8:	20001b7c 	.word	0x20001b7c
c0d024cc:	90006b7f 	.word	0x90006b7f

c0d024d0 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d024d0:	b5d0      	push	{r4, r6, r7, lr}
c0d024d2:	af02      	add	r7, sp, #8
c0d024d4:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d024d6:	4b0b      	ldr	r3, [pc, #44]	; (c0d02504 <io_seproxyhal_spi_recv+0x34>)
c0d024d8:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d024da:	4b0b      	ldr	r3, [pc, #44]	; (c0d02508 <io_seproxyhal_spi_recv+0x38>)
c0d024dc:	681c      	ldr	r4, [r3, #0]
c0d024de:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d024e0:	ac03      	add	r4, sp, #12
c0d024e2:	c407      	stmia	r4!, {r0, r1, r2}
c0d024e4:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d024e6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d024e8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d024ea:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d024ec:	4907      	ldr	r1, [pc, #28]	; (c0d0250c <io_seproxyhal_spi_recv+0x3c>)
c0d024ee:	9a01      	ldr	r2, [sp, #4]
c0d024f0:	428a      	cmp	r2, r1
c0d024f2:	d102      	bne.n	c0d024fa <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d024f4:	b280      	uxth	r0, r0
c0d024f6:	b006      	add	sp, #24
c0d024f8:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d024fa:	6818      	ldr	r0, [r3, #0]
c0d024fc:	2104      	movs	r1, #4
c0d024fe:	f001 fb1f 	bl	c0d03b40 <longjmp>
c0d02502:	46c0      	nop			; (mov r8, r8)
c0d02504:	60006cd1 	.word	0x60006cd1
c0d02508:	20001b7c 	.word	0x20001b7c
c0d0250c:	90006c2b 	.word	0x90006c2b

c0d02510 <write_display>:
char top_str[21];
char bot_str[21];

//write_display(&words, sizeof(words), TYPE_STR);
//write_display(&int_val, sizeof(int_val), TYPE_INT);
void write_display(void* o, uint8_t sz, uint8_t t, uint8_t p) {
c0d02510:	b5d0      	push	{r4, r6, r7, lr}
c0d02512:	af02      	add	r7, sp, #8
c0d02514:	4604      	mov	r4, r0
    //don't allow messages greater than 20
    if(sz > 20) sz = 20;
    char *c_ptr = NULL;
    
    if(p == TOP) c_ptr = &top_str[0];
c0d02516:	2b01      	cmp	r3, #1
c0d02518:	d001      	beq.n	c0d0251e <write_display+0xe>
c0d0251a:	480f      	ldr	r0, [pc, #60]	; (c0d02558 <write_display+0x48>)
c0d0251c:	e000      	b.n	c0d02520 <write_display+0x10>
c0d0251e:	480d      	ldr	r0, [pc, #52]	; (c0d02554 <write_display+0x44>)

//write_display(&words, sizeof(words), TYPE_STR);
//write_display(&int_val, sizeof(int_val), TYPE_INT);
void write_display(void* o, uint8_t sz, uint8_t t, uint8_t p) {
    //don't allow messages greater than 20
    if(sz > 20) sz = 20;
c0d02520:	2314      	movs	r3, #20
c0d02522:	2914      	cmp	r1, #20
c0d02524:	d300      	bcc.n	c0d02528 <write_display+0x18>
c0d02526:	4619      	mov	r1, r3
    
    if(p == TOP) c_ptr = &top_str[0];
    else c_ptr = &bot_str[0];
    
    //NULL value sets line blank
    if(o == NULL) {
c0d02528:	2c00      	cmp	r4, #0
c0d0252a:	d008      	beq.n	c0d0253e <write_display+0x2e>
        return;
    }
    
    //uint32_t/int(half this) [0, 4,294,967,295] -
    //ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
c0d0252c:	2a03      	cmp	r2, #3
c0d0252e:	d009      	beq.n	c0d02544 <write_display+0x34>
c0d02530:	2a02      	cmp	r2, #2
c0d02532:	d00a      	beq.n	c0d0254a <write_display+0x3a>
c0d02534:	2a01      	cmp	r2, #1
c0d02536:	d10c      	bne.n	c0d02552 <write_display+0x42>
        snprintf(c_ptr, sz, "%d", *(int32_t *) o);
c0d02538:	6823      	ldr	r3, [r4, #0]
c0d0253a:	a20a      	add	r2, pc, #40	; (adr r2, c0d02564 <write_display+0x54>)
c0d0253c:	e007      	b.n	c0d0254e <write_display+0x3e>
    if(p == TOP) c_ptr = &top_str[0];
    else c_ptr = &bot_str[0];
    
    //NULL value sets line blank
    if(o == NULL) {
        c_ptr[0] = '\0';
c0d0253e:	2100      	movs	r1, #0
c0d02540:	7001      	strb	r1, [r0, #0]
        snprintf(c_ptr, sz, "%u", *(uint32_t *) o);
    }
    else if(t == TYPE_STR) {
        snprintf(c_ptr, sz, "%s", (char *) o);
    }
}
c0d02542:	bdd0      	pop	{r4, r6, r7, pc}
    }
    else if(t == TYPE_UINT) {
        snprintf(c_ptr, sz, "%u", *(uint32_t *) o);
    }
    else if(t == TYPE_STR) {
        snprintf(c_ptr, sz, "%s", (char *) o);
c0d02544:	a205      	add	r2, pc, #20	; (adr r2, c0d0255c <write_display+0x4c>)
c0d02546:	4623      	mov	r3, r4
c0d02548:	e001      	b.n	c0d0254e <write_display+0x3e>
    //ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
        snprintf(c_ptr, sz, "%d", *(int32_t *) o);
    }
    else if(t == TYPE_UINT) {
        snprintf(c_ptr, sz, "%u", *(uint32_t *) o);
c0d0254a:	6823      	ldr	r3, [r4, #0]
c0d0254c:	a204      	add	r2, pc, #16	; (adr r2, c0d02560 <write_display+0x50>)
c0d0254e:	f7ff fb79 	bl	c0d01c44 <snprintf>
    }
    else if(t == TYPE_STR) {
        snprintf(c_ptr, sz, "%s", (char *) o);
    }
}
c0d02552:	bdd0      	pop	{r4, r6, r7, pc}
c0d02554:	20001cf0 	.word	0x20001cf0
c0d02558:	20001d05 	.word	0x20001d05
c0d0255c:	00007325 	.word	0x00007325
c0d02560:	00007525 	.word	0x00007525
c0d02564:	00006425 	.word	0x00006425

c0d02568 <initUImsg>:

/* ------------------- DISPLAY UI FUNCTIONS -------------
 ---------------------------------------------------------
 --------------------------------------------------------- */

void initUImsg() {
c0d02568:	b5b0      	push	{r4, r5, r7, lr}
c0d0256a:	af02      	add	r7, sp, #8
    if(nvram_is_init()) {//5678901234567890
c0d0256c:	f7fe faf4 	bl	c0d00b58 <nvram_is_init>
c0d02570:	2801      	cmp	r0, #1
c0d02572:	d10a      	bne.n	c0d0258a <initUImsg+0x22>
    //ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
        snprintf(c_ptr, sz, "%d", *(int32_t *) o);
    }
    else if(t == TYPE_UINT) {
        snprintf(c_ptr, sz, "%u", *(uint32_t *) o);
c0d02574:	480c      	ldr	r0, [pc, #48]	; (c0d025a8 <initUImsg+0x40>)
c0d02576:	2414      	movs	r4, #20
c0d02578:	a516      	add	r5, pc, #88	; (adr r5, c0d025d4 <initUImsg+0x6c>)
c0d0257a:	2301      	movs	r3, #1
c0d0257c:	4621      	mov	r1, r4
c0d0257e:	462a      	mov	r2, r5
c0d02580:	f7ff fb60 	bl	c0d01c44 <snprintf>
c0d02584:	480e      	ldr	r0, [pc, #56]	; (c0d025c0 <initUImsg+0x58>)
c0d02586:	2303      	movs	r3, #3
c0d02588:	e009      	b.n	c0d0259e <initUImsg+0x36>
    }
    else if(t == TYPE_STR) {
        snprintf(c_ptr, sz, "%s", (char *) o);
c0d0258a:	4807      	ldr	r0, [pc, #28]	; (c0d025a8 <initUImsg+0x40>)
c0d0258c:	2414      	movs	r4, #20
c0d0258e:	a507      	add	r5, pc, #28	; (adr r5, c0d025ac <initUImsg+0x44>)
c0d02590:	a307      	add	r3, pc, #28	; (adr r3, c0d025b0 <initUImsg+0x48>)
c0d02592:	4621      	mov	r1, r4
c0d02594:	462a      	mov	r2, r5
c0d02596:	f7ff fb55 	bl	c0d01c44 <snprintf>
c0d0259a:	4809      	ldr	r0, [pc, #36]	; (c0d025c0 <initUImsg+0x58>)
c0d0259c:	a309      	add	r3, pc, #36	; (adr r3, c0d025c4 <initUImsg+0x5c>)
c0d0259e:	4621      	mov	r1, r4
c0d025a0:	462a      	mov	r2, r5
c0d025a2:	f7ff fb4f 	bl	c0d01c44 <snprintf>
    }
    else {
        write_display("DONT USE OTHER", 20, TYPE_STR, TOP);
        write_display("PEOPLES SEED!", 20, TYPE_STR, BOT);
    }
}
c0d025a6:	bdb0      	pop	{r4, r5, r7, pc}
c0d025a8:	20001cf0 	.word	0x20001cf0
c0d025ac:	00007325 	.word	0x00007325
c0d025b0:	544e4f44 	.word	0x544e4f44
c0d025b4:	45535520 	.word	0x45535520
c0d025b8:	48544f20 	.word	0x48544f20
c0d025bc:	00005245 	.word	0x00005245
c0d025c0:	20001d05 	.word	0x20001d05
c0d025c4:	504f4550 	.word	0x504f4550
c0d025c8:	2053454c 	.word	0x2053454c
c0d025cc:	44454553 	.word	0x44454553
c0d025d0:	00000021 	.word	0x00000021
c0d025d4:	00007525 	.word	0x00007525

c0d025d8 <ui_display_debug>:

void ui_display_debug(void *o, uint8_t sz, uint8_t t, void *o2,
                      uint8_t sz2, uint8_t t2) {
c0d025d8:	b5b0      	push	{r4, r5, r7, lr}
c0d025da:	af02      	add	r7, sp, #8
c0d025dc:	461c      	mov	r4, r3
    write_display(o, sz, t, TOP);
c0d025de:	2301      	movs	r3, #1
c0d025e0:	f7ff ff96 	bl	c0d02510 <write_display>
c0d025e4:	9904      	ldr	r1, [sp, #16]
c0d025e6:	9a05      	ldr	r2, [sp, #20]
    write_display(o2, sz2, t2, BOT);
c0d025e8:	2302      	movs	r3, #2
c0d025ea:	4620      	mov	r0, r4
c0d025ec:	f7ff ff90 	bl	c0d02510 <write_display>
    
    UX_DISPLAY(bagl_ui_nanos_screen, NULL);
c0d025f0:	4c21      	ldr	r4, [pc, #132]	; (c0d02678 <ui_display_debug+0xa0>)
c0d025f2:	4823      	ldr	r0, [pc, #140]	; (c0d02680 <ui_display_debug+0xa8>)
c0d025f4:	4478      	add	r0, pc
c0d025f6:	6020      	str	r0, [r4, #0]
c0d025f8:	2005      	movs	r0, #5
c0d025fa:	6060      	str	r0, [r4, #4]
c0d025fc:	4821      	ldr	r0, [pc, #132]	; (c0d02684 <ui_display_debug+0xac>)
c0d025fe:	4478      	add	r0, pc
c0d02600:	6120      	str	r0, [r4, #16]
c0d02602:	2500      	movs	r5, #0
c0d02604:	60e5      	str	r5, [r4, #12]
c0d02606:	2003      	movs	r0, #3
c0d02608:	7620      	strb	r0, [r4, #24]
c0d0260a:	61e5      	str	r5, [r4, #28]
c0d0260c:	4620      	mov	r0, r4
c0d0260e:	3018      	adds	r0, #24
c0d02610:	f7ff feea 	bl	c0d023e8 <os_ux>
c0d02614:	61e0      	str	r0, [r4, #28]
c0d02616:	f7ff f8ab 	bl	c0d01770 <io_seproxyhal_init_ux>
c0d0261a:	60a5      	str	r5, [r4, #8]
c0d0261c:	6820      	ldr	r0, [r4, #0]
c0d0261e:	2800      	cmp	r0, #0
c0d02620:	d028      	beq.n	c0d02674 <ui_display_debug+0x9c>
c0d02622:	69e0      	ldr	r0, [r4, #28]
c0d02624:	4915      	ldr	r1, [pc, #84]	; (c0d0267c <ui_display_debug+0xa4>)
c0d02626:	4288      	cmp	r0, r1
c0d02628:	d116      	bne.n	c0d02658 <ui_display_debug+0x80>
c0d0262a:	e023      	b.n	c0d02674 <ui_display_debug+0x9c>
c0d0262c:	6860      	ldr	r0, [r4, #4]
c0d0262e:	4285      	cmp	r5, r0
c0d02630:	d220      	bcs.n	c0d02674 <ui_display_debug+0x9c>
c0d02632:	f7ff ff31 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d02636:	2800      	cmp	r0, #0
c0d02638:	d11c      	bne.n	c0d02674 <ui_display_debug+0x9c>
c0d0263a:	68a0      	ldr	r0, [r4, #8]
c0d0263c:	68e1      	ldr	r1, [r4, #12]
c0d0263e:	2538      	movs	r5, #56	; 0x38
c0d02640:	4368      	muls	r0, r5
c0d02642:	6822      	ldr	r2, [r4, #0]
c0d02644:	1810      	adds	r0, r2, r0
c0d02646:	2900      	cmp	r1, #0
c0d02648:	d009      	beq.n	c0d0265e <ui_display_debug+0x86>
c0d0264a:	4788      	blx	r1
c0d0264c:	2800      	cmp	r0, #0
c0d0264e:	d106      	bne.n	c0d0265e <ui_display_debug+0x86>
c0d02650:	68a0      	ldr	r0, [r4, #8]
c0d02652:	1c45      	adds	r5, r0, #1
c0d02654:	60a5      	str	r5, [r4, #8]
c0d02656:	6820      	ldr	r0, [r4, #0]
c0d02658:	2800      	cmp	r0, #0
c0d0265a:	d1e7      	bne.n	c0d0262c <ui_display_debug+0x54>
c0d0265c:	e00a      	b.n	c0d02674 <ui_display_debug+0x9c>
c0d0265e:	2801      	cmp	r0, #1
c0d02660:	d103      	bne.n	c0d0266a <ui_display_debug+0x92>
c0d02662:	68a0      	ldr	r0, [r4, #8]
c0d02664:	4345      	muls	r5, r0
c0d02666:	6820      	ldr	r0, [r4, #0]
c0d02668:	1940      	adds	r0, r0, r5
c0d0266a:	f7fe faab 	bl	c0d00bc4 <io_seproxyhal_display>
c0d0266e:	68a0      	ldr	r0, [r4, #8]
c0d02670:	1c40      	adds	r0, r0, #1
c0d02672:	60a0      	str	r0, [r4, #8]
}
c0d02674:	bdb0      	pop	{r4, r5, r7, pc}
c0d02676:	46c0      	nop			; (mov r8, r8)
c0d02678:	20001a58 	.word	0x20001a58
c0d0267c:	b0105044 	.word	0xb0105044
c0d02680:	00001600 	.word	0x00001600
c0d02684:	00000087 	.word	0x00000087

c0d02688 <bagl_ui_nanos_screen_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
 ---------------------------------------------------------------
 --------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02688:	b580      	push	{r7, lr}
c0d0268a:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d0268c:	4905      	ldr	r1, [pc, #20]	; (c0d026a4 <bagl_ui_nanos_screen_button+0x1c>)
c0d0268e:	4288      	cmp	r0, r1
c0d02690:	d002      	beq.n	c0d02698 <bagl_ui_nanos_screen_button+0x10>
c0d02692:	4905      	ldr	r1, [pc, #20]	; (c0d026a8 <bagl_ui_nanos_screen_button+0x20>)
c0d02694:	4288      	cmp	r0, r1
c0d02696:	d102      	bne.n	c0d0269e <bagl_ui_nanos_screen_button+0x16>
c0d02698:	2000      	movs	r0, #0
c0d0269a:	f7ff fe87 	bl	c0d023ac <os_sched_exit>
            break;
        case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
            io_seproxyhal_touch_exit(NULL);
            break;
    }
    return 0;
c0d0269e:	2000      	movs	r0, #0
c0d026a0:	bd80      	pop	{r7, pc}
c0d026a2:	46c0      	nop			; (mov r8, r8)
c0d026a4:	80000002 	.word	0x80000002
c0d026a8:	80000001 	.word	0x80000001

c0d026ac <ui_idle>:
    write_display(o2, sz2, t2, BOT);
    
    UX_DISPLAY(bagl_ui_nanos_screen, NULL);
}

void ui_idle(void) {
c0d026ac:	b5b0      	push	{r4, r5, r7, lr}
c0d026ae:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d026b0:	2001      	movs	r0, #1
c0d026b2:	0204      	lsls	r4, r0, #8
c0d026b4:	f7ff feb6 	bl	c0d02424 <os_seph_features>
c0d026b8:	4220      	tst	r0, r4
c0d026ba:	d136      	bne.n	c0d0272a <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen, NULL);
c0d026bc:	4c3c      	ldr	r4, [pc, #240]	; (c0d027b0 <ui_idle+0x104>)
c0d026be:	4840      	ldr	r0, [pc, #256]	; (c0d027c0 <ui_idle+0x114>)
c0d026c0:	4478      	add	r0, pc
c0d026c2:	6020      	str	r0, [r4, #0]
c0d026c4:	2005      	movs	r0, #5
c0d026c6:	6060      	str	r0, [r4, #4]
c0d026c8:	483e      	ldr	r0, [pc, #248]	; (c0d027c4 <ui_idle+0x118>)
c0d026ca:	4478      	add	r0, pc
c0d026cc:	6120      	str	r0, [r4, #16]
c0d026ce:	2500      	movs	r5, #0
c0d026d0:	60e5      	str	r5, [r4, #12]
c0d026d2:	2003      	movs	r0, #3
c0d026d4:	7620      	strb	r0, [r4, #24]
c0d026d6:	61e5      	str	r5, [r4, #28]
c0d026d8:	4620      	mov	r0, r4
c0d026da:	3018      	adds	r0, #24
c0d026dc:	f7ff fe84 	bl	c0d023e8 <os_ux>
c0d026e0:	61e0      	str	r0, [r4, #28]
c0d026e2:	f7ff f845 	bl	c0d01770 <io_seproxyhal_init_ux>
c0d026e6:	60a5      	str	r5, [r4, #8]
c0d026e8:	6820      	ldr	r0, [r4, #0]
c0d026ea:	2800      	cmp	r0, #0
c0d026ec:	d05f      	beq.n	c0d027ae <ui_idle+0x102>
c0d026ee:	69e0      	ldr	r0, [r4, #28]
c0d026f0:	4930      	ldr	r1, [pc, #192]	; (c0d027b4 <ui_idle+0x108>)
c0d026f2:	4288      	cmp	r0, r1
c0d026f4:	d116      	bne.n	c0d02724 <ui_idle+0x78>
c0d026f6:	e05a      	b.n	c0d027ae <ui_idle+0x102>
c0d026f8:	6860      	ldr	r0, [r4, #4]
c0d026fa:	4285      	cmp	r5, r0
c0d026fc:	d257      	bcs.n	c0d027ae <ui_idle+0x102>
c0d026fe:	f7ff fecb 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d02702:	2800      	cmp	r0, #0
c0d02704:	d153      	bne.n	c0d027ae <ui_idle+0x102>
c0d02706:	68a0      	ldr	r0, [r4, #8]
c0d02708:	68e1      	ldr	r1, [r4, #12]
c0d0270a:	2538      	movs	r5, #56	; 0x38
c0d0270c:	4368      	muls	r0, r5
c0d0270e:	6822      	ldr	r2, [r4, #0]
c0d02710:	1810      	adds	r0, r2, r0
c0d02712:	2900      	cmp	r1, #0
c0d02714:	d040      	beq.n	c0d02798 <ui_idle+0xec>
c0d02716:	4788      	blx	r1
c0d02718:	2800      	cmp	r0, #0
c0d0271a:	d13d      	bne.n	c0d02798 <ui_idle+0xec>
c0d0271c:	68a0      	ldr	r0, [r4, #8]
c0d0271e:	1c45      	adds	r5, r0, #1
c0d02720:	60a5      	str	r5, [r4, #8]
c0d02722:	6820      	ldr	r0, [r4, #0]
c0d02724:	2800      	cmp	r0, #0
c0d02726:	d1e7      	bne.n	c0d026f8 <ui_idle+0x4c>
c0d02728:	e041      	b.n	c0d027ae <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d0272a:	4c21      	ldr	r4, [pc, #132]	; (c0d027b0 <ui_idle+0x104>)
c0d0272c:	4822      	ldr	r0, [pc, #136]	; (c0d027b8 <ui_idle+0x10c>)
c0d0272e:	4478      	add	r0, pc
c0d02730:	6020      	str	r0, [r4, #0]
c0d02732:	2004      	movs	r0, #4
c0d02734:	6060      	str	r0, [r4, #4]
c0d02736:	4821      	ldr	r0, [pc, #132]	; (c0d027bc <ui_idle+0x110>)
c0d02738:	4478      	add	r0, pc
c0d0273a:	6120      	str	r0, [r4, #16]
c0d0273c:	2500      	movs	r5, #0
c0d0273e:	60e5      	str	r5, [r4, #12]
c0d02740:	2003      	movs	r0, #3
c0d02742:	7620      	strb	r0, [r4, #24]
c0d02744:	61e5      	str	r5, [r4, #28]
c0d02746:	4620      	mov	r0, r4
c0d02748:	3018      	adds	r0, #24
c0d0274a:	f7ff fe4d 	bl	c0d023e8 <os_ux>
c0d0274e:	61e0      	str	r0, [r4, #28]
c0d02750:	f7ff f80e 	bl	c0d01770 <io_seproxyhal_init_ux>
c0d02754:	60a5      	str	r5, [r4, #8]
c0d02756:	6820      	ldr	r0, [r4, #0]
c0d02758:	2800      	cmp	r0, #0
c0d0275a:	d028      	beq.n	c0d027ae <ui_idle+0x102>
c0d0275c:	69e0      	ldr	r0, [r4, #28]
c0d0275e:	4915      	ldr	r1, [pc, #84]	; (c0d027b4 <ui_idle+0x108>)
c0d02760:	4288      	cmp	r0, r1
c0d02762:	d116      	bne.n	c0d02792 <ui_idle+0xe6>
c0d02764:	e023      	b.n	c0d027ae <ui_idle+0x102>
c0d02766:	6860      	ldr	r0, [r4, #4]
c0d02768:	4285      	cmp	r5, r0
c0d0276a:	d220      	bcs.n	c0d027ae <ui_idle+0x102>
c0d0276c:	f7ff fe94 	bl	c0d02498 <io_seproxyhal_spi_is_status_sent>
c0d02770:	2800      	cmp	r0, #0
c0d02772:	d11c      	bne.n	c0d027ae <ui_idle+0x102>
c0d02774:	68a0      	ldr	r0, [r4, #8]
c0d02776:	68e1      	ldr	r1, [r4, #12]
c0d02778:	2538      	movs	r5, #56	; 0x38
c0d0277a:	4368      	muls	r0, r5
c0d0277c:	6822      	ldr	r2, [r4, #0]
c0d0277e:	1810      	adds	r0, r2, r0
c0d02780:	2900      	cmp	r1, #0
c0d02782:	d009      	beq.n	c0d02798 <ui_idle+0xec>
c0d02784:	4788      	blx	r1
c0d02786:	2800      	cmp	r0, #0
c0d02788:	d106      	bne.n	c0d02798 <ui_idle+0xec>
c0d0278a:	68a0      	ldr	r0, [r4, #8]
c0d0278c:	1c45      	adds	r5, r0, #1
c0d0278e:	60a5      	str	r5, [r4, #8]
c0d02790:	6820      	ldr	r0, [r4, #0]
c0d02792:	2800      	cmp	r0, #0
c0d02794:	d1e7      	bne.n	c0d02766 <ui_idle+0xba>
c0d02796:	e00a      	b.n	c0d027ae <ui_idle+0x102>
c0d02798:	2801      	cmp	r0, #1
c0d0279a:	d103      	bne.n	c0d027a4 <ui_idle+0xf8>
c0d0279c:	68a0      	ldr	r0, [r4, #8]
c0d0279e:	4345      	muls	r5, r0
c0d027a0:	6820      	ldr	r0, [r4, #0]
c0d027a2:	1940      	adds	r0, r0, r5
c0d027a4:	f7fe fa0e 	bl	c0d00bc4 <io_seproxyhal_display>
c0d027a8:	68a0      	ldr	r0, [r4, #8]
c0d027aa:	1c40      	adds	r0, r0, #1
c0d027ac:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen, NULL);
    }
}
c0d027ae:	bdb0      	pop	{r4, r5, r7, pc}
c0d027b0:	20001a58 	.word	0x20001a58
c0d027b4:	b0105044 	.word	0xb0105044
c0d027b8:	000015de 	.word	0x000015de
c0d027bc:	0000008d 	.word	0x0000008d
c0d027c0:	00001534 	.word	0x00001534
c0d027c4:	ffffffbb 	.word	0xffffffbb

c0d027c8 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d027c8:	2000      	movs	r0, #0
c0d027ca:	4770      	bx	lr

c0d027cc <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d027cc:	b5d0      	push	{r4, r6, r7, lr}
c0d027ce:	af02      	add	r7, sp, #8
c0d027d0:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d027d2:	4620      	mov	r0, r4
c0d027d4:	f7ff fdea 	bl	c0d023ac <os_sched_exit>
    return NULL;
c0d027d8:	4620      	mov	r0, r4
c0d027da:	bdd0      	pop	{r4, r6, r7, pc}

c0d027dc <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d027dc:	4902      	ldr	r1, [pc, #8]	; (c0d027e8 <USBD_LL_Init+0xc>)
c0d027de:	2000      	movs	r0, #0
c0d027e0:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d027e2:	4902      	ldr	r1, [pc, #8]	; (c0d027ec <USBD_LL_Init+0x10>)
c0d027e4:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d027e6:	4770      	bx	lr
c0d027e8:	20001d1c 	.word	0x20001d1c
c0d027ec:	20001d20 	.word	0x20001d20

c0d027f0 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d027f0:	b5d0      	push	{r4, r6, r7, lr}
c0d027f2:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d027f4:	4806      	ldr	r0, [pc, #24]	; (c0d02810 <USBD_LL_DeInit+0x20>)
c0d027f6:	214f      	movs	r1, #79	; 0x4f
c0d027f8:	7001      	strb	r1, [r0, #0]
c0d027fa:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d027fc:	7044      	strb	r4, [r0, #1]
c0d027fe:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02800:	7081      	strb	r1, [r0, #2]
c0d02802:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02804:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d02806:	2104      	movs	r1, #4
c0d02808:	f7ff fe28 	bl	c0d0245c <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d0280c:	4620      	mov	r0, r4
c0d0280e:	bdd0      	pop	{r4, r6, r7, pc}
c0d02810:	200019d8 	.word	0x200019d8

c0d02814 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02814:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02816:	af03      	add	r7, sp, #12
c0d02818:	b083      	sub	sp, #12
c0d0281a:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0281c:	264f      	movs	r6, #79	; 0x4f
c0d0281e:	702e      	strb	r6, [r5, #0]
c0d02820:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02822:	706c      	strb	r4, [r5, #1]
c0d02824:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d02826:	70a8      	strb	r0, [r5, #2]
c0d02828:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0282a:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d0282c:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0282e:	2105      	movs	r1, #5
c0d02830:	4628      	mov	r0, r5
c0d02832:	f7ff fe13 	bl	c0d0245c <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02836:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d02838:	706c      	strb	r4, [r5, #1]
c0d0283a:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d0283c:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d0283e:	70e8      	strb	r0, [r5, #3]
c0d02840:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d02842:	4628      	mov	r0, r5
c0d02844:	f7ff fe0a 	bl	c0d0245c <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02848:	4620      	mov	r0, r4
c0d0284a:	b003      	add	sp, #12
c0d0284c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0284e <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d0284e:	b5d0      	push	{r4, r6, r7, lr}
c0d02850:	af02      	add	r7, sp, #8
c0d02852:	b082      	sub	sp, #8
c0d02854:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02856:	214f      	movs	r1, #79	; 0x4f
c0d02858:	7001      	strb	r1, [r0, #0]
c0d0285a:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0285c:	7044      	strb	r4, [r0, #1]
c0d0285e:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d02860:	7081      	strb	r1, [r0, #2]
c0d02862:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02864:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d02866:	2104      	movs	r1, #4
c0d02868:	f7ff fdf8 	bl	c0d0245c <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0286c:	4620      	mov	r0, r4
c0d0286e:	b002      	add	sp, #8
c0d02870:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02874 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d02874:	b5b0      	push	{r4, r5, r7, lr}
c0d02876:	af02      	add	r7, sp, #8
c0d02878:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d0287a:	480f      	ldr	r0, [pc, #60]	; (c0d028b8 <USBD_LL_OpenEP+0x44>)
c0d0287c:	2400      	movs	r4, #0
c0d0287e:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d02880:	480e      	ldr	r0, [pc, #56]	; (c0d028bc <USBD_LL_OpenEP+0x48>)
c0d02882:	6004      	str	r4, [r0, #0]
c0d02884:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02886:	254f      	movs	r5, #79	; 0x4f
c0d02888:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d0288a:	7044      	strb	r4, [r0, #1]
c0d0288c:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d0288e:	7085      	strb	r5, [r0, #2]
c0d02890:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02892:	70c5      	strb	r5, [r0, #3]
c0d02894:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d02896:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d02898:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d0289a:	2a03      	cmp	r2, #3
c0d0289c:	d802      	bhi.n	c0d028a4 <USBD_LL_OpenEP+0x30>
c0d0289e:	00d0      	lsls	r0, r2, #3
c0d028a0:	4c07      	ldr	r4, [pc, #28]	; (c0d028c0 <USBD_LL_OpenEP+0x4c>)
c0d028a2:	40c4      	lsrs	r4, r0
c0d028a4:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d028a6:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d028a8:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d028aa:	2108      	movs	r1, #8
c0d028ac:	f7ff fdd6 	bl	c0d0245c <io_seproxyhal_spi_send>
c0d028b0:	2000      	movs	r0, #0
  return USBD_OK; 
c0d028b2:	b002      	add	sp, #8
c0d028b4:	bdb0      	pop	{r4, r5, r7, pc}
c0d028b6:	46c0      	nop			; (mov r8, r8)
c0d028b8:	20001d1c 	.word	0x20001d1c
c0d028bc:	20001d20 	.word	0x20001d20
c0d028c0:	02030401 	.word	0x02030401

c0d028c4 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d028c4:	b5d0      	push	{r4, r6, r7, lr}
c0d028c6:	af02      	add	r7, sp, #8
c0d028c8:	b082      	sub	sp, #8
c0d028ca:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d028cc:	224f      	movs	r2, #79	; 0x4f
c0d028ce:	7002      	strb	r2, [r0, #0]
c0d028d0:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d028d2:	7044      	strb	r4, [r0, #1]
c0d028d4:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d028d6:	7082      	strb	r2, [r0, #2]
c0d028d8:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d028da:	70c2      	strb	r2, [r0, #3]
c0d028dc:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d028de:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d028e0:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d028e2:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d028e4:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d028e6:	2108      	movs	r1, #8
c0d028e8:	f7ff fdb8 	bl	c0d0245c <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d028ec:	4620      	mov	r0, r4
c0d028ee:	b002      	add	sp, #8
c0d028f0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d028f4 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d028f4:	b5b0      	push	{r4, r5, r7, lr}
c0d028f6:	af02      	add	r7, sp, #8
c0d028f8:	b082      	sub	sp, #8
c0d028fa:	460d      	mov	r5, r1
c0d028fc:	4668      	mov	r0, sp
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
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d0290c:	2140      	movs	r1, #64	; 0x40
c0d0290e:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02910:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02912:	2106      	movs	r1, #6
c0d02914:	f7ff fda2 	bl	c0d0245c <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02918:	2080      	movs	r0, #128	; 0x80
c0d0291a:	4205      	tst	r5, r0
c0d0291c:	d101      	bne.n	c0d02922 <USBD_LL_StallEP+0x2e>
c0d0291e:	4807      	ldr	r0, [pc, #28]	; (c0d0293c <USBD_LL_StallEP+0x48>)
c0d02920:	e000      	b.n	c0d02924 <USBD_LL_StallEP+0x30>
c0d02922:	4805      	ldr	r0, [pc, #20]	; (c0d02938 <USBD_LL_StallEP+0x44>)
c0d02924:	6801      	ldr	r1, [r0, #0]
c0d02926:	227f      	movs	r2, #127	; 0x7f
c0d02928:	4015      	ands	r5, r2
c0d0292a:	2201      	movs	r2, #1
c0d0292c:	40aa      	lsls	r2, r5
c0d0292e:	430a      	orrs	r2, r1
c0d02930:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02932:	4620      	mov	r0, r4
c0d02934:	b002      	add	sp, #8
c0d02936:	bdb0      	pop	{r4, r5, r7, pc}
c0d02938:	20001d1c 	.word	0x20001d1c
c0d0293c:	20001d20 	.word	0x20001d20

c0d02940 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02940:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02942:	af03      	add	r7, sp, #12
c0d02944:	b083      	sub	sp, #12
c0d02946:	460d      	mov	r5, r1
c0d02948:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0294a:	2150      	movs	r1, #80	; 0x50
c0d0294c:	7001      	strb	r1, [r0, #0]
c0d0294e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02950:	7044      	strb	r4, [r0, #1]
c0d02952:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02954:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02956:	70c5      	strb	r5, [r0, #3]
c0d02958:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d0295a:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d0295c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0295e:	2106      	movs	r1, #6
c0d02960:	f7ff fd7c 	bl	c0d0245c <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02964:	4235      	tst	r5, r6
c0d02966:	d101      	bne.n	c0d0296c <USBD_LL_ClearStallEP+0x2c>
c0d02968:	4807      	ldr	r0, [pc, #28]	; (c0d02988 <USBD_LL_ClearStallEP+0x48>)
c0d0296a:	e000      	b.n	c0d0296e <USBD_LL_ClearStallEP+0x2e>
c0d0296c:	4805      	ldr	r0, [pc, #20]	; (c0d02984 <USBD_LL_ClearStallEP+0x44>)
c0d0296e:	6801      	ldr	r1, [r0, #0]
c0d02970:	227f      	movs	r2, #127	; 0x7f
c0d02972:	4015      	ands	r5, r2
c0d02974:	2201      	movs	r2, #1
c0d02976:	40aa      	lsls	r2, r5
c0d02978:	4391      	bics	r1, r2
c0d0297a:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d0297c:	4620      	mov	r0, r4
c0d0297e:	b003      	add	sp, #12
c0d02980:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02982:	46c0      	nop			; (mov r8, r8)
c0d02984:	20001d1c 	.word	0x20001d1c
c0d02988:	20001d20 	.word	0x20001d20

c0d0298c <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d0298c:	2080      	movs	r0, #128	; 0x80
c0d0298e:	4201      	tst	r1, r0
c0d02990:	d001      	beq.n	c0d02996 <USBD_LL_IsStallEP+0xa>
c0d02992:	4806      	ldr	r0, [pc, #24]	; (c0d029ac <USBD_LL_IsStallEP+0x20>)
c0d02994:	e000      	b.n	c0d02998 <USBD_LL_IsStallEP+0xc>
c0d02996:	4804      	ldr	r0, [pc, #16]	; (c0d029a8 <USBD_LL_IsStallEP+0x1c>)
c0d02998:	6800      	ldr	r0, [r0, #0]
c0d0299a:	227f      	movs	r2, #127	; 0x7f
c0d0299c:	4011      	ands	r1, r2
c0d0299e:	2201      	movs	r2, #1
c0d029a0:	408a      	lsls	r2, r1
c0d029a2:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d029a4:	b2d0      	uxtb	r0, r2
c0d029a6:	4770      	bx	lr
c0d029a8:	20001d20 	.word	0x20001d20
c0d029ac:	20001d1c 	.word	0x20001d1c

c0d029b0 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d029b0:	b5d0      	push	{r4, r6, r7, lr}
c0d029b2:	af02      	add	r7, sp, #8
c0d029b4:	b082      	sub	sp, #8
c0d029b6:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d029b8:	224f      	movs	r2, #79	; 0x4f
c0d029ba:	7002      	strb	r2, [r0, #0]
c0d029bc:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d029be:	7044      	strb	r4, [r0, #1]
c0d029c0:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d029c2:	7082      	strb	r2, [r0, #2]
c0d029c4:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d029c6:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d029c8:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d029ca:	2105      	movs	r1, #5
c0d029cc:	f7ff fd46 	bl	c0d0245c <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d029d0:	4620      	mov	r0, r4
c0d029d2:	b002      	add	sp, #8
c0d029d4:	bdd0      	pop	{r4, r6, r7, pc}

c0d029d6 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d029d6:	b5b0      	push	{r4, r5, r7, lr}
c0d029d8:	af02      	add	r7, sp, #8
c0d029da:	b082      	sub	sp, #8
c0d029dc:	461c      	mov	r4, r3
c0d029de:	4615      	mov	r5, r2
c0d029e0:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d029e2:	2250      	movs	r2, #80	; 0x50
c0d029e4:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d029e6:	1ce2      	adds	r2, r4, #3
c0d029e8:	0a13      	lsrs	r3, r2, #8
c0d029ea:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d029ec:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d029ee:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d029f0:	2120      	movs	r1, #32
c0d029f2:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d029f4:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d029f6:	2106      	movs	r1, #6
c0d029f8:	f7ff fd30 	bl	c0d0245c <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d029fc:	4628      	mov	r0, r5
c0d029fe:	4621      	mov	r1, r4
c0d02a00:	f7ff fd2c 	bl	c0d0245c <io_seproxyhal_spi_send>
c0d02a04:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02a06:	b002      	add	sp, #8
c0d02a08:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a0a <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02a0a:	b5d0      	push	{r4, r6, r7, lr}
c0d02a0c:	af02      	add	r7, sp, #8
c0d02a0e:	b082      	sub	sp, #8
c0d02a10:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02a12:	2350      	movs	r3, #80	; 0x50
c0d02a14:	7003      	strb	r3, [r0, #0]
c0d02a16:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02a18:	7044      	strb	r4, [r0, #1]
c0d02a1a:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02a1c:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d02a1e:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02a20:	2130      	movs	r1, #48	; 0x30
c0d02a22:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02a24:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02a26:	2106      	movs	r1, #6
c0d02a28:	f7ff fd18 	bl	c0d0245c <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d02a2c:	4620      	mov	r0, r4
c0d02a2e:	b002      	add	sp, #8
c0d02a30:	bdd0      	pop	{r4, r6, r7, pc}

c0d02a32 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02a32:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a34:	af03      	add	r7, sp, #12
c0d02a36:	b081      	sub	sp, #4
c0d02a38:	4615      	mov	r5, r2
c0d02a3a:	460e      	mov	r6, r1
c0d02a3c:	4604      	mov	r4, r0
c0d02a3e:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d02a40:	2c00      	cmp	r4, #0
c0d02a42:	d011      	beq.n	c0d02a68 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02a44:	2049      	movs	r0, #73	; 0x49
c0d02a46:	0081      	lsls	r1, r0, #2
c0d02a48:	4620      	mov	r0, r4
c0d02a4a:	f000 ffd7 	bl	c0d039fc <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d02a4e:	2e00      	cmp	r6, #0
c0d02a50:	d002      	beq.n	c0d02a58 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d02a52:	2011      	movs	r0, #17
c0d02a54:	0100      	lsls	r0, r0, #4
c0d02a56:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02a58:	20fc      	movs	r0, #252	; 0xfc
c0d02a5a:	2101      	movs	r1, #1
c0d02a5c:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d02a5e:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d02a60:	4620      	mov	r0, r4
c0d02a62:	f7ff febb 	bl	c0d027dc <USBD_LL_Init>
c0d02a66:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d02a68:	b2c0      	uxtb	r0, r0
c0d02a6a:	b001      	add	sp, #4
c0d02a6c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a6e <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d02a6e:	b5d0      	push	{r4, r6, r7, lr}
c0d02a70:	af02      	add	r7, sp, #8
c0d02a72:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02a74:	20fc      	movs	r0, #252	; 0xfc
c0d02a76:	2101      	movs	r1, #1
c0d02a78:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d02a7a:	2045      	movs	r0, #69	; 0x45
c0d02a7c:	0080      	lsls	r0, r0, #2
c0d02a7e:	5820      	ldr	r0, [r4, r0]
c0d02a80:	2800      	cmp	r0, #0
c0d02a82:	d006      	beq.n	c0d02a92 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02a84:	6840      	ldr	r0, [r0, #4]
c0d02a86:	f7ff fb2d 	bl	c0d020e4 <pic>
c0d02a8a:	4602      	mov	r2, r0
c0d02a8c:	7921      	ldrb	r1, [r4, #4]
c0d02a8e:	4620      	mov	r0, r4
c0d02a90:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d02a92:	4620      	mov	r0, r4
c0d02a94:	f7ff fedb 	bl	c0d0284e <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02a98:	4620      	mov	r0, r4
c0d02a9a:	f7ff fea9 	bl	c0d027f0 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d02a9e:	2000      	movs	r0, #0
c0d02aa0:	bdd0      	pop	{r4, r6, r7, pc}

c0d02aa2 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d02aa2:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d02aa4:	2900      	cmp	r1, #0
c0d02aa6:	d003      	beq.n	c0d02ab0 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02aa8:	2245      	movs	r2, #69	; 0x45
c0d02aaa:	0092      	lsls	r2, r2, #2
c0d02aac:	5081      	str	r1, [r0, r2]
c0d02aae:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02ab0:	b2d0      	uxtb	r0, r2
c0d02ab2:	4770      	bx	lr

c0d02ab4 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02ab4:	b580      	push	{r7, lr}
c0d02ab6:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02ab8:	f7ff feac 	bl	c0d02814 <USBD_LL_Start>
  
  return USBD_OK;  
c0d02abc:	2000      	movs	r0, #0
c0d02abe:	bd80      	pop	{r7, pc}

c0d02ac0 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02ac0:	b5b0      	push	{r4, r5, r7, lr}
c0d02ac2:	af02      	add	r7, sp, #8
c0d02ac4:	460c      	mov	r4, r1
c0d02ac6:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02ac8:	2045      	movs	r0, #69	; 0x45
c0d02aca:	0080      	lsls	r0, r0, #2
c0d02acc:	5828      	ldr	r0, [r5, r0]
c0d02ace:	2800      	cmp	r0, #0
c0d02ad0:	d00c      	beq.n	c0d02aec <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d02ad2:	6800      	ldr	r0, [r0, #0]
c0d02ad4:	f7ff fb06 	bl	c0d020e4 <pic>
c0d02ad8:	4602      	mov	r2, r0
c0d02ada:	4628      	mov	r0, r5
c0d02adc:	4621      	mov	r1, r4
c0d02ade:	4790      	blx	r2
c0d02ae0:	4601      	mov	r1, r0
c0d02ae2:	2002      	movs	r0, #2
c0d02ae4:	2900      	cmp	r1, #0
c0d02ae6:	d100      	bne.n	c0d02aea <USBD_SetClassConfig+0x2a>
c0d02ae8:	4608      	mov	r0, r1
c0d02aea:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02aec:	2002      	movs	r0, #2
c0d02aee:	bdb0      	pop	{r4, r5, r7, pc}

c0d02af0 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02af0:	b5b0      	push	{r4, r5, r7, lr}
c0d02af2:	af02      	add	r7, sp, #8
c0d02af4:	460c      	mov	r4, r1
c0d02af6:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02af8:	2045      	movs	r0, #69	; 0x45
c0d02afa:	0080      	lsls	r0, r0, #2
c0d02afc:	5828      	ldr	r0, [r5, r0]
c0d02afe:	2800      	cmp	r0, #0
c0d02b00:	d006      	beq.n	c0d02b10 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02b02:	6840      	ldr	r0, [r0, #4]
c0d02b04:	f7ff faee 	bl	c0d020e4 <pic>
c0d02b08:	4602      	mov	r2, r0
c0d02b0a:	4628      	mov	r0, r5
c0d02b0c:	4621      	mov	r1, r4
c0d02b0e:	4790      	blx	r2
  }
  return USBD_OK;
c0d02b10:	2000      	movs	r0, #0
c0d02b12:	bdb0      	pop	{r4, r5, r7, pc}

c0d02b14 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02b14:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b16:	af03      	add	r7, sp, #12
c0d02b18:	b081      	sub	sp, #4
c0d02b1a:	4604      	mov	r4, r0
c0d02b1c:	2021      	movs	r0, #33	; 0x21
c0d02b1e:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02b20:	19a5      	adds	r5, r4, r6
c0d02b22:	4628      	mov	r0, r5
c0d02b24:	f000 fb69 	bl	c0d031fa <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02b28:	20f4      	movs	r0, #244	; 0xf4
c0d02b2a:	2101      	movs	r1, #1
c0d02b2c:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d02b2e:	2087      	movs	r0, #135	; 0x87
c0d02b30:	0040      	lsls	r0, r0, #1
c0d02b32:	5a20      	ldrh	r0, [r4, r0]
c0d02b34:	21f8      	movs	r1, #248	; 0xf8
c0d02b36:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02b38:	5da1      	ldrb	r1, [r4, r6]
c0d02b3a:	201f      	movs	r0, #31
c0d02b3c:	4008      	ands	r0, r1
c0d02b3e:	2802      	cmp	r0, #2
c0d02b40:	d008      	beq.n	c0d02b54 <USBD_LL_SetupStage+0x40>
c0d02b42:	2801      	cmp	r0, #1
c0d02b44:	d00b      	beq.n	c0d02b5e <USBD_LL_SetupStage+0x4a>
c0d02b46:	2800      	cmp	r0, #0
c0d02b48:	d10e      	bne.n	c0d02b68 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d02b4a:	4620      	mov	r0, r4
c0d02b4c:	4629      	mov	r1, r5
c0d02b4e:	f000 f8f1 	bl	c0d02d34 <USBD_StdDevReq>
c0d02b52:	e00e      	b.n	c0d02b72 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02b54:	4620      	mov	r0, r4
c0d02b56:	4629      	mov	r1, r5
c0d02b58:	f000 fad3 	bl	c0d03102 <USBD_StdEPReq>
c0d02b5c:	e009      	b.n	c0d02b72 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d02b5e:	4620      	mov	r0, r4
c0d02b60:	4629      	mov	r1, r5
c0d02b62:	f000 faa6 	bl	c0d030b2 <USBD_StdItfReq>
c0d02b66:	e004      	b.n	c0d02b72 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d02b68:	2080      	movs	r0, #128	; 0x80
c0d02b6a:	4001      	ands	r1, r0
c0d02b6c:	4620      	mov	r0, r4
c0d02b6e:	f7ff fec1 	bl	c0d028f4 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d02b72:	2000      	movs	r0, #0
c0d02b74:	b001      	add	sp, #4
c0d02b76:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b78 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d02b78:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b7a:	af03      	add	r7, sp, #12
c0d02b7c:	b081      	sub	sp, #4
c0d02b7e:	4615      	mov	r5, r2
c0d02b80:	460e      	mov	r6, r1
c0d02b82:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02b84:	2e00      	cmp	r6, #0
c0d02b86:	d011      	beq.n	c0d02bac <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02b88:	2045      	movs	r0, #69	; 0x45
c0d02b8a:	0080      	lsls	r0, r0, #2
c0d02b8c:	5820      	ldr	r0, [r4, r0]
c0d02b8e:	6980      	ldr	r0, [r0, #24]
c0d02b90:	2800      	cmp	r0, #0
c0d02b92:	d034      	beq.n	c0d02bfe <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02b94:	21fc      	movs	r1, #252	; 0xfc
c0d02b96:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02b98:	2903      	cmp	r1, #3
c0d02b9a:	d130      	bne.n	c0d02bfe <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02b9c:	f7ff faa2 	bl	c0d020e4 <pic>
c0d02ba0:	4603      	mov	r3, r0
c0d02ba2:	4620      	mov	r0, r4
c0d02ba4:	4631      	mov	r1, r6
c0d02ba6:	462a      	mov	r2, r5
c0d02ba8:	4798      	blx	r3
c0d02baa:	e028      	b.n	c0d02bfe <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02bac:	20f4      	movs	r0, #244	; 0xf4
c0d02bae:	5820      	ldr	r0, [r4, r0]
c0d02bb0:	2803      	cmp	r0, #3
c0d02bb2:	d124      	bne.n	c0d02bfe <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02bb4:	2090      	movs	r0, #144	; 0x90
c0d02bb6:	5820      	ldr	r0, [r4, r0]
c0d02bb8:	218c      	movs	r1, #140	; 0x8c
c0d02bba:	5861      	ldr	r1, [r4, r1]
c0d02bbc:	4622      	mov	r2, r4
c0d02bbe:	328c      	adds	r2, #140	; 0x8c
c0d02bc0:	4281      	cmp	r1, r0
c0d02bc2:	d90a      	bls.n	c0d02bda <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02bc4:	1a09      	subs	r1, r1, r0
c0d02bc6:	6011      	str	r1, [r2, #0]
c0d02bc8:	4281      	cmp	r1, r0
c0d02bca:	d300      	bcc.n	c0d02bce <USBD_LL_DataOutStage+0x56>
c0d02bcc:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d02bce:	b28a      	uxth	r2, r1
c0d02bd0:	4620      	mov	r0, r4
c0d02bd2:	4629      	mov	r1, r5
c0d02bd4:	f000 fc70 	bl	c0d034b8 <USBD_CtlContinueRx>
c0d02bd8:	e011      	b.n	c0d02bfe <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02bda:	2045      	movs	r0, #69	; 0x45
c0d02bdc:	0080      	lsls	r0, r0, #2
c0d02bde:	5820      	ldr	r0, [r4, r0]
c0d02be0:	6900      	ldr	r0, [r0, #16]
c0d02be2:	2800      	cmp	r0, #0
c0d02be4:	d008      	beq.n	c0d02bf8 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02be6:	21fc      	movs	r1, #252	; 0xfc
c0d02be8:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02bea:	2903      	cmp	r1, #3
c0d02bec:	d104      	bne.n	c0d02bf8 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02bee:	f7ff fa79 	bl	c0d020e4 <pic>
c0d02bf2:	4601      	mov	r1, r0
c0d02bf4:	4620      	mov	r0, r4
c0d02bf6:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02bf8:	4620      	mov	r0, r4
c0d02bfa:	f000 fc65 	bl	c0d034c8 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02bfe:	2000      	movs	r0, #0
c0d02c00:	b001      	add	sp, #4
c0d02c02:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c04 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02c04:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c06:	af03      	add	r7, sp, #12
c0d02c08:	b081      	sub	sp, #4
c0d02c0a:	460d      	mov	r5, r1
c0d02c0c:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02c0e:	2d00      	cmp	r5, #0
c0d02c10:	d012      	beq.n	c0d02c38 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02c12:	2045      	movs	r0, #69	; 0x45
c0d02c14:	0080      	lsls	r0, r0, #2
c0d02c16:	5820      	ldr	r0, [r4, r0]
c0d02c18:	2800      	cmp	r0, #0
c0d02c1a:	d054      	beq.n	c0d02cc6 <USBD_LL_DataInStage+0xc2>
c0d02c1c:	6940      	ldr	r0, [r0, #20]
c0d02c1e:	2800      	cmp	r0, #0
c0d02c20:	d051      	beq.n	c0d02cc6 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02c22:	21fc      	movs	r1, #252	; 0xfc
c0d02c24:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02c26:	2903      	cmp	r1, #3
c0d02c28:	d14d      	bne.n	c0d02cc6 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d02c2a:	f7ff fa5b 	bl	c0d020e4 <pic>
c0d02c2e:	4602      	mov	r2, r0
c0d02c30:	4620      	mov	r0, r4
c0d02c32:	4629      	mov	r1, r5
c0d02c34:	4790      	blx	r2
c0d02c36:	e046      	b.n	c0d02cc6 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02c38:	20f4      	movs	r0, #244	; 0xf4
c0d02c3a:	5820      	ldr	r0, [r4, r0]
c0d02c3c:	2802      	cmp	r0, #2
c0d02c3e:	d13a      	bne.n	c0d02cb6 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02c40:	69e0      	ldr	r0, [r4, #28]
c0d02c42:	6a25      	ldr	r5, [r4, #32]
c0d02c44:	42a8      	cmp	r0, r5
c0d02c46:	d90b      	bls.n	c0d02c60 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02c48:	1b40      	subs	r0, r0, r5
c0d02c4a:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d02c4c:	2109      	movs	r1, #9
c0d02c4e:	014a      	lsls	r2, r1, #5
c0d02c50:	58a1      	ldr	r1, [r4, r2]
c0d02c52:	1949      	adds	r1, r1, r5
c0d02c54:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02c56:	b282      	uxth	r2, r0
c0d02c58:	4620      	mov	r0, r4
c0d02c5a:	f000 fc1e 	bl	c0d0349a <USBD_CtlContinueSendData>
c0d02c5e:	e02a      	b.n	c0d02cb6 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02c60:	69a6      	ldr	r6, [r4, #24]
c0d02c62:	4630      	mov	r0, r6
c0d02c64:	4629      	mov	r1, r5
c0d02c66:	f000 fccf 	bl	c0d03608 <__aeabi_uidivmod>
c0d02c6a:	42ae      	cmp	r6, r5
c0d02c6c:	d30f      	bcc.n	c0d02c8e <USBD_LL_DataInStage+0x8a>
c0d02c6e:	2900      	cmp	r1, #0
c0d02c70:	d10d      	bne.n	c0d02c8e <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02c72:	20f8      	movs	r0, #248	; 0xf8
c0d02c74:	5820      	ldr	r0, [r4, r0]
c0d02c76:	4625      	mov	r5, r4
c0d02c78:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02c7a:	4286      	cmp	r6, r0
c0d02c7c:	d207      	bcs.n	c0d02c8e <USBD_LL_DataInStage+0x8a>
c0d02c7e:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02c80:	4620      	mov	r0, r4
c0d02c82:	4631      	mov	r1, r6
c0d02c84:	4632      	mov	r2, r6
c0d02c86:	f000 fc08 	bl	c0d0349a <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02c8a:	602e      	str	r6, [r5, #0]
c0d02c8c:	e013      	b.n	c0d02cb6 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02c8e:	2045      	movs	r0, #69	; 0x45
c0d02c90:	0080      	lsls	r0, r0, #2
c0d02c92:	5820      	ldr	r0, [r4, r0]
c0d02c94:	2800      	cmp	r0, #0
c0d02c96:	d00b      	beq.n	c0d02cb0 <USBD_LL_DataInStage+0xac>
c0d02c98:	68c0      	ldr	r0, [r0, #12]
c0d02c9a:	2800      	cmp	r0, #0
c0d02c9c:	d008      	beq.n	c0d02cb0 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02c9e:	21fc      	movs	r1, #252	; 0xfc
c0d02ca0:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02ca2:	2903      	cmp	r1, #3
c0d02ca4:	d104      	bne.n	c0d02cb0 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02ca6:	f7ff fa1d 	bl	c0d020e4 <pic>
c0d02caa:	4601      	mov	r1, r0
c0d02cac:	4620      	mov	r0, r4
c0d02cae:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02cb0:	4620      	mov	r0, r4
c0d02cb2:	f000 fc16 	bl	c0d034e2 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02cb6:	2001      	movs	r0, #1
c0d02cb8:	0201      	lsls	r1, r0, #8
c0d02cba:	1860      	adds	r0, r4, r1
c0d02cbc:	5c61      	ldrb	r1, [r4, r1]
c0d02cbe:	2901      	cmp	r1, #1
c0d02cc0:	d101      	bne.n	c0d02cc6 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02cc2:	2100      	movs	r1, #0
c0d02cc4:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02cc6:	2000      	movs	r0, #0
c0d02cc8:	b001      	add	sp, #4
c0d02cca:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02ccc <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02ccc:	b5d0      	push	{r4, r6, r7, lr}
c0d02cce:	af02      	add	r7, sp, #8
c0d02cd0:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02cd2:	2090      	movs	r0, #144	; 0x90
c0d02cd4:	2140      	movs	r1, #64	; 0x40
c0d02cd6:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02cd8:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02cda:	20fc      	movs	r0, #252	; 0xfc
c0d02cdc:	2101      	movs	r1, #1
c0d02cde:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02ce0:	2045      	movs	r0, #69	; 0x45
c0d02ce2:	0080      	lsls	r0, r0, #2
c0d02ce4:	5820      	ldr	r0, [r4, r0]
c0d02ce6:	2800      	cmp	r0, #0
c0d02ce8:	d006      	beq.n	c0d02cf8 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02cea:	6840      	ldr	r0, [r0, #4]
c0d02cec:	f7ff f9fa 	bl	c0d020e4 <pic>
c0d02cf0:	4602      	mov	r2, r0
c0d02cf2:	7921      	ldrb	r1, [r4, #4]
c0d02cf4:	4620      	mov	r0, r4
c0d02cf6:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02cf8:	2000      	movs	r0, #0
c0d02cfa:	bdd0      	pop	{r4, r6, r7, pc}

c0d02cfc <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02cfc:	7401      	strb	r1, [r0, #16]
c0d02cfe:	2000      	movs	r0, #0
  return USBD_OK;
c0d02d00:	4770      	bx	lr

c0d02d02 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02d02:	2000      	movs	r0, #0
c0d02d04:	4770      	bx	lr

c0d02d06 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02d06:	2000      	movs	r0, #0
c0d02d08:	4770      	bx	lr

c0d02d0a <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02d0a:	b5d0      	push	{r4, r6, r7, lr}
c0d02d0c:	af02      	add	r7, sp, #8
c0d02d0e:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02d10:	20fc      	movs	r0, #252	; 0xfc
c0d02d12:	5c20      	ldrb	r0, [r4, r0]
c0d02d14:	2803      	cmp	r0, #3
c0d02d16:	d10a      	bne.n	c0d02d2e <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02d18:	2045      	movs	r0, #69	; 0x45
c0d02d1a:	0080      	lsls	r0, r0, #2
c0d02d1c:	5820      	ldr	r0, [r4, r0]
c0d02d1e:	69c0      	ldr	r0, [r0, #28]
c0d02d20:	2800      	cmp	r0, #0
c0d02d22:	d004      	beq.n	c0d02d2e <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02d24:	f7ff f9de 	bl	c0d020e4 <pic>
c0d02d28:	4601      	mov	r1, r0
c0d02d2a:	4620      	mov	r0, r4
c0d02d2c:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d02d2e:	2000      	movs	r0, #0
c0d02d30:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02d34 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02d34:	b5d0      	push	{r4, r6, r7, lr}
c0d02d36:	af02      	add	r7, sp, #8
c0d02d38:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02d3a:	7848      	ldrb	r0, [r1, #1]
c0d02d3c:	2809      	cmp	r0, #9
c0d02d3e:	d810      	bhi.n	c0d02d62 <USBD_StdDevReq+0x2e>
c0d02d40:	4478      	add	r0, pc
c0d02d42:	7900      	ldrb	r0, [r0, #4]
c0d02d44:	0040      	lsls	r0, r0, #1
c0d02d46:	4487      	add	pc, r0
c0d02d48:	150c0804 	.word	0x150c0804
c0d02d4c:	0c25190c 	.word	0x0c25190c
c0d02d50:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02d52:	4620      	mov	r0, r4
c0d02d54:	f000 f938 	bl	c0d02fc8 <USBD_GetStatus>
c0d02d58:	e01f      	b.n	c0d02d9a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02d5a:	4620      	mov	r0, r4
c0d02d5c:	f000 f976 	bl	c0d0304c <USBD_ClrFeature>
c0d02d60:	e01b      	b.n	c0d02d9a <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d62:	2180      	movs	r1, #128	; 0x80
c0d02d64:	4620      	mov	r0, r4
c0d02d66:	f7ff fdc5 	bl	c0d028f4 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02d6a:	2100      	movs	r1, #0
c0d02d6c:	4620      	mov	r0, r4
c0d02d6e:	f7ff fdc1 	bl	c0d028f4 <USBD_LL_StallEP>
c0d02d72:	e012      	b.n	c0d02d9a <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02d74:	4620      	mov	r0, r4
c0d02d76:	f000 f950 	bl	c0d0301a <USBD_SetFeature>
c0d02d7a:	e00e      	b.n	c0d02d9a <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02d7c:	4620      	mov	r0, r4
c0d02d7e:	f000 f897 	bl	c0d02eb0 <USBD_SetAddress>
c0d02d82:	e00a      	b.n	c0d02d9a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02d84:	4620      	mov	r0, r4
c0d02d86:	f000 f8ff 	bl	c0d02f88 <USBD_GetConfig>
c0d02d8a:	e006      	b.n	c0d02d9a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02d8c:	4620      	mov	r0, r4
c0d02d8e:	f000 f8bd 	bl	c0d02f0c <USBD_SetConfig>
c0d02d92:	e002      	b.n	c0d02d9a <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02d94:	4620      	mov	r0, r4
c0d02d96:	f000 f803 	bl	c0d02da0 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02d9a:	2000      	movs	r0, #0
c0d02d9c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02da0 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02da0:	b5b0      	push	{r4, r5, r7, lr}
c0d02da2:	af02      	add	r7, sp, #8
c0d02da4:	b082      	sub	sp, #8
c0d02da6:	460d      	mov	r5, r1
c0d02da8:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02daa:	8868      	ldrh	r0, [r5, #2]
c0d02dac:	0a01      	lsrs	r1, r0, #8
c0d02dae:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02db0:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02db2:	2a0e      	cmp	r2, #14
c0d02db4:	d83e      	bhi.n	c0d02e34 <USBD_GetDescriptor+0x94>
c0d02db6:	46c0      	nop			; (mov r8, r8)
c0d02db8:	447a      	add	r2, pc
c0d02dba:	7912      	ldrb	r2, [r2, #4]
c0d02dbc:	0052      	lsls	r2, r2, #1
c0d02dbe:	4497      	add	pc, r2
c0d02dc0:	390c2607 	.word	0x390c2607
c0d02dc4:	39362e39 	.word	0x39362e39
c0d02dc8:	39393939 	.word	0x39393939
c0d02dcc:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02dd0:	2011      	movs	r0, #17
c0d02dd2:	0100      	lsls	r0, r0, #4
c0d02dd4:	5820      	ldr	r0, [r4, r0]
c0d02dd6:	6800      	ldr	r0, [r0, #0]
c0d02dd8:	e012      	b.n	c0d02e00 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02dda:	b2c0      	uxtb	r0, r0
c0d02ddc:	2805      	cmp	r0, #5
c0d02dde:	d829      	bhi.n	c0d02e34 <USBD_GetDescriptor+0x94>
c0d02de0:	4478      	add	r0, pc
c0d02de2:	7900      	ldrb	r0, [r0, #4]
c0d02de4:	0040      	lsls	r0, r0, #1
c0d02de6:	4487      	add	pc, r0
c0d02de8:	544f4a02 	.word	0x544f4a02
c0d02dec:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02dee:	2011      	movs	r0, #17
c0d02df0:	0100      	lsls	r0, r0, #4
c0d02df2:	5820      	ldr	r0, [r4, r0]
c0d02df4:	6840      	ldr	r0, [r0, #4]
c0d02df6:	e003      	b.n	c0d02e00 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02df8:	2011      	movs	r0, #17
c0d02dfa:	0100      	lsls	r0, r0, #4
c0d02dfc:	5820      	ldr	r0, [r4, r0]
c0d02dfe:	69c0      	ldr	r0, [r0, #28]
c0d02e00:	f7ff f970 	bl	c0d020e4 <pic>
c0d02e04:	4602      	mov	r2, r0
c0d02e06:	7c20      	ldrb	r0, [r4, #16]
c0d02e08:	a901      	add	r1, sp, #4
c0d02e0a:	4790      	blx	r2
c0d02e0c:	e025      	b.n	c0d02e5a <USBD_GetDescriptor+0xba>
c0d02e0e:	2045      	movs	r0, #69	; 0x45
c0d02e10:	0080      	lsls	r0, r0, #2
c0d02e12:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02e14:	7c21      	ldrb	r1, [r4, #16]
c0d02e16:	2900      	cmp	r1, #0
c0d02e18:	d014      	beq.n	c0d02e44 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02e1a:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02e1c:	e018      	b.n	c0d02e50 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02e1e:	7c20      	ldrb	r0, [r4, #16]
c0d02e20:	2800      	cmp	r0, #0
c0d02e22:	d107      	bne.n	c0d02e34 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02e24:	2045      	movs	r0, #69	; 0x45
c0d02e26:	0080      	lsls	r0, r0, #2
c0d02e28:	5820      	ldr	r0, [r4, r0]
c0d02e2a:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02e2c:	e010      	b.n	c0d02e50 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02e2e:	7c20      	ldrb	r0, [r4, #16]
c0d02e30:	2800      	cmp	r0, #0
c0d02e32:	d009      	beq.n	c0d02e48 <USBD_GetDescriptor+0xa8>
c0d02e34:	4620      	mov	r0, r4
c0d02e36:	f7ff fd5d 	bl	c0d028f4 <USBD_LL_StallEP>
c0d02e3a:	2100      	movs	r1, #0
c0d02e3c:	4620      	mov	r0, r4
c0d02e3e:	f7ff fd59 	bl	c0d028f4 <USBD_LL_StallEP>
c0d02e42:	e01a      	b.n	c0d02e7a <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02e44:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02e46:	e003      	b.n	c0d02e50 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02e48:	2045      	movs	r0, #69	; 0x45
c0d02e4a:	0080      	lsls	r0, r0, #2
c0d02e4c:	5820      	ldr	r0, [r4, r0]
c0d02e4e:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02e50:	f7ff f948 	bl	c0d020e4 <pic>
c0d02e54:	4601      	mov	r1, r0
c0d02e56:	a801      	add	r0, sp, #4
c0d02e58:	4788      	blx	r1
c0d02e5a:	4601      	mov	r1, r0
c0d02e5c:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02e5e:	8802      	ldrh	r2, [r0, #0]
c0d02e60:	2a00      	cmp	r2, #0
c0d02e62:	d00a      	beq.n	c0d02e7a <USBD_GetDescriptor+0xda>
c0d02e64:	88e8      	ldrh	r0, [r5, #6]
c0d02e66:	2800      	cmp	r0, #0
c0d02e68:	d007      	beq.n	c0d02e7a <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02e6a:	4282      	cmp	r2, r0
c0d02e6c:	d300      	bcc.n	c0d02e70 <USBD_GetDescriptor+0xd0>
c0d02e6e:	4602      	mov	r2, r0
c0d02e70:	a801      	add	r0, sp, #4
c0d02e72:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02e74:	4620      	mov	r0, r4
c0d02e76:	f000 faf9 	bl	c0d0346c <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02e7a:	b002      	add	sp, #8
c0d02e7c:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02e7e:	2011      	movs	r0, #17
c0d02e80:	0100      	lsls	r0, r0, #4
c0d02e82:	5820      	ldr	r0, [r4, r0]
c0d02e84:	6880      	ldr	r0, [r0, #8]
c0d02e86:	e7bb      	b.n	c0d02e00 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02e88:	2011      	movs	r0, #17
c0d02e8a:	0100      	lsls	r0, r0, #4
c0d02e8c:	5820      	ldr	r0, [r4, r0]
c0d02e8e:	68c0      	ldr	r0, [r0, #12]
c0d02e90:	e7b6      	b.n	c0d02e00 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02e92:	2011      	movs	r0, #17
c0d02e94:	0100      	lsls	r0, r0, #4
c0d02e96:	5820      	ldr	r0, [r4, r0]
c0d02e98:	6900      	ldr	r0, [r0, #16]
c0d02e9a:	e7b1      	b.n	c0d02e00 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02e9c:	2011      	movs	r0, #17
c0d02e9e:	0100      	lsls	r0, r0, #4
c0d02ea0:	5820      	ldr	r0, [r4, r0]
c0d02ea2:	6940      	ldr	r0, [r0, #20]
c0d02ea4:	e7ac      	b.n	c0d02e00 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02ea6:	2011      	movs	r0, #17
c0d02ea8:	0100      	lsls	r0, r0, #4
c0d02eaa:	5820      	ldr	r0, [r4, r0]
c0d02eac:	6980      	ldr	r0, [r0, #24]
c0d02eae:	e7a7      	b.n	c0d02e00 <USBD_GetDescriptor+0x60>

c0d02eb0 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02eb0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02eb2:	af03      	add	r7, sp, #12
c0d02eb4:	b081      	sub	sp, #4
c0d02eb6:	460a      	mov	r2, r1
c0d02eb8:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02eba:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02ebc:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02ebe:	2800      	cmp	r0, #0
c0d02ec0:	d10b      	bne.n	c0d02eda <USBD_SetAddress+0x2a>
c0d02ec2:	88d0      	ldrh	r0, [r2, #6]
c0d02ec4:	2800      	cmp	r0, #0
c0d02ec6:	d108      	bne.n	c0d02eda <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02ec8:	8850      	ldrh	r0, [r2, #2]
c0d02eca:	267f      	movs	r6, #127	; 0x7f
c0d02ecc:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02ece:	20fc      	movs	r0, #252	; 0xfc
c0d02ed0:	5c20      	ldrb	r0, [r4, r0]
c0d02ed2:	4625      	mov	r5, r4
c0d02ed4:	35fc      	adds	r5, #252	; 0xfc
c0d02ed6:	2803      	cmp	r0, #3
c0d02ed8:	d108      	bne.n	c0d02eec <USBD_SetAddress+0x3c>
c0d02eda:	4620      	mov	r0, r4
c0d02edc:	f7ff fd0a 	bl	c0d028f4 <USBD_LL_StallEP>
c0d02ee0:	2100      	movs	r1, #0
c0d02ee2:	4620      	mov	r0, r4
c0d02ee4:	f7ff fd06 	bl	c0d028f4 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02ee8:	b001      	add	sp, #4
c0d02eea:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02eec:	20fe      	movs	r0, #254	; 0xfe
c0d02eee:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02ef0:	b2f1      	uxtb	r1, r6
c0d02ef2:	4620      	mov	r0, r4
c0d02ef4:	f7ff fd5c 	bl	c0d029b0 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02ef8:	4620      	mov	r0, r4
c0d02efa:	f000 fae5 	bl	c0d034c8 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02efe:	2002      	movs	r0, #2
c0d02f00:	2101      	movs	r1, #1
c0d02f02:	2e00      	cmp	r6, #0
c0d02f04:	d100      	bne.n	c0d02f08 <USBD_SetAddress+0x58>
c0d02f06:	4608      	mov	r0, r1
c0d02f08:	7028      	strb	r0, [r5, #0]
c0d02f0a:	e7ed      	b.n	c0d02ee8 <USBD_SetAddress+0x38>

c0d02f0c <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02f0c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02f0e:	af03      	add	r7, sp, #12
c0d02f10:	b081      	sub	sp, #4
c0d02f12:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02f14:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f16:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02f18:	2e02      	cmp	r6, #2
c0d02f1a:	d21d      	bcs.n	c0d02f58 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02f1c:	20fc      	movs	r0, #252	; 0xfc
c0d02f1e:	5c21      	ldrb	r1, [r4, r0]
c0d02f20:	4620      	mov	r0, r4
c0d02f22:	30fc      	adds	r0, #252	; 0xfc
c0d02f24:	2903      	cmp	r1, #3
c0d02f26:	d007      	beq.n	c0d02f38 <USBD_SetConfig+0x2c>
c0d02f28:	2902      	cmp	r1, #2
c0d02f2a:	d115      	bne.n	c0d02f58 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02f2c:	2e00      	cmp	r6, #0
c0d02f2e:	d026      	beq.n	c0d02f7e <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02f30:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02f32:	2103      	movs	r1, #3
c0d02f34:	7001      	strb	r1, [r0, #0]
c0d02f36:	e009      	b.n	c0d02f4c <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02f38:	2e00      	cmp	r6, #0
c0d02f3a:	d016      	beq.n	c0d02f6a <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02f3c:	6860      	ldr	r0, [r4, #4]
c0d02f3e:	4286      	cmp	r6, r0
c0d02f40:	d01d      	beq.n	c0d02f7e <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02f42:	b2c1      	uxtb	r1, r0
c0d02f44:	4620      	mov	r0, r4
c0d02f46:	f7ff fdd3 	bl	c0d02af0 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02f4a:	6066      	str	r6, [r4, #4]
c0d02f4c:	4620      	mov	r0, r4
c0d02f4e:	4631      	mov	r1, r6
c0d02f50:	f7ff fdb6 	bl	c0d02ac0 <USBD_SetClassConfig>
c0d02f54:	2802      	cmp	r0, #2
c0d02f56:	d112      	bne.n	c0d02f7e <USBD_SetConfig+0x72>
c0d02f58:	4620      	mov	r0, r4
c0d02f5a:	4629      	mov	r1, r5
c0d02f5c:	f7ff fcca 	bl	c0d028f4 <USBD_LL_StallEP>
c0d02f60:	2100      	movs	r1, #0
c0d02f62:	4620      	mov	r0, r4
c0d02f64:	f7ff fcc6 	bl	c0d028f4 <USBD_LL_StallEP>
c0d02f68:	e00c      	b.n	c0d02f84 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02f6a:	2102      	movs	r1, #2
c0d02f6c:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02f6e:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02f70:	4620      	mov	r0, r4
c0d02f72:	4631      	mov	r1, r6
c0d02f74:	f7ff fdbc 	bl	c0d02af0 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02f78:	4620      	mov	r0, r4
c0d02f7a:	f000 faa5 	bl	c0d034c8 <USBD_CtlSendStatus>
c0d02f7e:	4620      	mov	r0, r4
c0d02f80:	f000 faa2 	bl	c0d034c8 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02f84:	b001      	add	sp, #4
c0d02f86:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02f88 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02f88:	b5d0      	push	{r4, r6, r7, lr}
c0d02f8a:	af02      	add	r7, sp, #8
c0d02f8c:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02f8e:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f90:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02f92:	2801      	cmp	r0, #1
c0d02f94:	d10a      	bne.n	c0d02fac <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02f96:	20fc      	movs	r0, #252	; 0xfc
c0d02f98:	5c20      	ldrb	r0, [r4, r0]
c0d02f9a:	2803      	cmp	r0, #3
c0d02f9c:	d00e      	beq.n	c0d02fbc <USBD_GetConfig+0x34>
c0d02f9e:	2802      	cmp	r0, #2
c0d02fa0:	d104      	bne.n	c0d02fac <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02fa2:	2000      	movs	r0, #0
c0d02fa4:	60a0      	str	r0, [r4, #8]
c0d02fa6:	4621      	mov	r1, r4
c0d02fa8:	3108      	adds	r1, #8
c0d02faa:	e008      	b.n	c0d02fbe <USBD_GetConfig+0x36>
c0d02fac:	4620      	mov	r0, r4
c0d02fae:	f7ff fca1 	bl	c0d028f4 <USBD_LL_StallEP>
c0d02fb2:	2100      	movs	r1, #0
c0d02fb4:	4620      	mov	r0, r4
c0d02fb6:	f7ff fc9d 	bl	c0d028f4 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02fba:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02fbc:	1d21      	adds	r1, r4, #4
c0d02fbe:	2201      	movs	r2, #1
c0d02fc0:	4620      	mov	r0, r4
c0d02fc2:	f000 fa53 	bl	c0d0346c <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02fc6:	bdd0      	pop	{r4, r6, r7, pc}

c0d02fc8 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02fc8:	b5b0      	push	{r4, r5, r7, lr}
c0d02fca:	af02      	add	r7, sp, #8
c0d02fcc:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02fce:	20fc      	movs	r0, #252	; 0xfc
c0d02fd0:	5c20      	ldrb	r0, [r4, r0]
c0d02fd2:	21fe      	movs	r1, #254	; 0xfe
c0d02fd4:	4001      	ands	r1, r0
c0d02fd6:	2902      	cmp	r1, #2
c0d02fd8:	d116      	bne.n	c0d03008 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02fda:	2001      	movs	r0, #1
c0d02fdc:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02fde:	2041      	movs	r0, #65	; 0x41
c0d02fe0:	0080      	lsls	r0, r0, #2
c0d02fe2:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02fe4:	4625      	mov	r5, r4
c0d02fe6:	350c      	adds	r5, #12
c0d02fe8:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02fea:	2900      	cmp	r1, #0
c0d02fec:	d005      	beq.n	c0d02ffa <USBD_GetStatus+0x32>
c0d02fee:	4620      	mov	r0, r4
c0d02ff0:	f000 fa77 	bl	c0d034e2 <USBD_CtlReceiveStatus>
c0d02ff4:	68e1      	ldr	r1, [r4, #12]
c0d02ff6:	2002      	movs	r0, #2
c0d02ff8:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02ffa:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02ffc:	2202      	movs	r2, #2
c0d02ffe:	4620      	mov	r0, r4
c0d03000:	4629      	mov	r1, r5
c0d03002:	f000 fa33 	bl	c0d0346c <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d03006:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d03008:	2180      	movs	r1, #128	; 0x80
c0d0300a:	4620      	mov	r0, r4
c0d0300c:	f7ff fc72 	bl	c0d028f4 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d03010:	2100      	movs	r1, #0
c0d03012:	4620      	mov	r0, r4
c0d03014:	f7ff fc6e 	bl	c0d028f4 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d03018:	bdb0      	pop	{r4, r5, r7, pc}

c0d0301a <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0301a:	b5b0      	push	{r4, r5, r7, lr}
c0d0301c:	af02      	add	r7, sp, #8
c0d0301e:	460d      	mov	r5, r1
c0d03020:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d03022:	8868      	ldrh	r0, [r5, #2]
c0d03024:	2801      	cmp	r0, #1
c0d03026:	d110      	bne.n	c0d0304a <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d03028:	2041      	movs	r0, #65	; 0x41
c0d0302a:	0080      	lsls	r0, r0, #2
c0d0302c:	2101      	movs	r1, #1
c0d0302e:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d03030:	2045      	movs	r0, #69	; 0x45
c0d03032:	0080      	lsls	r0, r0, #2
c0d03034:	5820      	ldr	r0, [r4, r0]
c0d03036:	6880      	ldr	r0, [r0, #8]
c0d03038:	f7ff f854 	bl	c0d020e4 <pic>
c0d0303c:	4602      	mov	r2, r0
c0d0303e:	4620      	mov	r0, r4
c0d03040:	4629      	mov	r1, r5
c0d03042:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d03044:	4620      	mov	r0, r4
c0d03046:	f000 fa3f 	bl	c0d034c8 <USBD_CtlSendStatus>
  }

}
c0d0304a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0304c <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0304c:	b5b0      	push	{r4, r5, r7, lr}
c0d0304e:	af02      	add	r7, sp, #8
c0d03050:	460d      	mov	r5, r1
c0d03052:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d03054:	20fc      	movs	r0, #252	; 0xfc
c0d03056:	5c20      	ldrb	r0, [r4, r0]
c0d03058:	21fe      	movs	r1, #254	; 0xfe
c0d0305a:	4001      	ands	r1, r0
c0d0305c:	2902      	cmp	r1, #2
c0d0305e:	d114      	bne.n	c0d0308a <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d03060:	8868      	ldrh	r0, [r5, #2]
c0d03062:	2801      	cmp	r0, #1
c0d03064:	d119      	bne.n	c0d0309a <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d03066:	2041      	movs	r0, #65	; 0x41
c0d03068:	0080      	lsls	r0, r0, #2
c0d0306a:	2100      	movs	r1, #0
c0d0306c:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d0306e:	2045      	movs	r0, #69	; 0x45
c0d03070:	0080      	lsls	r0, r0, #2
c0d03072:	5820      	ldr	r0, [r4, r0]
c0d03074:	6880      	ldr	r0, [r0, #8]
c0d03076:	f7ff f835 	bl	c0d020e4 <pic>
c0d0307a:	4602      	mov	r2, r0
c0d0307c:	4620      	mov	r0, r4
c0d0307e:	4629      	mov	r1, r5
c0d03080:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d03082:	4620      	mov	r0, r4
c0d03084:	f000 fa20 	bl	c0d034c8 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d03088:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0308a:	2180      	movs	r1, #128	; 0x80
c0d0308c:	4620      	mov	r0, r4
c0d0308e:	f7ff fc31 	bl	c0d028f4 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d03092:	2100      	movs	r1, #0
c0d03094:	4620      	mov	r0, r4
c0d03096:	f7ff fc2d 	bl	c0d028f4 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d0309a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0309c <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d0309c:	b5d0      	push	{r4, r6, r7, lr}
c0d0309e:	af02      	add	r7, sp, #8
c0d030a0:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d030a2:	2180      	movs	r1, #128	; 0x80
c0d030a4:	f7ff fc26 	bl	c0d028f4 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d030a8:	2100      	movs	r1, #0
c0d030aa:	4620      	mov	r0, r4
c0d030ac:	f7ff fc22 	bl	c0d028f4 <USBD_LL_StallEP>
}
c0d030b0:	bdd0      	pop	{r4, r6, r7, pc}

c0d030b2 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d030b2:	b5b0      	push	{r4, r5, r7, lr}
c0d030b4:	af02      	add	r7, sp, #8
c0d030b6:	460d      	mov	r5, r1
c0d030b8:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d030ba:	20fc      	movs	r0, #252	; 0xfc
c0d030bc:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d030be:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d030c0:	2803      	cmp	r0, #3
c0d030c2:	d115      	bne.n	c0d030f0 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d030c4:	88a8      	ldrh	r0, [r5, #4]
c0d030c6:	22fe      	movs	r2, #254	; 0xfe
c0d030c8:	4002      	ands	r2, r0
c0d030ca:	2a01      	cmp	r2, #1
c0d030cc:	d810      	bhi.n	c0d030f0 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d030ce:	2045      	movs	r0, #69	; 0x45
c0d030d0:	0080      	lsls	r0, r0, #2
c0d030d2:	5820      	ldr	r0, [r4, r0]
c0d030d4:	6880      	ldr	r0, [r0, #8]
c0d030d6:	f7ff f805 	bl	c0d020e4 <pic>
c0d030da:	4602      	mov	r2, r0
c0d030dc:	4620      	mov	r0, r4
c0d030de:	4629      	mov	r1, r5
c0d030e0:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d030e2:	88e8      	ldrh	r0, [r5, #6]
c0d030e4:	2800      	cmp	r0, #0
c0d030e6:	d10a      	bne.n	c0d030fe <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d030e8:	4620      	mov	r0, r4
c0d030ea:	f000 f9ed 	bl	c0d034c8 <USBD_CtlSendStatus>
c0d030ee:	e006      	b.n	c0d030fe <USBD_StdItfReq+0x4c>
c0d030f0:	4620      	mov	r0, r4
c0d030f2:	f7ff fbff 	bl	c0d028f4 <USBD_LL_StallEP>
c0d030f6:	2100      	movs	r1, #0
c0d030f8:	4620      	mov	r0, r4
c0d030fa:	f7ff fbfb 	bl	c0d028f4 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d030fe:	2000      	movs	r0, #0
c0d03100:	bdb0      	pop	{r4, r5, r7, pc}

c0d03102 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d03102:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03104:	af03      	add	r7, sp, #12
c0d03106:	b081      	sub	sp, #4
c0d03108:	460e      	mov	r6, r1
c0d0310a:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d0310c:	7830      	ldrb	r0, [r6, #0]
c0d0310e:	2160      	movs	r1, #96	; 0x60
c0d03110:	4001      	ands	r1, r0
c0d03112:	2920      	cmp	r1, #32
c0d03114:	d10a      	bne.n	c0d0312c <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d03116:	2045      	movs	r0, #69	; 0x45
c0d03118:	0080      	lsls	r0, r0, #2
c0d0311a:	5820      	ldr	r0, [r4, r0]
c0d0311c:	6880      	ldr	r0, [r0, #8]
c0d0311e:	f7fe ffe1 	bl	c0d020e4 <pic>
c0d03122:	4602      	mov	r2, r0
c0d03124:	4620      	mov	r0, r4
c0d03126:	4631      	mov	r1, r6
c0d03128:	4790      	blx	r2
c0d0312a:	e063      	b.n	c0d031f4 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d0312c:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d0312e:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d03130:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d03132:	2800      	cmp	r0, #0
c0d03134:	d012      	beq.n	c0d0315c <USBD_StdEPReq+0x5a>
c0d03136:	2801      	cmp	r0, #1
c0d03138:	d019      	beq.n	c0d0316e <USBD_StdEPReq+0x6c>
c0d0313a:	2803      	cmp	r0, #3
c0d0313c:	d15a      	bne.n	c0d031f4 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d0313e:	20fc      	movs	r0, #252	; 0xfc
c0d03140:	5c20      	ldrb	r0, [r4, r0]
c0d03142:	2803      	cmp	r0, #3
c0d03144:	d117      	bne.n	c0d03176 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d03146:	8870      	ldrh	r0, [r6, #2]
c0d03148:	2800      	cmp	r0, #0
c0d0314a:	d12d      	bne.n	c0d031a8 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d0314c:	4329      	orrs	r1, r5
c0d0314e:	2980      	cmp	r1, #128	; 0x80
c0d03150:	d02a      	beq.n	c0d031a8 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d03152:	4620      	mov	r0, r4
c0d03154:	4629      	mov	r1, r5
c0d03156:	f7ff fbcd 	bl	c0d028f4 <USBD_LL_StallEP>
c0d0315a:	e025      	b.n	c0d031a8 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d0315c:	20fc      	movs	r0, #252	; 0xfc
c0d0315e:	5c20      	ldrb	r0, [r4, r0]
c0d03160:	2803      	cmp	r0, #3
c0d03162:	d02f      	beq.n	c0d031c4 <USBD_StdEPReq+0xc2>
c0d03164:	2802      	cmp	r0, #2
c0d03166:	d10e      	bne.n	c0d03186 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d03168:	0668      	lsls	r0, r5, #25
c0d0316a:	d109      	bne.n	c0d03180 <USBD_StdEPReq+0x7e>
c0d0316c:	e042      	b.n	c0d031f4 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d0316e:	20fc      	movs	r0, #252	; 0xfc
c0d03170:	5c20      	ldrb	r0, [r4, r0]
c0d03172:	2803      	cmp	r0, #3
c0d03174:	d00f      	beq.n	c0d03196 <USBD_StdEPReq+0x94>
c0d03176:	2802      	cmp	r0, #2
c0d03178:	d105      	bne.n	c0d03186 <USBD_StdEPReq+0x84>
c0d0317a:	4329      	orrs	r1, r5
c0d0317c:	2980      	cmp	r1, #128	; 0x80
c0d0317e:	d039      	beq.n	c0d031f4 <USBD_StdEPReq+0xf2>
c0d03180:	4620      	mov	r0, r4
c0d03182:	4629      	mov	r1, r5
c0d03184:	e004      	b.n	c0d03190 <USBD_StdEPReq+0x8e>
c0d03186:	4620      	mov	r0, r4
c0d03188:	f7ff fbb4 	bl	c0d028f4 <USBD_LL_StallEP>
c0d0318c:	2100      	movs	r1, #0
c0d0318e:	4620      	mov	r0, r4
c0d03190:	f7ff fbb0 	bl	c0d028f4 <USBD_LL_StallEP>
c0d03194:	e02e      	b.n	c0d031f4 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d03196:	8870      	ldrh	r0, [r6, #2]
c0d03198:	2800      	cmp	r0, #0
c0d0319a:	d12b      	bne.n	c0d031f4 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d0319c:	0668      	lsls	r0, r5, #25
c0d0319e:	d00d      	beq.n	c0d031bc <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d031a0:	4620      	mov	r0, r4
c0d031a2:	4629      	mov	r1, r5
c0d031a4:	f7ff fbcc 	bl	c0d02940 <USBD_LL_ClearStallEP>
c0d031a8:	2045      	movs	r0, #69	; 0x45
c0d031aa:	0080      	lsls	r0, r0, #2
c0d031ac:	5820      	ldr	r0, [r4, r0]
c0d031ae:	6880      	ldr	r0, [r0, #8]
c0d031b0:	f7fe ff98 	bl	c0d020e4 <pic>
c0d031b4:	4602      	mov	r2, r0
c0d031b6:	4620      	mov	r0, r4
c0d031b8:	4631      	mov	r1, r6
c0d031ba:	4790      	blx	r2
c0d031bc:	4620      	mov	r0, r4
c0d031be:	f000 f983 	bl	c0d034c8 <USBD_CtlSendStatus>
c0d031c2:	e017      	b.n	c0d031f4 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d031c4:	4626      	mov	r6, r4
c0d031c6:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d031c8:	4620      	mov	r0, r4
c0d031ca:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d031cc:	420d      	tst	r5, r1
c0d031ce:	d100      	bne.n	c0d031d2 <USBD_StdEPReq+0xd0>
c0d031d0:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d031d2:	4620      	mov	r0, r4
c0d031d4:	4629      	mov	r1, r5
c0d031d6:	f7ff fbd9 	bl	c0d0298c <USBD_LL_IsStallEP>
c0d031da:	2101      	movs	r1, #1
c0d031dc:	2800      	cmp	r0, #0
c0d031de:	d100      	bne.n	c0d031e2 <USBD_StdEPReq+0xe0>
c0d031e0:	4601      	mov	r1, r0
c0d031e2:	207f      	movs	r0, #127	; 0x7f
c0d031e4:	4005      	ands	r5, r0
c0d031e6:	0128      	lsls	r0, r5, #4
c0d031e8:	5031      	str	r1, [r6, r0]
c0d031ea:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d031ec:	2202      	movs	r2, #2
c0d031ee:	4620      	mov	r0, r4
c0d031f0:	f000 f93c 	bl	c0d0346c <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d031f4:	2000      	movs	r0, #0
c0d031f6:	b001      	add	sp, #4
c0d031f8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d031fa <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d031fa:	780a      	ldrb	r2, [r1, #0]
c0d031fc:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d031fe:	784a      	ldrb	r2, [r1, #1]
c0d03200:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d03202:	788a      	ldrb	r2, [r1, #2]
c0d03204:	78cb      	ldrb	r3, [r1, #3]
c0d03206:	021b      	lsls	r3, r3, #8
c0d03208:	4313      	orrs	r3, r2
c0d0320a:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d0320c:	790a      	ldrb	r2, [r1, #4]
c0d0320e:	794b      	ldrb	r3, [r1, #5]
c0d03210:	021b      	lsls	r3, r3, #8
c0d03212:	4313      	orrs	r3, r2
c0d03214:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d03216:	798a      	ldrb	r2, [r1, #6]
c0d03218:	79c9      	ldrb	r1, [r1, #7]
c0d0321a:	0209      	lsls	r1, r1, #8
c0d0321c:	4311      	orrs	r1, r2
c0d0321e:	80c1      	strh	r1, [r0, #6]

}
c0d03220:	4770      	bx	lr

c0d03222 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d03222:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03224:	af03      	add	r7, sp, #12
c0d03226:	b083      	sub	sp, #12
c0d03228:	460d      	mov	r5, r1
c0d0322a:	4604      	mov	r4, r0
c0d0322c:	a802      	add	r0, sp, #8
c0d0322e:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d03230:	8006      	strh	r6, [r0, #0]
c0d03232:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d03234:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d03236:	7829      	ldrb	r1, [r5, #0]
c0d03238:	2060      	movs	r0, #96	; 0x60
c0d0323a:	4008      	ands	r0, r1
c0d0323c:	2800      	cmp	r0, #0
c0d0323e:	d010      	beq.n	c0d03262 <USBD_HID_Setup+0x40>
c0d03240:	2820      	cmp	r0, #32
c0d03242:	d139      	bne.n	c0d032b8 <USBD_HID_Setup+0x96>
c0d03244:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d03246:	4601      	mov	r1, r0
c0d03248:	390a      	subs	r1, #10
c0d0324a:	2902      	cmp	r1, #2
c0d0324c:	d334      	bcc.n	c0d032b8 <USBD_HID_Setup+0x96>
c0d0324e:	2802      	cmp	r0, #2
c0d03250:	d01c      	beq.n	c0d0328c <USBD_HID_Setup+0x6a>
c0d03252:	2803      	cmp	r0, #3
c0d03254:	d01a      	beq.n	c0d0328c <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d03256:	4620      	mov	r0, r4
c0d03258:	4629      	mov	r1, r5
c0d0325a:	f7ff ff1f 	bl	c0d0309c <USBD_CtlError>
c0d0325e:	2602      	movs	r6, #2
c0d03260:	e02a      	b.n	c0d032b8 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d03262:	7868      	ldrb	r0, [r5, #1]
c0d03264:	280b      	cmp	r0, #11
c0d03266:	d014      	beq.n	c0d03292 <USBD_HID_Setup+0x70>
c0d03268:	280a      	cmp	r0, #10
c0d0326a:	d00f      	beq.n	c0d0328c <USBD_HID_Setup+0x6a>
c0d0326c:	2806      	cmp	r0, #6
c0d0326e:	d123      	bne.n	c0d032b8 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d03270:	8868      	ldrh	r0, [r5, #2]
c0d03272:	0a00      	lsrs	r0, r0, #8
c0d03274:	2600      	movs	r6, #0
c0d03276:	2821      	cmp	r0, #33	; 0x21
c0d03278:	d00f      	beq.n	c0d0329a <USBD_HID_Setup+0x78>
c0d0327a:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d0327c:	4632      	mov	r2, r6
c0d0327e:	4631      	mov	r1, r6
c0d03280:	d117      	bne.n	c0d032b2 <USBD_HID_Setup+0x90>
c0d03282:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d03284:	9000      	str	r0, [sp, #0]
c0d03286:	f000 f847 	bl	c0d03318 <USBD_HID_GetReportDescriptor_impl>
c0d0328a:	e00a      	b.n	c0d032a2 <USBD_HID_Setup+0x80>
c0d0328c:	a901      	add	r1, sp, #4
c0d0328e:	2201      	movs	r2, #1
c0d03290:	e00f      	b.n	c0d032b2 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d03292:	4620      	mov	r0, r4
c0d03294:	f000 f918 	bl	c0d034c8 <USBD_CtlSendStatus>
c0d03298:	e00e      	b.n	c0d032b8 <USBD_HID_Setup+0x96>
c0d0329a:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d0329c:	9000      	str	r0, [sp, #0]
c0d0329e:	f000 f833 	bl	c0d03308 <USBD_HID_GetHidDescriptor_impl>
c0d032a2:	9b00      	ldr	r3, [sp, #0]
c0d032a4:	4601      	mov	r1, r0
c0d032a6:	881a      	ldrh	r2, [r3, #0]
c0d032a8:	88e8      	ldrh	r0, [r5, #6]
c0d032aa:	4282      	cmp	r2, r0
c0d032ac:	d300      	bcc.n	c0d032b0 <USBD_HID_Setup+0x8e>
c0d032ae:	4602      	mov	r2, r0
c0d032b0:	801a      	strh	r2, [r3, #0]
c0d032b2:	4620      	mov	r0, r4
c0d032b4:	f000 f8da 	bl	c0d0346c <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d032b8:	b2f0      	uxtb	r0, r6
c0d032ba:	b003      	add	sp, #12
c0d032bc:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d032be <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d032be:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d032c0:	af03      	add	r7, sp, #12
c0d032c2:	b081      	sub	sp, #4
c0d032c4:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d032c6:	2182      	movs	r1, #130	; 0x82
c0d032c8:	2502      	movs	r5, #2
c0d032ca:	2640      	movs	r6, #64	; 0x40
c0d032cc:	462a      	mov	r2, r5
c0d032ce:	4633      	mov	r3, r6
c0d032d0:	f7ff fad0 	bl	c0d02874 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d032d4:	4620      	mov	r0, r4
c0d032d6:	4629      	mov	r1, r5
c0d032d8:	462a      	mov	r2, r5
c0d032da:	4633      	mov	r3, r6
c0d032dc:	f7ff faca 	bl	c0d02874 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d032e0:	4620      	mov	r0, r4
c0d032e2:	4629      	mov	r1, r5
c0d032e4:	4632      	mov	r2, r6
c0d032e6:	f7ff fb90 	bl	c0d02a0a <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d032ea:	2000      	movs	r0, #0
c0d032ec:	b001      	add	sp, #4
c0d032ee:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d032f0 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d032f0:	b5d0      	push	{r4, r6, r7, lr}
c0d032f2:	af02      	add	r7, sp, #8
c0d032f4:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d032f6:	2182      	movs	r1, #130	; 0x82
c0d032f8:	f7ff fae4 	bl	c0d028c4 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d032fc:	2102      	movs	r1, #2
c0d032fe:	4620      	mov	r0, r4
c0d03300:	f7ff fae0 	bl	c0d028c4 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d03304:	2000      	movs	r0, #0
c0d03306:	bdd0      	pop	{r4, r6, r7, pc}

c0d03308 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d03308:	2109      	movs	r1, #9
c0d0330a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d0330c:	4801      	ldr	r0, [pc, #4]	; (c0d03314 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d0330e:	4478      	add	r0, pc
c0d03310:	4770      	bx	lr
c0d03312:	46c0      	nop			; (mov r8, r8)
c0d03314:	00000b22 	.word	0x00000b22

c0d03318 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d03318:	2122      	movs	r1, #34	; 0x22
c0d0331a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d0331c:	4801      	ldr	r0, [pc, #4]	; (c0d03324 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d0331e:	4478      	add	r0, pc
c0d03320:	4770      	bx	lr
c0d03322:	46c0      	nop			; (mov r8, r8)
c0d03324:	00000aed 	.word	0x00000aed

c0d03328 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d03328:	b5b0      	push	{r4, r5, r7, lr}
c0d0332a:	af02      	add	r7, sp, #8
c0d0332c:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d0332e:	2102      	movs	r1, #2
c0d03330:	2240      	movs	r2, #64	; 0x40
c0d03332:	f7ff fb6a 	bl	c0d02a0a <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d03336:	4d0d      	ldr	r5, [pc, #52]	; (c0d0336c <USBD_HID_DataOut_impl+0x44>)
c0d03338:	7828      	ldrb	r0, [r5, #0]
c0d0333a:	2800      	cmp	r0, #0
c0d0333c:	d113      	bne.n	c0d03366 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d0333e:	2002      	movs	r0, #2
c0d03340:	f7fe f936 	bl	c0d015b0 <io_seproxyhal_get_ep_rx_size>
c0d03344:	4602      	mov	r2, r0
c0d03346:	480d      	ldr	r0, [pc, #52]	; (c0d0337c <USBD_HID_DataOut_impl+0x54>)
c0d03348:	4478      	add	r0, pc
c0d0334a:	4621      	mov	r1, r4
c0d0334c:	f7fd ff94 	bl	c0d01278 <io_usb_hid_receive>
c0d03350:	2802      	cmp	r0, #2
c0d03352:	d108      	bne.n	c0d03366 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d03354:	2001      	movs	r0, #1
c0d03356:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d03358:	4805      	ldr	r0, [pc, #20]	; (c0d03370 <USBD_HID_DataOut_impl+0x48>)
c0d0335a:	2107      	movs	r1, #7
c0d0335c:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d0335e:	4805      	ldr	r0, [pc, #20]	; (c0d03374 <USBD_HID_DataOut_impl+0x4c>)
c0d03360:	6800      	ldr	r0, [r0, #0]
c0d03362:	4905      	ldr	r1, [pc, #20]	; (c0d03378 <USBD_HID_DataOut_impl+0x50>)
c0d03364:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d03366:	2000      	movs	r0, #0
c0d03368:	bdb0      	pop	{r4, r5, r7, pc}
c0d0336a:	46c0      	nop			; (mov r8, r8)
c0d0336c:	20001cd4 	.word	0x20001cd4
c0d03370:	20001cdc 	.word	0x20001cdc
c0d03374:	20001bc4 	.word	0x20001bc4
c0d03378:	20001ce0 	.word	0x20001ce0
c0d0337c:	ffffe3bd 	.word	0xffffe3bd

c0d03380 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d03380:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03382:	af03      	add	r7, sp, #12
c0d03384:	b081      	sub	sp, #4
c0d03386:	4604      	mov	r4, r0
c0d03388:	2049      	movs	r0, #73	; 0x49
c0d0338a:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d0338c:	4810      	ldr	r0, [pc, #64]	; (c0d033d0 <USB_power+0x50>)
c0d0338e:	2100      	movs	r1, #0
c0d03390:	462a      	mov	r2, r5
c0d03392:	f7fe f81d 	bl	c0d013d0 <os_memset>

  if (enabled) {
c0d03396:	2c00      	cmp	r4, #0
c0d03398:	d015      	beq.n	c0d033c6 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d0339a:	4c0d      	ldr	r4, [pc, #52]	; (c0d033d0 <USB_power+0x50>)
c0d0339c:	2600      	movs	r6, #0
c0d0339e:	4620      	mov	r0, r4
c0d033a0:	4631      	mov	r1, r6
c0d033a2:	462a      	mov	r2, r5
c0d033a4:	f7fe f814 	bl	c0d013d0 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d033a8:	490a      	ldr	r1, [pc, #40]	; (c0d033d4 <USB_power+0x54>)
c0d033aa:	4479      	add	r1, pc
c0d033ac:	4620      	mov	r0, r4
c0d033ae:	4632      	mov	r2, r6
c0d033b0:	f7ff fb3f 	bl	c0d02a32 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d033b4:	4908      	ldr	r1, [pc, #32]	; (c0d033d8 <USB_power+0x58>)
c0d033b6:	4479      	add	r1, pc
c0d033b8:	4620      	mov	r0, r4
c0d033ba:	f7ff fb72 	bl	c0d02aa2 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d033be:	4620      	mov	r0, r4
c0d033c0:	f7ff fb78 	bl	c0d02ab4 <USBD_Start>
c0d033c4:	e002      	b.n	c0d033cc <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d033c6:	4802      	ldr	r0, [pc, #8]	; (c0d033d0 <USB_power+0x50>)
c0d033c8:	f7ff fb51 	bl	c0d02a6e <USBD_DeInit>
  }
}
c0d033cc:	b001      	add	sp, #4
c0d033ce:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d033d0:	20001d24 	.word	0x20001d24
c0d033d4:	00000aa2 	.word	0x00000aa2
c0d033d8:	00000ad2 	.word	0x00000ad2

c0d033dc <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d033dc:	2012      	movs	r0, #18
c0d033de:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d033e0:	4801      	ldr	r0, [pc, #4]	; (c0d033e8 <USBD_DeviceDescriptor+0xc>)
c0d033e2:	4478      	add	r0, pc
c0d033e4:	4770      	bx	lr
c0d033e6:	46c0      	nop			; (mov r8, r8)
c0d033e8:	00000a57 	.word	0x00000a57

c0d033ec <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d033ec:	2004      	movs	r0, #4
c0d033ee:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d033f0:	4801      	ldr	r0, [pc, #4]	; (c0d033f8 <USBD_LangIDStrDescriptor+0xc>)
c0d033f2:	4478      	add	r0, pc
c0d033f4:	4770      	bx	lr
c0d033f6:	46c0      	nop			; (mov r8, r8)
c0d033f8:	00000a7a 	.word	0x00000a7a

c0d033fc <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d033fc:	200e      	movs	r0, #14
c0d033fe:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d03400:	4801      	ldr	r0, [pc, #4]	; (c0d03408 <USBD_ManufacturerStrDescriptor+0xc>)
c0d03402:	4478      	add	r0, pc
c0d03404:	4770      	bx	lr
c0d03406:	46c0      	nop			; (mov r8, r8)
c0d03408:	00000a6e 	.word	0x00000a6e

c0d0340c <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d0340c:	200e      	movs	r0, #14
c0d0340e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d03410:	4801      	ldr	r0, [pc, #4]	; (c0d03418 <USBD_ProductStrDescriptor+0xc>)
c0d03412:	4478      	add	r0, pc
c0d03414:	4770      	bx	lr
c0d03416:	46c0      	nop			; (mov r8, r8)
c0d03418:	000009eb 	.word	0x000009eb

c0d0341c <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d0341c:	200a      	movs	r0, #10
c0d0341e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d03420:	4801      	ldr	r0, [pc, #4]	; (c0d03428 <USBD_SerialStrDescriptor+0xc>)
c0d03422:	4478      	add	r0, pc
c0d03424:	4770      	bx	lr
c0d03426:	46c0      	nop			; (mov r8, r8)
c0d03428:	00000a5c 	.word	0x00000a5c

c0d0342c <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d0342c:	200e      	movs	r0, #14
c0d0342e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d03430:	4801      	ldr	r0, [pc, #4]	; (c0d03438 <USBD_ConfigStrDescriptor+0xc>)
c0d03432:	4478      	add	r0, pc
c0d03434:	4770      	bx	lr
c0d03436:	46c0      	nop			; (mov r8, r8)
c0d03438:	000009cb 	.word	0x000009cb

c0d0343c <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d0343c:	200e      	movs	r0, #14
c0d0343e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d03440:	4801      	ldr	r0, [pc, #4]	; (c0d03448 <USBD_InterfaceStrDescriptor+0xc>)
c0d03442:	4478      	add	r0, pc
c0d03444:	4770      	bx	lr
c0d03446:	46c0      	nop			; (mov r8, r8)
c0d03448:	000009bb 	.word	0x000009bb

c0d0344c <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d0344c:	2129      	movs	r1, #41	; 0x29
c0d0344e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d03450:	4801      	ldr	r0, [pc, #4]	; (c0d03458 <USBD_GetCfgDesc_impl+0xc>)
c0d03452:	4478      	add	r0, pc
c0d03454:	4770      	bx	lr
c0d03456:	46c0      	nop			; (mov r8, r8)
c0d03458:	00000a6e 	.word	0x00000a6e

c0d0345c <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d0345c:	210a      	movs	r1, #10
c0d0345e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d03460:	4801      	ldr	r0, [pc, #4]	; (c0d03468 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d03462:	4478      	add	r0, pc
c0d03464:	4770      	bx	lr
c0d03466:	46c0      	nop			; (mov r8, r8)
c0d03468:	00000a8a 	.word	0x00000a8a

c0d0346c <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d0346c:	b5b0      	push	{r4, r5, r7, lr}
c0d0346e:	af02      	add	r7, sp, #8
c0d03470:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d03472:	21f4      	movs	r1, #244	; 0xf4
c0d03474:	2302      	movs	r3, #2
c0d03476:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d03478:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d0347a:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d0347c:	2109      	movs	r1, #9
c0d0347e:	0149      	lsls	r1, r1, #5
c0d03480:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d03482:	6a01      	ldr	r1, [r0, #32]
c0d03484:	428a      	cmp	r2, r1
c0d03486:	d300      	bcc.n	c0d0348a <USBD_CtlSendData+0x1e>
c0d03488:	460a      	mov	r2, r1
c0d0348a:	b293      	uxth	r3, r2
c0d0348c:	2500      	movs	r5, #0
c0d0348e:	4629      	mov	r1, r5
c0d03490:	4622      	mov	r2, r4
c0d03492:	f7ff faa0 	bl	c0d029d6 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03496:	4628      	mov	r0, r5
c0d03498:	bdb0      	pop	{r4, r5, r7, pc}

c0d0349a <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d0349a:	b5b0      	push	{r4, r5, r7, lr}
c0d0349c:	af02      	add	r7, sp, #8
c0d0349e:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d034a0:	6a01      	ldr	r1, [r0, #32]
c0d034a2:	428a      	cmp	r2, r1
c0d034a4:	d300      	bcc.n	c0d034a8 <USBD_CtlContinueSendData+0xe>
c0d034a6:	460a      	mov	r2, r1
c0d034a8:	b293      	uxth	r3, r2
c0d034aa:	2500      	movs	r5, #0
c0d034ac:	4629      	mov	r1, r5
c0d034ae:	4622      	mov	r2, r4
c0d034b0:	f7ff fa91 	bl	c0d029d6 <USBD_LL_Transmit>
  return USBD_OK;
c0d034b4:	4628      	mov	r0, r5
c0d034b6:	bdb0      	pop	{r4, r5, r7, pc}

c0d034b8 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d034b8:	b5d0      	push	{r4, r6, r7, lr}
c0d034ba:	af02      	add	r7, sp, #8
c0d034bc:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d034be:	4621      	mov	r1, r4
c0d034c0:	f7ff faa3 	bl	c0d02a0a <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d034c4:	4620      	mov	r0, r4
c0d034c6:	bdd0      	pop	{r4, r6, r7, pc}

c0d034c8 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d034c8:	b5d0      	push	{r4, r6, r7, lr}
c0d034ca:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d034cc:	21f4      	movs	r1, #244	; 0xf4
c0d034ce:	2204      	movs	r2, #4
c0d034d0:	5042      	str	r2, [r0, r1]
c0d034d2:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d034d4:	4621      	mov	r1, r4
c0d034d6:	4622      	mov	r2, r4
c0d034d8:	4623      	mov	r3, r4
c0d034da:	f7ff fa7c 	bl	c0d029d6 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d034de:	4620      	mov	r0, r4
c0d034e0:	bdd0      	pop	{r4, r6, r7, pc}

c0d034e2 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d034e2:	b5d0      	push	{r4, r6, r7, lr}
c0d034e4:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d034e6:	21f4      	movs	r1, #244	; 0xf4
c0d034e8:	2205      	movs	r2, #5
c0d034ea:	5042      	str	r2, [r0, r1]
c0d034ec:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d034ee:	4621      	mov	r1, r4
c0d034f0:	4622      	mov	r2, r4
c0d034f2:	f7ff fa8a 	bl	c0d02a0a <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d034f6:	4620      	mov	r0, r4
c0d034f8:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d034fc <__aeabi_uidiv>:
c0d034fc:	2200      	movs	r2, #0
c0d034fe:	0843      	lsrs	r3, r0, #1
c0d03500:	428b      	cmp	r3, r1
c0d03502:	d374      	bcc.n	c0d035ee <__aeabi_uidiv+0xf2>
c0d03504:	0903      	lsrs	r3, r0, #4
c0d03506:	428b      	cmp	r3, r1
c0d03508:	d35f      	bcc.n	c0d035ca <__aeabi_uidiv+0xce>
c0d0350a:	0a03      	lsrs	r3, r0, #8
c0d0350c:	428b      	cmp	r3, r1
c0d0350e:	d344      	bcc.n	c0d0359a <__aeabi_uidiv+0x9e>
c0d03510:	0b03      	lsrs	r3, r0, #12
c0d03512:	428b      	cmp	r3, r1
c0d03514:	d328      	bcc.n	c0d03568 <__aeabi_uidiv+0x6c>
c0d03516:	0c03      	lsrs	r3, r0, #16
c0d03518:	428b      	cmp	r3, r1
c0d0351a:	d30d      	bcc.n	c0d03538 <__aeabi_uidiv+0x3c>
c0d0351c:	22ff      	movs	r2, #255	; 0xff
c0d0351e:	0209      	lsls	r1, r1, #8
c0d03520:	ba12      	rev	r2, r2
c0d03522:	0c03      	lsrs	r3, r0, #16
c0d03524:	428b      	cmp	r3, r1
c0d03526:	d302      	bcc.n	c0d0352e <__aeabi_uidiv+0x32>
c0d03528:	1212      	asrs	r2, r2, #8
c0d0352a:	0209      	lsls	r1, r1, #8
c0d0352c:	d065      	beq.n	c0d035fa <__aeabi_uidiv+0xfe>
c0d0352e:	0b03      	lsrs	r3, r0, #12
c0d03530:	428b      	cmp	r3, r1
c0d03532:	d319      	bcc.n	c0d03568 <__aeabi_uidiv+0x6c>
c0d03534:	e000      	b.n	c0d03538 <__aeabi_uidiv+0x3c>
c0d03536:	0a09      	lsrs	r1, r1, #8
c0d03538:	0bc3      	lsrs	r3, r0, #15
c0d0353a:	428b      	cmp	r3, r1
c0d0353c:	d301      	bcc.n	c0d03542 <__aeabi_uidiv+0x46>
c0d0353e:	03cb      	lsls	r3, r1, #15
c0d03540:	1ac0      	subs	r0, r0, r3
c0d03542:	4152      	adcs	r2, r2
c0d03544:	0b83      	lsrs	r3, r0, #14
c0d03546:	428b      	cmp	r3, r1
c0d03548:	d301      	bcc.n	c0d0354e <__aeabi_uidiv+0x52>
c0d0354a:	038b      	lsls	r3, r1, #14
c0d0354c:	1ac0      	subs	r0, r0, r3
c0d0354e:	4152      	adcs	r2, r2
c0d03550:	0b43      	lsrs	r3, r0, #13
c0d03552:	428b      	cmp	r3, r1
c0d03554:	d301      	bcc.n	c0d0355a <__aeabi_uidiv+0x5e>
c0d03556:	034b      	lsls	r3, r1, #13
c0d03558:	1ac0      	subs	r0, r0, r3
c0d0355a:	4152      	adcs	r2, r2
c0d0355c:	0b03      	lsrs	r3, r0, #12
c0d0355e:	428b      	cmp	r3, r1
c0d03560:	d301      	bcc.n	c0d03566 <__aeabi_uidiv+0x6a>
c0d03562:	030b      	lsls	r3, r1, #12
c0d03564:	1ac0      	subs	r0, r0, r3
c0d03566:	4152      	adcs	r2, r2
c0d03568:	0ac3      	lsrs	r3, r0, #11
c0d0356a:	428b      	cmp	r3, r1
c0d0356c:	d301      	bcc.n	c0d03572 <__aeabi_uidiv+0x76>
c0d0356e:	02cb      	lsls	r3, r1, #11
c0d03570:	1ac0      	subs	r0, r0, r3
c0d03572:	4152      	adcs	r2, r2
c0d03574:	0a83      	lsrs	r3, r0, #10
c0d03576:	428b      	cmp	r3, r1
c0d03578:	d301      	bcc.n	c0d0357e <__aeabi_uidiv+0x82>
c0d0357a:	028b      	lsls	r3, r1, #10
c0d0357c:	1ac0      	subs	r0, r0, r3
c0d0357e:	4152      	adcs	r2, r2
c0d03580:	0a43      	lsrs	r3, r0, #9
c0d03582:	428b      	cmp	r3, r1
c0d03584:	d301      	bcc.n	c0d0358a <__aeabi_uidiv+0x8e>
c0d03586:	024b      	lsls	r3, r1, #9
c0d03588:	1ac0      	subs	r0, r0, r3
c0d0358a:	4152      	adcs	r2, r2
c0d0358c:	0a03      	lsrs	r3, r0, #8
c0d0358e:	428b      	cmp	r3, r1
c0d03590:	d301      	bcc.n	c0d03596 <__aeabi_uidiv+0x9a>
c0d03592:	020b      	lsls	r3, r1, #8
c0d03594:	1ac0      	subs	r0, r0, r3
c0d03596:	4152      	adcs	r2, r2
c0d03598:	d2cd      	bcs.n	c0d03536 <__aeabi_uidiv+0x3a>
c0d0359a:	09c3      	lsrs	r3, r0, #7
c0d0359c:	428b      	cmp	r3, r1
c0d0359e:	d301      	bcc.n	c0d035a4 <__aeabi_uidiv+0xa8>
c0d035a0:	01cb      	lsls	r3, r1, #7
c0d035a2:	1ac0      	subs	r0, r0, r3
c0d035a4:	4152      	adcs	r2, r2
c0d035a6:	0983      	lsrs	r3, r0, #6
c0d035a8:	428b      	cmp	r3, r1
c0d035aa:	d301      	bcc.n	c0d035b0 <__aeabi_uidiv+0xb4>
c0d035ac:	018b      	lsls	r3, r1, #6
c0d035ae:	1ac0      	subs	r0, r0, r3
c0d035b0:	4152      	adcs	r2, r2
c0d035b2:	0943      	lsrs	r3, r0, #5
c0d035b4:	428b      	cmp	r3, r1
c0d035b6:	d301      	bcc.n	c0d035bc <__aeabi_uidiv+0xc0>
c0d035b8:	014b      	lsls	r3, r1, #5
c0d035ba:	1ac0      	subs	r0, r0, r3
c0d035bc:	4152      	adcs	r2, r2
c0d035be:	0903      	lsrs	r3, r0, #4
c0d035c0:	428b      	cmp	r3, r1
c0d035c2:	d301      	bcc.n	c0d035c8 <__aeabi_uidiv+0xcc>
c0d035c4:	010b      	lsls	r3, r1, #4
c0d035c6:	1ac0      	subs	r0, r0, r3
c0d035c8:	4152      	adcs	r2, r2
c0d035ca:	08c3      	lsrs	r3, r0, #3
c0d035cc:	428b      	cmp	r3, r1
c0d035ce:	d301      	bcc.n	c0d035d4 <__aeabi_uidiv+0xd8>
c0d035d0:	00cb      	lsls	r3, r1, #3
c0d035d2:	1ac0      	subs	r0, r0, r3
c0d035d4:	4152      	adcs	r2, r2
c0d035d6:	0883      	lsrs	r3, r0, #2
c0d035d8:	428b      	cmp	r3, r1
c0d035da:	d301      	bcc.n	c0d035e0 <__aeabi_uidiv+0xe4>
c0d035dc:	008b      	lsls	r3, r1, #2
c0d035de:	1ac0      	subs	r0, r0, r3
c0d035e0:	4152      	adcs	r2, r2
c0d035e2:	0843      	lsrs	r3, r0, #1
c0d035e4:	428b      	cmp	r3, r1
c0d035e6:	d301      	bcc.n	c0d035ec <__aeabi_uidiv+0xf0>
c0d035e8:	004b      	lsls	r3, r1, #1
c0d035ea:	1ac0      	subs	r0, r0, r3
c0d035ec:	4152      	adcs	r2, r2
c0d035ee:	1a41      	subs	r1, r0, r1
c0d035f0:	d200      	bcs.n	c0d035f4 <__aeabi_uidiv+0xf8>
c0d035f2:	4601      	mov	r1, r0
c0d035f4:	4152      	adcs	r2, r2
c0d035f6:	4610      	mov	r0, r2
c0d035f8:	4770      	bx	lr
c0d035fa:	e7ff      	b.n	c0d035fc <__aeabi_uidiv+0x100>
c0d035fc:	b501      	push	{r0, lr}
c0d035fe:	2000      	movs	r0, #0
c0d03600:	f000 f8f0 	bl	c0d037e4 <__aeabi_idiv0>
c0d03604:	bd02      	pop	{r1, pc}
c0d03606:	46c0      	nop			; (mov r8, r8)

c0d03608 <__aeabi_uidivmod>:
c0d03608:	2900      	cmp	r1, #0
c0d0360a:	d0f7      	beq.n	c0d035fc <__aeabi_uidiv+0x100>
c0d0360c:	e776      	b.n	c0d034fc <__aeabi_uidiv>
c0d0360e:	4770      	bx	lr

c0d03610 <__aeabi_idiv>:
c0d03610:	4603      	mov	r3, r0
c0d03612:	430b      	orrs	r3, r1
c0d03614:	d47f      	bmi.n	c0d03716 <__aeabi_idiv+0x106>
c0d03616:	2200      	movs	r2, #0
c0d03618:	0843      	lsrs	r3, r0, #1
c0d0361a:	428b      	cmp	r3, r1
c0d0361c:	d374      	bcc.n	c0d03708 <__aeabi_idiv+0xf8>
c0d0361e:	0903      	lsrs	r3, r0, #4
c0d03620:	428b      	cmp	r3, r1
c0d03622:	d35f      	bcc.n	c0d036e4 <__aeabi_idiv+0xd4>
c0d03624:	0a03      	lsrs	r3, r0, #8
c0d03626:	428b      	cmp	r3, r1
c0d03628:	d344      	bcc.n	c0d036b4 <__aeabi_idiv+0xa4>
c0d0362a:	0b03      	lsrs	r3, r0, #12
c0d0362c:	428b      	cmp	r3, r1
c0d0362e:	d328      	bcc.n	c0d03682 <__aeabi_idiv+0x72>
c0d03630:	0c03      	lsrs	r3, r0, #16
c0d03632:	428b      	cmp	r3, r1
c0d03634:	d30d      	bcc.n	c0d03652 <__aeabi_idiv+0x42>
c0d03636:	22ff      	movs	r2, #255	; 0xff
c0d03638:	0209      	lsls	r1, r1, #8
c0d0363a:	ba12      	rev	r2, r2
c0d0363c:	0c03      	lsrs	r3, r0, #16
c0d0363e:	428b      	cmp	r3, r1
c0d03640:	d302      	bcc.n	c0d03648 <__aeabi_idiv+0x38>
c0d03642:	1212      	asrs	r2, r2, #8
c0d03644:	0209      	lsls	r1, r1, #8
c0d03646:	d065      	beq.n	c0d03714 <__aeabi_idiv+0x104>
c0d03648:	0b03      	lsrs	r3, r0, #12
c0d0364a:	428b      	cmp	r3, r1
c0d0364c:	d319      	bcc.n	c0d03682 <__aeabi_idiv+0x72>
c0d0364e:	e000      	b.n	c0d03652 <__aeabi_idiv+0x42>
c0d03650:	0a09      	lsrs	r1, r1, #8
c0d03652:	0bc3      	lsrs	r3, r0, #15
c0d03654:	428b      	cmp	r3, r1
c0d03656:	d301      	bcc.n	c0d0365c <__aeabi_idiv+0x4c>
c0d03658:	03cb      	lsls	r3, r1, #15
c0d0365a:	1ac0      	subs	r0, r0, r3
c0d0365c:	4152      	adcs	r2, r2
c0d0365e:	0b83      	lsrs	r3, r0, #14
c0d03660:	428b      	cmp	r3, r1
c0d03662:	d301      	bcc.n	c0d03668 <__aeabi_idiv+0x58>
c0d03664:	038b      	lsls	r3, r1, #14
c0d03666:	1ac0      	subs	r0, r0, r3
c0d03668:	4152      	adcs	r2, r2
c0d0366a:	0b43      	lsrs	r3, r0, #13
c0d0366c:	428b      	cmp	r3, r1
c0d0366e:	d301      	bcc.n	c0d03674 <__aeabi_idiv+0x64>
c0d03670:	034b      	lsls	r3, r1, #13
c0d03672:	1ac0      	subs	r0, r0, r3
c0d03674:	4152      	adcs	r2, r2
c0d03676:	0b03      	lsrs	r3, r0, #12
c0d03678:	428b      	cmp	r3, r1
c0d0367a:	d301      	bcc.n	c0d03680 <__aeabi_idiv+0x70>
c0d0367c:	030b      	lsls	r3, r1, #12
c0d0367e:	1ac0      	subs	r0, r0, r3
c0d03680:	4152      	adcs	r2, r2
c0d03682:	0ac3      	lsrs	r3, r0, #11
c0d03684:	428b      	cmp	r3, r1
c0d03686:	d301      	bcc.n	c0d0368c <__aeabi_idiv+0x7c>
c0d03688:	02cb      	lsls	r3, r1, #11
c0d0368a:	1ac0      	subs	r0, r0, r3
c0d0368c:	4152      	adcs	r2, r2
c0d0368e:	0a83      	lsrs	r3, r0, #10
c0d03690:	428b      	cmp	r3, r1
c0d03692:	d301      	bcc.n	c0d03698 <__aeabi_idiv+0x88>
c0d03694:	028b      	lsls	r3, r1, #10
c0d03696:	1ac0      	subs	r0, r0, r3
c0d03698:	4152      	adcs	r2, r2
c0d0369a:	0a43      	lsrs	r3, r0, #9
c0d0369c:	428b      	cmp	r3, r1
c0d0369e:	d301      	bcc.n	c0d036a4 <__aeabi_idiv+0x94>
c0d036a0:	024b      	lsls	r3, r1, #9
c0d036a2:	1ac0      	subs	r0, r0, r3
c0d036a4:	4152      	adcs	r2, r2
c0d036a6:	0a03      	lsrs	r3, r0, #8
c0d036a8:	428b      	cmp	r3, r1
c0d036aa:	d301      	bcc.n	c0d036b0 <__aeabi_idiv+0xa0>
c0d036ac:	020b      	lsls	r3, r1, #8
c0d036ae:	1ac0      	subs	r0, r0, r3
c0d036b0:	4152      	adcs	r2, r2
c0d036b2:	d2cd      	bcs.n	c0d03650 <__aeabi_idiv+0x40>
c0d036b4:	09c3      	lsrs	r3, r0, #7
c0d036b6:	428b      	cmp	r3, r1
c0d036b8:	d301      	bcc.n	c0d036be <__aeabi_idiv+0xae>
c0d036ba:	01cb      	lsls	r3, r1, #7
c0d036bc:	1ac0      	subs	r0, r0, r3
c0d036be:	4152      	adcs	r2, r2
c0d036c0:	0983      	lsrs	r3, r0, #6
c0d036c2:	428b      	cmp	r3, r1
c0d036c4:	d301      	bcc.n	c0d036ca <__aeabi_idiv+0xba>
c0d036c6:	018b      	lsls	r3, r1, #6
c0d036c8:	1ac0      	subs	r0, r0, r3
c0d036ca:	4152      	adcs	r2, r2
c0d036cc:	0943      	lsrs	r3, r0, #5
c0d036ce:	428b      	cmp	r3, r1
c0d036d0:	d301      	bcc.n	c0d036d6 <__aeabi_idiv+0xc6>
c0d036d2:	014b      	lsls	r3, r1, #5
c0d036d4:	1ac0      	subs	r0, r0, r3
c0d036d6:	4152      	adcs	r2, r2
c0d036d8:	0903      	lsrs	r3, r0, #4
c0d036da:	428b      	cmp	r3, r1
c0d036dc:	d301      	bcc.n	c0d036e2 <__aeabi_idiv+0xd2>
c0d036de:	010b      	lsls	r3, r1, #4
c0d036e0:	1ac0      	subs	r0, r0, r3
c0d036e2:	4152      	adcs	r2, r2
c0d036e4:	08c3      	lsrs	r3, r0, #3
c0d036e6:	428b      	cmp	r3, r1
c0d036e8:	d301      	bcc.n	c0d036ee <__aeabi_idiv+0xde>
c0d036ea:	00cb      	lsls	r3, r1, #3
c0d036ec:	1ac0      	subs	r0, r0, r3
c0d036ee:	4152      	adcs	r2, r2
c0d036f0:	0883      	lsrs	r3, r0, #2
c0d036f2:	428b      	cmp	r3, r1
c0d036f4:	d301      	bcc.n	c0d036fa <__aeabi_idiv+0xea>
c0d036f6:	008b      	lsls	r3, r1, #2
c0d036f8:	1ac0      	subs	r0, r0, r3
c0d036fa:	4152      	adcs	r2, r2
c0d036fc:	0843      	lsrs	r3, r0, #1
c0d036fe:	428b      	cmp	r3, r1
c0d03700:	d301      	bcc.n	c0d03706 <__aeabi_idiv+0xf6>
c0d03702:	004b      	lsls	r3, r1, #1
c0d03704:	1ac0      	subs	r0, r0, r3
c0d03706:	4152      	adcs	r2, r2
c0d03708:	1a41      	subs	r1, r0, r1
c0d0370a:	d200      	bcs.n	c0d0370e <__aeabi_idiv+0xfe>
c0d0370c:	4601      	mov	r1, r0
c0d0370e:	4152      	adcs	r2, r2
c0d03710:	4610      	mov	r0, r2
c0d03712:	4770      	bx	lr
c0d03714:	e05d      	b.n	c0d037d2 <__aeabi_idiv+0x1c2>
c0d03716:	0fca      	lsrs	r2, r1, #31
c0d03718:	d000      	beq.n	c0d0371c <__aeabi_idiv+0x10c>
c0d0371a:	4249      	negs	r1, r1
c0d0371c:	1003      	asrs	r3, r0, #32
c0d0371e:	d300      	bcc.n	c0d03722 <__aeabi_idiv+0x112>
c0d03720:	4240      	negs	r0, r0
c0d03722:	4053      	eors	r3, r2
c0d03724:	2200      	movs	r2, #0
c0d03726:	469c      	mov	ip, r3
c0d03728:	0903      	lsrs	r3, r0, #4
c0d0372a:	428b      	cmp	r3, r1
c0d0372c:	d32d      	bcc.n	c0d0378a <__aeabi_idiv+0x17a>
c0d0372e:	0a03      	lsrs	r3, r0, #8
c0d03730:	428b      	cmp	r3, r1
c0d03732:	d312      	bcc.n	c0d0375a <__aeabi_idiv+0x14a>
c0d03734:	22fc      	movs	r2, #252	; 0xfc
c0d03736:	0189      	lsls	r1, r1, #6
c0d03738:	ba12      	rev	r2, r2
c0d0373a:	0a03      	lsrs	r3, r0, #8
c0d0373c:	428b      	cmp	r3, r1
c0d0373e:	d30c      	bcc.n	c0d0375a <__aeabi_idiv+0x14a>
c0d03740:	0189      	lsls	r1, r1, #6
c0d03742:	1192      	asrs	r2, r2, #6
c0d03744:	428b      	cmp	r3, r1
c0d03746:	d308      	bcc.n	c0d0375a <__aeabi_idiv+0x14a>
c0d03748:	0189      	lsls	r1, r1, #6
c0d0374a:	1192      	asrs	r2, r2, #6
c0d0374c:	428b      	cmp	r3, r1
c0d0374e:	d304      	bcc.n	c0d0375a <__aeabi_idiv+0x14a>
c0d03750:	0189      	lsls	r1, r1, #6
c0d03752:	d03a      	beq.n	c0d037ca <__aeabi_idiv+0x1ba>
c0d03754:	1192      	asrs	r2, r2, #6
c0d03756:	e000      	b.n	c0d0375a <__aeabi_idiv+0x14a>
c0d03758:	0989      	lsrs	r1, r1, #6
c0d0375a:	09c3      	lsrs	r3, r0, #7
c0d0375c:	428b      	cmp	r3, r1
c0d0375e:	d301      	bcc.n	c0d03764 <__aeabi_idiv+0x154>
c0d03760:	01cb      	lsls	r3, r1, #7
c0d03762:	1ac0      	subs	r0, r0, r3
c0d03764:	4152      	adcs	r2, r2
c0d03766:	0983      	lsrs	r3, r0, #6
c0d03768:	428b      	cmp	r3, r1
c0d0376a:	d301      	bcc.n	c0d03770 <__aeabi_idiv+0x160>
c0d0376c:	018b      	lsls	r3, r1, #6
c0d0376e:	1ac0      	subs	r0, r0, r3
c0d03770:	4152      	adcs	r2, r2
c0d03772:	0943      	lsrs	r3, r0, #5
c0d03774:	428b      	cmp	r3, r1
c0d03776:	d301      	bcc.n	c0d0377c <__aeabi_idiv+0x16c>
c0d03778:	014b      	lsls	r3, r1, #5
c0d0377a:	1ac0      	subs	r0, r0, r3
c0d0377c:	4152      	adcs	r2, r2
c0d0377e:	0903      	lsrs	r3, r0, #4
c0d03780:	428b      	cmp	r3, r1
c0d03782:	d301      	bcc.n	c0d03788 <__aeabi_idiv+0x178>
c0d03784:	010b      	lsls	r3, r1, #4
c0d03786:	1ac0      	subs	r0, r0, r3
c0d03788:	4152      	adcs	r2, r2
c0d0378a:	08c3      	lsrs	r3, r0, #3
c0d0378c:	428b      	cmp	r3, r1
c0d0378e:	d301      	bcc.n	c0d03794 <__aeabi_idiv+0x184>
c0d03790:	00cb      	lsls	r3, r1, #3
c0d03792:	1ac0      	subs	r0, r0, r3
c0d03794:	4152      	adcs	r2, r2
c0d03796:	0883      	lsrs	r3, r0, #2
c0d03798:	428b      	cmp	r3, r1
c0d0379a:	d301      	bcc.n	c0d037a0 <__aeabi_idiv+0x190>
c0d0379c:	008b      	lsls	r3, r1, #2
c0d0379e:	1ac0      	subs	r0, r0, r3
c0d037a0:	4152      	adcs	r2, r2
c0d037a2:	d2d9      	bcs.n	c0d03758 <__aeabi_idiv+0x148>
c0d037a4:	0843      	lsrs	r3, r0, #1
c0d037a6:	428b      	cmp	r3, r1
c0d037a8:	d301      	bcc.n	c0d037ae <__aeabi_idiv+0x19e>
c0d037aa:	004b      	lsls	r3, r1, #1
c0d037ac:	1ac0      	subs	r0, r0, r3
c0d037ae:	4152      	adcs	r2, r2
c0d037b0:	1a41      	subs	r1, r0, r1
c0d037b2:	d200      	bcs.n	c0d037b6 <__aeabi_idiv+0x1a6>
c0d037b4:	4601      	mov	r1, r0
c0d037b6:	4663      	mov	r3, ip
c0d037b8:	4152      	adcs	r2, r2
c0d037ba:	105b      	asrs	r3, r3, #1
c0d037bc:	4610      	mov	r0, r2
c0d037be:	d301      	bcc.n	c0d037c4 <__aeabi_idiv+0x1b4>
c0d037c0:	4240      	negs	r0, r0
c0d037c2:	2b00      	cmp	r3, #0
c0d037c4:	d500      	bpl.n	c0d037c8 <__aeabi_idiv+0x1b8>
c0d037c6:	4249      	negs	r1, r1
c0d037c8:	4770      	bx	lr
c0d037ca:	4663      	mov	r3, ip
c0d037cc:	105b      	asrs	r3, r3, #1
c0d037ce:	d300      	bcc.n	c0d037d2 <__aeabi_idiv+0x1c2>
c0d037d0:	4240      	negs	r0, r0
c0d037d2:	b501      	push	{r0, lr}
c0d037d4:	2000      	movs	r0, #0
c0d037d6:	f000 f805 	bl	c0d037e4 <__aeabi_idiv0>
c0d037da:	bd02      	pop	{r1, pc}

c0d037dc <__aeabi_idivmod>:
c0d037dc:	2900      	cmp	r1, #0
c0d037de:	d0f8      	beq.n	c0d037d2 <__aeabi_idiv+0x1c2>
c0d037e0:	e716      	b.n	c0d03610 <__aeabi_idiv>
c0d037e2:	4770      	bx	lr

c0d037e4 <__aeabi_idiv0>:
c0d037e4:	4770      	bx	lr
c0d037e6:	46c0      	nop			; (mov r8, r8)

c0d037e8 <__aeabi_uldivmod>:
c0d037e8:	2b00      	cmp	r3, #0
c0d037ea:	d111      	bne.n	c0d03810 <__aeabi_uldivmod+0x28>
c0d037ec:	2a00      	cmp	r2, #0
c0d037ee:	d10f      	bne.n	c0d03810 <__aeabi_uldivmod+0x28>
c0d037f0:	2900      	cmp	r1, #0
c0d037f2:	d100      	bne.n	c0d037f6 <__aeabi_uldivmod+0xe>
c0d037f4:	2800      	cmp	r0, #0
c0d037f6:	d002      	beq.n	c0d037fe <__aeabi_uldivmod+0x16>
c0d037f8:	2100      	movs	r1, #0
c0d037fa:	43c9      	mvns	r1, r1
c0d037fc:	1c08      	adds	r0, r1, #0
c0d037fe:	b407      	push	{r0, r1, r2}
c0d03800:	4802      	ldr	r0, [pc, #8]	; (c0d0380c <__aeabi_uldivmod+0x24>)
c0d03802:	a102      	add	r1, pc, #8	; (adr r1, c0d0380c <__aeabi_uldivmod+0x24>)
c0d03804:	1840      	adds	r0, r0, r1
c0d03806:	9002      	str	r0, [sp, #8]
c0d03808:	bd03      	pop	{r0, r1, pc}
c0d0380a:	46c0      	nop			; (mov r8, r8)
c0d0380c:	ffffffd9 	.word	0xffffffd9
c0d03810:	b403      	push	{r0, r1}
c0d03812:	4668      	mov	r0, sp
c0d03814:	b501      	push	{r0, lr}
c0d03816:	9802      	ldr	r0, [sp, #8]
c0d03818:	f000 f806 	bl	c0d03828 <__udivmoddi4>
c0d0381c:	9b01      	ldr	r3, [sp, #4]
c0d0381e:	469e      	mov	lr, r3
c0d03820:	b002      	add	sp, #8
c0d03822:	bc0c      	pop	{r2, r3}
c0d03824:	4770      	bx	lr
c0d03826:	46c0      	nop			; (mov r8, r8)

c0d03828 <__udivmoddi4>:
c0d03828:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0382a:	464d      	mov	r5, r9
c0d0382c:	4656      	mov	r6, sl
c0d0382e:	4644      	mov	r4, r8
c0d03830:	465f      	mov	r7, fp
c0d03832:	b4f0      	push	{r4, r5, r6, r7}
c0d03834:	4692      	mov	sl, r2
c0d03836:	b083      	sub	sp, #12
c0d03838:	0004      	movs	r4, r0
c0d0383a:	000d      	movs	r5, r1
c0d0383c:	4699      	mov	r9, r3
c0d0383e:	428b      	cmp	r3, r1
c0d03840:	d82f      	bhi.n	c0d038a2 <__udivmoddi4+0x7a>
c0d03842:	d02c      	beq.n	c0d0389e <__udivmoddi4+0x76>
c0d03844:	4649      	mov	r1, r9
c0d03846:	4650      	mov	r0, sl
c0d03848:	f000 f8ae 	bl	c0d039a8 <__clzdi2>
c0d0384c:	0029      	movs	r1, r5
c0d0384e:	0006      	movs	r6, r0
c0d03850:	0020      	movs	r0, r4
c0d03852:	f000 f8a9 	bl	c0d039a8 <__clzdi2>
c0d03856:	1a33      	subs	r3, r6, r0
c0d03858:	4698      	mov	r8, r3
c0d0385a:	3b20      	subs	r3, #32
c0d0385c:	469b      	mov	fp, r3
c0d0385e:	d500      	bpl.n	c0d03862 <__udivmoddi4+0x3a>
c0d03860:	e074      	b.n	c0d0394c <__udivmoddi4+0x124>
c0d03862:	4653      	mov	r3, sl
c0d03864:	465a      	mov	r2, fp
c0d03866:	4093      	lsls	r3, r2
c0d03868:	001f      	movs	r7, r3
c0d0386a:	4653      	mov	r3, sl
c0d0386c:	4642      	mov	r2, r8
c0d0386e:	4093      	lsls	r3, r2
c0d03870:	001e      	movs	r6, r3
c0d03872:	42af      	cmp	r7, r5
c0d03874:	d829      	bhi.n	c0d038ca <__udivmoddi4+0xa2>
c0d03876:	d026      	beq.n	c0d038c6 <__udivmoddi4+0x9e>
c0d03878:	465b      	mov	r3, fp
c0d0387a:	1ba4      	subs	r4, r4, r6
c0d0387c:	41bd      	sbcs	r5, r7
c0d0387e:	2b00      	cmp	r3, #0
c0d03880:	da00      	bge.n	c0d03884 <__udivmoddi4+0x5c>
c0d03882:	e079      	b.n	c0d03978 <__udivmoddi4+0x150>
c0d03884:	2200      	movs	r2, #0
c0d03886:	2300      	movs	r3, #0
c0d03888:	9200      	str	r2, [sp, #0]
c0d0388a:	9301      	str	r3, [sp, #4]
c0d0388c:	2301      	movs	r3, #1
c0d0388e:	465a      	mov	r2, fp
c0d03890:	4093      	lsls	r3, r2
c0d03892:	9301      	str	r3, [sp, #4]
c0d03894:	2301      	movs	r3, #1
c0d03896:	4642      	mov	r2, r8
c0d03898:	4093      	lsls	r3, r2
c0d0389a:	9300      	str	r3, [sp, #0]
c0d0389c:	e019      	b.n	c0d038d2 <__udivmoddi4+0xaa>
c0d0389e:	4282      	cmp	r2, r0
c0d038a0:	d9d0      	bls.n	c0d03844 <__udivmoddi4+0x1c>
c0d038a2:	2200      	movs	r2, #0
c0d038a4:	2300      	movs	r3, #0
c0d038a6:	9200      	str	r2, [sp, #0]
c0d038a8:	9301      	str	r3, [sp, #4]
c0d038aa:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d038ac:	2b00      	cmp	r3, #0
c0d038ae:	d001      	beq.n	c0d038b4 <__udivmoddi4+0x8c>
c0d038b0:	601c      	str	r4, [r3, #0]
c0d038b2:	605d      	str	r5, [r3, #4]
c0d038b4:	9800      	ldr	r0, [sp, #0]
c0d038b6:	9901      	ldr	r1, [sp, #4]
c0d038b8:	b003      	add	sp, #12
c0d038ba:	bc3c      	pop	{r2, r3, r4, r5}
c0d038bc:	4690      	mov	r8, r2
c0d038be:	4699      	mov	r9, r3
c0d038c0:	46a2      	mov	sl, r4
c0d038c2:	46ab      	mov	fp, r5
c0d038c4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d038c6:	42a3      	cmp	r3, r4
c0d038c8:	d9d6      	bls.n	c0d03878 <__udivmoddi4+0x50>
c0d038ca:	2200      	movs	r2, #0
c0d038cc:	2300      	movs	r3, #0
c0d038ce:	9200      	str	r2, [sp, #0]
c0d038d0:	9301      	str	r3, [sp, #4]
c0d038d2:	4643      	mov	r3, r8
c0d038d4:	2b00      	cmp	r3, #0
c0d038d6:	d0e8      	beq.n	c0d038aa <__udivmoddi4+0x82>
c0d038d8:	07fb      	lsls	r3, r7, #31
c0d038da:	0872      	lsrs	r2, r6, #1
c0d038dc:	431a      	orrs	r2, r3
c0d038de:	4646      	mov	r6, r8
c0d038e0:	087b      	lsrs	r3, r7, #1
c0d038e2:	e00e      	b.n	c0d03902 <__udivmoddi4+0xda>
c0d038e4:	42ab      	cmp	r3, r5
c0d038e6:	d101      	bne.n	c0d038ec <__udivmoddi4+0xc4>
c0d038e8:	42a2      	cmp	r2, r4
c0d038ea:	d80c      	bhi.n	c0d03906 <__udivmoddi4+0xde>
c0d038ec:	1aa4      	subs	r4, r4, r2
c0d038ee:	419d      	sbcs	r5, r3
c0d038f0:	2001      	movs	r0, #1
c0d038f2:	1924      	adds	r4, r4, r4
c0d038f4:	416d      	adcs	r5, r5
c0d038f6:	2100      	movs	r1, #0
c0d038f8:	3e01      	subs	r6, #1
c0d038fa:	1824      	adds	r4, r4, r0
c0d038fc:	414d      	adcs	r5, r1
c0d038fe:	2e00      	cmp	r6, #0
c0d03900:	d006      	beq.n	c0d03910 <__udivmoddi4+0xe8>
c0d03902:	42ab      	cmp	r3, r5
c0d03904:	d9ee      	bls.n	c0d038e4 <__udivmoddi4+0xbc>
c0d03906:	3e01      	subs	r6, #1
c0d03908:	1924      	adds	r4, r4, r4
c0d0390a:	416d      	adcs	r5, r5
c0d0390c:	2e00      	cmp	r6, #0
c0d0390e:	d1f8      	bne.n	c0d03902 <__udivmoddi4+0xda>
c0d03910:	465b      	mov	r3, fp
c0d03912:	9800      	ldr	r0, [sp, #0]
c0d03914:	9901      	ldr	r1, [sp, #4]
c0d03916:	1900      	adds	r0, r0, r4
c0d03918:	4169      	adcs	r1, r5
c0d0391a:	2b00      	cmp	r3, #0
c0d0391c:	db22      	blt.n	c0d03964 <__udivmoddi4+0x13c>
c0d0391e:	002b      	movs	r3, r5
c0d03920:	465a      	mov	r2, fp
c0d03922:	40d3      	lsrs	r3, r2
c0d03924:	002a      	movs	r2, r5
c0d03926:	4644      	mov	r4, r8
c0d03928:	40e2      	lsrs	r2, r4
c0d0392a:	001c      	movs	r4, r3
c0d0392c:	465b      	mov	r3, fp
c0d0392e:	0015      	movs	r5, r2
c0d03930:	2b00      	cmp	r3, #0
c0d03932:	db2c      	blt.n	c0d0398e <__udivmoddi4+0x166>
c0d03934:	0026      	movs	r6, r4
c0d03936:	409e      	lsls	r6, r3
c0d03938:	0033      	movs	r3, r6
c0d0393a:	0026      	movs	r6, r4
c0d0393c:	4647      	mov	r7, r8
c0d0393e:	40be      	lsls	r6, r7
c0d03940:	0032      	movs	r2, r6
c0d03942:	1a80      	subs	r0, r0, r2
c0d03944:	4199      	sbcs	r1, r3
c0d03946:	9000      	str	r0, [sp, #0]
c0d03948:	9101      	str	r1, [sp, #4]
c0d0394a:	e7ae      	b.n	c0d038aa <__udivmoddi4+0x82>
c0d0394c:	4642      	mov	r2, r8
c0d0394e:	2320      	movs	r3, #32
c0d03950:	1a9b      	subs	r3, r3, r2
c0d03952:	4652      	mov	r2, sl
c0d03954:	40da      	lsrs	r2, r3
c0d03956:	4641      	mov	r1, r8
c0d03958:	0013      	movs	r3, r2
c0d0395a:	464a      	mov	r2, r9
c0d0395c:	408a      	lsls	r2, r1
c0d0395e:	0017      	movs	r7, r2
c0d03960:	431f      	orrs	r7, r3
c0d03962:	e782      	b.n	c0d0386a <__udivmoddi4+0x42>
c0d03964:	4642      	mov	r2, r8
c0d03966:	2320      	movs	r3, #32
c0d03968:	1a9b      	subs	r3, r3, r2
c0d0396a:	002a      	movs	r2, r5
c0d0396c:	4646      	mov	r6, r8
c0d0396e:	409a      	lsls	r2, r3
c0d03970:	0023      	movs	r3, r4
c0d03972:	40f3      	lsrs	r3, r6
c0d03974:	4313      	orrs	r3, r2
c0d03976:	e7d5      	b.n	c0d03924 <__udivmoddi4+0xfc>
c0d03978:	4642      	mov	r2, r8
c0d0397a:	2320      	movs	r3, #32
c0d0397c:	2100      	movs	r1, #0
c0d0397e:	1a9b      	subs	r3, r3, r2
c0d03980:	2200      	movs	r2, #0
c0d03982:	9100      	str	r1, [sp, #0]
c0d03984:	9201      	str	r2, [sp, #4]
c0d03986:	2201      	movs	r2, #1
c0d03988:	40da      	lsrs	r2, r3
c0d0398a:	9201      	str	r2, [sp, #4]
c0d0398c:	e782      	b.n	c0d03894 <__udivmoddi4+0x6c>
c0d0398e:	4642      	mov	r2, r8
c0d03990:	2320      	movs	r3, #32
c0d03992:	0026      	movs	r6, r4
c0d03994:	1a9b      	subs	r3, r3, r2
c0d03996:	40de      	lsrs	r6, r3
c0d03998:	002f      	movs	r7, r5
c0d0399a:	46b4      	mov	ip, r6
c0d0399c:	4097      	lsls	r7, r2
c0d0399e:	4666      	mov	r6, ip
c0d039a0:	003b      	movs	r3, r7
c0d039a2:	4333      	orrs	r3, r6
c0d039a4:	e7c9      	b.n	c0d0393a <__udivmoddi4+0x112>
c0d039a6:	46c0      	nop			; (mov r8, r8)

c0d039a8 <__clzdi2>:
c0d039a8:	b510      	push	{r4, lr}
c0d039aa:	2900      	cmp	r1, #0
c0d039ac:	d103      	bne.n	c0d039b6 <__clzdi2+0xe>
c0d039ae:	f000 f807 	bl	c0d039c0 <__clzsi2>
c0d039b2:	3020      	adds	r0, #32
c0d039b4:	e002      	b.n	c0d039bc <__clzdi2+0x14>
c0d039b6:	1c08      	adds	r0, r1, #0
c0d039b8:	f000 f802 	bl	c0d039c0 <__clzsi2>
c0d039bc:	bd10      	pop	{r4, pc}
c0d039be:	46c0      	nop			; (mov r8, r8)

c0d039c0 <__clzsi2>:
c0d039c0:	211c      	movs	r1, #28
c0d039c2:	2301      	movs	r3, #1
c0d039c4:	041b      	lsls	r3, r3, #16
c0d039c6:	4298      	cmp	r0, r3
c0d039c8:	d301      	bcc.n	c0d039ce <__clzsi2+0xe>
c0d039ca:	0c00      	lsrs	r0, r0, #16
c0d039cc:	3910      	subs	r1, #16
c0d039ce:	0a1b      	lsrs	r3, r3, #8
c0d039d0:	4298      	cmp	r0, r3
c0d039d2:	d301      	bcc.n	c0d039d8 <__clzsi2+0x18>
c0d039d4:	0a00      	lsrs	r0, r0, #8
c0d039d6:	3908      	subs	r1, #8
c0d039d8:	091b      	lsrs	r3, r3, #4
c0d039da:	4298      	cmp	r0, r3
c0d039dc:	d301      	bcc.n	c0d039e2 <__clzsi2+0x22>
c0d039de:	0900      	lsrs	r0, r0, #4
c0d039e0:	3904      	subs	r1, #4
c0d039e2:	a202      	add	r2, pc, #8	; (adr r2, c0d039ec <__clzsi2+0x2c>)
c0d039e4:	5c10      	ldrb	r0, [r2, r0]
c0d039e6:	1840      	adds	r0, r0, r1
c0d039e8:	4770      	bx	lr
c0d039ea:	46c0      	nop			; (mov r8, r8)
c0d039ec:	02020304 	.word	0x02020304
c0d039f0:	01010101 	.word	0x01010101
	...

c0d039fc <__aeabi_memclr>:
c0d039fc:	b510      	push	{r4, lr}
c0d039fe:	2200      	movs	r2, #0
c0d03a00:	f000 f806 	bl	c0d03a10 <__aeabi_memset>
c0d03a04:	bd10      	pop	{r4, pc}
c0d03a06:	46c0      	nop			; (mov r8, r8)

c0d03a08 <__aeabi_memcpy>:
c0d03a08:	b510      	push	{r4, lr}
c0d03a0a:	f000 f809 	bl	c0d03a20 <memcpy>
c0d03a0e:	bd10      	pop	{r4, pc}

c0d03a10 <__aeabi_memset>:
c0d03a10:	0013      	movs	r3, r2
c0d03a12:	b510      	push	{r4, lr}
c0d03a14:	000a      	movs	r2, r1
c0d03a16:	0019      	movs	r1, r3
c0d03a18:	f000 f840 	bl	c0d03a9c <memset>
c0d03a1c:	bd10      	pop	{r4, pc}
c0d03a1e:	46c0      	nop			; (mov r8, r8)

c0d03a20 <memcpy>:
c0d03a20:	b570      	push	{r4, r5, r6, lr}
c0d03a22:	2a0f      	cmp	r2, #15
c0d03a24:	d932      	bls.n	c0d03a8c <memcpy+0x6c>
c0d03a26:	000c      	movs	r4, r1
c0d03a28:	4304      	orrs	r4, r0
c0d03a2a:	000b      	movs	r3, r1
c0d03a2c:	07a4      	lsls	r4, r4, #30
c0d03a2e:	d131      	bne.n	c0d03a94 <memcpy+0x74>
c0d03a30:	0015      	movs	r5, r2
c0d03a32:	0004      	movs	r4, r0
c0d03a34:	3d10      	subs	r5, #16
c0d03a36:	092d      	lsrs	r5, r5, #4
c0d03a38:	3501      	adds	r5, #1
c0d03a3a:	012d      	lsls	r5, r5, #4
c0d03a3c:	1949      	adds	r1, r1, r5
c0d03a3e:	681e      	ldr	r6, [r3, #0]
c0d03a40:	6026      	str	r6, [r4, #0]
c0d03a42:	685e      	ldr	r6, [r3, #4]
c0d03a44:	6066      	str	r6, [r4, #4]
c0d03a46:	689e      	ldr	r6, [r3, #8]
c0d03a48:	60a6      	str	r6, [r4, #8]
c0d03a4a:	68de      	ldr	r6, [r3, #12]
c0d03a4c:	3310      	adds	r3, #16
c0d03a4e:	60e6      	str	r6, [r4, #12]
c0d03a50:	3410      	adds	r4, #16
c0d03a52:	4299      	cmp	r1, r3
c0d03a54:	d1f3      	bne.n	c0d03a3e <memcpy+0x1e>
c0d03a56:	230f      	movs	r3, #15
c0d03a58:	1945      	adds	r5, r0, r5
c0d03a5a:	4013      	ands	r3, r2
c0d03a5c:	2b03      	cmp	r3, #3
c0d03a5e:	d91b      	bls.n	c0d03a98 <memcpy+0x78>
c0d03a60:	1f1c      	subs	r4, r3, #4
c0d03a62:	2300      	movs	r3, #0
c0d03a64:	08a4      	lsrs	r4, r4, #2
c0d03a66:	3401      	adds	r4, #1
c0d03a68:	00a4      	lsls	r4, r4, #2
c0d03a6a:	58ce      	ldr	r6, [r1, r3]
c0d03a6c:	50ee      	str	r6, [r5, r3]
c0d03a6e:	3304      	adds	r3, #4
c0d03a70:	429c      	cmp	r4, r3
c0d03a72:	d1fa      	bne.n	c0d03a6a <memcpy+0x4a>
c0d03a74:	2303      	movs	r3, #3
c0d03a76:	192d      	adds	r5, r5, r4
c0d03a78:	1909      	adds	r1, r1, r4
c0d03a7a:	401a      	ands	r2, r3
c0d03a7c:	d005      	beq.n	c0d03a8a <memcpy+0x6a>
c0d03a7e:	2300      	movs	r3, #0
c0d03a80:	5ccc      	ldrb	r4, [r1, r3]
c0d03a82:	54ec      	strb	r4, [r5, r3]
c0d03a84:	3301      	adds	r3, #1
c0d03a86:	429a      	cmp	r2, r3
c0d03a88:	d1fa      	bne.n	c0d03a80 <memcpy+0x60>
c0d03a8a:	bd70      	pop	{r4, r5, r6, pc}
c0d03a8c:	0005      	movs	r5, r0
c0d03a8e:	2a00      	cmp	r2, #0
c0d03a90:	d1f5      	bne.n	c0d03a7e <memcpy+0x5e>
c0d03a92:	e7fa      	b.n	c0d03a8a <memcpy+0x6a>
c0d03a94:	0005      	movs	r5, r0
c0d03a96:	e7f2      	b.n	c0d03a7e <memcpy+0x5e>
c0d03a98:	001a      	movs	r2, r3
c0d03a9a:	e7f8      	b.n	c0d03a8e <memcpy+0x6e>

c0d03a9c <memset>:
c0d03a9c:	b570      	push	{r4, r5, r6, lr}
c0d03a9e:	0783      	lsls	r3, r0, #30
c0d03aa0:	d03f      	beq.n	c0d03b22 <memset+0x86>
c0d03aa2:	1e54      	subs	r4, r2, #1
c0d03aa4:	2a00      	cmp	r2, #0
c0d03aa6:	d03b      	beq.n	c0d03b20 <memset+0x84>
c0d03aa8:	b2ce      	uxtb	r6, r1
c0d03aaa:	0003      	movs	r3, r0
c0d03aac:	2503      	movs	r5, #3
c0d03aae:	e003      	b.n	c0d03ab8 <memset+0x1c>
c0d03ab0:	1e62      	subs	r2, r4, #1
c0d03ab2:	2c00      	cmp	r4, #0
c0d03ab4:	d034      	beq.n	c0d03b20 <memset+0x84>
c0d03ab6:	0014      	movs	r4, r2
c0d03ab8:	3301      	adds	r3, #1
c0d03aba:	1e5a      	subs	r2, r3, #1
c0d03abc:	7016      	strb	r6, [r2, #0]
c0d03abe:	422b      	tst	r3, r5
c0d03ac0:	d1f6      	bne.n	c0d03ab0 <memset+0x14>
c0d03ac2:	2c03      	cmp	r4, #3
c0d03ac4:	d924      	bls.n	c0d03b10 <memset+0x74>
c0d03ac6:	25ff      	movs	r5, #255	; 0xff
c0d03ac8:	400d      	ands	r5, r1
c0d03aca:	022a      	lsls	r2, r5, #8
c0d03acc:	4315      	orrs	r5, r2
c0d03ace:	042a      	lsls	r2, r5, #16
c0d03ad0:	4315      	orrs	r5, r2
c0d03ad2:	2c0f      	cmp	r4, #15
c0d03ad4:	d911      	bls.n	c0d03afa <memset+0x5e>
c0d03ad6:	0026      	movs	r6, r4
c0d03ad8:	3e10      	subs	r6, #16
c0d03ada:	0936      	lsrs	r6, r6, #4
c0d03adc:	3601      	adds	r6, #1
c0d03ade:	0136      	lsls	r6, r6, #4
c0d03ae0:	001a      	movs	r2, r3
c0d03ae2:	199b      	adds	r3, r3, r6
c0d03ae4:	6015      	str	r5, [r2, #0]
c0d03ae6:	6055      	str	r5, [r2, #4]
c0d03ae8:	6095      	str	r5, [r2, #8]
c0d03aea:	60d5      	str	r5, [r2, #12]
c0d03aec:	3210      	adds	r2, #16
c0d03aee:	4293      	cmp	r3, r2
c0d03af0:	d1f8      	bne.n	c0d03ae4 <memset+0x48>
c0d03af2:	220f      	movs	r2, #15
c0d03af4:	4014      	ands	r4, r2
c0d03af6:	2c03      	cmp	r4, #3
c0d03af8:	d90a      	bls.n	c0d03b10 <memset+0x74>
c0d03afa:	1f26      	subs	r6, r4, #4
c0d03afc:	08b6      	lsrs	r6, r6, #2
c0d03afe:	3601      	adds	r6, #1
c0d03b00:	00b6      	lsls	r6, r6, #2
c0d03b02:	001a      	movs	r2, r3
c0d03b04:	199b      	adds	r3, r3, r6
c0d03b06:	c220      	stmia	r2!, {r5}
c0d03b08:	4293      	cmp	r3, r2
c0d03b0a:	d1fc      	bne.n	c0d03b06 <memset+0x6a>
c0d03b0c:	2203      	movs	r2, #3
c0d03b0e:	4014      	ands	r4, r2
c0d03b10:	2c00      	cmp	r4, #0
c0d03b12:	d005      	beq.n	c0d03b20 <memset+0x84>
c0d03b14:	b2c9      	uxtb	r1, r1
c0d03b16:	191c      	adds	r4, r3, r4
c0d03b18:	7019      	strb	r1, [r3, #0]
c0d03b1a:	3301      	adds	r3, #1
c0d03b1c:	429c      	cmp	r4, r3
c0d03b1e:	d1fb      	bne.n	c0d03b18 <memset+0x7c>
c0d03b20:	bd70      	pop	{r4, r5, r6, pc}
c0d03b22:	0014      	movs	r4, r2
c0d03b24:	0003      	movs	r3, r0
c0d03b26:	e7cc      	b.n	c0d03ac2 <memset+0x26>

c0d03b28 <setjmp>:
c0d03b28:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d03b2a:	4641      	mov	r1, r8
c0d03b2c:	464a      	mov	r2, r9
c0d03b2e:	4653      	mov	r3, sl
c0d03b30:	465c      	mov	r4, fp
c0d03b32:	466d      	mov	r5, sp
c0d03b34:	4676      	mov	r6, lr
c0d03b36:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d03b38:	3828      	subs	r0, #40	; 0x28
c0d03b3a:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03b3c:	2000      	movs	r0, #0
c0d03b3e:	4770      	bx	lr

c0d03b40 <longjmp>:
c0d03b40:	3010      	adds	r0, #16
c0d03b42:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03b44:	4690      	mov	r8, r2
c0d03b46:	4699      	mov	r9, r3
c0d03b48:	46a2      	mov	sl, r4
c0d03b4a:	46ab      	mov	fp, r5
c0d03b4c:	46b5      	mov	sp, r6
c0d03b4e:	c808      	ldmia	r0!, {r3}
c0d03b50:	3828      	subs	r0, #40	; 0x28
c0d03b52:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03b54:	1c08      	adds	r0, r1, #0
c0d03b56:	d100      	bne.n	c0d03b5a <longjmp+0x1a>
c0d03b58:	2001      	movs	r0, #1
c0d03b5a:	4718      	bx	r3

c0d03b5c <strlen>:
c0d03b5c:	b510      	push	{r4, lr}
c0d03b5e:	0783      	lsls	r3, r0, #30
c0d03b60:	d027      	beq.n	c0d03bb2 <strlen+0x56>
c0d03b62:	7803      	ldrb	r3, [r0, #0]
c0d03b64:	2b00      	cmp	r3, #0
c0d03b66:	d026      	beq.n	c0d03bb6 <strlen+0x5a>
c0d03b68:	0003      	movs	r3, r0
c0d03b6a:	2103      	movs	r1, #3
c0d03b6c:	e002      	b.n	c0d03b74 <strlen+0x18>
c0d03b6e:	781a      	ldrb	r2, [r3, #0]
c0d03b70:	2a00      	cmp	r2, #0
c0d03b72:	d01c      	beq.n	c0d03bae <strlen+0x52>
c0d03b74:	3301      	adds	r3, #1
c0d03b76:	420b      	tst	r3, r1
c0d03b78:	d1f9      	bne.n	c0d03b6e <strlen+0x12>
c0d03b7a:	6819      	ldr	r1, [r3, #0]
c0d03b7c:	4a0f      	ldr	r2, [pc, #60]	; (c0d03bbc <strlen+0x60>)
c0d03b7e:	4c10      	ldr	r4, [pc, #64]	; (c0d03bc0 <strlen+0x64>)
c0d03b80:	188a      	adds	r2, r1, r2
c0d03b82:	438a      	bics	r2, r1
c0d03b84:	4222      	tst	r2, r4
c0d03b86:	d10f      	bne.n	c0d03ba8 <strlen+0x4c>
c0d03b88:	3304      	adds	r3, #4
c0d03b8a:	6819      	ldr	r1, [r3, #0]
c0d03b8c:	4a0b      	ldr	r2, [pc, #44]	; (c0d03bbc <strlen+0x60>)
c0d03b8e:	188a      	adds	r2, r1, r2
c0d03b90:	438a      	bics	r2, r1
c0d03b92:	4222      	tst	r2, r4
c0d03b94:	d108      	bne.n	c0d03ba8 <strlen+0x4c>
c0d03b96:	3304      	adds	r3, #4
c0d03b98:	6819      	ldr	r1, [r3, #0]
c0d03b9a:	4a08      	ldr	r2, [pc, #32]	; (c0d03bbc <strlen+0x60>)
c0d03b9c:	188a      	adds	r2, r1, r2
c0d03b9e:	438a      	bics	r2, r1
c0d03ba0:	4222      	tst	r2, r4
c0d03ba2:	d0f1      	beq.n	c0d03b88 <strlen+0x2c>
c0d03ba4:	e000      	b.n	c0d03ba8 <strlen+0x4c>
c0d03ba6:	3301      	adds	r3, #1
c0d03ba8:	781a      	ldrb	r2, [r3, #0]
c0d03baa:	2a00      	cmp	r2, #0
c0d03bac:	d1fb      	bne.n	c0d03ba6 <strlen+0x4a>
c0d03bae:	1a18      	subs	r0, r3, r0
c0d03bb0:	bd10      	pop	{r4, pc}
c0d03bb2:	0003      	movs	r3, r0
c0d03bb4:	e7e1      	b.n	c0d03b7a <strlen+0x1e>
c0d03bb6:	2000      	movs	r0, #0
c0d03bb8:	e7fa      	b.n	c0d03bb0 <strlen+0x54>
c0d03bba:	46c0      	nop			; (mov r8, r8)
c0d03bbc:	fefefeff 	.word	0xfefefeff
c0d03bc0:	80808080 	.word	0x80808080

c0d03bc4 <HALF_3>:
c0d03bc4:	f16b9c2d dd01633c 3d8cf0ee b09a028b     -.k.<c.....=....
c0d03bd4:	246cd94a f1c6d805 6cee5506 da330aa3     J.l$.....U.l..3.
c0d03be4:	fde381a1 fe13f810 f97f039e 1b3dc3ce     ..............=.
c0d03bf4:	00000001                                ....

c0d03bf8 <bagl_ui_nanos_screen>:
c0d03bf8:	00000003 00800000 00000020 00000001     ........ .......
c0d03c08:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03c30:	00000107 0080000c 00000020 00000000     ........ .......
c0d03c40:	00ffffff 00000000 0000800a 20001cf0     ............... 
	...
c0d03c68:	00000107 00800018 00000020 00000000     ........ .......
c0d03c78:	00ffffff 00000000 0000800a 20001d05     ............... 
	...
c0d03ca0:	00030005 0007000c 00000007 00000000     ................
	...
c0d03cb8:	00070000 00000000 00000000 00000000     ................
	...
c0d03cd8:	00750005 0008000d 00000006 00000000     ..u.............
c0d03ce8:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03d10 <bagl_ui_sample_blue>:
c0d03d10:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03d20:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03d48:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03d58:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03d80:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03d90:	00ffffff 001d2028 00002004 c0d03df0     ....( ... ...=..
	...
c0d03db8:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03dc8:	0041ccb4 00f9f9f9 0000a004 c0d03dfc     ..A..........=..
c0d03dd8:	00000000 0037ae99 00f9f9f9 c0d027cd     ......7......'..
	...
c0d03df0:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03e01 <USBD_PRODUCT_FS_STRING>:
c0d03e01:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d03e0f <HID_ReportDesc>:
c0d03e0f:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d03e1f:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d03e2f:	0000c008 11210900                                .....

c0d03e34 <USBD_HID_Desc>:
c0d03e34:	01112109 22220100 00011200                       .!...."".

c0d03e3d <USBD_DeviceDesc>:
c0d03e3d:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03e4d:	dd000103                                         ...

c0d03e50 <HID_Desc>:
c0d03e50:	c0d033dd c0d033ed c0d033fd c0d0340d     .3...3...3...4..
c0d03e60:	c0d0341d c0d0342d c0d0343d 00000000     .4..-4..=4......

c0d03e70 <USBD_LangIDDesc>:
c0d03e70:	04090304                                ....

c0d03e74 <USBD_MANUFACTURER_STRING>:
c0d03e74:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03e82 <USB_SERIAL_STRING>:
c0d03e82:	0030030a 00300030 32bf0031                       ..0.0.0.1.

c0d03e8c <USBD_HID>:
c0d03e8c:	c0d032bf c0d032f1 c0d03223 00000000     .2...2..#2......
	...
c0d03ea4:	c0d03329 00000000 00000000 00000000     )3..............
c0d03eb4:	c0d0344d c0d0344d c0d0344d c0d0345d     M4..M4..M4..]4..

c0d03ec4 <USBD_CfgDesc>:
c0d03ec4:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03ed4:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03ee4:	05070100 00400302 00000001              ......@.....

c0d03ef0 <USBD_DeviceQualifierDesc>:
c0d03ef0:	0200060a 40000000 00000001              .......@....

c0d03efc <_etext>:
c0d03efc:	00000000 	.word	0x00000000

c0d03f00 <N_storage_real>:
	...
