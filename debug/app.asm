
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
c0d00014:	f001 f902 	bl	c0d0121c <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f001 f84e 	bl	c0d010b8 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 fcb3 	bl	c0d03990 <setjmp>
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
c0d00040:	f001 fa92 	bl	c0d01568 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 ff73 	bl	c0d01f30 <pic>
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
c0d0005a:	f001 ff69 	bl	c0d01f30 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 ffb7 	bl	c0d01fd4 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f003 f8be 	bl	c0d031e8 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f003 f8bb 	bl	c0d031e8 <USB_power>

            ui_idle();
c0d00072:	f002 fa4f 	bl	c0d02514 <ui_idle>

            IOTA_main();
c0d00076:	f000 feb7 	bl	c0d00de8 <IOTA_main>
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
c0d0008c:	f003 fc8c 	bl	c0d039a8 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d03e40 	.word	0xc0d03e40

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
c0d000c8:	f003 f9d2 	bl	c0d03470 <__aeabi_uidivmod>
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
c0d000e6:	f003 f93d 	bl	c0d03364 <__aeabi_uidiv>
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
c0d000fa:	f000 f8d1 	bl	c0d002a0 <trits_to_trint>
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
c0d00114:	f000 f8fc 	bl	c0d00310 <trint_to_trits>
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
c0d00144:	f000 f8ac 	bl	c0d002a0 <trits_to_trint>
c0d00148:	4605      	mov	r5, r0
c0d0014a:	2000      	movs	r0, #0
c0d0014c:	9a06      	ldr	r2, [sp, #24]
c0d0014e:	2a05      	cmp	r2, #5
c0d00150:	d303      	bcc.n	c0d0015a <add_index_to_seed_trints+0xb6>
                else trints[(uint8_t)(offset/5)] = trits_to_trint(&trits[0], send);
c0d00152:	2105      	movs	r1, #5
c0d00154:	4610      	mov	r0, r2
c0d00156:	f003 f905 	bl	c0d03364 <__aeabi_uidiv>
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

c0d0016e <generate_private_key_half>:

// generates half of a private key to encoded format of trints
// use level 1 for first half, level 2 for second half
int generate_private_key_half(trint_t *seed_trints, uint32_t index,
                              trint_t *private_key, uint8_t level, char *msg)
{
c0d0016e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00170:	af03      	add	r7, sp, #12
c0d00172:	b083      	sub	sp, #12
c0d00174:	9302      	str	r3, [sp, #8]
c0d00176:	4614      	mov	r4, r2
c0d00178:	4605      	mov	r5, r0
    // Add index -- keep in mind fix index_to_seed
    add_index_to_seed_trints(&seed_trints[0], index);
c0d0017a:	f7ff ff93 	bl	c0d000a4 <add_index_to_seed_trints>
    
    snprintf(&msg[0], 64, "[%d][%d][%d][%d][%d]\n", trits[0], trits[1],
             trits[2], trits[3], trits[4]);
 /* */
    
    kerl_initialize();
c0d0017e:	f000 fc0f 	bl	c0d009a0 <kerl_initialize>
c0d00182:	2631      	movs	r6, #49	; 0x31
    kerl_absorb_trints(&seed_trints[0], 49);
c0d00184:	4628      	mov	r0, r5
c0d00186:	4631      	mov	r1, r6
c0d00188:	f000 fc2a 	bl	c0d009e0 <kerl_absorb_trints>
c0d0018c:	9400      	str	r4, [sp, #0]
    kerl_squeeze_trints(&private_key[0], 49);
c0d0018e:	4620      	mov	r0, r4
c0d00190:	4631      	mov	r1, r6
c0d00192:	f000 fc55 	bl	c0d00a40 <kerl_squeeze_trints>
    
    kerl_initialize();
c0d00196:	f000 fc03 	bl	c0d009a0 <kerl_initialize>
    kerl_absorb_trints(&seed_trints[0], 49);
c0d0019a:	4628      	mov	r0, r5
c0d0019c:	4631      	mov	r1, r6
c0d0019e:	f000 fc1f 	bl	c0d009e0 <kerl_absorb_trints>
c0d001a2:	2500      	movs	r5, #0
c0d001a4:	9501      	str	r5, [sp, #4]
    
    //level == 1 means generate first half of private key
    for (uint8_t j = 0; j < 27; j++) {
c0d001a6:	b2ec      	uxtb	r4, r5
        //27 chunks makes up half the private key
        
        // THIS SHOULD TAKE ROUGHLY 3 SECONDS ELSE IT HUNG
        kerl_squeeze_trints(&private_key[j * 49], 49);
c0d001a8:	4630      	mov	r0, r6
c0d001aa:	4360      	muls	r0, r4
c0d001ac:	9900      	ldr	r1, [sp, #0]
c0d001ae:	1808      	adds	r0, r1, r0
c0d001b0:	4631      	mov	r1, r6
c0d001b2:	f000 fc45 	bl	c0d00a40 <kerl_squeeze_trints>
c0d001b6:	2001      	movs	r0, #1
        
        //the first level just store it, if second half, discard
        //entire first half (OPTIMIZE!!!)
        if(j == 26 && level != 1) {
c0d001b8:	2c1a      	cmp	r4, #26
c0d001ba:	4602      	mov	r2, r0
c0d001bc:	d100      	bne.n	c0d001c0 <generate_private_key_half+0x52>
c0d001be:	9a01      	ldr	r2, [sp, #4]
c0d001c0:	9902      	ldr	r1, [sp, #8]
c0d001c2:	b2cb      	uxtb	r3, r1
c0d001c4:	2b01      	cmp	r3, #1
c0d001c6:	9901      	ldr	r1, [sp, #4]
c0d001c8:	d100      	bne.n	c0d001cc <generate_private_key_half+0x5e>
c0d001ca:	4619      	mov	r1, r3
c0d001cc:	4311      	orrs	r1, r2
c0d001ce:	2900      	cmp	r1, #0
c0d001d0:	d100      	bne.n	c0d001d4 <generate_private_key_half+0x66>
c0d001d2:	9002      	str	r0, [sp, #8]
    
    kerl_initialize();
    kerl_absorb_trints(&seed_trints[0], 49);
    
    //level == 1 means generate first half of private key
    for (uint8_t j = 0; j < 27; j++) {
c0d001d4:	1c6d      	adds	r5, r5, #1
c0d001d6:	2900      	cmp	r1, #0
c0d001d8:	d100      	bne.n	c0d001dc <generate_private_key_half+0x6e>
c0d001da:	4605      	mov	r5, r0
c0d001dc:	b2e8      	uxtb	r0, r5
c0d001de:	281b      	cmp	r0, #27
c0d001e0:	d3e1      	bcc.n	c0d001a6 <generate_private_key_half+0x38>
            j = 0;  //reset j so it can just go again,
                    //overwriting first half with second half
            level = 1; // use this as a flag to tell it to not enter infinite loop
        }
    }
    return 0;
c0d001e2:	2000      	movs	r0, #0
c0d001e4:	b003      	add	sp, #12
c0d001e6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d001e8 <generate_public_address_half>:
}

//Generate the public key half at a time
//Use level 1 to generate first half, level 2 to generate second half
int generate_public_address_half(trint_t *private_key, trint_t *address_out, uint8_t level)
{
c0d001e8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d001ea:	af03      	add	r7, sp, #12
c0d001ec:	b083      	sub	sp, #12
c0d001ee:	9200      	str	r2, [sp, #0]
c0d001f0:	9102      	str	r1, [sp, #8]
c0d001f2:	4604      	mov	r4, r0
    for(uint8_t j = 0; j < 27; j++) {
        // each piece get's kerl'd 26 times(?)
        for(uint8_t k = 0; k < 26; k++) {
            //temp set k=25 to make this a LOT faster
            k = 25;
            kerl_initialize();
c0d001f4:	f000 fbd4 	bl	c0d009a0 <kerl_initialize>
c0d001f8:	251b      	movs	r5, #27
c0d001fa:	9401      	str	r4, [sp, #4]
c0d001fc:	2631      	movs	r6, #49	; 0x31
            kerl_absorb_trints(&private_key[j*49], 49);
c0d001fe:	4620      	mov	r0, r4
c0d00200:	4631      	mov	r1, r6
c0d00202:	f000 fbed 	bl	c0d009e0 <kerl_absorb_trints>
            kerl_squeeze_trints(&private_key[j*49], 49);
c0d00206:	4620      	mov	r0, r4
c0d00208:	4631      	mov	r1, r6
c0d0020a:	f000 fc19 	bl	c0d00a40 <kerl_squeeze_trints>
    for(uint8_t j = 0; j < 27; j++) {
        // each piece get's kerl'd 26 times(?)
        for(uint8_t k = 0; k < 26; k++) {
            //temp set k=25 to make this a LOT faster
            k = 25;
            kerl_initialize();
c0d0020e:	f000 fbc7 	bl	c0d009a0 <kerl_initialize>

//Generate the public key half at a time
//Use level 1 to generate first half, level 2 to generate second half
int generate_public_address_half(trint_t *private_key, trint_t *address_out, uint8_t level)
{
    for(uint8_t j = 0; j < 27; j++) {
c0d00212:	1e6d      	subs	r5, r5, #1
c0d00214:	3431      	adds	r4, #49	; 0x31
c0d00216:	2d00      	cmp	r5, #0
c0d00218:	d1f0      	bne.n	c0d001fc <generate_public_address_half+0x14>
        }
    }
    
    //the 27th kerl generates the digests
    kerl_initialize();
    kerl_absorb_trints(private_key, 49*27); // re-absorb the entire private key
c0d0021a:	4911      	ldr	r1, [pc, #68]	; (c0d00260 <generate_public_address_half+0x78>)
c0d0021c:	9e01      	ldr	r6, [sp, #4]
c0d0021e:	4630      	mov	r0, r6
c0d00220:	f000 fbde 	bl	c0d009e0 <kerl_absorb_trints>
    
    // use level 1 to pass the first half of the private key, store
    // digest in public key for now to save RAM
    if(level == 1)
c0d00224:	9800      	ldr	r0, [sp, #0]
c0d00226:	2801      	cmp	r0, #1
c0d00228:	d102      	bne.n	c0d00230 <generate_public_address_half+0x48>
        kerl_squeeze_trints(address_out, 49); // Store the first digest just in address_out{
c0d0022a:	2131      	movs	r1, #49	; 0x31
c0d0022c:	9802      	ldr	r0, [sp, #8]
c0d0022e:	e011      	b.n	c0d00254 <generate_public_address_half+0x6c>
c0d00230:	2431      	movs	r4, #49	; 0x31
    else {
        //done with private key, so store the second digest in private key
        kerl_squeeze_trints(private_key, 49);
c0d00232:	4630      	mov	r0, r6
c0d00234:	4621      	mov	r1, r4
c0d00236:	f000 fc03 	bl	c0d00a40 <kerl_squeeze_trints>
        
        //now get address
        kerl_initialize();
c0d0023a:	f000 fbb1 	bl	c0d009a0 <kerl_initialize>
c0d0023e:	9d02      	ldr	r5, [sp, #8]
        //address out stores first half, private key stores second half
        kerl_absorb_trints(address_out, 49);
c0d00240:	4628      	mov	r0, r5
c0d00242:	4621      	mov	r1, r4
c0d00244:	f000 fbcc 	bl	c0d009e0 <kerl_absorb_trints>
        kerl_absorb_trints(private_key, 49);
c0d00248:	4630      	mov	r0, r6
c0d0024a:	4621      	mov	r1, r4
c0d0024c:	f000 fbc8 	bl	c0d009e0 <kerl_absorb_trints>
        //finally publish the public key
        kerl_squeeze_trints(address_out, 49);
c0d00250:	4628      	mov	r0, r5
c0d00252:	4621      	mov	r1, r4
c0d00254:	f000 fbf4 	bl	c0d00a40 <kerl_squeeze_trints>
    }
    
    return 0;
c0d00258:	2000      	movs	r0, #0
c0d0025a:	b003      	add	sp, #12
c0d0025c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0025e:	46c0      	nop			; (mov r8, r8)
c0d00260:	0000052b 	.word	0x0000052b

c0d00264 <write_debug>:

char debug_str[64];

//write_debug(&words, sizeof(words), TYPE_STR);
//write_debug(&int_val, sizeof(int_val), TYPE_INT);
void write_debug(void* o, unsigned int sz, uint8_t t) {
c0d00264:	b580      	push	{r7, lr}
c0d00266:	af00      	add	r7, sp, #0
c0d00268:	4603      	mov	r3, r0

    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
c0d0026a:	2a03      	cmp	r2, #3
c0d0026c:	d007      	beq.n	c0d0027e <write_debug+0x1a>
c0d0026e:	2a02      	cmp	r2, #2
c0d00270:	d008      	beq.n	c0d00284 <write_debug+0x20>
c0d00272:	2a01      	cmp	r2, #1
c0d00274:	d10b      	bne.n	c0d0028e <write_debug+0x2a>
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
c0d00276:	681b      	ldr	r3, [r3, #0]
c0d00278:	4805      	ldr	r0, [pc, #20]	; (c0d00290 <write_debug+0x2c>)
c0d0027a:	a208      	add	r2, pc, #32	; (adr r2, c0d0029c <write_debug+0x38>)
c0d0027c:	e005      	b.n	c0d0028a <write_debug+0x26>
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
c0d0027e:	4804      	ldr	r0, [pc, #16]	; (c0d00290 <write_debug+0x2c>)
c0d00280:	a204      	add	r2, pc, #16	; (adr r2, c0d00294 <write_debug+0x30>)
c0d00282:	e002      	b.n	c0d0028a <write_debug+0x26>
    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
c0d00284:	681b      	ldr	r3, [r3, #0]
c0d00286:	4802      	ldr	r0, [pc, #8]	; (c0d00290 <write_debug+0x2c>)
c0d00288:	a203      	add	r2, pc, #12	; (adr r2, c0d00298 <write_debug+0x34>)
c0d0028a:	f001 fc01 	bl	c0d01a90 <snprintf>
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
    }
}
c0d0028e:	bd80      	pop	{r7, pc}
c0d00290:	20001800 	.word	0x20001800
c0d00294:	00007325 	.word	0x00007325
c0d00298:	00007525 	.word	0x00007525
c0d0029c:	00006425 	.word	0x00006425

c0d002a0 <trits_to_trint>:
        pow3_val /= 3;
    }
}

//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
c0d002a0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d002a2:	af03      	add	r7, sp, #12
c0d002a4:	2200      	movs	r2, #0
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d002a6:	43d3      	mvns	r3, r2
c0d002a8:	b2c9      	uxtb	r1, r1
c0d002aa:	31ff      	adds	r1, #255	; 0xff
c0d002ac:	b24c      	sxtb	r4, r1
c0d002ae:	2c00      	cmp	r4, #0
c0d002b0:	db0f      	blt.n	c0d002d2 <trits_to_trint+0x32>
c0d002b2:	1900      	adds	r0, r0, r4
c0d002b4:	2401      	movs	r4, #1
c0d002b6:	2200      	movs	r2, #0
    {
        ret += trits[i]*pow3_val;
c0d002b8:	b265      	sxtb	r5, r4
        pow3_val *= 3;
c0d002ba:	2403      	movs	r4, #3
c0d002bc:	436c      	muls	r4, r5
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
    {
        ret += trits[i]*pow3_val;
c0d002be:	7806      	ldrb	r6, [r0, #0]
c0d002c0:	b276      	sxtb	r6, r6
c0d002c2:	436e      	muls	r6, r5
c0d002c4:	b2d2      	uxtb	r2, r2
c0d002c6:	18b2      	adds	r2, r6, r2
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d002c8:	1e40      	subs	r0, r0, #1
c0d002ca:	1e49      	subs	r1, r1, #1
c0d002cc:	b249      	sxtb	r1, r1
c0d002ce:	4299      	cmp	r1, r3
c0d002d0:	dcf2      	bgt.n	c0d002b8 <trits_to_trint+0x18>
    {
        ret += trits[i]*pow3_val;
        pow3_val *= 3;
    }

    return ret;
c0d002d2:	b250      	sxtb	r0, r2
c0d002d4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d002d6 <specific_49trints_to_243trits>:
        //incr count as we get trints
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
c0d002d6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d002d8:	af03      	add	r7, sp, #12
c0d002da:	b081      	sub	sp, #4
c0d002dc:	460e      	mov	r6, r1
c0d002de:	4605      	mov	r5, r0
c0d002e0:	2400      	movs	r4, #0
c0d002e2:	9600      	str	r6, [sp, #0]
    for(uint8_t i = 0; i < 48; i++) {
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
c0d002e4:	1b28      	subs	r0, r5, r4
c0d002e6:	7800      	ldrb	r0, [r0, #0]
c0d002e8:	b240      	sxtb	r0, r0
c0d002ea:	2205      	movs	r2, #5
c0d002ec:	4631      	mov	r1, r6
c0d002ee:	f000 f80f 	bl	c0d00310 <trint_to_trits>
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
    for(uint8_t i = 0; i < 48; i++) {
c0d002f2:	1d76      	adds	r6, r6, #5
c0d002f4:	1e64      	subs	r4, r4, #1
c0d002f6:	4620      	mov	r0, r4
c0d002f8:	3030      	adds	r0, #48	; 0x30
c0d002fa:	d1f3      	bne.n	c0d002e4 <specific_49trints_to_243trits+0xe>
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
c0d002fc:	2030      	movs	r0, #48	; 0x30
c0d002fe:	5628      	ldrsb	r0, [r5, r0]
c0d00300:	9900      	ldr	r1, [sp, #0]
c0d00302:	31f0      	adds	r1, #240	; 0xf0
c0d00304:	2203      	movs	r2, #3
c0d00306:	f000 f803 	bl	c0d00310 <trint_to_trits>
}
c0d0030a:	b001      	add	sp, #4
c0d0030c:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00310 <trint_to_trits>:

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
c0d00310:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00312:	af03      	add	r7, sp, #12
c0d00314:	b083      	sub	sp, #12
c0d00316:	9100      	str	r1, [sp, #0]
c0d00318:	4603      	mov	r3, r0
c0d0031a:	9201      	str	r2, [sp, #4]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d0031c:	2a01      	cmp	r2, #1
c0d0031e:	db2b      	blt.n	c0d00378 <trint_to_trits+0x68>
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
c0d00320:	2009      	movs	r0, #9
c0d00322:	2151      	movs	r1, #81	; 0x51
c0d00324:	9a01      	ldr	r2, [sp, #4]
c0d00326:	2a03      	cmp	r2, #3
c0d00328:	d000      	beq.n	c0d0032c <trint_to_trits+0x1c>
c0d0032a:	4608      	mov	r0, r1
c0d0032c:	2500      	movs	r5, #0
c0d0032e:	462e      	mov	r6, r5
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d00330:	b2c4      	uxtb	r4, r0
c0d00332:	b258      	sxtb	r0, r3
c0d00334:	9002      	str	r0, [sp, #8]
c0d00336:	0040      	lsls	r0, r0, #1
c0d00338:	4621      	mov	r1, r4
c0d0033a:	f003 f89d 	bl	c0d03478 <__aeabi_idiv>
c0d0033e:	9900      	ldr	r1, [sp, #0]
c0d00340:	5548      	strb	r0, [r1, r5]
c0d00342:	194a      	adds	r2, r1, r5


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d00344:	0603      	lsls	r3, r0, #24
c0d00346:	2101      	movs	r1, #1
c0d00348:	060d      	lsls	r5, r1, #24
c0d0034a:	42ab      	cmp	r3, r5
c0d0034c:	dc03      	bgt.n	c0d00356 <trint_to_trits+0x46>
c0d0034e:	21ff      	movs	r1, #255	; 0xff
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d00350:	4d0a      	ldr	r5, [pc, #40]	; (c0d0037c <trint_to_trits+0x6c>)
c0d00352:	42ab      	cmp	r3, r5
c0d00354:	dc01      	bgt.n	c0d0035a <trint_to_trits+0x4a>
c0d00356:	7011      	strb	r1, [r2, #0]
c0d00358:	e000      	b.n	c0d0035c <trint_to_trits+0x4c>

        integ -= trits_r[j] * pow3_val;
c0d0035a:	4601      	mov	r1, r0
c0d0035c:	9a02      	ldr	r2, [sp, #8]
c0d0035e:	b248      	sxtb	r0, r1
c0d00360:	4360      	muls	r0, r4
c0d00362:	1a15      	subs	r5, r2, r0
        pow3_val /= 3;
c0d00364:	2103      	movs	r1, #3
c0d00366:	4620      	mov	r0, r4
c0d00368:	f002 fffc 	bl	c0d03364 <__aeabi_uidiv>
c0d0036c:	462b      	mov	r3, r5
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d0036e:	1c76      	adds	r6, r6, #1
c0d00370:	b2f5      	uxtb	r5, r6
c0d00372:	9901      	ldr	r1, [sp, #4]
c0d00374:	428d      	cmp	r5, r1
c0d00376:	dbdb      	blt.n	c0d00330 <trint_to_trits+0x20>
        else if(trits_r[j] < -1) trits_r[j] = -1;

        integ -= trits_r[j] * pow3_val;
        pow3_val /= 3;
    }
}
c0d00378:	b003      	add	sp, #12
c0d0037a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0037c:	feffffff 	.word	0xfeffffff

c0d00380 <get_seed>:
    return ret;
}

void do_nothing() {}

void get_seed(unsigned char *privateKey, uint8_t sz, char *msg) {
c0d00380:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00382:	af03      	add	r7, sp, #12
c0d00384:	b08f      	sub	sp, #60	; 0x3c
c0d00386:	9201      	str	r2, [sp, #4]
c0d00388:	460e      	mov	r6, r1
c0d0038a:	4605      	mov	r5, r0

    //kerl requires 424 bytes
    kerl_initialize();
c0d0038c:	9500      	str	r5, [sp, #0]
c0d0038e:	f000 fb07 	bl	c0d009a0 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d00392:	f000 fb05 	bl	c0d009a0 <kerl_initialize>
c0d00396:	ac02      	add	r4, sp, #8

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d00398:	4620      	mov	r0, r4
c0d0039a:	4629      	mov	r1, r5
c0d0039c:	4632      	mov	r2, r6
c0d0039e:	f003 fa67 	bl	c0d03870 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d003a2:	19a0      	adds	r0, r4, r6
c0d003a4:	2530      	movs	r5, #48	; 0x30
c0d003a6:	1baa      	subs	r2, r5, r6
c0d003a8:	9900      	ldr	r1, [sp, #0]
c0d003aa:	f003 fa61 	bl	c0d03870 <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d003ae:	4620      	mov	r0, r4
c0d003b0:	4629      	mov	r1, r5
c0d003b2:	f000 fb01 	bl	c0d009b8 <kerl_absorb_bytes>
c0d003b6:	ac02      	add	r4, sp, #8
    }

    // A trint_t is 5 trits encoded as 1 int8_t - Used to massively
    // reduce RAM required
    trint_t seed_trints[49];
    kerl_squeeze_trints(&seed_trints[0], 49);
c0d003b8:	2131      	movs	r1, #49	; 0x31
c0d003ba:	4620      	mov	r0, r4
c0d003bc:	f000 fb40 	bl	c0d00a40 <kerl_squeeze_trints>

    //null terminate seed
    //seed_chars[81] = '\0';

    //pass trints to private key func and let it handle the response
    get_private_key(&seed_trints[0], 0, msg);
c0d003c0:	2100      	movs	r1, #0
c0d003c2:	4620      	mov	r0, r4
c0d003c4:	9a01      	ldr	r2, [sp, #4]
c0d003c6:	f000 f803 	bl	c0d003d0 <get_private_key>
}
c0d003ca:	b00f      	add	sp, #60	; 0x3c
c0d003cc:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d003d0 <get_private_key>:

//write func to get private key
void get_private_key(trint_t *seed_trints, uint32_t idx, char *msg) {
c0d003d0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003d2:	af03      	add	r7, sp, #12
c0d003d4:	b0ff      	sub	sp, #508	; 0x1fc
c0d003d6:	b0ff      	sub	sp, #508	; 0x1fc
c0d003d8:	b0f3      	sub	sp, #460	; 0x1cc
    { // localize the memory for private key
        //currently able to store 31 - [-1][-1][-1][0][-1]
        trint_t private_key_trints[49 * 27]; //trints are still just int8_t but encoded

        //generate private key using level 1 for first half
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 1, msg);
c0d003da:	ab01      	add	r3, sp, #4
c0d003dc:	c307      	stmia	r3!, {r0, r1, r2}
c0d003de:	466b      	mov	r3, sp
c0d003e0:	601a      	str	r2, [r3, #0]
c0d003e2:	ad19      	add	r5, sp, #100	; 0x64
c0d003e4:	2601      	movs	r6, #1
c0d003e6:	462a      	mov	r2, r5
c0d003e8:	4633      	mov	r3, r6
c0d003ea:	f7ff fec0 	bl	c0d0016e <generate_private_key_half>
c0d003ee:	4c17      	ldr	r4, [pc, #92]	; (c0d0044c <get_private_key+0x7c>)
c0d003f0:	446c      	add	r4, sp
        //use this half to generate half public key 1
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 1);
c0d003f2:	4628      	mov	r0, r5
c0d003f4:	4621      	mov	r1, r4
c0d003f6:	4632      	mov	r2, r6
c0d003f8:	f7ff fef6 	bl	c0d001e8 <generate_public_address_half>

        //use level 2 to generate second half of private key
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 2, msg);
c0d003fc:	4668      	mov	r0, sp
c0d003fe:	9903      	ldr	r1, [sp, #12]
c0d00400:	6001      	str	r1, [r0, #0]
c0d00402:	2602      	movs	r6, #2
c0d00404:	9801      	ldr	r0, [sp, #4]
c0d00406:	9902      	ldr	r1, [sp, #8]
c0d00408:	462a      	mov	r2, r5
c0d0040a:	4633      	mov	r3, r6
c0d0040c:	f7ff feaf 	bl	c0d0016e <generate_private_key_half>

        //finally level 2 to generate second half of public key (and then digests both)
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 2);
c0d00410:	4628      	mov	r0, r5
c0d00412:	4621      	mov	r1, r4
c0d00414:	4632      	mov	r2, r6
c0d00416:	f7ff fee7 	bl	c0d001e8 <generate_public_address_half>
c0d0041a:	ad19      	add	r5, sp, #100	; 0x64
    }
    // 12s to get here if k=25, 2min otherwise
    //now public key will hold the actual public address
    trit_t pub_trits[243];
    specific_49trints_to_243trits(&public_key_trints[0], &pub_trits[0]);
c0d0041c:	4620      	mov	r0, r4
c0d0041e:	4629      	mov	r1, r5
c0d00420:	f7ff ff59 	bl	c0d002d6 <specific_49trints_to_243trits>
c0d00424:	ac04      	add	r4, sp, #16

    tryte_t seed_trytes[81];
    trits_to_trytes(pub_trits, seed_trytes, 243);
c0d00426:	22f3      	movs	r2, #243	; 0xf3
c0d00428:	4628      	mov	r0, r5
c0d0042a:	4621      	mov	r1, r4
c0d0042c:	f000 f8fd 	bl	c0d0062a <trits_to_trytes>
c0d00430:	2551      	movs	r5, #81	; 0x51

    trytes_to_chars(seed_trytes, msg, 81);
c0d00432:	4620      	mov	r0, r4
c0d00434:	9c03      	ldr	r4, [sp, #12]
c0d00436:	4621      	mov	r1, r4
c0d00438:	462a      	mov	r2, r5
c0d0043a:	f000 f92b 	bl	c0d00694 <trytes_to_chars>

    //null terminate the public key
    msg[81] = '\0';
c0d0043e:	2000      	movs	r0, #0
c0d00440:	5560      	strb	r0, [r4, r5]
}
c0d00442:	1ffc      	subs	r4, r7, #7
c0d00444:	3c05      	subs	r4, #5
c0d00446:	46a5      	mov	sp, r4
c0d00448:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0044a:	46c0      	nop			; (mov r8, r8)
c0d0044c:	00000590 	.word	0x00000590

c0d00450 <bigint_add_int>:
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
    return ret;
}

int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
c0d00450:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00452:	af03      	add	r7, sp, #12
c0d00454:	b087      	sub	sp, #28
c0d00456:	9105      	str	r1, [sp, #20]
c0d00458:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d0045a:	2b00      	cmp	r3, #0
c0d0045c:	d03a      	beq.n	c0d004d4 <bigint_add_int+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0045e:	2100      	movs	r1, #0
c0d00460:	43cc      	mvns	r4, r1
c0d00462:	9400      	str	r4, [sp, #0]
c0d00464:	460e      	mov	r6, r1
c0d00466:	460c      	mov	r4, r1
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_in[i], val.low, val.hi);
c0d00468:	9101      	str	r1, [sp, #4]
c0d0046a:	9302      	str	r3, [sp, #8]
c0d0046c:	9203      	str	r2, [sp, #12]
c0d0046e:	9b00      	ldr	r3, [sp, #0]
c0d00470:	460a      	mov	r2, r1
c0d00472:	4605      	mov	r5, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00474:	cd01      	ldmia	r5!, {r0}
c0d00476:	9504      	str	r5, [sp, #16]
c0d00478:	9905      	ldr	r1, [sp, #20]
c0d0047a:	1841      	adds	r1, r0, r1
c0d0047c:	4156      	adcs	r6, r2
c0d0047e:	9106      	str	r1, [sp, #24]
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00480:	4019      	ands	r1, r3
c0d00482:	1c49      	adds	r1, r1, #1
c0d00484:	4615      	mov	r5, r2
c0d00486:	416d      	adcs	r5, r5
c0d00488:	2001      	movs	r0, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0048a:	4004      	ands	r4, r0
c0d0048c:	4622      	mov	r2, r4
c0d0048e:	2c00      	cmp	r4, #0
c0d00490:	d100      	bne.n	c0d00494 <bigint_add_int+0x44>
c0d00492:	9906      	ldr	r1, [sp, #24]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00494:	4299      	cmp	r1, r3
c0d00496:	9006      	str	r0, [sp, #24]
c0d00498:	d800      	bhi.n	c0d0049c <bigint_add_int+0x4c>
c0d0049a:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0049c:	2a00      	cmp	r2, #0
c0d0049e:	4632      	mov	r2, r6
c0d004a0:	d100      	bne.n	c0d004a4 <bigint_add_int+0x54>
c0d004a2:	4615      	mov	r5, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004a4:	2d00      	cmp	r5, #0
c0d004a6:	9e06      	ldr	r6, [sp, #24]
c0d004a8:	d100      	bne.n	c0d004ac <bigint_add_int+0x5c>
c0d004aa:	462e      	mov	r6, r5
c0d004ac:	2d00      	cmp	r5, #0
c0d004ae:	d000      	beq.n	c0d004b2 <bigint_add_int+0x62>
c0d004b0:	4630      	mov	r0, r6
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d004b2:	4310      	orrs	r0, r2
c0d004b4:	b2c0      	uxtb	r0, r0
c0d004b6:	2800      	cmp	r0, #0
c0d004b8:	9b02      	ldr	r3, [sp, #8]
c0d004ba:	9a03      	ldr	r2, [sp, #12]
c0d004bc:	9c01      	ldr	r4, [sp, #4]
c0d004be:	d100      	bne.n	c0d004c2 <bigint_add_int+0x72>
c0d004c0:	9006      	str	r0, [sp, #24]
        val = full_add(bigint_in[i], val.low, val.hi);
        bigint_out[i] = val.low;
c0d004c2:	c202      	stmia	r2!, {r1}
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d004c4:	1e5b      	subs	r3, r3, #1
c0d004c6:	9405      	str	r4, [sp, #20]
c0d004c8:	4626      	mov	r6, r4
c0d004ca:	9d06      	ldr	r5, [sp, #24]
c0d004cc:	4621      	mov	r1, r4
c0d004ce:	462c      	mov	r4, r5
c0d004d0:	9804      	ldr	r0, [sp, #16]
c0d004d2:	d1ca      	bne.n	c0d0046a <bigint_add_int+0x1a>
        bigint_out[i] = val.low;
        val.low = 0;
    }

    if (val.hi) {
        return -1;
c0d004d4:	4268      	negs	r0, r5
    }
    return 0;
}
c0d004d6:	b007      	add	sp, #28
c0d004d8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d004da <bigint_add_bigint>:

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d004da:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004dc:	af03      	add	r7, sp, #12
c0d004de:	b086      	sub	sp, #24
c0d004e0:	461c      	mov	r4, r3
c0d004e2:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d004e4:	2c00      	cmp	r4, #0
c0d004e6:	d034      	beq.n	c0d00552 <bigint_add_bigint+0x78>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004e8:	2600      	movs	r6, #0
c0d004ea:	43f3      	mvns	r3, r6
c0d004ec:	9300      	str	r3, [sp, #0]
c0d004ee:	9601      	str	r6, [sp, #4]
c0d004f0:	9202      	str	r2, [sp, #8]
c0d004f2:	9403      	str	r4, [sp, #12]
c0d004f4:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d004f6:	cc01      	ldmia	r4!, {r0}
c0d004f8:	9404      	str	r4, [sp, #16]
c0d004fa:	460c      	mov	r4, r1
c0d004fc:	cc02      	ldmia	r4!, {r1}
c0d004fe:	9405      	str	r4, [sp, #20]
c0d00500:	180a      	adds	r2, r1, r0
c0d00502:	9d01      	ldr	r5, [sp, #4]
c0d00504:	462c      	mov	r4, r5
c0d00506:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00508:	4611      	mov	r1, r2
c0d0050a:	9800      	ldr	r0, [sp, #0]
c0d0050c:	4001      	ands	r1, r0
c0d0050e:	1c4b      	adds	r3, r1, #1
c0d00510:	4629      	mov	r1, r5
c0d00512:	4149      	adcs	r1, r1
c0d00514:	2501      	movs	r5, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00516:	402e      	ands	r6, r5
c0d00518:	2e00      	cmp	r6, #0
c0d0051a:	d100      	bne.n	c0d0051e <bigint_add_bigint+0x44>
c0d0051c:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0051e:	4283      	cmp	r3, r0
c0d00520:	4628      	mov	r0, r5
c0d00522:	d800      	bhi.n	c0d00526 <bigint_add_bigint+0x4c>
c0d00524:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00526:	2e00      	cmp	r6, #0
c0d00528:	9a02      	ldr	r2, [sp, #8]
c0d0052a:	d100      	bne.n	c0d0052e <bigint_add_bigint+0x54>
c0d0052c:	4621      	mov	r1, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0052e:	2900      	cmp	r1, #0
c0d00530:	462e      	mov	r6, r5
c0d00532:	d100      	bne.n	c0d00536 <bigint_add_bigint+0x5c>
c0d00534:	460e      	mov	r6, r1
c0d00536:	2900      	cmp	r1, #0
c0d00538:	d000      	beq.n	c0d0053c <bigint_add_bigint+0x62>
c0d0053a:	4630      	mov	r0, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d0053c:	4320      	orrs	r0, r4

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d0053e:	2800      	cmp	r0, #0
c0d00540:	9905      	ldr	r1, [sp, #20]
c0d00542:	d100      	bne.n	c0d00546 <bigint_add_bigint+0x6c>
c0d00544:	4605      	mov	r5, r0
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d00546:	c208      	stmia	r2!, {r3}
c0d00548:	9c03      	ldr	r4, [sp, #12]

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d0054a:	1e64      	subs	r4, r4, #1
c0d0054c:	462e      	mov	r6, r5
c0d0054e:	9804      	ldr	r0, [sp, #16]
c0d00550:	d1ce      	bne.n	c0d004f0 <bigint_add_bigint+0x16>
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }

    if (val.hi) {
        return -1;
c0d00552:	4268      	negs	r0, r5
    }
    return 0;
}
c0d00554:	b006      	add	sp, #24
c0d00556:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00558 <bigint_sub_bigint>:

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d00558:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0055a:	af03      	add	r7, sp, #12
c0d0055c:	b087      	sub	sp, #28
c0d0055e:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00560:	2d00      	cmp	r5, #0
c0d00562:	d037      	beq.n	c0d005d4 <bigint_sub_bigint+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00564:	2400      	movs	r4, #0
c0d00566:	9402      	str	r4, [sp, #8]
c0d00568:	43e3      	mvns	r3, r4
c0d0056a:	9301      	str	r3, [sp, #4]
c0d0056c:	2601      	movs	r6, #1
c0d0056e:	9600      	str	r6, [sp, #0]
c0d00570:	9203      	str	r2, [sp, #12]
c0d00572:	9504      	str	r5, [sp, #16]
c0d00574:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00576:	cc01      	ldmia	r4!, {r0}
c0d00578:	9405      	str	r4, [sp, #20]
c0d0057a:	460c      	mov	r4, r1
int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d0057c:	cc02      	ldmia	r4!, {r1}
c0d0057e:	9406      	str	r4, [sp, #24]
c0d00580:	43c9      	mvns	r1, r1
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00582:	180a      	adds	r2, r1, r0
c0d00584:	9902      	ldr	r1, [sp, #8]
c0d00586:	460c      	mov	r4, r1
c0d00588:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d0058a:	4610      	mov	r0, r2
c0d0058c:	9d01      	ldr	r5, [sp, #4]
c0d0058e:	4028      	ands	r0, r5
c0d00590:	1c43      	adds	r3, r0, #1
c0d00592:	4608      	mov	r0, r1
c0d00594:	4140      	adcs	r0, r0
c0d00596:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00598:	400e      	ands	r6, r1
c0d0059a:	2e00      	cmp	r6, #0
c0d0059c:	d100      	bne.n	c0d005a0 <bigint_sub_bigint+0x48>
c0d0059e:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005a0:	42ab      	cmp	r3, r5
c0d005a2:	460d      	mov	r5, r1
c0d005a4:	d800      	bhi.n	c0d005a8 <bigint_sub_bigint+0x50>
c0d005a6:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d005a8:	2e00      	cmp	r6, #0
c0d005aa:	9a03      	ldr	r2, [sp, #12]
c0d005ac:	d100      	bne.n	c0d005b0 <bigint_sub_bigint+0x58>
c0d005ae:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005b0:	2800      	cmp	r0, #0
c0d005b2:	460e      	mov	r6, r1
c0d005b4:	d100      	bne.n	c0d005b8 <bigint_sub_bigint+0x60>
c0d005b6:	4606      	mov	r6, r0
c0d005b8:	2800      	cmp	r0, #0
c0d005ba:	d000      	beq.n	c0d005be <bigint_sub_bigint+0x66>
c0d005bc:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d005be:	4325      	orrs	r5, r4

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d005c0:	2d00      	cmp	r5, #0
c0d005c2:	460e      	mov	r6, r1
c0d005c4:	9805      	ldr	r0, [sp, #20]
c0d005c6:	d100      	bne.n	c0d005ca <bigint_sub_bigint+0x72>
c0d005c8:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d005ca:	c208      	stmia	r2!, {r3}
c0d005cc:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d005ce:	1e6d      	subs	r5, r5, #1
c0d005d0:	9906      	ldr	r1, [sp, #24]
c0d005d2:	d1cd      	bne.n	c0d00570 <bigint_sub_bigint+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d005d4:	2000      	movs	r0, #0
c0d005d6:	b007      	add	sp, #28
c0d005d8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d005da <bigint_cmp_bigint>:
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
c0d005da:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005dc:	af03      	add	r7, sp, #12
c0d005de:	b081      	sub	sp, #4
c0d005e0:	2400      	movs	r4, #0
c0d005e2:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d005e4:	32ff      	adds	r2, #255	; 0xff
c0d005e6:	b253      	sxtb	r3, r2
c0d005e8:	2b00      	cmp	r3, #0
c0d005ea:	db0f      	blt.n	c0d0060c <bigint_cmp_bigint+0x32>
c0d005ec:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d005ee:	009b      	lsls	r3, r3, #2
c0d005f0:	58ce      	ldr	r6, [r1, r3]
c0d005f2:	58c4      	ldr	r4, [r0, r3]
c0d005f4:	2301      	movs	r3, #1
c0d005f6:	42b4      	cmp	r4, r6
c0d005f8:	dc0b      	bgt.n	c0d00612 <bigint_cmp_bigint+0x38>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d005fa:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d005fc:	42b4      	cmp	r4, r6
c0d005fe:	db07      	blt.n	c0d00610 <bigint_cmp_bigint+0x36>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00600:	b253      	sxtb	r3, r2
c0d00602:	42ab      	cmp	r3, r5
c0d00604:	461a      	mov	r2, r3
c0d00606:	dcf2      	bgt.n	c0d005ee <bigint_cmp_bigint+0x14>
c0d00608:	9b00      	ldr	r3, [sp, #0]
c0d0060a:	e002      	b.n	c0d00612 <bigint_cmp_bigint+0x38>
c0d0060c:	4623      	mov	r3, r4
c0d0060e:	e000      	b.n	c0d00612 <bigint_cmp_bigint+0x38>
c0d00610:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d00612:	4618      	mov	r0, r3
c0d00614:	b001      	add	sp, #4
c0d00616:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00618 <bigint_not>:

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00618:	2900      	cmp	r1, #0
c0d0061a:	d004      	beq.n	c0d00626 <bigint_not+0xe>
        bigint[i] = ~bigint[i];
c0d0061c:	6802      	ldr	r2, [r0, #0]
c0d0061e:	43d2      	mvns	r2, r2
c0d00620:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00622:	1e49      	subs	r1, r1, #1
c0d00624:	d1fa      	bne.n	c0d0061c <bigint_not+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d00626:	2000      	movs	r0, #0
c0d00628:	4770      	bx	lr

c0d0062a <trits_to_trytes>:

static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";


int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len)
{
c0d0062a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0062c:	af03      	add	r7, sp, #12
c0d0062e:	b083      	sub	sp, #12
c0d00630:	4616      	mov	r6, r2
c0d00632:	460c      	mov	r4, r1
c0d00634:	4605      	mov	r5, r0
    if (trit_len % 3 != 0) {
c0d00636:	2103      	movs	r1, #3
c0d00638:	4630      	mov	r0, r6
c0d0063a:	f002 ff19 	bl	c0d03470 <__aeabi_uidivmod>
c0d0063e:	2000      	movs	r0, #0
c0d00640:	43c2      	mvns	r2, r0
c0d00642:	2900      	cmp	r1, #0
c0d00644:	d123      	bne.n	c0d0068e <trits_to_trytes+0x64>
c0d00646:	9502      	str	r5, [sp, #8]
c0d00648:	4635      	mov	r5, r6
c0d0064a:	2603      	movs	r6, #3
c0d0064c:	9001      	str	r0, [sp, #4]
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;
c0d0064e:	4628      	mov	r0, r5
c0d00650:	4631      	mov	r1, r6
c0d00652:	f002 fe87 	bl	c0d03364 <__aeabi_uidiv>

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00656:	2d03      	cmp	r5, #3
c0d00658:	9a01      	ldr	r2, [sp, #4]
c0d0065a:	d318      	bcc.n	c0d0068e <trits_to_trytes+0x64>
c0d0065c:	2200      	movs	r2, #0
c0d0065e:	9200      	str	r2, [sp, #0]
c0d00660:	9601      	str	r6, [sp, #4]
c0d00662:	9e01      	ldr	r6, [sp, #4]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
c0d00664:	4633      	mov	r3, r6
c0d00666:	4353      	muls	r3, r2
c0d00668:	4625      	mov	r5, r4
c0d0066a:	9902      	ldr	r1, [sp, #8]
c0d0066c:	5ccc      	ldrb	r4, [r1, r3]
c0d0066e:	18cb      	adds	r3, r1, r3
c0d00670:	2101      	movs	r1, #1
c0d00672:	5659      	ldrsb	r1, [r3, r1]
c0d00674:	4371      	muls	r1, r6
c0d00676:	1909      	adds	r1, r1, r4
c0d00678:	2402      	movs	r4, #2
c0d0067a:	571b      	ldrsb	r3, [r3, r4]
c0d0067c:	2409      	movs	r4, #9
c0d0067e:	435c      	muls	r4, r3
c0d00680:	1909      	adds	r1, r1, r4
c0d00682:	462c      	mov	r4, r5
c0d00684:	54a1      	strb	r1, [r4, r2]
    if (trit_len % 3 != 0) {
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00686:	1c52      	adds	r2, r2, #1
c0d00688:	4282      	cmp	r2, r0
c0d0068a:	d3eb      	bcc.n	c0d00664 <trits_to_trytes+0x3a>
c0d0068c:	9a00      	ldr	r2, [sp, #0]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
    }
    return 0;
}
c0d0068e:	4610      	mov	r0, r2
c0d00690:	b003      	add	sp, #12
c0d00692:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00694 <trytes_to_chars>:
    }
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
c0d00694:	b5d0      	push	{r4, r6, r7, lr}
c0d00696:	af02      	add	r7, sp, #8
    for (uint16_t i = 0; i < len; i++) {
c0d00698:	2a00      	cmp	r2, #0
c0d0069a:	d00a      	beq.n	c0d006b2 <trytes_to_chars+0x1e>
c0d0069c:	a306      	add	r3, pc, #24	; (adr r3, c0d006b8 <tryte_to_char_mapping>)
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
c0d0069e:	7804      	ldrb	r4, [r0, #0]
c0d006a0:	b264      	sxtb	r4, r4
c0d006a2:	191c      	adds	r4, r3, r4
c0d006a4:	7b64      	ldrb	r4, [r4, #13]
c0d006a6:	700c      	strb	r4, [r1, #0]
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
    for (uint16_t i = 0; i < len; i++) {
c0d006a8:	1e52      	subs	r2, r2, #1
c0d006aa:	1c40      	adds	r0, r0, #1
c0d006ac:	1c49      	adds	r1, r1, #1
c0d006ae:	2a00      	cmp	r2, #0
c0d006b0:	d1f5      	bne.n	c0d0069e <trytes_to_chars+0xa>
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
    }

    return 0;
c0d006b2:	2000      	movs	r0, #0
c0d006b4:	bdd0      	pop	{r4, r6, r7, pc}
c0d006b6:	46c0      	nop			; (mov r8, r8)

c0d006b8 <tryte_to_char_mapping>:
c0d006b8:	51504f4e 	.word	0x51504f4e
c0d006bc:	55545352 	.word	0x55545352
c0d006c0:	59585756 	.word	0x59585756
c0d006c4:	4241395a 	.word	0x4241395a
c0d006c8:	46454443 	.word	0x46454443
c0d006cc:	4a494847 	.word	0x4a494847
c0d006d0:	004d4c4b 	.word	0x004d4c4b

c0d006d4 <words_to_bytes>:
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
c0d006d4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006d6:	af03      	add	r7, sp, #12
c0d006d8:	b082      	sub	sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d006da:	2a00      	cmp	r2, #0
c0d006dc:	d01a      	beq.n	c0d00714 <words_to_bytes+0x40>
c0d006de:	0093      	lsls	r3, r2, #2
c0d006e0:	18c0      	adds	r0, r0, r3
c0d006e2:	1f00      	subs	r0, r0, #4
c0d006e4:	2303      	movs	r3, #3
c0d006e6:	43db      	mvns	r3, r3
c0d006e8:	9301      	str	r3, [sp, #4]
c0d006ea:	4252      	negs	r2, r2
c0d006ec:	9200      	str	r2, [sp, #0]
c0d006ee:	2400      	movs	r4, #0
        bytes_out[i*4+0] = (words_in[word_len-1-i] >> 24);
c0d006f0:	9d01      	ldr	r5, [sp, #4]
c0d006f2:	4365      	muls	r5, r4
c0d006f4:	00a6      	lsls	r6, r4, #2
c0d006f6:	1983      	adds	r3, r0, r6
c0d006f8:	78da      	ldrb	r2, [r3, #3]
c0d006fa:	554a      	strb	r2, [r1, r5]
c0d006fc:	194a      	adds	r2, r1, r5
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
c0d006fe:	885b      	ldrh	r3, [r3, #2]
c0d00700:	7053      	strb	r3, [r2, #1]
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
c0d00702:	5983      	ldr	r3, [r0, r6]
c0d00704:	0a1b      	lsrs	r3, r3, #8
c0d00706:	7093      	strb	r3, [r2, #2]
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
c0d00708:	5983      	ldr	r3, [r0, r6]
c0d0070a:	70d3      	strb	r3, [r2, #3]
    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d0070c:	1e64      	subs	r4, r4, #1
c0d0070e:	9a00      	ldr	r2, [sp, #0]
c0d00710:	42a2      	cmp	r2, r4
c0d00712:	d1ed      	bne.n	c0d006f0 <words_to_bytes+0x1c>
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
    }

    return 0;
c0d00714:	2000      	movs	r0, #0
c0d00716:	b002      	add	sp, #8
c0d00718:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0071a <bytes_to_words>:
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
c0d0071a:	b5d0      	push	{r4, r6, r7, lr}
c0d0071c:	af02      	add	r7, sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d0071e:	2a00      	cmp	r2, #0
c0d00720:	d015      	beq.n	c0d0074e <bytes_to_words+0x34>
c0d00722:	0093      	lsls	r3, r2, #2
c0d00724:	18c0      	adds	r0, r0, r3
c0d00726:	1f00      	subs	r0, r0, #4
c0d00728:	2300      	movs	r3, #0
        words_out[i] = 0;
c0d0072a:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
c0d0072c:	7803      	ldrb	r3, [r0, #0]
c0d0072e:	061b      	lsls	r3, r3, #24
c0d00730:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
c0d00732:	7844      	ldrb	r4, [r0, #1]
c0d00734:	0424      	lsls	r4, r4, #16
c0d00736:	431c      	orrs	r4, r3
c0d00738:	600c      	str	r4, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
c0d0073a:	7883      	ldrb	r3, [r0, #2]
c0d0073c:	021b      	lsls	r3, r3, #8
c0d0073e:	4323      	orrs	r3, r4
c0d00740:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
c0d00742:	78c4      	ldrb	r4, [r0, #3]
c0d00744:	431c      	orrs	r4, r3
c0d00746:	c110      	stmia	r1!, {r4}
    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d00748:	1f00      	subs	r0, r0, #4
c0d0074a:	1e52      	subs	r2, r2, #1
c0d0074c:	d1ec      	bne.n	c0d00728 <bytes_to_words+0xe>
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
    }
    return 0;
c0d0074e:	2000      	movs	r0, #0
c0d00750:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d00754 <trints_to_words>:
}

//custom conversion straight from trints to words
int trints_to_words(trint_t *trints_in, int32_t words_out[])
{
c0d00754:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00756:	af03      	add	r7, sp, #12
c0d00758:	b0a1      	sub	sp, #132	; 0x84
c0d0075a:	9101      	str	r1, [sp, #4]
c0d0075c:	9002      	str	r0, [sp, #8]
c0d0075e:	a814      	add	r0, sp, #80	; 0x50
    int32_t base[13] = {0};
c0d00760:	2134      	movs	r1, #52	; 0x34
c0d00762:	f003 f87f 	bl	c0d03864 <__aeabi_memclr>
c0d00766:	2430      	movs	r4, #48	; 0x30
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
c0d00768:	2603      	movs	r6, #3
c0d0076a:	2005      	movs	r0, #5
c0d0076c:	2c30      	cmp	r4, #48	; 0x30
c0d0076e:	d000      	beq.n	c0d00772 <trints_to_words+0x1e>
c0d00770:	4606      	mov	r6, r0
        trint_to_trits(trints_in[x], &trits[0], get);
c0d00772:	9802      	ldr	r0, [sp, #8]
c0d00774:	5700      	ldrsb	r0, [r0, r4]
c0d00776:	a912      	add	r1, sp, #72	; 0x48
c0d00778:	4632      	mov	r2, r6
c0d0077a:	f7ff fdc9 	bl	c0d00310 <trint_to_trits>
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d0077e:	4833      	ldr	r0, [pc, #204]	; (c0d0084c <trints_to_words+0xf8>)
c0d00780:	1832      	adds	r2, r6, r0
c0d00782:	2006      	movs	r0, #6
c0d00784:	4010      	ands	r0, r2
            // multiply
            {
                int32_t sz = size;
                int32_t carry = 0;
                
                for (int32_t j = 0; j < sz; j++) {
c0d00786:	1e76      	subs	r6, r6, #1
c0d00788:	9403      	str	r4, [sp, #12]
            
            // add
            {
                int32_t tmp[12];
                // Ignore the last trit (48 is last trint, 2 is last trit in that trint)
                if (x == 48 & i == 2) {
c0d0078a:	2c30      	cmp	r4, #48	; 0x30
c0d0078c:	9204      	str	r2, [sp, #16]
c0d0078e:	d105      	bne.n	c0d0079c <trints_to_words+0x48>
c0d00790:	b2b1      	uxth	r1, r6
c0d00792:	2902      	cmp	r1, #2
c0d00794:	d102      	bne.n	c0d0079c <trints_to_words+0x48>
c0d00796:	a814      	add	r0, sp, #80	; 0x50
                    bigint_add_int(base, 1, tmp, 13);
c0d00798:	2101      	movs	r1, #1
c0d0079a:	e003      	b.n	c0d007a4 <trints_to_words+0x50>
c0d0079c:	a912      	add	r1, sp, #72	; 0x48
                } else {
                    bigint_add_int(base, trits[i]+1, tmp, 13);
c0d0079e:	5608      	ldrsb	r0, [r1, r0]
c0d007a0:	1c41      	adds	r1, r0, #1
c0d007a2:	a814      	add	r0, sp, #80	; 0x50
c0d007a4:	aa05      	add	r2, sp, #20
c0d007a6:	230d      	movs	r3, #13
c0d007a8:	f7ff fe52 	bl	c0d00450 <bigint_add_int>
c0d007ac:	a805      	add	r0, sp, #20
c0d007ae:	a914      	add	r1, sp, #80	; 0x50
                }
                memcpy(base, tmp, 52);
c0d007b0:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d007b2:	c11c      	stmia	r1!, {r2, r3, r4}
c0d007b4:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d007b6:	c11c      	stmia	r1!, {r2, r3, r4}
c0d007b8:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d007ba:	c11c      	stmia	r1!, {r2, r3, r4}
c0d007bc:	c83c      	ldmia	r0!, {r2, r3, r4, r5}
c0d007be:	c13c      	stmia	r1!, {r2, r3, r4, r5}
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
        trint_to_trits(trints_in[x], &trits[0], get);
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d007c0:	1e76      	subs	r6, r6, #1
c0d007c2:	9804      	ldr	r0, [sp, #16]
c0d007c4:	1e40      	subs	r0, r0, #1
c0d007c6:	b200      	sxth	r0, r0
c0d007c8:	2800      	cmp	r0, #0
c0d007ca:	4602      	mov	r2, r0
c0d007cc:	9c03      	ldr	r4, [sp, #12]
c0d007ce:	dadc      	bge.n	c0d0078a <trints_to_words+0x36>
    int32_t size = 13;
    trit_t trits[5]; // on final call only left 3 trits matter
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
c0d007d0:	1e60      	subs	r0, r4, #1
c0d007d2:	2c00      	cmp	r4, #0
c0d007d4:	4604      	mov	r4, r0
c0d007d6:	dcc7      	bgt.n	c0d00768 <trints_to_words+0x14>
                // todo sz>size stuff
            }
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
c0d007d8:	481d      	ldr	r0, [pc, #116]	; (c0d00850 <trints_to_words+0xfc>)
c0d007da:	4478      	add	r0, pc
c0d007dc:	a914      	add	r1, sp, #80	; 0x50
c0d007de:	220d      	movs	r2, #13
c0d007e0:	f7ff fefb 	bl	c0d005da <bigint_cmp_bigint>
c0d007e4:	2801      	cmp	r0, #1
c0d007e6:	db14      	blt.n	c0d00812 <trints_to_words+0xbe>
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d007e8:	481b      	ldr	r0, [pc, #108]	; (c0d00858 <trints_to_words+0x104>)
c0d007ea:	4478      	add	r0, pc
c0d007ec:	ad14      	add	r5, sp, #80	; 0x50
c0d007ee:	ac05      	add	r4, sp, #20
c0d007f0:	260d      	movs	r6, #13
c0d007f2:	4629      	mov	r1, r5
c0d007f4:	4622      	mov	r2, r4
c0d007f6:	4633      	mov	r3, r6
c0d007f8:	f7ff feae 	bl	c0d00558 <bigint_sub_bigint>
        bigint_not(tmp, 13);
c0d007fc:	4620      	mov	r0, r4
c0d007fe:	4631      	mov	r1, r6
c0d00800:	f7ff ff0a 	bl	c0d00618 <bigint_not>
        bigint_add_int(tmp, 1, base, 13);
c0d00804:	2101      	movs	r1, #1
c0d00806:	4620      	mov	r0, r4
c0d00808:	462a      	mov	r2, r5
c0d0080a:	4633      	mov	r3, r6
c0d0080c:	f7ff fe20 	bl	c0d00450 <bigint_add_int>
c0d00810:	e010      	b.n	c0d00834 <trints_to_words+0xe0>
c0d00812:	ad14      	add	r5, sp, #80	; 0x50
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
c0d00814:	490f      	ldr	r1, [pc, #60]	; (c0d00854 <trints_to_words+0x100>)
c0d00816:	4479      	add	r1, pc
c0d00818:	ae05      	add	r6, sp, #20
c0d0081a:	230d      	movs	r3, #13
c0d0081c:	4628      	mov	r0, r5
c0d0081e:	4632      	mov	r2, r6
c0d00820:	f7ff fe9a 	bl	c0d00558 <bigint_sub_bigint>
        memcpy(base, tmp, 52);
c0d00824:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d00826:	c507      	stmia	r5!, {r0, r1, r2}
c0d00828:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d0082a:	c507      	stmia	r5!, {r0, r1, r2}
c0d0082c:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d0082e:	c507      	stmia	r5!, {r0, r1, r2}
c0d00830:	ce0f      	ldmia	r6!, {r0, r1, r2, r3}
c0d00832:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d00834:	a814      	add	r0, sp, #80	; 0x50
c0d00836:	9d01      	ldr	r5, [sp, #4]
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }
    
    
    memcpy(words_out, base, 48);
c0d00838:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d0083a:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d0083c:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d0083e:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00840:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00842:	c51e      	stmia	r5!, {r1, r2, r3, r4}
    return 0;
c0d00844:	2000      	movs	r0, #0
c0d00846:	b021      	add	sp, #132	; 0x84
c0d00848:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0084a:	46c0      	nop			; (mov r8, r8)
c0d0084c:	0000ffff 	.word	0x0000ffff
c0d00850:	0000324e 	.word	0x0000324e
c0d00854:	00003212 	.word	0x00003212
c0d00858:	0000323e 	.word	0x0000323e

c0d0085c <words_to_trints>:
}

//straight from words into trints
int words_to_trints(const int32_t words_in[], trint_t *trints_out)
{
c0d0085c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0085e:	af03      	add	r7, sp, #12
c0d00860:	b0a5      	sub	sp, #148	; 0x94
c0d00862:	9100      	str	r1, [sp, #0]
c0d00864:	4604      	mov	r4, r0
    int32_t base[13] = {0};
c0d00866:	9408      	str	r4, [sp, #32]
c0d00868:	a818      	add	r0, sp, #96	; 0x60
c0d0086a:	2134      	movs	r1, #52	; 0x34
c0d0086c:	f002 fffa 	bl	c0d03864 <__aeabi_memclr>
c0d00870:	2500      	movs	r5, #0
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
c0d00872:	9517      	str	r5, [sp, #92]	; 0x5c
c0d00874:	a80b      	add	r0, sp, #44	; 0x2c
c0d00876:	4621      	mov	r1, r4
c0d00878:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d0087a:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d0087c:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d0087e:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00880:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d00882:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00884:	20fe      	movs	r0, #254	; 0xfe
c0d00886:	43c1      	mvns	r1, r0
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
c0d00888:	9808      	ldr	r0, [sp, #32]
c0d0088a:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d0088c:	2800      	cmp	r0, #0
c0d0088e:	9103      	str	r1, [sp, #12]
c0d00890:	db08      	blt.n	c0d008a4 <words_to_trints+0x48>
c0d00892:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
c0d00894:	4941      	ldr	r1, [pc, #260]	; (c0d0099c <words_to_trints+0x140>)
c0d00896:	4479      	add	r1, pc
c0d00898:	aa18      	add	r2, sp, #96	; 0x60
c0d0089a:	230d      	movs	r3, #13
c0d0089c:	f7ff fe1d 	bl	c0d004da <bigint_add_bigint>
c0d008a0:	9502      	str	r5, [sp, #8]
c0d008a2:	e01b      	b.n	c0d008dc <words_to_trints+0x80>
c0d008a4:	9501      	str	r5, [sp, #4]
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
c0d008a6:	4608      	mov	r0, r1
c0d008a8:	30fe      	adds	r0, #254	; 0xfe
c0d008aa:	9017      	str	r0, [sp, #92]	; 0x5c
c0d008ac:	ad0b      	add	r5, sp, #44	; 0x2c
c0d008ae:	260d      	movs	r6, #13
        bigint_not(tmp, 13);
c0d008b0:	4628      	mov	r0, r5
c0d008b2:	4631      	mov	r1, r6
c0d008b4:	f7ff feb0 	bl	c0d00618 <bigint_not>
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
c0d008b8:	4935      	ldr	r1, [pc, #212]	; (c0d00990 <words_to_trints+0x134>)
c0d008ba:	4479      	add	r1, pc
c0d008bc:	4628      	mov	r0, r5
c0d008be:	4632      	mov	r2, r6
c0d008c0:	f7ff fe8b 	bl	c0d005da <bigint_cmp_bigint>
c0d008c4:	2801      	cmp	r0, #1
c0d008c6:	db49      	blt.n	c0d0095c <words_to_trints+0x100>
c0d008c8:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(tmp, HALF_3, base, 13);
c0d008ca:	4932      	ldr	r1, [pc, #200]	; (c0d00994 <words_to_trints+0x138>)
c0d008cc:	4479      	add	r1, pc
c0d008ce:	aa18      	add	r2, sp, #96	; 0x60
c0d008d0:	230d      	movs	r3, #13
c0d008d2:	f7ff fe41 	bl	c0d00558 <bigint_sub_bigint>
c0d008d6:	2001      	movs	r0, #1
c0d008d8:	9002      	str	r0, [sp, #8]
c0d008da:	9d01      	ldr	r5, [sp, #4]
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
c0d008dc:	2403      	movs	r4, #3
c0d008de:	2005      	movs	r0, #5
c0d008e0:	9501      	str	r5, [sp, #4]
c0d008e2:	2d30      	cmp	r5, #48	; 0x30
c0d008e4:	d000      	beq.n	c0d008e8 <words_to_trints+0x8c>
c0d008e6:	4604      	mov	r4, r0
c0d008e8:	a809      	add	r0, sp, #36	; 0x24
        trits_to_trint(&trits[0], send);
c0d008ea:	4621      	mov	r1, r4
c0d008ec:	f7ff fcd8 	bl	c0d002a0 <trits_to_trint>
c0d008f0:	2000      	movs	r0, #0
c0d008f2:	4601      	mov	r1, r0
c0d008f4:	9004      	str	r0, [sp, #16]
c0d008f6:	9405      	str	r4, [sp, #20]
c0d008f8:	9106      	str	r1, [sp, #24]
c0d008fa:	9007      	str	r0, [sp, #28]
c0d008fc:	250c      	movs	r5, #12
c0d008fe:	9a04      	ldr	r2, [sp, #16]
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
                uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
c0d00900:	00a9      	lsls	r1, r5, #2
c0d00902:	ac18      	add	r4, sp, #96	; 0x60
c0d00904:	5860      	ldr	r0, [r4, r1]
c0d00906:	2a00      	cmp	r2, #0
c0d00908:	9108      	str	r1, [sp, #32]
c0d0090a:	2603      	movs	r6, #3
c0d0090c:	2300      	movs	r3, #0
                uint64_t q = (lhs / 3) & 0xFFFFFFFF;
                uint8_t r = lhs % 3;
c0d0090e:	4611      	mov	r1, r2
c0d00910:	4632      	mov	r2, r6
c0d00912:	f002 fe9d 	bl	c0d03650 <__aeabi_uldivmod>
                
                base[j] = q;
c0d00916:	9908      	ldr	r1, [sp, #32]
c0d00918:	5060      	str	r0, [r4, r1]
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
c0d0091a:	1e68      	subs	r0, r5, #1
c0d0091c:	2d00      	cmp	r5, #0
c0d0091e:	4605      	mov	r5, r0
c0d00920:	dcee      	bgt.n	c0d00900 <words_to_trints+0xa4>
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
            if (flip_trits) {
                trits[i] = -trits[i];
c0d00922:	9803      	ldr	r0, [sp, #12]
c0d00924:	1a80      	subs	r0, r0, r2
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d00926:	32ff      	adds	r2, #255	; 0xff
            if (flip_trits) {
c0d00928:	9902      	ldr	r1, [sp, #8]
c0d0092a:	2900      	cmp	r1, #0
c0d0092c:	d100      	bne.n	c0d00930 <words_to_trints+0xd4>
c0d0092e:	4610      	mov	r0, r2
c0d00930:	a909      	add	r1, sp, #36	; 0x24
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d00932:	9a06      	ldr	r2, [sp, #24]
c0d00934:	5488      	strb	r0, [r1, r2]
c0d00936:	9807      	ldr	r0, [sp, #28]
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
c0d00938:	1c40      	adds	r0, r0, #1
c0d0093a:	b201      	sxth	r1, r0
c0d0093c:	9c05      	ldr	r4, [sp, #20]
c0d0093e:	42a1      	cmp	r1, r4
c0d00940:	dbda      	blt.n	c0d008f8 <words_to_trints+0x9c>
c0d00942:	a809      	add	r0, sp, #36	; 0x24
            if (flip_trits) {
                trits[i] = -trits[i];
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
c0d00944:	4621      	mov	r1, r4
c0d00946:	f7ff fcab 	bl	c0d002a0 <trits_to_trint>
c0d0094a:	9900      	ldr	r1, [sp, #0]
c0d0094c:	9d01      	ldr	r5, [sp, #4]
c0d0094e:	5548      	strb	r0, [r1, r5]
    }
    
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
c0d00950:	1c6d      	adds	r5, r5, #1
c0d00952:	2d31      	cmp	r5, #49	; 0x31
c0d00954:	d1c2      	bne.n	c0d008dc <words_to_trints+0x80>
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
    }
    return 0;
c0d00956:	2000      	movs	r0, #0
c0d00958:	b025      	add	sp, #148	; 0x94
c0d0095a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0095c:	ad0b      	add	r5, sp, #44	; 0x2c
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
c0d0095e:	2101      	movs	r1, #1
c0d00960:	ae18      	add	r6, sp, #96	; 0x60
c0d00962:	240d      	movs	r4, #13
c0d00964:	4628      	mov	r0, r5
c0d00966:	4632      	mov	r2, r6
c0d00968:	4623      	mov	r3, r4
c0d0096a:	f7ff fd71 	bl	c0d00450 <bigint_add_int>
            bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d0096e:	480a      	ldr	r0, [pc, #40]	; (c0d00998 <words_to_trints+0x13c>)
c0d00970:	4478      	add	r0, pc
c0d00972:	4631      	mov	r1, r6
c0d00974:	462a      	mov	r2, r5
c0d00976:	4623      	mov	r3, r4
c0d00978:	f7ff fdee 	bl	c0d00558 <bigint_sub_bigint>
            memcpy(base, tmp, 52);
c0d0097c:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d0097e:	c607      	stmia	r6!, {r0, r1, r2}
c0d00980:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00982:	c607      	stmia	r6!, {r0, r1, r2}
c0d00984:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00986:	c607      	stmia	r6!, {r0, r1, r2}
c0d00988:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d0098a:	c60f      	stmia	r6!, {r0, r1, r2, r3}
c0d0098c:	9d01      	ldr	r5, [sp, #4]
c0d0098e:	e787      	b.n	c0d008a0 <words_to_trints+0x44>
c0d00990:	0000316e 	.word	0x0000316e
c0d00994:	0000315c 	.word	0x0000315c
c0d00998:	000030b8 	.word	0x000030b8
c0d0099c:	00003192 	.word	0x00003192

c0d009a0 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d009a0:	b580      	push	{r7, lr}
c0d009a2:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d009a4:	2003      	movs	r0, #3
c0d009a6:	01c1      	lsls	r1, r0, #7
c0d009a8:	4802      	ldr	r0, [pc, #8]	; (c0d009b4 <kerl_initialize+0x14>)
c0d009aa:	f001 fb6d 	bl	c0d02088 <cx_keccak_init>
    return 0;
c0d009ae:	2000      	movs	r0, #0
c0d009b0:	bd80      	pop	{r7, pc}
c0d009b2:	46c0      	nop			; (mov r8, r8)
c0d009b4:	20001840 	.word	0x20001840

c0d009b8 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d009b8:	b580      	push	{r7, lr}
c0d009ba:	af00      	add	r7, sp, #0
c0d009bc:	b082      	sub	sp, #8
c0d009be:	460b      	mov	r3, r1
c0d009c0:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d009c2:	4805      	ldr	r0, [pc, #20]	; (c0d009d8 <kerl_absorb_bytes+0x20>)
c0d009c4:	4669      	mov	r1, sp
c0d009c6:	6008      	str	r0, [r1, #0]
c0d009c8:	4804      	ldr	r0, [pc, #16]	; (c0d009dc <kerl_absorb_bytes+0x24>)
c0d009ca:	2101      	movs	r1, #1
c0d009cc:	f001 fb7a 	bl	c0d020c4 <cx_hash>
c0d009d0:	2000      	movs	r0, #0
    return 0;
c0d009d2:	b002      	add	sp, #8
c0d009d4:	bd80      	pop	{r7, pc}
c0d009d6:	46c0      	nop			; (mov r8, r8)
c0d009d8:	200019e8 	.word	0x200019e8
c0d009dc:	20001840 	.word	0x20001840

c0d009e0 <kerl_absorb_trints>:
    return 0;
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
c0d009e0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d009e2:	af03      	add	r7, sp, #12
c0d009e4:	b09b      	sub	sp, #108	; 0x6c
c0d009e6:	460e      	mov	r6, r1
c0d009e8:	4604      	mov	r4, r0
c0d009ea:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < (len/49); i++) {
c0d009ec:	4630      	mov	r0, r6
c0d009ee:	f002 fcb9 	bl	c0d03364 <__aeabi_uidiv>
c0d009f2:	2e31      	cmp	r6, #49	; 0x31
c0d009f4:	d31c      	bcc.n	c0d00a30 <kerl_absorb_trints+0x50>
c0d009f6:	2500      	movs	r5, #0
c0d009f8:	9402      	str	r4, [sp, #8]
c0d009fa:	9001      	str	r0, [sp, #4]
c0d009fc:	ae0f      	add	r6, sp, #60	; 0x3c
        // First, convert to bytes
        int32_t words[12];
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
c0d009fe:	4620      	mov	r0, r4
c0d00a00:	4631      	mov	r1, r6
c0d00a02:	f7ff fea7 	bl	c0d00754 <trints_to_words>
c0d00a06:	ac03      	add	r4, sp, #12
        words_to_bytes(words, bytes, 12);
c0d00a08:	220c      	movs	r2, #12
c0d00a0a:	4630      	mov	r0, r6
c0d00a0c:	4621      	mov	r1, r4
c0d00a0e:	f7ff fe61 	bl	c0d006d4 <words_to_bytes>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00a12:	4668      	mov	r0, sp
c0d00a14:	4908      	ldr	r1, [pc, #32]	; (c0d00a38 <kerl_absorb_trints+0x58>)
c0d00a16:	6001      	str	r1, [r0, #0]
c0d00a18:	2101      	movs	r1, #1
c0d00a1a:	2330      	movs	r3, #48	; 0x30
c0d00a1c:	4807      	ldr	r0, [pc, #28]	; (c0d00a3c <kerl_absorb_trints+0x5c>)
c0d00a1e:	4622      	mov	r2, r4
c0d00a20:	9c02      	ldr	r4, [sp, #8]
c0d00a22:	f001 fb4f 	bl	c0d020c4 <cx_hash>
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00a26:	1c6d      	adds	r5, r5, #1
c0d00a28:	b2e8      	uxtb	r0, r5
c0d00a2a:	9901      	ldr	r1, [sp, #4]
c0d00a2c:	4288      	cmp	r0, r1
c0d00a2e:	d3e5      	bcc.n	c0d009fc <kerl_absorb_trints+0x1c>
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
c0d00a30:	2000      	movs	r0, #0
c0d00a32:	b01b      	add	sp, #108	; 0x6c
c0d00a34:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00a36:	46c0      	nop			; (mov r8, r8)
c0d00a38:	200019e8 	.word	0x200019e8
c0d00a3c:	20001840 	.word	0x20001840

c0d00a40 <kerl_squeeze_trints>:
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
c0d00a40:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a42:	af03      	add	r7, sp, #12
c0d00a44:	b091      	sub	sp, #68	; 0x44
c0d00a46:	4605      	mov	r5, r0
    (void) len;

    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
c0d00a48:	4c1b      	ldr	r4, [pc, #108]	; (c0d00ab8 <kerl_squeeze_trints+0x78>)
c0d00a4a:	ae05      	add	r6, sp, #20
c0d00a4c:	220c      	movs	r2, #12
c0d00a4e:	4620      	mov	r0, r4
c0d00a50:	4631      	mov	r1, r6
c0d00a52:	f7ff fe62 	bl	c0d0071a <bytes_to_words>
    words_to_trints(words, &trints_out[0]);
c0d00a56:	4630      	mov	r0, r6
c0d00a58:	9502      	str	r5, [sp, #8]
c0d00a5a:	4629      	mov	r1, r5
c0d00a5c:	f7ff fefe 	bl	c0d0085c <words_to_trints>


    //-- Setting last trit to 0
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
c0d00a60:	2030      	movs	r0, #48	; 0x30
c0d00a62:	9003      	str	r0, [sp, #12]
c0d00a64:	5628      	ldrsb	r0, [r5, r0]
c0d00a66:	ad04      	add	r5, sp, #16
c0d00a68:	2203      	movs	r2, #3
c0d00a6a:	9201      	str	r2, [sp, #4]
c0d00a6c:	4629      	mov	r1, r5
c0d00a6e:	f7ff fc4f 	bl	c0d00310 <trint_to_trits>
c0d00a72:	2600      	movs	r6, #0
    trits[2] = 0; //set last trit to 0
c0d00a74:	70ae      	strb	r6, [r5, #2]
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00a76:	4628      	mov	r0, r5
c0d00a78:	9d01      	ldr	r5, [sp, #4]
c0d00a7a:	4629      	mov	r1, r5
c0d00a7c:	f7ff fc10 	bl	c0d002a0 <trits_to_trint>
c0d00a80:	9903      	ldr	r1, [sp, #12]
c0d00a82:	9a02      	ldr	r2, [sp, #8]
c0d00a84:	5450      	strb	r0, [r2, r1]

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
c0d00a86:	1ba0      	subs	r0, r4, r6
c0d00a88:	7801      	ldrb	r1, [r0, #0]
c0d00a8a:	43c9      	mvns	r1, r1
c0d00a8c:	7001      	strb	r1, [r0, #0]
    trints_out[48] = trits_to_trint(&trits[0], 3);

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d00a8e:	1e76      	subs	r6, r6, #1
c0d00a90:	4630      	mov	r0, r6
c0d00a92:	3030      	adds	r0, #48	; 0x30
c0d00a94:	d1f7      	bne.n	c0d00a86 <kerl_squeeze_trints+0x46>
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d00a96:	01e9      	lsls	r1, r5, #7
c0d00a98:	4d08      	ldr	r5, [pc, #32]	; (c0d00abc <kerl_squeeze_trints+0x7c>)
c0d00a9a:	4628      	mov	r0, r5
c0d00a9c:	f001 faf4 	bl	c0d02088 <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00aa0:	4668      	mov	r0, sp
c0d00aa2:	6004      	str	r4, [r0, #0]
c0d00aa4:	2101      	movs	r1, #1
c0d00aa6:	2330      	movs	r3, #48	; 0x30
c0d00aa8:	4628      	mov	r0, r5
c0d00aaa:	4622      	mov	r2, r4
c0d00aac:	f001 fb0a 	bl	c0d020c4 <cx_hash>
c0d00ab0:	2000      	movs	r0, #0
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
c0d00ab2:	b011      	add	sp, #68	; 0x44
c0d00ab4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ab6:	46c0      	nop			; (mov r8, r8)
c0d00ab8:	200019e8 	.word	0x200019e8
c0d00abc:	20001840 	.word	0x20001840

c0d00ac0 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00ac0:	b580      	push	{r7, lr}
c0d00ac2:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00ac4:	4804      	ldr	r0, [pc, #16]	; (c0d00ad8 <nvram_is_init+0x18>)
c0d00ac6:	f001 fa33 	bl	c0d01f30 <pic>
c0d00aca:	7801      	ldrb	r1, [r0, #0]
c0d00acc:	2000      	movs	r0, #0
c0d00ace:	2901      	cmp	r1, #1
c0d00ad0:	d100      	bne.n	c0d00ad4 <nvram_is_init+0x14>
c0d00ad2:	4608      	mov	r0, r1
    else return true;
}
c0d00ad4:	bd80      	pop	{r7, pc}
c0d00ad6:	46c0      	nop			; (mov r8, r8)
c0d00ad8:	c0d03e40 	.word	0xc0d03e40

c0d00adc <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00adc:	b5b0      	push	{r4, r5, r7, lr}
c0d00ade:	af02      	add	r7, sp, #8
c0d00ae0:	4605      	mov	r5, r0
c0d00ae2:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00ae4:	4028      	ands	r0, r5
c0d00ae6:	2400      	movs	r4, #0
c0d00ae8:	2801      	cmp	r0, #1
c0d00aea:	d013      	beq.n	c0d00b14 <io_exchange_al+0x38>
c0d00aec:	2802      	cmp	r0, #2
c0d00aee:	d113      	bne.n	c0d00b18 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00af0:	2900      	cmp	r1, #0
c0d00af2:	d008      	beq.n	c0d00b06 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00af4:	480b      	ldr	r0, [pc, #44]	; (c0d00b24 <io_exchange_al+0x48>)
c0d00af6:	f001 fbd7 	bl	c0d022a8 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d00afa:	b268      	sxtb	r0, r5
c0d00afc:	2800      	cmp	r0, #0
c0d00afe:	da09      	bge.n	c0d00b14 <io_exchange_al+0x38>
                reset();
c0d00b00:	f001 fa4c 	bl	c0d01f9c <reset>
c0d00b04:	e006      	b.n	c0d00b14 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00b06:	2041      	movs	r0, #65	; 0x41
c0d00b08:	0081      	lsls	r1, r0, #2
c0d00b0a:	4806      	ldr	r0, [pc, #24]	; (c0d00b24 <io_exchange_al+0x48>)
c0d00b0c:	2200      	movs	r2, #0
c0d00b0e:	f001 fc05 	bl	c0d0231c <io_seproxyhal_spi_recv>
c0d00b12:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00b14:	4620      	mov	r0, r4
c0d00b16:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00b18:	4803      	ldr	r0, [pc, #12]	; (c0d00b28 <io_exchange_al+0x4c>)
c0d00b1a:	6800      	ldr	r0, [r0, #0]
c0d00b1c:	2102      	movs	r1, #2
c0d00b1e:	f002 ff43 	bl	c0d039a8 <longjmp>
c0d00b22:	46c0      	nop			; (mov r8, r8)
c0d00b24:	20001c08 	.word	0x20001c08
c0d00b28:	20001bb8 	.word	0x20001bb8

c0d00b2c <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00b2c:	b580      	push	{r7, lr}
c0d00b2e:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00b30:	f000 fe8e 	bl	c0d01850 <io_seproxyhal_display_default>
}
c0d00b34:	bd80      	pop	{r7, pc}
	...

c0d00b38 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00b38:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00b3a:	af03      	add	r7, sp, #12
c0d00b3c:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00b3e:	48a6      	ldr	r0, [pc, #664]	; (c0d00dd8 <io_event+0x2a0>)
c0d00b40:	7800      	ldrb	r0, [r0, #0]
c0d00b42:	2805      	cmp	r0, #5
c0d00b44:	d02e      	beq.n	c0d00ba4 <io_event+0x6c>
c0d00b46:	280d      	cmp	r0, #13
c0d00b48:	d04e      	beq.n	c0d00be8 <io_event+0xb0>
c0d00b4a:	280c      	cmp	r0, #12
c0d00b4c:	d000      	beq.n	c0d00b50 <io_event+0x18>
c0d00b4e:	e13a      	b.n	c0d00dc6 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00b50:	4ea2      	ldr	r6, [pc, #648]	; (c0d00ddc <io_event+0x2a4>)
c0d00b52:	2001      	movs	r0, #1
c0d00b54:	7630      	strb	r0, [r6, #24]
c0d00b56:	2500      	movs	r5, #0
c0d00b58:	61f5      	str	r5, [r6, #28]
c0d00b5a:	4634      	mov	r4, r6
c0d00b5c:	3418      	adds	r4, #24
c0d00b5e:	4620      	mov	r0, r4
c0d00b60:	f001 fb68 	bl	c0d02234 <os_ux>
c0d00b64:	61f0      	str	r0, [r6, #28]
c0d00b66:	499e      	ldr	r1, [pc, #632]	; (c0d00de0 <io_event+0x2a8>)
c0d00b68:	4288      	cmp	r0, r1
c0d00b6a:	d100      	bne.n	c0d00b6e <io_event+0x36>
c0d00b6c:	e12b      	b.n	c0d00dc6 <io_event+0x28e>
c0d00b6e:	2800      	cmp	r0, #0
c0d00b70:	d100      	bne.n	c0d00b74 <io_event+0x3c>
c0d00b72:	e128      	b.n	c0d00dc6 <io_event+0x28e>
c0d00b74:	499b      	ldr	r1, [pc, #620]	; (c0d00de4 <io_event+0x2ac>)
c0d00b76:	4288      	cmp	r0, r1
c0d00b78:	d000      	beq.n	c0d00b7c <io_event+0x44>
c0d00b7a:	e0ac      	b.n	c0d00cd6 <io_event+0x19e>
c0d00b7c:	2003      	movs	r0, #3
c0d00b7e:	7630      	strb	r0, [r6, #24]
c0d00b80:	61f5      	str	r5, [r6, #28]
c0d00b82:	4620      	mov	r0, r4
c0d00b84:	f001 fb56 	bl	c0d02234 <os_ux>
c0d00b88:	61f0      	str	r0, [r6, #28]
c0d00b8a:	f000 fd17 	bl	c0d015bc <io_seproxyhal_init_ux>
c0d00b8e:	60b5      	str	r5, [r6, #8]
c0d00b90:	6830      	ldr	r0, [r6, #0]
c0d00b92:	2800      	cmp	r0, #0
c0d00b94:	d100      	bne.n	c0d00b98 <io_event+0x60>
c0d00b96:	e116      	b.n	c0d00dc6 <io_event+0x28e>
c0d00b98:	69f0      	ldr	r0, [r6, #28]
c0d00b9a:	4991      	ldr	r1, [pc, #580]	; (c0d00de0 <io_event+0x2a8>)
c0d00b9c:	4288      	cmp	r0, r1
c0d00b9e:	d000      	beq.n	c0d00ba2 <io_event+0x6a>
c0d00ba0:	e096      	b.n	c0d00cd0 <io_event+0x198>
c0d00ba2:	e110      	b.n	c0d00dc6 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00ba4:	4d8d      	ldr	r5, [pc, #564]	; (c0d00ddc <io_event+0x2a4>)
c0d00ba6:	2001      	movs	r0, #1
c0d00ba8:	7628      	strb	r0, [r5, #24]
c0d00baa:	2600      	movs	r6, #0
c0d00bac:	61ee      	str	r6, [r5, #28]
c0d00bae:	462c      	mov	r4, r5
c0d00bb0:	3418      	adds	r4, #24
c0d00bb2:	4620      	mov	r0, r4
c0d00bb4:	f001 fb3e 	bl	c0d02234 <os_ux>
c0d00bb8:	4601      	mov	r1, r0
c0d00bba:	61e9      	str	r1, [r5, #28]
c0d00bbc:	4889      	ldr	r0, [pc, #548]	; (c0d00de4 <io_event+0x2ac>)
c0d00bbe:	4281      	cmp	r1, r0
c0d00bc0:	d15d      	bne.n	c0d00c7e <io_event+0x146>
c0d00bc2:	2003      	movs	r0, #3
c0d00bc4:	7628      	strb	r0, [r5, #24]
c0d00bc6:	61ee      	str	r6, [r5, #28]
c0d00bc8:	4620      	mov	r0, r4
c0d00bca:	f001 fb33 	bl	c0d02234 <os_ux>
c0d00bce:	61e8      	str	r0, [r5, #28]
c0d00bd0:	f000 fcf4 	bl	c0d015bc <io_seproxyhal_init_ux>
c0d00bd4:	60ae      	str	r6, [r5, #8]
c0d00bd6:	6828      	ldr	r0, [r5, #0]
c0d00bd8:	2800      	cmp	r0, #0
c0d00bda:	d100      	bne.n	c0d00bde <io_event+0xa6>
c0d00bdc:	e0f3      	b.n	c0d00dc6 <io_event+0x28e>
c0d00bde:	69e8      	ldr	r0, [r5, #28]
c0d00be0:	497f      	ldr	r1, [pc, #508]	; (c0d00de0 <io_event+0x2a8>)
c0d00be2:	4288      	cmp	r0, r1
c0d00be4:	d148      	bne.n	c0d00c78 <io_event+0x140>
c0d00be6:	e0ee      	b.n	c0d00dc6 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00be8:	4d7c      	ldr	r5, [pc, #496]	; (c0d00ddc <io_event+0x2a4>)
c0d00bea:	6868      	ldr	r0, [r5, #4]
c0d00bec:	68a9      	ldr	r1, [r5, #8]
c0d00bee:	4281      	cmp	r1, r0
c0d00bf0:	d300      	bcc.n	c0d00bf4 <io_event+0xbc>
c0d00bf2:	e0e8      	b.n	c0d00dc6 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00bf4:	2001      	movs	r0, #1
c0d00bf6:	7628      	strb	r0, [r5, #24]
c0d00bf8:	2600      	movs	r6, #0
c0d00bfa:	61ee      	str	r6, [r5, #28]
c0d00bfc:	462c      	mov	r4, r5
c0d00bfe:	3418      	adds	r4, #24
c0d00c00:	4620      	mov	r0, r4
c0d00c02:	f001 fb17 	bl	c0d02234 <os_ux>
c0d00c06:	61e8      	str	r0, [r5, #28]
c0d00c08:	4975      	ldr	r1, [pc, #468]	; (c0d00de0 <io_event+0x2a8>)
c0d00c0a:	4288      	cmp	r0, r1
c0d00c0c:	d100      	bne.n	c0d00c10 <io_event+0xd8>
c0d00c0e:	e0da      	b.n	c0d00dc6 <io_event+0x28e>
c0d00c10:	2800      	cmp	r0, #0
c0d00c12:	d100      	bne.n	c0d00c16 <io_event+0xde>
c0d00c14:	e0d7      	b.n	c0d00dc6 <io_event+0x28e>
c0d00c16:	4973      	ldr	r1, [pc, #460]	; (c0d00de4 <io_event+0x2ac>)
c0d00c18:	4288      	cmp	r0, r1
c0d00c1a:	d000      	beq.n	c0d00c1e <io_event+0xe6>
c0d00c1c:	e08d      	b.n	c0d00d3a <io_event+0x202>
c0d00c1e:	2003      	movs	r0, #3
c0d00c20:	7628      	strb	r0, [r5, #24]
c0d00c22:	61ee      	str	r6, [r5, #28]
c0d00c24:	4620      	mov	r0, r4
c0d00c26:	f001 fb05 	bl	c0d02234 <os_ux>
c0d00c2a:	61e8      	str	r0, [r5, #28]
c0d00c2c:	f000 fcc6 	bl	c0d015bc <io_seproxyhal_init_ux>
c0d00c30:	60ae      	str	r6, [r5, #8]
c0d00c32:	6828      	ldr	r0, [r5, #0]
c0d00c34:	2800      	cmp	r0, #0
c0d00c36:	d100      	bne.n	c0d00c3a <io_event+0x102>
c0d00c38:	e0c5      	b.n	c0d00dc6 <io_event+0x28e>
c0d00c3a:	69e8      	ldr	r0, [r5, #28]
c0d00c3c:	4968      	ldr	r1, [pc, #416]	; (c0d00de0 <io_event+0x2a8>)
c0d00c3e:	4288      	cmp	r0, r1
c0d00c40:	d178      	bne.n	c0d00d34 <io_event+0x1fc>
c0d00c42:	e0c0      	b.n	c0d00dc6 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c44:	6868      	ldr	r0, [r5, #4]
c0d00c46:	4286      	cmp	r6, r0
c0d00c48:	d300      	bcc.n	c0d00c4c <io_event+0x114>
c0d00c4a:	e0bc      	b.n	c0d00dc6 <io_event+0x28e>
c0d00c4c:	f001 fb4a 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d00c50:	2800      	cmp	r0, #0
c0d00c52:	d000      	beq.n	c0d00c56 <io_event+0x11e>
c0d00c54:	e0b7      	b.n	c0d00dc6 <io_event+0x28e>
c0d00c56:	68a8      	ldr	r0, [r5, #8]
c0d00c58:	68e9      	ldr	r1, [r5, #12]
c0d00c5a:	2438      	movs	r4, #56	; 0x38
c0d00c5c:	4360      	muls	r0, r4
c0d00c5e:	682a      	ldr	r2, [r5, #0]
c0d00c60:	1810      	adds	r0, r2, r0
c0d00c62:	2900      	cmp	r1, #0
c0d00c64:	d100      	bne.n	c0d00c68 <io_event+0x130>
c0d00c66:	e085      	b.n	c0d00d74 <io_event+0x23c>
c0d00c68:	4788      	blx	r1
c0d00c6a:	2800      	cmp	r0, #0
c0d00c6c:	d000      	beq.n	c0d00c70 <io_event+0x138>
c0d00c6e:	e081      	b.n	c0d00d74 <io_event+0x23c>
c0d00c70:	68a8      	ldr	r0, [r5, #8]
c0d00c72:	1c46      	adds	r6, r0, #1
c0d00c74:	60ae      	str	r6, [r5, #8]
c0d00c76:	6828      	ldr	r0, [r5, #0]
c0d00c78:	2800      	cmp	r0, #0
c0d00c7a:	d1e3      	bne.n	c0d00c44 <io_event+0x10c>
c0d00c7c:	e0a3      	b.n	c0d00dc6 <io_event+0x28e>
c0d00c7e:	6928      	ldr	r0, [r5, #16]
c0d00c80:	2800      	cmp	r0, #0
c0d00c82:	d100      	bne.n	c0d00c86 <io_event+0x14e>
c0d00c84:	e09f      	b.n	c0d00dc6 <io_event+0x28e>
c0d00c86:	4a56      	ldr	r2, [pc, #344]	; (c0d00de0 <io_event+0x2a8>)
c0d00c88:	4291      	cmp	r1, r2
c0d00c8a:	d100      	bne.n	c0d00c8e <io_event+0x156>
c0d00c8c:	e09b      	b.n	c0d00dc6 <io_event+0x28e>
c0d00c8e:	2900      	cmp	r1, #0
c0d00c90:	d100      	bne.n	c0d00c94 <io_event+0x15c>
c0d00c92:	e098      	b.n	c0d00dc6 <io_event+0x28e>
c0d00c94:	4950      	ldr	r1, [pc, #320]	; (c0d00dd8 <io_event+0x2a0>)
c0d00c96:	78c9      	ldrb	r1, [r1, #3]
c0d00c98:	0849      	lsrs	r1, r1, #1
c0d00c9a:	f000 fe1b 	bl	c0d018d4 <io_seproxyhal_button_push>
c0d00c9e:	e092      	b.n	c0d00dc6 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00ca0:	6870      	ldr	r0, [r6, #4]
c0d00ca2:	4285      	cmp	r5, r0
c0d00ca4:	d300      	bcc.n	c0d00ca8 <io_event+0x170>
c0d00ca6:	e08e      	b.n	c0d00dc6 <io_event+0x28e>
c0d00ca8:	f001 fb1c 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d00cac:	2800      	cmp	r0, #0
c0d00cae:	d000      	beq.n	c0d00cb2 <io_event+0x17a>
c0d00cb0:	e089      	b.n	c0d00dc6 <io_event+0x28e>
c0d00cb2:	68b0      	ldr	r0, [r6, #8]
c0d00cb4:	68f1      	ldr	r1, [r6, #12]
c0d00cb6:	2438      	movs	r4, #56	; 0x38
c0d00cb8:	4360      	muls	r0, r4
c0d00cba:	6832      	ldr	r2, [r6, #0]
c0d00cbc:	1810      	adds	r0, r2, r0
c0d00cbe:	2900      	cmp	r1, #0
c0d00cc0:	d076      	beq.n	c0d00db0 <io_event+0x278>
c0d00cc2:	4788      	blx	r1
c0d00cc4:	2800      	cmp	r0, #0
c0d00cc6:	d173      	bne.n	c0d00db0 <io_event+0x278>
c0d00cc8:	68b0      	ldr	r0, [r6, #8]
c0d00cca:	1c45      	adds	r5, r0, #1
c0d00ccc:	60b5      	str	r5, [r6, #8]
c0d00cce:	6830      	ldr	r0, [r6, #0]
c0d00cd0:	2800      	cmp	r0, #0
c0d00cd2:	d1e5      	bne.n	c0d00ca0 <io_event+0x168>
c0d00cd4:	e077      	b.n	c0d00dc6 <io_event+0x28e>
c0d00cd6:	88b0      	ldrh	r0, [r6, #4]
c0d00cd8:	9004      	str	r0, [sp, #16]
c0d00cda:	6830      	ldr	r0, [r6, #0]
c0d00cdc:	9003      	str	r0, [sp, #12]
c0d00cde:	483e      	ldr	r0, [pc, #248]	; (c0d00dd8 <io_event+0x2a0>)
c0d00ce0:	4601      	mov	r1, r0
c0d00ce2:	79cc      	ldrb	r4, [r1, #7]
c0d00ce4:	798b      	ldrb	r3, [r1, #6]
c0d00ce6:	794d      	ldrb	r5, [r1, #5]
c0d00ce8:	790a      	ldrb	r2, [r1, #4]
c0d00cea:	4630      	mov	r0, r6
c0d00cec:	78ce      	ldrb	r6, [r1, #3]
c0d00cee:	68c1      	ldr	r1, [r0, #12]
c0d00cf0:	4668      	mov	r0, sp
c0d00cf2:	6006      	str	r6, [r0, #0]
c0d00cf4:	6041      	str	r1, [r0, #4]
c0d00cf6:	0212      	lsls	r2, r2, #8
c0d00cf8:	432a      	orrs	r2, r5
c0d00cfa:	021b      	lsls	r3, r3, #8
c0d00cfc:	4323      	orrs	r3, r4
c0d00cfe:	9803      	ldr	r0, [sp, #12]
c0d00d00:	9904      	ldr	r1, [sp, #16]
c0d00d02:	f000 fcd5 	bl	c0d016b0 <io_seproxyhal_touch_element_callback>
c0d00d06:	e05e      	b.n	c0d00dc6 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00d08:	6868      	ldr	r0, [r5, #4]
c0d00d0a:	4286      	cmp	r6, r0
c0d00d0c:	d25b      	bcs.n	c0d00dc6 <io_event+0x28e>
c0d00d0e:	f001 fae9 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d00d12:	2800      	cmp	r0, #0
c0d00d14:	d157      	bne.n	c0d00dc6 <io_event+0x28e>
c0d00d16:	68a8      	ldr	r0, [r5, #8]
c0d00d18:	68e9      	ldr	r1, [r5, #12]
c0d00d1a:	2438      	movs	r4, #56	; 0x38
c0d00d1c:	4360      	muls	r0, r4
c0d00d1e:	682a      	ldr	r2, [r5, #0]
c0d00d20:	1810      	adds	r0, r2, r0
c0d00d22:	2900      	cmp	r1, #0
c0d00d24:	d026      	beq.n	c0d00d74 <io_event+0x23c>
c0d00d26:	4788      	blx	r1
c0d00d28:	2800      	cmp	r0, #0
c0d00d2a:	d123      	bne.n	c0d00d74 <io_event+0x23c>
c0d00d2c:	68a8      	ldr	r0, [r5, #8]
c0d00d2e:	1c46      	adds	r6, r0, #1
c0d00d30:	60ae      	str	r6, [r5, #8]
c0d00d32:	6828      	ldr	r0, [r5, #0]
c0d00d34:	2800      	cmp	r0, #0
c0d00d36:	d1e7      	bne.n	c0d00d08 <io_event+0x1d0>
c0d00d38:	e045      	b.n	c0d00dc6 <io_event+0x28e>
c0d00d3a:	6828      	ldr	r0, [r5, #0]
c0d00d3c:	2800      	cmp	r0, #0
c0d00d3e:	d030      	beq.n	c0d00da2 <io_event+0x26a>
c0d00d40:	68a8      	ldr	r0, [r5, #8]
c0d00d42:	6869      	ldr	r1, [r5, #4]
c0d00d44:	4288      	cmp	r0, r1
c0d00d46:	d22c      	bcs.n	c0d00da2 <io_event+0x26a>
c0d00d48:	f001 facc 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d00d4c:	2800      	cmp	r0, #0
c0d00d4e:	d128      	bne.n	c0d00da2 <io_event+0x26a>
c0d00d50:	68a8      	ldr	r0, [r5, #8]
c0d00d52:	68e9      	ldr	r1, [r5, #12]
c0d00d54:	2438      	movs	r4, #56	; 0x38
c0d00d56:	4360      	muls	r0, r4
c0d00d58:	682a      	ldr	r2, [r5, #0]
c0d00d5a:	1810      	adds	r0, r2, r0
c0d00d5c:	2900      	cmp	r1, #0
c0d00d5e:	d015      	beq.n	c0d00d8c <io_event+0x254>
c0d00d60:	4788      	blx	r1
c0d00d62:	2800      	cmp	r0, #0
c0d00d64:	d112      	bne.n	c0d00d8c <io_event+0x254>
c0d00d66:	68a8      	ldr	r0, [r5, #8]
c0d00d68:	1c40      	adds	r0, r0, #1
c0d00d6a:	60a8      	str	r0, [r5, #8]
c0d00d6c:	6829      	ldr	r1, [r5, #0]
c0d00d6e:	2900      	cmp	r1, #0
c0d00d70:	d1e7      	bne.n	c0d00d42 <io_event+0x20a>
c0d00d72:	e016      	b.n	c0d00da2 <io_event+0x26a>
c0d00d74:	2801      	cmp	r0, #1
c0d00d76:	d103      	bne.n	c0d00d80 <io_event+0x248>
c0d00d78:	68a8      	ldr	r0, [r5, #8]
c0d00d7a:	4344      	muls	r4, r0
c0d00d7c:	6828      	ldr	r0, [r5, #0]
c0d00d7e:	1900      	adds	r0, r0, r4
c0d00d80:	f000 fd66 	bl	c0d01850 <io_seproxyhal_display_default>
c0d00d84:	68a8      	ldr	r0, [r5, #8]
c0d00d86:	1c40      	adds	r0, r0, #1
c0d00d88:	60a8      	str	r0, [r5, #8]
c0d00d8a:	e01c      	b.n	c0d00dc6 <io_event+0x28e>
c0d00d8c:	2801      	cmp	r0, #1
c0d00d8e:	d103      	bne.n	c0d00d98 <io_event+0x260>
c0d00d90:	68a8      	ldr	r0, [r5, #8]
c0d00d92:	4344      	muls	r4, r0
c0d00d94:	6828      	ldr	r0, [r5, #0]
c0d00d96:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00d98:	f000 fd5a 	bl	c0d01850 <io_seproxyhal_display_default>
c0d00d9c:	68a8      	ldr	r0, [r5, #8]
c0d00d9e:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00da0:	60a8      	str	r0, [r5, #8]
c0d00da2:	6868      	ldr	r0, [r5, #4]
c0d00da4:	68a9      	ldr	r1, [r5, #8]
c0d00da6:	4281      	cmp	r1, r0
c0d00da8:	d30d      	bcc.n	c0d00dc6 <io_event+0x28e>
c0d00daa:	f001 fa9b 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d00dae:	e00a      	b.n	c0d00dc6 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00db0:	2801      	cmp	r0, #1
c0d00db2:	d103      	bne.n	c0d00dbc <io_event+0x284>
c0d00db4:	68b0      	ldr	r0, [r6, #8]
c0d00db6:	4344      	muls	r4, r0
c0d00db8:	6830      	ldr	r0, [r6, #0]
c0d00dba:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00dbc:	f000 fd48 	bl	c0d01850 <io_seproxyhal_display_default>
c0d00dc0:	68b0      	ldr	r0, [r6, #8]
c0d00dc2:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00dc4:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00dc6:	f001 fa8d 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d00dca:	2800      	cmp	r0, #0
c0d00dcc:	d101      	bne.n	c0d00dd2 <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00dce:	f000 fac9 	bl	c0d01364 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00dd2:	2001      	movs	r0, #1
c0d00dd4:	b005      	add	sp, #20
c0d00dd6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00dd8:	20001a18 	.word	0x20001a18
c0d00ddc:	20001a98 	.word	0x20001a98
c0d00de0:	b0105044 	.word	0xb0105044
c0d00de4:	b0105055 	.word	0xb0105055

c0d00de8 <IOTA_main>:





static void IOTA_main(void) {
c0d00de8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00dea:	af03      	add	r7, sp, #12
c0d00dec:	b0dd      	sub	sp, #372	; 0x174
c0d00dee:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00df0:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00df2:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00df4:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00df6:	a0a1      	add	r0, pc, #644	; (adr r0, c0d0107c <IOTA_main+0x294>)
c0d00df8:	2110      	movs	r1, #16
c0d00dfa:	2203      	movs	r2, #3
c0d00dfc:	9109      	str	r1, [sp, #36]	; 0x24
c0d00dfe:	9208      	str	r2, [sp, #32]
c0d00e00:	f7ff fa30 	bl	c0d00264 <write_debug>
c0d00e04:	a80e      	add	r0, sp, #56	; 0x38
c0d00e06:	304d      	adds	r0, #77	; 0x4d
c0d00e08:	9007      	str	r0, [sp, #28]
c0d00e0a:	a80b      	add	r0, sp, #44	; 0x2c
c0d00e0c:	1dc1      	adds	r1, r0, #7
c0d00e0e:	9106      	str	r1, [sp, #24]
c0d00e10:	1d00      	adds	r0, r0, #4
c0d00e12:	9005      	str	r0, [sp, #20]
c0d00e14:	4e9d      	ldr	r6, [pc, #628]	; (c0d0108c <IOTA_main+0x2a4>)
c0d00e16:	6830      	ldr	r0, [r6, #0]
c0d00e18:	e08d      	b.n	c0d00f36 <IOTA_main+0x14e>
c0d00e1a:	489f      	ldr	r0, [pc, #636]	; (c0d01098 <IOTA_main+0x2b0>)
c0d00e1c:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00e1e:	4330      	orrs	r0, r6
c0d00e20:	2880      	cmp	r0, #128	; 0x80
c0d00e22:	d000      	beq.n	c0d00e26 <IOTA_main+0x3e>
c0d00e24:	e11e      	b.n	c0d01064 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d00e26:	7810      	ldrb	r0, [r2, #0]
c0d00e28:	2800      	cmp	r0, #0
c0d00e2a:	4e98      	ldr	r6, [pc, #608]	; (c0d0108c <IOTA_main+0x2a4>)
c0d00e2c:	d004      	beq.n	c0d00e38 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d00e2e:	489c      	ldr	r0, [pc, #624]	; (c0d010a0 <IOTA_main+0x2b8>)
c0d00e30:	f001 f90c 	bl	c0d0204c <cx_sha256_init>
                        hashTainted = 0;
c0d00e34:	4899      	ldr	r0, [pc, #612]	; (c0d0109c <IOTA_main+0x2b4>)
c0d00e36:	7004      	strb	r4, [r0, #0]
c0d00e38:	4897      	ldr	r0, [pc, #604]	; (c0d01098 <IOTA_main+0x2b0>)
c0d00e3a:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00e3c:	7908      	ldrb	r0, [r1, #4]
c0d00e3e:	1808      	adds	r0, r1, r0
c0d00e40:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00e42:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00e44:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00e46:	4308      	orrs	r0, r1
c0d00e48:	905a      	str	r0, [sp, #360]	; 0x168
c0d00e4a:	e0e5      	b.n	c0d01018 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00e4c:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00e4e:	2818      	cmp	r0, #24
c0d00e50:	d800      	bhi.n	c0d00e54 <IOTA_main+0x6c>
c0d00e52:	e10c      	b.n	c0d0106e <IOTA_main+0x286>
c0d00e54:	950a      	str	r5, [sp, #40]	; 0x28
c0d00e56:	4d90      	ldr	r5, [pc, #576]	; (c0d01098 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00e58:	00a0      	lsls	r0, r4, #2
c0d00e5a:	1829      	adds	r1, r5, r0
c0d00e5c:	794a      	ldrb	r2, [r1, #5]
c0d00e5e:	0612      	lsls	r2, r2, #24
c0d00e60:	798b      	ldrb	r3, [r1, #6]
c0d00e62:	041b      	lsls	r3, r3, #16
c0d00e64:	4313      	orrs	r3, r2
c0d00e66:	79ca      	ldrb	r2, [r1, #7]
c0d00e68:	0212      	lsls	r2, r2, #8
c0d00e6a:	431a      	orrs	r2, r3
c0d00e6c:	7a09      	ldrb	r1, [r1, #8]
c0d00e6e:	4311      	orrs	r1, r2
c0d00e70:	aa2b      	add	r2, sp, #172	; 0xac
c0d00e72:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00e74:	1c64      	adds	r4, r4, #1
c0d00e76:	2c05      	cmp	r4, #5
c0d00e78:	d1ee      	bne.n	c0d00e58 <IOTA_main+0x70>
c0d00e7a:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00e7c:	9103      	str	r1, [sp, #12]
c0d00e7e:	4668      	mov	r0, sp
c0d00e80:	6001      	str	r1, [r0, #0]
c0d00e82:	2421      	movs	r4, #33	; 0x21
c0d00e84:	a92b      	add	r1, sp, #172	; 0xac
c0d00e86:	2205      	movs	r2, #5
c0d00e88:	ad23      	add	r5, sp, #140	; 0x8c
c0d00e8a:	9502      	str	r5, [sp, #8]
c0d00e8c:	4620      	mov	r0, r4
c0d00e8e:	462b      	mov	r3, r5
c0d00e90:	f001 f992 	bl	c0d021b8 <os_perso_derive_node_bip32>
c0d00e94:	2220      	movs	r2, #32
c0d00e96:	9204      	str	r2, [sp, #16]
c0d00e98:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00e9a:	9301      	str	r3, [sp, #4]
c0d00e9c:	4620      	mov	r0, r4
c0d00e9e:	4629      	mov	r1, r5
c0d00ea0:	f001 f94e 	bl	c0d02140 <cx_ecfp_init_private_key>
c0d00ea4:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00ea6:	4620      	mov	r0, r4
c0d00ea8:	9903      	ldr	r1, [sp, #12]
c0d00eaa:	460a      	mov	r2, r1
c0d00eac:	462b      	mov	r3, r5
c0d00eae:	f001 f929 	bl	c0d02104 <cx_ecfp_init_public_key>
c0d00eb2:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00eb4:	4620      	mov	r0, r4
c0d00eb6:	4629      	mov	r1, r5
c0d00eb8:	9a01      	ldr	r2, [sp, #4]
c0d00eba:	f001 f95f 	bl	c0d0217c <cx_ecfp_generate_pair>
c0d00ebe:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00ec0:	9802      	ldr	r0, [sp, #8]
c0d00ec2:	9904      	ldr	r1, [sp, #16]
c0d00ec4:	4622      	mov	r2, r4
c0d00ec6:	f7ff fa5b 	bl	c0d00380 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d00eca:	2552      	movs	r5, #82	; 0x52
c0d00ecc:	4872      	ldr	r0, [pc, #456]	; (c0d01098 <IOTA_main+0x2b0>)
c0d00ece:	4621      	mov	r1, r4
c0d00ed0:	462a      	mov	r2, r5
c0d00ed2:	f000 f9ad 	bl	c0d01230 <os_memmove>
                    tx = 82;
c0d00ed6:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d00ed8:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00eda:	1c41      	adds	r1, r0, #1
c0d00edc:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00ede:	3610      	adds	r6, #16
c0d00ee0:	4a6d      	ldr	r2, [pc, #436]	; (c0d01098 <IOTA_main+0x2b0>)
c0d00ee2:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d00ee4:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00ee6:	1c41      	adds	r1, r0, #1
c0d00ee8:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00eea:	9903      	ldr	r1, [sp, #12]
c0d00eec:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00eee:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00ef0:	b281      	uxth	r1, r0
c0d00ef2:	9804      	ldr	r0, [sp, #16]
c0d00ef4:	f000 fd2a 	bl	c0d0194c <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00ef8:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00efa:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00efc:	4308      	orrs	r0, r1
c0d00efe:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d00f00:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00f02:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d00f04:	202e      	movs	r0, #46	; 0x2e
c0d00f06:	9905      	ldr	r1, [sp, #20]
c0d00f08:	7048      	strb	r0, [r1, #1]
c0d00f0a:	7008      	strb	r0, [r1, #0]
c0d00f0c:	7088      	strb	r0, [r1, #2]
c0d00f0e:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d00f10:	78c8      	ldrb	r0, [r1, #3]
c0d00f12:	9a06      	ldr	r2, [sp, #24]
c0d00f14:	70d0      	strb	r0, [r2, #3]
c0d00f16:	7888      	ldrb	r0, [r1, #2]
c0d00f18:	7090      	strb	r0, [r2, #2]
c0d00f1a:	7848      	ldrb	r0, [r1, #1]
c0d00f1c:	7050      	strb	r0, [r2, #1]
c0d00f1e:	7808      	ldrb	r0, [r1, #0]
c0d00f20:	7010      	strb	r0, [r2, #0]
c0d00f22:	7908      	ldrb	r0, [r1, #4]
c0d00f24:	7110      	strb	r0, [r2, #4]
c0d00f26:	a80b      	add	r0, sp, #44	; 0x2c
                    

                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d00f28:	2140      	movs	r1, #64	; 0x40
c0d00f2a:	2203      	movs	r2, #3
c0d00f2c:	f001 fa8a 	bl	c0d02444 <ui_display_debug>
c0d00f30:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d00f32:	4e56      	ldr	r6, [pc, #344]	; (c0d0108c <IOTA_main+0x2a4>)
c0d00f34:	e070      	b.n	c0d01018 <IOTA_main+0x230>
c0d00f36:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00f38:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00f3a:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00f3c:	ac4d      	add	r4, sp, #308	; 0x134
c0d00f3e:	4620      	mov	r0, r4
c0d00f40:	f002 fd26 	bl	c0d03990 <setjmp>
c0d00f44:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00f46:	6034      	str	r4, [r6, #0]
c0d00f48:	4951      	ldr	r1, [pc, #324]	; (c0d01090 <IOTA_main+0x2a8>)
c0d00f4a:	4208      	tst	r0, r1
c0d00f4c:	d011      	beq.n	c0d00f72 <IOTA_main+0x18a>
c0d00f4e:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00f50:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d00f52:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00f54:	6031      	str	r1, [r6, #0]
c0d00f56:	210f      	movs	r1, #15
c0d00f58:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00f5a:	4001      	ands	r1, r0
c0d00f5c:	2209      	movs	r2, #9
c0d00f5e:	0312      	lsls	r2, r2, #12
c0d00f60:	4291      	cmp	r1, r2
c0d00f62:	d003      	beq.n	c0d00f6c <IOTA_main+0x184>
c0d00f64:	9a08      	ldr	r2, [sp, #32]
c0d00f66:	0352      	lsls	r2, r2, #13
c0d00f68:	4291      	cmp	r1, r2
c0d00f6a:	d142      	bne.n	c0d00ff2 <IOTA_main+0x20a>
c0d00f6c:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00f6e:	8008      	strh	r0, [r1, #0]
c0d00f70:	e046      	b.n	c0d01000 <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00f72:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00f74:	905c      	str	r0, [sp, #368]	; 0x170
c0d00f76:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00f78:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00f7a:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00f7c:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00f7e:	b2c0      	uxtb	r0, r0
c0d00f80:	b289      	uxth	r1, r1
c0d00f82:	f000 fce3 	bl	c0d0194c <io_exchange>
c0d00f86:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00f88:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00f8a:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00f8c:	2800      	cmp	r0, #0
c0d00f8e:	d053      	beq.n	c0d01038 <IOTA_main+0x250>
c0d00f90:	4941      	ldr	r1, [pc, #260]	; (c0d01098 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00f92:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00f94:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00f96:	2880      	cmp	r0, #128	; 0x80
c0d00f98:	4a40      	ldr	r2, [pc, #256]	; (c0d0109c <IOTA_main+0x2b4>)
c0d00f9a:	d155      	bne.n	c0d01048 <IOTA_main+0x260>
c0d00f9c:	7848      	ldrb	r0, [r1, #1]
c0d00f9e:	216d      	movs	r1, #109	; 0x6d
c0d00fa0:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00fa2:	2807      	cmp	r0, #7
c0d00fa4:	dc3f      	bgt.n	c0d01026 <IOTA_main+0x23e>
c0d00fa6:	2802      	cmp	r0, #2
c0d00fa8:	d100      	bne.n	c0d00fac <IOTA_main+0x1c4>
c0d00faa:	e74f      	b.n	c0d00e4c <IOTA_main+0x64>
c0d00fac:	2804      	cmp	r0, #4
c0d00fae:	d153      	bne.n	c0d01058 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00fb0:	210b      	movs	r1, #11
c0d00fb2:	2203      	movs	r2, #3
c0d00fb4:	a03c      	add	r0, pc, #240	; (adr r0, c0d010a8 <IOTA_main+0x2c0>)
c0d00fb6:	f7ff f955 	bl	c0d00264 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d00fba:	2048      	movs	r0, #72	; 0x48
c0d00fbc:	4936      	ldr	r1, [pc, #216]	; (c0d01098 <IOTA_main+0x2b0>)
c0d00fbe:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00fc0:	2049      	movs	r0, #73	; 0x49
c0d00fc2:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d00fc4:	2021      	movs	r0, #33	; 0x21
c0d00fc6:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00fc8:	3610      	adds	r6, #16
c0d00fca:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00fcc:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00fce:	2005      	movs	r0, #5
c0d00fd0:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00fd2:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00fd4:	b281      	uxth	r1, r0
c0d00fd6:	2020      	movs	r0, #32
c0d00fd8:	f000 fcb8 	bl	c0d0194c <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00fdc:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00fde:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00fe0:	4308      	orrs	r0, r1
c0d00fe2:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d00fe4:	4620      	mov	r0, r4
c0d00fe6:	4621      	mov	r1, r4
c0d00fe8:	4622      	mov	r2, r4
c0d00fea:	f001 fa2b 	bl	c0d02444 <ui_display_debug>
c0d00fee:	4e27      	ldr	r6, [pc, #156]	; (c0d0108c <IOTA_main+0x2a4>)
c0d00ff0:	e012      	b.n	c0d01018 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00ff2:	4928      	ldr	r1, [pc, #160]	; (c0d01094 <IOTA_main+0x2ac>)
c0d00ff4:	4008      	ands	r0, r1
c0d00ff6:	210d      	movs	r1, #13
c0d00ff8:	02c9      	lsls	r1, r1, #11
c0d00ffa:	4301      	orrs	r1, r0
c0d00ffc:	a859      	add	r0, sp, #356	; 0x164
c0d00ffe:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d01000:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d01002:	0a00      	lsrs	r0, r0, #8
c0d01004:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d01006:	4a24      	ldr	r2, [pc, #144]	; (c0d01098 <IOTA_main+0x2b0>)
c0d01008:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d0100a:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d0100c:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d0100e:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d01010:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d01012:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d01014:	1c80      	adds	r0, r0, #2
c0d01016:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d01018:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d0101a:	6030      	str	r0, [r6, #0]
c0d0101c:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d0101e:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d01020:	2900      	cmp	r1, #0
c0d01022:	d088      	beq.n	c0d00f36 <IOTA_main+0x14e>
c0d01024:	e006      	b.n	c0d01034 <IOTA_main+0x24c>
c0d01026:	2808      	cmp	r0, #8
c0d01028:	d100      	bne.n	c0d0102c <IOTA_main+0x244>
c0d0102a:	e6f6      	b.n	c0d00e1a <IOTA_main+0x32>
c0d0102c:	28ff      	cmp	r0, #255	; 0xff
c0d0102e:	d113      	bne.n	c0d01058 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d01030:	b05d      	add	sp, #372	; 0x174
c0d01032:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d01034:	f002 fcb8 	bl	c0d039a8 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d01038:	2001      	movs	r0, #1
c0d0103a:	4918      	ldr	r1, [pc, #96]	; (c0d0109c <IOTA_main+0x2b4>)
c0d0103c:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d0103e:	4813      	ldr	r0, [pc, #76]	; (c0d0108c <IOTA_main+0x2a4>)
c0d01040:	6800      	ldr	r0, [r0, #0]
c0d01042:	491c      	ldr	r1, [pc, #112]	; (c0d010b4 <IOTA_main+0x2cc>)
c0d01044:	f002 fcb0 	bl	c0d039a8 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d01048:	2001      	movs	r0, #1
c0d0104a:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d0104c:	480f      	ldr	r0, [pc, #60]	; (c0d0108c <IOTA_main+0x2a4>)
c0d0104e:	6800      	ldr	r0, [r0, #0]
c0d01050:	2137      	movs	r1, #55	; 0x37
c0d01052:	0249      	lsls	r1, r1, #9
c0d01054:	f002 fca8 	bl	c0d039a8 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d01058:	2001      	movs	r0, #1
c0d0105a:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d0105c:	480b      	ldr	r0, [pc, #44]	; (c0d0108c <IOTA_main+0x2a4>)
c0d0105e:	6800      	ldr	r0, [r0, #0]
c0d01060:	f002 fca2 	bl	c0d039a8 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d01064:	4809      	ldr	r0, [pc, #36]	; (c0d0108c <IOTA_main+0x2a4>)
c0d01066:	6800      	ldr	r0, [r0, #0]
c0d01068:	490e      	ldr	r1, [pc, #56]	; (c0d010a4 <IOTA_main+0x2bc>)
c0d0106a:	f002 fc9d 	bl	c0d039a8 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d0106e:	2001      	movs	r0, #1
c0d01070:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d01072:	4806      	ldr	r0, [pc, #24]	; (c0d0108c <IOTA_main+0x2a4>)
c0d01074:	6800      	ldr	r0, [r0, #0]
c0d01076:	3109      	adds	r1, #9
c0d01078:	f002 fc96 	bl	c0d039a8 <longjmp>
c0d0107c:	74696157 	.word	0x74696157
c0d01080:	20676e69 	.word	0x20676e69
c0d01084:	20726f66 	.word	0x20726f66
c0d01088:	0067736d 	.word	0x0067736d
c0d0108c:	20001bb8 	.word	0x20001bb8
c0d01090:	0000ffff 	.word	0x0000ffff
c0d01094:	000007ff 	.word	0x000007ff
c0d01098:	20001c08 	.word	0x20001c08
c0d0109c:	20001b48 	.word	0x20001b48
c0d010a0:	20001b4c 	.word	0x20001b4c
c0d010a4:	00006a86 	.word	0x00006a86
c0d010a8:	20646142 	.word	0x20646142
c0d010ac:	6b627550 	.word	0x6b627550
c0d010b0:	00007965 	.word	0x00007965
c0d010b4:	00006982 	.word	0x00006982

c0d010b8 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d010b8:	4801      	ldr	r0, [pc, #4]	; (c0d010c0 <os_boot+0x8>)
c0d010ba:	2100      	movs	r1, #0
c0d010bc:	6001      	str	r1, [r0, #0]
}
c0d010be:	4770      	bx	lr
c0d010c0:	20001bb8 	.word	0x20001bb8

c0d010c4 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d010c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d010c6:	af03      	add	r7, sp, #12
c0d010c8:	b083      	sub	sp, #12
c0d010ca:	9202      	str	r2, [sp, #8]
c0d010cc:	460c      	mov	r4, r1
c0d010ce:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d010d0:	4d4a      	ldr	r5, [pc, #296]	; (c0d011fc <io_usb_hid_receive+0x138>)
c0d010d2:	42ac      	cmp	r4, r5
c0d010d4:	d00f      	beq.n	c0d010f6 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d010d6:	4e49      	ldr	r6, [pc, #292]	; (c0d011fc <io_usb_hid_receive+0x138>)
c0d010d8:	2540      	movs	r5, #64	; 0x40
c0d010da:	4630      	mov	r0, r6
c0d010dc:	4629      	mov	r1, r5
c0d010de:	f002 fbc1 	bl	c0d03864 <__aeabi_memclr>
c0d010e2:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d010e4:	2840      	cmp	r0, #64	; 0x40
c0d010e6:	4602      	mov	r2, r0
c0d010e8:	d300      	bcc.n	c0d010ec <io_usb_hid_receive+0x28>
c0d010ea:	462a      	mov	r2, r5
c0d010ec:	4630      	mov	r0, r6
c0d010ee:	4621      	mov	r1, r4
c0d010f0:	f000 f89e 	bl	c0d01230 <os_memmove>
c0d010f4:	4d41      	ldr	r5, [pc, #260]	; (c0d011fc <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d010f6:	78a8      	ldrb	r0, [r5, #2]
c0d010f8:	2805      	cmp	r0, #5
c0d010fa:	d900      	bls.n	c0d010fe <io_usb_hid_receive+0x3a>
c0d010fc:	e076      	b.n	c0d011ec <io_usb_hid_receive+0x128>
c0d010fe:	46c0      	nop			; (mov r8, r8)
c0d01100:	4478      	add	r0, pc
c0d01102:	7900      	ldrb	r0, [r0, #4]
c0d01104:	0040      	lsls	r0, r0, #1
c0d01106:	4487      	add	pc, r0
c0d01108:	71130c02 	.word	0x71130c02
c0d0110c:	1f71      	.short	0x1f71
c0d0110e:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01110:	71ae      	strb	r6, [r5, #6]
c0d01112:	716e      	strb	r6, [r5, #5]
c0d01114:	712e      	strb	r6, [r5, #4]
c0d01116:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d01118:	2140      	movs	r1, #64	; 0x40
c0d0111a:	4628      	mov	r0, r5
c0d0111c:	9a01      	ldr	r2, [sp, #4]
c0d0111e:	4790      	blx	r2
c0d01120:	e00b      	b.n	c0d0113a <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d01122:	1ce8      	adds	r0, r5, #3
c0d01124:	2104      	movs	r1, #4
c0d01126:	f000 ff73 	bl	c0d02010 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d0112a:	2140      	movs	r1, #64	; 0x40
c0d0112c:	4628      	mov	r0, r5
c0d0112e:	e001      	b.n	c0d01134 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d01130:	4832      	ldr	r0, [pc, #200]	; (c0d011fc <io_usb_hid_receive+0x138>)
c0d01132:	2140      	movs	r1, #64	; 0x40
c0d01134:	9a01      	ldr	r2, [sp, #4]
c0d01136:	4790      	blx	r2
c0d01138:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d0113a:	4831      	ldr	r0, [pc, #196]	; (c0d01200 <io_usb_hid_receive+0x13c>)
c0d0113c:	2100      	movs	r1, #0
c0d0113e:	6001      	str	r1, [r0, #0]
c0d01140:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d01142:	b2c0      	uxtb	r0, r0
c0d01144:	b003      	add	sp, #12
c0d01146:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d01148:	78e8      	ldrb	r0, [r5, #3]
c0d0114a:	4c2d      	ldr	r4, [pc, #180]	; (c0d01200 <io_usb_hid_receive+0x13c>)
c0d0114c:	6821      	ldr	r1, [r4, #0]
c0d0114e:	0a09      	lsrs	r1, r1, #8
c0d01150:	2600      	movs	r6, #0
c0d01152:	4288      	cmp	r0, r1
c0d01154:	d1f1      	bne.n	c0d0113a <io_usb_hid_receive+0x76>
c0d01156:	7928      	ldrb	r0, [r5, #4]
c0d01158:	6821      	ldr	r1, [r4, #0]
c0d0115a:	b2c9      	uxtb	r1, r1
c0d0115c:	4288      	cmp	r0, r1
c0d0115e:	d1ec      	bne.n	c0d0113a <io_usb_hid_receive+0x76>
c0d01160:	4b28      	ldr	r3, [pc, #160]	; (c0d01204 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d01162:	9802      	ldr	r0, [sp, #8]
c0d01164:	18c0      	adds	r0, r0, r3
c0d01166:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d01168:	6820      	ldr	r0, [r4, #0]
c0d0116a:	2800      	cmp	r0, #0
c0d0116c:	d00e      	beq.n	c0d0118c <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d0116e:	4629      	mov	r1, r5
c0d01170:	4019      	ands	r1, r3
c0d01172:	4825      	ldr	r0, [pc, #148]	; (c0d01208 <io_usb_hid_receive+0x144>)
c0d01174:	6802      	ldr	r2, [r0, #0]
c0d01176:	4291      	cmp	r1, r2
c0d01178:	461e      	mov	r6, r3
c0d0117a:	d900      	bls.n	c0d0117e <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d0117c:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d0117e:	462a      	mov	r2, r5
c0d01180:	4032      	ands	r2, r6
c0d01182:	4822      	ldr	r0, [pc, #136]	; (c0d0120c <io_usb_hid_receive+0x148>)
c0d01184:	6800      	ldr	r0, [r0, #0]
c0d01186:	491d      	ldr	r1, [pc, #116]	; (c0d011fc <io_usb_hid_receive+0x138>)
c0d01188:	1d49      	adds	r1, r1, #5
c0d0118a:	e021      	b.n	c0d011d0 <io_usb_hid_receive+0x10c>
c0d0118c:	9301      	str	r3, [sp, #4]
c0d0118e:	491b      	ldr	r1, [pc, #108]	; (c0d011fc <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d01190:	7988      	ldrb	r0, [r1, #6]
c0d01192:	7949      	ldrb	r1, [r1, #5]
c0d01194:	0209      	lsls	r1, r1, #8
c0d01196:	4301      	orrs	r1, r0
c0d01198:	481d      	ldr	r0, [pc, #116]	; (c0d01210 <io_usb_hid_receive+0x14c>)
c0d0119a:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d0119c:	6801      	ldr	r1, [r0, #0]
c0d0119e:	2241      	movs	r2, #65	; 0x41
c0d011a0:	0092      	lsls	r2, r2, #2
c0d011a2:	4291      	cmp	r1, r2
c0d011a4:	d8c9      	bhi.n	c0d0113a <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d011a6:	6801      	ldr	r1, [r0, #0]
c0d011a8:	4817      	ldr	r0, [pc, #92]	; (c0d01208 <io_usb_hid_receive+0x144>)
c0d011aa:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d011ac:	4917      	ldr	r1, [pc, #92]	; (c0d0120c <io_usb_hid_receive+0x148>)
c0d011ae:	4a19      	ldr	r2, [pc, #100]	; (c0d01214 <io_usb_hid_receive+0x150>)
c0d011b0:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d011b2:	4919      	ldr	r1, [pc, #100]	; (c0d01218 <io_usb_hid_receive+0x154>)
c0d011b4:	9a02      	ldr	r2, [sp, #8]
c0d011b6:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d011b8:	4629      	mov	r1, r5
c0d011ba:	9e01      	ldr	r6, [sp, #4]
c0d011bc:	4031      	ands	r1, r6
c0d011be:	6802      	ldr	r2, [r0, #0]
c0d011c0:	4291      	cmp	r1, r2
c0d011c2:	d900      	bls.n	c0d011c6 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d011c4:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d011c6:	462a      	mov	r2, r5
c0d011c8:	4032      	ands	r2, r6
c0d011ca:	480c      	ldr	r0, [pc, #48]	; (c0d011fc <io_usb_hid_receive+0x138>)
c0d011cc:	1dc1      	adds	r1, r0, #7
c0d011ce:	4811      	ldr	r0, [pc, #68]	; (c0d01214 <io_usb_hid_receive+0x150>)
c0d011d0:	f000 f82e 	bl	c0d01230 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d011d4:	4035      	ands	r5, r6
c0d011d6:	480d      	ldr	r0, [pc, #52]	; (c0d0120c <io_usb_hid_receive+0x148>)
c0d011d8:	6801      	ldr	r1, [r0, #0]
c0d011da:	1949      	adds	r1, r1, r5
c0d011dc:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d011de:	480a      	ldr	r0, [pc, #40]	; (c0d01208 <io_usb_hid_receive+0x144>)
c0d011e0:	6801      	ldr	r1, [r0, #0]
c0d011e2:	1b49      	subs	r1, r1, r5
c0d011e4:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d011e6:	6820      	ldr	r0, [r4, #0]
c0d011e8:	1c40      	adds	r0, r0, #1
c0d011ea:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d011ec:	4806      	ldr	r0, [pc, #24]	; (c0d01208 <io_usb_hid_receive+0x144>)
c0d011ee:	6801      	ldr	r1, [r0, #0]
c0d011f0:	2001      	movs	r0, #1
c0d011f2:	2602      	movs	r6, #2
c0d011f4:	2900      	cmp	r1, #0
c0d011f6:	d1a4      	bne.n	c0d01142 <io_usb_hid_receive+0x7e>
c0d011f8:	e79f      	b.n	c0d0113a <io_usb_hid_receive+0x76>
c0d011fa:	46c0      	nop			; (mov r8, r8)
c0d011fc:	20001bbc 	.word	0x20001bbc
c0d01200:	20001bfc 	.word	0x20001bfc
c0d01204:	0000ffff 	.word	0x0000ffff
c0d01208:	20001c04 	.word	0x20001c04
c0d0120c:	20001d0c 	.word	0x20001d0c
c0d01210:	20001c00 	.word	0x20001c00
c0d01214:	20001c08 	.word	0x20001c08
c0d01218:	0001fff9 	.word	0x0001fff9

c0d0121c <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d0121c:	b580      	push	{r7, lr}
c0d0121e:	af00      	add	r7, sp, #0
c0d01220:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d01222:	2a00      	cmp	r2, #0
c0d01224:	d003      	beq.n	c0d0122e <os_memset+0x12>
    DSTCHAR[length] = c;
c0d01226:	4611      	mov	r1, r2
c0d01228:	461a      	mov	r2, r3
c0d0122a:	f002 fb25 	bl	c0d03878 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d0122e:	bd80      	pop	{r7, pc}

c0d01230 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d01230:	b5b0      	push	{r4, r5, r7, lr}
c0d01232:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d01234:	4288      	cmp	r0, r1
c0d01236:	d90d      	bls.n	c0d01254 <os_memmove+0x24>
    while(length--) {
c0d01238:	2a00      	cmp	r2, #0
c0d0123a:	d014      	beq.n	c0d01266 <os_memmove+0x36>
c0d0123c:	1e49      	subs	r1, r1, #1
c0d0123e:	4252      	negs	r2, r2
c0d01240:	1e40      	subs	r0, r0, #1
c0d01242:	2300      	movs	r3, #0
c0d01244:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d01246:	461c      	mov	r4, r3
c0d01248:	4354      	muls	r4, r2
c0d0124a:	5d0d      	ldrb	r5, [r1, r4]
c0d0124c:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d0124e:	1c52      	adds	r2, r2, #1
c0d01250:	d1f9      	bne.n	c0d01246 <os_memmove+0x16>
c0d01252:	e008      	b.n	c0d01266 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01254:	2a00      	cmp	r2, #0
c0d01256:	d006      	beq.n	c0d01266 <os_memmove+0x36>
c0d01258:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d0125a:	b29c      	uxth	r4, r3
c0d0125c:	5d0d      	ldrb	r5, [r1, r4]
c0d0125e:	5505      	strb	r5, [r0, r4]
      l++;
c0d01260:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01262:	1e52      	subs	r2, r2, #1
c0d01264:	d1f9      	bne.n	c0d0125a <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d01266:	bdb0      	pop	{r4, r5, r7, pc}

c0d01268 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01268:	4801      	ldr	r0, [pc, #4]	; (c0d01270 <io_usb_hid_init+0x8>)
c0d0126a:	2100      	movs	r1, #0
c0d0126c:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d0126e:	4770      	bx	lr
c0d01270:	20001bfc 	.word	0x20001bfc

c0d01274 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d01274:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01276:	af03      	add	r7, sp, #12
c0d01278:	b087      	sub	sp, #28
c0d0127a:	9301      	str	r3, [sp, #4]
c0d0127c:	9203      	str	r2, [sp, #12]
c0d0127e:	460e      	mov	r6, r1
c0d01280:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d01282:	2e00      	cmp	r6, #0
c0d01284:	d042      	beq.n	c0d0130c <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d01286:	4d31      	ldr	r5, [pc, #196]	; (c0d0134c <io_usb_hid_exchange+0xd8>)
c0d01288:	2000      	movs	r0, #0
c0d0128a:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d0128c:	4930      	ldr	r1, [pc, #192]	; (c0d01350 <io_usb_hid_exchange+0xdc>)
c0d0128e:	4831      	ldr	r0, [pc, #196]	; (c0d01354 <io_usb_hid_exchange+0xe0>)
c0d01290:	6008      	str	r0, [r1, #0]
c0d01292:	4c31      	ldr	r4, [pc, #196]	; (c0d01358 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01294:	1d60      	adds	r0, r4, #5
c0d01296:	213b      	movs	r1, #59	; 0x3b
c0d01298:	9005      	str	r0, [sp, #20]
c0d0129a:	9102      	str	r1, [sp, #8]
c0d0129c:	f002 fae2 	bl	c0d03864 <__aeabi_memclr>
c0d012a0:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d012a2:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d012a4:	6828      	ldr	r0, [r5, #0]
c0d012a6:	0a00      	lsrs	r0, r0, #8
c0d012a8:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d012aa:	6828      	ldr	r0, [r5, #0]
c0d012ac:	7120      	strb	r0, [r4, #4]
c0d012ae:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d012b0:	6828      	ldr	r0, [r5, #0]
c0d012b2:	2800      	cmp	r0, #0
c0d012b4:	9106      	str	r1, [sp, #24]
c0d012b6:	d009      	beq.n	c0d012cc <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d012b8:	293b      	cmp	r1, #59	; 0x3b
c0d012ba:	460a      	mov	r2, r1
c0d012bc:	d300      	bcc.n	c0d012c0 <io_usb_hid_exchange+0x4c>
c0d012be:	9a02      	ldr	r2, [sp, #8]
c0d012c0:	4823      	ldr	r0, [pc, #140]	; (c0d01350 <io_usb_hid_exchange+0xdc>)
c0d012c2:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d012c4:	6819      	ldr	r1, [r3, #0]
c0d012c6:	9805      	ldr	r0, [sp, #20]
c0d012c8:	461e      	mov	r6, r3
c0d012ca:	e00a      	b.n	c0d012e2 <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d012cc:	0a30      	lsrs	r0, r6, #8
c0d012ce:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d012d0:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d012d2:	2039      	movs	r0, #57	; 0x39
c0d012d4:	2939      	cmp	r1, #57	; 0x39
c0d012d6:	460a      	mov	r2, r1
c0d012d8:	d300      	bcc.n	c0d012dc <io_usb_hid_exchange+0x68>
c0d012da:	4602      	mov	r2, r0
c0d012dc:	4e1c      	ldr	r6, [pc, #112]	; (c0d01350 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d012de:	6831      	ldr	r1, [r6, #0]
c0d012e0:	1de0      	adds	r0, r4, #7
c0d012e2:	9205      	str	r2, [sp, #20]
c0d012e4:	f7ff ffa4 	bl	c0d01230 <os_memmove>
c0d012e8:	4d18      	ldr	r5, [pc, #96]	; (c0d0134c <io_usb_hid_exchange+0xd8>)
c0d012ea:	6830      	ldr	r0, [r6, #0]
c0d012ec:	4631      	mov	r1, r6
c0d012ee:	9e05      	ldr	r6, [sp, #20]
c0d012f0:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d012f2:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d012f4:	6828      	ldr	r0, [r5, #0]
c0d012f6:	1c40      	adds	r0, r0, #1
c0d012f8:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d012fa:	2140      	movs	r1, #64	; 0x40
c0d012fc:	4620      	mov	r0, r4
c0d012fe:	9a04      	ldr	r2, [sp, #16]
c0d01300:	4790      	blx	r2
c0d01302:	9806      	ldr	r0, [sp, #24]
c0d01304:	1b86      	subs	r6, r0, r6
c0d01306:	4815      	ldr	r0, [pc, #84]	; (c0d0135c <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d01308:	4206      	tst	r6, r0
c0d0130a:	d1c3      	bne.n	c0d01294 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d0130c:	480f      	ldr	r0, [pc, #60]	; (c0d0134c <io_usb_hid_exchange+0xd8>)
c0d0130e:	2400      	movs	r4, #0
c0d01310:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d01312:	2080      	movs	r0, #128	; 0x80
c0d01314:	9901      	ldr	r1, [sp, #4]
c0d01316:	4201      	tst	r1, r0
c0d01318:	d001      	beq.n	c0d0131e <io_usb_hid_exchange+0xaa>
    reset();
c0d0131a:	f000 fe3f 	bl	c0d01f9c <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d0131e:	9801      	ldr	r0, [sp, #4]
c0d01320:	0680      	lsls	r0, r0, #26
c0d01322:	d40f      	bmi.n	c0d01344 <io_usb_hid_exchange+0xd0>
c0d01324:	4c0c      	ldr	r4, [pc, #48]	; (c0d01358 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d01326:	2140      	movs	r1, #64	; 0x40
c0d01328:	4620      	mov	r0, r4
c0d0132a:	9a03      	ldr	r2, [sp, #12]
c0d0132c:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d0132e:	b2c2      	uxtb	r2, r0
c0d01330:	2a40      	cmp	r2, #64	; 0x40
c0d01332:	d8f8      	bhi.n	c0d01326 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d01334:	9804      	ldr	r0, [sp, #16]
c0d01336:	4621      	mov	r1, r4
c0d01338:	f7ff fec4 	bl	c0d010c4 <io_usb_hid_receive>
c0d0133c:	2802      	cmp	r0, #2
c0d0133e:	d1f2      	bne.n	c0d01326 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d01340:	4807      	ldr	r0, [pc, #28]	; (c0d01360 <io_usb_hid_exchange+0xec>)
c0d01342:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d01344:	b2a0      	uxth	r0, r4
c0d01346:	b007      	add	sp, #28
c0d01348:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0134a:	46c0      	nop			; (mov r8, r8)
c0d0134c:	20001bfc 	.word	0x20001bfc
c0d01350:	20001d0c 	.word	0x20001d0c
c0d01354:	20001c08 	.word	0x20001c08
c0d01358:	20001bbc 	.word	0x20001bbc
c0d0135c:	0000ffff 	.word	0x0000ffff
c0d01360:	20001c00 	.word	0x20001c00

c0d01364 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d01364:	b580      	push	{r7, lr}
c0d01366:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d01368:	f000 ffbc 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d0136c:	2800      	cmp	r0, #0
c0d0136e:	d10b      	bne.n	c0d01388 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d01370:	4806      	ldr	r0, [pc, #24]	; (c0d0138c <io_seproxyhal_general_status+0x28>)
c0d01372:	2160      	movs	r1, #96	; 0x60
c0d01374:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d01376:	2100      	movs	r1, #0
c0d01378:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d0137a:	2202      	movs	r2, #2
c0d0137c:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d0137e:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d01380:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d01382:	2105      	movs	r1, #5
c0d01384:	f000 ff90 	bl	c0d022a8 <io_seproxyhal_spi_send>
}
c0d01388:	bd80      	pop	{r7, pc}
c0d0138a:	46c0      	nop			; (mov r8, r8)
c0d0138c:	20001a18 	.word	0x20001a18

c0d01390 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d01390:	b5d0      	push	{r4, r6, r7, lr}
c0d01392:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d01394:	4815      	ldr	r0, [pc, #84]	; (c0d013ec <io_seproxyhal_handle_usb_event+0x5c>)
c0d01396:	78c0      	ldrb	r0, [r0, #3]
c0d01398:	1e40      	subs	r0, r0, #1
c0d0139a:	2807      	cmp	r0, #7
c0d0139c:	d824      	bhi.n	c0d013e8 <io_seproxyhal_handle_usb_event+0x58>
c0d0139e:	46c0      	nop			; (mov r8, r8)
c0d013a0:	4478      	add	r0, pc
c0d013a2:	7900      	ldrb	r0, [r0, #4]
c0d013a4:	0040      	lsls	r0, r0, #1
c0d013a6:	4487      	add	pc, r0
c0d013a8:	141f1803 	.word	0x141f1803
c0d013ac:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d013b0:	4c0f      	ldr	r4, [pc, #60]	; (c0d013f0 <io_seproxyhal_handle_usb_event+0x60>)
c0d013b2:	2101      	movs	r1, #1
c0d013b4:	4620      	mov	r0, r4
c0d013b6:	f001 fbd5 	bl	c0d02b64 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d013ba:	4620      	mov	r0, r4
c0d013bc:	f001 fbba 	bl	c0d02b34 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d013c0:	480c      	ldr	r0, [pc, #48]	; (c0d013f4 <io_seproxyhal_handle_usb_event+0x64>)
c0d013c2:	7800      	ldrb	r0, [r0, #0]
c0d013c4:	2801      	cmp	r0, #1
c0d013c6:	d10f      	bne.n	c0d013e8 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d013c8:	480b      	ldr	r0, [pc, #44]	; (c0d013f8 <io_seproxyhal_handle_usb_event+0x68>)
c0d013ca:	6800      	ldr	r0, [r0, #0]
c0d013cc:	2110      	movs	r1, #16
c0d013ce:	f002 faeb 	bl	c0d039a8 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d013d2:	4807      	ldr	r0, [pc, #28]	; (c0d013f0 <io_seproxyhal_handle_usb_event+0x60>)
c0d013d4:	f001 fbc9 	bl	c0d02b6a <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d013d8:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d013da:	4805      	ldr	r0, [pc, #20]	; (c0d013f0 <io_seproxyhal_handle_usb_event+0x60>)
c0d013dc:	f001 fbc9 	bl	c0d02b72 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d013e0:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d013e2:	4803      	ldr	r0, [pc, #12]	; (c0d013f0 <io_seproxyhal_handle_usb_event+0x60>)
c0d013e4:	f001 fbc3 	bl	c0d02b6e <USBD_LL_Resume>
      break;
  }
}
c0d013e8:	bdd0      	pop	{r4, r6, r7, pc}
c0d013ea:	46c0      	nop			; (mov r8, r8)
c0d013ec:	20001a18 	.word	0x20001a18
c0d013f0:	20001d34 	.word	0x20001d34
c0d013f4:	20001d10 	.word	0x20001d10
c0d013f8:	20001bb8 	.word	0x20001bb8

c0d013fc <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d013fc:	217f      	movs	r1, #127	; 0x7f
c0d013fe:	4001      	ands	r1, r0
c0d01400:	4801      	ldr	r0, [pc, #4]	; (c0d01408 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d01402:	5c40      	ldrb	r0, [r0, r1]
c0d01404:	4770      	bx	lr
c0d01406:	46c0      	nop			; (mov r8, r8)
c0d01408:	20001d11 	.word	0x20001d11

c0d0140c <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d0140c:	b580      	push	{r7, lr}
c0d0140e:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d01410:	480f      	ldr	r0, [pc, #60]	; (c0d01450 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d01412:	7901      	ldrb	r1, [r0, #4]
c0d01414:	2904      	cmp	r1, #4
c0d01416:	d008      	beq.n	c0d0142a <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d01418:	2902      	cmp	r1, #2
c0d0141a:	d011      	beq.n	c0d01440 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d0141c:	2901      	cmp	r1, #1
c0d0141e:	d10e      	bne.n	c0d0143e <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d01420:	1d81      	adds	r1, r0, #6
c0d01422:	480d      	ldr	r0, [pc, #52]	; (c0d01458 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01424:	f001 faaa 	bl	c0d0297c <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d01428:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d0142a:	78c2      	ldrb	r2, [r0, #3]
c0d0142c:	217f      	movs	r1, #127	; 0x7f
c0d0142e:	4011      	ands	r1, r2
c0d01430:	7942      	ldrb	r2, [r0, #5]
c0d01432:	4b08      	ldr	r3, [pc, #32]	; (c0d01454 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d01434:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01436:	1d82      	adds	r2, r0, #6
c0d01438:	4807      	ldr	r0, [pc, #28]	; (c0d01458 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d0143a:	f001 fad1 	bl	c0d029e0 <USBD_LL_DataOutStage>
      break;
  }
}
c0d0143e:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01440:	78c2      	ldrb	r2, [r0, #3]
c0d01442:	217f      	movs	r1, #127	; 0x7f
c0d01444:	4011      	ands	r1, r2
c0d01446:	1d82      	adds	r2, r0, #6
c0d01448:	4803      	ldr	r0, [pc, #12]	; (c0d01458 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d0144a:	f001 fb0f 	bl	c0d02a6c <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d0144e:	bd80      	pop	{r7, pc}
c0d01450:	20001a18 	.word	0x20001a18
c0d01454:	20001d11 	.word	0x20001d11
c0d01458:	20001d34 	.word	0x20001d34

c0d0145c <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d0145c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0145e:	af03      	add	r7, sp, #12
c0d01460:	b083      	sub	sp, #12
c0d01462:	9201      	str	r2, [sp, #4]
c0d01464:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d01466:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d01468:	2b00      	cmp	r3, #0
c0d0146a:	d100      	bne.n	c0d0146e <io_usb_send_ep+0x12>
c0d0146c:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d0146e:	9801      	ldr	r0, [sp, #4]
c0d01470:	28ff      	cmp	r0, #255	; 0xff
c0d01472:	d843      	bhi.n	c0d014fc <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01474:	4e25      	ldr	r6, [pc, #148]	; (c0d0150c <io_usb_send_ep+0xb0>)
c0d01476:	2050      	movs	r0, #80	; 0x50
c0d01478:	7030      	strb	r0, [r6, #0]
c0d0147a:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d0147c:	1ce0      	adds	r0, r4, #3
c0d0147e:	9100      	str	r1, [sp, #0]
c0d01480:	0a01      	lsrs	r1, r0, #8
c0d01482:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d01484:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d01486:	2080      	movs	r0, #128	; 0x80
c0d01488:	4302      	orrs	r2, r0
c0d0148a:	9202      	str	r2, [sp, #8]
c0d0148c:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0148e:	2020      	movs	r0, #32
c0d01490:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d01492:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d01494:	2106      	movs	r1, #6
c0d01496:	4630      	mov	r0, r6
c0d01498:	f000 ff06 	bl	c0d022a8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d0149c:	9800      	ldr	r0, [sp, #0]
c0d0149e:	4621      	mov	r1, r4
c0d014a0:	f000 ff02 	bl	c0d022a8 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d014a4:	2d00      	cmp	r5, #0
c0d014a6:	d10d      	bne.n	c0d014c4 <io_usb_send_ep+0x68>
c0d014a8:	e028      	b.n	c0d014fc <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d014aa:	2d00      	cmp	r5, #0
c0d014ac:	d002      	beq.n	c0d014b4 <io_usb_send_ep+0x58>
c0d014ae:	1e6c      	subs	r4, r5, #1
c0d014b0:	2d01      	cmp	r5, #1
c0d014b2:	d025      	beq.n	c0d01500 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d014b4:	2915      	cmp	r1, #21
c0d014b6:	d102      	bne.n	c0d014be <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d014b8:	79b0      	ldrb	r0, [r6, #6]
c0d014ba:	0700      	lsls	r0, r0, #28
c0d014bc:	d520      	bpl.n	c0d01500 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d014be:	f000 f829 	bl	c0d01514 <io_seproxyhal_handle_event>
c0d014c2:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d014c4:	f000 ff0e 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d014c8:	2800      	cmp	r0, #0
c0d014ca:	d101      	bne.n	c0d014d0 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d014cc:	f7ff ff4a 	bl	c0d01364 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d014d0:	2180      	movs	r1, #128	; 0x80
c0d014d2:	2400      	movs	r4, #0
c0d014d4:	4630      	mov	r0, r6
c0d014d6:	4622      	mov	r2, r4
c0d014d8:	f000 ff20 	bl	c0d0231c <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d014dc:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d014de:	2806      	cmp	r0, #6
c0d014e0:	d1e3      	bne.n	c0d014aa <io_usb_send_ep+0x4e>
c0d014e2:	2910      	cmp	r1, #16
c0d014e4:	d1e1      	bne.n	c0d014aa <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d014e6:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d014e8:	9a02      	ldr	r2, [sp, #8]
c0d014ea:	4290      	cmp	r0, r2
c0d014ec:	d1dd      	bne.n	c0d014aa <io_usb_send_ep+0x4e>
c0d014ee:	7930      	ldrb	r0, [r6, #4]
c0d014f0:	2802      	cmp	r0, #2
c0d014f2:	d1da      	bne.n	c0d014aa <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d014f4:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d014f6:	9a01      	ldr	r2, [sp, #4]
c0d014f8:	4290      	cmp	r0, r2
c0d014fa:	d1d6      	bne.n	c0d014aa <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d014fc:	b003      	add	sp, #12
c0d014fe:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01500:	4803      	ldr	r0, [pc, #12]	; (c0d01510 <io_usb_send_ep+0xb4>)
c0d01502:	6800      	ldr	r0, [r0, #0]
c0d01504:	2110      	movs	r1, #16
c0d01506:	f002 fa4f 	bl	c0d039a8 <longjmp>
c0d0150a:	46c0      	nop			; (mov r8, r8)
c0d0150c:	20001a18 	.word	0x20001a18
c0d01510:	20001bb8 	.word	0x20001bb8

c0d01514 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d01514:	b580      	push	{r7, lr}
c0d01516:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d01518:	480d      	ldr	r0, [pc, #52]	; (c0d01550 <io_seproxyhal_handle_event+0x3c>)
c0d0151a:	7882      	ldrb	r2, [r0, #2]
c0d0151c:	7841      	ldrb	r1, [r0, #1]
c0d0151e:	0209      	lsls	r1, r1, #8
c0d01520:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01522:	7800      	ldrb	r0, [r0, #0]
c0d01524:	2810      	cmp	r0, #16
c0d01526:	d008      	beq.n	c0d0153a <io_seproxyhal_handle_event+0x26>
c0d01528:	280f      	cmp	r0, #15
c0d0152a:	d10d      	bne.n	c0d01548 <io_seproxyhal_handle_event+0x34>
c0d0152c:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d0152e:	2904      	cmp	r1, #4
c0d01530:	d10d      	bne.n	c0d0154e <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d01532:	f7ff ff2d 	bl	c0d01390 <io_seproxyhal_handle_usb_event>
c0d01536:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01538:	bd80      	pop	{r7, pc}
c0d0153a:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d0153c:	2906      	cmp	r1, #6
c0d0153e:	d306      	bcc.n	c0d0154e <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d01540:	f7ff ff64 	bl	c0d0140c <io_seproxyhal_handle_usb_ep_xfer_event>
c0d01544:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01546:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d01548:	2002      	movs	r0, #2
c0d0154a:	f7ff faf5 	bl	c0d00b38 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d0154e:	bd80      	pop	{r7, pc}
c0d01550:	20001a18 	.word	0x20001a18

c0d01554 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01554:	b580      	push	{r7, lr}
c0d01556:	af00      	add	r7, sp, #0
c0d01558:	460a      	mov	r2, r1
c0d0155a:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d0155c:	2082      	movs	r0, #130	; 0x82
c0d0155e:	2314      	movs	r3, #20
c0d01560:	f7ff ff7c 	bl	c0d0145c <io_usb_send_ep>
}
c0d01564:	bd80      	pop	{r7, pc}
	...

c0d01568 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01568:	b5d0      	push	{r4, r6, r7, lr}
c0d0156a:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d0156c:	2007      	movs	r0, #7
c0d0156e:	f000 fcf7 	bl	c0d01f60 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d01572:	480a      	ldr	r0, [pc, #40]	; (c0d0159c <io_seproxyhal_init+0x34>)
c0d01574:	2400      	movs	r4, #0
c0d01576:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01578:	4809      	ldr	r0, [pc, #36]	; (c0d015a0 <io_seproxyhal_init+0x38>)
c0d0157a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d0157c:	4809      	ldr	r0, [pc, #36]	; (c0d015a4 <io_seproxyhal_init+0x3c>)
c0d0157e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d01580:	4809      	ldr	r0, [pc, #36]	; (c0d015a8 <io_seproxyhal_init+0x40>)
c0d01582:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01584:	4809      	ldr	r0, [pc, #36]	; (c0d015ac <io_seproxyhal_init+0x44>)
c0d01586:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d01588:	f7ff fe6e 	bl	c0d01268 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d0158c:	4808      	ldr	r0, [pc, #32]	; (c0d015b0 <io_seproxyhal_init+0x48>)
c0d0158e:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d01590:	4808      	ldr	r0, [pc, #32]	; (c0d015b4 <io_seproxyhal_init+0x4c>)
c0d01592:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d01594:	4808      	ldr	r0, [pc, #32]	; (c0d015b8 <io_seproxyhal_init+0x50>)
c0d01596:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d01598:	bdd0      	pop	{r4, r6, r7, pc}
c0d0159a:	46c0      	nop			; (mov r8, r8)
c0d0159c:	20001d18 	.word	0x20001d18
c0d015a0:	20001d1a 	.word	0x20001d1a
c0d015a4:	20001d1c 	.word	0x20001d1c
c0d015a8:	20001d1e 	.word	0x20001d1e
c0d015ac:	20001d10 	.word	0x20001d10
c0d015b0:	20001d20 	.word	0x20001d20
c0d015b4:	20001d24 	.word	0x20001d24
c0d015b8:	20001d28 	.word	0x20001d28

c0d015bc <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d015bc:	4801      	ldr	r0, [pc, #4]	; (c0d015c4 <io_seproxyhal_init_ux+0x8>)
c0d015be:	2100      	movs	r1, #0
c0d015c0:	6001      	str	r1, [r0, #0]

}
c0d015c2:	4770      	bx	lr
c0d015c4:	20001d20 	.word	0x20001d20

c0d015c8 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d015c8:	b5b0      	push	{r4, r5, r7, lr}
c0d015ca:	af02      	add	r7, sp, #8
c0d015cc:	460d      	mov	r5, r1
c0d015ce:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d015d0:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d015d2:	2800      	cmp	r0, #0
c0d015d4:	d00c      	beq.n	c0d015f0 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d015d6:	f000 fcab 	bl	c0d01f30 <pic>
c0d015da:	4601      	mov	r1, r0
c0d015dc:	4620      	mov	r0, r4
c0d015de:	4788      	blx	r1
c0d015e0:	f000 fca6 	bl	c0d01f30 <pic>
c0d015e4:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d015e6:	2800      	cmp	r0, #0
c0d015e8:	d010      	beq.n	c0d0160c <io_seproxyhal_touch_out+0x44>
c0d015ea:	2801      	cmp	r0, #1
c0d015ec:	d000      	beq.n	c0d015f0 <io_seproxyhal_touch_out+0x28>
c0d015ee:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d015f0:	2d00      	cmp	r5, #0
c0d015f2:	d007      	beq.n	c0d01604 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d015f4:	4620      	mov	r0, r4
c0d015f6:	47a8      	blx	r5
c0d015f8:	2100      	movs	r1, #0
    if (!el) {
c0d015fa:	2800      	cmp	r0, #0
c0d015fc:	d006      	beq.n	c0d0160c <io_seproxyhal_touch_out+0x44>
c0d015fe:	2801      	cmp	r0, #1
c0d01600:	d000      	beq.n	c0d01604 <io_seproxyhal_touch_out+0x3c>
c0d01602:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d01604:	4620      	mov	r0, r4
c0d01606:	f7ff fa91 	bl	c0d00b2c <io_seproxyhal_display>
c0d0160a:	2101      	movs	r1, #1
  return 1;
}
c0d0160c:	4608      	mov	r0, r1
c0d0160e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01610 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01610:	b5b0      	push	{r4, r5, r7, lr}
c0d01612:	af02      	add	r7, sp, #8
c0d01614:	b08e      	sub	sp, #56	; 0x38
c0d01616:	460c      	mov	r4, r1
c0d01618:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d0161a:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d0161c:	2800      	cmp	r0, #0
c0d0161e:	d00c      	beq.n	c0d0163a <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d01620:	f000 fc86 	bl	c0d01f30 <pic>
c0d01624:	4601      	mov	r1, r0
c0d01626:	4628      	mov	r0, r5
c0d01628:	4788      	blx	r1
c0d0162a:	f000 fc81 	bl	c0d01f30 <pic>
c0d0162e:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01630:	2800      	cmp	r0, #0
c0d01632:	d016      	beq.n	c0d01662 <io_seproxyhal_touch_over+0x52>
c0d01634:	2801      	cmp	r0, #1
c0d01636:	d000      	beq.n	c0d0163a <io_seproxyhal_touch_over+0x2a>
c0d01638:	4605      	mov	r5, r0
c0d0163a:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d0163c:	2238      	movs	r2, #56	; 0x38
c0d0163e:	4629      	mov	r1, r5
c0d01640:	f7ff fdf6 	bl	c0d01230 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d01644:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01646:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01648:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d0164a:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d0164c:	2c00      	cmp	r4, #0
c0d0164e:	d004      	beq.n	c0d0165a <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01650:	4628      	mov	r0, r5
c0d01652:	47a0      	blx	r4
c0d01654:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d01656:	2800      	cmp	r0, #0
c0d01658:	d003      	beq.n	c0d01662 <io_seproxyhal_touch_over+0x52>
c0d0165a:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d0165c:	f7ff fa66 	bl	c0d00b2c <io_seproxyhal_display>
c0d01660:	2101      	movs	r1, #1
  return 1;
}
c0d01662:	4608      	mov	r0, r1
c0d01664:	b00e      	add	sp, #56	; 0x38
c0d01666:	bdb0      	pop	{r4, r5, r7, pc}

c0d01668 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01668:	b5b0      	push	{r4, r5, r7, lr}
c0d0166a:	af02      	add	r7, sp, #8
c0d0166c:	460d      	mov	r5, r1
c0d0166e:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01670:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d01672:	2800      	cmp	r0, #0
c0d01674:	d00c      	beq.n	c0d01690 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d01676:	f000 fc5b 	bl	c0d01f30 <pic>
c0d0167a:	4601      	mov	r1, r0
c0d0167c:	4620      	mov	r0, r4
c0d0167e:	4788      	blx	r1
c0d01680:	f000 fc56 	bl	c0d01f30 <pic>
c0d01684:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01686:	2800      	cmp	r0, #0
c0d01688:	d010      	beq.n	c0d016ac <io_seproxyhal_touch_tap+0x44>
c0d0168a:	2801      	cmp	r0, #1
c0d0168c:	d000      	beq.n	c0d01690 <io_seproxyhal_touch_tap+0x28>
c0d0168e:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01690:	2d00      	cmp	r5, #0
c0d01692:	d007      	beq.n	c0d016a4 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d01694:	4620      	mov	r0, r4
c0d01696:	47a8      	blx	r5
c0d01698:	2100      	movs	r1, #0
    if (!el) {
c0d0169a:	2800      	cmp	r0, #0
c0d0169c:	d006      	beq.n	c0d016ac <io_seproxyhal_touch_tap+0x44>
c0d0169e:	2801      	cmp	r0, #1
c0d016a0:	d000      	beq.n	c0d016a4 <io_seproxyhal_touch_tap+0x3c>
c0d016a2:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d016a4:	4620      	mov	r0, r4
c0d016a6:	f7ff fa41 	bl	c0d00b2c <io_seproxyhal_display>
c0d016aa:	2101      	movs	r1, #1
  return 1;
}
c0d016ac:	4608      	mov	r0, r1
c0d016ae:	bdb0      	pop	{r4, r5, r7, pc}

c0d016b0 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d016b0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d016b2:	af03      	add	r7, sp, #12
c0d016b4:	b087      	sub	sp, #28
c0d016b6:	9302      	str	r3, [sp, #8]
c0d016b8:	9203      	str	r2, [sp, #12]
c0d016ba:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d016bc:	2900      	cmp	r1, #0
c0d016be:	d076      	beq.n	c0d017ae <io_seproxyhal_touch_element_callback+0xfe>
c0d016c0:	9004      	str	r0, [sp, #16]
c0d016c2:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d016c4:	9001      	str	r0, [sp, #4]
c0d016c6:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d016c8:	9000      	str	r0, [sp, #0]
c0d016ca:	2600      	movs	r6, #0
c0d016cc:	9606      	str	r6, [sp, #24]
c0d016ce:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d016d0:	f000 fe08 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d016d4:	2800      	cmp	r0, #0
c0d016d6:	d155      	bne.n	c0d01784 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d016d8:	2038      	movs	r0, #56	; 0x38
c0d016da:	4370      	muls	r0, r6
c0d016dc:	9d04      	ldr	r5, [sp, #16]
c0d016de:	182e      	adds	r6, r5, r0
c0d016e0:	4b36      	ldr	r3, [pc, #216]	; (c0d017bc <io_seproxyhal_touch_element_callback+0x10c>)
c0d016e2:	681a      	ldr	r2, [r3, #0]
c0d016e4:	2101      	movs	r1, #1
c0d016e6:	4296      	cmp	r6, r2
c0d016e8:	d000      	beq.n	c0d016ec <io_seproxyhal_touch_element_callback+0x3c>
c0d016ea:	9906      	ldr	r1, [sp, #24]
c0d016ec:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d016ee:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d016f0:	2800      	cmp	r0, #0
c0d016f2:	da41      	bge.n	c0d01778 <io_seproxyhal_touch_element_callback+0xc8>
c0d016f4:	2020      	movs	r0, #32
c0d016f6:	5c35      	ldrb	r5, [r6, r0]
c0d016f8:	2102      	movs	r1, #2
c0d016fa:	5e71      	ldrsh	r1, [r6, r1]
c0d016fc:	1b4a      	subs	r2, r1, r5
c0d016fe:	9803      	ldr	r0, [sp, #12]
c0d01700:	4282      	cmp	r2, r0
c0d01702:	dc39      	bgt.n	c0d01778 <io_seproxyhal_touch_element_callback+0xc8>
c0d01704:	1869      	adds	r1, r5, r1
c0d01706:	88f2      	ldrh	r2, [r6, #6]
c0d01708:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d0170a:	9803      	ldr	r0, [sp, #12]
c0d0170c:	4288      	cmp	r0, r1
c0d0170e:	da33      	bge.n	c0d01778 <io_seproxyhal_touch_element_callback+0xc8>
c0d01710:	2104      	movs	r1, #4
c0d01712:	5e70      	ldrsh	r0, [r6, r1]
c0d01714:	1b42      	subs	r2, r0, r5
c0d01716:	9902      	ldr	r1, [sp, #8]
c0d01718:	428a      	cmp	r2, r1
c0d0171a:	dc2d      	bgt.n	c0d01778 <io_seproxyhal_touch_element_callback+0xc8>
c0d0171c:	1940      	adds	r0, r0, r5
c0d0171e:	8931      	ldrh	r1, [r6, #8]
c0d01720:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01722:	9902      	ldr	r1, [sp, #8]
c0d01724:	4281      	cmp	r1, r0
c0d01726:	da27      	bge.n	c0d01778 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01728:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d0172a:	4286      	cmp	r6, r0
c0d0172c:	d010      	beq.n	c0d01750 <io_seproxyhal_touch_element_callback+0xa0>
c0d0172e:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01730:	2800      	cmp	r0, #0
c0d01732:	d00d      	beq.n	c0d01750 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d01734:	9801      	ldr	r0, [sp, #4]
c0d01736:	2800      	cmp	r0, #0
c0d01738:	d005      	beq.n	c0d01746 <io_seproxyhal_touch_element_callback+0x96>
c0d0173a:	4630      	mov	r0, r6
c0d0173c:	9901      	ldr	r1, [sp, #4]
c0d0173e:	4788      	blx	r1
c0d01740:	4b1e      	ldr	r3, [pc, #120]	; (c0d017bc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01742:	2800      	cmp	r0, #0
c0d01744:	d018      	beq.n	c0d01778 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01746:	6818      	ldr	r0, [r3, #0]
c0d01748:	9901      	ldr	r1, [sp, #4]
c0d0174a:	f7ff ff3d 	bl	c0d015c8 <io_seproxyhal_touch_out>
c0d0174e:	e008      	b.n	c0d01762 <io_seproxyhal_touch_element_callback+0xb2>
c0d01750:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d01752:	2801      	cmp	r0, #1
c0d01754:	d009      	beq.n	c0d0176a <io_seproxyhal_touch_element_callback+0xba>
c0d01756:	2802      	cmp	r0, #2
c0d01758:	d10e      	bne.n	c0d01778 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d0175a:	4630      	mov	r0, r6
c0d0175c:	9901      	ldr	r1, [sp, #4]
c0d0175e:	f7ff ff83 	bl	c0d01668 <io_seproxyhal_touch_tap>
c0d01762:	4b16      	ldr	r3, [pc, #88]	; (c0d017bc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01764:	2800      	cmp	r0, #0
c0d01766:	d007      	beq.n	c0d01778 <io_seproxyhal_touch_element_callback+0xc8>
c0d01768:	e023      	b.n	c0d017b2 <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d0176a:	4630      	mov	r0, r6
c0d0176c:	9901      	ldr	r1, [sp, #4]
c0d0176e:	f7ff ff4f 	bl	c0d01610 <io_seproxyhal_touch_over>
c0d01772:	4b12      	ldr	r3, [pc, #72]	; (c0d017bc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01774:	2800      	cmp	r0, #0
c0d01776:	d11f      	bne.n	c0d017b8 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01778:	1c64      	adds	r4, r4, #1
c0d0177a:	b2e6      	uxtb	r6, r4
c0d0177c:	9805      	ldr	r0, [sp, #20]
c0d0177e:	4286      	cmp	r6, r0
c0d01780:	d3a6      	bcc.n	c0d016d0 <io_seproxyhal_touch_element_callback+0x20>
c0d01782:	e000      	b.n	c0d01786 <io_seproxyhal_touch_element_callback+0xd6>
c0d01784:	4b0d      	ldr	r3, [pc, #52]	; (c0d017bc <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d01786:	9806      	ldr	r0, [sp, #24]
c0d01788:	0600      	lsls	r0, r0, #24
c0d0178a:	d010      	beq.n	c0d017ae <io_seproxyhal_touch_element_callback+0xfe>
c0d0178c:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d0178e:	2800      	cmp	r0, #0
c0d01790:	d00d      	beq.n	c0d017ae <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01792:	f000 fda7 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d01796:	4909      	ldr	r1, [pc, #36]	; (c0d017bc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01798:	2800      	cmp	r0, #0
c0d0179a:	d108      	bne.n	c0d017ae <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d0179c:	6808      	ldr	r0, [r1, #0]
c0d0179e:	9901      	ldr	r1, [sp, #4]
c0d017a0:	f7ff ff12 	bl	c0d015c8 <io_seproxyhal_touch_out>
c0d017a4:	4d05      	ldr	r5, [pc, #20]	; (c0d017bc <io_seproxyhal_touch_element_callback+0x10c>)
c0d017a6:	2800      	cmp	r0, #0
c0d017a8:	d001      	beq.n	c0d017ae <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d017aa:	2000      	movs	r0, #0
c0d017ac:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d017ae:	b007      	add	sp, #28
c0d017b0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d017b2:	2000      	movs	r0, #0
c0d017b4:	6018      	str	r0, [r3, #0]
c0d017b6:	e7fa      	b.n	c0d017ae <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d017b8:	601e      	str	r6, [r3, #0]
c0d017ba:	e7f8      	b.n	c0d017ae <io_seproxyhal_touch_element_callback+0xfe>
c0d017bc:	20001d20 	.word	0x20001d20

c0d017c0 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d017c0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d017c2:	af03      	add	r7, sp, #12
c0d017c4:	b08b      	sub	sp, #44	; 0x2c
c0d017c6:	460c      	mov	r4, r1
c0d017c8:	4601      	mov	r1, r0
c0d017ca:	ad04      	add	r5, sp, #16
c0d017cc:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d017ce:	4628      	mov	r0, r5
c0d017d0:	9203      	str	r2, [sp, #12]
c0d017d2:	f7ff fd2d 	bl	c0d01230 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d017d6:	6821      	ldr	r1, [r4, #0]
c0d017d8:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d017da:	6862      	ldr	r2, [r4, #4]
c0d017dc:	9502      	str	r5, [sp, #8]
c0d017de:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d017e0:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d017e2:	4e1a      	ldr	r6, [pc, #104]	; (c0d0184c <io_seproxyhal_display_icon+0x8c>)
c0d017e4:	2365      	movs	r3, #101	; 0x65
c0d017e6:	4635      	mov	r5, r6
c0d017e8:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d017ea:	b292      	uxth	r2, r2
c0d017ec:	4342      	muls	r2, r0
c0d017ee:	b28b      	uxth	r3, r1
c0d017f0:	4353      	muls	r3, r2
c0d017f2:	08d9      	lsrs	r1, r3, #3
c0d017f4:	1c4e      	adds	r6, r1, #1
c0d017f6:	2207      	movs	r2, #7
c0d017f8:	4213      	tst	r3, r2
c0d017fa:	d100      	bne.n	c0d017fe <io_seproxyhal_display_icon+0x3e>
c0d017fc:	460e      	mov	r6, r1
c0d017fe:	4631      	mov	r1, r6
c0d01800:	9101      	str	r1, [sp, #4]
c0d01802:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01804:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d01806:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d01808:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0180a:	0a01      	lsrs	r1, r0, #8
c0d0180c:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d0180e:	70a8      	strb	r0, [r5, #2]
c0d01810:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01812:	4628      	mov	r0, r5
c0d01814:	f000 fd48 	bl	c0d022a8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01818:	9802      	ldr	r0, [sp, #8]
c0d0181a:	9903      	ldr	r1, [sp, #12]
c0d0181c:	f000 fd44 	bl	c0d022a8 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01820:	68a0      	ldr	r0, [r4, #8]
c0d01822:	7028      	strb	r0, [r5, #0]
c0d01824:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d01826:	4628      	mov	r0, r5
c0d01828:	f000 fd3e 	bl	c0d022a8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d0182c:	68e0      	ldr	r0, [r4, #12]
c0d0182e:	f000 fb7f 	bl	c0d01f30 <pic>
c0d01832:	b2b1      	uxth	r1, r6
c0d01834:	f000 fd38 	bl	c0d022a8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01838:	9801      	ldr	r0, [sp, #4]
c0d0183a:	b285      	uxth	r5, r0
c0d0183c:	6920      	ldr	r0, [r4, #16]
c0d0183e:	f000 fb77 	bl	c0d01f30 <pic>
c0d01842:	4629      	mov	r1, r5
c0d01844:	f000 fd30 	bl	c0d022a8 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01848:	b00b      	add	sp, #44	; 0x2c
c0d0184a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0184c:	20001a18 	.word	0x20001a18

c0d01850 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01850:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01852:	af03      	add	r7, sp, #12
c0d01854:	b081      	sub	sp, #4
c0d01856:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01858:	7820      	ldrb	r0, [r4, #0]
c0d0185a:	267f      	movs	r6, #127	; 0x7f
c0d0185c:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d0185e:	2e00      	cmp	r6, #0
c0d01860:	d02e      	beq.n	c0d018c0 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d01862:	69e0      	ldr	r0, [r4, #28]
c0d01864:	2800      	cmp	r0, #0
c0d01866:	d01d      	beq.n	c0d018a4 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01868:	f000 fb62 	bl	c0d01f30 <pic>
c0d0186c:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d0186e:	2e05      	cmp	r6, #5
c0d01870:	d102      	bne.n	c0d01878 <io_seproxyhal_display_default+0x28>
c0d01872:	7ea0      	ldrb	r0, [r4, #26]
c0d01874:	2800      	cmp	r0, #0
c0d01876:	d025      	beq.n	c0d018c4 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01878:	4628      	mov	r0, r5
c0d0187a:	f002 f8a3 	bl	c0d039c4 <strlen>
c0d0187e:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01880:	4813      	ldr	r0, [pc, #76]	; (c0d018d0 <io_seproxyhal_display_default+0x80>)
c0d01882:	2165      	movs	r1, #101	; 0x65
c0d01884:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01886:	4631      	mov	r1, r6
c0d01888:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0188a:	0a0a      	lsrs	r2, r1, #8
c0d0188c:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d0188e:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01890:	2103      	movs	r1, #3
c0d01892:	f000 fd09 	bl	c0d022a8 <io_seproxyhal_spi_send>
c0d01896:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01898:	4620      	mov	r0, r4
c0d0189a:	f000 fd05 	bl	c0d022a8 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d0189e:	b2b1      	uxth	r1, r6
c0d018a0:	4628      	mov	r0, r5
c0d018a2:	e00b      	b.n	c0d018bc <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d018a4:	480a      	ldr	r0, [pc, #40]	; (c0d018d0 <io_seproxyhal_display_default+0x80>)
c0d018a6:	2165      	movs	r1, #101	; 0x65
c0d018a8:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d018aa:	2100      	movs	r1, #0
c0d018ac:	7041      	strb	r1, [r0, #1]
c0d018ae:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d018b0:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d018b2:	2103      	movs	r1, #3
c0d018b4:	f000 fcf8 	bl	c0d022a8 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d018b8:	4620      	mov	r0, r4
c0d018ba:	4629      	mov	r1, r5
c0d018bc:	f000 fcf4 	bl	c0d022a8 <io_seproxyhal_spi_send>
    }
  }
}
c0d018c0:	b001      	add	sp, #4
c0d018c2:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d018c4:	4620      	mov	r0, r4
c0d018c6:	4629      	mov	r1, r5
c0d018c8:	f7ff ff7a 	bl	c0d017c0 <io_seproxyhal_display_icon>
c0d018cc:	e7f8      	b.n	c0d018c0 <io_seproxyhal_display_default+0x70>
c0d018ce:	46c0      	nop			; (mov r8, r8)
c0d018d0:	20001a18 	.word	0x20001a18

c0d018d4 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d018d4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d018d6:	af03      	add	r7, sp, #12
c0d018d8:	b081      	sub	sp, #4
c0d018da:	4604      	mov	r4, r0
  if (button_callback) {
c0d018dc:	2c00      	cmp	r4, #0
c0d018de:	d02e      	beq.n	c0d0193e <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d018e0:	4818      	ldr	r0, [pc, #96]	; (c0d01944 <io_seproxyhal_button_push+0x70>)
c0d018e2:	6802      	ldr	r2, [r0, #0]
c0d018e4:	428a      	cmp	r2, r1
c0d018e6:	d103      	bne.n	c0d018f0 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d018e8:	4a17      	ldr	r2, [pc, #92]	; (c0d01948 <io_seproxyhal_button_push+0x74>)
c0d018ea:	6813      	ldr	r3, [r2, #0]
c0d018ec:	1c5b      	adds	r3, r3, #1
c0d018ee:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d018f0:	6806      	ldr	r6, [r0, #0]
c0d018f2:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d018f4:	4a14      	ldr	r2, [pc, #80]	; (c0d01948 <io_seproxyhal_button_push+0x74>)
c0d018f6:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d018f8:	2900      	cmp	r1, #0
c0d018fa:	d001      	beq.n	c0d01900 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d018fc:	6006      	str	r6, [r0, #0]
c0d018fe:	e005      	b.n	c0d0190c <io_seproxyhal_button_push+0x38>
c0d01900:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d01902:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d01904:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d01906:	2301      	movs	r3, #1
c0d01908:	07db      	lsls	r3, r3, #31
c0d0190a:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d0190c:	6800      	ldr	r0, [r0, #0]
c0d0190e:	4288      	cmp	r0, r1
c0d01910:	d001      	beq.n	c0d01916 <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d01912:	2000      	movs	r0, #0
c0d01914:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d01916:	2d08      	cmp	r5, #8
c0d01918:	d30e      	bcc.n	c0d01938 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d0191a:	2103      	movs	r1, #3
c0d0191c:	4628      	mov	r0, r5
c0d0191e:	f001 fda7 	bl	c0d03470 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d01922:	2001      	movs	r0, #1
c0d01924:	0780      	lsls	r0, r0, #30
c0d01926:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01928:	2900      	cmp	r1, #0
c0d0192a:	4601      	mov	r1, r0
c0d0192c:	d000      	beq.n	c0d01930 <io_seproxyhal_button_push+0x5c>
c0d0192e:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01930:	2900      	cmp	r1, #0
c0d01932:	db02      	blt.n	c0d0193a <io_seproxyhal_button_push+0x66>
c0d01934:	4608      	mov	r0, r1
c0d01936:	e000      	b.n	c0d0193a <io_seproxyhal_button_push+0x66>
c0d01938:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d0193a:	4629      	mov	r1, r5
c0d0193c:	47a0      	blx	r4
  }
}
c0d0193e:	b001      	add	sp, #4
c0d01940:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01942:	46c0      	nop			; (mov r8, r8)
c0d01944:	20001d24 	.word	0x20001d24
c0d01948:	20001d28 	.word	0x20001d28

c0d0194c <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d0194c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0194e:	af03      	add	r7, sp, #12
c0d01950:	b081      	sub	sp, #4
c0d01952:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01954:	200f      	movs	r0, #15
c0d01956:	4204      	tst	r4, r0
c0d01958:	d006      	beq.n	c0d01968 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d0195a:	4620      	mov	r0, r4
c0d0195c:	f7ff f8be 	bl	c0d00adc <io_exchange_al>
c0d01960:	4605      	mov	r5, r0
  }
}
c0d01962:	b2a8      	uxth	r0, r5
c0d01964:	b001      	add	sp, #4
c0d01966:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01968:	2610      	movs	r6, #16
c0d0196a:	4026      	ands	r6, r4
c0d0196c:	2900      	cmp	r1, #0
c0d0196e:	d02a      	beq.n	c0d019c6 <io_exchange+0x7a>
c0d01970:	2e00      	cmp	r6, #0
c0d01972:	d128      	bne.n	c0d019c6 <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01974:	483d      	ldr	r0, [pc, #244]	; (c0d01a6c <io_exchange+0x120>)
c0d01976:	7800      	ldrb	r0, [r0, #0]
c0d01978:	2807      	cmp	r0, #7
c0d0197a:	d00b      	beq.n	c0d01994 <io_exchange+0x48>
c0d0197c:	2800      	cmp	r0, #0
c0d0197e:	d004      	beq.n	c0d0198a <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01980:	4620      	mov	r0, r4
c0d01982:	f7ff f8ab 	bl	c0d00adc <io_exchange_al>
c0d01986:	2800      	cmp	r0, #0
c0d01988:	d00a      	beq.n	c0d019a0 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d0198a:	4839      	ldr	r0, [pc, #228]	; (c0d01a70 <io_exchange+0x124>)
c0d0198c:	6800      	ldr	r0, [r0, #0]
c0d0198e:	2109      	movs	r1, #9
c0d01990:	f002 f80a 	bl	c0d039a8 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01994:	483d      	ldr	r0, [pc, #244]	; (c0d01a8c <io_exchange+0x140>)
c0d01996:	4478      	add	r0, pc
c0d01998:	2200      	movs	r2, #0
c0d0199a:	2320      	movs	r3, #32
c0d0199c:	f7ff fc6a 	bl	c0d01274 <io_usb_hid_exchange>
c0d019a0:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d019a2:	4832      	ldr	r0, [pc, #200]	; (c0d01a6c <io_exchange+0x120>)
c0d019a4:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d019a6:	4833      	ldr	r0, [pc, #204]	; (c0d01a74 <io_exchange+0x128>)
c0d019a8:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d019aa:	4833      	ldr	r0, [pc, #204]	; (c0d01a78 <io_exchange+0x12c>)
c0d019ac:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d019ae:	4833      	ldr	r0, [pc, #204]	; (c0d01a7c <io_exchange+0x130>)
c0d019b0:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d019b2:	4833      	ldr	r0, [pc, #204]	; (c0d01a80 <io_exchange+0x134>)
c0d019b4:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d019b6:	06a0      	lsls	r0, r4, #26
c0d019b8:	d4d3      	bmi.n	c0d01962 <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d019ba:	f7ff fcd3 	bl	c0d01364 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d019be:	0620      	lsls	r0, r4, #24
c0d019c0:	d501      	bpl.n	c0d019c6 <io_exchange+0x7a>
        reset();
c0d019c2:	f000 faeb 	bl	c0d01f9c <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d019c6:	2e00      	cmp	r6, #0
c0d019c8:	d10c      	bne.n	c0d019e4 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d019ca:	0660      	lsls	r0, r4, #25
c0d019cc:	d448      	bmi.n	c0d01a60 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d019ce:	4827      	ldr	r0, [pc, #156]	; (c0d01a6c <io_exchange+0x120>)
c0d019d0:	2100      	movs	r1, #0
c0d019d2:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d019d4:	4827      	ldr	r0, [pc, #156]	; (c0d01a74 <io_exchange+0x128>)
c0d019d6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d019d8:	4827      	ldr	r0, [pc, #156]	; (c0d01a78 <io_exchange+0x12c>)
c0d019da:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d019dc:	4827      	ldr	r0, [pc, #156]	; (c0d01a7c <io_exchange+0x130>)
c0d019de:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d019e0:	4827      	ldr	r0, [pc, #156]	; (c0d01a80 <io_exchange+0x134>)
c0d019e2:	7001      	strb	r1, [r0, #0]
c0d019e4:	4c28      	ldr	r4, [pc, #160]	; (c0d01a88 <io_exchange+0x13c>)
c0d019e6:	4e24      	ldr	r6, [pc, #144]	; (c0d01a78 <io_exchange+0x12c>)
c0d019e8:	e008      	b.n	c0d019fc <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d019ea:	f7ff fd0f 	bl	c0d0140c <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d019ee:	8830      	ldrh	r0, [r6, #0]
c0d019f0:	2800      	cmp	r0, #0
c0d019f2:	d003      	beq.n	c0d019fc <io_exchange+0xb0>
c0d019f4:	e032      	b.n	c0d01a5c <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d019f6:	2002      	movs	r0, #2
c0d019f8:	f7ff f89e 	bl	c0d00b38 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d019fc:	f000 fc72 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d01a00:	2800      	cmp	r0, #0
c0d01a02:	d101      	bne.n	c0d01a08 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01a04:	f7ff fcae 	bl	c0d01364 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01a08:	2180      	movs	r1, #128	; 0x80
c0d01a0a:	2500      	movs	r5, #0
c0d01a0c:	4620      	mov	r0, r4
c0d01a0e:	462a      	mov	r2, r5
c0d01a10:	f000 fc84 	bl	c0d0231c <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01a14:	1ec1      	subs	r1, r0, #3
c0d01a16:	78a2      	ldrb	r2, [r4, #2]
c0d01a18:	7863      	ldrb	r3, [r4, #1]
c0d01a1a:	021b      	lsls	r3, r3, #8
c0d01a1c:	4313      	orrs	r3, r2
c0d01a1e:	4299      	cmp	r1, r3
c0d01a20:	d110      	bne.n	c0d01a44 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01a22:	4917      	ldr	r1, [pc, #92]	; (c0d01a80 <io_exchange+0x134>)
c0d01a24:	7809      	ldrb	r1, [r1, #0]
c0d01a26:	2900      	cmp	r1, #0
c0d01a28:	d002      	beq.n	c0d01a30 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01a2a:	f7ff fd73 	bl	c0d01514 <io_seproxyhal_handle_event>
c0d01a2e:	e7e5      	b.n	c0d019fc <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01a30:	7821      	ldrb	r1, [r4, #0]
c0d01a32:	2910      	cmp	r1, #16
c0d01a34:	d00f      	beq.n	c0d01a56 <io_exchange+0x10a>
c0d01a36:	290f      	cmp	r1, #15
c0d01a38:	d1dd      	bne.n	c0d019f6 <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01a3a:	2804      	cmp	r0, #4
c0d01a3c:	d102      	bne.n	c0d01a44 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01a3e:	f7ff fca7 	bl	c0d01390 <io_seproxyhal_handle_usb_event>
c0d01a42:	e7db      	b.n	c0d019fc <io_exchange+0xb0>
c0d01a44:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d01a46:	4909      	ldr	r1, [pc, #36]	; (c0d01a6c <io_exchange+0x120>)
c0d01a48:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01a4a:	490a      	ldr	r1, [pc, #40]	; (c0d01a74 <io_exchange+0x128>)
c0d01a4c:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01a4e:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01a50:	490a      	ldr	r1, [pc, #40]	; (c0d01a7c <io_exchange+0x130>)
c0d01a52:	8008      	strh	r0, [r1, #0]
c0d01a54:	e7d2      	b.n	c0d019fc <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01a56:	2806      	cmp	r0, #6
c0d01a58:	d2c7      	bcs.n	c0d019ea <io_exchange+0x9e>
c0d01a5a:	e782      	b.n	c0d01962 <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01a5c:	8835      	ldrh	r5, [r6, #0]
c0d01a5e:	e780      	b.n	c0d01962 <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01a60:	4805      	ldr	r0, [pc, #20]	; (c0d01a78 <io_exchange+0x12c>)
c0d01a62:	8800      	ldrh	r0, [r0, #0]
c0d01a64:	4907      	ldr	r1, [pc, #28]	; (c0d01a84 <io_exchange+0x138>)
c0d01a66:	1845      	adds	r5, r0, r1
c0d01a68:	e77b      	b.n	c0d01962 <io_exchange+0x16>
c0d01a6a:	46c0      	nop			; (mov r8, r8)
c0d01a6c:	20001d18 	.word	0x20001d18
c0d01a70:	20001bb8 	.word	0x20001bb8
c0d01a74:	20001d1a 	.word	0x20001d1a
c0d01a78:	20001d1c 	.word	0x20001d1c
c0d01a7c:	20001d1e 	.word	0x20001d1e
c0d01a80:	20001d10 	.word	0x20001d10
c0d01a84:	0000fffb 	.word	0x0000fffb
c0d01a88:	20001a18 	.word	0x20001a18
c0d01a8c:	fffffbbb 	.word	0xfffffbbb

c0d01a90 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01a90:	b081      	sub	sp, #4
c0d01a92:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a94:	af03      	add	r7, sp, #12
c0d01a96:	b094      	sub	sp, #80	; 0x50
c0d01a98:	4616      	mov	r6, r2
c0d01a9a:	460d      	mov	r5, r1
c0d01a9c:	900e      	str	r0, [sp, #56]	; 0x38
c0d01a9e:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01aa0:	2d02      	cmp	r5, #2
c0d01aa2:	d200      	bcs.n	c0d01aa6 <snprintf+0x16>
c0d01aa4:	e22a      	b.n	c0d01efc <snprintf+0x46c>
c0d01aa6:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01aa8:	2800      	cmp	r0, #0
c0d01aaa:	d100      	bne.n	c0d01aae <snprintf+0x1e>
c0d01aac:	e226      	b.n	c0d01efc <snprintf+0x46c>
c0d01aae:	2e00      	cmp	r6, #0
c0d01ab0:	d100      	bne.n	c0d01ab4 <snprintf+0x24>
c0d01ab2:	e223      	b.n	c0d01efc <snprintf+0x46c>
c0d01ab4:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d01ab6:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01ab8:	9109      	str	r1, [sp, #36]	; 0x24
c0d01aba:	462a      	mov	r2, r5
c0d01abc:	f7ff fbae 	bl	c0d0121c <os_memset>
c0d01ac0:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01ac2:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01ac4:	7830      	ldrb	r0, [r6, #0]
c0d01ac6:	2800      	cmp	r0, #0
c0d01ac8:	d100      	bne.n	c0d01acc <snprintf+0x3c>
c0d01aca:	e217      	b.n	c0d01efc <snprintf+0x46c>
c0d01acc:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01ace:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01ad0:	1e6b      	subs	r3, r5, #1
c0d01ad2:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01ad4:	460a      	mov	r2, r1
c0d01ad6:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01ad8:	e003      	b.n	c0d01ae2 <snprintf+0x52>
c0d01ada:	1970      	adds	r0, r6, r5
c0d01adc:	7840      	ldrb	r0, [r0, #1]
c0d01ade:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01ae0:	1c6d      	adds	r5, r5, #1
c0d01ae2:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01ae4:	2800      	cmp	r0, #0
c0d01ae6:	d001      	beq.n	c0d01aec <snprintf+0x5c>
c0d01ae8:	2825      	cmp	r0, #37	; 0x25
c0d01aea:	d1f6      	bne.n	c0d01ada <snprintf+0x4a>
c0d01aec:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01aee:	429d      	cmp	r5, r3
c0d01af0:	d300      	bcc.n	c0d01af4 <snprintf+0x64>
c0d01af2:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01af4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01af6:	4631      	mov	r1, r6
c0d01af8:	462a      	mov	r2, r5
c0d01afa:	461c      	mov	r4, r3
c0d01afc:	f7ff fb98 	bl	c0d01230 <os_memmove>
c0d01b00:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01b02:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01b04:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01b06:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01b08:	2b00      	cmp	r3, #0
c0d01b0a:	d100      	bne.n	c0d01b0e <snprintf+0x7e>
c0d01b0c:	e1f6      	b.n	c0d01efc <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01b0e:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01b10:	5d71      	ldrb	r1, [r6, r5]
c0d01b12:	2925      	cmp	r1, #37	; 0x25
c0d01b14:	d000      	beq.n	c0d01b18 <snprintf+0x88>
c0d01b16:	e0ab      	b.n	c0d01c70 <snprintf+0x1e0>
c0d01b18:	9304      	str	r3, [sp, #16]
c0d01b1a:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01b1c:	1c40      	adds	r0, r0, #1
c0d01b1e:	2100      	movs	r1, #0
c0d01b20:	2220      	movs	r2, #32
c0d01b22:	920a      	str	r2, [sp, #40]	; 0x28
c0d01b24:	220a      	movs	r2, #10
c0d01b26:	9203      	str	r2, [sp, #12]
c0d01b28:	9102      	str	r1, [sp, #8]
c0d01b2a:	9106      	str	r1, [sp, #24]
c0d01b2c:	910d      	str	r1, [sp, #52]	; 0x34
c0d01b2e:	460b      	mov	r3, r1
c0d01b30:	2102      	movs	r1, #2
c0d01b32:	910c      	str	r1, [sp, #48]	; 0x30
c0d01b34:	4606      	mov	r6, r0
c0d01b36:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01b38:	7831      	ldrb	r1, [r6, #0]
c0d01b3a:	1c76      	adds	r6, r6, #1
c0d01b3c:	2300      	movs	r3, #0
c0d01b3e:	2962      	cmp	r1, #98	; 0x62
c0d01b40:	dc41      	bgt.n	c0d01bc6 <snprintf+0x136>
c0d01b42:	4608      	mov	r0, r1
c0d01b44:	3825      	subs	r0, #37	; 0x25
c0d01b46:	2823      	cmp	r0, #35	; 0x23
c0d01b48:	d900      	bls.n	c0d01b4c <snprintf+0xbc>
c0d01b4a:	e094      	b.n	c0d01c76 <snprintf+0x1e6>
c0d01b4c:	0040      	lsls	r0, r0, #1
c0d01b4e:	46c0      	nop			; (mov r8, r8)
c0d01b50:	4478      	add	r0, pc
c0d01b52:	8880      	ldrh	r0, [r0, #4]
c0d01b54:	0040      	lsls	r0, r0, #1
c0d01b56:	4487      	add	pc, r0
c0d01b58:	0186012d 	.word	0x0186012d
c0d01b5c:	01860186 	.word	0x01860186
c0d01b60:	00510186 	.word	0x00510186
c0d01b64:	01860186 	.word	0x01860186
c0d01b68:	00580023 	.word	0x00580023
c0d01b6c:	00240186 	.word	0x00240186
c0d01b70:	00240024 	.word	0x00240024
c0d01b74:	00240024 	.word	0x00240024
c0d01b78:	00240024 	.word	0x00240024
c0d01b7c:	00240024 	.word	0x00240024
c0d01b80:	01860024 	.word	0x01860024
c0d01b84:	01860186 	.word	0x01860186
c0d01b88:	01860186 	.word	0x01860186
c0d01b8c:	01860186 	.word	0x01860186
c0d01b90:	01860186 	.word	0x01860186
c0d01b94:	01860186 	.word	0x01860186
c0d01b98:	01860186 	.word	0x01860186
c0d01b9c:	006c0186 	.word	0x006c0186
c0d01ba0:	e7c9      	b.n	c0d01b36 <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01ba2:	2930      	cmp	r1, #48	; 0x30
c0d01ba4:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01ba6:	4603      	mov	r3, r0
c0d01ba8:	d100      	bne.n	c0d01bac <snprintf+0x11c>
c0d01baa:	460b      	mov	r3, r1
c0d01bac:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01bae:	2c00      	cmp	r4, #0
c0d01bb0:	d000      	beq.n	c0d01bb4 <snprintf+0x124>
c0d01bb2:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01bb4:	200a      	movs	r0, #10
c0d01bb6:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01bb8:	1840      	adds	r0, r0, r1
c0d01bba:	3830      	subs	r0, #48	; 0x30
c0d01bbc:	900d      	str	r0, [sp, #52]	; 0x34
c0d01bbe:	4630      	mov	r0, r6
c0d01bc0:	930a      	str	r3, [sp, #40]	; 0x28
c0d01bc2:	4613      	mov	r3, r2
c0d01bc4:	e7b4      	b.n	c0d01b30 <snprintf+0xa0>
c0d01bc6:	296f      	cmp	r1, #111	; 0x6f
c0d01bc8:	dd11      	ble.n	c0d01bee <snprintf+0x15e>
c0d01bca:	3970      	subs	r1, #112	; 0x70
c0d01bcc:	2908      	cmp	r1, #8
c0d01bce:	d900      	bls.n	c0d01bd2 <snprintf+0x142>
c0d01bd0:	e149      	b.n	c0d01e66 <snprintf+0x3d6>
c0d01bd2:	0049      	lsls	r1, r1, #1
c0d01bd4:	4479      	add	r1, pc
c0d01bd6:	8889      	ldrh	r1, [r1, #4]
c0d01bd8:	0049      	lsls	r1, r1, #1
c0d01bda:	448f      	add	pc, r1
c0d01bdc:	01440051 	.word	0x01440051
c0d01be0:	002e0144 	.word	0x002e0144
c0d01be4:	00590144 	.word	0x00590144
c0d01be8:	01440144 	.word	0x01440144
c0d01bec:	0051      	.short	0x0051
c0d01bee:	2963      	cmp	r1, #99	; 0x63
c0d01bf0:	d054      	beq.n	c0d01c9c <snprintf+0x20c>
c0d01bf2:	2964      	cmp	r1, #100	; 0x64
c0d01bf4:	d057      	beq.n	c0d01ca6 <snprintf+0x216>
c0d01bf6:	2968      	cmp	r1, #104	; 0x68
c0d01bf8:	d01d      	beq.n	c0d01c36 <snprintf+0x1a6>
c0d01bfa:	e134      	b.n	c0d01e66 <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01bfc:	7830      	ldrb	r0, [r6, #0]
c0d01bfe:	2873      	cmp	r0, #115	; 0x73
c0d01c00:	d000      	beq.n	c0d01c04 <snprintf+0x174>
c0d01c02:	e130      	b.n	c0d01e66 <snprintf+0x3d6>
c0d01c04:	4630      	mov	r0, r6
c0d01c06:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01c08:	e00d      	b.n	c0d01c26 <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01c0a:	7830      	ldrb	r0, [r6, #0]
c0d01c0c:	282a      	cmp	r0, #42	; 0x2a
c0d01c0e:	d000      	beq.n	c0d01c12 <snprintf+0x182>
c0d01c10:	e129      	b.n	c0d01e66 <snprintf+0x3d6>
c0d01c12:	7871      	ldrb	r1, [r6, #1]
c0d01c14:	1c70      	adds	r0, r6, #1
c0d01c16:	2301      	movs	r3, #1
c0d01c18:	2948      	cmp	r1, #72	; 0x48
c0d01c1a:	d004      	beq.n	c0d01c26 <snprintf+0x196>
c0d01c1c:	2968      	cmp	r1, #104	; 0x68
c0d01c1e:	d002      	beq.n	c0d01c26 <snprintf+0x196>
c0d01c20:	2973      	cmp	r1, #115	; 0x73
c0d01c22:	d000      	beq.n	c0d01c26 <snprintf+0x196>
c0d01c24:	e11f      	b.n	c0d01e66 <snprintf+0x3d6>
c0d01c26:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01c28:	1d0a      	adds	r2, r1, #4
c0d01c2a:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01c2c:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01c2e:	9102      	str	r1, [sp, #8]
c0d01c30:	e77e      	b.n	c0d01b30 <snprintf+0xa0>
c0d01c32:	2001      	movs	r0, #1
c0d01c34:	9006      	str	r0, [sp, #24]
c0d01c36:	2010      	movs	r0, #16
c0d01c38:	9003      	str	r0, [sp, #12]
c0d01c3a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01c3c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01c3e:	1d01      	adds	r1, r0, #4
c0d01c40:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01c42:	2103      	movs	r1, #3
c0d01c44:	400a      	ands	r2, r1
c0d01c46:	1c5b      	adds	r3, r3, #1
c0d01c48:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01c4a:	2a01      	cmp	r2, #1
c0d01c4c:	d100      	bne.n	c0d01c50 <snprintf+0x1c0>
c0d01c4e:	e0b8      	b.n	c0d01dc2 <snprintf+0x332>
c0d01c50:	2a02      	cmp	r2, #2
c0d01c52:	d100      	bne.n	c0d01c56 <snprintf+0x1c6>
c0d01c54:	e104      	b.n	c0d01e60 <snprintf+0x3d0>
c0d01c56:	2a03      	cmp	r2, #3
c0d01c58:	4630      	mov	r0, r6
c0d01c5a:	d100      	bne.n	c0d01c5e <snprintf+0x1ce>
c0d01c5c:	e768      	b.n	c0d01b30 <snprintf+0xa0>
c0d01c5e:	9c08      	ldr	r4, [sp, #32]
c0d01c60:	4625      	mov	r5, r4
c0d01c62:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01c64:	1948      	adds	r0, r1, r5
c0d01c66:	7840      	ldrb	r0, [r0, #1]
c0d01c68:	1c6d      	adds	r5, r5, #1
c0d01c6a:	2800      	cmp	r0, #0
c0d01c6c:	d1fa      	bne.n	c0d01c64 <snprintf+0x1d4>
c0d01c6e:	e0ab      	b.n	c0d01dc8 <snprintf+0x338>
c0d01c70:	4606      	mov	r6, r0
c0d01c72:	920e      	str	r2, [sp, #56]	; 0x38
c0d01c74:	e109      	b.n	c0d01e8a <snprintf+0x3fa>
c0d01c76:	2958      	cmp	r1, #88	; 0x58
c0d01c78:	d000      	beq.n	c0d01c7c <snprintf+0x1ec>
c0d01c7a:	e0f4      	b.n	c0d01e66 <snprintf+0x3d6>
c0d01c7c:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01c7e:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01c80:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01c82:	1d01      	adds	r1, r0, #4
c0d01c84:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01c86:	6802      	ldr	r2, [r0, #0]
c0d01c88:	2000      	movs	r0, #0
c0d01c8a:	9005      	str	r0, [sp, #20]
c0d01c8c:	2510      	movs	r5, #16
c0d01c8e:	e014      	b.n	c0d01cba <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01c90:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01c92:	1d01      	adds	r1, r0, #4
c0d01c94:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01c96:	6802      	ldr	r2, [r0, #0]
c0d01c98:	2000      	movs	r0, #0
c0d01c9a:	e00c      	b.n	c0d01cb6 <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01c9c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01c9e:	1d01      	adds	r1, r0, #4
c0d01ca0:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01ca2:	6800      	ldr	r0, [r0, #0]
c0d01ca4:	e087      	b.n	c0d01db6 <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01ca6:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01ca8:	1d01      	adds	r1, r0, #4
c0d01caa:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01cac:	6800      	ldr	r0, [r0, #0]
c0d01cae:	17c1      	asrs	r1, r0, #31
c0d01cb0:	1842      	adds	r2, r0, r1
c0d01cb2:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01cb4:	0fc0      	lsrs	r0, r0, #31
c0d01cb6:	9005      	str	r0, [sp, #20]
c0d01cb8:	250a      	movs	r5, #10
c0d01cba:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01cbc:	4295      	cmp	r5, r2
c0d01cbe:	920e      	str	r2, [sp, #56]	; 0x38
c0d01cc0:	d814      	bhi.n	c0d01cec <snprintf+0x25c>
c0d01cc2:	2201      	movs	r2, #1
c0d01cc4:	4628      	mov	r0, r5
c0d01cc6:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01cc8:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01cca:	4629      	mov	r1, r5
c0d01ccc:	f001 fb4a 	bl	c0d03364 <__aeabi_uidiv>
c0d01cd0:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01cd2:	4288      	cmp	r0, r1
c0d01cd4:	d109      	bne.n	c0d01cea <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01cd6:	4628      	mov	r0, r5
c0d01cd8:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01cda:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01cdc:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01cde:	910d      	str	r1, [sp, #52]	; 0x34
c0d01ce0:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01ce2:	4288      	cmp	r0, r1
c0d01ce4:	4622      	mov	r2, r4
c0d01ce6:	d9ee      	bls.n	c0d01cc6 <snprintf+0x236>
c0d01ce8:	e000      	b.n	c0d01cec <snprintf+0x25c>
c0d01cea:	460c      	mov	r4, r1
c0d01cec:	950c      	str	r5, [sp, #48]	; 0x30
c0d01cee:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01cf0:	2000      	movs	r0, #0
c0d01cf2:	4603      	mov	r3, r0
c0d01cf4:	43c1      	mvns	r1, r0
c0d01cf6:	9c05      	ldr	r4, [sp, #20]
c0d01cf8:	2c00      	cmp	r4, #0
c0d01cfa:	d100      	bne.n	c0d01cfe <snprintf+0x26e>
c0d01cfc:	4621      	mov	r1, r4
c0d01cfe:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01d00:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01d02:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01d04:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01d06:	b2ca      	uxtb	r2, r1
c0d01d08:	2a30      	cmp	r2, #48	; 0x30
c0d01d0a:	d106      	bne.n	c0d01d1a <snprintf+0x28a>
c0d01d0c:	2c00      	cmp	r4, #0
c0d01d0e:	d004      	beq.n	c0d01d1a <snprintf+0x28a>
c0d01d10:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01d12:	232d      	movs	r3, #45	; 0x2d
c0d01d14:	700b      	strb	r3, [r1, #0]
c0d01d16:	2400      	movs	r4, #0
c0d01d18:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01d1a:	1e81      	subs	r1, r0, #2
c0d01d1c:	290d      	cmp	r1, #13
c0d01d1e:	d80d      	bhi.n	c0d01d3c <snprintf+0x2ac>
c0d01d20:	1e41      	subs	r1, r0, #1
c0d01d22:	d00b      	beq.n	c0d01d3c <snprintf+0x2ac>
c0d01d24:	a810      	add	r0, sp, #64	; 0x40
c0d01d26:	9405      	str	r4, [sp, #20]
c0d01d28:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01d2a:	4320      	orrs	r0, r4
c0d01d2c:	f001 fda4 	bl	c0d03878 <__aeabi_memset>
c0d01d30:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01d32:	1900      	adds	r0, r0, r4
c0d01d34:	9c05      	ldr	r4, [sp, #20]
c0d01d36:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01d38:	1840      	adds	r0, r0, r1
c0d01d3a:	1e43      	subs	r3, r0, #1
c0d01d3c:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01d3e:	2c00      	cmp	r4, #0
c0d01d40:	9601      	str	r6, [sp, #4]
c0d01d42:	d003      	beq.n	c0d01d4c <snprintf+0x2bc>
c0d01d44:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01d46:	222d      	movs	r2, #45	; 0x2d
c0d01d48:	54c2      	strb	r2, [r0, r3]
c0d01d4a:	1c5b      	adds	r3, r3, #1
c0d01d4c:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01d4e:	2900      	cmp	r1, #0
c0d01d50:	d003      	beq.n	c0d01d5a <snprintf+0x2ca>
c0d01d52:	2800      	cmp	r0, #0
c0d01d54:	d003      	beq.n	c0d01d5e <snprintf+0x2ce>
c0d01d56:	a06c      	add	r0, pc, #432	; (adr r0, c0d01f08 <g_pcHex_cap>)
c0d01d58:	e002      	b.n	c0d01d60 <snprintf+0x2d0>
c0d01d5a:	461c      	mov	r4, r3
c0d01d5c:	e016      	b.n	c0d01d8c <snprintf+0x2fc>
c0d01d5e:	a06e      	add	r0, pc, #440	; (adr r0, c0d01f18 <g_pcHex>)
c0d01d60:	900d      	str	r0, [sp, #52]	; 0x34
c0d01d62:	461c      	mov	r4, r3
c0d01d64:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01d66:	460e      	mov	r6, r1
c0d01d68:	f001 fafc 	bl	c0d03364 <__aeabi_uidiv>
c0d01d6c:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01d6e:	4629      	mov	r1, r5
c0d01d70:	f001 fb7e 	bl	c0d03470 <__aeabi_uidivmod>
c0d01d74:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01d76:	5c40      	ldrb	r0, [r0, r1]
c0d01d78:	a910      	add	r1, sp, #64	; 0x40
c0d01d7a:	5508      	strb	r0, [r1, r4]
c0d01d7c:	4630      	mov	r0, r6
c0d01d7e:	4629      	mov	r1, r5
c0d01d80:	f001 faf0 	bl	c0d03364 <__aeabi_uidiv>
c0d01d84:	1c64      	adds	r4, r4, #1
c0d01d86:	42b5      	cmp	r5, r6
c0d01d88:	4601      	mov	r1, r0
c0d01d8a:	d9eb      	bls.n	c0d01d64 <snprintf+0x2d4>
c0d01d8c:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01d8e:	429c      	cmp	r4, r3
c0d01d90:	4625      	mov	r5, r4
c0d01d92:	d300      	bcc.n	c0d01d96 <snprintf+0x306>
c0d01d94:	461d      	mov	r5, r3
c0d01d96:	a910      	add	r1, sp, #64	; 0x40
c0d01d98:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01d9a:	4620      	mov	r0, r4
c0d01d9c:	462a      	mov	r2, r5
c0d01d9e:	461e      	mov	r6, r3
c0d01da0:	f7ff fa46 	bl	c0d01230 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01da4:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d01da6:	1961      	adds	r1, r4, r5
c0d01da8:	910e      	str	r1, [sp, #56]	; 0x38
c0d01daa:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01dac:	2800      	cmp	r0, #0
c0d01dae:	9e01      	ldr	r6, [sp, #4]
c0d01db0:	d16b      	bne.n	c0d01e8a <snprintf+0x3fa>
c0d01db2:	e0a3      	b.n	c0d01efc <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01db4:	2025      	movs	r0, #37	; 0x25
c0d01db6:	9907      	ldr	r1, [sp, #28]
c0d01db8:	7008      	strb	r0, [r1, #0]
c0d01dba:	9804      	ldr	r0, [sp, #16]
c0d01dbc:	1e40      	subs	r0, r0, #1
c0d01dbe:	1c49      	adds	r1, r1, #1
c0d01dc0:	e05f      	b.n	c0d01e82 <snprintf+0x3f2>
c0d01dc2:	9d02      	ldr	r5, [sp, #8]
c0d01dc4:	9c08      	ldr	r4, [sp, #32]
c0d01dc6:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01dc8:	9803      	ldr	r0, [sp, #12]
c0d01dca:	2810      	cmp	r0, #16
c0d01dcc:	9807      	ldr	r0, [sp, #28]
c0d01dce:	d161      	bne.n	c0d01e94 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01dd0:	2d00      	cmp	r5, #0
c0d01dd2:	d06a      	beq.n	c0d01eaa <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01dd4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01dd6:	1900      	adds	r0, r0, r4
c0d01dd8:	900e      	str	r0, [sp, #56]	; 0x38
c0d01dda:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01ddc:	1aa0      	subs	r0, r4, r2
c0d01dde:	9b05      	ldr	r3, [sp, #20]
c0d01de0:	4283      	cmp	r3, r0
c0d01de2:	d800      	bhi.n	c0d01de6 <snprintf+0x356>
c0d01de4:	4603      	mov	r3, r0
c0d01de6:	930c      	str	r3, [sp, #48]	; 0x30
c0d01de8:	435c      	muls	r4, r3
c0d01dea:	940a      	str	r4, [sp, #40]	; 0x28
c0d01dec:	1c60      	adds	r0, r4, #1
c0d01dee:	9007      	str	r0, [sp, #28]
c0d01df0:	2000      	movs	r0, #0
c0d01df2:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01df4:	9100      	str	r1, [sp, #0]
c0d01df6:	940e      	str	r4, [sp, #56]	; 0x38
c0d01df8:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01dfa:	18e3      	adds	r3, r4, r3
c0d01dfc:	900d      	str	r0, [sp, #52]	; 0x34
c0d01dfe:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01e00:	200f      	movs	r0, #15
c0d01e02:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01e04:	0909      	lsrs	r1, r1, #4
c0d01e06:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01e08:	18a4      	adds	r4, r4, r2
c0d01e0a:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01e0c:	2c02      	cmp	r4, #2
c0d01e0e:	d375      	bcc.n	c0d01efc <snprintf+0x46c>
c0d01e10:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01e12:	2c01      	cmp	r4, #1
c0d01e14:	d003      	beq.n	c0d01e1e <snprintf+0x38e>
c0d01e16:	2c00      	cmp	r4, #0
c0d01e18:	d108      	bne.n	c0d01e2c <snprintf+0x39c>
c0d01e1a:	a43f      	add	r4, pc, #252	; (adr r4, c0d01f18 <g_pcHex>)
c0d01e1c:	e000      	b.n	c0d01e20 <snprintf+0x390>
c0d01e1e:	a43a      	add	r4, pc, #232	; (adr r4, c0d01f08 <g_pcHex_cap>)
c0d01e20:	b2c9      	uxtb	r1, r1
c0d01e22:	5c61      	ldrb	r1, [r4, r1]
c0d01e24:	7019      	strb	r1, [r3, #0]
c0d01e26:	b2c0      	uxtb	r0, r0
c0d01e28:	5c20      	ldrb	r0, [r4, r0]
c0d01e2a:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01e2c:	9807      	ldr	r0, [sp, #28]
c0d01e2e:	4290      	cmp	r0, r2
c0d01e30:	d064      	beq.n	c0d01efc <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01e32:	1e92      	subs	r2, r2, #2
c0d01e34:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01e36:	1ca4      	adds	r4, r4, #2
c0d01e38:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01e3a:	1c40      	adds	r0, r0, #1
c0d01e3c:	42a8      	cmp	r0, r5
c0d01e3e:	9900      	ldr	r1, [sp, #0]
c0d01e40:	d3d9      	bcc.n	c0d01df6 <snprintf+0x366>
c0d01e42:	900d      	str	r0, [sp, #52]	; 0x34
c0d01e44:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01e46:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01e48:	1a08      	subs	r0, r1, r0
c0d01e4a:	9b05      	ldr	r3, [sp, #20]
c0d01e4c:	4283      	cmp	r3, r0
c0d01e4e:	d800      	bhi.n	c0d01e52 <snprintf+0x3c2>
c0d01e50:	4603      	mov	r3, r0
c0d01e52:	4608      	mov	r0, r1
c0d01e54:	4358      	muls	r0, r3
c0d01e56:	1820      	adds	r0, r4, r0
c0d01e58:	900e      	str	r0, [sp, #56]	; 0x38
c0d01e5a:	1898      	adds	r0, r3, r2
c0d01e5c:	1c43      	adds	r3, r0, #1
c0d01e5e:	e038      	b.n	c0d01ed2 <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01e60:	7808      	ldrb	r0, [r1, #0]
c0d01e62:	2800      	cmp	r0, #0
c0d01e64:	d023      	beq.n	c0d01eae <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d01e66:	2005      	movs	r0, #5
c0d01e68:	9d04      	ldr	r5, [sp, #16]
c0d01e6a:	2d05      	cmp	r5, #5
c0d01e6c:	462c      	mov	r4, r5
c0d01e6e:	d300      	bcc.n	c0d01e72 <snprintf+0x3e2>
c0d01e70:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01e72:	9807      	ldr	r0, [sp, #28]
c0d01e74:	a12c      	add	r1, pc, #176	; (adr r1, c0d01f28 <g_pcHex+0x10>)
c0d01e76:	4622      	mov	r2, r4
c0d01e78:	f7ff f9da 	bl	c0d01230 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01e7c:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01e7e:	9907      	ldr	r1, [sp, #28]
c0d01e80:	1909      	adds	r1, r1, r4
c0d01e82:	910e      	str	r1, [sp, #56]	; 0x38
c0d01e84:	4603      	mov	r3, r0
c0d01e86:	2800      	cmp	r0, #0
c0d01e88:	d038      	beq.n	c0d01efc <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01e8a:	7830      	ldrb	r0, [r6, #0]
c0d01e8c:	2800      	cmp	r0, #0
c0d01e8e:	9908      	ldr	r1, [sp, #32]
c0d01e90:	d034      	beq.n	c0d01efc <snprintf+0x46c>
c0d01e92:	e61f      	b.n	c0d01ad4 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01e94:	429d      	cmp	r5, r3
c0d01e96:	d300      	bcc.n	c0d01e9a <snprintf+0x40a>
c0d01e98:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01e9a:	462a      	mov	r2, r5
c0d01e9c:	461c      	mov	r4, r3
c0d01e9e:	f7ff f9c7 	bl	c0d01230 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01ea2:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01ea4:	9907      	ldr	r1, [sp, #28]
c0d01ea6:	1949      	adds	r1, r1, r5
c0d01ea8:	e00f      	b.n	c0d01eca <snprintf+0x43a>
c0d01eaa:	900e      	str	r0, [sp, #56]	; 0x38
c0d01eac:	e7ed      	b.n	c0d01e8a <snprintf+0x3fa>
c0d01eae:	9b04      	ldr	r3, [sp, #16]
c0d01eb0:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01eb2:	429c      	cmp	r4, r3
c0d01eb4:	d300      	bcc.n	c0d01eb8 <snprintf+0x428>
c0d01eb6:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d01eb8:	2120      	movs	r1, #32
c0d01eba:	9807      	ldr	r0, [sp, #28]
c0d01ebc:	4622      	mov	r2, r4
c0d01ebe:	f7ff f9ad 	bl	c0d0121c <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d01ec2:	9804      	ldr	r0, [sp, #16]
c0d01ec4:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d01ec6:	9907      	ldr	r1, [sp, #28]
c0d01ec8:	1909      	adds	r1, r1, r4
c0d01eca:	910e      	str	r1, [sp, #56]	; 0x38
c0d01ecc:	4603      	mov	r3, r0
c0d01ece:	2800      	cmp	r0, #0
c0d01ed0:	d014      	beq.n	c0d01efc <snprintf+0x46c>
c0d01ed2:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01ed4:	42a8      	cmp	r0, r5
c0d01ed6:	d9d8      	bls.n	c0d01e8a <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d01ed8:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d01eda:	429a      	cmp	r2, r3
c0d01edc:	d300      	bcc.n	c0d01ee0 <snprintf+0x450>
c0d01ede:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d01ee0:	2120      	movs	r1, #32
c0d01ee2:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01ee4:	4628      	mov	r0, r5
c0d01ee6:	920d      	str	r2, [sp, #52]	; 0x34
c0d01ee8:	461c      	mov	r4, r3
c0d01eea:	f7ff f997 	bl	c0d0121c <os_memset>
c0d01eee:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01ef0:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01ef2:	182d      	adds	r5, r5, r0
c0d01ef4:	950e      	str	r5, [sp, #56]	; 0x38
c0d01ef6:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d01ef8:	2c00      	cmp	r4, #0
c0d01efa:	d1c6      	bne.n	c0d01e8a <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01efc:	2000      	movs	r0, #0
c0d01efe:	b014      	add	sp, #80	; 0x50
c0d01f00:	bcf0      	pop	{r4, r5, r6, r7}
c0d01f02:	bc02      	pop	{r1}
c0d01f04:	b001      	add	sp, #4
c0d01f06:	4708      	bx	r1

c0d01f08 <g_pcHex_cap>:
c0d01f08:	33323130 	.word	0x33323130
c0d01f0c:	37363534 	.word	0x37363534
c0d01f10:	42413938 	.word	0x42413938
c0d01f14:	46454443 	.word	0x46454443

c0d01f18 <g_pcHex>:
c0d01f18:	33323130 	.word	0x33323130
c0d01f1c:	37363534 	.word	0x37363534
c0d01f20:	62613938 	.word	0x62613938
c0d01f24:	66656463 	.word	0x66656463
c0d01f28:	4f525245 	.word	0x4f525245
c0d01f2c:	00000052 	.word	0x00000052

c0d01f30 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01f30:	b580      	push	{r7, lr}
c0d01f32:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01f34:	4904      	ldr	r1, [pc, #16]	; (c0d01f48 <pic+0x18>)
c0d01f36:	4288      	cmp	r0, r1
c0d01f38:	d304      	bcc.n	c0d01f44 <pic+0x14>
c0d01f3a:	4904      	ldr	r1, [pc, #16]	; (c0d01f4c <pic+0x1c>)
c0d01f3c:	4288      	cmp	r0, r1
c0d01f3e:	d201      	bcs.n	c0d01f44 <pic+0x14>
		link_address = pic_internal(link_address);
c0d01f40:	f000 f806 	bl	c0d01f50 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01f44:	bd80      	pop	{r7, pc}
c0d01f46:	46c0      	nop			; (mov r8, r8)
c0d01f48:	c0d00000 	.word	0xc0d00000
c0d01f4c:	c0d03e80 	.word	0xc0d03e80

c0d01f50 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01f50:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01f52:	4902      	ldr	r1, [pc, #8]	; (c0d01f5c <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01f54:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01f56:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01f58:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01f5a:	4770      	bx	lr
c0d01f5c:	c0d01f51 	.word	0xc0d01f51

c0d01f60 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01f60:	b580      	push	{r7, lr}
c0d01f62:	af00      	add	r7, sp, #0
c0d01f64:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01f66:	490a      	ldr	r1, [pc, #40]	; (c0d01f90 <check_api_level+0x30>)
c0d01f68:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f6a:	490a      	ldr	r1, [pc, #40]	; (c0d01f94 <check_api_level+0x34>)
c0d01f6c:	680a      	ldr	r2, [r1, #0]
c0d01f6e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01f70:	9003      	str	r0, [sp, #12]
c0d01f72:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f74:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01f76:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f78:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01f7a:	4807      	ldr	r0, [pc, #28]	; (c0d01f98 <check_api_level+0x38>)
c0d01f7c:	9a01      	ldr	r2, [sp, #4]
c0d01f7e:	4282      	cmp	r2, r0
c0d01f80:	d101      	bne.n	c0d01f86 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01f82:	b004      	add	sp, #16
c0d01f84:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f86:	6808      	ldr	r0, [r1, #0]
c0d01f88:	2104      	movs	r1, #4
c0d01f8a:	f001 fd0d 	bl	c0d039a8 <longjmp>
c0d01f8e:	46c0      	nop			; (mov r8, r8)
c0d01f90:	60000137 	.word	0x60000137
c0d01f94:	20001bb8 	.word	0x20001bb8
c0d01f98:	900001c6 	.word	0x900001c6

c0d01f9c <reset>:
  }
}

void reset ( void ) 
{
c0d01f9c:	b580      	push	{r7, lr}
c0d01f9e:	af00      	add	r7, sp, #0
c0d01fa0:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d01fa2:	4809      	ldr	r0, [pc, #36]	; (c0d01fc8 <reset+0x2c>)
c0d01fa4:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01fa6:	4809      	ldr	r0, [pc, #36]	; (c0d01fcc <reset+0x30>)
c0d01fa8:	6801      	ldr	r1, [r0, #0]
c0d01faa:	9101      	str	r1, [sp, #4]
c0d01fac:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01fae:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01fb0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01fb2:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01fb4:	4906      	ldr	r1, [pc, #24]	; (c0d01fd0 <reset+0x34>)
c0d01fb6:	9a00      	ldr	r2, [sp, #0]
c0d01fb8:	428a      	cmp	r2, r1
c0d01fba:	d101      	bne.n	c0d01fc0 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01fbc:	b002      	add	sp, #8
c0d01fbe:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01fc0:	6800      	ldr	r0, [r0, #0]
c0d01fc2:	2104      	movs	r1, #4
c0d01fc4:	f001 fcf0 	bl	c0d039a8 <longjmp>
c0d01fc8:	60000200 	.word	0x60000200
c0d01fcc:	20001bb8 	.word	0x20001bb8
c0d01fd0:	900002f1 	.word	0x900002f1

c0d01fd4 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01fd4:	b5d0      	push	{r4, r6, r7, lr}
c0d01fd6:	af02      	add	r7, sp, #8
c0d01fd8:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d01fda:	4b0a      	ldr	r3, [pc, #40]	; (c0d02004 <nvm_write+0x30>)
c0d01fdc:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01fde:	4b0a      	ldr	r3, [pc, #40]	; (c0d02008 <nvm_write+0x34>)
c0d01fe0:	681c      	ldr	r4, [r3, #0]
c0d01fe2:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d01fe4:	ac03      	add	r4, sp, #12
c0d01fe6:	c407      	stmia	r4!, {r0, r1, r2}
c0d01fe8:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01fea:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01fec:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01fee:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01ff0:	4806      	ldr	r0, [pc, #24]	; (c0d0200c <nvm_write+0x38>)
c0d01ff2:	9901      	ldr	r1, [sp, #4]
c0d01ff4:	4281      	cmp	r1, r0
c0d01ff6:	d101      	bne.n	c0d01ffc <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01ff8:	b006      	add	sp, #24
c0d01ffa:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ffc:	6818      	ldr	r0, [r3, #0]
c0d01ffe:	2104      	movs	r1, #4
c0d02000:	f001 fcd2 	bl	c0d039a8 <longjmp>
c0d02004:	6000037f 	.word	0x6000037f
c0d02008:	20001bb8 	.word	0x20001bb8
c0d0200c:	900003bc 	.word	0x900003bc

c0d02010 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d02010:	b580      	push	{r7, lr}
c0d02012:	af00      	add	r7, sp, #0
c0d02014:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d02016:	4a0a      	ldr	r2, [pc, #40]	; (c0d02040 <cx_rng+0x30>)
c0d02018:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0201a:	4a0a      	ldr	r2, [pc, #40]	; (c0d02044 <cx_rng+0x34>)
c0d0201c:	6813      	ldr	r3, [r2, #0]
c0d0201e:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d02020:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d02022:	9103      	str	r1, [sp, #12]
c0d02024:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02026:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02028:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0202a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d0202c:	4906      	ldr	r1, [pc, #24]	; (c0d02048 <cx_rng+0x38>)
c0d0202e:	9b00      	ldr	r3, [sp, #0]
c0d02030:	428b      	cmp	r3, r1
c0d02032:	d101      	bne.n	c0d02038 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d02034:	b004      	add	sp, #16
c0d02036:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02038:	6810      	ldr	r0, [r2, #0]
c0d0203a:	2104      	movs	r1, #4
c0d0203c:	f001 fcb4 	bl	c0d039a8 <longjmp>
c0d02040:	6000052c 	.word	0x6000052c
c0d02044:	20001bb8 	.word	0x20001bb8
c0d02048:	90000567 	.word	0x90000567

c0d0204c <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d0204c:	b580      	push	{r7, lr}
c0d0204e:	af00      	add	r7, sp, #0
c0d02050:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d02052:	490a      	ldr	r1, [pc, #40]	; (c0d0207c <cx_sha256_init+0x30>)
c0d02054:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02056:	490a      	ldr	r1, [pc, #40]	; (c0d02080 <cx_sha256_init+0x34>)
c0d02058:	680a      	ldr	r2, [r1, #0]
c0d0205a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d0205c:	9003      	str	r0, [sp, #12]
c0d0205e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02060:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02062:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02064:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d02066:	4a07      	ldr	r2, [pc, #28]	; (c0d02084 <cx_sha256_init+0x38>)
c0d02068:	9b01      	ldr	r3, [sp, #4]
c0d0206a:	4293      	cmp	r3, r2
c0d0206c:	d101      	bne.n	c0d02072 <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0206e:	b004      	add	sp, #16
c0d02070:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02072:	6808      	ldr	r0, [r1, #0]
c0d02074:	2104      	movs	r1, #4
c0d02076:	f001 fc97 	bl	c0d039a8 <longjmp>
c0d0207a:	46c0      	nop			; (mov r8, r8)
c0d0207c:	600008db 	.word	0x600008db
c0d02080:	20001bb8 	.word	0x20001bb8
c0d02084:	90000864 	.word	0x90000864

c0d02088 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d02088:	b580      	push	{r7, lr}
c0d0208a:	af00      	add	r7, sp, #0
c0d0208c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d0208e:	4a0a      	ldr	r2, [pc, #40]	; (c0d020b8 <cx_keccak_init+0x30>)
c0d02090:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02092:	4a0a      	ldr	r2, [pc, #40]	; (c0d020bc <cx_keccak_init+0x34>)
c0d02094:	6813      	ldr	r3, [r2, #0]
c0d02096:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d02098:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d0209a:	9103      	str	r1, [sp, #12]
c0d0209c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0209e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d020a0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d020a2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d020a4:	4906      	ldr	r1, [pc, #24]	; (c0d020c0 <cx_keccak_init+0x38>)
c0d020a6:	9b00      	ldr	r3, [sp, #0]
c0d020a8:	428b      	cmp	r3, r1
c0d020aa:	d101      	bne.n	c0d020b0 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d020ac:	b004      	add	sp, #16
c0d020ae:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020b0:	6810      	ldr	r0, [r2, #0]
c0d020b2:	2104      	movs	r1, #4
c0d020b4:	f001 fc78 	bl	c0d039a8 <longjmp>
c0d020b8:	60000c3c 	.word	0x60000c3c
c0d020bc:	20001bb8 	.word	0x20001bb8
c0d020c0:	90000c39 	.word	0x90000c39

c0d020c4 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d020c4:	b5b0      	push	{r4, r5, r7, lr}
c0d020c6:	af02      	add	r7, sp, #8
c0d020c8:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d020ca:	4c0b      	ldr	r4, [pc, #44]	; (c0d020f8 <cx_hash+0x34>)
c0d020cc:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d020ce:	4c0b      	ldr	r4, [pc, #44]	; (c0d020fc <cx_hash+0x38>)
c0d020d0:	6825      	ldr	r5, [r4, #0]
c0d020d2:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d020d4:	ad03      	add	r5, sp, #12
c0d020d6:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d020d8:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d020da:	9007      	str	r0, [sp, #28]
c0d020dc:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d020de:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d020e0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d020e2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d020e4:	4906      	ldr	r1, [pc, #24]	; (c0d02100 <cx_hash+0x3c>)
c0d020e6:	9a01      	ldr	r2, [sp, #4]
c0d020e8:	428a      	cmp	r2, r1
c0d020ea:	d101      	bne.n	c0d020f0 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d020ec:	b008      	add	sp, #32
c0d020ee:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020f0:	6820      	ldr	r0, [r4, #0]
c0d020f2:	2104      	movs	r1, #4
c0d020f4:	f001 fc58 	bl	c0d039a8 <longjmp>
c0d020f8:	60000ea6 	.word	0x60000ea6
c0d020fc:	20001bb8 	.word	0x20001bb8
c0d02100:	90000e46 	.word	0x90000e46

c0d02104 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d02104:	b5b0      	push	{r4, r5, r7, lr}
c0d02106:	af02      	add	r7, sp, #8
c0d02108:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d0210a:	4c0a      	ldr	r4, [pc, #40]	; (c0d02134 <cx_ecfp_init_public_key+0x30>)
c0d0210c:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0210e:	4c0a      	ldr	r4, [pc, #40]	; (c0d02138 <cx_ecfp_init_public_key+0x34>)
c0d02110:	6825      	ldr	r5, [r4, #0]
c0d02112:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02114:	ad02      	add	r5, sp, #8
c0d02116:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02118:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0211a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0211c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0211e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d02120:	4906      	ldr	r1, [pc, #24]	; (c0d0213c <cx_ecfp_init_public_key+0x38>)
c0d02122:	9a00      	ldr	r2, [sp, #0]
c0d02124:	428a      	cmp	r2, r1
c0d02126:	d101      	bne.n	c0d0212c <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02128:	b006      	add	sp, #24
c0d0212a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0212c:	6820      	ldr	r0, [r4, #0]
c0d0212e:	2104      	movs	r1, #4
c0d02130:	f001 fc3a 	bl	c0d039a8 <longjmp>
c0d02134:	60002835 	.word	0x60002835
c0d02138:	20001bb8 	.word	0x20001bb8
c0d0213c:	900028f0 	.word	0x900028f0

c0d02140 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d02140:	b5b0      	push	{r4, r5, r7, lr}
c0d02142:	af02      	add	r7, sp, #8
c0d02144:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d02146:	4c0a      	ldr	r4, [pc, #40]	; (c0d02170 <cx_ecfp_init_private_key+0x30>)
c0d02148:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0214a:	4c0a      	ldr	r4, [pc, #40]	; (c0d02174 <cx_ecfp_init_private_key+0x34>)
c0d0214c:	6825      	ldr	r5, [r4, #0]
c0d0214e:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02150:	ad02      	add	r5, sp, #8
c0d02152:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02154:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02156:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02158:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0215a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d0215c:	4906      	ldr	r1, [pc, #24]	; (c0d02178 <cx_ecfp_init_private_key+0x38>)
c0d0215e:	9a00      	ldr	r2, [sp, #0]
c0d02160:	428a      	cmp	r2, r1
c0d02162:	d101      	bne.n	c0d02168 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02164:	b006      	add	sp, #24
c0d02166:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02168:	6820      	ldr	r0, [r4, #0]
c0d0216a:	2104      	movs	r1, #4
c0d0216c:	f001 fc1c 	bl	c0d039a8 <longjmp>
c0d02170:	600029ed 	.word	0x600029ed
c0d02174:	20001bb8 	.word	0x20001bb8
c0d02178:	900029ae 	.word	0x900029ae

c0d0217c <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d0217c:	b5b0      	push	{r4, r5, r7, lr}
c0d0217e:	af02      	add	r7, sp, #8
c0d02180:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d02182:	4c0a      	ldr	r4, [pc, #40]	; (c0d021ac <cx_ecfp_generate_pair+0x30>)
c0d02184:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02186:	4c0a      	ldr	r4, [pc, #40]	; (c0d021b0 <cx_ecfp_generate_pair+0x34>)
c0d02188:	6825      	ldr	r5, [r4, #0]
c0d0218a:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d0218c:	ad02      	add	r5, sp, #8
c0d0218e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02190:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02192:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02194:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02196:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d02198:	4906      	ldr	r1, [pc, #24]	; (c0d021b4 <cx_ecfp_generate_pair+0x38>)
c0d0219a:	9a00      	ldr	r2, [sp, #0]
c0d0219c:	428a      	cmp	r2, r1
c0d0219e:	d101      	bne.n	c0d021a4 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d021a0:	b006      	add	sp, #24
c0d021a2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021a4:	6820      	ldr	r0, [r4, #0]
c0d021a6:	2104      	movs	r1, #4
c0d021a8:	f001 fbfe 	bl	c0d039a8 <longjmp>
c0d021ac:	60002a2e 	.word	0x60002a2e
c0d021b0:	20001bb8 	.word	0x20001bb8
c0d021b4:	90002a74 	.word	0x90002a74

c0d021b8 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d021b8:	b5b0      	push	{r4, r5, r7, lr}
c0d021ba:	af02      	add	r7, sp, #8
c0d021bc:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d021be:	4c0b      	ldr	r4, [pc, #44]	; (c0d021ec <os_perso_derive_node_bip32+0x34>)
c0d021c0:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021c2:	4c0b      	ldr	r4, [pc, #44]	; (c0d021f0 <os_perso_derive_node_bip32+0x38>)
c0d021c4:	6825      	ldr	r5, [r4, #0]
c0d021c6:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d021c8:	ad03      	add	r5, sp, #12
c0d021ca:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d021cc:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d021ce:	9007      	str	r0, [sp, #28]
c0d021d0:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021d2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021d4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021d6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d021d8:	4806      	ldr	r0, [pc, #24]	; (c0d021f4 <os_perso_derive_node_bip32+0x3c>)
c0d021da:	9901      	ldr	r1, [sp, #4]
c0d021dc:	4281      	cmp	r1, r0
c0d021de:	d101      	bne.n	c0d021e4 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d021e0:	b008      	add	sp, #32
c0d021e2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021e4:	6820      	ldr	r0, [r4, #0]
c0d021e6:	2104      	movs	r1, #4
c0d021e8:	f001 fbde 	bl	c0d039a8 <longjmp>
c0d021ec:	6000512b 	.word	0x6000512b
c0d021f0:	20001bb8 	.word	0x20001bb8
c0d021f4:	9000517f 	.word	0x9000517f

c0d021f8 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d021f8:	b580      	push	{r7, lr}
c0d021fa:	af00      	add	r7, sp, #0
c0d021fc:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d021fe:	490a      	ldr	r1, [pc, #40]	; (c0d02228 <os_sched_exit+0x30>)
c0d02200:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02202:	490a      	ldr	r1, [pc, #40]	; (c0d0222c <os_sched_exit+0x34>)
c0d02204:	680a      	ldr	r2, [r1, #0]
c0d02206:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d02208:	9003      	str	r0, [sp, #12]
c0d0220a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0220c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0220e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02210:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d02212:	4807      	ldr	r0, [pc, #28]	; (c0d02230 <os_sched_exit+0x38>)
c0d02214:	9a01      	ldr	r2, [sp, #4]
c0d02216:	4282      	cmp	r2, r0
c0d02218:	d101      	bne.n	c0d0221e <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0221a:	b004      	add	sp, #16
c0d0221c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0221e:	6808      	ldr	r0, [r1, #0]
c0d02220:	2104      	movs	r1, #4
c0d02222:	f001 fbc1 	bl	c0d039a8 <longjmp>
c0d02226:	46c0      	nop			; (mov r8, r8)
c0d02228:	60005fe1 	.word	0x60005fe1
c0d0222c:	20001bb8 	.word	0x20001bb8
c0d02230:	90005f6f 	.word	0x90005f6f

c0d02234 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d02234:	b580      	push	{r7, lr}
c0d02236:	af00      	add	r7, sp, #0
c0d02238:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d0223a:	490a      	ldr	r1, [pc, #40]	; (c0d02264 <os_ux+0x30>)
c0d0223c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0223e:	490a      	ldr	r1, [pc, #40]	; (c0d02268 <os_ux+0x34>)
c0d02240:	680a      	ldr	r2, [r1, #0]
c0d02242:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d02244:	9003      	str	r0, [sp, #12]
c0d02246:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02248:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0224a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0224c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d0224e:	4a07      	ldr	r2, [pc, #28]	; (c0d0226c <os_ux+0x38>)
c0d02250:	9b01      	ldr	r3, [sp, #4]
c0d02252:	4293      	cmp	r3, r2
c0d02254:	d101      	bne.n	c0d0225a <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02256:	b004      	add	sp, #16
c0d02258:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0225a:	6808      	ldr	r0, [r1, #0]
c0d0225c:	2104      	movs	r1, #4
c0d0225e:	f001 fba3 	bl	c0d039a8 <longjmp>
c0d02262:	46c0      	nop			; (mov r8, r8)
c0d02264:	60006158 	.word	0x60006158
c0d02268:	20001bb8 	.word	0x20001bb8
c0d0226c:	9000611f 	.word	0x9000611f

c0d02270 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d02270:	b580      	push	{r7, lr}
c0d02272:	af00      	add	r7, sp, #0
c0d02274:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d02276:	4809      	ldr	r0, [pc, #36]	; (c0d0229c <os_seph_features+0x2c>)
c0d02278:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0227a:	4909      	ldr	r1, [pc, #36]	; (c0d022a0 <os_seph_features+0x30>)
c0d0227c:	6808      	ldr	r0, [r1, #0]
c0d0227e:	9001      	str	r0, [sp, #4]
c0d02280:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02282:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02284:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02286:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d02288:	4a06      	ldr	r2, [pc, #24]	; (c0d022a4 <os_seph_features+0x34>)
c0d0228a:	9b00      	ldr	r3, [sp, #0]
c0d0228c:	4293      	cmp	r3, r2
c0d0228e:	d101      	bne.n	c0d02294 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02290:	b002      	add	sp, #8
c0d02292:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02294:	6808      	ldr	r0, [r1, #0]
c0d02296:	2104      	movs	r1, #4
c0d02298:	f001 fb86 	bl	c0d039a8 <longjmp>
c0d0229c:	600064d6 	.word	0x600064d6
c0d022a0:	20001bb8 	.word	0x20001bb8
c0d022a4:	90006444 	.word	0x90006444

c0d022a8 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d022a8:	b580      	push	{r7, lr}
c0d022aa:	af00      	add	r7, sp, #0
c0d022ac:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d022ae:	4a0a      	ldr	r2, [pc, #40]	; (c0d022d8 <io_seproxyhal_spi_send+0x30>)
c0d022b0:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022b2:	4a0a      	ldr	r2, [pc, #40]	; (c0d022dc <io_seproxyhal_spi_send+0x34>)
c0d022b4:	6813      	ldr	r3, [r2, #0]
c0d022b6:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d022b8:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d022ba:	9103      	str	r1, [sp, #12]
c0d022bc:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022be:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022c0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022c2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d022c4:	4806      	ldr	r0, [pc, #24]	; (c0d022e0 <io_seproxyhal_spi_send+0x38>)
c0d022c6:	9900      	ldr	r1, [sp, #0]
c0d022c8:	4281      	cmp	r1, r0
c0d022ca:	d101      	bne.n	c0d022d0 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d022cc:	b004      	add	sp, #16
c0d022ce:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022d0:	6810      	ldr	r0, [r2, #0]
c0d022d2:	2104      	movs	r1, #4
c0d022d4:	f001 fb68 	bl	c0d039a8 <longjmp>
c0d022d8:	60006a1c 	.word	0x60006a1c
c0d022dc:	20001bb8 	.word	0x20001bb8
c0d022e0:	90006af3 	.word	0x90006af3

c0d022e4 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d022e4:	b580      	push	{r7, lr}
c0d022e6:	af00      	add	r7, sp, #0
c0d022e8:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d022ea:	4809      	ldr	r0, [pc, #36]	; (c0d02310 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d022ec:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022ee:	4909      	ldr	r1, [pc, #36]	; (c0d02314 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d022f0:	6808      	ldr	r0, [r1, #0]
c0d022f2:	9001      	str	r0, [sp, #4]
c0d022f4:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022f6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022f8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022fa:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d022fc:	4a06      	ldr	r2, [pc, #24]	; (c0d02318 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d022fe:	9b00      	ldr	r3, [sp, #0]
c0d02300:	4293      	cmp	r3, r2
c0d02302:	d101      	bne.n	c0d02308 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02304:	b002      	add	sp, #8
c0d02306:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02308:	6808      	ldr	r0, [r1, #0]
c0d0230a:	2104      	movs	r1, #4
c0d0230c:	f001 fb4c 	bl	c0d039a8 <longjmp>
c0d02310:	60006bcf 	.word	0x60006bcf
c0d02314:	20001bb8 	.word	0x20001bb8
c0d02318:	90006b7f 	.word	0x90006b7f

c0d0231c <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d0231c:	b5d0      	push	{r4, r6, r7, lr}
c0d0231e:	af02      	add	r7, sp, #8
c0d02320:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d02322:	4b0b      	ldr	r3, [pc, #44]	; (c0d02350 <io_seproxyhal_spi_recv+0x34>)
c0d02324:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02326:	4b0b      	ldr	r3, [pc, #44]	; (c0d02354 <io_seproxyhal_spi_recv+0x38>)
c0d02328:	681c      	ldr	r4, [r3, #0]
c0d0232a:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d0232c:	ac03      	add	r4, sp, #12
c0d0232e:	c407      	stmia	r4!, {r0, r1, r2}
c0d02330:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02332:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02334:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02336:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d02338:	4907      	ldr	r1, [pc, #28]	; (c0d02358 <io_seproxyhal_spi_recv+0x3c>)
c0d0233a:	9a01      	ldr	r2, [sp, #4]
c0d0233c:	428a      	cmp	r2, r1
c0d0233e:	d102      	bne.n	c0d02346 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d02340:	b280      	uxth	r0, r0
c0d02342:	b006      	add	sp, #24
c0d02344:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02346:	6818      	ldr	r0, [r3, #0]
c0d02348:	2104      	movs	r1, #4
c0d0234a:	f001 fb2d 	bl	c0d039a8 <longjmp>
c0d0234e:	46c0      	nop			; (mov r8, r8)
c0d02350:	60006cd1 	.word	0x60006cd1
c0d02354:	20001bb8 	.word	0x20001bb8
c0d02358:	90006c2b 	.word	0x90006c2b

c0d0235c <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d0235c:	b5b0      	push	{r4, r5, r7, lr}
c0d0235e:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d02360:	492c      	ldr	r1, [pc, #176]	; (c0d02414 <bagl_ui_nanos_screen1_button+0xb8>)
c0d02362:	4288      	cmp	r0, r1
c0d02364:	d006      	beq.n	c0d02374 <bagl_ui_nanos_screen1_button+0x18>
c0d02366:	492c      	ldr	r1, [pc, #176]	; (c0d02418 <bagl_ui_nanos_screen1_button+0xbc>)
c0d02368:	4288      	cmp	r0, r1
c0d0236a:	d151      	bne.n	c0d02410 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d0236c:	2000      	movs	r0, #0
c0d0236e:	f7ff ff43 	bl	c0d021f8 <os_sched_exit>
c0d02372:	e04d      	b.n	c0d02410 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d02374:	f7fe fba4 	bl	c0d00ac0 <nvram_is_init>
c0d02378:	2801      	cmp	r0, #1
c0d0237a:	d102      	bne.n	c0d02382 <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d0237c:	a029      	add	r0, pc, #164	; (adr r0, c0d02424 <bagl_ui_nanos_screen1_button+0xc8>)
c0d0237e:	210d      	movs	r1, #13
c0d02380:	e001      	b.n	c0d02386 <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d02382:	a026      	add	r0, pc, #152	; (adr r0, c0d0241c <bagl_ui_nanos_screen1_button+0xc0>)
c0d02384:	2105      	movs	r1, #5
c0d02386:	2203      	movs	r2, #3
c0d02388:	f7fd ff6c 	bl	c0d00264 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d0238c:	4c29      	ldr	r4, [pc, #164]	; (c0d02434 <bagl_ui_nanos_screen1_button+0xd8>)
c0d0238e:	482b      	ldr	r0, [pc, #172]	; (c0d0243c <bagl_ui_nanos_screen1_button+0xe0>)
c0d02390:	4478      	add	r0, pc
c0d02392:	6020      	str	r0, [r4, #0]
c0d02394:	2004      	movs	r0, #4
c0d02396:	6060      	str	r0, [r4, #4]
c0d02398:	4829      	ldr	r0, [pc, #164]	; (c0d02440 <bagl_ui_nanos_screen1_button+0xe4>)
c0d0239a:	4478      	add	r0, pc
c0d0239c:	6120      	str	r0, [r4, #16]
c0d0239e:	2500      	movs	r5, #0
c0d023a0:	60e5      	str	r5, [r4, #12]
c0d023a2:	2003      	movs	r0, #3
c0d023a4:	7620      	strb	r0, [r4, #24]
c0d023a6:	61e5      	str	r5, [r4, #28]
c0d023a8:	4620      	mov	r0, r4
c0d023aa:	3018      	adds	r0, #24
c0d023ac:	f7ff ff42 	bl	c0d02234 <os_ux>
c0d023b0:	61e0      	str	r0, [r4, #28]
c0d023b2:	f7ff f903 	bl	c0d015bc <io_seproxyhal_init_ux>
c0d023b6:	60a5      	str	r5, [r4, #8]
c0d023b8:	6820      	ldr	r0, [r4, #0]
c0d023ba:	2800      	cmp	r0, #0
c0d023bc:	d028      	beq.n	c0d02410 <bagl_ui_nanos_screen1_button+0xb4>
c0d023be:	69e0      	ldr	r0, [r4, #28]
c0d023c0:	491d      	ldr	r1, [pc, #116]	; (c0d02438 <bagl_ui_nanos_screen1_button+0xdc>)
c0d023c2:	4288      	cmp	r0, r1
c0d023c4:	d116      	bne.n	c0d023f4 <bagl_ui_nanos_screen1_button+0x98>
c0d023c6:	e023      	b.n	c0d02410 <bagl_ui_nanos_screen1_button+0xb4>
c0d023c8:	6860      	ldr	r0, [r4, #4]
c0d023ca:	4285      	cmp	r5, r0
c0d023cc:	d220      	bcs.n	c0d02410 <bagl_ui_nanos_screen1_button+0xb4>
c0d023ce:	f7ff ff89 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d023d2:	2800      	cmp	r0, #0
c0d023d4:	d11c      	bne.n	c0d02410 <bagl_ui_nanos_screen1_button+0xb4>
c0d023d6:	68a0      	ldr	r0, [r4, #8]
c0d023d8:	68e1      	ldr	r1, [r4, #12]
c0d023da:	2538      	movs	r5, #56	; 0x38
c0d023dc:	4368      	muls	r0, r5
c0d023de:	6822      	ldr	r2, [r4, #0]
c0d023e0:	1810      	adds	r0, r2, r0
c0d023e2:	2900      	cmp	r1, #0
c0d023e4:	d009      	beq.n	c0d023fa <bagl_ui_nanos_screen1_button+0x9e>
c0d023e6:	4788      	blx	r1
c0d023e8:	2800      	cmp	r0, #0
c0d023ea:	d106      	bne.n	c0d023fa <bagl_ui_nanos_screen1_button+0x9e>
c0d023ec:	68a0      	ldr	r0, [r4, #8]
c0d023ee:	1c45      	adds	r5, r0, #1
c0d023f0:	60a5      	str	r5, [r4, #8]
c0d023f2:	6820      	ldr	r0, [r4, #0]
c0d023f4:	2800      	cmp	r0, #0
c0d023f6:	d1e7      	bne.n	c0d023c8 <bagl_ui_nanos_screen1_button+0x6c>
c0d023f8:	e00a      	b.n	c0d02410 <bagl_ui_nanos_screen1_button+0xb4>
c0d023fa:	2801      	cmp	r0, #1
c0d023fc:	d103      	bne.n	c0d02406 <bagl_ui_nanos_screen1_button+0xaa>
c0d023fe:	68a0      	ldr	r0, [r4, #8]
c0d02400:	4345      	muls	r5, r0
c0d02402:	6820      	ldr	r0, [r4, #0]
c0d02404:	1940      	adds	r0, r0, r5
c0d02406:	f7fe fb91 	bl	c0d00b2c <io_seproxyhal_display>
c0d0240a:	68a0      	ldr	r0, [r4, #8]
c0d0240c:	1c40      	adds	r0, r0, #1
c0d0240e:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d02410:	2000      	movs	r0, #0
c0d02412:	bdb0      	pop	{r4, r5, r7, pc}
c0d02414:	80000002 	.word	0x80000002
c0d02418:	80000001 	.word	0x80000001
c0d0241c:	54494e49 	.word	0x54494e49
c0d02420:	00000000 	.word	0x00000000
c0d02424:	6c697453 	.word	0x6c697453
c0d02428:	6e75206c 	.word	0x6e75206c
c0d0242c:	74696e69 	.word	0x74696e69
c0d02430:	00000000 	.word	0x00000000
c0d02434:	20001a98 	.word	0x20001a98
c0d02438:	b0105044 	.word	0xb0105044
c0d0243c:	000017ac 	.word	0x000017ac
c0d02440:	00000153 	.word	0x00000153

c0d02444 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d02444:	b5b0      	push	{r4, r5, r7, lr}
c0d02446:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d02448:	2800      	cmp	r0, #0
c0d0244a:	d005      	beq.n	c0d02458 <ui_display_debug+0x14>
c0d0244c:	2900      	cmp	r1, #0
c0d0244e:	d003      	beq.n	c0d02458 <ui_display_debug+0x14>
c0d02450:	2a00      	cmp	r2, #0
c0d02452:	d001      	beq.n	c0d02458 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d02454:	f7fd ff06 	bl	c0d00264 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02458:	4c21      	ldr	r4, [pc, #132]	; (c0d024e0 <ui_display_debug+0x9c>)
c0d0245a:	4823      	ldr	r0, [pc, #140]	; (c0d024e8 <ui_display_debug+0xa4>)
c0d0245c:	4478      	add	r0, pc
c0d0245e:	6020      	str	r0, [r4, #0]
c0d02460:	2004      	movs	r0, #4
c0d02462:	6060      	str	r0, [r4, #4]
c0d02464:	4821      	ldr	r0, [pc, #132]	; (c0d024ec <ui_display_debug+0xa8>)
c0d02466:	4478      	add	r0, pc
c0d02468:	6120      	str	r0, [r4, #16]
c0d0246a:	2500      	movs	r5, #0
c0d0246c:	60e5      	str	r5, [r4, #12]
c0d0246e:	2003      	movs	r0, #3
c0d02470:	7620      	strb	r0, [r4, #24]
c0d02472:	61e5      	str	r5, [r4, #28]
c0d02474:	4620      	mov	r0, r4
c0d02476:	3018      	adds	r0, #24
c0d02478:	f7ff fedc 	bl	c0d02234 <os_ux>
c0d0247c:	61e0      	str	r0, [r4, #28]
c0d0247e:	f7ff f89d 	bl	c0d015bc <io_seproxyhal_init_ux>
c0d02482:	60a5      	str	r5, [r4, #8]
c0d02484:	6820      	ldr	r0, [r4, #0]
c0d02486:	2800      	cmp	r0, #0
c0d02488:	d028      	beq.n	c0d024dc <ui_display_debug+0x98>
c0d0248a:	69e0      	ldr	r0, [r4, #28]
c0d0248c:	4915      	ldr	r1, [pc, #84]	; (c0d024e4 <ui_display_debug+0xa0>)
c0d0248e:	4288      	cmp	r0, r1
c0d02490:	d116      	bne.n	c0d024c0 <ui_display_debug+0x7c>
c0d02492:	e023      	b.n	c0d024dc <ui_display_debug+0x98>
c0d02494:	6860      	ldr	r0, [r4, #4]
c0d02496:	4285      	cmp	r5, r0
c0d02498:	d220      	bcs.n	c0d024dc <ui_display_debug+0x98>
c0d0249a:	f7ff ff23 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d0249e:	2800      	cmp	r0, #0
c0d024a0:	d11c      	bne.n	c0d024dc <ui_display_debug+0x98>
c0d024a2:	68a0      	ldr	r0, [r4, #8]
c0d024a4:	68e1      	ldr	r1, [r4, #12]
c0d024a6:	2538      	movs	r5, #56	; 0x38
c0d024a8:	4368      	muls	r0, r5
c0d024aa:	6822      	ldr	r2, [r4, #0]
c0d024ac:	1810      	adds	r0, r2, r0
c0d024ae:	2900      	cmp	r1, #0
c0d024b0:	d009      	beq.n	c0d024c6 <ui_display_debug+0x82>
c0d024b2:	4788      	blx	r1
c0d024b4:	2800      	cmp	r0, #0
c0d024b6:	d106      	bne.n	c0d024c6 <ui_display_debug+0x82>
c0d024b8:	68a0      	ldr	r0, [r4, #8]
c0d024ba:	1c45      	adds	r5, r0, #1
c0d024bc:	60a5      	str	r5, [r4, #8]
c0d024be:	6820      	ldr	r0, [r4, #0]
c0d024c0:	2800      	cmp	r0, #0
c0d024c2:	d1e7      	bne.n	c0d02494 <ui_display_debug+0x50>
c0d024c4:	e00a      	b.n	c0d024dc <ui_display_debug+0x98>
c0d024c6:	2801      	cmp	r0, #1
c0d024c8:	d103      	bne.n	c0d024d2 <ui_display_debug+0x8e>
c0d024ca:	68a0      	ldr	r0, [r4, #8]
c0d024cc:	4345      	muls	r5, r0
c0d024ce:	6820      	ldr	r0, [r4, #0]
c0d024d0:	1940      	adds	r0, r0, r5
c0d024d2:	f7fe fb2b 	bl	c0d00b2c <io_seproxyhal_display>
c0d024d6:	68a0      	ldr	r0, [r4, #8]
c0d024d8:	1c40      	adds	r0, r0, #1
c0d024da:	60a0      	str	r0, [r4, #8]
}
c0d024dc:	bdb0      	pop	{r4, r5, r7, pc}
c0d024de:	46c0      	nop			; (mov r8, r8)
c0d024e0:	20001a98 	.word	0x20001a98
c0d024e4:	b0105044 	.word	0xb0105044
c0d024e8:	000016e0 	.word	0x000016e0
c0d024ec:	00000087 	.word	0x00000087

c0d024f0 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d024f0:	b580      	push	{r7, lr}
c0d024f2:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d024f4:	4905      	ldr	r1, [pc, #20]	; (c0d0250c <bagl_ui_nanos_screen2_button+0x1c>)
c0d024f6:	4288      	cmp	r0, r1
c0d024f8:	d002      	beq.n	c0d02500 <bagl_ui_nanos_screen2_button+0x10>
c0d024fa:	4905      	ldr	r1, [pc, #20]	; (c0d02510 <bagl_ui_nanos_screen2_button+0x20>)
c0d024fc:	4288      	cmp	r0, r1
c0d024fe:	d102      	bne.n	c0d02506 <bagl_ui_nanos_screen2_button+0x16>
c0d02500:	2000      	movs	r0, #0
c0d02502:	f7ff fe79 	bl	c0d021f8 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d02506:	2000      	movs	r0, #0
c0d02508:	bd80      	pop	{r7, pc}
c0d0250a:	46c0      	nop			; (mov r8, r8)
c0d0250c:	80000002 	.word	0x80000002
c0d02510:	80000001 	.word	0x80000001

c0d02514 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d02514:	b5b0      	push	{r4, r5, r7, lr}
c0d02516:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d02518:	2001      	movs	r0, #1
c0d0251a:	0204      	lsls	r4, r0, #8
c0d0251c:	f7ff fea8 	bl	c0d02270 <os_seph_features>
c0d02520:	4220      	tst	r0, r4
c0d02522:	d136      	bne.n	c0d02592 <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d02524:	4c3c      	ldr	r4, [pc, #240]	; (c0d02618 <ui_idle+0x104>)
c0d02526:	4840      	ldr	r0, [pc, #256]	; (c0d02628 <ui_idle+0x114>)
c0d02528:	4478      	add	r0, pc
c0d0252a:	6020      	str	r0, [r4, #0]
c0d0252c:	2004      	movs	r0, #4
c0d0252e:	6060      	str	r0, [r4, #4]
c0d02530:	483e      	ldr	r0, [pc, #248]	; (c0d0262c <ui_idle+0x118>)
c0d02532:	4478      	add	r0, pc
c0d02534:	6120      	str	r0, [r4, #16]
c0d02536:	2500      	movs	r5, #0
c0d02538:	60e5      	str	r5, [r4, #12]
c0d0253a:	2003      	movs	r0, #3
c0d0253c:	7620      	strb	r0, [r4, #24]
c0d0253e:	61e5      	str	r5, [r4, #28]
c0d02540:	4620      	mov	r0, r4
c0d02542:	3018      	adds	r0, #24
c0d02544:	f7ff fe76 	bl	c0d02234 <os_ux>
c0d02548:	61e0      	str	r0, [r4, #28]
c0d0254a:	f7ff f837 	bl	c0d015bc <io_seproxyhal_init_ux>
c0d0254e:	60a5      	str	r5, [r4, #8]
c0d02550:	6820      	ldr	r0, [r4, #0]
c0d02552:	2800      	cmp	r0, #0
c0d02554:	d05f      	beq.n	c0d02616 <ui_idle+0x102>
c0d02556:	69e0      	ldr	r0, [r4, #28]
c0d02558:	4930      	ldr	r1, [pc, #192]	; (c0d0261c <ui_idle+0x108>)
c0d0255a:	4288      	cmp	r0, r1
c0d0255c:	d116      	bne.n	c0d0258c <ui_idle+0x78>
c0d0255e:	e05a      	b.n	c0d02616 <ui_idle+0x102>
c0d02560:	6860      	ldr	r0, [r4, #4]
c0d02562:	4285      	cmp	r5, r0
c0d02564:	d257      	bcs.n	c0d02616 <ui_idle+0x102>
c0d02566:	f7ff febd 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d0256a:	2800      	cmp	r0, #0
c0d0256c:	d153      	bne.n	c0d02616 <ui_idle+0x102>
c0d0256e:	68a0      	ldr	r0, [r4, #8]
c0d02570:	68e1      	ldr	r1, [r4, #12]
c0d02572:	2538      	movs	r5, #56	; 0x38
c0d02574:	4368      	muls	r0, r5
c0d02576:	6822      	ldr	r2, [r4, #0]
c0d02578:	1810      	adds	r0, r2, r0
c0d0257a:	2900      	cmp	r1, #0
c0d0257c:	d040      	beq.n	c0d02600 <ui_idle+0xec>
c0d0257e:	4788      	blx	r1
c0d02580:	2800      	cmp	r0, #0
c0d02582:	d13d      	bne.n	c0d02600 <ui_idle+0xec>
c0d02584:	68a0      	ldr	r0, [r4, #8]
c0d02586:	1c45      	adds	r5, r0, #1
c0d02588:	60a5      	str	r5, [r4, #8]
c0d0258a:	6820      	ldr	r0, [r4, #0]
c0d0258c:	2800      	cmp	r0, #0
c0d0258e:	d1e7      	bne.n	c0d02560 <ui_idle+0x4c>
c0d02590:	e041      	b.n	c0d02616 <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d02592:	4c21      	ldr	r4, [pc, #132]	; (c0d02618 <ui_idle+0x104>)
c0d02594:	4822      	ldr	r0, [pc, #136]	; (c0d02620 <ui_idle+0x10c>)
c0d02596:	4478      	add	r0, pc
c0d02598:	6020      	str	r0, [r4, #0]
c0d0259a:	2004      	movs	r0, #4
c0d0259c:	6060      	str	r0, [r4, #4]
c0d0259e:	4821      	ldr	r0, [pc, #132]	; (c0d02624 <ui_idle+0x110>)
c0d025a0:	4478      	add	r0, pc
c0d025a2:	6120      	str	r0, [r4, #16]
c0d025a4:	2500      	movs	r5, #0
c0d025a6:	60e5      	str	r5, [r4, #12]
c0d025a8:	2003      	movs	r0, #3
c0d025aa:	7620      	strb	r0, [r4, #24]
c0d025ac:	61e5      	str	r5, [r4, #28]
c0d025ae:	4620      	mov	r0, r4
c0d025b0:	3018      	adds	r0, #24
c0d025b2:	f7ff fe3f 	bl	c0d02234 <os_ux>
c0d025b6:	61e0      	str	r0, [r4, #28]
c0d025b8:	f7ff f800 	bl	c0d015bc <io_seproxyhal_init_ux>
c0d025bc:	60a5      	str	r5, [r4, #8]
c0d025be:	6820      	ldr	r0, [r4, #0]
c0d025c0:	2800      	cmp	r0, #0
c0d025c2:	d028      	beq.n	c0d02616 <ui_idle+0x102>
c0d025c4:	69e0      	ldr	r0, [r4, #28]
c0d025c6:	4915      	ldr	r1, [pc, #84]	; (c0d0261c <ui_idle+0x108>)
c0d025c8:	4288      	cmp	r0, r1
c0d025ca:	d116      	bne.n	c0d025fa <ui_idle+0xe6>
c0d025cc:	e023      	b.n	c0d02616 <ui_idle+0x102>
c0d025ce:	6860      	ldr	r0, [r4, #4]
c0d025d0:	4285      	cmp	r5, r0
c0d025d2:	d220      	bcs.n	c0d02616 <ui_idle+0x102>
c0d025d4:	f7ff fe86 	bl	c0d022e4 <io_seproxyhal_spi_is_status_sent>
c0d025d8:	2800      	cmp	r0, #0
c0d025da:	d11c      	bne.n	c0d02616 <ui_idle+0x102>
c0d025dc:	68a0      	ldr	r0, [r4, #8]
c0d025de:	68e1      	ldr	r1, [r4, #12]
c0d025e0:	2538      	movs	r5, #56	; 0x38
c0d025e2:	4368      	muls	r0, r5
c0d025e4:	6822      	ldr	r2, [r4, #0]
c0d025e6:	1810      	adds	r0, r2, r0
c0d025e8:	2900      	cmp	r1, #0
c0d025ea:	d009      	beq.n	c0d02600 <ui_idle+0xec>
c0d025ec:	4788      	blx	r1
c0d025ee:	2800      	cmp	r0, #0
c0d025f0:	d106      	bne.n	c0d02600 <ui_idle+0xec>
c0d025f2:	68a0      	ldr	r0, [r4, #8]
c0d025f4:	1c45      	adds	r5, r0, #1
c0d025f6:	60a5      	str	r5, [r4, #8]
c0d025f8:	6820      	ldr	r0, [r4, #0]
c0d025fa:	2800      	cmp	r0, #0
c0d025fc:	d1e7      	bne.n	c0d025ce <ui_idle+0xba>
c0d025fe:	e00a      	b.n	c0d02616 <ui_idle+0x102>
c0d02600:	2801      	cmp	r0, #1
c0d02602:	d103      	bne.n	c0d0260c <ui_idle+0xf8>
c0d02604:	68a0      	ldr	r0, [r4, #8]
c0d02606:	4345      	muls	r5, r0
c0d02608:	6820      	ldr	r0, [r4, #0]
c0d0260a:	1940      	adds	r0, r0, r5
c0d0260c:	f7fe fa8e 	bl	c0d00b2c <io_seproxyhal_display>
c0d02610:	68a0      	ldr	r0, [r4, #8]
c0d02612:	1c40      	adds	r0, r0, #1
c0d02614:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d02616:	bdb0      	pop	{r4, r5, r7, pc}
c0d02618:	20001a98 	.word	0x20001a98
c0d0261c:	b0105044 	.word	0xb0105044
c0d02620:	00001686 	.word	0x00001686
c0d02624:	0000008d 	.word	0x0000008d
c0d02628:	00001534 	.word	0x00001534
c0d0262c:	fffffe27 	.word	0xfffffe27

c0d02630 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d02630:	2000      	movs	r0, #0
c0d02632:	4770      	bx	lr

c0d02634 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d02634:	b5d0      	push	{r4, r6, r7, lr}
c0d02636:	af02      	add	r7, sp, #8
c0d02638:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d0263a:	4620      	mov	r0, r4
c0d0263c:	f7ff fddc 	bl	c0d021f8 <os_sched_exit>
    return NULL;
c0d02640:	4620      	mov	r0, r4
c0d02642:	bdd0      	pop	{r4, r6, r7, pc}

c0d02644 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02644:	4902      	ldr	r1, [pc, #8]	; (c0d02650 <USBD_LL_Init+0xc>)
c0d02646:	2000      	movs	r0, #0
c0d02648:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d0264a:	4902      	ldr	r1, [pc, #8]	; (c0d02654 <USBD_LL_Init+0x10>)
c0d0264c:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d0264e:	4770      	bx	lr
c0d02650:	20001d2c 	.word	0x20001d2c
c0d02654:	20001d30 	.word	0x20001d30

c0d02658 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02658:	b5d0      	push	{r4, r6, r7, lr}
c0d0265a:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0265c:	4806      	ldr	r0, [pc, #24]	; (c0d02678 <USBD_LL_DeInit+0x20>)
c0d0265e:	214f      	movs	r1, #79	; 0x4f
c0d02660:	7001      	strb	r1, [r0, #0]
c0d02662:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02664:	7044      	strb	r4, [r0, #1]
c0d02666:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02668:	7081      	strb	r1, [r0, #2]
c0d0266a:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d0266c:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0266e:	2104      	movs	r1, #4
c0d02670:	f7ff fe1a 	bl	c0d022a8 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02674:	4620      	mov	r0, r4
c0d02676:	bdd0      	pop	{r4, r6, r7, pc}
c0d02678:	20001a18 	.word	0x20001a18

c0d0267c <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d0267c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0267e:	af03      	add	r7, sp, #12
c0d02680:	b083      	sub	sp, #12
c0d02682:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02684:	264f      	movs	r6, #79	; 0x4f
c0d02686:	702e      	strb	r6, [r5, #0]
c0d02688:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0268a:	706c      	strb	r4, [r5, #1]
c0d0268c:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d0268e:	70a8      	strb	r0, [r5, #2]
c0d02690:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02692:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d02694:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02696:	2105      	movs	r1, #5
c0d02698:	4628      	mov	r0, r5
c0d0269a:	f7ff fe05 	bl	c0d022a8 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0269e:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d026a0:	706c      	strb	r4, [r5, #1]
c0d026a2:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d026a4:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d026a6:	70e8      	strb	r0, [r5, #3]
c0d026a8:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d026aa:	4628      	mov	r0, r5
c0d026ac:	f7ff fdfc 	bl	c0d022a8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d026b0:	4620      	mov	r0, r4
c0d026b2:	b003      	add	sp, #12
c0d026b4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d026b6 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d026b6:	b5d0      	push	{r4, r6, r7, lr}
c0d026b8:	af02      	add	r7, sp, #8
c0d026ba:	b082      	sub	sp, #8
c0d026bc:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d026be:	214f      	movs	r1, #79	; 0x4f
c0d026c0:	7001      	strb	r1, [r0, #0]
c0d026c2:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d026c4:	7044      	strb	r4, [r0, #1]
c0d026c6:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d026c8:	7081      	strb	r1, [r0, #2]
c0d026ca:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d026cc:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d026ce:	2104      	movs	r1, #4
c0d026d0:	f7ff fdea 	bl	c0d022a8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d026d4:	4620      	mov	r0, r4
c0d026d6:	b002      	add	sp, #8
c0d026d8:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d026dc <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d026dc:	b5b0      	push	{r4, r5, r7, lr}
c0d026de:	af02      	add	r7, sp, #8
c0d026e0:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d026e2:	480f      	ldr	r0, [pc, #60]	; (c0d02720 <USBD_LL_OpenEP+0x44>)
c0d026e4:	2400      	movs	r4, #0
c0d026e6:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d026e8:	480e      	ldr	r0, [pc, #56]	; (c0d02724 <USBD_LL_OpenEP+0x48>)
c0d026ea:	6004      	str	r4, [r0, #0]
c0d026ec:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d026ee:	254f      	movs	r5, #79	; 0x4f
c0d026f0:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d026f2:	7044      	strb	r4, [r0, #1]
c0d026f4:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d026f6:	7085      	strb	r5, [r0, #2]
c0d026f8:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d026fa:	70c5      	strb	r5, [r0, #3]
c0d026fc:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d026fe:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d02700:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d02702:	2a03      	cmp	r2, #3
c0d02704:	d802      	bhi.n	c0d0270c <USBD_LL_OpenEP+0x30>
c0d02706:	00d0      	lsls	r0, r2, #3
c0d02708:	4c07      	ldr	r4, [pc, #28]	; (c0d02728 <USBD_LL_OpenEP+0x4c>)
c0d0270a:	40c4      	lsrs	r4, r0
c0d0270c:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d0270e:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d02710:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02712:	2108      	movs	r1, #8
c0d02714:	f7ff fdc8 	bl	c0d022a8 <io_seproxyhal_spi_send>
c0d02718:	2000      	movs	r0, #0
  return USBD_OK; 
c0d0271a:	b002      	add	sp, #8
c0d0271c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0271e:	46c0      	nop			; (mov r8, r8)
c0d02720:	20001d2c 	.word	0x20001d2c
c0d02724:	20001d30 	.word	0x20001d30
c0d02728:	02030401 	.word	0x02030401

c0d0272c <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d0272c:	b5d0      	push	{r4, r6, r7, lr}
c0d0272e:	af02      	add	r7, sp, #8
c0d02730:	b082      	sub	sp, #8
c0d02732:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02734:	224f      	movs	r2, #79	; 0x4f
c0d02736:	7002      	strb	r2, [r0, #0]
c0d02738:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0273a:	7044      	strb	r4, [r0, #1]
c0d0273c:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d0273e:	7082      	strb	r2, [r0, #2]
c0d02740:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02742:	70c2      	strb	r2, [r0, #3]
c0d02744:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d02746:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02748:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d0274a:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d0274c:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d0274e:	2108      	movs	r1, #8
c0d02750:	f7ff fdaa 	bl	c0d022a8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02754:	4620      	mov	r0, r4
c0d02756:	b002      	add	sp, #8
c0d02758:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d0275c <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d0275c:	b5b0      	push	{r4, r5, r7, lr}
c0d0275e:	af02      	add	r7, sp, #8
c0d02760:	b082      	sub	sp, #8
c0d02762:	460d      	mov	r5, r1
c0d02764:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02766:	2150      	movs	r1, #80	; 0x50
c0d02768:	7001      	strb	r1, [r0, #0]
c0d0276a:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0276c:	7044      	strb	r4, [r0, #1]
c0d0276e:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02770:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02772:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02774:	2140      	movs	r1, #64	; 0x40
c0d02776:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02778:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0277a:	2106      	movs	r1, #6
c0d0277c:	f7ff fd94 	bl	c0d022a8 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02780:	2080      	movs	r0, #128	; 0x80
c0d02782:	4205      	tst	r5, r0
c0d02784:	d101      	bne.n	c0d0278a <USBD_LL_StallEP+0x2e>
c0d02786:	4807      	ldr	r0, [pc, #28]	; (c0d027a4 <USBD_LL_StallEP+0x48>)
c0d02788:	e000      	b.n	c0d0278c <USBD_LL_StallEP+0x30>
c0d0278a:	4805      	ldr	r0, [pc, #20]	; (c0d027a0 <USBD_LL_StallEP+0x44>)
c0d0278c:	6801      	ldr	r1, [r0, #0]
c0d0278e:	227f      	movs	r2, #127	; 0x7f
c0d02790:	4015      	ands	r5, r2
c0d02792:	2201      	movs	r2, #1
c0d02794:	40aa      	lsls	r2, r5
c0d02796:	430a      	orrs	r2, r1
c0d02798:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d0279a:	4620      	mov	r0, r4
c0d0279c:	b002      	add	sp, #8
c0d0279e:	bdb0      	pop	{r4, r5, r7, pc}
c0d027a0:	20001d2c 	.word	0x20001d2c
c0d027a4:	20001d30 	.word	0x20001d30

c0d027a8 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d027a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d027aa:	af03      	add	r7, sp, #12
c0d027ac:	b083      	sub	sp, #12
c0d027ae:	460d      	mov	r5, r1
c0d027b0:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d027b2:	2150      	movs	r1, #80	; 0x50
c0d027b4:	7001      	strb	r1, [r0, #0]
c0d027b6:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d027b8:	7044      	strb	r4, [r0, #1]
c0d027ba:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d027bc:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d027be:	70c5      	strb	r5, [r0, #3]
c0d027c0:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d027c2:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d027c4:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d027c6:	2106      	movs	r1, #6
c0d027c8:	f7ff fd6e 	bl	c0d022a8 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d027cc:	4235      	tst	r5, r6
c0d027ce:	d101      	bne.n	c0d027d4 <USBD_LL_ClearStallEP+0x2c>
c0d027d0:	4807      	ldr	r0, [pc, #28]	; (c0d027f0 <USBD_LL_ClearStallEP+0x48>)
c0d027d2:	e000      	b.n	c0d027d6 <USBD_LL_ClearStallEP+0x2e>
c0d027d4:	4805      	ldr	r0, [pc, #20]	; (c0d027ec <USBD_LL_ClearStallEP+0x44>)
c0d027d6:	6801      	ldr	r1, [r0, #0]
c0d027d8:	227f      	movs	r2, #127	; 0x7f
c0d027da:	4015      	ands	r5, r2
c0d027dc:	2201      	movs	r2, #1
c0d027de:	40aa      	lsls	r2, r5
c0d027e0:	4391      	bics	r1, r2
c0d027e2:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d027e4:	4620      	mov	r0, r4
c0d027e6:	b003      	add	sp, #12
c0d027e8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d027ea:	46c0      	nop			; (mov r8, r8)
c0d027ec:	20001d2c 	.word	0x20001d2c
c0d027f0:	20001d30 	.word	0x20001d30

c0d027f4 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d027f4:	2080      	movs	r0, #128	; 0x80
c0d027f6:	4201      	tst	r1, r0
c0d027f8:	d001      	beq.n	c0d027fe <USBD_LL_IsStallEP+0xa>
c0d027fa:	4806      	ldr	r0, [pc, #24]	; (c0d02814 <USBD_LL_IsStallEP+0x20>)
c0d027fc:	e000      	b.n	c0d02800 <USBD_LL_IsStallEP+0xc>
c0d027fe:	4804      	ldr	r0, [pc, #16]	; (c0d02810 <USBD_LL_IsStallEP+0x1c>)
c0d02800:	6800      	ldr	r0, [r0, #0]
c0d02802:	227f      	movs	r2, #127	; 0x7f
c0d02804:	4011      	ands	r1, r2
c0d02806:	2201      	movs	r2, #1
c0d02808:	408a      	lsls	r2, r1
c0d0280a:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d0280c:	b2d0      	uxtb	r0, r2
c0d0280e:	4770      	bx	lr
c0d02810:	20001d30 	.word	0x20001d30
c0d02814:	20001d2c 	.word	0x20001d2c

c0d02818 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02818:	b5d0      	push	{r4, r6, r7, lr}
c0d0281a:	af02      	add	r7, sp, #8
c0d0281c:	b082      	sub	sp, #8
c0d0281e:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02820:	224f      	movs	r2, #79	; 0x4f
c0d02822:	7002      	strb	r2, [r0, #0]
c0d02824:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02826:	7044      	strb	r4, [r0, #1]
c0d02828:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d0282a:	7082      	strb	r2, [r0, #2]
c0d0282c:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0282e:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02830:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02832:	2105      	movs	r1, #5
c0d02834:	f7ff fd38 	bl	c0d022a8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02838:	4620      	mov	r0, r4
c0d0283a:	b002      	add	sp, #8
c0d0283c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0283e <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d0283e:	b5b0      	push	{r4, r5, r7, lr}
c0d02840:	af02      	add	r7, sp, #8
c0d02842:	b082      	sub	sp, #8
c0d02844:	461c      	mov	r4, r3
c0d02846:	4615      	mov	r5, r2
c0d02848:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0284a:	2250      	movs	r2, #80	; 0x50
c0d0284c:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d0284e:	1ce2      	adds	r2, r4, #3
c0d02850:	0a13      	lsrs	r3, r2, #8
c0d02852:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d02854:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d02856:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02858:	2120      	movs	r1, #32
c0d0285a:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d0285c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0285e:	2106      	movs	r1, #6
c0d02860:	f7ff fd22 	bl	c0d022a8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02864:	4628      	mov	r0, r5
c0d02866:	4621      	mov	r1, r4
c0d02868:	f7ff fd1e 	bl	c0d022a8 <io_seproxyhal_spi_send>
c0d0286c:	2000      	movs	r0, #0
  return USBD_OK;   
c0d0286e:	b002      	add	sp, #8
c0d02870:	bdb0      	pop	{r4, r5, r7, pc}

c0d02872 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02872:	b5d0      	push	{r4, r6, r7, lr}
c0d02874:	af02      	add	r7, sp, #8
c0d02876:	b082      	sub	sp, #8
c0d02878:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0287a:	2350      	movs	r3, #80	; 0x50
c0d0287c:	7003      	strb	r3, [r0, #0]
c0d0287e:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02880:	7044      	strb	r4, [r0, #1]
c0d02882:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02884:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d02886:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02888:	2130      	movs	r1, #48	; 0x30
c0d0288a:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d0288c:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0288e:	2106      	movs	r1, #6
c0d02890:	f7ff fd0a 	bl	c0d022a8 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d02894:	4620      	mov	r0, r4
c0d02896:	b002      	add	sp, #8
c0d02898:	bdd0      	pop	{r4, r6, r7, pc}

c0d0289a <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d0289a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0289c:	af03      	add	r7, sp, #12
c0d0289e:	b081      	sub	sp, #4
c0d028a0:	4615      	mov	r5, r2
c0d028a2:	460e      	mov	r6, r1
c0d028a4:	4604      	mov	r4, r0
c0d028a6:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d028a8:	2c00      	cmp	r4, #0
c0d028aa:	d011      	beq.n	c0d028d0 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d028ac:	2049      	movs	r0, #73	; 0x49
c0d028ae:	0081      	lsls	r1, r0, #2
c0d028b0:	4620      	mov	r0, r4
c0d028b2:	f000 ffd7 	bl	c0d03864 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d028b6:	2e00      	cmp	r6, #0
c0d028b8:	d002      	beq.n	c0d028c0 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d028ba:	2011      	movs	r0, #17
c0d028bc:	0100      	lsls	r0, r0, #4
c0d028be:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d028c0:	20fc      	movs	r0, #252	; 0xfc
c0d028c2:	2101      	movs	r1, #1
c0d028c4:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d028c6:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d028c8:	4620      	mov	r0, r4
c0d028ca:	f7ff febb 	bl	c0d02644 <USBD_LL_Init>
c0d028ce:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d028d0:	b2c0      	uxtb	r0, r0
c0d028d2:	b001      	add	sp, #4
c0d028d4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d028d6 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d028d6:	b5d0      	push	{r4, r6, r7, lr}
c0d028d8:	af02      	add	r7, sp, #8
c0d028da:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d028dc:	20fc      	movs	r0, #252	; 0xfc
c0d028de:	2101      	movs	r1, #1
c0d028e0:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d028e2:	2045      	movs	r0, #69	; 0x45
c0d028e4:	0080      	lsls	r0, r0, #2
c0d028e6:	5820      	ldr	r0, [r4, r0]
c0d028e8:	2800      	cmp	r0, #0
c0d028ea:	d006      	beq.n	c0d028fa <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d028ec:	6840      	ldr	r0, [r0, #4]
c0d028ee:	f7ff fb1f 	bl	c0d01f30 <pic>
c0d028f2:	4602      	mov	r2, r0
c0d028f4:	7921      	ldrb	r1, [r4, #4]
c0d028f6:	4620      	mov	r0, r4
c0d028f8:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d028fa:	4620      	mov	r0, r4
c0d028fc:	f7ff fedb 	bl	c0d026b6 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02900:	4620      	mov	r0, r4
c0d02902:	f7ff fea9 	bl	c0d02658 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d02906:	2000      	movs	r0, #0
c0d02908:	bdd0      	pop	{r4, r6, r7, pc}

c0d0290a <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d0290a:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d0290c:	2900      	cmp	r1, #0
c0d0290e:	d003      	beq.n	c0d02918 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02910:	2245      	movs	r2, #69	; 0x45
c0d02912:	0092      	lsls	r2, r2, #2
c0d02914:	5081      	str	r1, [r0, r2]
c0d02916:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02918:	b2d0      	uxtb	r0, r2
c0d0291a:	4770      	bx	lr

c0d0291c <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d0291c:	b580      	push	{r7, lr}
c0d0291e:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02920:	f7ff feac 	bl	c0d0267c <USBD_LL_Start>
  
  return USBD_OK;  
c0d02924:	2000      	movs	r0, #0
c0d02926:	bd80      	pop	{r7, pc}

c0d02928 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02928:	b5b0      	push	{r4, r5, r7, lr}
c0d0292a:	af02      	add	r7, sp, #8
c0d0292c:	460c      	mov	r4, r1
c0d0292e:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02930:	2045      	movs	r0, #69	; 0x45
c0d02932:	0080      	lsls	r0, r0, #2
c0d02934:	5828      	ldr	r0, [r5, r0]
c0d02936:	2800      	cmp	r0, #0
c0d02938:	d00c      	beq.n	c0d02954 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d0293a:	6800      	ldr	r0, [r0, #0]
c0d0293c:	f7ff faf8 	bl	c0d01f30 <pic>
c0d02940:	4602      	mov	r2, r0
c0d02942:	4628      	mov	r0, r5
c0d02944:	4621      	mov	r1, r4
c0d02946:	4790      	blx	r2
c0d02948:	4601      	mov	r1, r0
c0d0294a:	2002      	movs	r0, #2
c0d0294c:	2900      	cmp	r1, #0
c0d0294e:	d100      	bne.n	c0d02952 <USBD_SetClassConfig+0x2a>
c0d02950:	4608      	mov	r0, r1
c0d02952:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02954:	2002      	movs	r0, #2
c0d02956:	bdb0      	pop	{r4, r5, r7, pc}

c0d02958 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02958:	b5b0      	push	{r4, r5, r7, lr}
c0d0295a:	af02      	add	r7, sp, #8
c0d0295c:	460c      	mov	r4, r1
c0d0295e:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02960:	2045      	movs	r0, #69	; 0x45
c0d02962:	0080      	lsls	r0, r0, #2
c0d02964:	5828      	ldr	r0, [r5, r0]
c0d02966:	2800      	cmp	r0, #0
c0d02968:	d006      	beq.n	c0d02978 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d0296a:	6840      	ldr	r0, [r0, #4]
c0d0296c:	f7ff fae0 	bl	c0d01f30 <pic>
c0d02970:	4602      	mov	r2, r0
c0d02972:	4628      	mov	r0, r5
c0d02974:	4621      	mov	r1, r4
c0d02976:	4790      	blx	r2
  }
  return USBD_OK;
c0d02978:	2000      	movs	r0, #0
c0d0297a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0297c <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d0297c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0297e:	af03      	add	r7, sp, #12
c0d02980:	b081      	sub	sp, #4
c0d02982:	4604      	mov	r4, r0
c0d02984:	2021      	movs	r0, #33	; 0x21
c0d02986:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02988:	19a5      	adds	r5, r4, r6
c0d0298a:	4628      	mov	r0, r5
c0d0298c:	f000 fb69 	bl	c0d03062 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02990:	20f4      	movs	r0, #244	; 0xf4
c0d02992:	2101      	movs	r1, #1
c0d02994:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d02996:	2087      	movs	r0, #135	; 0x87
c0d02998:	0040      	lsls	r0, r0, #1
c0d0299a:	5a20      	ldrh	r0, [r4, r0]
c0d0299c:	21f8      	movs	r1, #248	; 0xf8
c0d0299e:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d029a0:	5da1      	ldrb	r1, [r4, r6]
c0d029a2:	201f      	movs	r0, #31
c0d029a4:	4008      	ands	r0, r1
c0d029a6:	2802      	cmp	r0, #2
c0d029a8:	d008      	beq.n	c0d029bc <USBD_LL_SetupStage+0x40>
c0d029aa:	2801      	cmp	r0, #1
c0d029ac:	d00b      	beq.n	c0d029c6 <USBD_LL_SetupStage+0x4a>
c0d029ae:	2800      	cmp	r0, #0
c0d029b0:	d10e      	bne.n	c0d029d0 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d029b2:	4620      	mov	r0, r4
c0d029b4:	4629      	mov	r1, r5
c0d029b6:	f000 f8f1 	bl	c0d02b9c <USBD_StdDevReq>
c0d029ba:	e00e      	b.n	c0d029da <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d029bc:	4620      	mov	r0, r4
c0d029be:	4629      	mov	r1, r5
c0d029c0:	f000 fad3 	bl	c0d02f6a <USBD_StdEPReq>
c0d029c4:	e009      	b.n	c0d029da <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d029c6:	4620      	mov	r0, r4
c0d029c8:	4629      	mov	r1, r5
c0d029ca:	f000 faa6 	bl	c0d02f1a <USBD_StdItfReq>
c0d029ce:	e004      	b.n	c0d029da <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d029d0:	2080      	movs	r0, #128	; 0x80
c0d029d2:	4001      	ands	r1, r0
c0d029d4:	4620      	mov	r0, r4
c0d029d6:	f7ff fec1 	bl	c0d0275c <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d029da:	2000      	movs	r0, #0
c0d029dc:	b001      	add	sp, #4
c0d029de:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d029e0 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d029e0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d029e2:	af03      	add	r7, sp, #12
c0d029e4:	b081      	sub	sp, #4
c0d029e6:	4615      	mov	r5, r2
c0d029e8:	460e      	mov	r6, r1
c0d029ea:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d029ec:	2e00      	cmp	r6, #0
c0d029ee:	d011      	beq.n	c0d02a14 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d029f0:	2045      	movs	r0, #69	; 0x45
c0d029f2:	0080      	lsls	r0, r0, #2
c0d029f4:	5820      	ldr	r0, [r4, r0]
c0d029f6:	6980      	ldr	r0, [r0, #24]
c0d029f8:	2800      	cmp	r0, #0
c0d029fa:	d034      	beq.n	c0d02a66 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d029fc:	21fc      	movs	r1, #252	; 0xfc
c0d029fe:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02a00:	2903      	cmp	r1, #3
c0d02a02:	d130      	bne.n	c0d02a66 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02a04:	f7ff fa94 	bl	c0d01f30 <pic>
c0d02a08:	4603      	mov	r3, r0
c0d02a0a:	4620      	mov	r0, r4
c0d02a0c:	4631      	mov	r1, r6
c0d02a0e:	462a      	mov	r2, r5
c0d02a10:	4798      	blx	r3
c0d02a12:	e028      	b.n	c0d02a66 <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02a14:	20f4      	movs	r0, #244	; 0xf4
c0d02a16:	5820      	ldr	r0, [r4, r0]
c0d02a18:	2803      	cmp	r0, #3
c0d02a1a:	d124      	bne.n	c0d02a66 <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02a1c:	2090      	movs	r0, #144	; 0x90
c0d02a1e:	5820      	ldr	r0, [r4, r0]
c0d02a20:	218c      	movs	r1, #140	; 0x8c
c0d02a22:	5861      	ldr	r1, [r4, r1]
c0d02a24:	4622      	mov	r2, r4
c0d02a26:	328c      	adds	r2, #140	; 0x8c
c0d02a28:	4281      	cmp	r1, r0
c0d02a2a:	d90a      	bls.n	c0d02a42 <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02a2c:	1a09      	subs	r1, r1, r0
c0d02a2e:	6011      	str	r1, [r2, #0]
c0d02a30:	4281      	cmp	r1, r0
c0d02a32:	d300      	bcc.n	c0d02a36 <USBD_LL_DataOutStage+0x56>
c0d02a34:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d02a36:	b28a      	uxth	r2, r1
c0d02a38:	4620      	mov	r0, r4
c0d02a3a:	4629      	mov	r1, r5
c0d02a3c:	f000 fc70 	bl	c0d03320 <USBD_CtlContinueRx>
c0d02a40:	e011      	b.n	c0d02a66 <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02a42:	2045      	movs	r0, #69	; 0x45
c0d02a44:	0080      	lsls	r0, r0, #2
c0d02a46:	5820      	ldr	r0, [r4, r0]
c0d02a48:	6900      	ldr	r0, [r0, #16]
c0d02a4a:	2800      	cmp	r0, #0
c0d02a4c:	d008      	beq.n	c0d02a60 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02a4e:	21fc      	movs	r1, #252	; 0xfc
c0d02a50:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02a52:	2903      	cmp	r1, #3
c0d02a54:	d104      	bne.n	c0d02a60 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02a56:	f7ff fa6b 	bl	c0d01f30 <pic>
c0d02a5a:	4601      	mov	r1, r0
c0d02a5c:	4620      	mov	r0, r4
c0d02a5e:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02a60:	4620      	mov	r0, r4
c0d02a62:	f000 fc65 	bl	c0d03330 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02a66:	2000      	movs	r0, #0
c0d02a68:	b001      	add	sp, #4
c0d02a6a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a6c <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02a6c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a6e:	af03      	add	r7, sp, #12
c0d02a70:	b081      	sub	sp, #4
c0d02a72:	460d      	mov	r5, r1
c0d02a74:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02a76:	2d00      	cmp	r5, #0
c0d02a78:	d012      	beq.n	c0d02aa0 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02a7a:	2045      	movs	r0, #69	; 0x45
c0d02a7c:	0080      	lsls	r0, r0, #2
c0d02a7e:	5820      	ldr	r0, [r4, r0]
c0d02a80:	2800      	cmp	r0, #0
c0d02a82:	d054      	beq.n	c0d02b2e <USBD_LL_DataInStage+0xc2>
c0d02a84:	6940      	ldr	r0, [r0, #20]
c0d02a86:	2800      	cmp	r0, #0
c0d02a88:	d051      	beq.n	c0d02b2e <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02a8a:	21fc      	movs	r1, #252	; 0xfc
c0d02a8c:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02a8e:	2903      	cmp	r1, #3
c0d02a90:	d14d      	bne.n	c0d02b2e <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d02a92:	f7ff fa4d 	bl	c0d01f30 <pic>
c0d02a96:	4602      	mov	r2, r0
c0d02a98:	4620      	mov	r0, r4
c0d02a9a:	4629      	mov	r1, r5
c0d02a9c:	4790      	blx	r2
c0d02a9e:	e046      	b.n	c0d02b2e <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02aa0:	20f4      	movs	r0, #244	; 0xf4
c0d02aa2:	5820      	ldr	r0, [r4, r0]
c0d02aa4:	2802      	cmp	r0, #2
c0d02aa6:	d13a      	bne.n	c0d02b1e <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02aa8:	69e0      	ldr	r0, [r4, #28]
c0d02aaa:	6a25      	ldr	r5, [r4, #32]
c0d02aac:	42a8      	cmp	r0, r5
c0d02aae:	d90b      	bls.n	c0d02ac8 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02ab0:	1b40      	subs	r0, r0, r5
c0d02ab2:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d02ab4:	2109      	movs	r1, #9
c0d02ab6:	014a      	lsls	r2, r1, #5
c0d02ab8:	58a1      	ldr	r1, [r4, r2]
c0d02aba:	1949      	adds	r1, r1, r5
c0d02abc:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02abe:	b282      	uxth	r2, r0
c0d02ac0:	4620      	mov	r0, r4
c0d02ac2:	f000 fc1e 	bl	c0d03302 <USBD_CtlContinueSendData>
c0d02ac6:	e02a      	b.n	c0d02b1e <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02ac8:	69a6      	ldr	r6, [r4, #24]
c0d02aca:	4630      	mov	r0, r6
c0d02acc:	4629      	mov	r1, r5
c0d02ace:	f000 fccf 	bl	c0d03470 <__aeabi_uidivmod>
c0d02ad2:	42ae      	cmp	r6, r5
c0d02ad4:	d30f      	bcc.n	c0d02af6 <USBD_LL_DataInStage+0x8a>
c0d02ad6:	2900      	cmp	r1, #0
c0d02ad8:	d10d      	bne.n	c0d02af6 <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02ada:	20f8      	movs	r0, #248	; 0xf8
c0d02adc:	5820      	ldr	r0, [r4, r0]
c0d02ade:	4625      	mov	r5, r4
c0d02ae0:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02ae2:	4286      	cmp	r6, r0
c0d02ae4:	d207      	bcs.n	c0d02af6 <USBD_LL_DataInStage+0x8a>
c0d02ae6:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02ae8:	4620      	mov	r0, r4
c0d02aea:	4631      	mov	r1, r6
c0d02aec:	4632      	mov	r2, r6
c0d02aee:	f000 fc08 	bl	c0d03302 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02af2:	602e      	str	r6, [r5, #0]
c0d02af4:	e013      	b.n	c0d02b1e <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02af6:	2045      	movs	r0, #69	; 0x45
c0d02af8:	0080      	lsls	r0, r0, #2
c0d02afa:	5820      	ldr	r0, [r4, r0]
c0d02afc:	2800      	cmp	r0, #0
c0d02afe:	d00b      	beq.n	c0d02b18 <USBD_LL_DataInStage+0xac>
c0d02b00:	68c0      	ldr	r0, [r0, #12]
c0d02b02:	2800      	cmp	r0, #0
c0d02b04:	d008      	beq.n	c0d02b18 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02b06:	21fc      	movs	r1, #252	; 0xfc
c0d02b08:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02b0a:	2903      	cmp	r1, #3
c0d02b0c:	d104      	bne.n	c0d02b18 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02b0e:	f7ff fa0f 	bl	c0d01f30 <pic>
c0d02b12:	4601      	mov	r1, r0
c0d02b14:	4620      	mov	r0, r4
c0d02b16:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02b18:	4620      	mov	r0, r4
c0d02b1a:	f000 fc16 	bl	c0d0334a <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02b1e:	2001      	movs	r0, #1
c0d02b20:	0201      	lsls	r1, r0, #8
c0d02b22:	1860      	adds	r0, r4, r1
c0d02b24:	5c61      	ldrb	r1, [r4, r1]
c0d02b26:	2901      	cmp	r1, #1
c0d02b28:	d101      	bne.n	c0d02b2e <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02b2a:	2100      	movs	r1, #0
c0d02b2c:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02b2e:	2000      	movs	r0, #0
c0d02b30:	b001      	add	sp, #4
c0d02b32:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b34 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02b34:	b5d0      	push	{r4, r6, r7, lr}
c0d02b36:	af02      	add	r7, sp, #8
c0d02b38:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02b3a:	2090      	movs	r0, #144	; 0x90
c0d02b3c:	2140      	movs	r1, #64	; 0x40
c0d02b3e:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02b40:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02b42:	20fc      	movs	r0, #252	; 0xfc
c0d02b44:	2101      	movs	r1, #1
c0d02b46:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02b48:	2045      	movs	r0, #69	; 0x45
c0d02b4a:	0080      	lsls	r0, r0, #2
c0d02b4c:	5820      	ldr	r0, [r4, r0]
c0d02b4e:	2800      	cmp	r0, #0
c0d02b50:	d006      	beq.n	c0d02b60 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02b52:	6840      	ldr	r0, [r0, #4]
c0d02b54:	f7ff f9ec 	bl	c0d01f30 <pic>
c0d02b58:	4602      	mov	r2, r0
c0d02b5a:	7921      	ldrb	r1, [r4, #4]
c0d02b5c:	4620      	mov	r0, r4
c0d02b5e:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02b60:	2000      	movs	r0, #0
c0d02b62:	bdd0      	pop	{r4, r6, r7, pc}

c0d02b64 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02b64:	7401      	strb	r1, [r0, #16]
c0d02b66:	2000      	movs	r0, #0
  return USBD_OK;
c0d02b68:	4770      	bx	lr

c0d02b6a <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02b6a:	2000      	movs	r0, #0
c0d02b6c:	4770      	bx	lr

c0d02b6e <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02b6e:	2000      	movs	r0, #0
c0d02b70:	4770      	bx	lr

c0d02b72 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02b72:	b5d0      	push	{r4, r6, r7, lr}
c0d02b74:	af02      	add	r7, sp, #8
c0d02b76:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02b78:	20fc      	movs	r0, #252	; 0xfc
c0d02b7a:	5c20      	ldrb	r0, [r4, r0]
c0d02b7c:	2803      	cmp	r0, #3
c0d02b7e:	d10a      	bne.n	c0d02b96 <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02b80:	2045      	movs	r0, #69	; 0x45
c0d02b82:	0080      	lsls	r0, r0, #2
c0d02b84:	5820      	ldr	r0, [r4, r0]
c0d02b86:	69c0      	ldr	r0, [r0, #28]
c0d02b88:	2800      	cmp	r0, #0
c0d02b8a:	d004      	beq.n	c0d02b96 <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02b8c:	f7ff f9d0 	bl	c0d01f30 <pic>
c0d02b90:	4601      	mov	r1, r0
c0d02b92:	4620      	mov	r0, r4
c0d02b94:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d02b96:	2000      	movs	r0, #0
c0d02b98:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02b9c <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02b9c:	b5d0      	push	{r4, r6, r7, lr}
c0d02b9e:	af02      	add	r7, sp, #8
c0d02ba0:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02ba2:	7848      	ldrb	r0, [r1, #1]
c0d02ba4:	2809      	cmp	r0, #9
c0d02ba6:	d810      	bhi.n	c0d02bca <USBD_StdDevReq+0x2e>
c0d02ba8:	4478      	add	r0, pc
c0d02baa:	7900      	ldrb	r0, [r0, #4]
c0d02bac:	0040      	lsls	r0, r0, #1
c0d02bae:	4487      	add	pc, r0
c0d02bb0:	150c0804 	.word	0x150c0804
c0d02bb4:	0c25190c 	.word	0x0c25190c
c0d02bb8:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02bba:	4620      	mov	r0, r4
c0d02bbc:	f000 f938 	bl	c0d02e30 <USBD_GetStatus>
c0d02bc0:	e01f      	b.n	c0d02c02 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02bc2:	4620      	mov	r0, r4
c0d02bc4:	f000 f976 	bl	c0d02eb4 <USBD_ClrFeature>
c0d02bc8:	e01b      	b.n	c0d02c02 <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02bca:	2180      	movs	r1, #128	; 0x80
c0d02bcc:	4620      	mov	r0, r4
c0d02bce:	f7ff fdc5 	bl	c0d0275c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02bd2:	2100      	movs	r1, #0
c0d02bd4:	4620      	mov	r0, r4
c0d02bd6:	f7ff fdc1 	bl	c0d0275c <USBD_LL_StallEP>
c0d02bda:	e012      	b.n	c0d02c02 <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02bdc:	4620      	mov	r0, r4
c0d02bde:	f000 f950 	bl	c0d02e82 <USBD_SetFeature>
c0d02be2:	e00e      	b.n	c0d02c02 <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02be4:	4620      	mov	r0, r4
c0d02be6:	f000 f897 	bl	c0d02d18 <USBD_SetAddress>
c0d02bea:	e00a      	b.n	c0d02c02 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02bec:	4620      	mov	r0, r4
c0d02bee:	f000 f8ff 	bl	c0d02df0 <USBD_GetConfig>
c0d02bf2:	e006      	b.n	c0d02c02 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02bf4:	4620      	mov	r0, r4
c0d02bf6:	f000 f8bd 	bl	c0d02d74 <USBD_SetConfig>
c0d02bfa:	e002      	b.n	c0d02c02 <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02bfc:	4620      	mov	r0, r4
c0d02bfe:	f000 f803 	bl	c0d02c08 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02c02:	2000      	movs	r0, #0
c0d02c04:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02c08 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02c08:	b5b0      	push	{r4, r5, r7, lr}
c0d02c0a:	af02      	add	r7, sp, #8
c0d02c0c:	b082      	sub	sp, #8
c0d02c0e:	460d      	mov	r5, r1
c0d02c10:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02c12:	8868      	ldrh	r0, [r5, #2]
c0d02c14:	0a01      	lsrs	r1, r0, #8
c0d02c16:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02c18:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02c1a:	2a0e      	cmp	r2, #14
c0d02c1c:	d83e      	bhi.n	c0d02c9c <USBD_GetDescriptor+0x94>
c0d02c1e:	46c0      	nop			; (mov r8, r8)
c0d02c20:	447a      	add	r2, pc
c0d02c22:	7912      	ldrb	r2, [r2, #4]
c0d02c24:	0052      	lsls	r2, r2, #1
c0d02c26:	4497      	add	pc, r2
c0d02c28:	390c2607 	.word	0x390c2607
c0d02c2c:	39362e39 	.word	0x39362e39
c0d02c30:	39393939 	.word	0x39393939
c0d02c34:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02c38:	2011      	movs	r0, #17
c0d02c3a:	0100      	lsls	r0, r0, #4
c0d02c3c:	5820      	ldr	r0, [r4, r0]
c0d02c3e:	6800      	ldr	r0, [r0, #0]
c0d02c40:	e012      	b.n	c0d02c68 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02c42:	b2c0      	uxtb	r0, r0
c0d02c44:	2805      	cmp	r0, #5
c0d02c46:	d829      	bhi.n	c0d02c9c <USBD_GetDescriptor+0x94>
c0d02c48:	4478      	add	r0, pc
c0d02c4a:	7900      	ldrb	r0, [r0, #4]
c0d02c4c:	0040      	lsls	r0, r0, #1
c0d02c4e:	4487      	add	pc, r0
c0d02c50:	544f4a02 	.word	0x544f4a02
c0d02c54:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02c56:	2011      	movs	r0, #17
c0d02c58:	0100      	lsls	r0, r0, #4
c0d02c5a:	5820      	ldr	r0, [r4, r0]
c0d02c5c:	6840      	ldr	r0, [r0, #4]
c0d02c5e:	e003      	b.n	c0d02c68 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02c60:	2011      	movs	r0, #17
c0d02c62:	0100      	lsls	r0, r0, #4
c0d02c64:	5820      	ldr	r0, [r4, r0]
c0d02c66:	69c0      	ldr	r0, [r0, #28]
c0d02c68:	f7ff f962 	bl	c0d01f30 <pic>
c0d02c6c:	4602      	mov	r2, r0
c0d02c6e:	7c20      	ldrb	r0, [r4, #16]
c0d02c70:	a901      	add	r1, sp, #4
c0d02c72:	4790      	blx	r2
c0d02c74:	e025      	b.n	c0d02cc2 <USBD_GetDescriptor+0xba>
c0d02c76:	2045      	movs	r0, #69	; 0x45
c0d02c78:	0080      	lsls	r0, r0, #2
c0d02c7a:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02c7c:	7c21      	ldrb	r1, [r4, #16]
c0d02c7e:	2900      	cmp	r1, #0
c0d02c80:	d014      	beq.n	c0d02cac <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02c82:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02c84:	e018      	b.n	c0d02cb8 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02c86:	7c20      	ldrb	r0, [r4, #16]
c0d02c88:	2800      	cmp	r0, #0
c0d02c8a:	d107      	bne.n	c0d02c9c <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02c8c:	2045      	movs	r0, #69	; 0x45
c0d02c8e:	0080      	lsls	r0, r0, #2
c0d02c90:	5820      	ldr	r0, [r4, r0]
c0d02c92:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02c94:	e010      	b.n	c0d02cb8 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02c96:	7c20      	ldrb	r0, [r4, #16]
c0d02c98:	2800      	cmp	r0, #0
c0d02c9a:	d009      	beq.n	c0d02cb0 <USBD_GetDescriptor+0xa8>
c0d02c9c:	4620      	mov	r0, r4
c0d02c9e:	f7ff fd5d 	bl	c0d0275c <USBD_LL_StallEP>
c0d02ca2:	2100      	movs	r1, #0
c0d02ca4:	4620      	mov	r0, r4
c0d02ca6:	f7ff fd59 	bl	c0d0275c <USBD_LL_StallEP>
c0d02caa:	e01a      	b.n	c0d02ce2 <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02cac:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02cae:	e003      	b.n	c0d02cb8 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02cb0:	2045      	movs	r0, #69	; 0x45
c0d02cb2:	0080      	lsls	r0, r0, #2
c0d02cb4:	5820      	ldr	r0, [r4, r0]
c0d02cb6:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02cb8:	f7ff f93a 	bl	c0d01f30 <pic>
c0d02cbc:	4601      	mov	r1, r0
c0d02cbe:	a801      	add	r0, sp, #4
c0d02cc0:	4788      	blx	r1
c0d02cc2:	4601      	mov	r1, r0
c0d02cc4:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02cc6:	8802      	ldrh	r2, [r0, #0]
c0d02cc8:	2a00      	cmp	r2, #0
c0d02cca:	d00a      	beq.n	c0d02ce2 <USBD_GetDescriptor+0xda>
c0d02ccc:	88e8      	ldrh	r0, [r5, #6]
c0d02cce:	2800      	cmp	r0, #0
c0d02cd0:	d007      	beq.n	c0d02ce2 <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02cd2:	4282      	cmp	r2, r0
c0d02cd4:	d300      	bcc.n	c0d02cd8 <USBD_GetDescriptor+0xd0>
c0d02cd6:	4602      	mov	r2, r0
c0d02cd8:	a801      	add	r0, sp, #4
c0d02cda:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02cdc:	4620      	mov	r0, r4
c0d02cde:	f000 faf9 	bl	c0d032d4 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02ce2:	b002      	add	sp, #8
c0d02ce4:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02ce6:	2011      	movs	r0, #17
c0d02ce8:	0100      	lsls	r0, r0, #4
c0d02cea:	5820      	ldr	r0, [r4, r0]
c0d02cec:	6880      	ldr	r0, [r0, #8]
c0d02cee:	e7bb      	b.n	c0d02c68 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02cf0:	2011      	movs	r0, #17
c0d02cf2:	0100      	lsls	r0, r0, #4
c0d02cf4:	5820      	ldr	r0, [r4, r0]
c0d02cf6:	68c0      	ldr	r0, [r0, #12]
c0d02cf8:	e7b6      	b.n	c0d02c68 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02cfa:	2011      	movs	r0, #17
c0d02cfc:	0100      	lsls	r0, r0, #4
c0d02cfe:	5820      	ldr	r0, [r4, r0]
c0d02d00:	6900      	ldr	r0, [r0, #16]
c0d02d02:	e7b1      	b.n	c0d02c68 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02d04:	2011      	movs	r0, #17
c0d02d06:	0100      	lsls	r0, r0, #4
c0d02d08:	5820      	ldr	r0, [r4, r0]
c0d02d0a:	6940      	ldr	r0, [r0, #20]
c0d02d0c:	e7ac      	b.n	c0d02c68 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02d0e:	2011      	movs	r0, #17
c0d02d10:	0100      	lsls	r0, r0, #4
c0d02d12:	5820      	ldr	r0, [r4, r0]
c0d02d14:	6980      	ldr	r0, [r0, #24]
c0d02d16:	e7a7      	b.n	c0d02c68 <USBD_GetDescriptor+0x60>

c0d02d18 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02d18:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02d1a:	af03      	add	r7, sp, #12
c0d02d1c:	b081      	sub	sp, #4
c0d02d1e:	460a      	mov	r2, r1
c0d02d20:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02d22:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d24:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02d26:	2800      	cmp	r0, #0
c0d02d28:	d10b      	bne.n	c0d02d42 <USBD_SetAddress+0x2a>
c0d02d2a:	88d0      	ldrh	r0, [r2, #6]
c0d02d2c:	2800      	cmp	r0, #0
c0d02d2e:	d108      	bne.n	c0d02d42 <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02d30:	8850      	ldrh	r0, [r2, #2]
c0d02d32:	267f      	movs	r6, #127	; 0x7f
c0d02d34:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02d36:	20fc      	movs	r0, #252	; 0xfc
c0d02d38:	5c20      	ldrb	r0, [r4, r0]
c0d02d3a:	4625      	mov	r5, r4
c0d02d3c:	35fc      	adds	r5, #252	; 0xfc
c0d02d3e:	2803      	cmp	r0, #3
c0d02d40:	d108      	bne.n	c0d02d54 <USBD_SetAddress+0x3c>
c0d02d42:	4620      	mov	r0, r4
c0d02d44:	f7ff fd0a 	bl	c0d0275c <USBD_LL_StallEP>
c0d02d48:	2100      	movs	r1, #0
c0d02d4a:	4620      	mov	r0, r4
c0d02d4c:	f7ff fd06 	bl	c0d0275c <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02d50:	b001      	add	sp, #4
c0d02d52:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02d54:	20fe      	movs	r0, #254	; 0xfe
c0d02d56:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02d58:	b2f1      	uxtb	r1, r6
c0d02d5a:	4620      	mov	r0, r4
c0d02d5c:	f7ff fd5c 	bl	c0d02818 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02d60:	4620      	mov	r0, r4
c0d02d62:	f000 fae5 	bl	c0d03330 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02d66:	2002      	movs	r0, #2
c0d02d68:	2101      	movs	r1, #1
c0d02d6a:	2e00      	cmp	r6, #0
c0d02d6c:	d100      	bne.n	c0d02d70 <USBD_SetAddress+0x58>
c0d02d6e:	4608      	mov	r0, r1
c0d02d70:	7028      	strb	r0, [r5, #0]
c0d02d72:	e7ed      	b.n	c0d02d50 <USBD_SetAddress+0x38>

c0d02d74 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02d74:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02d76:	af03      	add	r7, sp, #12
c0d02d78:	b081      	sub	sp, #4
c0d02d7a:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02d7c:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d7e:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02d80:	2e02      	cmp	r6, #2
c0d02d82:	d21d      	bcs.n	c0d02dc0 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02d84:	20fc      	movs	r0, #252	; 0xfc
c0d02d86:	5c21      	ldrb	r1, [r4, r0]
c0d02d88:	4620      	mov	r0, r4
c0d02d8a:	30fc      	adds	r0, #252	; 0xfc
c0d02d8c:	2903      	cmp	r1, #3
c0d02d8e:	d007      	beq.n	c0d02da0 <USBD_SetConfig+0x2c>
c0d02d90:	2902      	cmp	r1, #2
c0d02d92:	d115      	bne.n	c0d02dc0 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02d94:	2e00      	cmp	r6, #0
c0d02d96:	d026      	beq.n	c0d02de6 <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02d98:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02d9a:	2103      	movs	r1, #3
c0d02d9c:	7001      	strb	r1, [r0, #0]
c0d02d9e:	e009      	b.n	c0d02db4 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02da0:	2e00      	cmp	r6, #0
c0d02da2:	d016      	beq.n	c0d02dd2 <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02da4:	6860      	ldr	r0, [r4, #4]
c0d02da6:	4286      	cmp	r6, r0
c0d02da8:	d01d      	beq.n	c0d02de6 <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02daa:	b2c1      	uxtb	r1, r0
c0d02dac:	4620      	mov	r0, r4
c0d02dae:	f7ff fdd3 	bl	c0d02958 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02db2:	6066      	str	r6, [r4, #4]
c0d02db4:	4620      	mov	r0, r4
c0d02db6:	4631      	mov	r1, r6
c0d02db8:	f7ff fdb6 	bl	c0d02928 <USBD_SetClassConfig>
c0d02dbc:	2802      	cmp	r0, #2
c0d02dbe:	d112      	bne.n	c0d02de6 <USBD_SetConfig+0x72>
c0d02dc0:	4620      	mov	r0, r4
c0d02dc2:	4629      	mov	r1, r5
c0d02dc4:	f7ff fcca 	bl	c0d0275c <USBD_LL_StallEP>
c0d02dc8:	2100      	movs	r1, #0
c0d02dca:	4620      	mov	r0, r4
c0d02dcc:	f7ff fcc6 	bl	c0d0275c <USBD_LL_StallEP>
c0d02dd0:	e00c      	b.n	c0d02dec <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02dd2:	2102      	movs	r1, #2
c0d02dd4:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02dd6:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02dd8:	4620      	mov	r0, r4
c0d02dda:	4631      	mov	r1, r6
c0d02ddc:	f7ff fdbc 	bl	c0d02958 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02de0:	4620      	mov	r0, r4
c0d02de2:	f000 faa5 	bl	c0d03330 <USBD_CtlSendStatus>
c0d02de6:	4620      	mov	r0, r4
c0d02de8:	f000 faa2 	bl	c0d03330 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02dec:	b001      	add	sp, #4
c0d02dee:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02df0 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02df0:	b5d0      	push	{r4, r6, r7, lr}
c0d02df2:	af02      	add	r7, sp, #8
c0d02df4:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02df6:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02df8:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02dfa:	2801      	cmp	r0, #1
c0d02dfc:	d10a      	bne.n	c0d02e14 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02dfe:	20fc      	movs	r0, #252	; 0xfc
c0d02e00:	5c20      	ldrb	r0, [r4, r0]
c0d02e02:	2803      	cmp	r0, #3
c0d02e04:	d00e      	beq.n	c0d02e24 <USBD_GetConfig+0x34>
c0d02e06:	2802      	cmp	r0, #2
c0d02e08:	d104      	bne.n	c0d02e14 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02e0a:	2000      	movs	r0, #0
c0d02e0c:	60a0      	str	r0, [r4, #8]
c0d02e0e:	4621      	mov	r1, r4
c0d02e10:	3108      	adds	r1, #8
c0d02e12:	e008      	b.n	c0d02e26 <USBD_GetConfig+0x36>
c0d02e14:	4620      	mov	r0, r4
c0d02e16:	f7ff fca1 	bl	c0d0275c <USBD_LL_StallEP>
c0d02e1a:	2100      	movs	r1, #0
c0d02e1c:	4620      	mov	r0, r4
c0d02e1e:	f7ff fc9d 	bl	c0d0275c <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02e22:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02e24:	1d21      	adds	r1, r4, #4
c0d02e26:	2201      	movs	r2, #1
c0d02e28:	4620      	mov	r0, r4
c0d02e2a:	f000 fa53 	bl	c0d032d4 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02e2e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02e30 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02e30:	b5b0      	push	{r4, r5, r7, lr}
c0d02e32:	af02      	add	r7, sp, #8
c0d02e34:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02e36:	20fc      	movs	r0, #252	; 0xfc
c0d02e38:	5c20      	ldrb	r0, [r4, r0]
c0d02e3a:	21fe      	movs	r1, #254	; 0xfe
c0d02e3c:	4001      	ands	r1, r0
c0d02e3e:	2902      	cmp	r1, #2
c0d02e40:	d116      	bne.n	c0d02e70 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02e42:	2001      	movs	r0, #1
c0d02e44:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02e46:	2041      	movs	r0, #65	; 0x41
c0d02e48:	0080      	lsls	r0, r0, #2
c0d02e4a:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02e4c:	4625      	mov	r5, r4
c0d02e4e:	350c      	adds	r5, #12
c0d02e50:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02e52:	2900      	cmp	r1, #0
c0d02e54:	d005      	beq.n	c0d02e62 <USBD_GetStatus+0x32>
c0d02e56:	4620      	mov	r0, r4
c0d02e58:	f000 fa77 	bl	c0d0334a <USBD_CtlReceiveStatus>
c0d02e5c:	68e1      	ldr	r1, [r4, #12]
c0d02e5e:	2002      	movs	r0, #2
c0d02e60:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02e62:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02e64:	2202      	movs	r2, #2
c0d02e66:	4620      	mov	r0, r4
c0d02e68:	4629      	mov	r1, r5
c0d02e6a:	f000 fa33 	bl	c0d032d4 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02e6e:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e70:	2180      	movs	r1, #128	; 0x80
c0d02e72:	4620      	mov	r0, r4
c0d02e74:	f7ff fc72 	bl	c0d0275c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02e78:	2100      	movs	r1, #0
c0d02e7a:	4620      	mov	r0, r4
c0d02e7c:	f7ff fc6e 	bl	c0d0275c <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02e80:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e82 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02e82:	b5b0      	push	{r4, r5, r7, lr}
c0d02e84:	af02      	add	r7, sp, #8
c0d02e86:	460d      	mov	r5, r1
c0d02e88:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02e8a:	8868      	ldrh	r0, [r5, #2]
c0d02e8c:	2801      	cmp	r0, #1
c0d02e8e:	d110      	bne.n	c0d02eb2 <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02e90:	2041      	movs	r0, #65	; 0x41
c0d02e92:	0080      	lsls	r0, r0, #2
c0d02e94:	2101      	movs	r1, #1
c0d02e96:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02e98:	2045      	movs	r0, #69	; 0x45
c0d02e9a:	0080      	lsls	r0, r0, #2
c0d02e9c:	5820      	ldr	r0, [r4, r0]
c0d02e9e:	6880      	ldr	r0, [r0, #8]
c0d02ea0:	f7ff f846 	bl	c0d01f30 <pic>
c0d02ea4:	4602      	mov	r2, r0
c0d02ea6:	4620      	mov	r0, r4
c0d02ea8:	4629      	mov	r1, r5
c0d02eaa:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02eac:	4620      	mov	r0, r4
c0d02eae:	f000 fa3f 	bl	c0d03330 <USBD_CtlSendStatus>
  }

}
c0d02eb2:	bdb0      	pop	{r4, r5, r7, pc}

c0d02eb4 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02eb4:	b5b0      	push	{r4, r5, r7, lr}
c0d02eb6:	af02      	add	r7, sp, #8
c0d02eb8:	460d      	mov	r5, r1
c0d02eba:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02ebc:	20fc      	movs	r0, #252	; 0xfc
c0d02ebe:	5c20      	ldrb	r0, [r4, r0]
c0d02ec0:	21fe      	movs	r1, #254	; 0xfe
c0d02ec2:	4001      	ands	r1, r0
c0d02ec4:	2902      	cmp	r1, #2
c0d02ec6:	d114      	bne.n	c0d02ef2 <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02ec8:	8868      	ldrh	r0, [r5, #2]
c0d02eca:	2801      	cmp	r0, #1
c0d02ecc:	d119      	bne.n	c0d02f02 <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02ece:	2041      	movs	r0, #65	; 0x41
c0d02ed0:	0080      	lsls	r0, r0, #2
c0d02ed2:	2100      	movs	r1, #0
c0d02ed4:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02ed6:	2045      	movs	r0, #69	; 0x45
c0d02ed8:	0080      	lsls	r0, r0, #2
c0d02eda:	5820      	ldr	r0, [r4, r0]
c0d02edc:	6880      	ldr	r0, [r0, #8]
c0d02ede:	f7ff f827 	bl	c0d01f30 <pic>
c0d02ee2:	4602      	mov	r2, r0
c0d02ee4:	4620      	mov	r0, r4
c0d02ee6:	4629      	mov	r1, r5
c0d02ee8:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d02eea:	4620      	mov	r0, r4
c0d02eec:	f000 fa20 	bl	c0d03330 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02ef0:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02ef2:	2180      	movs	r1, #128	; 0x80
c0d02ef4:	4620      	mov	r0, r4
c0d02ef6:	f7ff fc31 	bl	c0d0275c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02efa:	2100      	movs	r1, #0
c0d02efc:	4620      	mov	r0, r4
c0d02efe:	f7ff fc2d 	bl	c0d0275c <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02f02:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f04 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02f04:	b5d0      	push	{r4, r6, r7, lr}
c0d02f06:	af02      	add	r7, sp, #8
c0d02f08:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f0a:	2180      	movs	r1, #128	; 0x80
c0d02f0c:	f7ff fc26 	bl	c0d0275c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02f10:	2100      	movs	r1, #0
c0d02f12:	4620      	mov	r0, r4
c0d02f14:	f7ff fc22 	bl	c0d0275c <USBD_LL_StallEP>
}
c0d02f18:	bdd0      	pop	{r4, r6, r7, pc}

c0d02f1a <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02f1a:	b5b0      	push	{r4, r5, r7, lr}
c0d02f1c:	af02      	add	r7, sp, #8
c0d02f1e:	460d      	mov	r5, r1
c0d02f20:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02f22:	20fc      	movs	r0, #252	; 0xfc
c0d02f24:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f26:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02f28:	2803      	cmp	r0, #3
c0d02f2a:	d115      	bne.n	c0d02f58 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02f2c:	88a8      	ldrh	r0, [r5, #4]
c0d02f2e:	22fe      	movs	r2, #254	; 0xfe
c0d02f30:	4002      	ands	r2, r0
c0d02f32:	2a01      	cmp	r2, #1
c0d02f34:	d810      	bhi.n	c0d02f58 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d02f36:	2045      	movs	r0, #69	; 0x45
c0d02f38:	0080      	lsls	r0, r0, #2
c0d02f3a:	5820      	ldr	r0, [r4, r0]
c0d02f3c:	6880      	ldr	r0, [r0, #8]
c0d02f3e:	f7fe fff7 	bl	c0d01f30 <pic>
c0d02f42:	4602      	mov	r2, r0
c0d02f44:	4620      	mov	r0, r4
c0d02f46:	4629      	mov	r1, r5
c0d02f48:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02f4a:	88e8      	ldrh	r0, [r5, #6]
c0d02f4c:	2800      	cmp	r0, #0
c0d02f4e:	d10a      	bne.n	c0d02f66 <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02f50:	4620      	mov	r0, r4
c0d02f52:	f000 f9ed 	bl	c0d03330 <USBD_CtlSendStatus>
c0d02f56:	e006      	b.n	c0d02f66 <USBD_StdItfReq+0x4c>
c0d02f58:	4620      	mov	r0, r4
c0d02f5a:	f7ff fbff 	bl	c0d0275c <USBD_LL_StallEP>
c0d02f5e:	2100      	movs	r1, #0
c0d02f60:	4620      	mov	r0, r4
c0d02f62:	f7ff fbfb 	bl	c0d0275c <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02f66:	2000      	movs	r0, #0
c0d02f68:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f6a <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02f6a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02f6c:	af03      	add	r7, sp, #12
c0d02f6e:	b081      	sub	sp, #4
c0d02f70:	460e      	mov	r6, r1
c0d02f72:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02f74:	7830      	ldrb	r0, [r6, #0]
c0d02f76:	2160      	movs	r1, #96	; 0x60
c0d02f78:	4001      	ands	r1, r0
c0d02f7a:	2920      	cmp	r1, #32
c0d02f7c:	d10a      	bne.n	c0d02f94 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02f7e:	2045      	movs	r0, #69	; 0x45
c0d02f80:	0080      	lsls	r0, r0, #2
c0d02f82:	5820      	ldr	r0, [r4, r0]
c0d02f84:	6880      	ldr	r0, [r0, #8]
c0d02f86:	f7fe ffd3 	bl	c0d01f30 <pic>
c0d02f8a:	4602      	mov	r2, r0
c0d02f8c:	4620      	mov	r0, r4
c0d02f8e:	4631      	mov	r1, r6
c0d02f90:	4790      	blx	r2
c0d02f92:	e063      	b.n	c0d0305c <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02f94:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02f96:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f98:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02f9a:	2800      	cmp	r0, #0
c0d02f9c:	d012      	beq.n	c0d02fc4 <USBD_StdEPReq+0x5a>
c0d02f9e:	2801      	cmp	r0, #1
c0d02fa0:	d019      	beq.n	c0d02fd6 <USBD_StdEPReq+0x6c>
c0d02fa2:	2803      	cmp	r0, #3
c0d02fa4:	d15a      	bne.n	c0d0305c <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02fa6:	20fc      	movs	r0, #252	; 0xfc
c0d02fa8:	5c20      	ldrb	r0, [r4, r0]
c0d02faa:	2803      	cmp	r0, #3
c0d02fac:	d117      	bne.n	c0d02fde <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02fae:	8870      	ldrh	r0, [r6, #2]
c0d02fb0:	2800      	cmp	r0, #0
c0d02fb2:	d12d      	bne.n	c0d03010 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02fb4:	4329      	orrs	r1, r5
c0d02fb6:	2980      	cmp	r1, #128	; 0x80
c0d02fb8:	d02a      	beq.n	c0d03010 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02fba:	4620      	mov	r0, r4
c0d02fbc:	4629      	mov	r1, r5
c0d02fbe:	f7ff fbcd 	bl	c0d0275c <USBD_LL_StallEP>
c0d02fc2:	e025      	b.n	c0d03010 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02fc4:	20fc      	movs	r0, #252	; 0xfc
c0d02fc6:	5c20      	ldrb	r0, [r4, r0]
c0d02fc8:	2803      	cmp	r0, #3
c0d02fca:	d02f      	beq.n	c0d0302c <USBD_StdEPReq+0xc2>
c0d02fcc:	2802      	cmp	r0, #2
c0d02fce:	d10e      	bne.n	c0d02fee <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02fd0:	0668      	lsls	r0, r5, #25
c0d02fd2:	d109      	bne.n	c0d02fe8 <USBD_StdEPReq+0x7e>
c0d02fd4:	e042      	b.n	c0d0305c <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d02fd6:	20fc      	movs	r0, #252	; 0xfc
c0d02fd8:	5c20      	ldrb	r0, [r4, r0]
c0d02fda:	2803      	cmp	r0, #3
c0d02fdc:	d00f      	beq.n	c0d02ffe <USBD_StdEPReq+0x94>
c0d02fde:	2802      	cmp	r0, #2
c0d02fe0:	d105      	bne.n	c0d02fee <USBD_StdEPReq+0x84>
c0d02fe2:	4329      	orrs	r1, r5
c0d02fe4:	2980      	cmp	r1, #128	; 0x80
c0d02fe6:	d039      	beq.n	c0d0305c <USBD_StdEPReq+0xf2>
c0d02fe8:	4620      	mov	r0, r4
c0d02fea:	4629      	mov	r1, r5
c0d02fec:	e004      	b.n	c0d02ff8 <USBD_StdEPReq+0x8e>
c0d02fee:	4620      	mov	r0, r4
c0d02ff0:	f7ff fbb4 	bl	c0d0275c <USBD_LL_StallEP>
c0d02ff4:	2100      	movs	r1, #0
c0d02ff6:	4620      	mov	r0, r4
c0d02ff8:	f7ff fbb0 	bl	c0d0275c <USBD_LL_StallEP>
c0d02ffc:	e02e      	b.n	c0d0305c <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02ffe:	8870      	ldrh	r0, [r6, #2]
c0d03000:	2800      	cmp	r0, #0
c0d03002:	d12b      	bne.n	c0d0305c <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d03004:	0668      	lsls	r0, r5, #25
c0d03006:	d00d      	beq.n	c0d03024 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d03008:	4620      	mov	r0, r4
c0d0300a:	4629      	mov	r1, r5
c0d0300c:	f7ff fbcc 	bl	c0d027a8 <USBD_LL_ClearStallEP>
c0d03010:	2045      	movs	r0, #69	; 0x45
c0d03012:	0080      	lsls	r0, r0, #2
c0d03014:	5820      	ldr	r0, [r4, r0]
c0d03016:	6880      	ldr	r0, [r0, #8]
c0d03018:	f7fe ff8a 	bl	c0d01f30 <pic>
c0d0301c:	4602      	mov	r2, r0
c0d0301e:	4620      	mov	r0, r4
c0d03020:	4631      	mov	r1, r6
c0d03022:	4790      	blx	r2
c0d03024:	4620      	mov	r0, r4
c0d03026:	f000 f983 	bl	c0d03330 <USBD_CtlSendStatus>
c0d0302a:	e017      	b.n	c0d0305c <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d0302c:	4626      	mov	r6, r4
c0d0302e:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d03030:	4620      	mov	r0, r4
c0d03032:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d03034:	420d      	tst	r5, r1
c0d03036:	d100      	bne.n	c0d0303a <USBD_StdEPReq+0xd0>
c0d03038:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d0303a:	4620      	mov	r0, r4
c0d0303c:	4629      	mov	r1, r5
c0d0303e:	f7ff fbd9 	bl	c0d027f4 <USBD_LL_IsStallEP>
c0d03042:	2101      	movs	r1, #1
c0d03044:	2800      	cmp	r0, #0
c0d03046:	d100      	bne.n	c0d0304a <USBD_StdEPReq+0xe0>
c0d03048:	4601      	mov	r1, r0
c0d0304a:	207f      	movs	r0, #127	; 0x7f
c0d0304c:	4005      	ands	r5, r0
c0d0304e:	0128      	lsls	r0, r5, #4
c0d03050:	5031      	str	r1, [r6, r0]
c0d03052:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d03054:	2202      	movs	r2, #2
c0d03056:	4620      	mov	r0, r4
c0d03058:	f000 f93c 	bl	c0d032d4 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d0305c:	2000      	movs	r0, #0
c0d0305e:	b001      	add	sp, #4
c0d03060:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03062 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d03062:	780a      	ldrb	r2, [r1, #0]
c0d03064:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d03066:	784a      	ldrb	r2, [r1, #1]
c0d03068:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d0306a:	788a      	ldrb	r2, [r1, #2]
c0d0306c:	78cb      	ldrb	r3, [r1, #3]
c0d0306e:	021b      	lsls	r3, r3, #8
c0d03070:	4313      	orrs	r3, r2
c0d03072:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d03074:	790a      	ldrb	r2, [r1, #4]
c0d03076:	794b      	ldrb	r3, [r1, #5]
c0d03078:	021b      	lsls	r3, r3, #8
c0d0307a:	4313      	orrs	r3, r2
c0d0307c:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d0307e:	798a      	ldrb	r2, [r1, #6]
c0d03080:	79c9      	ldrb	r1, [r1, #7]
c0d03082:	0209      	lsls	r1, r1, #8
c0d03084:	4311      	orrs	r1, r2
c0d03086:	80c1      	strh	r1, [r0, #6]

}
c0d03088:	4770      	bx	lr

c0d0308a <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d0308a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0308c:	af03      	add	r7, sp, #12
c0d0308e:	b083      	sub	sp, #12
c0d03090:	460d      	mov	r5, r1
c0d03092:	4604      	mov	r4, r0
c0d03094:	a802      	add	r0, sp, #8
c0d03096:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d03098:	8006      	strh	r6, [r0, #0]
c0d0309a:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d0309c:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d0309e:	7829      	ldrb	r1, [r5, #0]
c0d030a0:	2060      	movs	r0, #96	; 0x60
c0d030a2:	4008      	ands	r0, r1
c0d030a4:	2800      	cmp	r0, #0
c0d030a6:	d010      	beq.n	c0d030ca <USBD_HID_Setup+0x40>
c0d030a8:	2820      	cmp	r0, #32
c0d030aa:	d139      	bne.n	c0d03120 <USBD_HID_Setup+0x96>
c0d030ac:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d030ae:	4601      	mov	r1, r0
c0d030b0:	390a      	subs	r1, #10
c0d030b2:	2902      	cmp	r1, #2
c0d030b4:	d334      	bcc.n	c0d03120 <USBD_HID_Setup+0x96>
c0d030b6:	2802      	cmp	r0, #2
c0d030b8:	d01c      	beq.n	c0d030f4 <USBD_HID_Setup+0x6a>
c0d030ba:	2803      	cmp	r0, #3
c0d030bc:	d01a      	beq.n	c0d030f4 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d030be:	4620      	mov	r0, r4
c0d030c0:	4629      	mov	r1, r5
c0d030c2:	f7ff ff1f 	bl	c0d02f04 <USBD_CtlError>
c0d030c6:	2602      	movs	r6, #2
c0d030c8:	e02a      	b.n	c0d03120 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d030ca:	7868      	ldrb	r0, [r5, #1]
c0d030cc:	280b      	cmp	r0, #11
c0d030ce:	d014      	beq.n	c0d030fa <USBD_HID_Setup+0x70>
c0d030d0:	280a      	cmp	r0, #10
c0d030d2:	d00f      	beq.n	c0d030f4 <USBD_HID_Setup+0x6a>
c0d030d4:	2806      	cmp	r0, #6
c0d030d6:	d123      	bne.n	c0d03120 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d030d8:	8868      	ldrh	r0, [r5, #2]
c0d030da:	0a00      	lsrs	r0, r0, #8
c0d030dc:	2600      	movs	r6, #0
c0d030de:	2821      	cmp	r0, #33	; 0x21
c0d030e0:	d00f      	beq.n	c0d03102 <USBD_HID_Setup+0x78>
c0d030e2:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d030e4:	4632      	mov	r2, r6
c0d030e6:	4631      	mov	r1, r6
c0d030e8:	d117      	bne.n	c0d0311a <USBD_HID_Setup+0x90>
c0d030ea:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d030ec:	9000      	str	r0, [sp, #0]
c0d030ee:	f000 f847 	bl	c0d03180 <USBD_HID_GetReportDescriptor_impl>
c0d030f2:	e00a      	b.n	c0d0310a <USBD_HID_Setup+0x80>
c0d030f4:	a901      	add	r1, sp, #4
c0d030f6:	2201      	movs	r2, #1
c0d030f8:	e00f      	b.n	c0d0311a <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d030fa:	4620      	mov	r0, r4
c0d030fc:	f000 f918 	bl	c0d03330 <USBD_CtlSendStatus>
c0d03100:	e00e      	b.n	c0d03120 <USBD_HID_Setup+0x96>
c0d03102:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d03104:	9000      	str	r0, [sp, #0]
c0d03106:	f000 f833 	bl	c0d03170 <USBD_HID_GetHidDescriptor_impl>
c0d0310a:	9b00      	ldr	r3, [sp, #0]
c0d0310c:	4601      	mov	r1, r0
c0d0310e:	881a      	ldrh	r2, [r3, #0]
c0d03110:	88e8      	ldrh	r0, [r5, #6]
c0d03112:	4282      	cmp	r2, r0
c0d03114:	d300      	bcc.n	c0d03118 <USBD_HID_Setup+0x8e>
c0d03116:	4602      	mov	r2, r0
c0d03118:	801a      	strh	r2, [r3, #0]
c0d0311a:	4620      	mov	r0, r4
c0d0311c:	f000 f8da 	bl	c0d032d4 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d03120:	b2f0      	uxtb	r0, r6
c0d03122:	b003      	add	sp, #12
c0d03124:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03126 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d03126:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03128:	af03      	add	r7, sp, #12
c0d0312a:	b081      	sub	sp, #4
c0d0312c:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d0312e:	2182      	movs	r1, #130	; 0x82
c0d03130:	2502      	movs	r5, #2
c0d03132:	2640      	movs	r6, #64	; 0x40
c0d03134:	462a      	mov	r2, r5
c0d03136:	4633      	mov	r3, r6
c0d03138:	f7ff fad0 	bl	c0d026dc <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d0313c:	4620      	mov	r0, r4
c0d0313e:	4629      	mov	r1, r5
c0d03140:	462a      	mov	r2, r5
c0d03142:	4633      	mov	r3, r6
c0d03144:	f7ff faca 	bl	c0d026dc <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d03148:	4620      	mov	r0, r4
c0d0314a:	4629      	mov	r1, r5
c0d0314c:	4632      	mov	r2, r6
c0d0314e:	f7ff fb90 	bl	c0d02872 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d03152:	2000      	movs	r0, #0
c0d03154:	b001      	add	sp, #4
c0d03156:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03158 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d03158:	b5d0      	push	{r4, r6, r7, lr}
c0d0315a:	af02      	add	r7, sp, #8
c0d0315c:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d0315e:	2182      	movs	r1, #130	; 0x82
c0d03160:	f7ff fae4 	bl	c0d0272c <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d03164:	2102      	movs	r1, #2
c0d03166:	4620      	mov	r0, r4
c0d03168:	f7ff fae0 	bl	c0d0272c <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d0316c:	2000      	movs	r0, #0
c0d0316e:	bdd0      	pop	{r4, r6, r7, pc}

c0d03170 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d03170:	2109      	movs	r1, #9
c0d03172:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d03174:	4801      	ldr	r0, [pc, #4]	; (c0d0317c <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d03176:	4478      	add	r0, pc
c0d03178:	4770      	bx	lr
c0d0317a:	46c0      	nop			; (mov r8, r8)
c0d0317c:	00000bca 	.word	0x00000bca

c0d03180 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d03180:	2122      	movs	r1, #34	; 0x22
c0d03182:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d03184:	4801      	ldr	r0, [pc, #4]	; (c0d0318c <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d03186:	4478      	add	r0, pc
c0d03188:	4770      	bx	lr
c0d0318a:	46c0      	nop			; (mov r8, r8)
c0d0318c:	00000b95 	.word	0x00000b95

c0d03190 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d03190:	b5b0      	push	{r4, r5, r7, lr}
c0d03192:	af02      	add	r7, sp, #8
c0d03194:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d03196:	2102      	movs	r1, #2
c0d03198:	2240      	movs	r2, #64	; 0x40
c0d0319a:	f7ff fb6a 	bl	c0d02872 <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d0319e:	4d0d      	ldr	r5, [pc, #52]	; (c0d031d4 <USBD_HID_DataOut_impl+0x44>)
c0d031a0:	7828      	ldrb	r0, [r5, #0]
c0d031a2:	2800      	cmp	r0, #0
c0d031a4:	d113      	bne.n	c0d031ce <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d031a6:	2002      	movs	r0, #2
c0d031a8:	f7fe f928 	bl	c0d013fc <io_seproxyhal_get_ep_rx_size>
c0d031ac:	4602      	mov	r2, r0
c0d031ae:	480d      	ldr	r0, [pc, #52]	; (c0d031e4 <USBD_HID_DataOut_impl+0x54>)
c0d031b0:	4478      	add	r0, pc
c0d031b2:	4621      	mov	r1, r4
c0d031b4:	f7fd ff86 	bl	c0d010c4 <io_usb_hid_receive>
c0d031b8:	2802      	cmp	r0, #2
c0d031ba:	d108      	bne.n	c0d031ce <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d031bc:	2001      	movs	r0, #1
c0d031be:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d031c0:	4805      	ldr	r0, [pc, #20]	; (c0d031d8 <USBD_HID_DataOut_impl+0x48>)
c0d031c2:	2107      	movs	r1, #7
c0d031c4:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d031c6:	4805      	ldr	r0, [pc, #20]	; (c0d031dc <USBD_HID_DataOut_impl+0x4c>)
c0d031c8:	6800      	ldr	r0, [r0, #0]
c0d031ca:	4905      	ldr	r1, [pc, #20]	; (c0d031e0 <USBD_HID_DataOut_impl+0x50>)
c0d031cc:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d031ce:	2000      	movs	r0, #0
c0d031d0:	bdb0      	pop	{r4, r5, r7, pc}
c0d031d2:	46c0      	nop			; (mov r8, r8)
c0d031d4:	20001d10 	.word	0x20001d10
c0d031d8:	20001d18 	.word	0x20001d18
c0d031dc:	20001c00 	.word	0x20001c00
c0d031e0:	20001d1c 	.word	0x20001d1c
c0d031e4:	ffffe3a1 	.word	0xffffe3a1

c0d031e8 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d031e8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d031ea:	af03      	add	r7, sp, #12
c0d031ec:	b081      	sub	sp, #4
c0d031ee:	4604      	mov	r4, r0
c0d031f0:	2049      	movs	r0, #73	; 0x49
c0d031f2:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d031f4:	4810      	ldr	r0, [pc, #64]	; (c0d03238 <USB_power+0x50>)
c0d031f6:	2100      	movs	r1, #0
c0d031f8:	462a      	mov	r2, r5
c0d031fa:	f7fe f80f 	bl	c0d0121c <os_memset>

  if (enabled) {
c0d031fe:	2c00      	cmp	r4, #0
c0d03200:	d015      	beq.n	c0d0322e <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d03202:	4c0d      	ldr	r4, [pc, #52]	; (c0d03238 <USB_power+0x50>)
c0d03204:	2600      	movs	r6, #0
c0d03206:	4620      	mov	r0, r4
c0d03208:	4631      	mov	r1, r6
c0d0320a:	462a      	mov	r2, r5
c0d0320c:	f7fe f806 	bl	c0d0121c <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d03210:	490a      	ldr	r1, [pc, #40]	; (c0d0323c <USB_power+0x54>)
c0d03212:	4479      	add	r1, pc
c0d03214:	4620      	mov	r0, r4
c0d03216:	4632      	mov	r2, r6
c0d03218:	f7ff fb3f 	bl	c0d0289a <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d0321c:	4908      	ldr	r1, [pc, #32]	; (c0d03240 <USB_power+0x58>)
c0d0321e:	4479      	add	r1, pc
c0d03220:	4620      	mov	r0, r4
c0d03222:	f7ff fb72 	bl	c0d0290a <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d03226:	4620      	mov	r0, r4
c0d03228:	f7ff fb78 	bl	c0d0291c <USBD_Start>
c0d0322c:	e002      	b.n	c0d03234 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d0322e:	4802      	ldr	r0, [pc, #8]	; (c0d03238 <USB_power+0x50>)
c0d03230:	f7ff fb51 	bl	c0d028d6 <USBD_DeInit>
  }
}
c0d03234:	b001      	add	sp, #4
c0d03236:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03238:	20001d34 	.word	0x20001d34
c0d0323c:	00000b4a 	.word	0x00000b4a
c0d03240:	00000b7a 	.word	0x00000b7a

c0d03244 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d03244:	2012      	movs	r0, #18
c0d03246:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d03248:	4801      	ldr	r0, [pc, #4]	; (c0d03250 <USBD_DeviceDescriptor+0xc>)
c0d0324a:	4478      	add	r0, pc
c0d0324c:	4770      	bx	lr
c0d0324e:	46c0      	nop			; (mov r8, r8)
c0d03250:	00000aff 	.word	0x00000aff

c0d03254 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d03254:	2004      	movs	r0, #4
c0d03256:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d03258:	4801      	ldr	r0, [pc, #4]	; (c0d03260 <USBD_LangIDStrDescriptor+0xc>)
c0d0325a:	4478      	add	r0, pc
c0d0325c:	4770      	bx	lr
c0d0325e:	46c0      	nop			; (mov r8, r8)
c0d03260:	00000b22 	.word	0x00000b22

c0d03264 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d03264:	200e      	movs	r0, #14
c0d03266:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d03268:	4801      	ldr	r0, [pc, #4]	; (c0d03270 <USBD_ManufacturerStrDescriptor+0xc>)
c0d0326a:	4478      	add	r0, pc
c0d0326c:	4770      	bx	lr
c0d0326e:	46c0      	nop			; (mov r8, r8)
c0d03270:	00000b16 	.word	0x00000b16

c0d03274 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d03274:	200e      	movs	r0, #14
c0d03276:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d03278:	4801      	ldr	r0, [pc, #4]	; (c0d03280 <USBD_ProductStrDescriptor+0xc>)
c0d0327a:	4478      	add	r0, pc
c0d0327c:	4770      	bx	lr
c0d0327e:	46c0      	nop			; (mov r8, r8)
c0d03280:	00000a93 	.word	0x00000a93

c0d03284 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d03284:	200a      	movs	r0, #10
c0d03286:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d03288:	4801      	ldr	r0, [pc, #4]	; (c0d03290 <USBD_SerialStrDescriptor+0xc>)
c0d0328a:	4478      	add	r0, pc
c0d0328c:	4770      	bx	lr
c0d0328e:	46c0      	nop			; (mov r8, r8)
c0d03290:	00000b04 	.word	0x00000b04

c0d03294 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d03294:	200e      	movs	r0, #14
c0d03296:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d03298:	4801      	ldr	r0, [pc, #4]	; (c0d032a0 <USBD_ConfigStrDescriptor+0xc>)
c0d0329a:	4478      	add	r0, pc
c0d0329c:	4770      	bx	lr
c0d0329e:	46c0      	nop			; (mov r8, r8)
c0d032a0:	00000a73 	.word	0x00000a73

c0d032a4 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d032a4:	200e      	movs	r0, #14
c0d032a6:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d032a8:	4801      	ldr	r0, [pc, #4]	; (c0d032b0 <USBD_InterfaceStrDescriptor+0xc>)
c0d032aa:	4478      	add	r0, pc
c0d032ac:	4770      	bx	lr
c0d032ae:	46c0      	nop			; (mov r8, r8)
c0d032b0:	00000a63 	.word	0x00000a63

c0d032b4 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d032b4:	2129      	movs	r1, #41	; 0x29
c0d032b6:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d032b8:	4801      	ldr	r0, [pc, #4]	; (c0d032c0 <USBD_GetCfgDesc_impl+0xc>)
c0d032ba:	4478      	add	r0, pc
c0d032bc:	4770      	bx	lr
c0d032be:	46c0      	nop			; (mov r8, r8)
c0d032c0:	00000b16 	.word	0x00000b16

c0d032c4 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d032c4:	210a      	movs	r1, #10
c0d032c6:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d032c8:	4801      	ldr	r0, [pc, #4]	; (c0d032d0 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d032ca:	4478      	add	r0, pc
c0d032cc:	4770      	bx	lr
c0d032ce:	46c0      	nop			; (mov r8, r8)
c0d032d0:	00000b32 	.word	0x00000b32

c0d032d4 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d032d4:	b5b0      	push	{r4, r5, r7, lr}
c0d032d6:	af02      	add	r7, sp, #8
c0d032d8:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d032da:	21f4      	movs	r1, #244	; 0xf4
c0d032dc:	2302      	movs	r3, #2
c0d032de:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d032e0:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d032e2:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d032e4:	2109      	movs	r1, #9
c0d032e6:	0149      	lsls	r1, r1, #5
c0d032e8:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d032ea:	6a01      	ldr	r1, [r0, #32]
c0d032ec:	428a      	cmp	r2, r1
c0d032ee:	d300      	bcc.n	c0d032f2 <USBD_CtlSendData+0x1e>
c0d032f0:	460a      	mov	r2, r1
c0d032f2:	b293      	uxth	r3, r2
c0d032f4:	2500      	movs	r5, #0
c0d032f6:	4629      	mov	r1, r5
c0d032f8:	4622      	mov	r2, r4
c0d032fa:	f7ff faa0 	bl	c0d0283e <USBD_LL_Transmit>
  
  return USBD_OK;
c0d032fe:	4628      	mov	r0, r5
c0d03300:	bdb0      	pop	{r4, r5, r7, pc}

c0d03302 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d03302:	b5b0      	push	{r4, r5, r7, lr}
c0d03304:	af02      	add	r7, sp, #8
c0d03306:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d03308:	6a01      	ldr	r1, [r0, #32]
c0d0330a:	428a      	cmp	r2, r1
c0d0330c:	d300      	bcc.n	c0d03310 <USBD_CtlContinueSendData+0xe>
c0d0330e:	460a      	mov	r2, r1
c0d03310:	b293      	uxth	r3, r2
c0d03312:	2500      	movs	r5, #0
c0d03314:	4629      	mov	r1, r5
c0d03316:	4622      	mov	r2, r4
c0d03318:	f7ff fa91 	bl	c0d0283e <USBD_LL_Transmit>
  return USBD_OK;
c0d0331c:	4628      	mov	r0, r5
c0d0331e:	bdb0      	pop	{r4, r5, r7, pc}

c0d03320 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d03320:	b5d0      	push	{r4, r6, r7, lr}
c0d03322:	af02      	add	r7, sp, #8
c0d03324:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d03326:	4621      	mov	r1, r4
c0d03328:	f7ff faa3 	bl	c0d02872 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d0332c:	4620      	mov	r0, r4
c0d0332e:	bdd0      	pop	{r4, r6, r7, pc}

c0d03330 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d03330:	b5d0      	push	{r4, r6, r7, lr}
c0d03332:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d03334:	21f4      	movs	r1, #244	; 0xf4
c0d03336:	2204      	movs	r2, #4
c0d03338:	5042      	str	r2, [r0, r1]
c0d0333a:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d0333c:	4621      	mov	r1, r4
c0d0333e:	4622      	mov	r2, r4
c0d03340:	4623      	mov	r3, r4
c0d03342:	f7ff fa7c 	bl	c0d0283e <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03346:	4620      	mov	r0, r4
c0d03348:	bdd0      	pop	{r4, r6, r7, pc}

c0d0334a <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d0334a:	b5d0      	push	{r4, r6, r7, lr}
c0d0334c:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d0334e:	21f4      	movs	r1, #244	; 0xf4
c0d03350:	2205      	movs	r2, #5
c0d03352:	5042      	str	r2, [r0, r1]
c0d03354:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d03356:	4621      	mov	r1, r4
c0d03358:	4622      	mov	r2, r4
c0d0335a:	f7ff fa8a 	bl	c0d02872 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d0335e:	4620      	mov	r0, r4
c0d03360:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d03364 <__aeabi_uidiv>:
c0d03364:	2200      	movs	r2, #0
c0d03366:	0843      	lsrs	r3, r0, #1
c0d03368:	428b      	cmp	r3, r1
c0d0336a:	d374      	bcc.n	c0d03456 <__aeabi_uidiv+0xf2>
c0d0336c:	0903      	lsrs	r3, r0, #4
c0d0336e:	428b      	cmp	r3, r1
c0d03370:	d35f      	bcc.n	c0d03432 <__aeabi_uidiv+0xce>
c0d03372:	0a03      	lsrs	r3, r0, #8
c0d03374:	428b      	cmp	r3, r1
c0d03376:	d344      	bcc.n	c0d03402 <__aeabi_uidiv+0x9e>
c0d03378:	0b03      	lsrs	r3, r0, #12
c0d0337a:	428b      	cmp	r3, r1
c0d0337c:	d328      	bcc.n	c0d033d0 <__aeabi_uidiv+0x6c>
c0d0337e:	0c03      	lsrs	r3, r0, #16
c0d03380:	428b      	cmp	r3, r1
c0d03382:	d30d      	bcc.n	c0d033a0 <__aeabi_uidiv+0x3c>
c0d03384:	22ff      	movs	r2, #255	; 0xff
c0d03386:	0209      	lsls	r1, r1, #8
c0d03388:	ba12      	rev	r2, r2
c0d0338a:	0c03      	lsrs	r3, r0, #16
c0d0338c:	428b      	cmp	r3, r1
c0d0338e:	d302      	bcc.n	c0d03396 <__aeabi_uidiv+0x32>
c0d03390:	1212      	asrs	r2, r2, #8
c0d03392:	0209      	lsls	r1, r1, #8
c0d03394:	d065      	beq.n	c0d03462 <__aeabi_uidiv+0xfe>
c0d03396:	0b03      	lsrs	r3, r0, #12
c0d03398:	428b      	cmp	r3, r1
c0d0339a:	d319      	bcc.n	c0d033d0 <__aeabi_uidiv+0x6c>
c0d0339c:	e000      	b.n	c0d033a0 <__aeabi_uidiv+0x3c>
c0d0339e:	0a09      	lsrs	r1, r1, #8
c0d033a0:	0bc3      	lsrs	r3, r0, #15
c0d033a2:	428b      	cmp	r3, r1
c0d033a4:	d301      	bcc.n	c0d033aa <__aeabi_uidiv+0x46>
c0d033a6:	03cb      	lsls	r3, r1, #15
c0d033a8:	1ac0      	subs	r0, r0, r3
c0d033aa:	4152      	adcs	r2, r2
c0d033ac:	0b83      	lsrs	r3, r0, #14
c0d033ae:	428b      	cmp	r3, r1
c0d033b0:	d301      	bcc.n	c0d033b6 <__aeabi_uidiv+0x52>
c0d033b2:	038b      	lsls	r3, r1, #14
c0d033b4:	1ac0      	subs	r0, r0, r3
c0d033b6:	4152      	adcs	r2, r2
c0d033b8:	0b43      	lsrs	r3, r0, #13
c0d033ba:	428b      	cmp	r3, r1
c0d033bc:	d301      	bcc.n	c0d033c2 <__aeabi_uidiv+0x5e>
c0d033be:	034b      	lsls	r3, r1, #13
c0d033c0:	1ac0      	subs	r0, r0, r3
c0d033c2:	4152      	adcs	r2, r2
c0d033c4:	0b03      	lsrs	r3, r0, #12
c0d033c6:	428b      	cmp	r3, r1
c0d033c8:	d301      	bcc.n	c0d033ce <__aeabi_uidiv+0x6a>
c0d033ca:	030b      	lsls	r3, r1, #12
c0d033cc:	1ac0      	subs	r0, r0, r3
c0d033ce:	4152      	adcs	r2, r2
c0d033d0:	0ac3      	lsrs	r3, r0, #11
c0d033d2:	428b      	cmp	r3, r1
c0d033d4:	d301      	bcc.n	c0d033da <__aeabi_uidiv+0x76>
c0d033d6:	02cb      	lsls	r3, r1, #11
c0d033d8:	1ac0      	subs	r0, r0, r3
c0d033da:	4152      	adcs	r2, r2
c0d033dc:	0a83      	lsrs	r3, r0, #10
c0d033de:	428b      	cmp	r3, r1
c0d033e0:	d301      	bcc.n	c0d033e6 <__aeabi_uidiv+0x82>
c0d033e2:	028b      	lsls	r3, r1, #10
c0d033e4:	1ac0      	subs	r0, r0, r3
c0d033e6:	4152      	adcs	r2, r2
c0d033e8:	0a43      	lsrs	r3, r0, #9
c0d033ea:	428b      	cmp	r3, r1
c0d033ec:	d301      	bcc.n	c0d033f2 <__aeabi_uidiv+0x8e>
c0d033ee:	024b      	lsls	r3, r1, #9
c0d033f0:	1ac0      	subs	r0, r0, r3
c0d033f2:	4152      	adcs	r2, r2
c0d033f4:	0a03      	lsrs	r3, r0, #8
c0d033f6:	428b      	cmp	r3, r1
c0d033f8:	d301      	bcc.n	c0d033fe <__aeabi_uidiv+0x9a>
c0d033fa:	020b      	lsls	r3, r1, #8
c0d033fc:	1ac0      	subs	r0, r0, r3
c0d033fe:	4152      	adcs	r2, r2
c0d03400:	d2cd      	bcs.n	c0d0339e <__aeabi_uidiv+0x3a>
c0d03402:	09c3      	lsrs	r3, r0, #7
c0d03404:	428b      	cmp	r3, r1
c0d03406:	d301      	bcc.n	c0d0340c <__aeabi_uidiv+0xa8>
c0d03408:	01cb      	lsls	r3, r1, #7
c0d0340a:	1ac0      	subs	r0, r0, r3
c0d0340c:	4152      	adcs	r2, r2
c0d0340e:	0983      	lsrs	r3, r0, #6
c0d03410:	428b      	cmp	r3, r1
c0d03412:	d301      	bcc.n	c0d03418 <__aeabi_uidiv+0xb4>
c0d03414:	018b      	lsls	r3, r1, #6
c0d03416:	1ac0      	subs	r0, r0, r3
c0d03418:	4152      	adcs	r2, r2
c0d0341a:	0943      	lsrs	r3, r0, #5
c0d0341c:	428b      	cmp	r3, r1
c0d0341e:	d301      	bcc.n	c0d03424 <__aeabi_uidiv+0xc0>
c0d03420:	014b      	lsls	r3, r1, #5
c0d03422:	1ac0      	subs	r0, r0, r3
c0d03424:	4152      	adcs	r2, r2
c0d03426:	0903      	lsrs	r3, r0, #4
c0d03428:	428b      	cmp	r3, r1
c0d0342a:	d301      	bcc.n	c0d03430 <__aeabi_uidiv+0xcc>
c0d0342c:	010b      	lsls	r3, r1, #4
c0d0342e:	1ac0      	subs	r0, r0, r3
c0d03430:	4152      	adcs	r2, r2
c0d03432:	08c3      	lsrs	r3, r0, #3
c0d03434:	428b      	cmp	r3, r1
c0d03436:	d301      	bcc.n	c0d0343c <__aeabi_uidiv+0xd8>
c0d03438:	00cb      	lsls	r3, r1, #3
c0d0343a:	1ac0      	subs	r0, r0, r3
c0d0343c:	4152      	adcs	r2, r2
c0d0343e:	0883      	lsrs	r3, r0, #2
c0d03440:	428b      	cmp	r3, r1
c0d03442:	d301      	bcc.n	c0d03448 <__aeabi_uidiv+0xe4>
c0d03444:	008b      	lsls	r3, r1, #2
c0d03446:	1ac0      	subs	r0, r0, r3
c0d03448:	4152      	adcs	r2, r2
c0d0344a:	0843      	lsrs	r3, r0, #1
c0d0344c:	428b      	cmp	r3, r1
c0d0344e:	d301      	bcc.n	c0d03454 <__aeabi_uidiv+0xf0>
c0d03450:	004b      	lsls	r3, r1, #1
c0d03452:	1ac0      	subs	r0, r0, r3
c0d03454:	4152      	adcs	r2, r2
c0d03456:	1a41      	subs	r1, r0, r1
c0d03458:	d200      	bcs.n	c0d0345c <__aeabi_uidiv+0xf8>
c0d0345a:	4601      	mov	r1, r0
c0d0345c:	4152      	adcs	r2, r2
c0d0345e:	4610      	mov	r0, r2
c0d03460:	4770      	bx	lr
c0d03462:	e7ff      	b.n	c0d03464 <__aeabi_uidiv+0x100>
c0d03464:	b501      	push	{r0, lr}
c0d03466:	2000      	movs	r0, #0
c0d03468:	f000 f8f0 	bl	c0d0364c <__aeabi_idiv0>
c0d0346c:	bd02      	pop	{r1, pc}
c0d0346e:	46c0      	nop			; (mov r8, r8)

c0d03470 <__aeabi_uidivmod>:
c0d03470:	2900      	cmp	r1, #0
c0d03472:	d0f7      	beq.n	c0d03464 <__aeabi_uidiv+0x100>
c0d03474:	e776      	b.n	c0d03364 <__aeabi_uidiv>
c0d03476:	4770      	bx	lr

c0d03478 <__aeabi_idiv>:
c0d03478:	4603      	mov	r3, r0
c0d0347a:	430b      	orrs	r3, r1
c0d0347c:	d47f      	bmi.n	c0d0357e <__aeabi_idiv+0x106>
c0d0347e:	2200      	movs	r2, #0
c0d03480:	0843      	lsrs	r3, r0, #1
c0d03482:	428b      	cmp	r3, r1
c0d03484:	d374      	bcc.n	c0d03570 <__aeabi_idiv+0xf8>
c0d03486:	0903      	lsrs	r3, r0, #4
c0d03488:	428b      	cmp	r3, r1
c0d0348a:	d35f      	bcc.n	c0d0354c <__aeabi_idiv+0xd4>
c0d0348c:	0a03      	lsrs	r3, r0, #8
c0d0348e:	428b      	cmp	r3, r1
c0d03490:	d344      	bcc.n	c0d0351c <__aeabi_idiv+0xa4>
c0d03492:	0b03      	lsrs	r3, r0, #12
c0d03494:	428b      	cmp	r3, r1
c0d03496:	d328      	bcc.n	c0d034ea <__aeabi_idiv+0x72>
c0d03498:	0c03      	lsrs	r3, r0, #16
c0d0349a:	428b      	cmp	r3, r1
c0d0349c:	d30d      	bcc.n	c0d034ba <__aeabi_idiv+0x42>
c0d0349e:	22ff      	movs	r2, #255	; 0xff
c0d034a0:	0209      	lsls	r1, r1, #8
c0d034a2:	ba12      	rev	r2, r2
c0d034a4:	0c03      	lsrs	r3, r0, #16
c0d034a6:	428b      	cmp	r3, r1
c0d034a8:	d302      	bcc.n	c0d034b0 <__aeabi_idiv+0x38>
c0d034aa:	1212      	asrs	r2, r2, #8
c0d034ac:	0209      	lsls	r1, r1, #8
c0d034ae:	d065      	beq.n	c0d0357c <__aeabi_idiv+0x104>
c0d034b0:	0b03      	lsrs	r3, r0, #12
c0d034b2:	428b      	cmp	r3, r1
c0d034b4:	d319      	bcc.n	c0d034ea <__aeabi_idiv+0x72>
c0d034b6:	e000      	b.n	c0d034ba <__aeabi_idiv+0x42>
c0d034b8:	0a09      	lsrs	r1, r1, #8
c0d034ba:	0bc3      	lsrs	r3, r0, #15
c0d034bc:	428b      	cmp	r3, r1
c0d034be:	d301      	bcc.n	c0d034c4 <__aeabi_idiv+0x4c>
c0d034c0:	03cb      	lsls	r3, r1, #15
c0d034c2:	1ac0      	subs	r0, r0, r3
c0d034c4:	4152      	adcs	r2, r2
c0d034c6:	0b83      	lsrs	r3, r0, #14
c0d034c8:	428b      	cmp	r3, r1
c0d034ca:	d301      	bcc.n	c0d034d0 <__aeabi_idiv+0x58>
c0d034cc:	038b      	lsls	r3, r1, #14
c0d034ce:	1ac0      	subs	r0, r0, r3
c0d034d0:	4152      	adcs	r2, r2
c0d034d2:	0b43      	lsrs	r3, r0, #13
c0d034d4:	428b      	cmp	r3, r1
c0d034d6:	d301      	bcc.n	c0d034dc <__aeabi_idiv+0x64>
c0d034d8:	034b      	lsls	r3, r1, #13
c0d034da:	1ac0      	subs	r0, r0, r3
c0d034dc:	4152      	adcs	r2, r2
c0d034de:	0b03      	lsrs	r3, r0, #12
c0d034e0:	428b      	cmp	r3, r1
c0d034e2:	d301      	bcc.n	c0d034e8 <__aeabi_idiv+0x70>
c0d034e4:	030b      	lsls	r3, r1, #12
c0d034e6:	1ac0      	subs	r0, r0, r3
c0d034e8:	4152      	adcs	r2, r2
c0d034ea:	0ac3      	lsrs	r3, r0, #11
c0d034ec:	428b      	cmp	r3, r1
c0d034ee:	d301      	bcc.n	c0d034f4 <__aeabi_idiv+0x7c>
c0d034f0:	02cb      	lsls	r3, r1, #11
c0d034f2:	1ac0      	subs	r0, r0, r3
c0d034f4:	4152      	adcs	r2, r2
c0d034f6:	0a83      	lsrs	r3, r0, #10
c0d034f8:	428b      	cmp	r3, r1
c0d034fa:	d301      	bcc.n	c0d03500 <__aeabi_idiv+0x88>
c0d034fc:	028b      	lsls	r3, r1, #10
c0d034fe:	1ac0      	subs	r0, r0, r3
c0d03500:	4152      	adcs	r2, r2
c0d03502:	0a43      	lsrs	r3, r0, #9
c0d03504:	428b      	cmp	r3, r1
c0d03506:	d301      	bcc.n	c0d0350c <__aeabi_idiv+0x94>
c0d03508:	024b      	lsls	r3, r1, #9
c0d0350a:	1ac0      	subs	r0, r0, r3
c0d0350c:	4152      	adcs	r2, r2
c0d0350e:	0a03      	lsrs	r3, r0, #8
c0d03510:	428b      	cmp	r3, r1
c0d03512:	d301      	bcc.n	c0d03518 <__aeabi_idiv+0xa0>
c0d03514:	020b      	lsls	r3, r1, #8
c0d03516:	1ac0      	subs	r0, r0, r3
c0d03518:	4152      	adcs	r2, r2
c0d0351a:	d2cd      	bcs.n	c0d034b8 <__aeabi_idiv+0x40>
c0d0351c:	09c3      	lsrs	r3, r0, #7
c0d0351e:	428b      	cmp	r3, r1
c0d03520:	d301      	bcc.n	c0d03526 <__aeabi_idiv+0xae>
c0d03522:	01cb      	lsls	r3, r1, #7
c0d03524:	1ac0      	subs	r0, r0, r3
c0d03526:	4152      	adcs	r2, r2
c0d03528:	0983      	lsrs	r3, r0, #6
c0d0352a:	428b      	cmp	r3, r1
c0d0352c:	d301      	bcc.n	c0d03532 <__aeabi_idiv+0xba>
c0d0352e:	018b      	lsls	r3, r1, #6
c0d03530:	1ac0      	subs	r0, r0, r3
c0d03532:	4152      	adcs	r2, r2
c0d03534:	0943      	lsrs	r3, r0, #5
c0d03536:	428b      	cmp	r3, r1
c0d03538:	d301      	bcc.n	c0d0353e <__aeabi_idiv+0xc6>
c0d0353a:	014b      	lsls	r3, r1, #5
c0d0353c:	1ac0      	subs	r0, r0, r3
c0d0353e:	4152      	adcs	r2, r2
c0d03540:	0903      	lsrs	r3, r0, #4
c0d03542:	428b      	cmp	r3, r1
c0d03544:	d301      	bcc.n	c0d0354a <__aeabi_idiv+0xd2>
c0d03546:	010b      	lsls	r3, r1, #4
c0d03548:	1ac0      	subs	r0, r0, r3
c0d0354a:	4152      	adcs	r2, r2
c0d0354c:	08c3      	lsrs	r3, r0, #3
c0d0354e:	428b      	cmp	r3, r1
c0d03550:	d301      	bcc.n	c0d03556 <__aeabi_idiv+0xde>
c0d03552:	00cb      	lsls	r3, r1, #3
c0d03554:	1ac0      	subs	r0, r0, r3
c0d03556:	4152      	adcs	r2, r2
c0d03558:	0883      	lsrs	r3, r0, #2
c0d0355a:	428b      	cmp	r3, r1
c0d0355c:	d301      	bcc.n	c0d03562 <__aeabi_idiv+0xea>
c0d0355e:	008b      	lsls	r3, r1, #2
c0d03560:	1ac0      	subs	r0, r0, r3
c0d03562:	4152      	adcs	r2, r2
c0d03564:	0843      	lsrs	r3, r0, #1
c0d03566:	428b      	cmp	r3, r1
c0d03568:	d301      	bcc.n	c0d0356e <__aeabi_idiv+0xf6>
c0d0356a:	004b      	lsls	r3, r1, #1
c0d0356c:	1ac0      	subs	r0, r0, r3
c0d0356e:	4152      	adcs	r2, r2
c0d03570:	1a41      	subs	r1, r0, r1
c0d03572:	d200      	bcs.n	c0d03576 <__aeabi_idiv+0xfe>
c0d03574:	4601      	mov	r1, r0
c0d03576:	4152      	adcs	r2, r2
c0d03578:	4610      	mov	r0, r2
c0d0357a:	4770      	bx	lr
c0d0357c:	e05d      	b.n	c0d0363a <__aeabi_idiv+0x1c2>
c0d0357e:	0fca      	lsrs	r2, r1, #31
c0d03580:	d000      	beq.n	c0d03584 <__aeabi_idiv+0x10c>
c0d03582:	4249      	negs	r1, r1
c0d03584:	1003      	asrs	r3, r0, #32
c0d03586:	d300      	bcc.n	c0d0358a <__aeabi_idiv+0x112>
c0d03588:	4240      	negs	r0, r0
c0d0358a:	4053      	eors	r3, r2
c0d0358c:	2200      	movs	r2, #0
c0d0358e:	469c      	mov	ip, r3
c0d03590:	0903      	lsrs	r3, r0, #4
c0d03592:	428b      	cmp	r3, r1
c0d03594:	d32d      	bcc.n	c0d035f2 <__aeabi_idiv+0x17a>
c0d03596:	0a03      	lsrs	r3, r0, #8
c0d03598:	428b      	cmp	r3, r1
c0d0359a:	d312      	bcc.n	c0d035c2 <__aeabi_idiv+0x14a>
c0d0359c:	22fc      	movs	r2, #252	; 0xfc
c0d0359e:	0189      	lsls	r1, r1, #6
c0d035a0:	ba12      	rev	r2, r2
c0d035a2:	0a03      	lsrs	r3, r0, #8
c0d035a4:	428b      	cmp	r3, r1
c0d035a6:	d30c      	bcc.n	c0d035c2 <__aeabi_idiv+0x14a>
c0d035a8:	0189      	lsls	r1, r1, #6
c0d035aa:	1192      	asrs	r2, r2, #6
c0d035ac:	428b      	cmp	r3, r1
c0d035ae:	d308      	bcc.n	c0d035c2 <__aeabi_idiv+0x14a>
c0d035b0:	0189      	lsls	r1, r1, #6
c0d035b2:	1192      	asrs	r2, r2, #6
c0d035b4:	428b      	cmp	r3, r1
c0d035b6:	d304      	bcc.n	c0d035c2 <__aeabi_idiv+0x14a>
c0d035b8:	0189      	lsls	r1, r1, #6
c0d035ba:	d03a      	beq.n	c0d03632 <__aeabi_idiv+0x1ba>
c0d035bc:	1192      	asrs	r2, r2, #6
c0d035be:	e000      	b.n	c0d035c2 <__aeabi_idiv+0x14a>
c0d035c0:	0989      	lsrs	r1, r1, #6
c0d035c2:	09c3      	lsrs	r3, r0, #7
c0d035c4:	428b      	cmp	r3, r1
c0d035c6:	d301      	bcc.n	c0d035cc <__aeabi_idiv+0x154>
c0d035c8:	01cb      	lsls	r3, r1, #7
c0d035ca:	1ac0      	subs	r0, r0, r3
c0d035cc:	4152      	adcs	r2, r2
c0d035ce:	0983      	lsrs	r3, r0, #6
c0d035d0:	428b      	cmp	r3, r1
c0d035d2:	d301      	bcc.n	c0d035d8 <__aeabi_idiv+0x160>
c0d035d4:	018b      	lsls	r3, r1, #6
c0d035d6:	1ac0      	subs	r0, r0, r3
c0d035d8:	4152      	adcs	r2, r2
c0d035da:	0943      	lsrs	r3, r0, #5
c0d035dc:	428b      	cmp	r3, r1
c0d035de:	d301      	bcc.n	c0d035e4 <__aeabi_idiv+0x16c>
c0d035e0:	014b      	lsls	r3, r1, #5
c0d035e2:	1ac0      	subs	r0, r0, r3
c0d035e4:	4152      	adcs	r2, r2
c0d035e6:	0903      	lsrs	r3, r0, #4
c0d035e8:	428b      	cmp	r3, r1
c0d035ea:	d301      	bcc.n	c0d035f0 <__aeabi_idiv+0x178>
c0d035ec:	010b      	lsls	r3, r1, #4
c0d035ee:	1ac0      	subs	r0, r0, r3
c0d035f0:	4152      	adcs	r2, r2
c0d035f2:	08c3      	lsrs	r3, r0, #3
c0d035f4:	428b      	cmp	r3, r1
c0d035f6:	d301      	bcc.n	c0d035fc <__aeabi_idiv+0x184>
c0d035f8:	00cb      	lsls	r3, r1, #3
c0d035fa:	1ac0      	subs	r0, r0, r3
c0d035fc:	4152      	adcs	r2, r2
c0d035fe:	0883      	lsrs	r3, r0, #2
c0d03600:	428b      	cmp	r3, r1
c0d03602:	d301      	bcc.n	c0d03608 <__aeabi_idiv+0x190>
c0d03604:	008b      	lsls	r3, r1, #2
c0d03606:	1ac0      	subs	r0, r0, r3
c0d03608:	4152      	adcs	r2, r2
c0d0360a:	d2d9      	bcs.n	c0d035c0 <__aeabi_idiv+0x148>
c0d0360c:	0843      	lsrs	r3, r0, #1
c0d0360e:	428b      	cmp	r3, r1
c0d03610:	d301      	bcc.n	c0d03616 <__aeabi_idiv+0x19e>
c0d03612:	004b      	lsls	r3, r1, #1
c0d03614:	1ac0      	subs	r0, r0, r3
c0d03616:	4152      	adcs	r2, r2
c0d03618:	1a41      	subs	r1, r0, r1
c0d0361a:	d200      	bcs.n	c0d0361e <__aeabi_idiv+0x1a6>
c0d0361c:	4601      	mov	r1, r0
c0d0361e:	4663      	mov	r3, ip
c0d03620:	4152      	adcs	r2, r2
c0d03622:	105b      	asrs	r3, r3, #1
c0d03624:	4610      	mov	r0, r2
c0d03626:	d301      	bcc.n	c0d0362c <__aeabi_idiv+0x1b4>
c0d03628:	4240      	negs	r0, r0
c0d0362a:	2b00      	cmp	r3, #0
c0d0362c:	d500      	bpl.n	c0d03630 <__aeabi_idiv+0x1b8>
c0d0362e:	4249      	negs	r1, r1
c0d03630:	4770      	bx	lr
c0d03632:	4663      	mov	r3, ip
c0d03634:	105b      	asrs	r3, r3, #1
c0d03636:	d300      	bcc.n	c0d0363a <__aeabi_idiv+0x1c2>
c0d03638:	4240      	negs	r0, r0
c0d0363a:	b501      	push	{r0, lr}
c0d0363c:	2000      	movs	r0, #0
c0d0363e:	f000 f805 	bl	c0d0364c <__aeabi_idiv0>
c0d03642:	bd02      	pop	{r1, pc}

c0d03644 <__aeabi_idivmod>:
c0d03644:	2900      	cmp	r1, #0
c0d03646:	d0f8      	beq.n	c0d0363a <__aeabi_idiv+0x1c2>
c0d03648:	e716      	b.n	c0d03478 <__aeabi_idiv>
c0d0364a:	4770      	bx	lr

c0d0364c <__aeabi_idiv0>:
c0d0364c:	4770      	bx	lr
c0d0364e:	46c0      	nop			; (mov r8, r8)

c0d03650 <__aeabi_uldivmod>:
c0d03650:	2b00      	cmp	r3, #0
c0d03652:	d111      	bne.n	c0d03678 <__aeabi_uldivmod+0x28>
c0d03654:	2a00      	cmp	r2, #0
c0d03656:	d10f      	bne.n	c0d03678 <__aeabi_uldivmod+0x28>
c0d03658:	2900      	cmp	r1, #0
c0d0365a:	d100      	bne.n	c0d0365e <__aeabi_uldivmod+0xe>
c0d0365c:	2800      	cmp	r0, #0
c0d0365e:	d002      	beq.n	c0d03666 <__aeabi_uldivmod+0x16>
c0d03660:	2100      	movs	r1, #0
c0d03662:	43c9      	mvns	r1, r1
c0d03664:	1c08      	adds	r0, r1, #0
c0d03666:	b407      	push	{r0, r1, r2}
c0d03668:	4802      	ldr	r0, [pc, #8]	; (c0d03674 <__aeabi_uldivmod+0x24>)
c0d0366a:	a102      	add	r1, pc, #8	; (adr r1, c0d03674 <__aeabi_uldivmod+0x24>)
c0d0366c:	1840      	adds	r0, r0, r1
c0d0366e:	9002      	str	r0, [sp, #8]
c0d03670:	bd03      	pop	{r0, r1, pc}
c0d03672:	46c0      	nop			; (mov r8, r8)
c0d03674:	ffffffd9 	.word	0xffffffd9
c0d03678:	b403      	push	{r0, r1}
c0d0367a:	4668      	mov	r0, sp
c0d0367c:	b501      	push	{r0, lr}
c0d0367e:	9802      	ldr	r0, [sp, #8]
c0d03680:	f000 f806 	bl	c0d03690 <__udivmoddi4>
c0d03684:	9b01      	ldr	r3, [sp, #4]
c0d03686:	469e      	mov	lr, r3
c0d03688:	b002      	add	sp, #8
c0d0368a:	bc0c      	pop	{r2, r3}
c0d0368c:	4770      	bx	lr
c0d0368e:	46c0      	nop			; (mov r8, r8)

c0d03690 <__udivmoddi4>:
c0d03690:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03692:	464d      	mov	r5, r9
c0d03694:	4656      	mov	r6, sl
c0d03696:	4644      	mov	r4, r8
c0d03698:	465f      	mov	r7, fp
c0d0369a:	b4f0      	push	{r4, r5, r6, r7}
c0d0369c:	4692      	mov	sl, r2
c0d0369e:	b083      	sub	sp, #12
c0d036a0:	0004      	movs	r4, r0
c0d036a2:	000d      	movs	r5, r1
c0d036a4:	4699      	mov	r9, r3
c0d036a6:	428b      	cmp	r3, r1
c0d036a8:	d82f      	bhi.n	c0d0370a <__udivmoddi4+0x7a>
c0d036aa:	d02c      	beq.n	c0d03706 <__udivmoddi4+0x76>
c0d036ac:	4649      	mov	r1, r9
c0d036ae:	4650      	mov	r0, sl
c0d036b0:	f000 f8ae 	bl	c0d03810 <__clzdi2>
c0d036b4:	0029      	movs	r1, r5
c0d036b6:	0006      	movs	r6, r0
c0d036b8:	0020      	movs	r0, r4
c0d036ba:	f000 f8a9 	bl	c0d03810 <__clzdi2>
c0d036be:	1a33      	subs	r3, r6, r0
c0d036c0:	4698      	mov	r8, r3
c0d036c2:	3b20      	subs	r3, #32
c0d036c4:	469b      	mov	fp, r3
c0d036c6:	d500      	bpl.n	c0d036ca <__udivmoddi4+0x3a>
c0d036c8:	e074      	b.n	c0d037b4 <__udivmoddi4+0x124>
c0d036ca:	4653      	mov	r3, sl
c0d036cc:	465a      	mov	r2, fp
c0d036ce:	4093      	lsls	r3, r2
c0d036d0:	001f      	movs	r7, r3
c0d036d2:	4653      	mov	r3, sl
c0d036d4:	4642      	mov	r2, r8
c0d036d6:	4093      	lsls	r3, r2
c0d036d8:	001e      	movs	r6, r3
c0d036da:	42af      	cmp	r7, r5
c0d036dc:	d829      	bhi.n	c0d03732 <__udivmoddi4+0xa2>
c0d036de:	d026      	beq.n	c0d0372e <__udivmoddi4+0x9e>
c0d036e0:	465b      	mov	r3, fp
c0d036e2:	1ba4      	subs	r4, r4, r6
c0d036e4:	41bd      	sbcs	r5, r7
c0d036e6:	2b00      	cmp	r3, #0
c0d036e8:	da00      	bge.n	c0d036ec <__udivmoddi4+0x5c>
c0d036ea:	e079      	b.n	c0d037e0 <__udivmoddi4+0x150>
c0d036ec:	2200      	movs	r2, #0
c0d036ee:	2300      	movs	r3, #0
c0d036f0:	9200      	str	r2, [sp, #0]
c0d036f2:	9301      	str	r3, [sp, #4]
c0d036f4:	2301      	movs	r3, #1
c0d036f6:	465a      	mov	r2, fp
c0d036f8:	4093      	lsls	r3, r2
c0d036fa:	9301      	str	r3, [sp, #4]
c0d036fc:	2301      	movs	r3, #1
c0d036fe:	4642      	mov	r2, r8
c0d03700:	4093      	lsls	r3, r2
c0d03702:	9300      	str	r3, [sp, #0]
c0d03704:	e019      	b.n	c0d0373a <__udivmoddi4+0xaa>
c0d03706:	4282      	cmp	r2, r0
c0d03708:	d9d0      	bls.n	c0d036ac <__udivmoddi4+0x1c>
c0d0370a:	2200      	movs	r2, #0
c0d0370c:	2300      	movs	r3, #0
c0d0370e:	9200      	str	r2, [sp, #0]
c0d03710:	9301      	str	r3, [sp, #4]
c0d03712:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d03714:	2b00      	cmp	r3, #0
c0d03716:	d001      	beq.n	c0d0371c <__udivmoddi4+0x8c>
c0d03718:	601c      	str	r4, [r3, #0]
c0d0371a:	605d      	str	r5, [r3, #4]
c0d0371c:	9800      	ldr	r0, [sp, #0]
c0d0371e:	9901      	ldr	r1, [sp, #4]
c0d03720:	b003      	add	sp, #12
c0d03722:	bc3c      	pop	{r2, r3, r4, r5}
c0d03724:	4690      	mov	r8, r2
c0d03726:	4699      	mov	r9, r3
c0d03728:	46a2      	mov	sl, r4
c0d0372a:	46ab      	mov	fp, r5
c0d0372c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0372e:	42a3      	cmp	r3, r4
c0d03730:	d9d6      	bls.n	c0d036e0 <__udivmoddi4+0x50>
c0d03732:	2200      	movs	r2, #0
c0d03734:	2300      	movs	r3, #0
c0d03736:	9200      	str	r2, [sp, #0]
c0d03738:	9301      	str	r3, [sp, #4]
c0d0373a:	4643      	mov	r3, r8
c0d0373c:	2b00      	cmp	r3, #0
c0d0373e:	d0e8      	beq.n	c0d03712 <__udivmoddi4+0x82>
c0d03740:	07fb      	lsls	r3, r7, #31
c0d03742:	0872      	lsrs	r2, r6, #1
c0d03744:	431a      	orrs	r2, r3
c0d03746:	4646      	mov	r6, r8
c0d03748:	087b      	lsrs	r3, r7, #1
c0d0374a:	e00e      	b.n	c0d0376a <__udivmoddi4+0xda>
c0d0374c:	42ab      	cmp	r3, r5
c0d0374e:	d101      	bne.n	c0d03754 <__udivmoddi4+0xc4>
c0d03750:	42a2      	cmp	r2, r4
c0d03752:	d80c      	bhi.n	c0d0376e <__udivmoddi4+0xde>
c0d03754:	1aa4      	subs	r4, r4, r2
c0d03756:	419d      	sbcs	r5, r3
c0d03758:	2001      	movs	r0, #1
c0d0375a:	1924      	adds	r4, r4, r4
c0d0375c:	416d      	adcs	r5, r5
c0d0375e:	2100      	movs	r1, #0
c0d03760:	3e01      	subs	r6, #1
c0d03762:	1824      	adds	r4, r4, r0
c0d03764:	414d      	adcs	r5, r1
c0d03766:	2e00      	cmp	r6, #0
c0d03768:	d006      	beq.n	c0d03778 <__udivmoddi4+0xe8>
c0d0376a:	42ab      	cmp	r3, r5
c0d0376c:	d9ee      	bls.n	c0d0374c <__udivmoddi4+0xbc>
c0d0376e:	3e01      	subs	r6, #1
c0d03770:	1924      	adds	r4, r4, r4
c0d03772:	416d      	adcs	r5, r5
c0d03774:	2e00      	cmp	r6, #0
c0d03776:	d1f8      	bne.n	c0d0376a <__udivmoddi4+0xda>
c0d03778:	465b      	mov	r3, fp
c0d0377a:	9800      	ldr	r0, [sp, #0]
c0d0377c:	9901      	ldr	r1, [sp, #4]
c0d0377e:	1900      	adds	r0, r0, r4
c0d03780:	4169      	adcs	r1, r5
c0d03782:	2b00      	cmp	r3, #0
c0d03784:	db22      	blt.n	c0d037cc <__udivmoddi4+0x13c>
c0d03786:	002b      	movs	r3, r5
c0d03788:	465a      	mov	r2, fp
c0d0378a:	40d3      	lsrs	r3, r2
c0d0378c:	002a      	movs	r2, r5
c0d0378e:	4644      	mov	r4, r8
c0d03790:	40e2      	lsrs	r2, r4
c0d03792:	001c      	movs	r4, r3
c0d03794:	465b      	mov	r3, fp
c0d03796:	0015      	movs	r5, r2
c0d03798:	2b00      	cmp	r3, #0
c0d0379a:	db2c      	blt.n	c0d037f6 <__udivmoddi4+0x166>
c0d0379c:	0026      	movs	r6, r4
c0d0379e:	409e      	lsls	r6, r3
c0d037a0:	0033      	movs	r3, r6
c0d037a2:	0026      	movs	r6, r4
c0d037a4:	4647      	mov	r7, r8
c0d037a6:	40be      	lsls	r6, r7
c0d037a8:	0032      	movs	r2, r6
c0d037aa:	1a80      	subs	r0, r0, r2
c0d037ac:	4199      	sbcs	r1, r3
c0d037ae:	9000      	str	r0, [sp, #0]
c0d037b0:	9101      	str	r1, [sp, #4]
c0d037b2:	e7ae      	b.n	c0d03712 <__udivmoddi4+0x82>
c0d037b4:	4642      	mov	r2, r8
c0d037b6:	2320      	movs	r3, #32
c0d037b8:	1a9b      	subs	r3, r3, r2
c0d037ba:	4652      	mov	r2, sl
c0d037bc:	40da      	lsrs	r2, r3
c0d037be:	4641      	mov	r1, r8
c0d037c0:	0013      	movs	r3, r2
c0d037c2:	464a      	mov	r2, r9
c0d037c4:	408a      	lsls	r2, r1
c0d037c6:	0017      	movs	r7, r2
c0d037c8:	431f      	orrs	r7, r3
c0d037ca:	e782      	b.n	c0d036d2 <__udivmoddi4+0x42>
c0d037cc:	4642      	mov	r2, r8
c0d037ce:	2320      	movs	r3, #32
c0d037d0:	1a9b      	subs	r3, r3, r2
c0d037d2:	002a      	movs	r2, r5
c0d037d4:	4646      	mov	r6, r8
c0d037d6:	409a      	lsls	r2, r3
c0d037d8:	0023      	movs	r3, r4
c0d037da:	40f3      	lsrs	r3, r6
c0d037dc:	4313      	orrs	r3, r2
c0d037de:	e7d5      	b.n	c0d0378c <__udivmoddi4+0xfc>
c0d037e0:	4642      	mov	r2, r8
c0d037e2:	2320      	movs	r3, #32
c0d037e4:	2100      	movs	r1, #0
c0d037e6:	1a9b      	subs	r3, r3, r2
c0d037e8:	2200      	movs	r2, #0
c0d037ea:	9100      	str	r1, [sp, #0]
c0d037ec:	9201      	str	r2, [sp, #4]
c0d037ee:	2201      	movs	r2, #1
c0d037f0:	40da      	lsrs	r2, r3
c0d037f2:	9201      	str	r2, [sp, #4]
c0d037f4:	e782      	b.n	c0d036fc <__udivmoddi4+0x6c>
c0d037f6:	4642      	mov	r2, r8
c0d037f8:	2320      	movs	r3, #32
c0d037fa:	0026      	movs	r6, r4
c0d037fc:	1a9b      	subs	r3, r3, r2
c0d037fe:	40de      	lsrs	r6, r3
c0d03800:	002f      	movs	r7, r5
c0d03802:	46b4      	mov	ip, r6
c0d03804:	4097      	lsls	r7, r2
c0d03806:	4666      	mov	r6, ip
c0d03808:	003b      	movs	r3, r7
c0d0380a:	4333      	orrs	r3, r6
c0d0380c:	e7c9      	b.n	c0d037a2 <__udivmoddi4+0x112>
c0d0380e:	46c0      	nop			; (mov r8, r8)

c0d03810 <__clzdi2>:
c0d03810:	b510      	push	{r4, lr}
c0d03812:	2900      	cmp	r1, #0
c0d03814:	d103      	bne.n	c0d0381e <__clzdi2+0xe>
c0d03816:	f000 f807 	bl	c0d03828 <__clzsi2>
c0d0381a:	3020      	adds	r0, #32
c0d0381c:	e002      	b.n	c0d03824 <__clzdi2+0x14>
c0d0381e:	1c08      	adds	r0, r1, #0
c0d03820:	f000 f802 	bl	c0d03828 <__clzsi2>
c0d03824:	bd10      	pop	{r4, pc}
c0d03826:	46c0      	nop			; (mov r8, r8)

c0d03828 <__clzsi2>:
c0d03828:	211c      	movs	r1, #28
c0d0382a:	2301      	movs	r3, #1
c0d0382c:	041b      	lsls	r3, r3, #16
c0d0382e:	4298      	cmp	r0, r3
c0d03830:	d301      	bcc.n	c0d03836 <__clzsi2+0xe>
c0d03832:	0c00      	lsrs	r0, r0, #16
c0d03834:	3910      	subs	r1, #16
c0d03836:	0a1b      	lsrs	r3, r3, #8
c0d03838:	4298      	cmp	r0, r3
c0d0383a:	d301      	bcc.n	c0d03840 <__clzsi2+0x18>
c0d0383c:	0a00      	lsrs	r0, r0, #8
c0d0383e:	3908      	subs	r1, #8
c0d03840:	091b      	lsrs	r3, r3, #4
c0d03842:	4298      	cmp	r0, r3
c0d03844:	d301      	bcc.n	c0d0384a <__clzsi2+0x22>
c0d03846:	0900      	lsrs	r0, r0, #4
c0d03848:	3904      	subs	r1, #4
c0d0384a:	a202      	add	r2, pc, #8	; (adr r2, c0d03854 <__clzsi2+0x2c>)
c0d0384c:	5c10      	ldrb	r0, [r2, r0]
c0d0384e:	1840      	adds	r0, r0, r1
c0d03850:	4770      	bx	lr
c0d03852:	46c0      	nop			; (mov r8, r8)
c0d03854:	02020304 	.word	0x02020304
c0d03858:	01010101 	.word	0x01010101
	...

c0d03864 <__aeabi_memclr>:
c0d03864:	b510      	push	{r4, lr}
c0d03866:	2200      	movs	r2, #0
c0d03868:	f000 f806 	bl	c0d03878 <__aeabi_memset>
c0d0386c:	bd10      	pop	{r4, pc}
c0d0386e:	46c0      	nop			; (mov r8, r8)

c0d03870 <__aeabi_memcpy>:
c0d03870:	b510      	push	{r4, lr}
c0d03872:	f000 f809 	bl	c0d03888 <memcpy>
c0d03876:	bd10      	pop	{r4, pc}

c0d03878 <__aeabi_memset>:
c0d03878:	0013      	movs	r3, r2
c0d0387a:	b510      	push	{r4, lr}
c0d0387c:	000a      	movs	r2, r1
c0d0387e:	0019      	movs	r1, r3
c0d03880:	f000 f840 	bl	c0d03904 <memset>
c0d03884:	bd10      	pop	{r4, pc}
c0d03886:	46c0      	nop			; (mov r8, r8)

c0d03888 <memcpy>:
c0d03888:	b570      	push	{r4, r5, r6, lr}
c0d0388a:	2a0f      	cmp	r2, #15
c0d0388c:	d932      	bls.n	c0d038f4 <memcpy+0x6c>
c0d0388e:	000c      	movs	r4, r1
c0d03890:	4304      	orrs	r4, r0
c0d03892:	000b      	movs	r3, r1
c0d03894:	07a4      	lsls	r4, r4, #30
c0d03896:	d131      	bne.n	c0d038fc <memcpy+0x74>
c0d03898:	0015      	movs	r5, r2
c0d0389a:	0004      	movs	r4, r0
c0d0389c:	3d10      	subs	r5, #16
c0d0389e:	092d      	lsrs	r5, r5, #4
c0d038a0:	3501      	adds	r5, #1
c0d038a2:	012d      	lsls	r5, r5, #4
c0d038a4:	1949      	adds	r1, r1, r5
c0d038a6:	681e      	ldr	r6, [r3, #0]
c0d038a8:	6026      	str	r6, [r4, #0]
c0d038aa:	685e      	ldr	r6, [r3, #4]
c0d038ac:	6066      	str	r6, [r4, #4]
c0d038ae:	689e      	ldr	r6, [r3, #8]
c0d038b0:	60a6      	str	r6, [r4, #8]
c0d038b2:	68de      	ldr	r6, [r3, #12]
c0d038b4:	3310      	adds	r3, #16
c0d038b6:	60e6      	str	r6, [r4, #12]
c0d038b8:	3410      	adds	r4, #16
c0d038ba:	4299      	cmp	r1, r3
c0d038bc:	d1f3      	bne.n	c0d038a6 <memcpy+0x1e>
c0d038be:	230f      	movs	r3, #15
c0d038c0:	1945      	adds	r5, r0, r5
c0d038c2:	4013      	ands	r3, r2
c0d038c4:	2b03      	cmp	r3, #3
c0d038c6:	d91b      	bls.n	c0d03900 <memcpy+0x78>
c0d038c8:	1f1c      	subs	r4, r3, #4
c0d038ca:	2300      	movs	r3, #0
c0d038cc:	08a4      	lsrs	r4, r4, #2
c0d038ce:	3401      	adds	r4, #1
c0d038d0:	00a4      	lsls	r4, r4, #2
c0d038d2:	58ce      	ldr	r6, [r1, r3]
c0d038d4:	50ee      	str	r6, [r5, r3]
c0d038d6:	3304      	adds	r3, #4
c0d038d8:	429c      	cmp	r4, r3
c0d038da:	d1fa      	bne.n	c0d038d2 <memcpy+0x4a>
c0d038dc:	2303      	movs	r3, #3
c0d038de:	192d      	adds	r5, r5, r4
c0d038e0:	1909      	adds	r1, r1, r4
c0d038e2:	401a      	ands	r2, r3
c0d038e4:	d005      	beq.n	c0d038f2 <memcpy+0x6a>
c0d038e6:	2300      	movs	r3, #0
c0d038e8:	5ccc      	ldrb	r4, [r1, r3]
c0d038ea:	54ec      	strb	r4, [r5, r3]
c0d038ec:	3301      	adds	r3, #1
c0d038ee:	429a      	cmp	r2, r3
c0d038f0:	d1fa      	bne.n	c0d038e8 <memcpy+0x60>
c0d038f2:	bd70      	pop	{r4, r5, r6, pc}
c0d038f4:	0005      	movs	r5, r0
c0d038f6:	2a00      	cmp	r2, #0
c0d038f8:	d1f5      	bne.n	c0d038e6 <memcpy+0x5e>
c0d038fa:	e7fa      	b.n	c0d038f2 <memcpy+0x6a>
c0d038fc:	0005      	movs	r5, r0
c0d038fe:	e7f2      	b.n	c0d038e6 <memcpy+0x5e>
c0d03900:	001a      	movs	r2, r3
c0d03902:	e7f8      	b.n	c0d038f6 <memcpy+0x6e>

c0d03904 <memset>:
c0d03904:	b570      	push	{r4, r5, r6, lr}
c0d03906:	0783      	lsls	r3, r0, #30
c0d03908:	d03f      	beq.n	c0d0398a <memset+0x86>
c0d0390a:	1e54      	subs	r4, r2, #1
c0d0390c:	2a00      	cmp	r2, #0
c0d0390e:	d03b      	beq.n	c0d03988 <memset+0x84>
c0d03910:	b2ce      	uxtb	r6, r1
c0d03912:	0003      	movs	r3, r0
c0d03914:	2503      	movs	r5, #3
c0d03916:	e003      	b.n	c0d03920 <memset+0x1c>
c0d03918:	1e62      	subs	r2, r4, #1
c0d0391a:	2c00      	cmp	r4, #0
c0d0391c:	d034      	beq.n	c0d03988 <memset+0x84>
c0d0391e:	0014      	movs	r4, r2
c0d03920:	3301      	adds	r3, #1
c0d03922:	1e5a      	subs	r2, r3, #1
c0d03924:	7016      	strb	r6, [r2, #0]
c0d03926:	422b      	tst	r3, r5
c0d03928:	d1f6      	bne.n	c0d03918 <memset+0x14>
c0d0392a:	2c03      	cmp	r4, #3
c0d0392c:	d924      	bls.n	c0d03978 <memset+0x74>
c0d0392e:	25ff      	movs	r5, #255	; 0xff
c0d03930:	400d      	ands	r5, r1
c0d03932:	022a      	lsls	r2, r5, #8
c0d03934:	4315      	orrs	r5, r2
c0d03936:	042a      	lsls	r2, r5, #16
c0d03938:	4315      	orrs	r5, r2
c0d0393a:	2c0f      	cmp	r4, #15
c0d0393c:	d911      	bls.n	c0d03962 <memset+0x5e>
c0d0393e:	0026      	movs	r6, r4
c0d03940:	3e10      	subs	r6, #16
c0d03942:	0936      	lsrs	r6, r6, #4
c0d03944:	3601      	adds	r6, #1
c0d03946:	0136      	lsls	r6, r6, #4
c0d03948:	001a      	movs	r2, r3
c0d0394a:	199b      	adds	r3, r3, r6
c0d0394c:	6015      	str	r5, [r2, #0]
c0d0394e:	6055      	str	r5, [r2, #4]
c0d03950:	6095      	str	r5, [r2, #8]
c0d03952:	60d5      	str	r5, [r2, #12]
c0d03954:	3210      	adds	r2, #16
c0d03956:	4293      	cmp	r3, r2
c0d03958:	d1f8      	bne.n	c0d0394c <memset+0x48>
c0d0395a:	220f      	movs	r2, #15
c0d0395c:	4014      	ands	r4, r2
c0d0395e:	2c03      	cmp	r4, #3
c0d03960:	d90a      	bls.n	c0d03978 <memset+0x74>
c0d03962:	1f26      	subs	r6, r4, #4
c0d03964:	08b6      	lsrs	r6, r6, #2
c0d03966:	3601      	adds	r6, #1
c0d03968:	00b6      	lsls	r6, r6, #2
c0d0396a:	001a      	movs	r2, r3
c0d0396c:	199b      	adds	r3, r3, r6
c0d0396e:	c220      	stmia	r2!, {r5}
c0d03970:	4293      	cmp	r3, r2
c0d03972:	d1fc      	bne.n	c0d0396e <memset+0x6a>
c0d03974:	2203      	movs	r2, #3
c0d03976:	4014      	ands	r4, r2
c0d03978:	2c00      	cmp	r4, #0
c0d0397a:	d005      	beq.n	c0d03988 <memset+0x84>
c0d0397c:	b2c9      	uxtb	r1, r1
c0d0397e:	191c      	adds	r4, r3, r4
c0d03980:	7019      	strb	r1, [r3, #0]
c0d03982:	3301      	adds	r3, #1
c0d03984:	429c      	cmp	r4, r3
c0d03986:	d1fb      	bne.n	c0d03980 <memset+0x7c>
c0d03988:	bd70      	pop	{r4, r5, r6, pc}
c0d0398a:	0014      	movs	r4, r2
c0d0398c:	0003      	movs	r3, r0
c0d0398e:	e7cc      	b.n	c0d0392a <memset+0x26>

c0d03990 <setjmp>:
c0d03990:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d03992:	4641      	mov	r1, r8
c0d03994:	464a      	mov	r2, r9
c0d03996:	4653      	mov	r3, sl
c0d03998:	465c      	mov	r4, fp
c0d0399a:	466d      	mov	r5, sp
c0d0399c:	4676      	mov	r6, lr
c0d0399e:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d039a0:	3828      	subs	r0, #40	; 0x28
c0d039a2:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d039a4:	2000      	movs	r0, #0
c0d039a6:	4770      	bx	lr

c0d039a8 <longjmp>:
c0d039a8:	3010      	adds	r0, #16
c0d039aa:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d039ac:	4690      	mov	r8, r2
c0d039ae:	4699      	mov	r9, r3
c0d039b0:	46a2      	mov	sl, r4
c0d039b2:	46ab      	mov	fp, r5
c0d039b4:	46b5      	mov	sp, r6
c0d039b6:	c808      	ldmia	r0!, {r3}
c0d039b8:	3828      	subs	r0, #40	; 0x28
c0d039ba:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d039bc:	1c08      	adds	r0, r1, #0
c0d039be:	d100      	bne.n	c0d039c2 <longjmp+0x1a>
c0d039c0:	2001      	movs	r0, #1
c0d039c2:	4718      	bx	r3

c0d039c4 <strlen>:
c0d039c4:	b510      	push	{r4, lr}
c0d039c6:	0783      	lsls	r3, r0, #30
c0d039c8:	d027      	beq.n	c0d03a1a <strlen+0x56>
c0d039ca:	7803      	ldrb	r3, [r0, #0]
c0d039cc:	2b00      	cmp	r3, #0
c0d039ce:	d026      	beq.n	c0d03a1e <strlen+0x5a>
c0d039d0:	0003      	movs	r3, r0
c0d039d2:	2103      	movs	r1, #3
c0d039d4:	e002      	b.n	c0d039dc <strlen+0x18>
c0d039d6:	781a      	ldrb	r2, [r3, #0]
c0d039d8:	2a00      	cmp	r2, #0
c0d039da:	d01c      	beq.n	c0d03a16 <strlen+0x52>
c0d039dc:	3301      	adds	r3, #1
c0d039de:	420b      	tst	r3, r1
c0d039e0:	d1f9      	bne.n	c0d039d6 <strlen+0x12>
c0d039e2:	6819      	ldr	r1, [r3, #0]
c0d039e4:	4a0f      	ldr	r2, [pc, #60]	; (c0d03a24 <strlen+0x60>)
c0d039e6:	4c10      	ldr	r4, [pc, #64]	; (c0d03a28 <strlen+0x64>)
c0d039e8:	188a      	adds	r2, r1, r2
c0d039ea:	438a      	bics	r2, r1
c0d039ec:	4222      	tst	r2, r4
c0d039ee:	d10f      	bne.n	c0d03a10 <strlen+0x4c>
c0d039f0:	3304      	adds	r3, #4
c0d039f2:	6819      	ldr	r1, [r3, #0]
c0d039f4:	4a0b      	ldr	r2, [pc, #44]	; (c0d03a24 <strlen+0x60>)
c0d039f6:	188a      	adds	r2, r1, r2
c0d039f8:	438a      	bics	r2, r1
c0d039fa:	4222      	tst	r2, r4
c0d039fc:	d108      	bne.n	c0d03a10 <strlen+0x4c>
c0d039fe:	3304      	adds	r3, #4
c0d03a00:	6819      	ldr	r1, [r3, #0]
c0d03a02:	4a08      	ldr	r2, [pc, #32]	; (c0d03a24 <strlen+0x60>)
c0d03a04:	188a      	adds	r2, r1, r2
c0d03a06:	438a      	bics	r2, r1
c0d03a08:	4222      	tst	r2, r4
c0d03a0a:	d0f1      	beq.n	c0d039f0 <strlen+0x2c>
c0d03a0c:	e000      	b.n	c0d03a10 <strlen+0x4c>
c0d03a0e:	3301      	adds	r3, #1
c0d03a10:	781a      	ldrb	r2, [r3, #0]
c0d03a12:	2a00      	cmp	r2, #0
c0d03a14:	d1fb      	bne.n	c0d03a0e <strlen+0x4a>
c0d03a16:	1a18      	subs	r0, r3, r0
c0d03a18:	bd10      	pop	{r4, pc}
c0d03a1a:	0003      	movs	r3, r0
c0d03a1c:	e7e1      	b.n	c0d039e2 <strlen+0x1e>
c0d03a1e:	2000      	movs	r0, #0
c0d03a20:	e7fa      	b.n	c0d03a18 <strlen+0x54>
c0d03a22:	46c0      	nop			; (mov r8, r8)
c0d03a24:	fefefeff 	.word	0xfefefeff
c0d03a28:	80808080 	.word	0x80808080

c0d03a2c <HALF_3>:
c0d03a2c:	f16b9c2d dd01633c 3d8cf0ee b09a028b     -.k.<c.....=....
c0d03a3c:	246cd94a f1c6d805 6cee5506 da330aa3     J.l$.....U.l..3.
c0d03a4c:	fde381a1 fe13f810 f97f039e 1b3dc3ce     ..............=.
c0d03a5c:	00000001                                ....

c0d03a60 <bagl_ui_nanos_screen1>:
c0d03a60:	00000003 00800000 00000020 00000001     ........ .......
c0d03a70:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03a98:	00000107 0080000c 00000020 00000000     ........ .......
c0d03aa8:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03ad0:	00030005 0007000c 00000007 00000000     ................
	...
c0d03ae8:	00070000 00000000 00000000 00000000     ................
	...
c0d03b08:	00750005 0008000d 00000006 00000000     ..u.............
c0d03b18:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03b40 <bagl_ui_nanos_screen2>:
c0d03b40:	00000003 00800000 00000020 00000001     ........ .......
c0d03b50:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03b78:	00000107 00800012 00000020 00000000     ........ .......
c0d03b88:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03bb0:	00030005 0007000c 00000007 00000000     ................
	...
c0d03bc8:	00070000 00000000 00000000 00000000     ................
	...
c0d03be8:	00750005 0008000d 00000006 00000000     ..u.............
c0d03bf8:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03c20 <bagl_ui_sample_blue>:
c0d03c20:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03c30:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03c58:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03c68:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03c90:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03ca0:	00ffffff 001d2028 00002004 c0d03d00     ....( ... ...=..
	...
c0d03cc8:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03cd8:	0041ccb4 00f9f9f9 0000a004 c0d03d0c     ..A..........=..
c0d03ce8:	00000000 0037ae99 00f9f9f9 c0d02635     ......7.....5&..
	...
c0d03d00:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03d11 <USBD_PRODUCT_FS_STRING>:
c0d03d11:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d03d1f <HID_ReportDesc>:
c0d03d1f:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d03d2f:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d03d3f:	0000c008 11210900                                .....

c0d03d44 <USBD_HID_Desc>:
c0d03d44:	01112109 22220100 00011200                       .!...."".

c0d03d4d <USBD_DeviceDesc>:
c0d03d4d:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03d5d:	45000103                                         ...

c0d03d60 <HID_Desc>:
c0d03d60:	c0d03245 c0d03255 c0d03265 c0d03275     E2..U2..e2..u2..
c0d03d70:	c0d03285 c0d03295 c0d032a5 00000000     .2...2...2......

c0d03d80 <USBD_LangIDDesc>:
c0d03d80:	04090304                                ....

c0d03d84 <USBD_MANUFACTURER_STRING>:
c0d03d84:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03d92 <USB_SERIAL_STRING>:
c0d03d92:	0030030a 00300030 31270031                       ..0.0.0.1.

c0d03d9c <USBD_HID>:
c0d03d9c:	c0d03127 c0d03159 c0d0308b 00000000     '1..Y1...0......
	...
c0d03db4:	c0d03191 00000000 00000000 00000000     .1..............
c0d03dc4:	c0d032b5 c0d032b5 c0d032b5 c0d032c5     .2...2...2...2..

c0d03dd4 <USBD_CfgDesc>:
c0d03dd4:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03de4:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03df4:	05070100 00400302 00000001              ......@.....

c0d03e00 <USBD_DeviceQualifierDesc>:
c0d03e00:	0200060a 40000000 00000001              .......@....

c0d03e0c <_etext>:
	...

c0d03e40 <N_storage_real>:
	...
