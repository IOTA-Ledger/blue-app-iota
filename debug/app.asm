
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
c0d00014:	f001 f950 	bl	c0d012b8 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f001 f89c 	bl	c0d01154 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 fd01 	bl	c0d03a2c <setjmp>
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
c0d00040:	f001 fae0 	bl	c0d01604 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 ffc1 	bl	c0d01fcc <pic>
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
c0d0005a:	f001 ffb7 	bl	c0d01fcc <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f002 f805 	bl	c0d02070 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f003 f90c 	bl	c0d03284 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f003 f909 	bl	c0d03284 <USB_power>

            ui_idle();
c0d00072:	f002 fa9d 	bl	c0d025b0 <ui_idle>

            IOTA_main();
c0d00076:	f000 ff05 	bl	c0d00e84 <IOTA_main>
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
c0d0008c:	f003 fcda 	bl	c0d03a44 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d03ec0 	.word	0xc0d03ec0

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
c0d000c8:	f003 fa20 	bl	c0d0350c <__aeabi_uidivmod>
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
c0d000e6:	f003 f98b 	bl	c0d03400 <__aeabi_uidiv>
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
c0d00114:	f000 f94a 	bl	c0d003ac <trint_to_trits>
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
c0d00156:	f003 f953 	bl	c0d03400 <__aeabi_uidiv>
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
c0d0017e:	f000 fc5d 	bl	c0d00a3c <kerl_initialize>
c0d00182:	2631      	movs	r6, #49	; 0x31
    kerl_absorb_trints(&seed_trints[0], 49);
c0d00184:	4628      	mov	r0, r5
c0d00186:	4631      	mov	r1, r6
c0d00188:	f000 fc78 	bl	c0d00a7c <kerl_absorb_trints>
c0d0018c:	9400      	str	r4, [sp, #0]
    kerl_squeeze_trints(&private_key[0], 49);
c0d0018e:	4620      	mov	r0, r4
c0d00190:	4631      	mov	r1, r6
c0d00192:	f000 fca3 	bl	c0d00adc <kerl_squeeze_trints>
    
    kerl_initialize();
c0d00196:	f000 fc51 	bl	c0d00a3c <kerl_initialize>
    kerl_absorb_trints(&seed_trints[0], 49);
c0d0019a:	4628      	mov	r0, r5
c0d0019c:	4631      	mov	r1, r6
c0d0019e:	f000 fc6d 	bl	c0d00a7c <kerl_absorb_trints>
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
c0d001b2:	f000 fc93 	bl	c0d00adc <kerl_squeeze_trints>
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
c0d001f4:	f000 fc22 	bl	c0d00a3c <kerl_initialize>
c0d001f8:	251b      	movs	r5, #27
c0d001fa:	9401      	str	r4, [sp, #4]
c0d001fc:	2631      	movs	r6, #49	; 0x31
            kerl_absorb_trints(&private_key[j*49], 49);
c0d001fe:	4620      	mov	r0, r4
c0d00200:	4631      	mov	r1, r6
c0d00202:	f000 fc3b 	bl	c0d00a7c <kerl_absorb_trints>
            kerl_squeeze_trints(&private_key[j*49], 49);
c0d00206:	4620      	mov	r0, r4
c0d00208:	4631      	mov	r1, r6
c0d0020a:	f000 fc67 	bl	c0d00adc <kerl_squeeze_trints>
    for(uint8_t j = 0; j < 27; j++) {
        // each piece get's kerl'd 26 times(?)
        for(uint8_t k = 0; k < 26; k++) {
            //temp set k=25 to make this a LOT faster
            k = 25;
            kerl_initialize();
c0d0020e:	f000 fc15 	bl	c0d00a3c <kerl_initialize>

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
c0d00220:	f000 fc2c 	bl	c0d00a7c <kerl_absorb_trints>
    
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
c0d00236:	f000 fc51 	bl	c0d00adc <kerl_squeeze_trints>
        
        //now get address
        kerl_initialize();
c0d0023a:	f000 fbff 	bl	c0d00a3c <kerl_initialize>
c0d0023e:	9d02      	ldr	r5, [sp, #8]
        //address out stores first half, private key stores second half
        kerl_absorb_trints(address_out, 49);
c0d00240:	4628      	mov	r0, r5
c0d00242:	4621      	mov	r1, r4
c0d00244:	f000 fc1a 	bl	c0d00a7c <kerl_absorb_trints>
        kerl_absorb_trints(private_key, 49);
c0d00248:	4630      	mov	r0, r6
c0d0024a:	4621      	mov	r1, r4
c0d0024c:	f000 fc16 	bl	c0d00a7c <kerl_absorb_trints>
        //finally publish the public key
        kerl_squeeze_trints(address_out, 49);
c0d00250:	4628      	mov	r0, r5
c0d00252:	4621      	mov	r1, r4
c0d00254:	f000 fc42 	bl	c0d00adc <kerl_squeeze_trints>
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
c0d0028a:	f001 fc4f 	bl	c0d01b2c <snprintf>
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
c0d002da:	b089      	sub	sp, #36	; 0x24
c0d002dc:	460c      	mov	r4, r1
c0d002de:	9001      	str	r0, [sp, #4]
c0d002e0:	2200      	movs	r2, #0
c0d002e2:	9400      	str	r4, [sp, #0]
    for(uint8_t i = 0; i < 48; i++) {
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
c0d002e4:	9801      	ldr	r0, [sp, #4]
c0d002e6:	9203      	str	r2, [sp, #12]
c0d002e8:	5c82      	ldrb	r2, [r0, r2]
c0d002ea:	20ff      	movs	r0, #255	; 0xff
c0d002ec:	9005      	str	r0, [sp, #20]
c0d002ee:	0600      	lsls	r0, r0, #24
c0d002f0:	9004      	str	r0, [sp, #16]
c0d002f2:	2001      	movs	r0, #1
c0d002f4:	9006      	str	r0, [sp, #24]
c0d002f6:	0600      	lsls	r0, r0, #24
c0d002f8:	9007      	str	r0, [sp, #28]
c0d002fa:	2051      	movs	r0, #81	; 0x51
c0d002fc:	2505      	movs	r5, #5
c0d002fe:	9402      	str	r4, [sp, #8]
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d00300:	b2c6      	uxtb	r6, r0
c0d00302:	b250      	sxtb	r0, r2
c0d00304:	9008      	str	r0, [sp, #32]
c0d00306:	0040      	lsls	r0, r0, #1
c0d00308:	4631      	mov	r1, r6
c0d0030a:	f003 f903 	bl	c0d03514 <__aeabi_idiv>
c0d0030e:	7020      	strb	r0, [r4, #0]


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d00310:	0602      	lsls	r2, r0, #24
c0d00312:	9907      	ldr	r1, [sp, #28]
c0d00314:	428a      	cmp	r2, r1
c0d00316:	9906      	ldr	r1, [sp, #24]
c0d00318:	dc03      	bgt.n	c0d00322 <specific_49trints_to_243trits+0x4c>
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d0031a:	9904      	ldr	r1, [sp, #16]
c0d0031c:	428a      	cmp	r2, r1
c0d0031e:	9905      	ldr	r1, [sp, #20]
c0d00320:	da01      	bge.n	c0d00326 <specific_49trints_to_243trits+0x50>
c0d00322:	7021      	strb	r1, [r4, #0]
c0d00324:	e000      	b.n	c0d00328 <specific_49trints_to_243trits+0x52>

        integ -= trits_r[j] * pow3_val;
c0d00326:	4601      	mov	r1, r0
c0d00328:	9a08      	ldr	r2, [sp, #32]
c0d0032a:	b248      	sxtb	r0, r1
c0d0032c:	4370      	muls	r0, r6
c0d0032e:	1a10      	subs	r0, r2, r0
        pow3_val /= 3;
c0d00330:	9008      	str	r0, [sp, #32]
c0d00332:	2103      	movs	r1, #3
c0d00334:	4630      	mov	r0, r6
c0d00336:	f003 f863 	bl	c0d03400 <__aeabi_uidiv>
c0d0033a:	9a08      	ldr	r2, [sp, #32]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d0033c:	1e6d      	subs	r5, r5, #1
c0d0033e:	1c64      	adds	r4, r4, #1
c0d00340:	2d00      	cmp	r5, #0
c0d00342:	d1dd      	bne.n	c0d00300 <specific_49trints_to_243trits+0x2a>
c0d00344:	9c02      	ldr	r4, [sp, #8]
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
    for(uint8_t i = 0; i < 48; i++) {
c0d00346:	1d64      	adds	r4, r4, #5
c0d00348:	9a03      	ldr	r2, [sp, #12]
c0d0034a:	1c52      	adds	r2, r2, #1
c0d0034c:	2a30      	cmp	r2, #48	; 0x30
c0d0034e:	d1c9      	bne.n	c0d002e4 <specific_49trints_to_243trits+0xe>
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
c0d00350:	2030      	movs	r0, #48	; 0x30
c0d00352:	9901      	ldr	r1, [sp, #4]
c0d00354:	5c0d      	ldrb	r5, [r1, r0]
c0d00356:	20ef      	movs	r0, #239	; 0xef
c0d00358:	43c4      	mvns	r4, r0
c0d0035a:	2009      	movs	r0, #9
c0d0035c:	9406      	str	r4, [sp, #24]
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d0035e:	b2c6      	uxtb	r6, r0
c0d00360:	b26d      	sxtb	r5, r5
c0d00362:	0068      	lsls	r0, r5, #1
c0d00364:	4631      	mov	r1, r6
c0d00366:	f003 f8d5 	bl	c0d03514 <__aeabi_idiv>
c0d0036a:	9906      	ldr	r1, [sp, #24]
c0d0036c:	31ef      	adds	r1, #239	; 0xef
c0d0036e:	4361      	muls	r1, r4
c0d00370:	9a00      	ldr	r2, [sp, #0]
c0d00372:	5450      	strb	r0, [r2, r1]
c0d00374:	1851      	adds	r1, r2, r1


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d00376:	9108      	str	r1, [sp, #32]
c0d00378:	0603      	lsls	r3, r0, #24
c0d0037a:	2101      	movs	r1, #1
c0d0037c:	9a07      	ldr	r2, [sp, #28]
c0d0037e:	4293      	cmp	r3, r2
c0d00380:	dc03      	bgt.n	c0d0038a <specific_49trints_to_243trits+0xb4>
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d00382:	9904      	ldr	r1, [sp, #16]
c0d00384:	428b      	cmp	r3, r1
c0d00386:	9905      	ldr	r1, [sp, #20]
c0d00388:	da02      	bge.n	c0d00390 <specific_49trints_to_243trits+0xba>
c0d0038a:	9808      	ldr	r0, [sp, #32]
c0d0038c:	7001      	strb	r1, [r0, #0]
c0d0038e:	e000      	b.n	c0d00392 <specific_49trints_to_243trits+0xbc>

        integ -= trits_r[j] * pow3_val;
c0d00390:	4601      	mov	r1, r0
c0d00392:	b248      	sxtb	r0, r1
c0d00394:	4370      	muls	r0, r6
c0d00396:	1a2d      	subs	r5, r5, r0
        pow3_val /= 3;
c0d00398:	2103      	movs	r1, #3
c0d0039a:	4630      	mov	r0, r6
c0d0039c:	f003 f830 	bl	c0d03400 <__aeabi_uidiv>
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d003a0:	1e64      	subs	r4, r4, #1
c0d003a2:	4621      	mov	r1, r4
c0d003a4:	31f3      	adds	r1, #243	; 0xf3
c0d003a6:	d1da      	bne.n	c0d0035e <specific_49trints_to_243trits+0x88>
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
}
c0d003a8:	b009      	add	sp, #36	; 0x24
c0d003aa:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d003ac <trint_to_trits>:

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) __attribute__((always_inline)) {
c0d003ac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003ae:	af03      	add	r7, sp, #12
c0d003b0:	b083      	sub	sp, #12
c0d003b2:	9100      	str	r1, [sp, #0]
c0d003b4:	4603      	mov	r3, r0
c0d003b6:	9201      	str	r2, [sp, #4]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d003b8:	2a01      	cmp	r2, #1
c0d003ba:	db2b      	blt.n	c0d00414 <trint_to_trits+0x68>
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) __attribute__((always_inline)) {
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
c0d003bc:	2009      	movs	r0, #9
c0d003be:	2151      	movs	r1, #81	; 0x51
c0d003c0:	9a01      	ldr	r2, [sp, #4]
c0d003c2:	2a03      	cmp	r2, #3
c0d003c4:	d000      	beq.n	c0d003c8 <trint_to_trits+0x1c>
c0d003c6:	4608      	mov	r0, r1
c0d003c8:	2500      	movs	r5, #0
c0d003ca:	462e      	mov	r6, r5
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d003cc:	b2c4      	uxtb	r4, r0
c0d003ce:	b258      	sxtb	r0, r3
c0d003d0:	9002      	str	r0, [sp, #8]
c0d003d2:	0040      	lsls	r0, r0, #1
c0d003d4:	4621      	mov	r1, r4
c0d003d6:	f003 f89d 	bl	c0d03514 <__aeabi_idiv>
c0d003da:	9900      	ldr	r1, [sp, #0]
c0d003dc:	5548      	strb	r0, [r1, r5]
c0d003de:	194a      	adds	r2, r1, r5


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d003e0:	0603      	lsls	r3, r0, #24
c0d003e2:	2101      	movs	r1, #1
c0d003e4:	060d      	lsls	r5, r1, #24
c0d003e6:	42ab      	cmp	r3, r5
c0d003e8:	dc03      	bgt.n	c0d003f2 <trint_to_trits+0x46>
c0d003ea:	21ff      	movs	r1, #255	; 0xff
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d003ec:	4d0a      	ldr	r5, [pc, #40]	; (c0d00418 <trint_to_trits+0x6c>)
c0d003ee:	42ab      	cmp	r3, r5
c0d003f0:	dc01      	bgt.n	c0d003f6 <trint_to_trits+0x4a>
c0d003f2:	7011      	strb	r1, [r2, #0]
c0d003f4:	e000      	b.n	c0d003f8 <trint_to_trits+0x4c>

        integ -= trits_r[j] * pow3_val;
c0d003f6:	4601      	mov	r1, r0
c0d003f8:	9a02      	ldr	r2, [sp, #8]
c0d003fa:	b248      	sxtb	r0, r1
c0d003fc:	4360      	muls	r0, r4
c0d003fe:	1a15      	subs	r5, r2, r0
        pow3_val /= 3;
c0d00400:	2103      	movs	r1, #3
c0d00402:	4620      	mov	r0, r4
c0d00404:	f002 fffc 	bl	c0d03400 <__aeabi_uidiv>
c0d00408:	462b      	mov	r3, r5
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d0040a:	1c76      	adds	r6, r6, #1
c0d0040c:	b2f5      	uxtb	r5, r6
c0d0040e:	9901      	ldr	r1, [sp, #4]
c0d00410:	428d      	cmp	r5, r1
c0d00412:	dbdb      	blt.n	c0d003cc <trint_to_trits+0x20>
        else if(trits_r[j] < -1) trits_r[j] = -1;

        integ -= trits_r[j] * pow3_val;
        pow3_val /= 3;
    }
}
c0d00414:	b003      	add	sp, #12
c0d00416:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00418:	feffffff 	.word	0xfeffffff

c0d0041c <get_seed>:
    return ret;
}

void do_nothing() {}

void get_seed(unsigned char *privateKey, uint8_t sz, char *msg) {
c0d0041c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0041e:	af03      	add	r7, sp, #12
c0d00420:	b08f      	sub	sp, #60	; 0x3c
c0d00422:	9201      	str	r2, [sp, #4]
c0d00424:	460e      	mov	r6, r1
c0d00426:	4605      	mov	r5, r0

    //kerl requires 424 bytes
    kerl_initialize();
c0d00428:	9500      	str	r5, [sp, #0]
c0d0042a:	f000 fb07 	bl	c0d00a3c <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d0042e:	f000 fb05 	bl	c0d00a3c <kerl_initialize>
c0d00432:	ac02      	add	r4, sp, #8

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d00434:	4620      	mov	r0, r4
c0d00436:	4629      	mov	r1, r5
c0d00438:	4632      	mov	r2, r6
c0d0043a:	f003 fa67 	bl	c0d0390c <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d0043e:	19a0      	adds	r0, r4, r6
c0d00440:	2530      	movs	r5, #48	; 0x30
c0d00442:	1baa      	subs	r2, r5, r6
c0d00444:	9900      	ldr	r1, [sp, #0]
c0d00446:	f003 fa61 	bl	c0d0390c <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d0044a:	4620      	mov	r0, r4
c0d0044c:	4629      	mov	r1, r5
c0d0044e:	f000 fb01 	bl	c0d00a54 <kerl_absorb_bytes>
c0d00452:	ac02      	add	r4, sp, #8
    }

    // A trint_t is 5 trits encoded as 1 int8_t - Used to massively
    // reduce RAM required
    trint_t seed_trints[49];
    kerl_squeeze_trints(&seed_trints[0], 49);
c0d00454:	2131      	movs	r1, #49	; 0x31
c0d00456:	4620      	mov	r0, r4
c0d00458:	f000 fb40 	bl	c0d00adc <kerl_squeeze_trints>

    //null terminate seed
    //seed_chars[81] = '\0';

    //pass trints to private key func and let it handle the response
    get_private_key(&seed_trints[0], 0, msg);
c0d0045c:	2100      	movs	r1, #0
c0d0045e:	4620      	mov	r0, r4
c0d00460:	9a01      	ldr	r2, [sp, #4]
c0d00462:	f000 f803 	bl	c0d0046c <get_private_key>
}
c0d00466:	b00f      	add	sp, #60	; 0x3c
c0d00468:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d0046c <get_private_key>:

//write func to get private key
void get_private_key(trint_t *seed_trints, uint32_t idx, char *msg) {
c0d0046c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0046e:	af03      	add	r7, sp, #12
c0d00470:	b0ff      	sub	sp, #508	; 0x1fc
c0d00472:	b0ff      	sub	sp, #508	; 0x1fc
c0d00474:	b0f3      	sub	sp, #460	; 0x1cc
    { // localize the memory for private key
        //currently able to store 31 - [-1][-1][-1][0][-1]
        trint_t private_key_trints[49 * 27]; //trints are still just int8_t but encoded

        //generate private key using level 1 for first half
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 1, msg);
c0d00476:	ab01      	add	r3, sp, #4
c0d00478:	c307      	stmia	r3!, {r0, r1, r2}
c0d0047a:	466b      	mov	r3, sp
c0d0047c:	601a      	str	r2, [r3, #0]
c0d0047e:	ad19      	add	r5, sp, #100	; 0x64
c0d00480:	2601      	movs	r6, #1
c0d00482:	462a      	mov	r2, r5
c0d00484:	4633      	mov	r3, r6
c0d00486:	f7ff fe72 	bl	c0d0016e <generate_private_key_half>
c0d0048a:	4c17      	ldr	r4, [pc, #92]	; (c0d004e8 <get_private_key+0x7c>)
c0d0048c:	446c      	add	r4, sp
        //use this half to generate half public key 1
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 1);
c0d0048e:	4628      	mov	r0, r5
c0d00490:	4621      	mov	r1, r4
c0d00492:	4632      	mov	r2, r6
c0d00494:	f7ff fea8 	bl	c0d001e8 <generate_public_address_half>

        //use level 2 to generate second half of private key
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 2, msg);
c0d00498:	4668      	mov	r0, sp
c0d0049a:	9903      	ldr	r1, [sp, #12]
c0d0049c:	6001      	str	r1, [r0, #0]
c0d0049e:	2602      	movs	r6, #2
c0d004a0:	9801      	ldr	r0, [sp, #4]
c0d004a2:	9902      	ldr	r1, [sp, #8]
c0d004a4:	462a      	mov	r2, r5
c0d004a6:	4633      	mov	r3, r6
c0d004a8:	f7ff fe61 	bl	c0d0016e <generate_private_key_half>

        //finally level 2 to generate second half of public key (and then digests both)
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 2);
c0d004ac:	4628      	mov	r0, r5
c0d004ae:	4621      	mov	r1, r4
c0d004b0:	4632      	mov	r2, r6
c0d004b2:	f7ff fe99 	bl	c0d001e8 <generate_public_address_half>
c0d004b6:	ad19      	add	r5, sp, #100	; 0x64
    }
    // 12s to get here if k=25, 2min otherwise
    //now public key will hold the actual public address
    trit_t pub_trits[243];
    specific_49trints_to_243trits(&public_key_trints[0], &pub_trits[0]);
c0d004b8:	4620      	mov	r0, r4
c0d004ba:	4629      	mov	r1, r5
c0d004bc:	f7ff ff0b 	bl	c0d002d6 <specific_49trints_to_243trits>
c0d004c0:	ac04      	add	r4, sp, #16

    tryte_t seed_trytes[81];
    trits_to_trytes(pub_trits, seed_trytes, 243);
c0d004c2:	22f3      	movs	r2, #243	; 0xf3
c0d004c4:	4628      	mov	r0, r5
c0d004c6:	4621      	mov	r1, r4
c0d004c8:	f000 f8fd 	bl	c0d006c6 <trits_to_trytes>
c0d004cc:	2551      	movs	r5, #81	; 0x51

    trytes_to_chars(seed_trytes, msg, 81);
c0d004ce:	4620      	mov	r0, r4
c0d004d0:	9c03      	ldr	r4, [sp, #12]
c0d004d2:	4621      	mov	r1, r4
c0d004d4:	462a      	mov	r2, r5
c0d004d6:	f000 f92b 	bl	c0d00730 <trytes_to_chars>

    //null terminate the public key
    msg[81] = '\0';
c0d004da:	2000      	movs	r0, #0
c0d004dc:	5560      	strb	r0, [r4, r5]
}
c0d004de:	1ffc      	subs	r4, r7, #7
c0d004e0:	3c05      	subs	r4, #5
c0d004e2:	46a5      	mov	sp, r4
c0d004e4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d004e6:	46c0      	nop			; (mov r8, r8)
c0d004e8:	00000590 	.word	0x00000590

c0d004ec <bigint_add_int>:
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
    return ret;
}

int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
c0d004ec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004ee:	af03      	add	r7, sp, #12
c0d004f0:	b087      	sub	sp, #28
c0d004f2:	9105      	str	r1, [sp, #20]
c0d004f4:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d004f6:	2b00      	cmp	r3, #0
c0d004f8:	d03a      	beq.n	c0d00570 <bigint_add_int+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004fa:	2100      	movs	r1, #0
c0d004fc:	43cc      	mvns	r4, r1
c0d004fe:	9400      	str	r4, [sp, #0]
c0d00500:	460e      	mov	r6, r1
c0d00502:	460c      	mov	r4, r1
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_in[i], val.low, val.hi);
c0d00504:	9101      	str	r1, [sp, #4]
c0d00506:	9302      	str	r3, [sp, #8]
c0d00508:	9203      	str	r2, [sp, #12]
c0d0050a:	9b00      	ldr	r3, [sp, #0]
c0d0050c:	460a      	mov	r2, r1
c0d0050e:	4605      	mov	r5, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00510:	cd01      	ldmia	r5!, {r0}
c0d00512:	9504      	str	r5, [sp, #16]
c0d00514:	9905      	ldr	r1, [sp, #20]
c0d00516:	1841      	adds	r1, r0, r1
c0d00518:	4156      	adcs	r6, r2
c0d0051a:	9106      	str	r1, [sp, #24]
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d0051c:	4019      	ands	r1, r3
c0d0051e:	1c49      	adds	r1, r1, #1
c0d00520:	4615      	mov	r5, r2
c0d00522:	416d      	adcs	r5, r5
c0d00524:	2001      	movs	r0, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00526:	4004      	ands	r4, r0
c0d00528:	4622      	mov	r2, r4
c0d0052a:	2c00      	cmp	r4, #0
c0d0052c:	d100      	bne.n	c0d00530 <bigint_add_int+0x44>
c0d0052e:	9906      	ldr	r1, [sp, #24]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00530:	4299      	cmp	r1, r3
c0d00532:	9006      	str	r0, [sp, #24]
c0d00534:	d800      	bhi.n	c0d00538 <bigint_add_int+0x4c>
c0d00536:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00538:	2a00      	cmp	r2, #0
c0d0053a:	4632      	mov	r2, r6
c0d0053c:	d100      	bne.n	c0d00540 <bigint_add_int+0x54>
c0d0053e:	4615      	mov	r5, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00540:	2d00      	cmp	r5, #0
c0d00542:	9e06      	ldr	r6, [sp, #24]
c0d00544:	d100      	bne.n	c0d00548 <bigint_add_int+0x5c>
c0d00546:	462e      	mov	r6, r5
c0d00548:	2d00      	cmp	r5, #0
c0d0054a:	d000      	beq.n	c0d0054e <bigint_add_int+0x62>
c0d0054c:	4630      	mov	r0, r6
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d0054e:	4310      	orrs	r0, r2
c0d00550:	b2c0      	uxtb	r0, r0
c0d00552:	2800      	cmp	r0, #0
c0d00554:	9b02      	ldr	r3, [sp, #8]
c0d00556:	9a03      	ldr	r2, [sp, #12]
c0d00558:	9c01      	ldr	r4, [sp, #4]
c0d0055a:	d100      	bne.n	c0d0055e <bigint_add_int+0x72>
c0d0055c:	9006      	str	r0, [sp, #24]
        val = full_add(bigint_in[i], val.low, val.hi);
        bigint_out[i] = val.low;
c0d0055e:	c202      	stmia	r2!, {r1}
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00560:	1e5b      	subs	r3, r3, #1
c0d00562:	9405      	str	r4, [sp, #20]
c0d00564:	4626      	mov	r6, r4
c0d00566:	9d06      	ldr	r5, [sp, #24]
c0d00568:	4621      	mov	r1, r4
c0d0056a:	462c      	mov	r4, r5
c0d0056c:	9804      	ldr	r0, [sp, #16]
c0d0056e:	d1ca      	bne.n	c0d00506 <bigint_add_int+0x1a>
        bigint_out[i] = val.low;
        val.low = 0;
    }

    if (val.hi) {
        return -1;
c0d00570:	4268      	negs	r0, r5
    }
    return 0;
}
c0d00572:	b007      	add	sp, #28
c0d00574:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00576 <bigint_add_bigint>:

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d00576:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00578:	af03      	add	r7, sp, #12
c0d0057a:	b086      	sub	sp, #24
c0d0057c:	461c      	mov	r4, r3
c0d0057e:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00580:	2c00      	cmp	r4, #0
c0d00582:	d034      	beq.n	c0d005ee <bigint_add_bigint+0x78>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00584:	2600      	movs	r6, #0
c0d00586:	43f3      	mvns	r3, r6
c0d00588:	9300      	str	r3, [sp, #0]
c0d0058a:	9601      	str	r6, [sp, #4]
c0d0058c:	9202      	str	r2, [sp, #8]
c0d0058e:	9403      	str	r4, [sp, #12]
c0d00590:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00592:	cc01      	ldmia	r4!, {r0}
c0d00594:	9404      	str	r4, [sp, #16]
c0d00596:	460c      	mov	r4, r1
c0d00598:	cc02      	ldmia	r4!, {r1}
c0d0059a:	9405      	str	r4, [sp, #20]
c0d0059c:	180a      	adds	r2, r1, r0
c0d0059e:	9d01      	ldr	r5, [sp, #4]
c0d005a0:	462c      	mov	r4, r5
c0d005a2:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d005a4:	4611      	mov	r1, r2
c0d005a6:	9800      	ldr	r0, [sp, #0]
c0d005a8:	4001      	ands	r1, r0
c0d005aa:	1c4b      	adds	r3, r1, #1
c0d005ac:	4629      	mov	r1, r5
c0d005ae:	4149      	adcs	r1, r1
c0d005b0:	2501      	movs	r5, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d005b2:	402e      	ands	r6, r5
c0d005b4:	2e00      	cmp	r6, #0
c0d005b6:	d100      	bne.n	c0d005ba <bigint_add_bigint+0x44>
c0d005b8:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005ba:	4283      	cmp	r3, r0
c0d005bc:	4628      	mov	r0, r5
c0d005be:	d800      	bhi.n	c0d005c2 <bigint_add_bigint+0x4c>
c0d005c0:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d005c2:	2e00      	cmp	r6, #0
c0d005c4:	9a02      	ldr	r2, [sp, #8]
c0d005c6:	d100      	bne.n	c0d005ca <bigint_add_bigint+0x54>
c0d005c8:	4621      	mov	r1, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005ca:	2900      	cmp	r1, #0
c0d005cc:	462e      	mov	r6, r5
c0d005ce:	d100      	bne.n	c0d005d2 <bigint_add_bigint+0x5c>
c0d005d0:	460e      	mov	r6, r1
c0d005d2:	2900      	cmp	r1, #0
c0d005d4:	d000      	beq.n	c0d005d8 <bigint_add_bigint+0x62>
c0d005d6:	4630      	mov	r0, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d005d8:	4320      	orrs	r0, r4

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d005da:	2800      	cmp	r0, #0
c0d005dc:	9905      	ldr	r1, [sp, #20]
c0d005de:	d100      	bne.n	c0d005e2 <bigint_add_bigint+0x6c>
c0d005e0:	4605      	mov	r5, r0
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d005e2:	c208      	stmia	r2!, {r3}
c0d005e4:	9c03      	ldr	r4, [sp, #12]

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d005e6:	1e64      	subs	r4, r4, #1
c0d005e8:	462e      	mov	r6, r5
c0d005ea:	9804      	ldr	r0, [sp, #16]
c0d005ec:	d1ce      	bne.n	c0d0058c <bigint_add_bigint+0x16>
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }

    if (val.hi) {
        return -1;
c0d005ee:	4268      	negs	r0, r5
    }
    return 0;
}
c0d005f0:	b006      	add	sp, #24
c0d005f2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d005f4 <bigint_sub_bigint>:

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d005f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005f6:	af03      	add	r7, sp, #12
c0d005f8:	b087      	sub	sp, #28
c0d005fa:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d005fc:	2d00      	cmp	r5, #0
c0d005fe:	d037      	beq.n	c0d00670 <bigint_sub_bigint+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00600:	2400      	movs	r4, #0
c0d00602:	9402      	str	r4, [sp, #8]
c0d00604:	43e3      	mvns	r3, r4
c0d00606:	9301      	str	r3, [sp, #4]
c0d00608:	2601      	movs	r6, #1
c0d0060a:	9600      	str	r6, [sp, #0]
c0d0060c:	9203      	str	r2, [sp, #12]
c0d0060e:	9504      	str	r5, [sp, #16]
c0d00610:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00612:	cc01      	ldmia	r4!, {r0}
c0d00614:	9405      	str	r4, [sp, #20]
c0d00616:	460c      	mov	r4, r1
int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d00618:	cc02      	ldmia	r4!, {r1}
c0d0061a:	9406      	str	r4, [sp, #24]
c0d0061c:	43c9      	mvns	r1, r1
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0061e:	180a      	adds	r2, r1, r0
c0d00620:	9902      	ldr	r1, [sp, #8]
c0d00622:	460c      	mov	r4, r1
c0d00624:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00626:	4610      	mov	r0, r2
c0d00628:	9d01      	ldr	r5, [sp, #4]
c0d0062a:	4028      	ands	r0, r5
c0d0062c:	1c43      	adds	r3, r0, #1
c0d0062e:	4608      	mov	r0, r1
c0d00630:	4140      	adcs	r0, r0
c0d00632:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00634:	400e      	ands	r6, r1
c0d00636:	2e00      	cmp	r6, #0
c0d00638:	d100      	bne.n	c0d0063c <bigint_sub_bigint+0x48>
c0d0063a:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0063c:	42ab      	cmp	r3, r5
c0d0063e:	460d      	mov	r5, r1
c0d00640:	d800      	bhi.n	c0d00644 <bigint_sub_bigint+0x50>
c0d00642:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00644:	2e00      	cmp	r6, #0
c0d00646:	9a03      	ldr	r2, [sp, #12]
c0d00648:	d100      	bne.n	c0d0064c <bigint_sub_bigint+0x58>
c0d0064a:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0064c:	2800      	cmp	r0, #0
c0d0064e:	460e      	mov	r6, r1
c0d00650:	d100      	bne.n	c0d00654 <bigint_sub_bigint+0x60>
c0d00652:	4606      	mov	r6, r0
c0d00654:	2800      	cmp	r0, #0
c0d00656:	d000      	beq.n	c0d0065a <bigint_sub_bigint+0x66>
c0d00658:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d0065a:	4325      	orrs	r5, r4

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0065c:	2d00      	cmp	r5, #0
c0d0065e:	460e      	mov	r6, r1
c0d00660:	9805      	ldr	r0, [sp, #20]
c0d00662:	d100      	bne.n	c0d00666 <bigint_sub_bigint+0x72>
c0d00664:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d00666:	c208      	stmia	r2!, {r3}
c0d00668:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0066a:	1e6d      	subs	r5, r5, #1
c0d0066c:	9906      	ldr	r1, [sp, #24]
c0d0066e:	d1cd      	bne.n	c0d0060c <bigint_sub_bigint+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d00670:	2000      	movs	r0, #0
c0d00672:	b007      	add	sp, #28
c0d00674:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00676 <bigint_cmp_bigint>:
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
c0d00676:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00678:	af03      	add	r7, sp, #12
c0d0067a:	b081      	sub	sp, #4
c0d0067c:	2400      	movs	r4, #0
c0d0067e:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d00680:	32ff      	adds	r2, #255	; 0xff
c0d00682:	b253      	sxtb	r3, r2
c0d00684:	2b00      	cmp	r3, #0
c0d00686:	db0f      	blt.n	c0d006a8 <bigint_cmp_bigint+0x32>
c0d00688:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d0068a:	009b      	lsls	r3, r3, #2
c0d0068c:	58ce      	ldr	r6, [r1, r3]
c0d0068e:	58c4      	ldr	r4, [r0, r3]
c0d00690:	2301      	movs	r3, #1
c0d00692:	42b4      	cmp	r4, r6
c0d00694:	dc0b      	bgt.n	c0d006ae <bigint_cmp_bigint+0x38>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00696:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d00698:	42b4      	cmp	r4, r6
c0d0069a:	db07      	blt.n	c0d006ac <bigint_cmp_bigint+0x36>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d0069c:	b253      	sxtb	r3, r2
c0d0069e:	42ab      	cmp	r3, r5
c0d006a0:	461a      	mov	r2, r3
c0d006a2:	dcf2      	bgt.n	c0d0068a <bigint_cmp_bigint+0x14>
c0d006a4:	9b00      	ldr	r3, [sp, #0]
c0d006a6:	e002      	b.n	c0d006ae <bigint_cmp_bigint+0x38>
c0d006a8:	4623      	mov	r3, r4
c0d006aa:	e000      	b.n	c0d006ae <bigint_cmp_bigint+0x38>
c0d006ac:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d006ae:	4618      	mov	r0, r3
c0d006b0:	b001      	add	sp, #4
c0d006b2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d006b4 <bigint_not>:

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d006b4:	2900      	cmp	r1, #0
c0d006b6:	d004      	beq.n	c0d006c2 <bigint_not+0xe>
        bigint[i] = ~bigint[i];
c0d006b8:	6802      	ldr	r2, [r0, #0]
c0d006ba:	43d2      	mvns	r2, r2
c0d006bc:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d006be:	1e49      	subs	r1, r1, #1
c0d006c0:	d1fa      	bne.n	c0d006b8 <bigint_not+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d006c2:	2000      	movs	r0, #0
c0d006c4:	4770      	bx	lr

c0d006c6 <trits_to_trytes>:

static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";


int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len)
{
c0d006c6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006c8:	af03      	add	r7, sp, #12
c0d006ca:	b083      	sub	sp, #12
c0d006cc:	4616      	mov	r6, r2
c0d006ce:	460c      	mov	r4, r1
c0d006d0:	4605      	mov	r5, r0
    if (trit_len % 3 != 0) {
c0d006d2:	2103      	movs	r1, #3
c0d006d4:	4630      	mov	r0, r6
c0d006d6:	f002 ff19 	bl	c0d0350c <__aeabi_uidivmod>
c0d006da:	2000      	movs	r0, #0
c0d006dc:	43c2      	mvns	r2, r0
c0d006de:	2900      	cmp	r1, #0
c0d006e0:	d123      	bne.n	c0d0072a <trits_to_trytes+0x64>
c0d006e2:	9502      	str	r5, [sp, #8]
c0d006e4:	4635      	mov	r5, r6
c0d006e6:	2603      	movs	r6, #3
c0d006e8:	9001      	str	r0, [sp, #4]
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;
c0d006ea:	4628      	mov	r0, r5
c0d006ec:	4631      	mov	r1, r6
c0d006ee:	f002 fe87 	bl	c0d03400 <__aeabi_uidiv>

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d006f2:	2d03      	cmp	r5, #3
c0d006f4:	9a01      	ldr	r2, [sp, #4]
c0d006f6:	d318      	bcc.n	c0d0072a <trits_to_trytes+0x64>
c0d006f8:	2200      	movs	r2, #0
c0d006fa:	9200      	str	r2, [sp, #0]
c0d006fc:	9601      	str	r6, [sp, #4]
c0d006fe:	9e01      	ldr	r6, [sp, #4]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
c0d00700:	4633      	mov	r3, r6
c0d00702:	4353      	muls	r3, r2
c0d00704:	4625      	mov	r5, r4
c0d00706:	9902      	ldr	r1, [sp, #8]
c0d00708:	5ccc      	ldrb	r4, [r1, r3]
c0d0070a:	18cb      	adds	r3, r1, r3
c0d0070c:	2101      	movs	r1, #1
c0d0070e:	5659      	ldrsb	r1, [r3, r1]
c0d00710:	4371      	muls	r1, r6
c0d00712:	1909      	adds	r1, r1, r4
c0d00714:	2402      	movs	r4, #2
c0d00716:	571b      	ldrsb	r3, [r3, r4]
c0d00718:	2409      	movs	r4, #9
c0d0071a:	435c      	muls	r4, r3
c0d0071c:	1909      	adds	r1, r1, r4
c0d0071e:	462c      	mov	r4, r5
c0d00720:	54a1      	strb	r1, [r4, r2]
    if (trit_len % 3 != 0) {
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00722:	1c52      	adds	r2, r2, #1
c0d00724:	4282      	cmp	r2, r0
c0d00726:	d3eb      	bcc.n	c0d00700 <trits_to_trytes+0x3a>
c0d00728:	9a00      	ldr	r2, [sp, #0]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
    }
    return 0;
}
c0d0072a:	4610      	mov	r0, r2
c0d0072c:	b003      	add	sp, #12
c0d0072e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00730 <trytes_to_chars>:
    }
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
c0d00730:	b5d0      	push	{r4, r6, r7, lr}
c0d00732:	af02      	add	r7, sp, #8
    for (uint16_t i = 0; i < len; i++) {
c0d00734:	2a00      	cmp	r2, #0
c0d00736:	d00a      	beq.n	c0d0074e <trytes_to_chars+0x1e>
c0d00738:	a306      	add	r3, pc, #24	; (adr r3, c0d00754 <tryte_to_char_mapping>)
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
c0d0073a:	7804      	ldrb	r4, [r0, #0]
c0d0073c:	b264      	sxtb	r4, r4
c0d0073e:	191c      	adds	r4, r3, r4
c0d00740:	7b64      	ldrb	r4, [r4, #13]
c0d00742:	700c      	strb	r4, [r1, #0]
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
    for (uint16_t i = 0; i < len; i++) {
c0d00744:	1e52      	subs	r2, r2, #1
c0d00746:	1c40      	adds	r0, r0, #1
c0d00748:	1c49      	adds	r1, r1, #1
c0d0074a:	2a00      	cmp	r2, #0
c0d0074c:	d1f5      	bne.n	c0d0073a <trytes_to_chars+0xa>
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
    }

    return 0;
c0d0074e:	2000      	movs	r0, #0
c0d00750:	bdd0      	pop	{r4, r6, r7, pc}
c0d00752:	46c0      	nop			; (mov r8, r8)

c0d00754 <tryte_to_char_mapping>:
c0d00754:	51504f4e 	.word	0x51504f4e
c0d00758:	55545352 	.word	0x55545352
c0d0075c:	59585756 	.word	0x59585756
c0d00760:	4241395a 	.word	0x4241395a
c0d00764:	46454443 	.word	0x46454443
c0d00768:	4a494847 	.word	0x4a494847
c0d0076c:	004d4c4b 	.word	0x004d4c4b

c0d00770 <words_to_bytes>:
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
c0d00770:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00772:	af03      	add	r7, sp, #12
c0d00774:	b082      	sub	sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d00776:	2a00      	cmp	r2, #0
c0d00778:	d01a      	beq.n	c0d007b0 <words_to_bytes+0x40>
c0d0077a:	0093      	lsls	r3, r2, #2
c0d0077c:	18c0      	adds	r0, r0, r3
c0d0077e:	1f00      	subs	r0, r0, #4
c0d00780:	2303      	movs	r3, #3
c0d00782:	43db      	mvns	r3, r3
c0d00784:	9301      	str	r3, [sp, #4]
c0d00786:	4252      	negs	r2, r2
c0d00788:	9200      	str	r2, [sp, #0]
c0d0078a:	2400      	movs	r4, #0
        bytes_out[i*4+0] = (words_in[word_len-1-i] >> 24);
c0d0078c:	9d01      	ldr	r5, [sp, #4]
c0d0078e:	4365      	muls	r5, r4
c0d00790:	00a6      	lsls	r6, r4, #2
c0d00792:	1983      	adds	r3, r0, r6
c0d00794:	78da      	ldrb	r2, [r3, #3]
c0d00796:	554a      	strb	r2, [r1, r5]
c0d00798:	194a      	adds	r2, r1, r5
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
c0d0079a:	885b      	ldrh	r3, [r3, #2]
c0d0079c:	7053      	strb	r3, [r2, #1]
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
c0d0079e:	5983      	ldr	r3, [r0, r6]
c0d007a0:	0a1b      	lsrs	r3, r3, #8
c0d007a2:	7093      	strb	r3, [r2, #2]
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
c0d007a4:	5983      	ldr	r3, [r0, r6]
c0d007a6:	70d3      	strb	r3, [r2, #3]
    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d007a8:	1e64      	subs	r4, r4, #1
c0d007aa:	9a00      	ldr	r2, [sp, #0]
c0d007ac:	42a2      	cmp	r2, r4
c0d007ae:	d1ed      	bne.n	c0d0078c <words_to_bytes+0x1c>
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
    }

    return 0;
c0d007b0:	2000      	movs	r0, #0
c0d007b2:	b002      	add	sp, #8
c0d007b4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d007b6 <bytes_to_words>:
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
c0d007b6:	b5d0      	push	{r4, r6, r7, lr}
c0d007b8:	af02      	add	r7, sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d007ba:	2a00      	cmp	r2, #0
c0d007bc:	d015      	beq.n	c0d007ea <bytes_to_words+0x34>
c0d007be:	0093      	lsls	r3, r2, #2
c0d007c0:	18c0      	adds	r0, r0, r3
c0d007c2:	1f00      	subs	r0, r0, #4
c0d007c4:	2300      	movs	r3, #0
        words_out[i] = 0;
c0d007c6:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
c0d007c8:	7803      	ldrb	r3, [r0, #0]
c0d007ca:	061b      	lsls	r3, r3, #24
c0d007cc:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
c0d007ce:	7844      	ldrb	r4, [r0, #1]
c0d007d0:	0424      	lsls	r4, r4, #16
c0d007d2:	431c      	orrs	r4, r3
c0d007d4:	600c      	str	r4, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
c0d007d6:	7883      	ldrb	r3, [r0, #2]
c0d007d8:	021b      	lsls	r3, r3, #8
c0d007da:	4323      	orrs	r3, r4
c0d007dc:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
c0d007de:	78c4      	ldrb	r4, [r0, #3]
c0d007e0:	431c      	orrs	r4, r3
c0d007e2:	c110      	stmia	r1!, {r4}
    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d007e4:	1f00      	subs	r0, r0, #4
c0d007e6:	1e52      	subs	r2, r2, #1
c0d007e8:	d1ec      	bne.n	c0d007c4 <bytes_to_words+0xe>
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
    }
    return 0;
c0d007ea:	2000      	movs	r0, #0
c0d007ec:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d007f0 <trints_to_words>:
}

//custom conversion straight from trints to words
int trints_to_words(trint_t *trints_in, int32_t words_out[])
{
c0d007f0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007f2:	af03      	add	r7, sp, #12
c0d007f4:	b0a1      	sub	sp, #132	; 0x84
c0d007f6:	9101      	str	r1, [sp, #4]
c0d007f8:	9002      	str	r0, [sp, #8]
c0d007fa:	a814      	add	r0, sp, #80	; 0x50
    int32_t base[13] = {0};
c0d007fc:	2134      	movs	r1, #52	; 0x34
c0d007fe:	f003 f87f 	bl	c0d03900 <__aeabi_memclr>
c0d00802:	2430      	movs	r4, #48	; 0x30
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
c0d00804:	2603      	movs	r6, #3
c0d00806:	2005      	movs	r0, #5
c0d00808:	2c30      	cmp	r4, #48	; 0x30
c0d0080a:	d000      	beq.n	c0d0080e <trints_to_words+0x1e>
c0d0080c:	4606      	mov	r6, r0
        trint_to_trits(trints_in[x], &trits[0], get);
c0d0080e:	9802      	ldr	r0, [sp, #8]
c0d00810:	5700      	ldrsb	r0, [r0, r4]
c0d00812:	a912      	add	r1, sp, #72	; 0x48
c0d00814:	4632      	mov	r2, r6
c0d00816:	f7ff fdc9 	bl	c0d003ac <trint_to_trits>
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d0081a:	4833      	ldr	r0, [pc, #204]	; (c0d008e8 <trints_to_words+0xf8>)
c0d0081c:	1832      	adds	r2, r6, r0
c0d0081e:	2006      	movs	r0, #6
c0d00820:	4010      	ands	r0, r2
            // multiply
            {
                int32_t sz = size;
                int32_t carry = 0;
                
                for (int32_t j = 0; j < sz; j++) {
c0d00822:	1e76      	subs	r6, r6, #1
c0d00824:	9403      	str	r4, [sp, #12]
            
            // add
            {
                int32_t tmp[12];
                // Ignore the last trit (48 is last trint, 2 is last trit in that trint)
                if (x == 48 & i == 2) {
c0d00826:	2c30      	cmp	r4, #48	; 0x30
c0d00828:	9204      	str	r2, [sp, #16]
c0d0082a:	d105      	bne.n	c0d00838 <trints_to_words+0x48>
c0d0082c:	b2b1      	uxth	r1, r6
c0d0082e:	2902      	cmp	r1, #2
c0d00830:	d102      	bne.n	c0d00838 <trints_to_words+0x48>
c0d00832:	a814      	add	r0, sp, #80	; 0x50
                    bigint_add_int(base, 1, tmp, 13);
c0d00834:	2101      	movs	r1, #1
c0d00836:	e003      	b.n	c0d00840 <trints_to_words+0x50>
c0d00838:	a912      	add	r1, sp, #72	; 0x48
                } else {
                    bigint_add_int(base, trits[i]+1, tmp, 13);
c0d0083a:	5608      	ldrsb	r0, [r1, r0]
c0d0083c:	1c41      	adds	r1, r0, #1
c0d0083e:	a814      	add	r0, sp, #80	; 0x50
c0d00840:	aa05      	add	r2, sp, #20
c0d00842:	230d      	movs	r3, #13
c0d00844:	f7ff fe52 	bl	c0d004ec <bigint_add_int>
c0d00848:	a805      	add	r0, sp, #20
c0d0084a:	a914      	add	r1, sp, #80	; 0x50
                }
                memcpy(base, tmp, 52);
c0d0084c:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d0084e:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00850:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00852:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00854:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00856:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00858:	c83c      	ldmia	r0!, {r2, r3, r4, r5}
c0d0085a:	c13c      	stmia	r1!, {r2, r3, r4, r5}
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
        trint_to_trits(trints_in[x], &trits[0], get);
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d0085c:	1e76      	subs	r6, r6, #1
c0d0085e:	9804      	ldr	r0, [sp, #16]
c0d00860:	1e40      	subs	r0, r0, #1
c0d00862:	b200      	sxth	r0, r0
c0d00864:	2800      	cmp	r0, #0
c0d00866:	4602      	mov	r2, r0
c0d00868:	9c03      	ldr	r4, [sp, #12]
c0d0086a:	dadc      	bge.n	c0d00826 <trints_to_words+0x36>
    int32_t size = 13;
    trit_t trits[5]; // on final call only left 3 trits matter
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
c0d0086c:	1e60      	subs	r0, r4, #1
c0d0086e:	2c00      	cmp	r4, #0
c0d00870:	4604      	mov	r4, r0
c0d00872:	dcc7      	bgt.n	c0d00804 <trints_to_words+0x14>
                // todo sz>size stuff
            }
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
c0d00874:	481d      	ldr	r0, [pc, #116]	; (c0d008ec <trints_to_words+0xfc>)
c0d00876:	4478      	add	r0, pc
c0d00878:	a914      	add	r1, sp, #80	; 0x50
c0d0087a:	220d      	movs	r2, #13
c0d0087c:	f7ff fefb 	bl	c0d00676 <bigint_cmp_bigint>
c0d00880:	2801      	cmp	r0, #1
c0d00882:	db14      	blt.n	c0d008ae <trints_to_words+0xbe>
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d00884:	481b      	ldr	r0, [pc, #108]	; (c0d008f4 <trints_to_words+0x104>)
c0d00886:	4478      	add	r0, pc
c0d00888:	ad14      	add	r5, sp, #80	; 0x50
c0d0088a:	ac05      	add	r4, sp, #20
c0d0088c:	260d      	movs	r6, #13
c0d0088e:	4629      	mov	r1, r5
c0d00890:	4622      	mov	r2, r4
c0d00892:	4633      	mov	r3, r6
c0d00894:	f7ff feae 	bl	c0d005f4 <bigint_sub_bigint>
        bigint_not(tmp, 13);
c0d00898:	4620      	mov	r0, r4
c0d0089a:	4631      	mov	r1, r6
c0d0089c:	f7ff ff0a 	bl	c0d006b4 <bigint_not>
        bigint_add_int(tmp, 1, base, 13);
c0d008a0:	2101      	movs	r1, #1
c0d008a2:	4620      	mov	r0, r4
c0d008a4:	462a      	mov	r2, r5
c0d008a6:	4633      	mov	r3, r6
c0d008a8:	f7ff fe20 	bl	c0d004ec <bigint_add_int>
c0d008ac:	e010      	b.n	c0d008d0 <trints_to_words+0xe0>
c0d008ae:	ad14      	add	r5, sp, #80	; 0x50
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
c0d008b0:	490f      	ldr	r1, [pc, #60]	; (c0d008f0 <trints_to_words+0x100>)
c0d008b2:	4479      	add	r1, pc
c0d008b4:	ae05      	add	r6, sp, #20
c0d008b6:	230d      	movs	r3, #13
c0d008b8:	4628      	mov	r0, r5
c0d008ba:	4632      	mov	r2, r6
c0d008bc:	f7ff fe9a 	bl	c0d005f4 <bigint_sub_bigint>
        memcpy(base, tmp, 52);
c0d008c0:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d008c2:	c507      	stmia	r5!, {r0, r1, r2}
c0d008c4:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d008c6:	c507      	stmia	r5!, {r0, r1, r2}
c0d008c8:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d008ca:	c507      	stmia	r5!, {r0, r1, r2}
c0d008cc:	ce0f      	ldmia	r6!, {r0, r1, r2, r3}
c0d008ce:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d008d0:	a814      	add	r0, sp, #80	; 0x50
c0d008d2:	9d01      	ldr	r5, [sp, #4]
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }
    
    
    memcpy(words_out, base, 48);
c0d008d4:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d008d6:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d008d8:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d008da:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d008dc:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d008de:	c51e      	stmia	r5!, {r1, r2, r3, r4}
    return 0;
c0d008e0:	2000      	movs	r0, #0
c0d008e2:	b021      	add	sp, #132	; 0x84
c0d008e4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d008e6:	46c0      	nop			; (mov r8, r8)
c0d008e8:	0000ffff 	.word	0x0000ffff
c0d008ec:	0000324e 	.word	0x0000324e
c0d008f0:	00003212 	.word	0x00003212
c0d008f4:	0000323e 	.word	0x0000323e

c0d008f8 <words_to_trints>:
}

//straight from words into trints
int words_to_trints(const int32_t words_in[], trint_t *trints_out)
{
c0d008f8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d008fa:	af03      	add	r7, sp, #12
c0d008fc:	b0a5      	sub	sp, #148	; 0x94
c0d008fe:	9100      	str	r1, [sp, #0]
c0d00900:	4604      	mov	r4, r0
    int32_t base[13] = {0};
c0d00902:	9408      	str	r4, [sp, #32]
c0d00904:	a818      	add	r0, sp, #96	; 0x60
c0d00906:	2134      	movs	r1, #52	; 0x34
c0d00908:	f002 fffa 	bl	c0d03900 <__aeabi_memclr>
c0d0090c:	2500      	movs	r5, #0
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
c0d0090e:	9517      	str	r5, [sp, #92]	; 0x5c
c0d00910:	a80b      	add	r0, sp, #44	; 0x2c
c0d00912:	4621      	mov	r1, r4
c0d00914:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d00916:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00918:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d0091a:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d0091c:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d0091e:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00920:	20fe      	movs	r0, #254	; 0xfe
c0d00922:	43c1      	mvns	r1, r0
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
c0d00924:	9808      	ldr	r0, [sp, #32]
c0d00926:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d00928:	2800      	cmp	r0, #0
c0d0092a:	9103      	str	r1, [sp, #12]
c0d0092c:	db08      	blt.n	c0d00940 <words_to_trints+0x48>
c0d0092e:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
c0d00930:	4941      	ldr	r1, [pc, #260]	; (c0d00a38 <words_to_trints+0x140>)
c0d00932:	4479      	add	r1, pc
c0d00934:	aa18      	add	r2, sp, #96	; 0x60
c0d00936:	230d      	movs	r3, #13
c0d00938:	f7ff fe1d 	bl	c0d00576 <bigint_add_bigint>
c0d0093c:	9502      	str	r5, [sp, #8]
c0d0093e:	e01b      	b.n	c0d00978 <words_to_trints+0x80>
c0d00940:	9501      	str	r5, [sp, #4]
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
c0d00942:	4608      	mov	r0, r1
c0d00944:	30fe      	adds	r0, #254	; 0xfe
c0d00946:	9017      	str	r0, [sp, #92]	; 0x5c
c0d00948:	ad0b      	add	r5, sp, #44	; 0x2c
c0d0094a:	260d      	movs	r6, #13
        bigint_not(tmp, 13);
c0d0094c:	4628      	mov	r0, r5
c0d0094e:	4631      	mov	r1, r6
c0d00950:	f7ff feb0 	bl	c0d006b4 <bigint_not>
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
c0d00954:	4935      	ldr	r1, [pc, #212]	; (c0d00a2c <words_to_trints+0x134>)
c0d00956:	4479      	add	r1, pc
c0d00958:	4628      	mov	r0, r5
c0d0095a:	4632      	mov	r2, r6
c0d0095c:	f7ff fe8b 	bl	c0d00676 <bigint_cmp_bigint>
c0d00960:	2801      	cmp	r0, #1
c0d00962:	db49      	blt.n	c0d009f8 <words_to_trints+0x100>
c0d00964:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(tmp, HALF_3, base, 13);
c0d00966:	4932      	ldr	r1, [pc, #200]	; (c0d00a30 <words_to_trints+0x138>)
c0d00968:	4479      	add	r1, pc
c0d0096a:	aa18      	add	r2, sp, #96	; 0x60
c0d0096c:	230d      	movs	r3, #13
c0d0096e:	f7ff fe41 	bl	c0d005f4 <bigint_sub_bigint>
c0d00972:	2001      	movs	r0, #1
c0d00974:	9002      	str	r0, [sp, #8]
c0d00976:	9d01      	ldr	r5, [sp, #4]
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
c0d00978:	2403      	movs	r4, #3
c0d0097a:	2005      	movs	r0, #5
c0d0097c:	9501      	str	r5, [sp, #4]
c0d0097e:	2d30      	cmp	r5, #48	; 0x30
c0d00980:	d000      	beq.n	c0d00984 <words_to_trints+0x8c>
c0d00982:	4604      	mov	r4, r0
c0d00984:	a809      	add	r0, sp, #36	; 0x24
        trits_to_trint(&trits[0], send);
c0d00986:	4621      	mov	r1, r4
c0d00988:	f7ff fc8a 	bl	c0d002a0 <trits_to_trint>
c0d0098c:	2000      	movs	r0, #0
c0d0098e:	4601      	mov	r1, r0
c0d00990:	9004      	str	r0, [sp, #16]
c0d00992:	9405      	str	r4, [sp, #20]
c0d00994:	9106      	str	r1, [sp, #24]
c0d00996:	9007      	str	r0, [sp, #28]
c0d00998:	250c      	movs	r5, #12
c0d0099a:	9a04      	ldr	r2, [sp, #16]
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
                uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
c0d0099c:	00a9      	lsls	r1, r5, #2
c0d0099e:	ac18      	add	r4, sp, #96	; 0x60
c0d009a0:	5860      	ldr	r0, [r4, r1]
c0d009a2:	2a00      	cmp	r2, #0
c0d009a4:	9108      	str	r1, [sp, #32]
c0d009a6:	2603      	movs	r6, #3
c0d009a8:	2300      	movs	r3, #0
                uint64_t q = (lhs / 3) & 0xFFFFFFFF;
                uint8_t r = lhs % 3;
c0d009aa:	4611      	mov	r1, r2
c0d009ac:	4632      	mov	r2, r6
c0d009ae:	f002 fe9d 	bl	c0d036ec <__aeabi_uldivmod>
                
                base[j] = q;
c0d009b2:	9908      	ldr	r1, [sp, #32]
c0d009b4:	5060      	str	r0, [r4, r1]
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
c0d009b6:	1e68      	subs	r0, r5, #1
c0d009b8:	2d00      	cmp	r5, #0
c0d009ba:	4605      	mov	r5, r0
c0d009bc:	dcee      	bgt.n	c0d0099c <words_to_trints+0xa4>
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
            if (flip_trits) {
                trits[i] = -trits[i];
c0d009be:	9803      	ldr	r0, [sp, #12]
c0d009c0:	1a80      	subs	r0, r0, r2
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d009c2:	32ff      	adds	r2, #255	; 0xff
            if (flip_trits) {
c0d009c4:	9902      	ldr	r1, [sp, #8]
c0d009c6:	2900      	cmp	r1, #0
c0d009c8:	d100      	bne.n	c0d009cc <words_to_trints+0xd4>
c0d009ca:	4610      	mov	r0, r2
c0d009cc:	a909      	add	r1, sp, #36	; 0x24
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d009ce:	9a06      	ldr	r2, [sp, #24]
c0d009d0:	5488      	strb	r0, [r1, r2]
c0d009d2:	9807      	ldr	r0, [sp, #28]
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
c0d009d4:	1c40      	adds	r0, r0, #1
c0d009d6:	b201      	sxth	r1, r0
c0d009d8:	9c05      	ldr	r4, [sp, #20]
c0d009da:	42a1      	cmp	r1, r4
c0d009dc:	dbda      	blt.n	c0d00994 <words_to_trints+0x9c>
c0d009de:	a809      	add	r0, sp, #36	; 0x24
            if (flip_trits) {
                trits[i] = -trits[i];
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
c0d009e0:	4621      	mov	r1, r4
c0d009e2:	f7ff fc5d 	bl	c0d002a0 <trits_to_trint>
c0d009e6:	9900      	ldr	r1, [sp, #0]
c0d009e8:	9d01      	ldr	r5, [sp, #4]
c0d009ea:	5548      	strb	r0, [r1, r5]
    }
    
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
c0d009ec:	1c6d      	adds	r5, r5, #1
c0d009ee:	2d31      	cmp	r5, #49	; 0x31
c0d009f0:	d1c2      	bne.n	c0d00978 <words_to_trints+0x80>
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
    }
    return 0;
c0d009f2:	2000      	movs	r0, #0
c0d009f4:	b025      	add	sp, #148	; 0x94
c0d009f6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d009f8:	ad0b      	add	r5, sp, #44	; 0x2c
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
c0d009fa:	2101      	movs	r1, #1
c0d009fc:	ae18      	add	r6, sp, #96	; 0x60
c0d009fe:	240d      	movs	r4, #13
c0d00a00:	4628      	mov	r0, r5
c0d00a02:	4632      	mov	r2, r6
c0d00a04:	4623      	mov	r3, r4
c0d00a06:	f7ff fd71 	bl	c0d004ec <bigint_add_int>
            bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d00a0a:	480a      	ldr	r0, [pc, #40]	; (c0d00a34 <words_to_trints+0x13c>)
c0d00a0c:	4478      	add	r0, pc
c0d00a0e:	4631      	mov	r1, r6
c0d00a10:	462a      	mov	r2, r5
c0d00a12:	4623      	mov	r3, r4
c0d00a14:	f7ff fdee 	bl	c0d005f4 <bigint_sub_bigint>
            memcpy(base, tmp, 52);
c0d00a18:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00a1a:	c607      	stmia	r6!, {r0, r1, r2}
c0d00a1c:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00a1e:	c607      	stmia	r6!, {r0, r1, r2}
c0d00a20:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00a22:	c607      	stmia	r6!, {r0, r1, r2}
c0d00a24:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00a26:	c60f      	stmia	r6!, {r0, r1, r2, r3}
c0d00a28:	9d01      	ldr	r5, [sp, #4]
c0d00a2a:	e787      	b.n	c0d0093c <words_to_trints+0x44>
c0d00a2c:	0000316e 	.word	0x0000316e
c0d00a30:	0000315c 	.word	0x0000315c
c0d00a34:	000030b8 	.word	0x000030b8
c0d00a38:	00003192 	.word	0x00003192

c0d00a3c <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00a3c:	b580      	push	{r7, lr}
c0d00a3e:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00a40:	2003      	movs	r0, #3
c0d00a42:	01c1      	lsls	r1, r0, #7
c0d00a44:	4802      	ldr	r0, [pc, #8]	; (c0d00a50 <kerl_initialize+0x14>)
c0d00a46:	f001 fb6d 	bl	c0d02124 <cx_keccak_init>
    return 0;
c0d00a4a:	2000      	movs	r0, #0
c0d00a4c:	bd80      	pop	{r7, pc}
c0d00a4e:	46c0      	nop			; (mov r8, r8)
c0d00a50:	20001840 	.word	0x20001840

c0d00a54 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00a54:	b580      	push	{r7, lr}
c0d00a56:	af00      	add	r7, sp, #0
c0d00a58:	b082      	sub	sp, #8
c0d00a5a:	460b      	mov	r3, r1
c0d00a5c:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00a5e:	4805      	ldr	r0, [pc, #20]	; (c0d00a74 <kerl_absorb_bytes+0x20>)
c0d00a60:	4669      	mov	r1, sp
c0d00a62:	6008      	str	r0, [r1, #0]
c0d00a64:	4804      	ldr	r0, [pc, #16]	; (c0d00a78 <kerl_absorb_bytes+0x24>)
c0d00a66:	2101      	movs	r1, #1
c0d00a68:	f001 fb7a 	bl	c0d02160 <cx_hash>
c0d00a6c:	2000      	movs	r0, #0
    return 0;
c0d00a6e:	b002      	add	sp, #8
c0d00a70:	bd80      	pop	{r7, pc}
c0d00a72:	46c0      	nop			; (mov r8, r8)
c0d00a74:	200019e8 	.word	0x200019e8
c0d00a78:	20001840 	.word	0x20001840

c0d00a7c <kerl_absorb_trints>:
    return 0;
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
c0d00a7c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a7e:	af03      	add	r7, sp, #12
c0d00a80:	b09b      	sub	sp, #108	; 0x6c
c0d00a82:	460e      	mov	r6, r1
c0d00a84:	4604      	mov	r4, r0
c0d00a86:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00a88:	4630      	mov	r0, r6
c0d00a8a:	f002 fcb9 	bl	c0d03400 <__aeabi_uidiv>
c0d00a8e:	2e31      	cmp	r6, #49	; 0x31
c0d00a90:	d31c      	bcc.n	c0d00acc <kerl_absorb_trints+0x50>
c0d00a92:	2500      	movs	r5, #0
c0d00a94:	9402      	str	r4, [sp, #8]
c0d00a96:	9001      	str	r0, [sp, #4]
c0d00a98:	ae0f      	add	r6, sp, #60	; 0x3c
        // First, convert to bytes
        int32_t words[12];
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
c0d00a9a:	4620      	mov	r0, r4
c0d00a9c:	4631      	mov	r1, r6
c0d00a9e:	f7ff fea7 	bl	c0d007f0 <trints_to_words>
c0d00aa2:	ac03      	add	r4, sp, #12
        words_to_bytes(words, bytes, 12);
c0d00aa4:	220c      	movs	r2, #12
c0d00aa6:	4630      	mov	r0, r6
c0d00aa8:	4621      	mov	r1, r4
c0d00aaa:	f7ff fe61 	bl	c0d00770 <words_to_bytes>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00aae:	4668      	mov	r0, sp
c0d00ab0:	4908      	ldr	r1, [pc, #32]	; (c0d00ad4 <kerl_absorb_trints+0x58>)
c0d00ab2:	6001      	str	r1, [r0, #0]
c0d00ab4:	2101      	movs	r1, #1
c0d00ab6:	2330      	movs	r3, #48	; 0x30
c0d00ab8:	4807      	ldr	r0, [pc, #28]	; (c0d00ad8 <kerl_absorb_trints+0x5c>)
c0d00aba:	4622      	mov	r2, r4
c0d00abc:	9c02      	ldr	r4, [sp, #8]
c0d00abe:	f001 fb4f 	bl	c0d02160 <cx_hash>
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00ac2:	1c6d      	adds	r5, r5, #1
c0d00ac4:	b2e8      	uxtb	r0, r5
c0d00ac6:	9901      	ldr	r1, [sp, #4]
c0d00ac8:	4288      	cmp	r0, r1
c0d00aca:	d3e5      	bcc.n	c0d00a98 <kerl_absorb_trints+0x1c>
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
c0d00acc:	2000      	movs	r0, #0
c0d00ace:	b01b      	add	sp, #108	; 0x6c
c0d00ad0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ad2:	46c0      	nop			; (mov r8, r8)
c0d00ad4:	200019e8 	.word	0x200019e8
c0d00ad8:	20001840 	.word	0x20001840

c0d00adc <kerl_squeeze_trints>:
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
c0d00adc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00ade:	af03      	add	r7, sp, #12
c0d00ae0:	b091      	sub	sp, #68	; 0x44
c0d00ae2:	4605      	mov	r5, r0
    (void) len;

    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
c0d00ae4:	4c1b      	ldr	r4, [pc, #108]	; (c0d00b54 <kerl_squeeze_trints+0x78>)
c0d00ae6:	ae05      	add	r6, sp, #20
c0d00ae8:	220c      	movs	r2, #12
c0d00aea:	4620      	mov	r0, r4
c0d00aec:	4631      	mov	r1, r6
c0d00aee:	f7ff fe62 	bl	c0d007b6 <bytes_to_words>
    words_to_trints(words, &trints_out[0]);
c0d00af2:	4630      	mov	r0, r6
c0d00af4:	9502      	str	r5, [sp, #8]
c0d00af6:	4629      	mov	r1, r5
c0d00af8:	f7ff fefe 	bl	c0d008f8 <words_to_trints>


    //-- Setting last trit to 0
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
c0d00afc:	2030      	movs	r0, #48	; 0x30
c0d00afe:	9003      	str	r0, [sp, #12]
c0d00b00:	5628      	ldrsb	r0, [r5, r0]
c0d00b02:	ad04      	add	r5, sp, #16
c0d00b04:	2203      	movs	r2, #3
c0d00b06:	9201      	str	r2, [sp, #4]
c0d00b08:	4629      	mov	r1, r5
c0d00b0a:	f7ff fc4f 	bl	c0d003ac <trint_to_trits>
c0d00b0e:	2600      	movs	r6, #0
    trits[2] = 0; //set last trit to 0
c0d00b10:	70ae      	strb	r6, [r5, #2]
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00b12:	4628      	mov	r0, r5
c0d00b14:	9d01      	ldr	r5, [sp, #4]
c0d00b16:	4629      	mov	r1, r5
c0d00b18:	f7ff fbc2 	bl	c0d002a0 <trits_to_trint>
c0d00b1c:	9903      	ldr	r1, [sp, #12]
c0d00b1e:	9a02      	ldr	r2, [sp, #8]
c0d00b20:	5450      	strb	r0, [r2, r1]

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
c0d00b22:	1ba0      	subs	r0, r4, r6
c0d00b24:	7801      	ldrb	r1, [r0, #0]
c0d00b26:	43c9      	mvns	r1, r1
c0d00b28:	7001      	strb	r1, [r0, #0]
    trints_out[48] = trits_to_trint(&trits[0], 3);

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d00b2a:	1e76      	subs	r6, r6, #1
c0d00b2c:	4630      	mov	r0, r6
c0d00b2e:	3030      	adds	r0, #48	; 0x30
c0d00b30:	d1f7      	bne.n	c0d00b22 <kerl_squeeze_trints+0x46>
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d00b32:	01e9      	lsls	r1, r5, #7
c0d00b34:	4d08      	ldr	r5, [pc, #32]	; (c0d00b58 <kerl_squeeze_trints+0x7c>)
c0d00b36:	4628      	mov	r0, r5
c0d00b38:	f001 faf4 	bl	c0d02124 <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00b3c:	4668      	mov	r0, sp
c0d00b3e:	6004      	str	r4, [r0, #0]
c0d00b40:	2101      	movs	r1, #1
c0d00b42:	2330      	movs	r3, #48	; 0x30
c0d00b44:	4628      	mov	r0, r5
c0d00b46:	4622      	mov	r2, r4
c0d00b48:	f001 fb0a 	bl	c0d02160 <cx_hash>
c0d00b4c:	2000      	movs	r0, #0
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
c0d00b4e:	b011      	add	sp, #68	; 0x44
c0d00b50:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00b52:	46c0      	nop			; (mov r8, r8)
c0d00b54:	200019e8 	.word	0x200019e8
c0d00b58:	20001840 	.word	0x20001840

c0d00b5c <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00b5c:	b580      	push	{r7, lr}
c0d00b5e:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00b60:	4804      	ldr	r0, [pc, #16]	; (c0d00b74 <nvram_is_init+0x18>)
c0d00b62:	f001 fa33 	bl	c0d01fcc <pic>
c0d00b66:	7801      	ldrb	r1, [r0, #0]
c0d00b68:	2000      	movs	r0, #0
c0d00b6a:	2901      	cmp	r1, #1
c0d00b6c:	d100      	bne.n	c0d00b70 <nvram_is_init+0x14>
c0d00b6e:	4608      	mov	r0, r1
    else return true;
}
c0d00b70:	bd80      	pop	{r7, pc}
c0d00b72:	46c0      	nop			; (mov r8, r8)
c0d00b74:	c0d03ec0 	.word	0xc0d03ec0

c0d00b78 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00b78:	b5b0      	push	{r4, r5, r7, lr}
c0d00b7a:	af02      	add	r7, sp, #8
c0d00b7c:	4605      	mov	r5, r0
c0d00b7e:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00b80:	4028      	ands	r0, r5
c0d00b82:	2400      	movs	r4, #0
c0d00b84:	2801      	cmp	r0, #1
c0d00b86:	d013      	beq.n	c0d00bb0 <io_exchange_al+0x38>
c0d00b88:	2802      	cmp	r0, #2
c0d00b8a:	d113      	bne.n	c0d00bb4 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00b8c:	2900      	cmp	r1, #0
c0d00b8e:	d008      	beq.n	c0d00ba2 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00b90:	480b      	ldr	r0, [pc, #44]	; (c0d00bc0 <io_exchange_al+0x48>)
c0d00b92:	f001 fbd7 	bl	c0d02344 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d00b96:	b268      	sxtb	r0, r5
c0d00b98:	2800      	cmp	r0, #0
c0d00b9a:	da09      	bge.n	c0d00bb0 <io_exchange_al+0x38>
                reset();
c0d00b9c:	f001 fa4c 	bl	c0d02038 <reset>
c0d00ba0:	e006      	b.n	c0d00bb0 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00ba2:	2041      	movs	r0, #65	; 0x41
c0d00ba4:	0081      	lsls	r1, r0, #2
c0d00ba6:	4806      	ldr	r0, [pc, #24]	; (c0d00bc0 <io_exchange_al+0x48>)
c0d00ba8:	2200      	movs	r2, #0
c0d00baa:	f001 fc05 	bl	c0d023b8 <io_seproxyhal_spi_recv>
c0d00bae:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00bb0:	4620      	mov	r0, r4
c0d00bb2:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00bb4:	4803      	ldr	r0, [pc, #12]	; (c0d00bc4 <io_exchange_al+0x4c>)
c0d00bb6:	6800      	ldr	r0, [r0, #0]
c0d00bb8:	2102      	movs	r1, #2
c0d00bba:	f002 ff43 	bl	c0d03a44 <longjmp>
c0d00bbe:	46c0      	nop			; (mov r8, r8)
c0d00bc0:	20001c08 	.word	0x20001c08
c0d00bc4:	20001bb8 	.word	0x20001bb8

c0d00bc8 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00bc8:	b580      	push	{r7, lr}
c0d00bca:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00bcc:	f000 fe8e 	bl	c0d018ec <io_seproxyhal_display_default>
}
c0d00bd0:	bd80      	pop	{r7, pc}
	...

c0d00bd4 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00bd4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00bd6:	af03      	add	r7, sp, #12
c0d00bd8:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00bda:	48a6      	ldr	r0, [pc, #664]	; (c0d00e74 <io_event+0x2a0>)
c0d00bdc:	7800      	ldrb	r0, [r0, #0]
c0d00bde:	2805      	cmp	r0, #5
c0d00be0:	d02e      	beq.n	c0d00c40 <io_event+0x6c>
c0d00be2:	280d      	cmp	r0, #13
c0d00be4:	d04e      	beq.n	c0d00c84 <io_event+0xb0>
c0d00be6:	280c      	cmp	r0, #12
c0d00be8:	d000      	beq.n	c0d00bec <io_event+0x18>
c0d00bea:	e13a      	b.n	c0d00e62 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00bec:	4ea2      	ldr	r6, [pc, #648]	; (c0d00e78 <io_event+0x2a4>)
c0d00bee:	2001      	movs	r0, #1
c0d00bf0:	7630      	strb	r0, [r6, #24]
c0d00bf2:	2500      	movs	r5, #0
c0d00bf4:	61f5      	str	r5, [r6, #28]
c0d00bf6:	4634      	mov	r4, r6
c0d00bf8:	3418      	adds	r4, #24
c0d00bfa:	4620      	mov	r0, r4
c0d00bfc:	f001 fb68 	bl	c0d022d0 <os_ux>
c0d00c00:	61f0      	str	r0, [r6, #28]
c0d00c02:	499e      	ldr	r1, [pc, #632]	; (c0d00e7c <io_event+0x2a8>)
c0d00c04:	4288      	cmp	r0, r1
c0d00c06:	d100      	bne.n	c0d00c0a <io_event+0x36>
c0d00c08:	e12b      	b.n	c0d00e62 <io_event+0x28e>
c0d00c0a:	2800      	cmp	r0, #0
c0d00c0c:	d100      	bne.n	c0d00c10 <io_event+0x3c>
c0d00c0e:	e128      	b.n	c0d00e62 <io_event+0x28e>
c0d00c10:	499b      	ldr	r1, [pc, #620]	; (c0d00e80 <io_event+0x2ac>)
c0d00c12:	4288      	cmp	r0, r1
c0d00c14:	d000      	beq.n	c0d00c18 <io_event+0x44>
c0d00c16:	e0ac      	b.n	c0d00d72 <io_event+0x19e>
c0d00c18:	2003      	movs	r0, #3
c0d00c1a:	7630      	strb	r0, [r6, #24]
c0d00c1c:	61f5      	str	r5, [r6, #28]
c0d00c1e:	4620      	mov	r0, r4
c0d00c20:	f001 fb56 	bl	c0d022d0 <os_ux>
c0d00c24:	61f0      	str	r0, [r6, #28]
c0d00c26:	f000 fd17 	bl	c0d01658 <io_seproxyhal_init_ux>
c0d00c2a:	60b5      	str	r5, [r6, #8]
c0d00c2c:	6830      	ldr	r0, [r6, #0]
c0d00c2e:	2800      	cmp	r0, #0
c0d00c30:	d100      	bne.n	c0d00c34 <io_event+0x60>
c0d00c32:	e116      	b.n	c0d00e62 <io_event+0x28e>
c0d00c34:	69f0      	ldr	r0, [r6, #28]
c0d00c36:	4991      	ldr	r1, [pc, #580]	; (c0d00e7c <io_event+0x2a8>)
c0d00c38:	4288      	cmp	r0, r1
c0d00c3a:	d000      	beq.n	c0d00c3e <io_event+0x6a>
c0d00c3c:	e096      	b.n	c0d00d6c <io_event+0x198>
c0d00c3e:	e110      	b.n	c0d00e62 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c40:	4d8d      	ldr	r5, [pc, #564]	; (c0d00e78 <io_event+0x2a4>)
c0d00c42:	2001      	movs	r0, #1
c0d00c44:	7628      	strb	r0, [r5, #24]
c0d00c46:	2600      	movs	r6, #0
c0d00c48:	61ee      	str	r6, [r5, #28]
c0d00c4a:	462c      	mov	r4, r5
c0d00c4c:	3418      	adds	r4, #24
c0d00c4e:	4620      	mov	r0, r4
c0d00c50:	f001 fb3e 	bl	c0d022d0 <os_ux>
c0d00c54:	4601      	mov	r1, r0
c0d00c56:	61e9      	str	r1, [r5, #28]
c0d00c58:	4889      	ldr	r0, [pc, #548]	; (c0d00e80 <io_event+0x2ac>)
c0d00c5a:	4281      	cmp	r1, r0
c0d00c5c:	d15d      	bne.n	c0d00d1a <io_event+0x146>
c0d00c5e:	2003      	movs	r0, #3
c0d00c60:	7628      	strb	r0, [r5, #24]
c0d00c62:	61ee      	str	r6, [r5, #28]
c0d00c64:	4620      	mov	r0, r4
c0d00c66:	f001 fb33 	bl	c0d022d0 <os_ux>
c0d00c6a:	61e8      	str	r0, [r5, #28]
c0d00c6c:	f000 fcf4 	bl	c0d01658 <io_seproxyhal_init_ux>
c0d00c70:	60ae      	str	r6, [r5, #8]
c0d00c72:	6828      	ldr	r0, [r5, #0]
c0d00c74:	2800      	cmp	r0, #0
c0d00c76:	d100      	bne.n	c0d00c7a <io_event+0xa6>
c0d00c78:	e0f3      	b.n	c0d00e62 <io_event+0x28e>
c0d00c7a:	69e8      	ldr	r0, [r5, #28]
c0d00c7c:	497f      	ldr	r1, [pc, #508]	; (c0d00e7c <io_event+0x2a8>)
c0d00c7e:	4288      	cmp	r0, r1
c0d00c80:	d148      	bne.n	c0d00d14 <io_event+0x140>
c0d00c82:	e0ee      	b.n	c0d00e62 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00c84:	4d7c      	ldr	r5, [pc, #496]	; (c0d00e78 <io_event+0x2a4>)
c0d00c86:	6868      	ldr	r0, [r5, #4]
c0d00c88:	68a9      	ldr	r1, [r5, #8]
c0d00c8a:	4281      	cmp	r1, r0
c0d00c8c:	d300      	bcc.n	c0d00c90 <io_event+0xbc>
c0d00c8e:	e0e8      	b.n	c0d00e62 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00c90:	2001      	movs	r0, #1
c0d00c92:	7628      	strb	r0, [r5, #24]
c0d00c94:	2600      	movs	r6, #0
c0d00c96:	61ee      	str	r6, [r5, #28]
c0d00c98:	462c      	mov	r4, r5
c0d00c9a:	3418      	adds	r4, #24
c0d00c9c:	4620      	mov	r0, r4
c0d00c9e:	f001 fb17 	bl	c0d022d0 <os_ux>
c0d00ca2:	61e8      	str	r0, [r5, #28]
c0d00ca4:	4975      	ldr	r1, [pc, #468]	; (c0d00e7c <io_event+0x2a8>)
c0d00ca6:	4288      	cmp	r0, r1
c0d00ca8:	d100      	bne.n	c0d00cac <io_event+0xd8>
c0d00caa:	e0da      	b.n	c0d00e62 <io_event+0x28e>
c0d00cac:	2800      	cmp	r0, #0
c0d00cae:	d100      	bne.n	c0d00cb2 <io_event+0xde>
c0d00cb0:	e0d7      	b.n	c0d00e62 <io_event+0x28e>
c0d00cb2:	4973      	ldr	r1, [pc, #460]	; (c0d00e80 <io_event+0x2ac>)
c0d00cb4:	4288      	cmp	r0, r1
c0d00cb6:	d000      	beq.n	c0d00cba <io_event+0xe6>
c0d00cb8:	e08d      	b.n	c0d00dd6 <io_event+0x202>
c0d00cba:	2003      	movs	r0, #3
c0d00cbc:	7628      	strb	r0, [r5, #24]
c0d00cbe:	61ee      	str	r6, [r5, #28]
c0d00cc0:	4620      	mov	r0, r4
c0d00cc2:	f001 fb05 	bl	c0d022d0 <os_ux>
c0d00cc6:	61e8      	str	r0, [r5, #28]
c0d00cc8:	f000 fcc6 	bl	c0d01658 <io_seproxyhal_init_ux>
c0d00ccc:	60ae      	str	r6, [r5, #8]
c0d00cce:	6828      	ldr	r0, [r5, #0]
c0d00cd0:	2800      	cmp	r0, #0
c0d00cd2:	d100      	bne.n	c0d00cd6 <io_event+0x102>
c0d00cd4:	e0c5      	b.n	c0d00e62 <io_event+0x28e>
c0d00cd6:	69e8      	ldr	r0, [r5, #28]
c0d00cd8:	4968      	ldr	r1, [pc, #416]	; (c0d00e7c <io_event+0x2a8>)
c0d00cda:	4288      	cmp	r0, r1
c0d00cdc:	d178      	bne.n	c0d00dd0 <io_event+0x1fc>
c0d00cde:	e0c0      	b.n	c0d00e62 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00ce0:	6868      	ldr	r0, [r5, #4]
c0d00ce2:	4286      	cmp	r6, r0
c0d00ce4:	d300      	bcc.n	c0d00ce8 <io_event+0x114>
c0d00ce6:	e0bc      	b.n	c0d00e62 <io_event+0x28e>
c0d00ce8:	f001 fb4a 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d00cec:	2800      	cmp	r0, #0
c0d00cee:	d000      	beq.n	c0d00cf2 <io_event+0x11e>
c0d00cf0:	e0b7      	b.n	c0d00e62 <io_event+0x28e>
c0d00cf2:	68a8      	ldr	r0, [r5, #8]
c0d00cf4:	68e9      	ldr	r1, [r5, #12]
c0d00cf6:	2438      	movs	r4, #56	; 0x38
c0d00cf8:	4360      	muls	r0, r4
c0d00cfa:	682a      	ldr	r2, [r5, #0]
c0d00cfc:	1810      	adds	r0, r2, r0
c0d00cfe:	2900      	cmp	r1, #0
c0d00d00:	d100      	bne.n	c0d00d04 <io_event+0x130>
c0d00d02:	e085      	b.n	c0d00e10 <io_event+0x23c>
c0d00d04:	4788      	blx	r1
c0d00d06:	2800      	cmp	r0, #0
c0d00d08:	d000      	beq.n	c0d00d0c <io_event+0x138>
c0d00d0a:	e081      	b.n	c0d00e10 <io_event+0x23c>
c0d00d0c:	68a8      	ldr	r0, [r5, #8]
c0d00d0e:	1c46      	adds	r6, r0, #1
c0d00d10:	60ae      	str	r6, [r5, #8]
c0d00d12:	6828      	ldr	r0, [r5, #0]
c0d00d14:	2800      	cmp	r0, #0
c0d00d16:	d1e3      	bne.n	c0d00ce0 <io_event+0x10c>
c0d00d18:	e0a3      	b.n	c0d00e62 <io_event+0x28e>
c0d00d1a:	6928      	ldr	r0, [r5, #16]
c0d00d1c:	2800      	cmp	r0, #0
c0d00d1e:	d100      	bne.n	c0d00d22 <io_event+0x14e>
c0d00d20:	e09f      	b.n	c0d00e62 <io_event+0x28e>
c0d00d22:	4a56      	ldr	r2, [pc, #344]	; (c0d00e7c <io_event+0x2a8>)
c0d00d24:	4291      	cmp	r1, r2
c0d00d26:	d100      	bne.n	c0d00d2a <io_event+0x156>
c0d00d28:	e09b      	b.n	c0d00e62 <io_event+0x28e>
c0d00d2a:	2900      	cmp	r1, #0
c0d00d2c:	d100      	bne.n	c0d00d30 <io_event+0x15c>
c0d00d2e:	e098      	b.n	c0d00e62 <io_event+0x28e>
c0d00d30:	4950      	ldr	r1, [pc, #320]	; (c0d00e74 <io_event+0x2a0>)
c0d00d32:	78c9      	ldrb	r1, [r1, #3]
c0d00d34:	0849      	lsrs	r1, r1, #1
c0d00d36:	f000 fe1b 	bl	c0d01970 <io_seproxyhal_button_push>
c0d00d3a:	e092      	b.n	c0d00e62 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00d3c:	6870      	ldr	r0, [r6, #4]
c0d00d3e:	4285      	cmp	r5, r0
c0d00d40:	d300      	bcc.n	c0d00d44 <io_event+0x170>
c0d00d42:	e08e      	b.n	c0d00e62 <io_event+0x28e>
c0d00d44:	f001 fb1c 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d00d48:	2800      	cmp	r0, #0
c0d00d4a:	d000      	beq.n	c0d00d4e <io_event+0x17a>
c0d00d4c:	e089      	b.n	c0d00e62 <io_event+0x28e>
c0d00d4e:	68b0      	ldr	r0, [r6, #8]
c0d00d50:	68f1      	ldr	r1, [r6, #12]
c0d00d52:	2438      	movs	r4, #56	; 0x38
c0d00d54:	4360      	muls	r0, r4
c0d00d56:	6832      	ldr	r2, [r6, #0]
c0d00d58:	1810      	adds	r0, r2, r0
c0d00d5a:	2900      	cmp	r1, #0
c0d00d5c:	d076      	beq.n	c0d00e4c <io_event+0x278>
c0d00d5e:	4788      	blx	r1
c0d00d60:	2800      	cmp	r0, #0
c0d00d62:	d173      	bne.n	c0d00e4c <io_event+0x278>
c0d00d64:	68b0      	ldr	r0, [r6, #8]
c0d00d66:	1c45      	adds	r5, r0, #1
c0d00d68:	60b5      	str	r5, [r6, #8]
c0d00d6a:	6830      	ldr	r0, [r6, #0]
c0d00d6c:	2800      	cmp	r0, #0
c0d00d6e:	d1e5      	bne.n	c0d00d3c <io_event+0x168>
c0d00d70:	e077      	b.n	c0d00e62 <io_event+0x28e>
c0d00d72:	88b0      	ldrh	r0, [r6, #4]
c0d00d74:	9004      	str	r0, [sp, #16]
c0d00d76:	6830      	ldr	r0, [r6, #0]
c0d00d78:	9003      	str	r0, [sp, #12]
c0d00d7a:	483e      	ldr	r0, [pc, #248]	; (c0d00e74 <io_event+0x2a0>)
c0d00d7c:	4601      	mov	r1, r0
c0d00d7e:	79cc      	ldrb	r4, [r1, #7]
c0d00d80:	798b      	ldrb	r3, [r1, #6]
c0d00d82:	794d      	ldrb	r5, [r1, #5]
c0d00d84:	790a      	ldrb	r2, [r1, #4]
c0d00d86:	4630      	mov	r0, r6
c0d00d88:	78ce      	ldrb	r6, [r1, #3]
c0d00d8a:	68c1      	ldr	r1, [r0, #12]
c0d00d8c:	4668      	mov	r0, sp
c0d00d8e:	6006      	str	r6, [r0, #0]
c0d00d90:	6041      	str	r1, [r0, #4]
c0d00d92:	0212      	lsls	r2, r2, #8
c0d00d94:	432a      	orrs	r2, r5
c0d00d96:	021b      	lsls	r3, r3, #8
c0d00d98:	4323      	orrs	r3, r4
c0d00d9a:	9803      	ldr	r0, [sp, #12]
c0d00d9c:	9904      	ldr	r1, [sp, #16]
c0d00d9e:	f000 fcd5 	bl	c0d0174c <io_seproxyhal_touch_element_callback>
c0d00da2:	e05e      	b.n	c0d00e62 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00da4:	6868      	ldr	r0, [r5, #4]
c0d00da6:	4286      	cmp	r6, r0
c0d00da8:	d25b      	bcs.n	c0d00e62 <io_event+0x28e>
c0d00daa:	f001 fae9 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d00dae:	2800      	cmp	r0, #0
c0d00db0:	d157      	bne.n	c0d00e62 <io_event+0x28e>
c0d00db2:	68a8      	ldr	r0, [r5, #8]
c0d00db4:	68e9      	ldr	r1, [r5, #12]
c0d00db6:	2438      	movs	r4, #56	; 0x38
c0d00db8:	4360      	muls	r0, r4
c0d00dba:	682a      	ldr	r2, [r5, #0]
c0d00dbc:	1810      	adds	r0, r2, r0
c0d00dbe:	2900      	cmp	r1, #0
c0d00dc0:	d026      	beq.n	c0d00e10 <io_event+0x23c>
c0d00dc2:	4788      	blx	r1
c0d00dc4:	2800      	cmp	r0, #0
c0d00dc6:	d123      	bne.n	c0d00e10 <io_event+0x23c>
c0d00dc8:	68a8      	ldr	r0, [r5, #8]
c0d00dca:	1c46      	adds	r6, r0, #1
c0d00dcc:	60ae      	str	r6, [r5, #8]
c0d00dce:	6828      	ldr	r0, [r5, #0]
c0d00dd0:	2800      	cmp	r0, #0
c0d00dd2:	d1e7      	bne.n	c0d00da4 <io_event+0x1d0>
c0d00dd4:	e045      	b.n	c0d00e62 <io_event+0x28e>
c0d00dd6:	6828      	ldr	r0, [r5, #0]
c0d00dd8:	2800      	cmp	r0, #0
c0d00dda:	d030      	beq.n	c0d00e3e <io_event+0x26a>
c0d00ddc:	68a8      	ldr	r0, [r5, #8]
c0d00dde:	6869      	ldr	r1, [r5, #4]
c0d00de0:	4288      	cmp	r0, r1
c0d00de2:	d22c      	bcs.n	c0d00e3e <io_event+0x26a>
c0d00de4:	f001 facc 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d00de8:	2800      	cmp	r0, #0
c0d00dea:	d128      	bne.n	c0d00e3e <io_event+0x26a>
c0d00dec:	68a8      	ldr	r0, [r5, #8]
c0d00dee:	68e9      	ldr	r1, [r5, #12]
c0d00df0:	2438      	movs	r4, #56	; 0x38
c0d00df2:	4360      	muls	r0, r4
c0d00df4:	682a      	ldr	r2, [r5, #0]
c0d00df6:	1810      	adds	r0, r2, r0
c0d00df8:	2900      	cmp	r1, #0
c0d00dfa:	d015      	beq.n	c0d00e28 <io_event+0x254>
c0d00dfc:	4788      	blx	r1
c0d00dfe:	2800      	cmp	r0, #0
c0d00e00:	d112      	bne.n	c0d00e28 <io_event+0x254>
c0d00e02:	68a8      	ldr	r0, [r5, #8]
c0d00e04:	1c40      	adds	r0, r0, #1
c0d00e06:	60a8      	str	r0, [r5, #8]
c0d00e08:	6829      	ldr	r1, [r5, #0]
c0d00e0a:	2900      	cmp	r1, #0
c0d00e0c:	d1e7      	bne.n	c0d00dde <io_event+0x20a>
c0d00e0e:	e016      	b.n	c0d00e3e <io_event+0x26a>
c0d00e10:	2801      	cmp	r0, #1
c0d00e12:	d103      	bne.n	c0d00e1c <io_event+0x248>
c0d00e14:	68a8      	ldr	r0, [r5, #8]
c0d00e16:	4344      	muls	r4, r0
c0d00e18:	6828      	ldr	r0, [r5, #0]
c0d00e1a:	1900      	adds	r0, r0, r4
c0d00e1c:	f000 fd66 	bl	c0d018ec <io_seproxyhal_display_default>
c0d00e20:	68a8      	ldr	r0, [r5, #8]
c0d00e22:	1c40      	adds	r0, r0, #1
c0d00e24:	60a8      	str	r0, [r5, #8]
c0d00e26:	e01c      	b.n	c0d00e62 <io_event+0x28e>
c0d00e28:	2801      	cmp	r0, #1
c0d00e2a:	d103      	bne.n	c0d00e34 <io_event+0x260>
c0d00e2c:	68a8      	ldr	r0, [r5, #8]
c0d00e2e:	4344      	muls	r4, r0
c0d00e30:	6828      	ldr	r0, [r5, #0]
c0d00e32:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00e34:	f000 fd5a 	bl	c0d018ec <io_seproxyhal_display_default>
c0d00e38:	68a8      	ldr	r0, [r5, #8]
c0d00e3a:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00e3c:	60a8      	str	r0, [r5, #8]
c0d00e3e:	6868      	ldr	r0, [r5, #4]
c0d00e40:	68a9      	ldr	r1, [r5, #8]
c0d00e42:	4281      	cmp	r1, r0
c0d00e44:	d30d      	bcc.n	c0d00e62 <io_event+0x28e>
c0d00e46:	f001 fa9b 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d00e4a:	e00a      	b.n	c0d00e62 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00e4c:	2801      	cmp	r0, #1
c0d00e4e:	d103      	bne.n	c0d00e58 <io_event+0x284>
c0d00e50:	68b0      	ldr	r0, [r6, #8]
c0d00e52:	4344      	muls	r4, r0
c0d00e54:	6830      	ldr	r0, [r6, #0]
c0d00e56:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00e58:	f000 fd48 	bl	c0d018ec <io_seproxyhal_display_default>
c0d00e5c:	68b0      	ldr	r0, [r6, #8]
c0d00e5e:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00e60:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00e62:	f001 fa8d 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d00e66:	2800      	cmp	r0, #0
c0d00e68:	d101      	bne.n	c0d00e6e <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00e6a:	f000 fac9 	bl	c0d01400 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00e6e:	2001      	movs	r0, #1
c0d00e70:	b005      	add	sp, #20
c0d00e72:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00e74:	20001a18 	.word	0x20001a18
c0d00e78:	20001a98 	.word	0x20001a98
c0d00e7c:	b0105044 	.word	0xb0105044
c0d00e80:	b0105055 	.word	0xb0105055

c0d00e84 <IOTA_main>:





static void IOTA_main(void) {
c0d00e84:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e86:	af03      	add	r7, sp, #12
c0d00e88:	b0dd      	sub	sp, #372	; 0x174
c0d00e8a:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00e8c:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00e8e:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00e90:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00e92:	a0a1      	add	r0, pc, #644	; (adr r0, c0d01118 <IOTA_main+0x294>)
c0d00e94:	2110      	movs	r1, #16
c0d00e96:	2203      	movs	r2, #3
c0d00e98:	9109      	str	r1, [sp, #36]	; 0x24
c0d00e9a:	9208      	str	r2, [sp, #32]
c0d00e9c:	f7ff f9e2 	bl	c0d00264 <write_debug>
c0d00ea0:	a80e      	add	r0, sp, #56	; 0x38
c0d00ea2:	304d      	adds	r0, #77	; 0x4d
c0d00ea4:	9007      	str	r0, [sp, #28]
c0d00ea6:	a80b      	add	r0, sp, #44	; 0x2c
c0d00ea8:	1dc1      	adds	r1, r0, #7
c0d00eaa:	9106      	str	r1, [sp, #24]
c0d00eac:	1d00      	adds	r0, r0, #4
c0d00eae:	9005      	str	r0, [sp, #20]
c0d00eb0:	4e9d      	ldr	r6, [pc, #628]	; (c0d01128 <IOTA_main+0x2a4>)
c0d00eb2:	6830      	ldr	r0, [r6, #0]
c0d00eb4:	e08d      	b.n	c0d00fd2 <IOTA_main+0x14e>
c0d00eb6:	489f      	ldr	r0, [pc, #636]	; (c0d01134 <IOTA_main+0x2b0>)
c0d00eb8:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00eba:	4330      	orrs	r0, r6
c0d00ebc:	2880      	cmp	r0, #128	; 0x80
c0d00ebe:	d000      	beq.n	c0d00ec2 <IOTA_main+0x3e>
c0d00ec0:	e11e      	b.n	c0d01100 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d00ec2:	7810      	ldrb	r0, [r2, #0]
c0d00ec4:	2800      	cmp	r0, #0
c0d00ec6:	4e98      	ldr	r6, [pc, #608]	; (c0d01128 <IOTA_main+0x2a4>)
c0d00ec8:	d004      	beq.n	c0d00ed4 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d00eca:	489c      	ldr	r0, [pc, #624]	; (c0d0113c <IOTA_main+0x2b8>)
c0d00ecc:	f001 f90c 	bl	c0d020e8 <cx_sha256_init>
                        hashTainted = 0;
c0d00ed0:	4899      	ldr	r0, [pc, #612]	; (c0d01138 <IOTA_main+0x2b4>)
c0d00ed2:	7004      	strb	r4, [r0, #0]
c0d00ed4:	4897      	ldr	r0, [pc, #604]	; (c0d01134 <IOTA_main+0x2b0>)
c0d00ed6:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00ed8:	7908      	ldrb	r0, [r1, #4]
c0d00eda:	1808      	adds	r0, r1, r0
c0d00edc:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00ede:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00ee0:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00ee2:	4308      	orrs	r0, r1
c0d00ee4:	905a      	str	r0, [sp, #360]	; 0x168
c0d00ee6:	e0e5      	b.n	c0d010b4 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00ee8:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00eea:	2818      	cmp	r0, #24
c0d00eec:	d800      	bhi.n	c0d00ef0 <IOTA_main+0x6c>
c0d00eee:	e10c      	b.n	c0d0110a <IOTA_main+0x286>
c0d00ef0:	950a      	str	r5, [sp, #40]	; 0x28
c0d00ef2:	4d90      	ldr	r5, [pc, #576]	; (c0d01134 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00ef4:	00a0      	lsls	r0, r4, #2
c0d00ef6:	1829      	adds	r1, r5, r0
c0d00ef8:	794a      	ldrb	r2, [r1, #5]
c0d00efa:	0612      	lsls	r2, r2, #24
c0d00efc:	798b      	ldrb	r3, [r1, #6]
c0d00efe:	041b      	lsls	r3, r3, #16
c0d00f00:	4313      	orrs	r3, r2
c0d00f02:	79ca      	ldrb	r2, [r1, #7]
c0d00f04:	0212      	lsls	r2, r2, #8
c0d00f06:	431a      	orrs	r2, r3
c0d00f08:	7a09      	ldrb	r1, [r1, #8]
c0d00f0a:	4311      	orrs	r1, r2
c0d00f0c:	aa2b      	add	r2, sp, #172	; 0xac
c0d00f0e:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00f10:	1c64      	adds	r4, r4, #1
c0d00f12:	2c05      	cmp	r4, #5
c0d00f14:	d1ee      	bne.n	c0d00ef4 <IOTA_main+0x70>
c0d00f16:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00f18:	9103      	str	r1, [sp, #12]
c0d00f1a:	4668      	mov	r0, sp
c0d00f1c:	6001      	str	r1, [r0, #0]
c0d00f1e:	2421      	movs	r4, #33	; 0x21
c0d00f20:	a92b      	add	r1, sp, #172	; 0xac
c0d00f22:	2205      	movs	r2, #5
c0d00f24:	ad23      	add	r5, sp, #140	; 0x8c
c0d00f26:	9502      	str	r5, [sp, #8]
c0d00f28:	4620      	mov	r0, r4
c0d00f2a:	462b      	mov	r3, r5
c0d00f2c:	f001 f992 	bl	c0d02254 <os_perso_derive_node_bip32>
c0d00f30:	2220      	movs	r2, #32
c0d00f32:	9204      	str	r2, [sp, #16]
c0d00f34:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00f36:	9301      	str	r3, [sp, #4]
c0d00f38:	4620      	mov	r0, r4
c0d00f3a:	4629      	mov	r1, r5
c0d00f3c:	f001 f94e 	bl	c0d021dc <cx_ecfp_init_private_key>
c0d00f40:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00f42:	4620      	mov	r0, r4
c0d00f44:	9903      	ldr	r1, [sp, #12]
c0d00f46:	460a      	mov	r2, r1
c0d00f48:	462b      	mov	r3, r5
c0d00f4a:	f001 f929 	bl	c0d021a0 <cx_ecfp_init_public_key>
c0d00f4e:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00f50:	4620      	mov	r0, r4
c0d00f52:	4629      	mov	r1, r5
c0d00f54:	9a01      	ldr	r2, [sp, #4]
c0d00f56:	f001 f95f 	bl	c0d02218 <cx_ecfp_generate_pair>
c0d00f5a:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00f5c:	9802      	ldr	r0, [sp, #8]
c0d00f5e:	9904      	ldr	r1, [sp, #16]
c0d00f60:	4622      	mov	r2, r4
c0d00f62:	f7ff fa5b 	bl	c0d0041c <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d00f66:	2552      	movs	r5, #82	; 0x52
c0d00f68:	4872      	ldr	r0, [pc, #456]	; (c0d01134 <IOTA_main+0x2b0>)
c0d00f6a:	4621      	mov	r1, r4
c0d00f6c:	462a      	mov	r2, r5
c0d00f6e:	f000 f9ad 	bl	c0d012cc <os_memmove>
                    tx = 82;
c0d00f72:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d00f74:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00f76:	1c41      	adds	r1, r0, #1
c0d00f78:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00f7a:	3610      	adds	r6, #16
c0d00f7c:	4a6d      	ldr	r2, [pc, #436]	; (c0d01134 <IOTA_main+0x2b0>)
c0d00f7e:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d00f80:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00f82:	1c41      	adds	r1, r0, #1
c0d00f84:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00f86:	9903      	ldr	r1, [sp, #12]
c0d00f88:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00f8a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00f8c:	b281      	uxth	r1, r0
c0d00f8e:	9804      	ldr	r0, [sp, #16]
c0d00f90:	f000 fd2a 	bl	c0d019e8 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00f94:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00f96:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00f98:	4308      	orrs	r0, r1
c0d00f9a:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d00f9c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00f9e:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d00fa0:	202e      	movs	r0, #46	; 0x2e
c0d00fa2:	9905      	ldr	r1, [sp, #20]
c0d00fa4:	7048      	strb	r0, [r1, #1]
c0d00fa6:	7008      	strb	r0, [r1, #0]
c0d00fa8:	7088      	strb	r0, [r1, #2]
c0d00faa:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d00fac:	78c8      	ldrb	r0, [r1, #3]
c0d00fae:	9a06      	ldr	r2, [sp, #24]
c0d00fb0:	70d0      	strb	r0, [r2, #3]
c0d00fb2:	7888      	ldrb	r0, [r1, #2]
c0d00fb4:	7090      	strb	r0, [r2, #2]
c0d00fb6:	7848      	ldrb	r0, [r1, #1]
c0d00fb8:	7050      	strb	r0, [r2, #1]
c0d00fba:	7808      	ldrb	r0, [r1, #0]
c0d00fbc:	7010      	strb	r0, [r2, #0]
c0d00fbe:	7908      	ldrb	r0, [r1, #4]
c0d00fc0:	7110      	strb	r0, [r2, #4]
c0d00fc2:	a80b      	add	r0, sp, #44	; 0x2c
                    

                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d00fc4:	2140      	movs	r1, #64	; 0x40
c0d00fc6:	2203      	movs	r2, #3
c0d00fc8:	f001 fa8a 	bl	c0d024e0 <ui_display_debug>
c0d00fcc:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d00fce:	4e56      	ldr	r6, [pc, #344]	; (c0d01128 <IOTA_main+0x2a4>)
c0d00fd0:	e070      	b.n	c0d010b4 <IOTA_main+0x230>
c0d00fd2:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00fd4:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00fd6:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00fd8:	ac4d      	add	r4, sp, #308	; 0x134
c0d00fda:	4620      	mov	r0, r4
c0d00fdc:	f002 fd26 	bl	c0d03a2c <setjmp>
c0d00fe0:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00fe2:	6034      	str	r4, [r6, #0]
c0d00fe4:	4951      	ldr	r1, [pc, #324]	; (c0d0112c <IOTA_main+0x2a8>)
c0d00fe6:	4208      	tst	r0, r1
c0d00fe8:	d011      	beq.n	c0d0100e <IOTA_main+0x18a>
c0d00fea:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00fec:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d00fee:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00ff0:	6031      	str	r1, [r6, #0]
c0d00ff2:	210f      	movs	r1, #15
c0d00ff4:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00ff6:	4001      	ands	r1, r0
c0d00ff8:	2209      	movs	r2, #9
c0d00ffa:	0312      	lsls	r2, r2, #12
c0d00ffc:	4291      	cmp	r1, r2
c0d00ffe:	d003      	beq.n	c0d01008 <IOTA_main+0x184>
c0d01000:	9a08      	ldr	r2, [sp, #32]
c0d01002:	0352      	lsls	r2, r2, #13
c0d01004:	4291      	cmp	r1, r2
c0d01006:	d142      	bne.n	c0d0108e <IOTA_main+0x20a>
c0d01008:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d0100a:	8008      	strh	r0, [r1, #0]
c0d0100c:	e046      	b.n	c0d0109c <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d0100e:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d01010:	905c      	str	r0, [sp, #368]	; 0x170
c0d01012:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d01014:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d01016:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d01018:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d0101a:	b2c0      	uxtb	r0, r0
c0d0101c:	b289      	uxth	r1, r1
c0d0101e:	f000 fce3 	bl	c0d019e8 <io_exchange>
c0d01022:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d01024:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d01026:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d01028:	2800      	cmp	r0, #0
c0d0102a:	d053      	beq.n	c0d010d4 <IOTA_main+0x250>
c0d0102c:	4941      	ldr	r1, [pc, #260]	; (c0d01134 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d0102e:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d01030:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d01032:	2880      	cmp	r0, #128	; 0x80
c0d01034:	4a40      	ldr	r2, [pc, #256]	; (c0d01138 <IOTA_main+0x2b4>)
c0d01036:	d155      	bne.n	c0d010e4 <IOTA_main+0x260>
c0d01038:	7848      	ldrb	r0, [r1, #1]
c0d0103a:	216d      	movs	r1, #109	; 0x6d
c0d0103c:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d0103e:	2807      	cmp	r0, #7
c0d01040:	dc3f      	bgt.n	c0d010c2 <IOTA_main+0x23e>
c0d01042:	2802      	cmp	r0, #2
c0d01044:	d100      	bne.n	c0d01048 <IOTA_main+0x1c4>
c0d01046:	e74f      	b.n	c0d00ee8 <IOTA_main+0x64>
c0d01048:	2804      	cmp	r0, #4
c0d0104a:	d153      	bne.n	c0d010f4 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d0104c:	210b      	movs	r1, #11
c0d0104e:	2203      	movs	r2, #3
c0d01050:	a03c      	add	r0, pc, #240	; (adr r0, c0d01144 <IOTA_main+0x2c0>)
c0d01052:	f7ff f907 	bl	c0d00264 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d01056:	2048      	movs	r0, #72	; 0x48
c0d01058:	4936      	ldr	r1, [pc, #216]	; (c0d01134 <IOTA_main+0x2b0>)
c0d0105a:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d0105c:	2049      	movs	r0, #73	; 0x49
c0d0105e:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d01060:	2021      	movs	r0, #33	; 0x21
c0d01062:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d01064:	3610      	adds	r6, #16
c0d01066:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d01068:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d0106a:	2005      	movs	r0, #5
c0d0106c:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d0106e:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d01070:	b281      	uxth	r1, r0
c0d01072:	2020      	movs	r0, #32
c0d01074:	f000 fcb8 	bl	c0d019e8 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d01078:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d0107a:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d0107c:	4308      	orrs	r0, r1
c0d0107e:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d01080:	4620      	mov	r0, r4
c0d01082:	4621      	mov	r1, r4
c0d01084:	4622      	mov	r2, r4
c0d01086:	f001 fa2b 	bl	c0d024e0 <ui_display_debug>
c0d0108a:	4e27      	ldr	r6, [pc, #156]	; (c0d01128 <IOTA_main+0x2a4>)
c0d0108c:	e012      	b.n	c0d010b4 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d0108e:	4928      	ldr	r1, [pc, #160]	; (c0d01130 <IOTA_main+0x2ac>)
c0d01090:	4008      	ands	r0, r1
c0d01092:	210d      	movs	r1, #13
c0d01094:	02c9      	lsls	r1, r1, #11
c0d01096:	4301      	orrs	r1, r0
c0d01098:	a859      	add	r0, sp, #356	; 0x164
c0d0109a:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d0109c:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d0109e:	0a00      	lsrs	r0, r0, #8
c0d010a0:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d010a2:	4a24      	ldr	r2, [pc, #144]	; (c0d01134 <IOTA_main+0x2b0>)
c0d010a4:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d010a6:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d010a8:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d010aa:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d010ac:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d010ae:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d010b0:	1c80      	adds	r0, r0, #2
c0d010b2:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d010b4:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d010b6:	6030      	str	r0, [r6, #0]
c0d010b8:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d010ba:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d010bc:	2900      	cmp	r1, #0
c0d010be:	d088      	beq.n	c0d00fd2 <IOTA_main+0x14e>
c0d010c0:	e006      	b.n	c0d010d0 <IOTA_main+0x24c>
c0d010c2:	2808      	cmp	r0, #8
c0d010c4:	d100      	bne.n	c0d010c8 <IOTA_main+0x244>
c0d010c6:	e6f6      	b.n	c0d00eb6 <IOTA_main+0x32>
c0d010c8:	28ff      	cmp	r0, #255	; 0xff
c0d010ca:	d113      	bne.n	c0d010f4 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d010cc:	b05d      	add	sp, #372	; 0x174
c0d010ce:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d010d0:	f002 fcb8 	bl	c0d03a44 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d010d4:	2001      	movs	r0, #1
c0d010d6:	4918      	ldr	r1, [pc, #96]	; (c0d01138 <IOTA_main+0x2b4>)
c0d010d8:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d010da:	4813      	ldr	r0, [pc, #76]	; (c0d01128 <IOTA_main+0x2a4>)
c0d010dc:	6800      	ldr	r0, [r0, #0]
c0d010de:	491c      	ldr	r1, [pc, #112]	; (c0d01150 <IOTA_main+0x2cc>)
c0d010e0:	f002 fcb0 	bl	c0d03a44 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d010e4:	2001      	movs	r0, #1
c0d010e6:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d010e8:	480f      	ldr	r0, [pc, #60]	; (c0d01128 <IOTA_main+0x2a4>)
c0d010ea:	6800      	ldr	r0, [r0, #0]
c0d010ec:	2137      	movs	r1, #55	; 0x37
c0d010ee:	0249      	lsls	r1, r1, #9
c0d010f0:	f002 fca8 	bl	c0d03a44 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d010f4:	2001      	movs	r0, #1
c0d010f6:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d010f8:	480b      	ldr	r0, [pc, #44]	; (c0d01128 <IOTA_main+0x2a4>)
c0d010fa:	6800      	ldr	r0, [r0, #0]
c0d010fc:	f002 fca2 	bl	c0d03a44 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d01100:	4809      	ldr	r0, [pc, #36]	; (c0d01128 <IOTA_main+0x2a4>)
c0d01102:	6800      	ldr	r0, [r0, #0]
c0d01104:	490e      	ldr	r1, [pc, #56]	; (c0d01140 <IOTA_main+0x2bc>)
c0d01106:	f002 fc9d 	bl	c0d03a44 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d0110a:	2001      	movs	r0, #1
c0d0110c:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d0110e:	4806      	ldr	r0, [pc, #24]	; (c0d01128 <IOTA_main+0x2a4>)
c0d01110:	6800      	ldr	r0, [r0, #0]
c0d01112:	3109      	adds	r1, #9
c0d01114:	f002 fc96 	bl	c0d03a44 <longjmp>
c0d01118:	74696157 	.word	0x74696157
c0d0111c:	20676e69 	.word	0x20676e69
c0d01120:	20726f66 	.word	0x20726f66
c0d01124:	0067736d 	.word	0x0067736d
c0d01128:	20001bb8 	.word	0x20001bb8
c0d0112c:	0000ffff 	.word	0x0000ffff
c0d01130:	000007ff 	.word	0x000007ff
c0d01134:	20001c08 	.word	0x20001c08
c0d01138:	20001b48 	.word	0x20001b48
c0d0113c:	20001b4c 	.word	0x20001b4c
c0d01140:	00006a86 	.word	0x00006a86
c0d01144:	20646142 	.word	0x20646142
c0d01148:	6b627550 	.word	0x6b627550
c0d0114c:	00007965 	.word	0x00007965
c0d01150:	00006982 	.word	0x00006982

c0d01154 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d01154:	4801      	ldr	r0, [pc, #4]	; (c0d0115c <os_boot+0x8>)
c0d01156:	2100      	movs	r1, #0
c0d01158:	6001      	str	r1, [r0, #0]
}
c0d0115a:	4770      	bx	lr
c0d0115c:	20001bb8 	.word	0x20001bb8

c0d01160 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d01160:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01162:	af03      	add	r7, sp, #12
c0d01164:	b083      	sub	sp, #12
c0d01166:	9202      	str	r2, [sp, #8]
c0d01168:	460c      	mov	r4, r1
c0d0116a:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d0116c:	4d4a      	ldr	r5, [pc, #296]	; (c0d01298 <io_usb_hid_receive+0x138>)
c0d0116e:	42ac      	cmp	r4, r5
c0d01170:	d00f      	beq.n	c0d01192 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01172:	4e49      	ldr	r6, [pc, #292]	; (c0d01298 <io_usb_hid_receive+0x138>)
c0d01174:	2540      	movs	r5, #64	; 0x40
c0d01176:	4630      	mov	r0, r6
c0d01178:	4629      	mov	r1, r5
c0d0117a:	f002 fbc1 	bl	c0d03900 <__aeabi_memclr>
c0d0117e:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d01180:	2840      	cmp	r0, #64	; 0x40
c0d01182:	4602      	mov	r2, r0
c0d01184:	d300      	bcc.n	c0d01188 <io_usb_hid_receive+0x28>
c0d01186:	462a      	mov	r2, r5
c0d01188:	4630      	mov	r0, r6
c0d0118a:	4621      	mov	r1, r4
c0d0118c:	f000 f89e 	bl	c0d012cc <os_memmove>
c0d01190:	4d41      	ldr	r5, [pc, #260]	; (c0d01298 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d01192:	78a8      	ldrb	r0, [r5, #2]
c0d01194:	2805      	cmp	r0, #5
c0d01196:	d900      	bls.n	c0d0119a <io_usb_hid_receive+0x3a>
c0d01198:	e076      	b.n	c0d01288 <io_usb_hid_receive+0x128>
c0d0119a:	46c0      	nop			; (mov r8, r8)
c0d0119c:	4478      	add	r0, pc
c0d0119e:	7900      	ldrb	r0, [r0, #4]
c0d011a0:	0040      	lsls	r0, r0, #1
c0d011a2:	4487      	add	pc, r0
c0d011a4:	71130c02 	.word	0x71130c02
c0d011a8:	1f71      	.short	0x1f71
c0d011aa:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d011ac:	71ae      	strb	r6, [r5, #6]
c0d011ae:	716e      	strb	r6, [r5, #5]
c0d011b0:	712e      	strb	r6, [r5, #4]
c0d011b2:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d011b4:	2140      	movs	r1, #64	; 0x40
c0d011b6:	4628      	mov	r0, r5
c0d011b8:	9a01      	ldr	r2, [sp, #4]
c0d011ba:	4790      	blx	r2
c0d011bc:	e00b      	b.n	c0d011d6 <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d011be:	1ce8      	adds	r0, r5, #3
c0d011c0:	2104      	movs	r1, #4
c0d011c2:	f000 ff73 	bl	c0d020ac <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d011c6:	2140      	movs	r1, #64	; 0x40
c0d011c8:	4628      	mov	r0, r5
c0d011ca:	e001      	b.n	c0d011d0 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d011cc:	4832      	ldr	r0, [pc, #200]	; (c0d01298 <io_usb_hid_receive+0x138>)
c0d011ce:	2140      	movs	r1, #64	; 0x40
c0d011d0:	9a01      	ldr	r2, [sp, #4]
c0d011d2:	4790      	blx	r2
c0d011d4:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d011d6:	4831      	ldr	r0, [pc, #196]	; (c0d0129c <io_usb_hid_receive+0x13c>)
c0d011d8:	2100      	movs	r1, #0
c0d011da:	6001      	str	r1, [r0, #0]
c0d011dc:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d011de:	b2c0      	uxtb	r0, r0
c0d011e0:	b003      	add	sp, #12
c0d011e2:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d011e4:	78e8      	ldrb	r0, [r5, #3]
c0d011e6:	4c2d      	ldr	r4, [pc, #180]	; (c0d0129c <io_usb_hid_receive+0x13c>)
c0d011e8:	6821      	ldr	r1, [r4, #0]
c0d011ea:	0a09      	lsrs	r1, r1, #8
c0d011ec:	2600      	movs	r6, #0
c0d011ee:	4288      	cmp	r0, r1
c0d011f0:	d1f1      	bne.n	c0d011d6 <io_usb_hid_receive+0x76>
c0d011f2:	7928      	ldrb	r0, [r5, #4]
c0d011f4:	6821      	ldr	r1, [r4, #0]
c0d011f6:	b2c9      	uxtb	r1, r1
c0d011f8:	4288      	cmp	r0, r1
c0d011fa:	d1ec      	bne.n	c0d011d6 <io_usb_hid_receive+0x76>
c0d011fc:	4b28      	ldr	r3, [pc, #160]	; (c0d012a0 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d011fe:	9802      	ldr	r0, [sp, #8]
c0d01200:	18c0      	adds	r0, r0, r3
c0d01202:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d01204:	6820      	ldr	r0, [r4, #0]
c0d01206:	2800      	cmp	r0, #0
c0d01208:	d00e      	beq.n	c0d01228 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d0120a:	4629      	mov	r1, r5
c0d0120c:	4019      	ands	r1, r3
c0d0120e:	4825      	ldr	r0, [pc, #148]	; (c0d012a4 <io_usb_hid_receive+0x144>)
c0d01210:	6802      	ldr	r2, [r0, #0]
c0d01212:	4291      	cmp	r1, r2
c0d01214:	461e      	mov	r6, r3
c0d01216:	d900      	bls.n	c0d0121a <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d01218:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d0121a:	462a      	mov	r2, r5
c0d0121c:	4032      	ands	r2, r6
c0d0121e:	4822      	ldr	r0, [pc, #136]	; (c0d012a8 <io_usb_hid_receive+0x148>)
c0d01220:	6800      	ldr	r0, [r0, #0]
c0d01222:	491d      	ldr	r1, [pc, #116]	; (c0d01298 <io_usb_hid_receive+0x138>)
c0d01224:	1d49      	adds	r1, r1, #5
c0d01226:	e021      	b.n	c0d0126c <io_usb_hid_receive+0x10c>
c0d01228:	9301      	str	r3, [sp, #4]
c0d0122a:	491b      	ldr	r1, [pc, #108]	; (c0d01298 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d0122c:	7988      	ldrb	r0, [r1, #6]
c0d0122e:	7949      	ldrb	r1, [r1, #5]
c0d01230:	0209      	lsls	r1, r1, #8
c0d01232:	4301      	orrs	r1, r0
c0d01234:	481d      	ldr	r0, [pc, #116]	; (c0d012ac <io_usb_hid_receive+0x14c>)
c0d01236:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d01238:	6801      	ldr	r1, [r0, #0]
c0d0123a:	2241      	movs	r2, #65	; 0x41
c0d0123c:	0092      	lsls	r2, r2, #2
c0d0123e:	4291      	cmp	r1, r2
c0d01240:	d8c9      	bhi.n	c0d011d6 <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d01242:	6801      	ldr	r1, [r0, #0]
c0d01244:	4817      	ldr	r0, [pc, #92]	; (c0d012a4 <io_usb_hid_receive+0x144>)
c0d01246:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01248:	4917      	ldr	r1, [pc, #92]	; (c0d012a8 <io_usb_hid_receive+0x148>)
c0d0124a:	4a19      	ldr	r2, [pc, #100]	; (c0d012b0 <io_usb_hid_receive+0x150>)
c0d0124c:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d0124e:	4919      	ldr	r1, [pc, #100]	; (c0d012b4 <io_usb_hid_receive+0x154>)
c0d01250:	9a02      	ldr	r2, [sp, #8]
c0d01252:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d01254:	4629      	mov	r1, r5
c0d01256:	9e01      	ldr	r6, [sp, #4]
c0d01258:	4031      	ands	r1, r6
c0d0125a:	6802      	ldr	r2, [r0, #0]
c0d0125c:	4291      	cmp	r1, r2
c0d0125e:	d900      	bls.n	c0d01262 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d01260:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d01262:	462a      	mov	r2, r5
c0d01264:	4032      	ands	r2, r6
c0d01266:	480c      	ldr	r0, [pc, #48]	; (c0d01298 <io_usb_hid_receive+0x138>)
c0d01268:	1dc1      	adds	r1, r0, #7
c0d0126a:	4811      	ldr	r0, [pc, #68]	; (c0d012b0 <io_usb_hid_receive+0x150>)
c0d0126c:	f000 f82e 	bl	c0d012cc <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d01270:	4035      	ands	r5, r6
c0d01272:	480d      	ldr	r0, [pc, #52]	; (c0d012a8 <io_usb_hid_receive+0x148>)
c0d01274:	6801      	ldr	r1, [r0, #0]
c0d01276:	1949      	adds	r1, r1, r5
c0d01278:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d0127a:	480a      	ldr	r0, [pc, #40]	; (c0d012a4 <io_usb_hid_receive+0x144>)
c0d0127c:	6801      	ldr	r1, [r0, #0]
c0d0127e:	1b49      	subs	r1, r1, r5
c0d01280:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d01282:	6820      	ldr	r0, [r4, #0]
c0d01284:	1c40      	adds	r0, r0, #1
c0d01286:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d01288:	4806      	ldr	r0, [pc, #24]	; (c0d012a4 <io_usb_hid_receive+0x144>)
c0d0128a:	6801      	ldr	r1, [r0, #0]
c0d0128c:	2001      	movs	r0, #1
c0d0128e:	2602      	movs	r6, #2
c0d01290:	2900      	cmp	r1, #0
c0d01292:	d1a4      	bne.n	c0d011de <io_usb_hid_receive+0x7e>
c0d01294:	e79f      	b.n	c0d011d6 <io_usb_hid_receive+0x76>
c0d01296:	46c0      	nop			; (mov r8, r8)
c0d01298:	20001bbc 	.word	0x20001bbc
c0d0129c:	20001bfc 	.word	0x20001bfc
c0d012a0:	0000ffff 	.word	0x0000ffff
c0d012a4:	20001c04 	.word	0x20001c04
c0d012a8:	20001d0c 	.word	0x20001d0c
c0d012ac:	20001c00 	.word	0x20001c00
c0d012b0:	20001c08 	.word	0x20001c08
c0d012b4:	0001fff9 	.word	0x0001fff9

c0d012b8 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d012b8:	b580      	push	{r7, lr}
c0d012ba:	af00      	add	r7, sp, #0
c0d012bc:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d012be:	2a00      	cmp	r2, #0
c0d012c0:	d003      	beq.n	c0d012ca <os_memset+0x12>
    DSTCHAR[length] = c;
c0d012c2:	4611      	mov	r1, r2
c0d012c4:	461a      	mov	r2, r3
c0d012c6:	f002 fb25 	bl	c0d03914 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d012ca:	bd80      	pop	{r7, pc}

c0d012cc <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d012cc:	b5b0      	push	{r4, r5, r7, lr}
c0d012ce:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d012d0:	4288      	cmp	r0, r1
c0d012d2:	d90d      	bls.n	c0d012f0 <os_memmove+0x24>
    while(length--) {
c0d012d4:	2a00      	cmp	r2, #0
c0d012d6:	d014      	beq.n	c0d01302 <os_memmove+0x36>
c0d012d8:	1e49      	subs	r1, r1, #1
c0d012da:	4252      	negs	r2, r2
c0d012dc:	1e40      	subs	r0, r0, #1
c0d012de:	2300      	movs	r3, #0
c0d012e0:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d012e2:	461c      	mov	r4, r3
c0d012e4:	4354      	muls	r4, r2
c0d012e6:	5d0d      	ldrb	r5, [r1, r4]
c0d012e8:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d012ea:	1c52      	adds	r2, r2, #1
c0d012ec:	d1f9      	bne.n	c0d012e2 <os_memmove+0x16>
c0d012ee:	e008      	b.n	c0d01302 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d012f0:	2a00      	cmp	r2, #0
c0d012f2:	d006      	beq.n	c0d01302 <os_memmove+0x36>
c0d012f4:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d012f6:	b29c      	uxth	r4, r3
c0d012f8:	5d0d      	ldrb	r5, [r1, r4]
c0d012fa:	5505      	strb	r5, [r0, r4]
      l++;
c0d012fc:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d012fe:	1e52      	subs	r2, r2, #1
c0d01300:	d1f9      	bne.n	c0d012f6 <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d01302:	bdb0      	pop	{r4, r5, r7, pc}

c0d01304 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01304:	4801      	ldr	r0, [pc, #4]	; (c0d0130c <io_usb_hid_init+0x8>)
c0d01306:	2100      	movs	r1, #0
c0d01308:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d0130a:	4770      	bx	lr
c0d0130c:	20001bfc 	.word	0x20001bfc

c0d01310 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d01310:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01312:	af03      	add	r7, sp, #12
c0d01314:	b087      	sub	sp, #28
c0d01316:	9301      	str	r3, [sp, #4]
c0d01318:	9203      	str	r2, [sp, #12]
c0d0131a:	460e      	mov	r6, r1
c0d0131c:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d0131e:	2e00      	cmp	r6, #0
c0d01320:	d042      	beq.n	c0d013a8 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d01322:	4d31      	ldr	r5, [pc, #196]	; (c0d013e8 <io_usb_hid_exchange+0xd8>)
c0d01324:	2000      	movs	r0, #0
c0d01326:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01328:	4930      	ldr	r1, [pc, #192]	; (c0d013ec <io_usb_hid_exchange+0xdc>)
c0d0132a:	4831      	ldr	r0, [pc, #196]	; (c0d013f0 <io_usb_hid_exchange+0xe0>)
c0d0132c:	6008      	str	r0, [r1, #0]
c0d0132e:	4c31      	ldr	r4, [pc, #196]	; (c0d013f4 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01330:	1d60      	adds	r0, r4, #5
c0d01332:	213b      	movs	r1, #59	; 0x3b
c0d01334:	9005      	str	r0, [sp, #20]
c0d01336:	9102      	str	r1, [sp, #8]
c0d01338:	f002 fae2 	bl	c0d03900 <__aeabi_memclr>
c0d0133c:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d0133e:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d01340:	6828      	ldr	r0, [r5, #0]
c0d01342:	0a00      	lsrs	r0, r0, #8
c0d01344:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d01346:	6828      	ldr	r0, [r5, #0]
c0d01348:	7120      	strb	r0, [r4, #4]
c0d0134a:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d0134c:	6828      	ldr	r0, [r5, #0]
c0d0134e:	2800      	cmp	r0, #0
c0d01350:	9106      	str	r1, [sp, #24]
c0d01352:	d009      	beq.n	c0d01368 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d01354:	293b      	cmp	r1, #59	; 0x3b
c0d01356:	460a      	mov	r2, r1
c0d01358:	d300      	bcc.n	c0d0135c <io_usb_hid_exchange+0x4c>
c0d0135a:	9a02      	ldr	r2, [sp, #8]
c0d0135c:	4823      	ldr	r0, [pc, #140]	; (c0d013ec <io_usb_hid_exchange+0xdc>)
c0d0135e:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d01360:	6819      	ldr	r1, [r3, #0]
c0d01362:	9805      	ldr	r0, [sp, #20]
c0d01364:	461e      	mov	r6, r3
c0d01366:	e00a      	b.n	c0d0137e <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d01368:	0a30      	lsrs	r0, r6, #8
c0d0136a:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d0136c:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d0136e:	2039      	movs	r0, #57	; 0x39
c0d01370:	2939      	cmp	r1, #57	; 0x39
c0d01372:	460a      	mov	r2, r1
c0d01374:	d300      	bcc.n	c0d01378 <io_usb_hid_exchange+0x68>
c0d01376:	4602      	mov	r2, r0
c0d01378:	4e1c      	ldr	r6, [pc, #112]	; (c0d013ec <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d0137a:	6831      	ldr	r1, [r6, #0]
c0d0137c:	1de0      	adds	r0, r4, #7
c0d0137e:	9205      	str	r2, [sp, #20]
c0d01380:	f7ff ffa4 	bl	c0d012cc <os_memmove>
c0d01384:	4d18      	ldr	r5, [pc, #96]	; (c0d013e8 <io_usb_hid_exchange+0xd8>)
c0d01386:	6830      	ldr	r0, [r6, #0]
c0d01388:	4631      	mov	r1, r6
c0d0138a:	9e05      	ldr	r6, [sp, #20]
c0d0138c:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d0138e:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d01390:	6828      	ldr	r0, [r5, #0]
c0d01392:	1c40      	adds	r0, r0, #1
c0d01394:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d01396:	2140      	movs	r1, #64	; 0x40
c0d01398:	4620      	mov	r0, r4
c0d0139a:	9a04      	ldr	r2, [sp, #16]
c0d0139c:	4790      	blx	r2
c0d0139e:	9806      	ldr	r0, [sp, #24]
c0d013a0:	1b86      	subs	r6, r0, r6
c0d013a2:	4815      	ldr	r0, [pc, #84]	; (c0d013f8 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d013a4:	4206      	tst	r6, r0
c0d013a6:	d1c3      	bne.n	c0d01330 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d013a8:	480f      	ldr	r0, [pc, #60]	; (c0d013e8 <io_usb_hid_exchange+0xd8>)
c0d013aa:	2400      	movs	r4, #0
c0d013ac:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d013ae:	2080      	movs	r0, #128	; 0x80
c0d013b0:	9901      	ldr	r1, [sp, #4]
c0d013b2:	4201      	tst	r1, r0
c0d013b4:	d001      	beq.n	c0d013ba <io_usb_hid_exchange+0xaa>
    reset();
c0d013b6:	f000 fe3f 	bl	c0d02038 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d013ba:	9801      	ldr	r0, [sp, #4]
c0d013bc:	0680      	lsls	r0, r0, #26
c0d013be:	d40f      	bmi.n	c0d013e0 <io_usb_hid_exchange+0xd0>
c0d013c0:	4c0c      	ldr	r4, [pc, #48]	; (c0d013f4 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d013c2:	2140      	movs	r1, #64	; 0x40
c0d013c4:	4620      	mov	r0, r4
c0d013c6:	9a03      	ldr	r2, [sp, #12]
c0d013c8:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d013ca:	b2c2      	uxtb	r2, r0
c0d013cc:	2a40      	cmp	r2, #64	; 0x40
c0d013ce:	d8f8      	bhi.n	c0d013c2 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d013d0:	9804      	ldr	r0, [sp, #16]
c0d013d2:	4621      	mov	r1, r4
c0d013d4:	f7ff fec4 	bl	c0d01160 <io_usb_hid_receive>
c0d013d8:	2802      	cmp	r0, #2
c0d013da:	d1f2      	bne.n	c0d013c2 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d013dc:	4807      	ldr	r0, [pc, #28]	; (c0d013fc <io_usb_hid_exchange+0xec>)
c0d013de:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d013e0:	b2a0      	uxth	r0, r4
c0d013e2:	b007      	add	sp, #28
c0d013e4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d013e6:	46c0      	nop			; (mov r8, r8)
c0d013e8:	20001bfc 	.word	0x20001bfc
c0d013ec:	20001d0c 	.word	0x20001d0c
c0d013f0:	20001c08 	.word	0x20001c08
c0d013f4:	20001bbc 	.word	0x20001bbc
c0d013f8:	0000ffff 	.word	0x0000ffff
c0d013fc:	20001c00 	.word	0x20001c00

c0d01400 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d01400:	b580      	push	{r7, lr}
c0d01402:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d01404:	f000 ffbc 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d01408:	2800      	cmp	r0, #0
c0d0140a:	d10b      	bne.n	c0d01424 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d0140c:	4806      	ldr	r0, [pc, #24]	; (c0d01428 <io_seproxyhal_general_status+0x28>)
c0d0140e:	2160      	movs	r1, #96	; 0x60
c0d01410:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d01412:	2100      	movs	r1, #0
c0d01414:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d01416:	2202      	movs	r2, #2
c0d01418:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d0141a:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d0141c:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d0141e:	2105      	movs	r1, #5
c0d01420:	f000 ff90 	bl	c0d02344 <io_seproxyhal_spi_send>
}
c0d01424:	bd80      	pop	{r7, pc}
c0d01426:	46c0      	nop			; (mov r8, r8)
c0d01428:	20001a18 	.word	0x20001a18

c0d0142c <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d0142c:	b5d0      	push	{r4, r6, r7, lr}
c0d0142e:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d01430:	4815      	ldr	r0, [pc, #84]	; (c0d01488 <io_seproxyhal_handle_usb_event+0x5c>)
c0d01432:	78c0      	ldrb	r0, [r0, #3]
c0d01434:	1e40      	subs	r0, r0, #1
c0d01436:	2807      	cmp	r0, #7
c0d01438:	d824      	bhi.n	c0d01484 <io_seproxyhal_handle_usb_event+0x58>
c0d0143a:	46c0      	nop			; (mov r8, r8)
c0d0143c:	4478      	add	r0, pc
c0d0143e:	7900      	ldrb	r0, [r0, #4]
c0d01440:	0040      	lsls	r0, r0, #1
c0d01442:	4487      	add	pc, r0
c0d01444:	141f1803 	.word	0x141f1803
c0d01448:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d0144c:	4c0f      	ldr	r4, [pc, #60]	; (c0d0148c <io_seproxyhal_handle_usb_event+0x60>)
c0d0144e:	2101      	movs	r1, #1
c0d01450:	4620      	mov	r0, r4
c0d01452:	f001 fbd5 	bl	c0d02c00 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d01456:	4620      	mov	r0, r4
c0d01458:	f001 fbba 	bl	c0d02bd0 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d0145c:	480c      	ldr	r0, [pc, #48]	; (c0d01490 <io_seproxyhal_handle_usb_event+0x64>)
c0d0145e:	7800      	ldrb	r0, [r0, #0]
c0d01460:	2801      	cmp	r0, #1
c0d01462:	d10f      	bne.n	c0d01484 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d01464:	480b      	ldr	r0, [pc, #44]	; (c0d01494 <io_seproxyhal_handle_usb_event+0x68>)
c0d01466:	6800      	ldr	r0, [r0, #0]
c0d01468:	2110      	movs	r1, #16
c0d0146a:	f002 faeb 	bl	c0d03a44 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d0146e:	4807      	ldr	r0, [pc, #28]	; (c0d0148c <io_seproxyhal_handle_usb_event+0x60>)
c0d01470:	f001 fbc9 	bl	c0d02c06 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d01474:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d01476:	4805      	ldr	r0, [pc, #20]	; (c0d0148c <io_seproxyhal_handle_usb_event+0x60>)
c0d01478:	f001 fbc9 	bl	c0d02c0e <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d0147c:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d0147e:	4803      	ldr	r0, [pc, #12]	; (c0d0148c <io_seproxyhal_handle_usb_event+0x60>)
c0d01480:	f001 fbc3 	bl	c0d02c0a <USBD_LL_Resume>
      break;
  }
}
c0d01484:	bdd0      	pop	{r4, r6, r7, pc}
c0d01486:	46c0      	nop			; (mov r8, r8)
c0d01488:	20001a18 	.word	0x20001a18
c0d0148c:	20001d34 	.word	0x20001d34
c0d01490:	20001d10 	.word	0x20001d10
c0d01494:	20001bb8 	.word	0x20001bb8

c0d01498 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d01498:	217f      	movs	r1, #127	; 0x7f
c0d0149a:	4001      	ands	r1, r0
c0d0149c:	4801      	ldr	r0, [pc, #4]	; (c0d014a4 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d0149e:	5c40      	ldrb	r0, [r0, r1]
c0d014a0:	4770      	bx	lr
c0d014a2:	46c0      	nop			; (mov r8, r8)
c0d014a4:	20001d11 	.word	0x20001d11

c0d014a8 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d014a8:	b580      	push	{r7, lr}
c0d014aa:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d014ac:	480f      	ldr	r0, [pc, #60]	; (c0d014ec <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d014ae:	7901      	ldrb	r1, [r0, #4]
c0d014b0:	2904      	cmp	r1, #4
c0d014b2:	d008      	beq.n	c0d014c6 <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d014b4:	2902      	cmp	r1, #2
c0d014b6:	d011      	beq.n	c0d014dc <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d014b8:	2901      	cmp	r1, #1
c0d014ba:	d10e      	bne.n	c0d014da <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d014bc:	1d81      	adds	r1, r0, #6
c0d014be:	480d      	ldr	r0, [pc, #52]	; (c0d014f4 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d014c0:	f001 faaa 	bl	c0d02a18 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d014c4:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d014c6:	78c2      	ldrb	r2, [r0, #3]
c0d014c8:	217f      	movs	r1, #127	; 0x7f
c0d014ca:	4011      	ands	r1, r2
c0d014cc:	7942      	ldrb	r2, [r0, #5]
c0d014ce:	4b08      	ldr	r3, [pc, #32]	; (c0d014f0 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d014d0:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d014d2:	1d82      	adds	r2, r0, #6
c0d014d4:	4807      	ldr	r0, [pc, #28]	; (c0d014f4 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d014d6:	f001 fad1 	bl	c0d02a7c <USBD_LL_DataOutStage>
      break;
  }
}
c0d014da:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d014dc:	78c2      	ldrb	r2, [r0, #3]
c0d014de:	217f      	movs	r1, #127	; 0x7f
c0d014e0:	4011      	ands	r1, r2
c0d014e2:	1d82      	adds	r2, r0, #6
c0d014e4:	4803      	ldr	r0, [pc, #12]	; (c0d014f4 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d014e6:	f001 fb0f 	bl	c0d02b08 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d014ea:	bd80      	pop	{r7, pc}
c0d014ec:	20001a18 	.word	0x20001a18
c0d014f0:	20001d11 	.word	0x20001d11
c0d014f4:	20001d34 	.word	0x20001d34

c0d014f8 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d014f8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d014fa:	af03      	add	r7, sp, #12
c0d014fc:	b083      	sub	sp, #12
c0d014fe:	9201      	str	r2, [sp, #4]
c0d01500:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d01502:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d01504:	2b00      	cmp	r3, #0
c0d01506:	d100      	bne.n	c0d0150a <io_usb_send_ep+0x12>
c0d01508:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d0150a:	9801      	ldr	r0, [sp, #4]
c0d0150c:	28ff      	cmp	r0, #255	; 0xff
c0d0150e:	d843      	bhi.n	c0d01598 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01510:	4e25      	ldr	r6, [pc, #148]	; (c0d015a8 <io_usb_send_ep+0xb0>)
c0d01512:	2050      	movs	r0, #80	; 0x50
c0d01514:	7030      	strb	r0, [r6, #0]
c0d01516:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d01518:	1ce0      	adds	r0, r4, #3
c0d0151a:	9100      	str	r1, [sp, #0]
c0d0151c:	0a01      	lsrs	r1, r0, #8
c0d0151e:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d01520:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d01522:	2080      	movs	r0, #128	; 0x80
c0d01524:	4302      	orrs	r2, r0
c0d01526:	9202      	str	r2, [sp, #8]
c0d01528:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0152a:	2020      	movs	r0, #32
c0d0152c:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d0152e:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d01530:	2106      	movs	r1, #6
c0d01532:	4630      	mov	r0, r6
c0d01534:	f000 ff06 	bl	c0d02344 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d01538:	9800      	ldr	r0, [sp, #0]
c0d0153a:	4621      	mov	r1, r4
c0d0153c:	f000 ff02 	bl	c0d02344 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d01540:	2d00      	cmp	r5, #0
c0d01542:	d10d      	bne.n	c0d01560 <io_usb_send_ep+0x68>
c0d01544:	e028      	b.n	c0d01598 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d01546:	2d00      	cmp	r5, #0
c0d01548:	d002      	beq.n	c0d01550 <io_usb_send_ep+0x58>
c0d0154a:	1e6c      	subs	r4, r5, #1
c0d0154c:	2d01      	cmp	r5, #1
c0d0154e:	d025      	beq.n	c0d0159c <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d01550:	2915      	cmp	r1, #21
c0d01552:	d102      	bne.n	c0d0155a <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d01554:	79b0      	ldrb	r0, [r6, #6]
c0d01556:	0700      	lsls	r0, r0, #28
c0d01558:	d520      	bpl.n	c0d0159c <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d0155a:	f000 f829 	bl	c0d015b0 <io_seproxyhal_handle_event>
c0d0155e:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01560:	f000 ff0e 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d01564:	2800      	cmp	r0, #0
c0d01566:	d101      	bne.n	c0d0156c <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d01568:	f7ff ff4a 	bl	c0d01400 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0156c:	2180      	movs	r1, #128	; 0x80
c0d0156e:	2400      	movs	r4, #0
c0d01570:	4630      	mov	r0, r6
c0d01572:	4622      	mov	r2, r4
c0d01574:	f000 ff20 	bl	c0d023b8 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d01578:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d0157a:	2806      	cmp	r0, #6
c0d0157c:	d1e3      	bne.n	c0d01546 <io_usb_send_ep+0x4e>
c0d0157e:	2910      	cmp	r1, #16
c0d01580:	d1e1      	bne.n	c0d01546 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d01582:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d01584:	9a02      	ldr	r2, [sp, #8]
c0d01586:	4290      	cmp	r0, r2
c0d01588:	d1dd      	bne.n	c0d01546 <io_usb_send_ep+0x4e>
c0d0158a:	7930      	ldrb	r0, [r6, #4]
c0d0158c:	2802      	cmp	r0, #2
c0d0158e:	d1da      	bne.n	c0d01546 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d01590:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d01592:	9a01      	ldr	r2, [sp, #4]
c0d01594:	4290      	cmp	r0, r2
c0d01596:	d1d6      	bne.n	c0d01546 <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d01598:	b003      	add	sp, #12
c0d0159a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0159c:	4803      	ldr	r0, [pc, #12]	; (c0d015ac <io_usb_send_ep+0xb4>)
c0d0159e:	6800      	ldr	r0, [r0, #0]
c0d015a0:	2110      	movs	r1, #16
c0d015a2:	f002 fa4f 	bl	c0d03a44 <longjmp>
c0d015a6:	46c0      	nop			; (mov r8, r8)
c0d015a8:	20001a18 	.word	0x20001a18
c0d015ac:	20001bb8 	.word	0x20001bb8

c0d015b0 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d015b0:	b580      	push	{r7, lr}
c0d015b2:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d015b4:	480d      	ldr	r0, [pc, #52]	; (c0d015ec <io_seproxyhal_handle_event+0x3c>)
c0d015b6:	7882      	ldrb	r2, [r0, #2]
c0d015b8:	7841      	ldrb	r1, [r0, #1]
c0d015ba:	0209      	lsls	r1, r1, #8
c0d015bc:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d015be:	7800      	ldrb	r0, [r0, #0]
c0d015c0:	2810      	cmp	r0, #16
c0d015c2:	d008      	beq.n	c0d015d6 <io_seproxyhal_handle_event+0x26>
c0d015c4:	280f      	cmp	r0, #15
c0d015c6:	d10d      	bne.n	c0d015e4 <io_seproxyhal_handle_event+0x34>
c0d015c8:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d015ca:	2904      	cmp	r1, #4
c0d015cc:	d10d      	bne.n	c0d015ea <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d015ce:	f7ff ff2d 	bl	c0d0142c <io_seproxyhal_handle_usb_event>
c0d015d2:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d015d4:	bd80      	pop	{r7, pc}
c0d015d6:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d015d8:	2906      	cmp	r1, #6
c0d015da:	d306      	bcc.n	c0d015ea <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d015dc:	f7ff ff64 	bl	c0d014a8 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d015e0:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d015e2:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d015e4:	2002      	movs	r0, #2
c0d015e6:	f7ff faf5 	bl	c0d00bd4 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d015ea:	bd80      	pop	{r7, pc}
c0d015ec:	20001a18 	.word	0x20001a18

c0d015f0 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d015f0:	b580      	push	{r7, lr}
c0d015f2:	af00      	add	r7, sp, #0
c0d015f4:	460a      	mov	r2, r1
c0d015f6:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d015f8:	2082      	movs	r0, #130	; 0x82
c0d015fa:	2314      	movs	r3, #20
c0d015fc:	f7ff ff7c 	bl	c0d014f8 <io_usb_send_ep>
}
c0d01600:	bd80      	pop	{r7, pc}
	...

c0d01604 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01604:	b5d0      	push	{r4, r6, r7, lr}
c0d01606:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01608:	2007      	movs	r0, #7
c0d0160a:	f000 fcf7 	bl	c0d01ffc <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d0160e:	480a      	ldr	r0, [pc, #40]	; (c0d01638 <io_seproxyhal_init+0x34>)
c0d01610:	2400      	movs	r4, #0
c0d01612:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01614:	4809      	ldr	r0, [pc, #36]	; (c0d0163c <io_seproxyhal_init+0x38>)
c0d01616:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d01618:	4809      	ldr	r0, [pc, #36]	; (c0d01640 <io_seproxyhal_init+0x3c>)
c0d0161a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d0161c:	4809      	ldr	r0, [pc, #36]	; (c0d01644 <io_seproxyhal_init+0x40>)
c0d0161e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01620:	4809      	ldr	r0, [pc, #36]	; (c0d01648 <io_seproxyhal_init+0x44>)
c0d01622:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d01624:	f7ff fe6e 	bl	c0d01304 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01628:	4808      	ldr	r0, [pc, #32]	; (c0d0164c <io_seproxyhal_init+0x48>)
c0d0162a:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d0162c:	4808      	ldr	r0, [pc, #32]	; (c0d01650 <io_seproxyhal_init+0x4c>)
c0d0162e:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d01630:	4808      	ldr	r0, [pc, #32]	; (c0d01654 <io_seproxyhal_init+0x50>)
c0d01632:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d01634:	bdd0      	pop	{r4, r6, r7, pc}
c0d01636:	46c0      	nop			; (mov r8, r8)
c0d01638:	20001d18 	.word	0x20001d18
c0d0163c:	20001d1a 	.word	0x20001d1a
c0d01640:	20001d1c 	.word	0x20001d1c
c0d01644:	20001d1e 	.word	0x20001d1e
c0d01648:	20001d10 	.word	0x20001d10
c0d0164c:	20001d20 	.word	0x20001d20
c0d01650:	20001d24 	.word	0x20001d24
c0d01654:	20001d28 	.word	0x20001d28

c0d01658 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01658:	4801      	ldr	r0, [pc, #4]	; (c0d01660 <io_seproxyhal_init_ux+0x8>)
c0d0165a:	2100      	movs	r1, #0
c0d0165c:	6001      	str	r1, [r0, #0]

}
c0d0165e:	4770      	bx	lr
c0d01660:	20001d20 	.word	0x20001d20

c0d01664 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01664:	b5b0      	push	{r4, r5, r7, lr}
c0d01666:	af02      	add	r7, sp, #8
c0d01668:	460d      	mov	r5, r1
c0d0166a:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d0166c:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d0166e:	2800      	cmp	r0, #0
c0d01670:	d00c      	beq.n	c0d0168c <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d01672:	f000 fcab 	bl	c0d01fcc <pic>
c0d01676:	4601      	mov	r1, r0
c0d01678:	4620      	mov	r0, r4
c0d0167a:	4788      	blx	r1
c0d0167c:	f000 fca6 	bl	c0d01fcc <pic>
c0d01680:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d01682:	2800      	cmp	r0, #0
c0d01684:	d010      	beq.n	c0d016a8 <io_seproxyhal_touch_out+0x44>
c0d01686:	2801      	cmp	r0, #1
c0d01688:	d000      	beq.n	c0d0168c <io_seproxyhal_touch_out+0x28>
c0d0168a:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d0168c:	2d00      	cmp	r5, #0
c0d0168e:	d007      	beq.n	c0d016a0 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d01690:	4620      	mov	r0, r4
c0d01692:	47a8      	blx	r5
c0d01694:	2100      	movs	r1, #0
    if (!el) {
c0d01696:	2800      	cmp	r0, #0
c0d01698:	d006      	beq.n	c0d016a8 <io_seproxyhal_touch_out+0x44>
c0d0169a:	2801      	cmp	r0, #1
c0d0169c:	d000      	beq.n	c0d016a0 <io_seproxyhal_touch_out+0x3c>
c0d0169e:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d016a0:	4620      	mov	r0, r4
c0d016a2:	f7ff fa91 	bl	c0d00bc8 <io_seproxyhal_display>
c0d016a6:	2101      	movs	r1, #1
  return 1;
}
c0d016a8:	4608      	mov	r0, r1
c0d016aa:	bdb0      	pop	{r4, r5, r7, pc}

c0d016ac <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d016ac:	b5b0      	push	{r4, r5, r7, lr}
c0d016ae:	af02      	add	r7, sp, #8
c0d016b0:	b08e      	sub	sp, #56	; 0x38
c0d016b2:	460c      	mov	r4, r1
c0d016b4:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d016b6:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d016b8:	2800      	cmp	r0, #0
c0d016ba:	d00c      	beq.n	c0d016d6 <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d016bc:	f000 fc86 	bl	c0d01fcc <pic>
c0d016c0:	4601      	mov	r1, r0
c0d016c2:	4628      	mov	r0, r5
c0d016c4:	4788      	blx	r1
c0d016c6:	f000 fc81 	bl	c0d01fcc <pic>
c0d016ca:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d016cc:	2800      	cmp	r0, #0
c0d016ce:	d016      	beq.n	c0d016fe <io_seproxyhal_touch_over+0x52>
c0d016d0:	2801      	cmp	r0, #1
c0d016d2:	d000      	beq.n	c0d016d6 <io_seproxyhal_touch_over+0x2a>
c0d016d4:	4605      	mov	r5, r0
c0d016d6:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d016d8:	2238      	movs	r2, #56	; 0x38
c0d016da:	4629      	mov	r1, r5
c0d016dc:	f7ff fdf6 	bl	c0d012cc <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d016e0:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d016e2:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d016e4:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d016e6:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d016e8:	2c00      	cmp	r4, #0
c0d016ea:	d004      	beq.n	c0d016f6 <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d016ec:	4628      	mov	r0, r5
c0d016ee:	47a0      	blx	r4
c0d016f0:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d016f2:	2800      	cmp	r0, #0
c0d016f4:	d003      	beq.n	c0d016fe <io_seproxyhal_touch_over+0x52>
c0d016f6:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d016f8:	f7ff fa66 	bl	c0d00bc8 <io_seproxyhal_display>
c0d016fc:	2101      	movs	r1, #1
  return 1;
}
c0d016fe:	4608      	mov	r0, r1
c0d01700:	b00e      	add	sp, #56	; 0x38
c0d01702:	bdb0      	pop	{r4, r5, r7, pc}

c0d01704 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01704:	b5b0      	push	{r4, r5, r7, lr}
c0d01706:	af02      	add	r7, sp, #8
c0d01708:	460d      	mov	r5, r1
c0d0170a:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d0170c:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d0170e:	2800      	cmp	r0, #0
c0d01710:	d00c      	beq.n	c0d0172c <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d01712:	f000 fc5b 	bl	c0d01fcc <pic>
c0d01716:	4601      	mov	r1, r0
c0d01718:	4620      	mov	r0, r4
c0d0171a:	4788      	blx	r1
c0d0171c:	f000 fc56 	bl	c0d01fcc <pic>
c0d01720:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01722:	2800      	cmp	r0, #0
c0d01724:	d010      	beq.n	c0d01748 <io_seproxyhal_touch_tap+0x44>
c0d01726:	2801      	cmp	r0, #1
c0d01728:	d000      	beq.n	c0d0172c <io_seproxyhal_touch_tap+0x28>
c0d0172a:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d0172c:	2d00      	cmp	r5, #0
c0d0172e:	d007      	beq.n	c0d01740 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d01730:	4620      	mov	r0, r4
c0d01732:	47a8      	blx	r5
c0d01734:	2100      	movs	r1, #0
    if (!el) {
c0d01736:	2800      	cmp	r0, #0
c0d01738:	d006      	beq.n	c0d01748 <io_seproxyhal_touch_tap+0x44>
c0d0173a:	2801      	cmp	r0, #1
c0d0173c:	d000      	beq.n	c0d01740 <io_seproxyhal_touch_tap+0x3c>
c0d0173e:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d01740:	4620      	mov	r0, r4
c0d01742:	f7ff fa41 	bl	c0d00bc8 <io_seproxyhal_display>
c0d01746:	2101      	movs	r1, #1
  return 1;
}
c0d01748:	4608      	mov	r0, r1
c0d0174a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0174c <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d0174c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0174e:	af03      	add	r7, sp, #12
c0d01750:	b087      	sub	sp, #28
c0d01752:	9302      	str	r3, [sp, #8]
c0d01754:	9203      	str	r2, [sp, #12]
c0d01756:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01758:	2900      	cmp	r1, #0
c0d0175a:	d076      	beq.n	c0d0184a <io_seproxyhal_touch_element_callback+0xfe>
c0d0175c:	9004      	str	r0, [sp, #16]
c0d0175e:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01760:	9001      	str	r0, [sp, #4]
c0d01762:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01764:	9000      	str	r0, [sp, #0]
c0d01766:	2600      	movs	r6, #0
c0d01768:	9606      	str	r6, [sp, #24]
c0d0176a:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0176c:	f000 fe08 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d01770:	2800      	cmp	r0, #0
c0d01772:	d155      	bne.n	c0d01820 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d01774:	2038      	movs	r0, #56	; 0x38
c0d01776:	4370      	muls	r0, r6
c0d01778:	9d04      	ldr	r5, [sp, #16]
c0d0177a:	182e      	adds	r6, r5, r0
c0d0177c:	4b36      	ldr	r3, [pc, #216]	; (c0d01858 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0177e:	681a      	ldr	r2, [r3, #0]
c0d01780:	2101      	movs	r1, #1
c0d01782:	4296      	cmp	r6, r2
c0d01784:	d000      	beq.n	c0d01788 <io_seproxyhal_touch_element_callback+0x3c>
c0d01786:	9906      	ldr	r1, [sp, #24]
c0d01788:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d0178a:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d0178c:	2800      	cmp	r0, #0
c0d0178e:	da41      	bge.n	c0d01814 <io_seproxyhal_touch_element_callback+0xc8>
c0d01790:	2020      	movs	r0, #32
c0d01792:	5c35      	ldrb	r5, [r6, r0]
c0d01794:	2102      	movs	r1, #2
c0d01796:	5e71      	ldrsh	r1, [r6, r1]
c0d01798:	1b4a      	subs	r2, r1, r5
c0d0179a:	9803      	ldr	r0, [sp, #12]
c0d0179c:	4282      	cmp	r2, r0
c0d0179e:	dc39      	bgt.n	c0d01814 <io_seproxyhal_touch_element_callback+0xc8>
c0d017a0:	1869      	adds	r1, r5, r1
c0d017a2:	88f2      	ldrh	r2, [r6, #6]
c0d017a4:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d017a6:	9803      	ldr	r0, [sp, #12]
c0d017a8:	4288      	cmp	r0, r1
c0d017aa:	da33      	bge.n	c0d01814 <io_seproxyhal_touch_element_callback+0xc8>
c0d017ac:	2104      	movs	r1, #4
c0d017ae:	5e70      	ldrsh	r0, [r6, r1]
c0d017b0:	1b42      	subs	r2, r0, r5
c0d017b2:	9902      	ldr	r1, [sp, #8]
c0d017b4:	428a      	cmp	r2, r1
c0d017b6:	dc2d      	bgt.n	c0d01814 <io_seproxyhal_touch_element_callback+0xc8>
c0d017b8:	1940      	adds	r0, r0, r5
c0d017ba:	8931      	ldrh	r1, [r6, #8]
c0d017bc:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d017be:	9902      	ldr	r1, [sp, #8]
c0d017c0:	4281      	cmp	r1, r0
c0d017c2:	da27      	bge.n	c0d01814 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d017c4:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d017c6:	4286      	cmp	r6, r0
c0d017c8:	d010      	beq.n	c0d017ec <io_seproxyhal_touch_element_callback+0xa0>
c0d017ca:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d017cc:	2800      	cmp	r0, #0
c0d017ce:	d00d      	beq.n	c0d017ec <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d017d0:	9801      	ldr	r0, [sp, #4]
c0d017d2:	2800      	cmp	r0, #0
c0d017d4:	d005      	beq.n	c0d017e2 <io_seproxyhal_touch_element_callback+0x96>
c0d017d6:	4630      	mov	r0, r6
c0d017d8:	9901      	ldr	r1, [sp, #4]
c0d017da:	4788      	blx	r1
c0d017dc:	4b1e      	ldr	r3, [pc, #120]	; (c0d01858 <io_seproxyhal_touch_element_callback+0x10c>)
c0d017de:	2800      	cmp	r0, #0
c0d017e0:	d018      	beq.n	c0d01814 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d017e2:	6818      	ldr	r0, [r3, #0]
c0d017e4:	9901      	ldr	r1, [sp, #4]
c0d017e6:	f7ff ff3d 	bl	c0d01664 <io_seproxyhal_touch_out>
c0d017ea:	e008      	b.n	c0d017fe <io_seproxyhal_touch_element_callback+0xb2>
c0d017ec:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d017ee:	2801      	cmp	r0, #1
c0d017f0:	d009      	beq.n	c0d01806 <io_seproxyhal_touch_element_callback+0xba>
c0d017f2:	2802      	cmp	r0, #2
c0d017f4:	d10e      	bne.n	c0d01814 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d017f6:	4630      	mov	r0, r6
c0d017f8:	9901      	ldr	r1, [sp, #4]
c0d017fa:	f7ff ff83 	bl	c0d01704 <io_seproxyhal_touch_tap>
c0d017fe:	4b16      	ldr	r3, [pc, #88]	; (c0d01858 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01800:	2800      	cmp	r0, #0
c0d01802:	d007      	beq.n	c0d01814 <io_seproxyhal_touch_element_callback+0xc8>
c0d01804:	e023      	b.n	c0d0184e <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d01806:	4630      	mov	r0, r6
c0d01808:	9901      	ldr	r1, [sp, #4]
c0d0180a:	f7ff ff4f 	bl	c0d016ac <io_seproxyhal_touch_over>
c0d0180e:	4b12      	ldr	r3, [pc, #72]	; (c0d01858 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01810:	2800      	cmp	r0, #0
c0d01812:	d11f      	bne.n	c0d01854 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01814:	1c64      	adds	r4, r4, #1
c0d01816:	b2e6      	uxtb	r6, r4
c0d01818:	9805      	ldr	r0, [sp, #20]
c0d0181a:	4286      	cmp	r6, r0
c0d0181c:	d3a6      	bcc.n	c0d0176c <io_seproxyhal_touch_element_callback+0x20>
c0d0181e:	e000      	b.n	c0d01822 <io_seproxyhal_touch_element_callback+0xd6>
c0d01820:	4b0d      	ldr	r3, [pc, #52]	; (c0d01858 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d01822:	9806      	ldr	r0, [sp, #24]
c0d01824:	0600      	lsls	r0, r0, #24
c0d01826:	d010      	beq.n	c0d0184a <io_seproxyhal_touch_element_callback+0xfe>
c0d01828:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d0182a:	2800      	cmp	r0, #0
c0d0182c:	d00d      	beq.n	c0d0184a <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0182e:	f000 fda7 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d01832:	4909      	ldr	r1, [pc, #36]	; (c0d01858 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01834:	2800      	cmp	r0, #0
c0d01836:	d108      	bne.n	c0d0184a <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01838:	6808      	ldr	r0, [r1, #0]
c0d0183a:	9901      	ldr	r1, [sp, #4]
c0d0183c:	f7ff ff12 	bl	c0d01664 <io_seproxyhal_touch_out>
c0d01840:	4d05      	ldr	r5, [pc, #20]	; (c0d01858 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01842:	2800      	cmp	r0, #0
c0d01844:	d001      	beq.n	c0d0184a <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d01846:	2000      	movs	r0, #0
c0d01848:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d0184a:	b007      	add	sp, #28
c0d0184c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0184e:	2000      	movs	r0, #0
c0d01850:	6018      	str	r0, [r3, #0]
c0d01852:	e7fa      	b.n	c0d0184a <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d01854:	601e      	str	r6, [r3, #0]
c0d01856:	e7f8      	b.n	c0d0184a <io_seproxyhal_touch_element_callback+0xfe>
c0d01858:	20001d20 	.word	0x20001d20

c0d0185c <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d0185c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0185e:	af03      	add	r7, sp, #12
c0d01860:	b08b      	sub	sp, #44	; 0x2c
c0d01862:	460c      	mov	r4, r1
c0d01864:	4601      	mov	r1, r0
c0d01866:	ad04      	add	r5, sp, #16
c0d01868:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d0186a:	4628      	mov	r0, r5
c0d0186c:	9203      	str	r2, [sp, #12]
c0d0186e:	f7ff fd2d 	bl	c0d012cc <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d01872:	6821      	ldr	r1, [r4, #0]
c0d01874:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d01876:	6862      	ldr	r2, [r4, #4]
c0d01878:	9502      	str	r5, [sp, #8]
c0d0187a:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d0187c:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0187e:	4e1a      	ldr	r6, [pc, #104]	; (c0d018e8 <io_seproxyhal_display_icon+0x8c>)
c0d01880:	2365      	movs	r3, #101	; 0x65
c0d01882:	4635      	mov	r5, r6
c0d01884:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d01886:	b292      	uxth	r2, r2
c0d01888:	4342      	muls	r2, r0
c0d0188a:	b28b      	uxth	r3, r1
c0d0188c:	4353      	muls	r3, r2
c0d0188e:	08d9      	lsrs	r1, r3, #3
c0d01890:	1c4e      	adds	r6, r1, #1
c0d01892:	2207      	movs	r2, #7
c0d01894:	4213      	tst	r3, r2
c0d01896:	d100      	bne.n	c0d0189a <io_seproxyhal_display_icon+0x3e>
c0d01898:	460e      	mov	r6, r1
c0d0189a:	4631      	mov	r1, r6
c0d0189c:	9101      	str	r1, [sp, #4]
c0d0189e:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d018a0:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d018a2:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d018a4:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d018a6:	0a01      	lsrs	r1, r0, #8
c0d018a8:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d018aa:	70a8      	strb	r0, [r5, #2]
c0d018ac:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d018ae:	4628      	mov	r0, r5
c0d018b0:	f000 fd48 	bl	c0d02344 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d018b4:	9802      	ldr	r0, [sp, #8]
c0d018b6:	9903      	ldr	r1, [sp, #12]
c0d018b8:	f000 fd44 	bl	c0d02344 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d018bc:	68a0      	ldr	r0, [r4, #8]
c0d018be:	7028      	strb	r0, [r5, #0]
c0d018c0:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d018c2:	4628      	mov	r0, r5
c0d018c4:	f000 fd3e 	bl	c0d02344 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d018c8:	68e0      	ldr	r0, [r4, #12]
c0d018ca:	f000 fb7f 	bl	c0d01fcc <pic>
c0d018ce:	b2b1      	uxth	r1, r6
c0d018d0:	f000 fd38 	bl	c0d02344 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d018d4:	9801      	ldr	r0, [sp, #4]
c0d018d6:	b285      	uxth	r5, r0
c0d018d8:	6920      	ldr	r0, [r4, #16]
c0d018da:	f000 fb77 	bl	c0d01fcc <pic>
c0d018de:	4629      	mov	r1, r5
c0d018e0:	f000 fd30 	bl	c0d02344 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d018e4:	b00b      	add	sp, #44	; 0x2c
c0d018e6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d018e8:	20001a18 	.word	0x20001a18

c0d018ec <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d018ec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d018ee:	af03      	add	r7, sp, #12
c0d018f0:	b081      	sub	sp, #4
c0d018f2:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d018f4:	7820      	ldrb	r0, [r4, #0]
c0d018f6:	267f      	movs	r6, #127	; 0x7f
c0d018f8:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d018fa:	2e00      	cmp	r6, #0
c0d018fc:	d02e      	beq.n	c0d0195c <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d018fe:	69e0      	ldr	r0, [r4, #28]
c0d01900:	2800      	cmp	r0, #0
c0d01902:	d01d      	beq.n	c0d01940 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01904:	f000 fb62 	bl	c0d01fcc <pic>
c0d01908:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d0190a:	2e05      	cmp	r6, #5
c0d0190c:	d102      	bne.n	c0d01914 <io_seproxyhal_display_default+0x28>
c0d0190e:	7ea0      	ldrb	r0, [r4, #26]
c0d01910:	2800      	cmp	r0, #0
c0d01912:	d025      	beq.n	c0d01960 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01914:	4628      	mov	r0, r5
c0d01916:	f002 f8a3 	bl	c0d03a60 <strlen>
c0d0191a:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0191c:	4813      	ldr	r0, [pc, #76]	; (c0d0196c <io_seproxyhal_display_default+0x80>)
c0d0191e:	2165      	movs	r1, #101	; 0x65
c0d01920:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01922:	4631      	mov	r1, r6
c0d01924:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01926:	0a0a      	lsrs	r2, r1, #8
c0d01928:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d0192a:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0192c:	2103      	movs	r1, #3
c0d0192e:	f000 fd09 	bl	c0d02344 <io_seproxyhal_spi_send>
c0d01932:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01934:	4620      	mov	r0, r4
c0d01936:	f000 fd05 	bl	c0d02344 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d0193a:	b2b1      	uxth	r1, r6
c0d0193c:	4628      	mov	r0, r5
c0d0193e:	e00b      	b.n	c0d01958 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01940:	480a      	ldr	r0, [pc, #40]	; (c0d0196c <io_seproxyhal_display_default+0x80>)
c0d01942:	2165      	movs	r1, #101	; 0x65
c0d01944:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01946:	2100      	movs	r1, #0
c0d01948:	7041      	strb	r1, [r0, #1]
c0d0194a:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d0194c:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0194e:	2103      	movs	r1, #3
c0d01950:	f000 fcf8 	bl	c0d02344 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01954:	4620      	mov	r0, r4
c0d01956:	4629      	mov	r1, r5
c0d01958:	f000 fcf4 	bl	c0d02344 <io_seproxyhal_spi_send>
    }
  }
}
c0d0195c:	b001      	add	sp, #4
c0d0195e:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d01960:	4620      	mov	r0, r4
c0d01962:	4629      	mov	r1, r5
c0d01964:	f7ff ff7a 	bl	c0d0185c <io_seproxyhal_display_icon>
c0d01968:	e7f8      	b.n	c0d0195c <io_seproxyhal_display_default+0x70>
c0d0196a:	46c0      	nop			; (mov r8, r8)
c0d0196c:	20001a18 	.word	0x20001a18

c0d01970 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d01970:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01972:	af03      	add	r7, sp, #12
c0d01974:	b081      	sub	sp, #4
c0d01976:	4604      	mov	r4, r0
  if (button_callback) {
c0d01978:	2c00      	cmp	r4, #0
c0d0197a:	d02e      	beq.n	c0d019da <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d0197c:	4818      	ldr	r0, [pc, #96]	; (c0d019e0 <io_seproxyhal_button_push+0x70>)
c0d0197e:	6802      	ldr	r2, [r0, #0]
c0d01980:	428a      	cmp	r2, r1
c0d01982:	d103      	bne.n	c0d0198c <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01984:	4a17      	ldr	r2, [pc, #92]	; (c0d019e4 <io_seproxyhal_button_push+0x74>)
c0d01986:	6813      	ldr	r3, [r2, #0]
c0d01988:	1c5b      	adds	r3, r3, #1
c0d0198a:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d0198c:	6806      	ldr	r6, [r0, #0]
c0d0198e:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d01990:	4a14      	ldr	r2, [pc, #80]	; (c0d019e4 <io_seproxyhal_button_push+0x74>)
c0d01992:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01994:	2900      	cmp	r1, #0
c0d01996:	d001      	beq.n	c0d0199c <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01998:	6006      	str	r6, [r0, #0]
c0d0199a:	e005      	b.n	c0d019a8 <io_seproxyhal_button_push+0x38>
c0d0199c:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d0199e:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d019a0:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d019a2:	2301      	movs	r3, #1
c0d019a4:	07db      	lsls	r3, r3, #31
c0d019a6:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d019a8:	6800      	ldr	r0, [r0, #0]
c0d019aa:	4288      	cmp	r0, r1
c0d019ac:	d001      	beq.n	c0d019b2 <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d019ae:	2000      	movs	r0, #0
c0d019b0:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d019b2:	2d08      	cmp	r5, #8
c0d019b4:	d30e      	bcc.n	c0d019d4 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d019b6:	2103      	movs	r1, #3
c0d019b8:	4628      	mov	r0, r5
c0d019ba:	f001 fda7 	bl	c0d0350c <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d019be:	2001      	movs	r0, #1
c0d019c0:	0780      	lsls	r0, r0, #30
c0d019c2:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d019c4:	2900      	cmp	r1, #0
c0d019c6:	4601      	mov	r1, r0
c0d019c8:	d000      	beq.n	c0d019cc <io_seproxyhal_button_push+0x5c>
c0d019ca:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d019cc:	2900      	cmp	r1, #0
c0d019ce:	db02      	blt.n	c0d019d6 <io_seproxyhal_button_push+0x66>
c0d019d0:	4608      	mov	r0, r1
c0d019d2:	e000      	b.n	c0d019d6 <io_seproxyhal_button_push+0x66>
c0d019d4:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d019d6:	4629      	mov	r1, r5
c0d019d8:	47a0      	blx	r4
  }
}
c0d019da:	b001      	add	sp, #4
c0d019dc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d019de:	46c0      	nop			; (mov r8, r8)
c0d019e0:	20001d24 	.word	0x20001d24
c0d019e4:	20001d28 	.word	0x20001d28

c0d019e8 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d019e8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d019ea:	af03      	add	r7, sp, #12
c0d019ec:	b081      	sub	sp, #4
c0d019ee:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d019f0:	200f      	movs	r0, #15
c0d019f2:	4204      	tst	r4, r0
c0d019f4:	d006      	beq.n	c0d01a04 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d019f6:	4620      	mov	r0, r4
c0d019f8:	f7ff f8be 	bl	c0d00b78 <io_exchange_al>
c0d019fc:	4605      	mov	r5, r0
  }
}
c0d019fe:	b2a8      	uxth	r0, r5
c0d01a00:	b001      	add	sp, #4
c0d01a02:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01a04:	2610      	movs	r6, #16
c0d01a06:	4026      	ands	r6, r4
c0d01a08:	2900      	cmp	r1, #0
c0d01a0a:	d02a      	beq.n	c0d01a62 <io_exchange+0x7a>
c0d01a0c:	2e00      	cmp	r6, #0
c0d01a0e:	d128      	bne.n	c0d01a62 <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01a10:	483d      	ldr	r0, [pc, #244]	; (c0d01b08 <io_exchange+0x120>)
c0d01a12:	7800      	ldrb	r0, [r0, #0]
c0d01a14:	2807      	cmp	r0, #7
c0d01a16:	d00b      	beq.n	c0d01a30 <io_exchange+0x48>
c0d01a18:	2800      	cmp	r0, #0
c0d01a1a:	d004      	beq.n	c0d01a26 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01a1c:	4620      	mov	r0, r4
c0d01a1e:	f7ff f8ab 	bl	c0d00b78 <io_exchange_al>
c0d01a22:	2800      	cmp	r0, #0
c0d01a24:	d00a      	beq.n	c0d01a3c <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01a26:	4839      	ldr	r0, [pc, #228]	; (c0d01b0c <io_exchange+0x124>)
c0d01a28:	6800      	ldr	r0, [r0, #0]
c0d01a2a:	2109      	movs	r1, #9
c0d01a2c:	f002 f80a 	bl	c0d03a44 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01a30:	483d      	ldr	r0, [pc, #244]	; (c0d01b28 <io_exchange+0x140>)
c0d01a32:	4478      	add	r0, pc
c0d01a34:	2200      	movs	r2, #0
c0d01a36:	2320      	movs	r3, #32
c0d01a38:	f7ff fc6a 	bl	c0d01310 <io_usb_hid_exchange>
c0d01a3c:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d01a3e:	4832      	ldr	r0, [pc, #200]	; (c0d01b08 <io_exchange+0x120>)
c0d01a40:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d01a42:	4833      	ldr	r0, [pc, #204]	; (c0d01b10 <io_exchange+0x128>)
c0d01a44:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01a46:	4833      	ldr	r0, [pc, #204]	; (c0d01b14 <io_exchange+0x12c>)
c0d01a48:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01a4a:	4833      	ldr	r0, [pc, #204]	; (c0d01b18 <io_exchange+0x130>)
c0d01a4c:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01a4e:	4833      	ldr	r0, [pc, #204]	; (c0d01b1c <io_exchange+0x134>)
c0d01a50:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d01a52:	06a0      	lsls	r0, r4, #26
c0d01a54:	d4d3      	bmi.n	c0d019fe <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01a56:	f7ff fcd3 	bl	c0d01400 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01a5a:	0620      	lsls	r0, r4, #24
c0d01a5c:	d501      	bpl.n	c0d01a62 <io_exchange+0x7a>
        reset();
c0d01a5e:	f000 faeb 	bl	c0d02038 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d01a62:	2e00      	cmp	r6, #0
c0d01a64:	d10c      	bne.n	c0d01a80 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01a66:	0660      	lsls	r0, r4, #25
c0d01a68:	d448      	bmi.n	c0d01afc <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d01a6a:	4827      	ldr	r0, [pc, #156]	; (c0d01b08 <io_exchange+0x120>)
c0d01a6c:	2100      	movs	r1, #0
c0d01a6e:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d01a70:	4827      	ldr	r0, [pc, #156]	; (c0d01b10 <io_exchange+0x128>)
c0d01a72:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d01a74:	4827      	ldr	r0, [pc, #156]	; (c0d01b14 <io_exchange+0x12c>)
c0d01a76:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d01a78:	4827      	ldr	r0, [pc, #156]	; (c0d01b18 <io_exchange+0x130>)
c0d01a7a:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01a7c:	4827      	ldr	r0, [pc, #156]	; (c0d01b1c <io_exchange+0x134>)
c0d01a7e:	7001      	strb	r1, [r0, #0]
c0d01a80:	4c28      	ldr	r4, [pc, #160]	; (c0d01b24 <io_exchange+0x13c>)
c0d01a82:	4e24      	ldr	r6, [pc, #144]	; (c0d01b14 <io_exchange+0x12c>)
c0d01a84:	e008      	b.n	c0d01a98 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d01a86:	f7ff fd0f 	bl	c0d014a8 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01a8a:	8830      	ldrh	r0, [r6, #0]
c0d01a8c:	2800      	cmp	r0, #0
c0d01a8e:	d003      	beq.n	c0d01a98 <io_exchange+0xb0>
c0d01a90:	e032      	b.n	c0d01af8 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d01a92:	2002      	movs	r0, #2
c0d01a94:	f7ff f89e 	bl	c0d00bd4 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01a98:	f000 fc72 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d01a9c:	2800      	cmp	r0, #0
c0d01a9e:	d101      	bne.n	c0d01aa4 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01aa0:	f7ff fcae 	bl	c0d01400 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01aa4:	2180      	movs	r1, #128	; 0x80
c0d01aa6:	2500      	movs	r5, #0
c0d01aa8:	4620      	mov	r0, r4
c0d01aaa:	462a      	mov	r2, r5
c0d01aac:	f000 fc84 	bl	c0d023b8 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01ab0:	1ec1      	subs	r1, r0, #3
c0d01ab2:	78a2      	ldrb	r2, [r4, #2]
c0d01ab4:	7863      	ldrb	r3, [r4, #1]
c0d01ab6:	021b      	lsls	r3, r3, #8
c0d01ab8:	4313      	orrs	r3, r2
c0d01aba:	4299      	cmp	r1, r3
c0d01abc:	d110      	bne.n	c0d01ae0 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01abe:	4917      	ldr	r1, [pc, #92]	; (c0d01b1c <io_exchange+0x134>)
c0d01ac0:	7809      	ldrb	r1, [r1, #0]
c0d01ac2:	2900      	cmp	r1, #0
c0d01ac4:	d002      	beq.n	c0d01acc <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01ac6:	f7ff fd73 	bl	c0d015b0 <io_seproxyhal_handle_event>
c0d01aca:	e7e5      	b.n	c0d01a98 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01acc:	7821      	ldrb	r1, [r4, #0]
c0d01ace:	2910      	cmp	r1, #16
c0d01ad0:	d00f      	beq.n	c0d01af2 <io_exchange+0x10a>
c0d01ad2:	290f      	cmp	r1, #15
c0d01ad4:	d1dd      	bne.n	c0d01a92 <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01ad6:	2804      	cmp	r0, #4
c0d01ad8:	d102      	bne.n	c0d01ae0 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01ada:	f7ff fca7 	bl	c0d0142c <io_seproxyhal_handle_usb_event>
c0d01ade:	e7db      	b.n	c0d01a98 <io_exchange+0xb0>
c0d01ae0:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d01ae2:	4909      	ldr	r1, [pc, #36]	; (c0d01b08 <io_exchange+0x120>)
c0d01ae4:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01ae6:	490a      	ldr	r1, [pc, #40]	; (c0d01b10 <io_exchange+0x128>)
c0d01ae8:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01aea:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01aec:	490a      	ldr	r1, [pc, #40]	; (c0d01b18 <io_exchange+0x130>)
c0d01aee:	8008      	strh	r0, [r1, #0]
c0d01af0:	e7d2      	b.n	c0d01a98 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01af2:	2806      	cmp	r0, #6
c0d01af4:	d2c7      	bcs.n	c0d01a86 <io_exchange+0x9e>
c0d01af6:	e782      	b.n	c0d019fe <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01af8:	8835      	ldrh	r5, [r6, #0]
c0d01afa:	e780      	b.n	c0d019fe <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01afc:	4805      	ldr	r0, [pc, #20]	; (c0d01b14 <io_exchange+0x12c>)
c0d01afe:	8800      	ldrh	r0, [r0, #0]
c0d01b00:	4907      	ldr	r1, [pc, #28]	; (c0d01b20 <io_exchange+0x138>)
c0d01b02:	1845      	adds	r5, r0, r1
c0d01b04:	e77b      	b.n	c0d019fe <io_exchange+0x16>
c0d01b06:	46c0      	nop			; (mov r8, r8)
c0d01b08:	20001d18 	.word	0x20001d18
c0d01b0c:	20001bb8 	.word	0x20001bb8
c0d01b10:	20001d1a 	.word	0x20001d1a
c0d01b14:	20001d1c 	.word	0x20001d1c
c0d01b18:	20001d1e 	.word	0x20001d1e
c0d01b1c:	20001d10 	.word	0x20001d10
c0d01b20:	0000fffb 	.word	0x0000fffb
c0d01b24:	20001a18 	.word	0x20001a18
c0d01b28:	fffffbbb 	.word	0xfffffbbb

c0d01b2c <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01b2c:	b081      	sub	sp, #4
c0d01b2e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01b30:	af03      	add	r7, sp, #12
c0d01b32:	b094      	sub	sp, #80	; 0x50
c0d01b34:	4616      	mov	r6, r2
c0d01b36:	460d      	mov	r5, r1
c0d01b38:	900e      	str	r0, [sp, #56]	; 0x38
c0d01b3a:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01b3c:	2d02      	cmp	r5, #2
c0d01b3e:	d200      	bcs.n	c0d01b42 <snprintf+0x16>
c0d01b40:	e22a      	b.n	c0d01f98 <snprintf+0x46c>
c0d01b42:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01b44:	2800      	cmp	r0, #0
c0d01b46:	d100      	bne.n	c0d01b4a <snprintf+0x1e>
c0d01b48:	e226      	b.n	c0d01f98 <snprintf+0x46c>
c0d01b4a:	2e00      	cmp	r6, #0
c0d01b4c:	d100      	bne.n	c0d01b50 <snprintf+0x24>
c0d01b4e:	e223      	b.n	c0d01f98 <snprintf+0x46c>
c0d01b50:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d01b52:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01b54:	9109      	str	r1, [sp, #36]	; 0x24
c0d01b56:	462a      	mov	r2, r5
c0d01b58:	f7ff fbae 	bl	c0d012b8 <os_memset>
c0d01b5c:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01b5e:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01b60:	7830      	ldrb	r0, [r6, #0]
c0d01b62:	2800      	cmp	r0, #0
c0d01b64:	d100      	bne.n	c0d01b68 <snprintf+0x3c>
c0d01b66:	e217      	b.n	c0d01f98 <snprintf+0x46c>
c0d01b68:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01b6a:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01b6c:	1e6b      	subs	r3, r5, #1
c0d01b6e:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01b70:	460a      	mov	r2, r1
c0d01b72:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01b74:	e003      	b.n	c0d01b7e <snprintf+0x52>
c0d01b76:	1970      	adds	r0, r6, r5
c0d01b78:	7840      	ldrb	r0, [r0, #1]
c0d01b7a:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01b7c:	1c6d      	adds	r5, r5, #1
c0d01b7e:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01b80:	2800      	cmp	r0, #0
c0d01b82:	d001      	beq.n	c0d01b88 <snprintf+0x5c>
c0d01b84:	2825      	cmp	r0, #37	; 0x25
c0d01b86:	d1f6      	bne.n	c0d01b76 <snprintf+0x4a>
c0d01b88:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01b8a:	429d      	cmp	r5, r3
c0d01b8c:	d300      	bcc.n	c0d01b90 <snprintf+0x64>
c0d01b8e:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01b90:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01b92:	4631      	mov	r1, r6
c0d01b94:	462a      	mov	r2, r5
c0d01b96:	461c      	mov	r4, r3
c0d01b98:	f7ff fb98 	bl	c0d012cc <os_memmove>
c0d01b9c:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01b9e:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01ba0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01ba2:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01ba4:	2b00      	cmp	r3, #0
c0d01ba6:	d100      	bne.n	c0d01baa <snprintf+0x7e>
c0d01ba8:	e1f6      	b.n	c0d01f98 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01baa:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01bac:	5d71      	ldrb	r1, [r6, r5]
c0d01bae:	2925      	cmp	r1, #37	; 0x25
c0d01bb0:	d000      	beq.n	c0d01bb4 <snprintf+0x88>
c0d01bb2:	e0ab      	b.n	c0d01d0c <snprintf+0x1e0>
c0d01bb4:	9304      	str	r3, [sp, #16]
c0d01bb6:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01bb8:	1c40      	adds	r0, r0, #1
c0d01bba:	2100      	movs	r1, #0
c0d01bbc:	2220      	movs	r2, #32
c0d01bbe:	920a      	str	r2, [sp, #40]	; 0x28
c0d01bc0:	220a      	movs	r2, #10
c0d01bc2:	9203      	str	r2, [sp, #12]
c0d01bc4:	9102      	str	r1, [sp, #8]
c0d01bc6:	9106      	str	r1, [sp, #24]
c0d01bc8:	910d      	str	r1, [sp, #52]	; 0x34
c0d01bca:	460b      	mov	r3, r1
c0d01bcc:	2102      	movs	r1, #2
c0d01bce:	910c      	str	r1, [sp, #48]	; 0x30
c0d01bd0:	4606      	mov	r6, r0
c0d01bd2:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01bd4:	7831      	ldrb	r1, [r6, #0]
c0d01bd6:	1c76      	adds	r6, r6, #1
c0d01bd8:	2300      	movs	r3, #0
c0d01bda:	2962      	cmp	r1, #98	; 0x62
c0d01bdc:	dc41      	bgt.n	c0d01c62 <snprintf+0x136>
c0d01bde:	4608      	mov	r0, r1
c0d01be0:	3825      	subs	r0, #37	; 0x25
c0d01be2:	2823      	cmp	r0, #35	; 0x23
c0d01be4:	d900      	bls.n	c0d01be8 <snprintf+0xbc>
c0d01be6:	e094      	b.n	c0d01d12 <snprintf+0x1e6>
c0d01be8:	0040      	lsls	r0, r0, #1
c0d01bea:	46c0      	nop			; (mov r8, r8)
c0d01bec:	4478      	add	r0, pc
c0d01bee:	8880      	ldrh	r0, [r0, #4]
c0d01bf0:	0040      	lsls	r0, r0, #1
c0d01bf2:	4487      	add	pc, r0
c0d01bf4:	0186012d 	.word	0x0186012d
c0d01bf8:	01860186 	.word	0x01860186
c0d01bfc:	00510186 	.word	0x00510186
c0d01c00:	01860186 	.word	0x01860186
c0d01c04:	00580023 	.word	0x00580023
c0d01c08:	00240186 	.word	0x00240186
c0d01c0c:	00240024 	.word	0x00240024
c0d01c10:	00240024 	.word	0x00240024
c0d01c14:	00240024 	.word	0x00240024
c0d01c18:	00240024 	.word	0x00240024
c0d01c1c:	01860024 	.word	0x01860024
c0d01c20:	01860186 	.word	0x01860186
c0d01c24:	01860186 	.word	0x01860186
c0d01c28:	01860186 	.word	0x01860186
c0d01c2c:	01860186 	.word	0x01860186
c0d01c30:	01860186 	.word	0x01860186
c0d01c34:	01860186 	.word	0x01860186
c0d01c38:	006c0186 	.word	0x006c0186
c0d01c3c:	e7c9      	b.n	c0d01bd2 <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01c3e:	2930      	cmp	r1, #48	; 0x30
c0d01c40:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01c42:	4603      	mov	r3, r0
c0d01c44:	d100      	bne.n	c0d01c48 <snprintf+0x11c>
c0d01c46:	460b      	mov	r3, r1
c0d01c48:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01c4a:	2c00      	cmp	r4, #0
c0d01c4c:	d000      	beq.n	c0d01c50 <snprintf+0x124>
c0d01c4e:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01c50:	200a      	movs	r0, #10
c0d01c52:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01c54:	1840      	adds	r0, r0, r1
c0d01c56:	3830      	subs	r0, #48	; 0x30
c0d01c58:	900d      	str	r0, [sp, #52]	; 0x34
c0d01c5a:	4630      	mov	r0, r6
c0d01c5c:	930a      	str	r3, [sp, #40]	; 0x28
c0d01c5e:	4613      	mov	r3, r2
c0d01c60:	e7b4      	b.n	c0d01bcc <snprintf+0xa0>
c0d01c62:	296f      	cmp	r1, #111	; 0x6f
c0d01c64:	dd11      	ble.n	c0d01c8a <snprintf+0x15e>
c0d01c66:	3970      	subs	r1, #112	; 0x70
c0d01c68:	2908      	cmp	r1, #8
c0d01c6a:	d900      	bls.n	c0d01c6e <snprintf+0x142>
c0d01c6c:	e149      	b.n	c0d01f02 <snprintf+0x3d6>
c0d01c6e:	0049      	lsls	r1, r1, #1
c0d01c70:	4479      	add	r1, pc
c0d01c72:	8889      	ldrh	r1, [r1, #4]
c0d01c74:	0049      	lsls	r1, r1, #1
c0d01c76:	448f      	add	pc, r1
c0d01c78:	01440051 	.word	0x01440051
c0d01c7c:	002e0144 	.word	0x002e0144
c0d01c80:	00590144 	.word	0x00590144
c0d01c84:	01440144 	.word	0x01440144
c0d01c88:	0051      	.short	0x0051
c0d01c8a:	2963      	cmp	r1, #99	; 0x63
c0d01c8c:	d054      	beq.n	c0d01d38 <snprintf+0x20c>
c0d01c8e:	2964      	cmp	r1, #100	; 0x64
c0d01c90:	d057      	beq.n	c0d01d42 <snprintf+0x216>
c0d01c92:	2968      	cmp	r1, #104	; 0x68
c0d01c94:	d01d      	beq.n	c0d01cd2 <snprintf+0x1a6>
c0d01c96:	e134      	b.n	c0d01f02 <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01c98:	7830      	ldrb	r0, [r6, #0]
c0d01c9a:	2873      	cmp	r0, #115	; 0x73
c0d01c9c:	d000      	beq.n	c0d01ca0 <snprintf+0x174>
c0d01c9e:	e130      	b.n	c0d01f02 <snprintf+0x3d6>
c0d01ca0:	4630      	mov	r0, r6
c0d01ca2:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01ca4:	e00d      	b.n	c0d01cc2 <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01ca6:	7830      	ldrb	r0, [r6, #0]
c0d01ca8:	282a      	cmp	r0, #42	; 0x2a
c0d01caa:	d000      	beq.n	c0d01cae <snprintf+0x182>
c0d01cac:	e129      	b.n	c0d01f02 <snprintf+0x3d6>
c0d01cae:	7871      	ldrb	r1, [r6, #1]
c0d01cb0:	1c70      	adds	r0, r6, #1
c0d01cb2:	2301      	movs	r3, #1
c0d01cb4:	2948      	cmp	r1, #72	; 0x48
c0d01cb6:	d004      	beq.n	c0d01cc2 <snprintf+0x196>
c0d01cb8:	2968      	cmp	r1, #104	; 0x68
c0d01cba:	d002      	beq.n	c0d01cc2 <snprintf+0x196>
c0d01cbc:	2973      	cmp	r1, #115	; 0x73
c0d01cbe:	d000      	beq.n	c0d01cc2 <snprintf+0x196>
c0d01cc0:	e11f      	b.n	c0d01f02 <snprintf+0x3d6>
c0d01cc2:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01cc4:	1d0a      	adds	r2, r1, #4
c0d01cc6:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01cc8:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01cca:	9102      	str	r1, [sp, #8]
c0d01ccc:	e77e      	b.n	c0d01bcc <snprintf+0xa0>
c0d01cce:	2001      	movs	r0, #1
c0d01cd0:	9006      	str	r0, [sp, #24]
c0d01cd2:	2010      	movs	r0, #16
c0d01cd4:	9003      	str	r0, [sp, #12]
c0d01cd6:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01cd8:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01cda:	1d01      	adds	r1, r0, #4
c0d01cdc:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01cde:	2103      	movs	r1, #3
c0d01ce0:	400a      	ands	r2, r1
c0d01ce2:	1c5b      	adds	r3, r3, #1
c0d01ce4:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01ce6:	2a01      	cmp	r2, #1
c0d01ce8:	d100      	bne.n	c0d01cec <snprintf+0x1c0>
c0d01cea:	e0b8      	b.n	c0d01e5e <snprintf+0x332>
c0d01cec:	2a02      	cmp	r2, #2
c0d01cee:	d100      	bne.n	c0d01cf2 <snprintf+0x1c6>
c0d01cf0:	e104      	b.n	c0d01efc <snprintf+0x3d0>
c0d01cf2:	2a03      	cmp	r2, #3
c0d01cf4:	4630      	mov	r0, r6
c0d01cf6:	d100      	bne.n	c0d01cfa <snprintf+0x1ce>
c0d01cf8:	e768      	b.n	c0d01bcc <snprintf+0xa0>
c0d01cfa:	9c08      	ldr	r4, [sp, #32]
c0d01cfc:	4625      	mov	r5, r4
c0d01cfe:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01d00:	1948      	adds	r0, r1, r5
c0d01d02:	7840      	ldrb	r0, [r0, #1]
c0d01d04:	1c6d      	adds	r5, r5, #1
c0d01d06:	2800      	cmp	r0, #0
c0d01d08:	d1fa      	bne.n	c0d01d00 <snprintf+0x1d4>
c0d01d0a:	e0ab      	b.n	c0d01e64 <snprintf+0x338>
c0d01d0c:	4606      	mov	r6, r0
c0d01d0e:	920e      	str	r2, [sp, #56]	; 0x38
c0d01d10:	e109      	b.n	c0d01f26 <snprintf+0x3fa>
c0d01d12:	2958      	cmp	r1, #88	; 0x58
c0d01d14:	d000      	beq.n	c0d01d18 <snprintf+0x1ec>
c0d01d16:	e0f4      	b.n	c0d01f02 <snprintf+0x3d6>
c0d01d18:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01d1a:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01d1c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01d1e:	1d01      	adds	r1, r0, #4
c0d01d20:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01d22:	6802      	ldr	r2, [r0, #0]
c0d01d24:	2000      	movs	r0, #0
c0d01d26:	9005      	str	r0, [sp, #20]
c0d01d28:	2510      	movs	r5, #16
c0d01d2a:	e014      	b.n	c0d01d56 <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01d2c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01d2e:	1d01      	adds	r1, r0, #4
c0d01d30:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01d32:	6802      	ldr	r2, [r0, #0]
c0d01d34:	2000      	movs	r0, #0
c0d01d36:	e00c      	b.n	c0d01d52 <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01d38:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01d3a:	1d01      	adds	r1, r0, #4
c0d01d3c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01d3e:	6800      	ldr	r0, [r0, #0]
c0d01d40:	e087      	b.n	c0d01e52 <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01d42:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01d44:	1d01      	adds	r1, r0, #4
c0d01d46:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01d48:	6800      	ldr	r0, [r0, #0]
c0d01d4a:	17c1      	asrs	r1, r0, #31
c0d01d4c:	1842      	adds	r2, r0, r1
c0d01d4e:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01d50:	0fc0      	lsrs	r0, r0, #31
c0d01d52:	9005      	str	r0, [sp, #20]
c0d01d54:	250a      	movs	r5, #10
c0d01d56:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01d58:	4295      	cmp	r5, r2
c0d01d5a:	920e      	str	r2, [sp, #56]	; 0x38
c0d01d5c:	d814      	bhi.n	c0d01d88 <snprintf+0x25c>
c0d01d5e:	2201      	movs	r2, #1
c0d01d60:	4628      	mov	r0, r5
c0d01d62:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01d64:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01d66:	4629      	mov	r1, r5
c0d01d68:	f001 fb4a 	bl	c0d03400 <__aeabi_uidiv>
c0d01d6c:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01d6e:	4288      	cmp	r0, r1
c0d01d70:	d109      	bne.n	c0d01d86 <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01d72:	4628      	mov	r0, r5
c0d01d74:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01d76:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01d78:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01d7a:	910d      	str	r1, [sp, #52]	; 0x34
c0d01d7c:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01d7e:	4288      	cmp	r0, r1
c0d01d80:	4622      	mov	r2, r4
c0d01d82:	d9ee      	bls.n	c0d01d62 <snprintf+0x236>
c0d01d84:	e000      	b.n	c0d01d88 <snprintf+0x25c>
c0d01d86:	460c      	mov	r4, r1
c0d01d88:	950c      	str	r5, [sp, #48]	; 0x30
c0d01d8a:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01d8c:	2000      	movs	r0, #0
c0d01d8e:	4603      	mov	r3, r0
c0d01d90:	43c1      	mvns	r1, r0
c0d01d92:	9c05      	ldr	r4, [sp, #20]
c0d01d94:	2c00      	cmp	r4, #0
c0d01d96:	d100      	bne.n	c0d01d9a <snprintf+0x26e>
c0d01d98:	4621      	mov	r1, r4
c0d01d9a:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01d9c:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01d9e:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01da0:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01da2:	b2ca      	uxtb	r2, r1
c0d01da4:	2a30      	cmp	r2, #48	; 0x30
c0d01da6:	d106      	bne.n	c0d01db6 <snprintf+0x28a>
c0d01da8:	2c00      	cmp	r4, #0
c0d01daa:	d004      	beq.n	c0d01db6 <snprintf+0x28a>
c0d01dac:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01dae:	232d      	movs	r3, #45	; 0x2d
c0d01db0:	700b      	strb	r3, [r1, #0]
c0d01db2:	2400      	movs	r4, #0
c0d01db4:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01db6:	1e81      	subs	r1, r0, #2
c0d01db8:	290d      	cmp	r1, #13
c0d01dba:	d80d      	bhi.n	c0d01dd8 <snprintf+0x2ac>
c0d01dbc:	1e41      	subs	r1, r0, #1
c0d01dbe:	d00b      	beq.n	c0d01dd8 <snprintf+0x2ac>
c0d01dc0:	a810      	add	r0, sp, #64	; 0x40
c0d01dc2:	9405      	str	r4, [sp, #20]
c0d01dc4:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01dc6:	4320      	orrs	r0, r4
c0d01dc8:	f001 fda4 	bl	c0d03914 <__aeabi_memset>
c0d01dcc:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01dce:	1900      	adds	r0, r0, r4
c0d01dd0:	9c05      	ldr	r4, [sp, #20]
c0d01dd2:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01dd4:	1840      	adds	r0, r0, r1
c0d01dd6:	1e43      	subs	r3, r0, #1
c0d01dd8:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01dda:	2c00      	cmp	r4, #0
c0d01ddc:	9601      	str	r6, [sp, #4]
c0d01dde:	d003      	beq.n	c0d01de8 <snprintf+0x2bc>
c0d01de0:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01de2:	222d      	movs	r2, #45	; 0x2d
c0d01de4:	54c2      	strb	r2, [r0, r3]
c0d01de6:	1c5b      	adds	r3, r3, #1
c0d01de8:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01dea:	2900      	cmp	r1, #0
c0d01dec:	d003      	beq.n	c0d01df6 <snprintf+0x2ca>
c0d01dee:	2800      	cmp	r0, #0
c0d01df0:	d003      	beq.n	c0d01dfa <snprintf+0x2ce>
c0d01df2:	a06c      	add	r0, pc, #432	; (adr r0, c0d01fa4 <g_pcHex_cap>)
c0d01df4:	e002      	b.n	c0d01dfc <snprintf+0x2d0>
c0d01df6:	461c      	mov	r4, r3
c0d01df8:	e016      	b.n	c0d01e28 <snprintf+0x2fc>
c0d01dfa:	a06e      	add	r0, pc, #440	; (adr r0, c0d01fb4 <g_pcHex>)
c0d01dfc:	900d      	str	r0, [sp, #52]	; 0x34
c0d01dfe:	461c      	mov	r4, r3
c0d01e00:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01e02:	460e      	mov	r6, r1
c0d01e04:	f001 fafc 	bl	c0d03400 <__aeabi_uidiv>
c0d01e08:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01e0a:	4629      	mov	r1, r5
c0d01e0c:	f001 fb7e 	bl	c0d0350c <__aeabi_uidivmod>
c0d01e10:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01e12:	5c40      	ldrb	r0, [r0, r1]
c0d01e14:	a910      	add	r1, sp, #64	; 0x40
c0d01e16:	5508      	strb	r0, [r1, r4]
c0d01e18:	4630      	mov	r0, r6
c0d01e1a:	4629      	mov	r1, r5
c0d01e1c:	f001 faf0 	bl	c0d03400 <__aeabi_uidiv>
c0d01e20:	1c64      	adds	r4, r4, #1
c0d01e22:	42b5      	cmp	r5, r6
c0d01e24:	4601      	mov	r1, r0
c0d01e26:	d9eb      	bls.n	c0d01e00 <snprintf+0x2d4>
c0d01e28:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01e2a:	429c      	cmp	r4, r3
c0d01e2c:	4625      	mov	r5, r4
c0d01e2e:	d300      	bcc.n	c0d01e32 <snprintf+0x306>
c0d01e30:	461d      	mov	r5, r3
c0d01e32:	a910      	add	r1, sp, #64	; 0x40
c0d01e34:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01e36:	4620      	mov	r0, r4
c0d01e38:	462a      	mov	r2, r5
c0d01e3a:	461e      	mov	r6, r3
c0d01e3c:	f7ff fa46 	bl	c0d012cc <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01e40:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d01e42:	1961      	adds	r1, r4, r5
c0d01e44:	910e      	str	r1, [sp, #56]	; 0x38
c0d01e46:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01e48:	2800      	cmp	r0, #0
c0d01e4a:	9e01      	ldr	r6, [sp, #4]
c0d01e4c:	d16b      	bne.n	c0d01f26 <snprintf+0x3fa>
c0d01e4e:	e0a3      	b.n	c0d01f98 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01e50:	2025      	movs	r0, #37	; 0x25
c0d01e52:	9907      	ldr	r1, [sp, #28]
c0d01e54:	7008      	strb	r0, [r1, #0]
c0d01e56:	9804      	ldr	r0, [sp, #16]
c0d01e58:	1e40      	subs	r0, r0, #1
c0d01e5a:	1c49      	adds	r1, r1, #1
c0d01e5c:	e05f      	b.n	c0d01f1e <snprintf+0x3f2>
c0d01e5e:	9d02      	ldr	r5, [sp, #8]
c0d01e60:	9c08      	ldr	r4, [sp, #32]
c0d01e62:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01e64:	9803      	ldr	r0, [sp, #12]
c0d01e66:	2810      	cmp	r0, #16
c0d01e68:	9807      	ldr	r0, [sp, #28]
c0d01e6a:	d161      	bne.n	c0d01f30 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01e6c:	2d00      	cmp	r5, #0
c0d01e6e:	d06a      	beq.n	c0d01f46 <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01e70:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01e72:	1900      	adds	r0, r0, r4
c0d01e74:	900e      	str	r0, [sp, #56]	; 0x38
c0d01e76:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01e78:	1aa0      	subs	r0, r4, r2
c0d01e7a:	9b05      	ldr	r3, [sp, #20]
c0d01e7c:	4283      	cmp	r3, r0
c0d01e7e:	d800      	bhi.n	c0d01e82 <snprintf+0x356>
c0d01e80:	4603      	mov	r3, r0
c0d01e82:	930c      	str	r3, [sp, #48]	; 0x30
c0d01e84:	435c      	muls	r4, r3
c0d01e86:	940a      	str	r4, [sp, #40]	; 0x28
c0d01e88:	1c60      	adds	r0, r4, #1
c0d01e8a:	9007      	str	r0, [sp, #28]
c0d01e8c:	2000      	movs	r0, #0
c0d01e8e:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01e90:	9100      	str	r1, [sp, #0]
c0d01e92:	940e      	str	r4, [sp, #56]	; 0x38
c0d01e94:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01e96:	18e3      	adds	r3, r4, r3
c0d01e98:	900d      	str	r0, [sp, #52]	; 0x34
c0d01e9a:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01e9c:	200f      	movs	r0, #15
c0d01e9e:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01ea0:	0909      	lsrs	r1, r1, #4
c0d01ea2:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01ea4:	18a4      	adds	r4, r4, r2
c0d01ea6:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01ea8:	2c02      	cmp	r4, #2
c0d01eaa:	d375      	bcc.n	c0d01f98 <snprintf+0x46c>
c0d01eac:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01eae:	2c01      	cmp	r4, #1
c0d01eb0:	d003      	beq.n	c0d01eba <snprintf+0x38e>
c0d01eb2:	2c00      	cmp	r4, #0
c0d01eb4:	d108      	bne.n	c0d01ec8 <snprintf+0x39c>
c0d01eb6:	a43f      	add	r4, pc, #252	; (adr r4, c0d01fb4 <g_pcHex>)
c0d01eb8:	e000      	b.n	c0d01ebc <snprintf+0x390>
c0d01eba:	a43a      	add	r4, pc, #232	; (adr r4, c0d01fa4 <g_pcHex_cap>)
c0d01ebc:	b2c9      	uxtb	r1, r1
c0d01ebe:	5c61      	ldrb	r1, [r4, r1]
c0d01ec0:	7019      	strb	r1, [r3, #0]
c0d01ec2:	b2c0      	uxtb	r0, r0
c0d01ec4:	5c20      	ldrb	r0, [r4, r0]
c0d01ec6:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01ec8:	9807      	ldr	r0, [sp, #28]
c0d01eca:	4290      	cmp	r0, r2
c0d01ecc:	d064      	beq.n	c0d01f98 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01ece:	1e92      	subs	r2, r2, #2
c0d01ed0:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01ed2:	1ca4      	adds	r4, r4, #2
c0d01ed4:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01ed6:	1c40      	adds	r0, r0, #1
c0d01ed8:	42a8      	cmp	r0, r5
c0d01eda:	9900      	ldr	r1, [sp, #0]
c0d01edc:	d3d9      	bcc.n	c0d01e92 <snprintf+0x366>
c0d01ede:	900d      	str	r0, [sp, #52]	; 0x34
c0d01ee0:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01ee2:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01ee4:	1a08      	subs	r0, r1, r0
c0d01ee6:	9b05      	ldr	r3, [sp, #20]
c0d01ee8:	4283      	cmp	r3, r0
c0d01eea:	d800      	bhi.n	c0d01eee <snprintf+0x3c2>
c0d01eec:	4603      	mov	r3, r0
c0d01eee:	4608      	mov	r0, r1
c0d01ef0:	4358      	muls	r0, r3
c0d01ef2:	1820      	adds	r0, r4, r0
c0d01ef4:	900e      	str	r0, [sp, #56]	; 0x38
c0d01ef6:	1898      	adds	r0, r3, r2
c0d01ef8:	1c43      	adds	r3, r0, #1
c0d01efa:	e038      	b.n	c0d01f6e <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01efc:	7808      	ldrb	r0, [r1, #0]
c0d01efe:	2800      	cmp	r0, #0
c0d01f00:	d023      	beq.n	c0d01f4a <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d01f02:	2005      	movs	r0, #5
c0d01f04:	9d04      	ldr	r5, [sp, #16]
c0d01f06:	2d05      	cmp	r5, #5
c0d01f08:	462c      	mov	r4, r5
c0d01f0a:	d300      	bcc.n	c0d01f0e <snprintf+0x3e2>
c0d01f0c:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01f0e:	9807      	ldr	r0, [sp, #28]
c0d01f10:	a12c      	add	r1, pc, #176	; (adr r1, c0d01fc4 <g_pcHex+0x10>)
c0d01f12:	4622      	mov	r2, r4
c0d01f14:	f7ff f9da 	bl	c0d012cc <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01f18:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01f1a:	9907      	ldr	r1, [sp, #28]
c0d01f1c:	1909      	adds	r1, r1, r4
c0d01f1e:	910e      	str	r1, [sp, #56]	; 0x38
c0d01f20:	4603      	mov	r3, r0
c0d01f22:	2800      	cmp	r0, #0
c0d01f24:	d038      	beq.n	c0d01f98 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01f26:	7830      	ldrb	r0, [r6, #0]
c0d01f28:	2800      	cmp	r0, #0
c0d01f2a:	9908      	ldr	r1, [sp, #32]
c0d01f2c:	d034      	beq.n	c0d01f98 <snprintf+0x46c>
c0d01f2e:	e61f      	b.n	c0d01b70 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01f30:	429d      	cmp	r5, r3
c0d01f32:	d300      	bcc.n	c0d01f36 <snprintf+0x40a>
c0d01f34:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01f36:	462a      	mov	r2, r5
c0d01f38:	461c      	mov	r4, r3
c0d01f3a:	f7ff f9c7 	bl	c0d012cc <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01f3e:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01f40:	9907      	ldr	r1, [sp, #28]
c0d01f42:	1949      	adds	r1, r1, r5
c0d01f44:	e00f      	b.n	c0d01f66 <snprintf+0x43a>
c0d01f46:	900e      	str	r0, [sp, #56]	; 0x38
c0d01f48:	e7ed      	b.n	c0d01f26 <snprintf+0x3fa>
c0d01f4a:	9b04      	ldr	r3, [sp, #16]
c0d01f4c:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01f4e:	429c      	cmp	r4, r3
c0d01f50:	d300      	bcc.n	c0d01f54 <snprintf+0x428>
c0d01f52:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d01f54:	2120      	movs	r1, #32
c0d01f56:	9807      	ldr	r0, [sp, #28]
c0d01f58:	4622      	mov	r2, r4
c0d01f5a:	f7ff f9ad 	bl	c0d012b8 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d01f5e:	9804      	ldr	r0, [sp, #16]
c0d01f60:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d01f62:	9907      	ldr	r1, [sp, #28]
c0d01f64:	1909      	adds	r1, r1, r4
c0d01f66:	910e      	str	r1, [sp, #56]	; 0x38
c0d01f68:	4603      	mov	r3, r0
c0d01f6a:	2800      	cmp	r0, #0
c0d01f6c:	d014      	beq.n	c0d01f98 <snprintf+0x46c>
c0d01f6e:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01f70:	42a8      	cmp	r0, r5
c0d01f72:	d9d8      	bls.n	c0d01f26 <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d01f74:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d01f76:	429a      	cmp	r2, r3
c0d01f78:	d300      	bcc.n	c0d01f7c <snprintf+0x450>
c0d01f7a:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d01f7c:	2120      	movs	r1, #32
c0d01f7e:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01f80:	4628      	mov	r0, r5
c0d01f82:	920d      	str	r2, [sp, #52]	; 0x34
c0d01f84:	461c      	mov	r4, r3
c0d01f86:	f7ff f997 	bl	c0d012b8 <os_memset>
c0d01f8a:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01f8c:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01f8e:	182d      	adds	r5, r5, r0
c0d01f90:	950e      	str	r5, [sp, #56]	; 0x38
c0d01f92:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d01f94:	2c00      	cmp	r4, #0
c0d01f96:	d1c6      	bne.n	c0d01f26 <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01f98:	2000      	movs	r0, #0
c0d01f9a:	b014      	add	sp, #80	; 0x50
c0d01f9c:	bcf0      	pop	{r4, r5, r6, r7}
c0d01f9e:	bc02      	pop	{r1}
c0d01fa0:	b001      	add	sp, #4
c0d01fa2:	4708      	bx	r1

c0d01fa4 <g_pcHex_cap>:
c0d01fa4:	33323130 	.word	0x33323130
c0d01fa8:	37363534 	.word	0x37363534
c0d01fac:	42413938 	.word	0x42413938
c0d01fb0:	46454443 	.word	0x46454443

c0d01fb4 <g_pcHex>:
c0d01fb4:	33323130 	.word	0x33323130
c0d01fb8:	37363534 	.word	0x37363534
c0d01fbc:	62613938 	.word	0x62613938
c0d01fc0:	66656463 	.word	0x66656463
c0d01fc4:	4f525245 	.word	0x4f525245
c0d01fc8:	00000052 	.word	0x00000052

c0d01fcc <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01fcc:	b580      	push	{r7, lr}
c0d01fce:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01fd0:	4904      	ldr	r1, [pc, #16]	; (c0d01fe4 <pic+0x18>)
c0d01fd2:	4288      	cmp	r0, r1
c0d01fd4:	d304      	bcc.n	c0d01fe0 <pic+0x14>
c0d01fd6:	4904      	ldr	r1, [pc, #16]	; (c0d01fe8 <pic+0x1c>)
c0d01fd8:	4288      	cmp	r0, r1
c0d01fda:	d201      	bcs.n	c0d01fe0 <pic+0x14>
		link_address = pic_internal(link_address);
c0d01fdc:	f000 f806 	bl	c0d01fec <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01fe0:	bd80      	pop	{r7, pc}
c0d01fe2:	46c0      	nop			; (mov r8, r8)
c0d01fe4:	c0d00000 	.word	0xc0d00000
c0d01fe8:	c0d03f00 	.word	0xc0d03f00

c0d01fec <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01fec:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01fee:	4902      	ldr	r1, [pc, #8]	; (c0d01ff8 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01ff0:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01ff2:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01ff4:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01ff6:	4770      	bx	lr
c0d01ff8:	c0d01fed 	.word	0xc0d01fed

c0d01ffc <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01ffc:	b580      	push	{r7, lr}
c0d01ffe:	af00      	add	r7, sp, #0
c0d02000:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d02002:	490a      	ldr	r1, [pc, #40]	; (c0d0202c <check_api_level+0x30>)
c0d02004:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02006:	490a      	ldr	r1, [pc, #40]	; (c0d02030 <check_api_level+0x34>)
c0d02008:	680a      	ldr	r2, [r1, #0]
c0d0200a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d0200c:	9003      	str	r0, [sp, #12]
c0d0200e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02010:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02012:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02014:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d02016:	4807      	ldr	r0, [pc, #28]	; (c0d02034 <check_api_level+0x38>)
c0d02018:	9a01      	ldr	r2, [sp, #4]
c0d0201a:	4282      	cmp	r2, r0
c0d0201c:	d101      	bne.n	c0d02022 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0201e:	b004      	add	sp, #16
c0d02020:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02022:	6808      	ldr	r0, [r1, #0]
c0d02024:	2104      	movs	r1, #4
c0d02026:	f001 fd0d 	bl	c0d03a44 <longjmp>
c0d0202a:	46c0      	nop			; (mov r8, r8)
c0d0202c:	60000137 	.word	0x60000137
c0d02030:	20001bb8 	.word	0x20001bb8
c0d02034:	900001c6 	.word	0x900001c6

c0d02038 <reset>:
  }
}

void reset ( void ) 
{
c0d02038:	b580      	push	{r7, lr}
c0d0203a:	af00      	add	r7, sp, #0
c0d0203c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d0203e:	4809      	ldr	r0, [pc, #36]	; (c0d02064 <reset+0x2c>)
c0d02040:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02042:	4809      	ldr	r0, [pc, #36]	; (c0d02068 <reset+0x30>)
c0d02044:	6801      	ldr	r1, [r0, #0]
c0d02046:	9101      	str	r1, [sp, #4]
c0d02048:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0204a:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d0204c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0204e:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d02050:	4906      	ldr	r1, [pc, #24]	; (c0d0206c <reset+0x34>)
c0d02052:	9a00      	ldr	r2, [sp, #0]
c0d02054:	428a      	cmp	r2, r1
c0d02056:	d101      	bne.n	c0d0205c <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02058:	b002      	add	sp, #8
c0d0205a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0205c:	6800      	ldr	r0, [r0, #0]
c0d0205e:	2104      	movs	r1, #4
c0d02060:	f001 fcf0 	bl	c0d03a44 <longjmp>
c0d02064:	60000200 	.word	0x60000200
c0d02068:	20001bb8 	.word	0x20001bb8
c0d0206c:	900002f1 	.word	0x900002f1

c0d02070 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d02070:	b5d0      	push	{r4, r6, r7, lr}
c0d02072:	af02      	add	r7, sp, #8
c0d02074:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d02076:	4b0a      	ldr	r3, [pc, #40]	; (c0d020a0 <nvm_write+0x30>)
c0d02078:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0207a:	4b0a      	ldr	r3, [pc, #40]	; (c0d020a4 <nvm_write+0x34>)
c0d0207c:	681c      	ldr	r4, [r3, #0]
c0d0207e:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d02080:	ac03      	add	r4, sp, #12
c0d02082:	c407      	stmia	r4!, {r0, r1, r2}
c0d02084:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02086:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02088:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0208a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d0208c:	4806      	ldr	r0, [pc, #24]	; (c0d020a8 <nvm_write+0x38>)
c0d0208e:	9901      	ldr	r1, [sp, #4]
c0d02090:	4281      	cmp	r1, r0
c0d02092:	d101      	bne.n	c0d02098 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02094:	b006      	add	sp, #24
c0d02096:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02098:	6818      	ldr	r0, [r3, #0]
c0d0209a:	2104      	movs	r1, #4
c0d0209c:	f001 fcd2 	bl	c0d03a44 <longjmp>
c0d020a0:	6000037f 	.word	0x6000037f
c0d020a4:	20001bb8 	.word	0x20001bb8
c0d020a8:	900003bc 	.word	0x900003bc

c0d020ac <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d020ac:	b580      	push	{r7, lr}
c0d020ae:	af00      	add	r7, sp, #0
c0d020b0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d020b2:	4a0a      	ldr	r2, [pc, #40]	; (c0d020dc <cx_rng+0x30>)
c0d020b4:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d020b6:	4a0a      	ldr	r2, [pc, #40]	; (c0d020e0 <cx_rng+0x34>)
c0d020b8:	6813      	ldr	r3, [r2, #0]
c0d020ba:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d020bc:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d020be:	9103      	str	r1, [sp, #12]
c0d020c0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d020c2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d020c4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d020c6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d020c8:	4906      	ldr	r1, [pc, #24]	; (c0d020e4 <cx_rng+0x38>)
c0d020ca:	9b00      	ldr	r3, [sp, #0]
c0d020cc:	428b      	cmp	r3, r1
c0d020ce:	d101      	bne.n	c0d020d4 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d020d0:	b004      	add	sp, #16
c0d020d2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020d4:	6810      	ldr	r0, [r2, #0]
c0d020d6:	2104      	movs	r1, #4
c0d020d8:	f001 fcb4 	bl	c0d03a44 <longjmp>
c0d020dc:	6000052c 	.word	0x6000052c
c0d020e0:	20001bb8 	.word	0x20001bb8
c0d020e4:	90000567 	.word	0x90000567

c0d020e8 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d020e8:	b580      	push	{r7, lr}
c0d020ea:	af00      	add	r7, sp, #0
c0d020ec:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d020ee:	490a      	ldr	r1, [pc, #40]	; (c0d02118 <cx_sha256_init+0x30>)
c0d020f0:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d020f2:	490a      	ldr	r1, [pc, #40]	; (c0d0211c <cx_sha256_init+0x34>)
c0d020f4:	680a      	ldr	r2, [r1, #0]
c0d020f6:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d020f8:	9003      	str	r0, [sp, #12]
c0d020fa:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d020fc:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d020fe:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02100:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d02102:	4a07      	ldr	r2, [pc, #28]	; (c0d02120 <cx_sha256_init+0x38>)
c0d02104:	9b01      	ldr	r3, [sp, #4]
c0d02106:	4293      	cmp	r3, r2
c0d02108:	d101      	bne.n	c0d0210e <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0210a:	b004      	add	sp, #16
c0d0210c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0210e:	6808      	ldr	r0, [r1, #0]
c0d02110:	2104      	movs	r1, #4
c0d02112:	f001 fc97 	bl	c0d03a44 <longjmp>
c0d02116:	46c0      	nop			; (mov r8, r8)
c0d02118:	600008db 	.word	0x600008db
c0d0211c:	20001bb8 	.word	0x20001bb8
c0d02120:	90000864 	.word	0x90000864

c0d02124 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d02124:	b580      	push	{r7, lr}
c0d02126:	af00      	add	r7, sp, #0
c0d02128:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d0212a:	4a0a      	ldr	r2, [pc, #40]	; (c0d02154 <cx_keccak_init+0x30>)
c0d0212c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0212e:	4a0a      	ldr	r2, [pc, #40]	; (c0d02158 <cx_keccak_init+0x34>)
c0d02130:	6813      	ldr	r3, [r2, #0]
c0d02132:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d02134:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d02136:	9103      	str	r1, [sp, #12]
c0d02138:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0213a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0213c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0213e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d02140:	4906      	ldr	r1, [pc, #24]	; (c0d0215c <cx_keccak_init+0x38>)
c0d02142:	9b00      	ldr	r3, [sp, #0]
c0d02144:	428b      	cmp	r3, r1
c0d02146:	d101      	bne.n	c0d0214c <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02148:	b004      	add	sp, #16
c0d0214a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0214c:	6810      	ldr	r0, [r2, #0]
c0d0214e:	2104      	movs	r1, #4
c0d02150:	f001 fc78 	bl	c0d03a44 <longjmp>
c0d02154:	60000c3c 	.word	0x60000c3c
c0d02158:	20001bb8 	.word	0x20001bb8
c0d0215c:	90000c39 	.word	0x90000c39

c0d02160 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d02160:	b5b0      	push	{r4, r5, r7, lr}
c0d02162:	af02      	add	r7, sp, #8
c0d02164:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d02166:	4c0b      	ldr	r4, [pc, #44]	; (c0d02194 <cx_hash+0x34>)
c0d02168:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0216a:	4c0b      	ldr	r4, [pc, #44]	; (c0d02198 <cx_hash+0x38>)
c0d0216c:	6825      	ldr	r5, [r4, #0]
c0d0216e:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d02170:	ad03      	add	r5, sp, #12
c0d02172:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02174:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d02176:	9007      	str	r0, [sp, #28]
c0d02178:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0217a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0217c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0217e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d02180:	4906      	ldr	r1, [pc, #24]	; (c0d0219c <cx_hash+0x3c>)
c0d02182:	9a01      	ldr	r2, [sp, #4]
c0d02184:	428a      	cmp	r2, r1
c0d02186:	d101      	bne.n	c0d0218c <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02188:	b008      	add	sp, #32
c0d0218a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0218c:	6820      	ldr	r0, [r4, #0]
c0d0218e:	2104      	movs	r1, #4
c0d02190:	f001 fc58 	bl	c0d03a44 <longjmp>
c0d02194:	60000ea6 	.word	0x60000ea6
c0d02198:	20001bb8 	.word	0x20001bb8
c0d0219c:	90000e46 	.word	0x90000e46

c0d021a0 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d021a0:	b5b0      	push	{r4, r5, r7, lr}
c0d021a2:	af02      	add	r7, sp, #8
c0d021a4:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d021a6:	4c0a      	ldr	r4, [pc, #40]	; (c0d021d0 <cx_ecfp_init_public_key+0x30>)
c0d021a8:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021aa:	4c0a      	ldr	r4, [pc, #40]	; (c0d021d4 <cx_ecfp_init_public_key+0x34>)
c0d021ac:	6825      	ldr	r5, [r4, #0]
c0d021ae:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d021b0:	ad02      	add	r5, sp, #8
c0d021b2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d021b4:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021b6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021b8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021ba:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d021bc:	4906      	ldr	r1, [pc, #24]	; (c0d021d8 <cx_ecfp_init_public_key+0x38>)
c0d021be:	9a00      	ldr	r2, [sp, #0]
c0d021c0:	428a      	cmp	r2, r1
c0d021c2:	d101      	bne.n	c0d021c8 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d021c4:	b006      	add	sp, #24
c0d021c6:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021c8:	6820      	ldr	r0, [r4, #0]
c0d021ca:	2104      	movs	r1, #4
c0d021cc:	f001 fc3a 	bl	c0d03a44 <longjmp>
c0d021d0:	60002835 	.word	0x60002835
c0d021d4:	20001bb8 	.word	0x20001bb8
c0d021d8:	900028f0 	.word	0x900028f0

c0d021dc <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d021dc:	b5b0      	push	{r4, r5, r7, lr}
c0d021de:	af02      	add	r7, sp, #8
c0d021e0:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d021e2:	4c0a      	ldr	r4, [pc, #40]	; (c0d0220c <cx_ecfp_init_private_key+0x30>)
c0d021e4:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021e6:	4c0a      	ldr	r4, [pc, #40]	; (c0d02210 <cx_ecfp_init_private_key+0x34>)
c0d021e8:	6825      	ldr	r5, [r4, #0]
c0d021ea:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d021ec:	ad02      	add	r5, sp, #8
c0d021ee:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d021f0:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021f2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021f4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021f6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d021f8:	4906      	ldr	r1, [pc, #24]	; (c0d02214 <cx_ecfp_init_private_key+0x38>)
c0d021fa:	9a00      	ldr	r2, [sp, #0]
c0d021fc:	428a      	cmp	r2, r1
c0d021fe:	d101      	bne.n	c0d02204 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02200:	b006      	add	sp, #24
c0d02202:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02204:	6820      	ldr	r0, [r4, #0]
c0d02206:	2104      	movs	r1, #4
c0d02208:	f001 fc1c 	bl	c0d03a44 <longjmp>
c0d0220c:	600029ed 	.word	0x600029ed
c0d02210:	20001bb8 	.word	0x20001bb8
c0d02214:	900029ae 	.word	0x900029ae

c0d02218 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d02218:	b5b0      	push	{r4, r5, r7, lr}
c0d0221a:	af02      	add	r7, sp, #8
c0d0221c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d0221e:	4c0a      	ldr	r4, [pc, #40]	; (c0d02248 <cx_ecfp_generate_pair+0x30>)
c0d02220:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02222:	4c0a      	ldr	r4, [pc, #40]	; (c0d0224c <cx_ecfp_generate_pair+0x34>)
c0d02224:	6825      	ldr	r5, [r4, #0]
c0d02226:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02228:	ad02      	add	r5, sp, #8
c0d0222a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d0222c:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0222e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02230:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02232:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d02234:	4906      	ldr	r1, [pc, #24]	; (c0d02250 <cx_ecfp_generate_pair+0x38>)
c0d02236:	9a00      	ldr	r2, [sp, #0]
c0d02238:	428a      	cmp	r2, r1
c0d0223a:	d101      	bne.n	c0d02240 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0223c:	b006      	add	sp, #24
c0d0223e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02240:	6820      	ldr	r0, [r4, #0]
c0d02242:	2104      	movs	r1, #4
c0d02244:	f001 fbfe 	bl	c0d03a44 <longjmp>
c0d02248:	60002a2e 	.word	0x60002a2e
c0d0224c:	20001bb8 	.word	0x20001bb8
c0d02250:	90002a74 	.word	0x90002a74

c0d02254 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d02254:	b5b0      	push	{r4, r5, r7, lr}
c0d02256:	af02      	add	r7, sp, #8
c0d02258:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d0225a:	4c0b      	ldr	r4, [pc, #44]	; (c0d02288 <os_perso_derive_node_bip32+0x34>)
c0d0225c:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0225e:	4c0b      	ldr	r4, [pc, #44]	; (c0d0228c <os_perso_derive_node_bip32+0x38>)
c0d02260:	6825      	ldr	r5, [r4, #0]
c0d02262:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d02264:	ad03      	add	r5, sp, #12
c0d02266:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02268:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d0226a:	9007      	str	r0, [sp, #28]
c0d0226c:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0226e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02270:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02272:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d02274:	4806      	ldr	r0, [pc, #24]	; (c0d02290 <os_perso_derive_node_bip32+0x3c>)
c0d02276:	9901      	ldr	r1, [sp, #4]
c0d02278:	4281      	cmp	r1, r0
c0d0227a:	d101      	bne.n	c0d02280 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0227c:	b008      	add	sp, #32
c0d0227e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02280:	6820      	ldr	r0, [r4, #0]
c0d02282:	2104      	movs	r1, #4
c0d02284:	f001 fbde 	bl	c0d03a44 <longjmp>
c0d02288:	6000512b 	.word	0x6000512b
c0d0228c:	20001bb8 	.word	0x20001bb8
c0d02290:	9000517f 	.word	0x9000517f

c0d02294 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d02294:	b580      	push	{r7, lr}
c0d02296:	af00      	add	r7, sp, #0
c0d02298:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d0229a:	490a      	ldr	r1, [pc, #40]	; (c0d022c4 <os_sched_exit+0x30>)
c0d0229c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0229e:	490a      	ldr	r1, [pc, #40]	; (c0d022c8 <os_sched_exit+0x34>)
c0d022a0:	680a      	ldr	r2, [r1, #0]
c0d022a2:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d022a4:	9003      	str	r0, [sp, #12]
c0d022a6:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022a8:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022aa:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022ac:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d022ae:	4807      	ldr	r0, [pc, #28]	; (c0d022cc <os_sched_exit+0x38>)
c0d022b0:	9a01      	ldr	r2, [sp, #4]
c0d022b2:	4282      	cmp	r2, r0
c0d022b4:	d101      	bne.n	c0d022ba <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d022b6:	b004      	add	sp, #16
c0d022b8:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022ba:	6808      	ldr	r0, [r1, #0]
c0d022bc:	2104      	movs	r1, #4
c0d022be:	f001 fbc1 	bl	c0d03a44 <longjmp>
c0d022c2:	46c0      	nop			; (mov r8, r8)
c0d022c4:	60005fe1 	.word	0x60005fe1
c0d022c8:	20001bb8 	.word	0x20001bb8
c0d022cc:	90005f6f 	.word	0x90005f6f

c0d022d0 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d022d0:	b580      	push	{r7, lr}
c0d022d2:	af00      	add	r7, sp, #0
c0d022d4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d022d6:	490a      	ldr	r1, [pc, #40]	; (c0d02300 <os_ux+0x30>)
c0d022d8:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022da:	490a      	ldr	r1, [pc, #40]	; (c0d02304 <os_ux+0x34>)
c0d022dc:	680a      	ldr	r2, [r1, #0]
c0d022de:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d022e0:	9003      	str	r0, [sp, #12]
c0d022e2:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022e4:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022e6:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022e8:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d022ea:	4a07      	ldr	r2, [pc, #28]	; (c0d02308 <os_ux+0x38>)
c0d022ec:	9b01      	ldr	r3, [sp, #4]
c0d022ee:	4293      	cmp	r3, r2
c0d022f0:	d101      	bne.n	c0d022f6 <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d022f2:	b004      	add	sp, #16
c0d022f4:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022f6:	6808      	ldr	r0, [r1, #0]
c0d022f8:	2104      	movs	r1, #4
c0d022fa:	f001 fba3 	bl	c0d03a44 <longjmp>
c0d022fe:	46c0      	nop			; (mov r8, r8)
c0d02300:	60006158 	.word	0x60006158
c0d02304:	20001bb8 	.word	0x20001bb8
c0d02308:	9000611f 	.word	0x9000611f

c0d0230c <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d0230c:	b580      	push	{r7, lr}
c0d0230e:	af00      	add	r7, sp, #0
c0d02310:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d02312:	4809      	ldr	r0, [pc, #36]	; (c0d02338 <os_seph_features+0x2c>)
c0d02314:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02316:	4909      	ldr	r1, [pc, #36]	; (c0d0233c <os_seph_features+0x30>)
c0d02318:	6808      	ldr	r0, [r1, #0]
c0d0231a:	9001      	str	r0, [sp, #4]
c0d0231c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0231e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02320:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02322:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d02324:	4a06      	ldr	r2, [pc, #24]	; (c0d02340 <os_seph_features+0x34>)
c0d02326:	9b00      	ldr	r3, [sp, #0]
c0d02328:	4293      	cmp	r3, r2
c0d0232a:	d101      	bne.n	c0d02330 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0232c:	b002      	add	sp, #8
c0d0232e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02330:	6808      	ldr	r0, [r1, #0]
c0d02332:	2104      	movs	r1, #4
c0d02334:	f001 fb86 	bl	c0d03a44 <longjmp>
c0d02338:	600064d6 	.word	0x600064d6
c0d0233c:	20001bb8 	.word	0x20001bb8
c0d02340:	90006444 	.word	0x90006444

c0d02344 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d02344:	b580      	push	{r7, lr}
c0d02346:	af00      	add	r7, sp, #0
c0d02348:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d0234a:	4a0a      	ldr	r2, [pc, #40]	; (c0d02374 <io_seproxyhal_spi_send+0x30>)
c0d0234c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0234e:	4a0a      	ldr	r2, [pc, #40]	; (c0d02378 <io_seproxyhal_spi_send+0x34>)
c0d02350:	6813      	ldr	r3, [r2, #0]
c0d02352:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d02354:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d02356:	9103      	str	r1, [sp, #12]
c0d02358:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0235a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0235c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0235e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d02360:	4806      	ldr	r0, [pc, #24]	; (c0d0237c <io_seproxyhal_spi_send+0x38>)
c0d02362:	9900      	ldr	r1, [sp, #0]
c0d02364:	4281      	cmp	r1, r0
c0d02366:	d101      	bne.n	c0d0236c <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02368:	b004      	add	sp, #16
c0d0236a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0236c:	6810      	ldr	r0, [r2, #0]
c0d0236e:	2104      	movs	r1, #4
c0d02370:	f001 fb68 	bl	c0d03a44 <longjmp>
c0d02374:	60006a1c 	.word	0x60006a1c
c0d02378:	20001bb8 	.word	0x20001bb8
c0d0237c:	90006af3 	.word	0x90006af3

c0d02380 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d02380:	b580      	push	{r7, lr}
c0d02382:	af00      	add	r7, sp, #0
c0d02384:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d02386:	4809      	ldr	r0, [pc, #36]	; (c0d023ac <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d02388:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0238a:	4909      	ldr	r1, [pc, #36]	; (c0d023b0 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d0238c:	6808      	ldr	r0, [r1, #0]
c0d0238e:	9001      	str	r0, [sp, #4]
c0d02390:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02392:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02394:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02396:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d02398:	4a06      	ldr	r2, [pc, #24]	; (c0d023b4 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d0239a:	9b00      	ldr	r3, [sp, #0]
c0d0239c:	4293      	cmp	r3, r2
c0d0239e:	d101      	bne.n	c0d023a4 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d023a0:	b002      	add	sp, #8
c0d023a2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023a4:	6808      	ldr	r0, [r1, #0]
c0d023a6:	2104      	movs	r1, #4
c0d023a8:	f001 fb4c 	bl	c0d03a44 <longjmp>
c0d023ac:	60006bcf 	.word	0x60006bcf
c0d023b0:	20001bb8 	.word	0x20001bb8
c0d023b4:	90006b7f 	.word	0x90006b7f

c0d023b8 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d023b8:	b5d0      	push	{r4, r6, r7, lr}
c0d023ba:	af02      	add	r7, sp, #8
c0d023bc:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d023be:	4b0b      	ldr	r3, [pc, #44]	; (c0d023ec <io_seproxyhal_spi_recv+0x34>)
c0d023c0:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d023c2:	4b0b      	ldr	r3, [pc, #44]	; (c0d023f0 <io_seproxyhal_spi_recv+0x38>)
c0d023c4:	681c      	ldr	r4, [r3, #0]
c0d023c6:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d023c8:	ac03      	add	r4, sp, #12
c0d023ca:	c407      	stmia	r4!, {r0, r1, r2}
c0d023cc:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d023ce:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d023d0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d023d2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d023d4:	4907      	ldr	r1, [pc, #28]	; (c0d023f4 <io_seproxyhal_spi_recv+0x3c>)
c0d023d6:	9a01      	ldr	r2, [sp, #4]
c0d023d8:	428a      	cmp	r2, r1
c0d023da:	d102      	bne.n	c0d023e2 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d023dc:	b280      	uxth	r0, r0
c0d023de:	b006      	add	sp, #24
c0d023e0:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023e2:	6818      	ldr	r0, [r3, #0]
c0d023e4:	2104      	movs	r1, #4
c0d023e6:	f001 fb2d 	bl	c0d03a44 <longjmp>
c0d023ea:	46c0      	nop			; (mov r8, r8)
c0d023ec:	60006cd1 	.word	0x60006cd1
c0d023f0:	20001bb8 	.word	0x20001bb8
c0d023f4:	90006c2b 	.word	0x90006c2b

c0d023f8 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d023f8:	b5b0      	push	{r4, r5, r7, lr}
c0d023fa:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d023fc:	492c      	ldr	r1, [pc, #176]	; (c0d024b0 <bagl_ui_nanos_screen1_button+0xb8>)
c0d023fe:	4288      	cmp	r0, r1
c0d02400:	d006      	beq.n	c0d02410 <bagl_ui_nanos_screen1_button+0x18>
c0d02402:	492c      	ldr	r1, [pc, #176]	; (c0d024b4 <bagl_ui_nanos_screen1_button+0xbc>)
c0d02404:	4288      	cmp	r0, r1
c0d02406:	d151      	bne.n	c0d024ac <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d02408:	2000      	movs	r0, #0
c0d0240a:	f7ff ff43 	bl	c0d02294 <os_sched_exit>
c0d0240e:	e04d      	b.n	c0d024ac <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d02410:	f7fe fba4 	bl	c0d00b5c <nvram_is_init>
c0d02414:	2801      	cmp	r0, #1
c0d02416:	d102      	bne.n	c0d0241e <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d02418:	a029      	add	r0, pc, #164	; (adr r0, c0d024c0 <bagl_ui_nanos_screen1_button+0xc8>)
c0d0241a:	210d      	movs	r1, #13
c0d0241c:	e001      	b.n	c0d02422 <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d0241e:	a026      	add	r0, pc, #152	; (adr r0, c0d024b8 <bagl_ui_nanos_screen1_button+0xc0>)
c0d02420:	2105      	movs	r1, #5
c0d02422:	2203      	movs	r2, #3
c0d02424:	f7fd ff1e 	bl	c0d00264 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02428:	4c29      	ldr	r4, [pc, #164]	; (c0d024d0 <bagl_ui_nanos_screen1_button+0xd8>)
c0d0242a:	482b      	ldr	r0, [pc, #172]	; (c0d024d8 <bagl_ui_nanos_screen1_button+0xe0>)
c0d0242c:	4478      	add	r0, pc
c0d0242e:	6020      	str	r0, [r4, #0]
c0d02430:	2004      	movs	r0, #4
c0d02432:	6060      	str	r0, [r4, #4]
c0d02434:	4829      	ldr	r0, [pc, #164]	; (c0d024dc <bagl_ui_nanos_screen1_button+0xe4>)
c0d02436:	4478      	add	r0, pc
c0d02438:	6120      	str	r0, [r4, #16]
c0d0243a:	2500      	movs	r5, #0
c0d0243c:	60e5      	str	r5, [r4, #12]
c0d0243e:	2003      	movs	r0, #3
c0d02440:	7620      	strb	r0, [r4, #24]
c0d02442:	61e5      	str	r5, [r4, #28]
c0d02444:	4620      	mov	r0, r4
c0d02446:	3018      	adds	r0, #24
c0d02448:	f7ff ff42 	bl	c0d022d0 <os_ux>
c0d0244c:	61e0      	str	r0, [r4, #28]
c0d0244e:	f7ff f903 	bl	c0d01658 <io_seproxyhal_init_ux>
c0d02452:	60a5      	str	r5, [r4, #8]
c0d02454:	6820      	ldr	r0, [r4, #0]
c0d02456:	2800      	cmp	r0, #0
c0d02458:	d028      	beq.n	c0d024ac <bagl_ui_nanos_screen1_button+0xb4>
c0d0245a:	69e0      	ldr	r0, [r4, #28]
c0d0245c:	491d      	ldr	r1, [pc, #116]	; (c0d024d4 <bagl_ui_nanos_screen1_button+0xdc>)
c0d0245e:	4288      	cmp	r0, r1
c0d02460:	d116      	bne.n	c0d02490 <bagl_ui_nanos_screen1_button+0x98>
c0d02462:	e023      	b.n	c0d024ac <bagl_ui_nanos_screen1_button+0xb4>
c0d02464:	6860      	ldr	r0, [r4, #4]
c0d02466:	4285      	cmp	r5, r0
c0d02468:	d220      	bcs.n	c0d024ac <bagl_ui_nanos_screen1_button+0xb4>
c0d0246a:	f7ff ff89 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d0246e:	2800      	cmp	r0, #0
c0d02470:	d11c      	bne.n	c0d024ac <bagl_ui_nanos_screen1_button+0xb4>
c0d02472:	68a0      	ldr	r0, [r4, #8]
c0d02474:	68e1      	ldr	r1, [r4, #12]
c0d02476:	2538      	movs	r5, #56	; 0x38
c0d02478:	4368      	muls	r0, r5
c0d0247a:	6822      	ldr	r2, [r4, #0]
c0d0247c:	1810      	adds	r0, r2, r0
c0d0247e:	2900      	cmp	r1, #0
c0d02480:	d009      	beq.n	c0d02496 <bagl_ui_nanos_screen1_button+0x9e>
c0d02482:	4788      	blx	r1
c0d02484:	2800      	cmp	r0, #0
c0d02486:	d106      	bne.n	c0d02496 <bagl_ui_nanos_screen1_button+0x9e>
c0d02488:	68a0      	ldr	r0, [r4, #8]
c0d0248a:	1c45      	adds	r5, r0, #1
c0d0248c:	60a5      	str	r5, [r4, #8]
c0d0248e:	6820      	ldr	r0, [r4, #0]
c0d02490:	2800      	cmp	r0, #0
c0d02492:	d1e7      	bne.n	c0d02464 <bagl_ui_nanos_screen1_button+0x6c>
c0d02494:	e00a      	b.n	c0d024ac <bagl_ui_nanos_screen1_button+0xb4>
c0d02496:	2801      	cmp	r0, #1
c0d02498:	d103      	bne.n	c0d024a2 <bagl_ui_nanos_screen1_button+0xaa>
c0d0249a:	68a0      	ldr	r0, [r4, #8]
c0d0249c:	4345      	muls	r5, r0
c0d0249e:	6820      	ldr	r0, [r4, #0]
c0d024a0:	1940      	adds	r0, r0, r5
c0d024a2:	f7fe fb91 	bl	c0d00bc8 <io_seproxyhal_display>
c0d024a6:	68a0      	ldr	r0, [r4, #8]
c0d024a8:	1c40      	adds	r0, r0, #1
c0d024aa:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d024ac:	2000      	movs	r0, #0
c0d024ae:	bdb0      	pop	{r4, r5, r7, pc}
c0d024b0:	80000002 	.word	0x80000002
c0d024b4:	80000001 	.word	0x80000001
c0d024b8:	54494e49 	.word	0x54494e49
c0d024bc:	00000000 	.word	0x00000000
c0d024c0:	6c697453 	.word	0x6c697453
c0d024c4:	6e75206c 	.word	0x6e75206c
c0d024c8:	74696e69 	.word	0x74696e69
c0d024cc:	00000000 	.word	0x00000000
c0d024d0:	20001a98 	.word	0x20001a98
c0d024d4:	b0105044 	.word	0xb0105044
c0d024d8:	000017ac 	.word	0x000017ac
c0d024dc:	00000153 	.word	0x00000153

c0d024e0 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d024e0:	b5b0      	push	{r4, r5, r7, lr}
c0d024e2:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d024e4:	2800      	cmp	r0, #0
c0d024e6:	d005      	beq.n	c0d024f4 <ui_display_debug+0x14>
c0d024e8:	2900      	cmp	r1, #0
c0d024ea:	d003      	beq.n	c0d024f4 <ui_display_debug+0x14>
c0d024ec:	2a00      	cmp	r2, #0
c0d024ee:	d001      	beq.n	c0d024f4 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d024f0:	f7fd feb8 	bl	c0d00264 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d024f4:	4c21      	ldr	r4, [pc, #132]	; (c0d0257c <ui_display_debug+0x9c>)
c0d024f6:	4823      	ldr	r0, [pc, #140]	; (c0d02584 <ui_display_debug+0xa4>)
c0d024f8:	4478      	add	r0, pc
c0d024fa:	6020      	str	r0, [r4, #0]
c0d024fc:	2004      	movs	r0, #4
c0d024fe:	6060      	str	r0, [r4, #4]
c0d02500:	4821      	ldr	r0, [pc, #132]	; (c0d02588 <ui_display_debug+0xa8>)
c0d02502:	4478      	add	r0, pc
c0d02504:	6120      	str	r0, [r4, #16]
c0d02506:	2500      	movs	r5, #0
c0d02508:	60e5      	str	r5, [r4, #12]
c0d0250a:	2003      	movs	r0, #3
c0d0250c:	7620      	strb	r0, [r4, #24]
c0d0250e:	61e5      	str	r5, [r4, #28]
c0d02510:	4620      	mov	r0, r4
c0d02512:	3018      	adds	r0, #24
c0d02514:	f7ff fedc 	bl	c0d022d0 <os_ux>
c0d02518:	61e0      	str	r0, [r4, #28]
c0d0251a:	f7ff f89d 	bl	c0d01658 <io_seproxyhal_init_ux>
c0d0251e:	60a5      	str	r5, [r4, #8]
c0d02520:	6820      	ldr	r0, [r4, #0]
c0d02522:	2800      	cmp	r0, #0
c0d02524:	d028      	beq.n	c0d02578 <ui_display_debug+0x98>
c0d02526:	69e0      	ldr	r0, [r4, #28]
c0d02528:	4915      	ldr	r1, [pc, #84]	; (c0d02580 <ui_display_debug+0xa0>)
c0d0252a:	4288      	cmp	r0, r1
c0d0252c:	d116      	bne.n	c0d0255c <ui_display_debug+0x7c>
c0d0252e:	e023      	b.n	c0d02578 <ui_display_debug+0x98>
c0d02530:	6860      	ldr	r0, [r4, #4]
c0d02532:	4285      	cmp	r5, r0
c0d02534:	d220      	bcs.n	c0d02578 <ui_display_debug+0x98>
c0d02536:	f7ff ff23 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d0253a:	2800      	cmp	r0, #0
c0d0253c:	d11c      	bne.n	c0d02578 <ui_display_debug+0x98>
c0d0253e:	68a0      	ldr	r0, [r4, #8]
c0d02540:	68e1      	ldr	r1, [r4, #12]
c0d02542:	2538      	movs	r5, #56	; 0x38
c0d02544:	4368      	muls	r0, r5
c0d02546:	6822      	ldr	r2, [r4, #0]
c0d02548:	1810      	adds	r0, r2, r0
c0d0254a:	2900      	cmp	r1, #0
c0d0254c:	d009      	beq.n	c0d02562 <ui_display_debug+0x82>
c0d0254e:	4788      	blx	r1
c0d02550:	2800      	cmp	r0, #0
c0d02552:	d106      	bne.n	c0d02562 <ui_display_debug+0x82>
c0d02554:	68a0      	ldr	r0, [r4, #8]
c0d02556:	1c45      	adds	r5, r0, #1
c0d02558:	60a5      	str	r5, [r4, #8]
c0d0255a:	6820      	ldr	r0, [r4, #0]
c0d0255c:	2800      	cmp	r0, #0
c0d0255e:	d1e7      	bne.n	c0d02530 <ui_display_debug+0x50>
c0d02560:	e00a      	b.n	c0d02578 <ui_display_debug+0x98>
c0d02562:	2801      	cmp	r0, #1
c0d02564:	d103      	bne.n	c0d0256e <ui_display_debug+0x8e>
c0d02566:	68a0      	ldr	r0, [r4, #8]
c0d02568:	4345      	muls	r5, r0
c0d0256a:	6820      	ldr	r0, [r4, #0]
c0d0256c:	1940      	adds	r0, r0, r5
c0d0256e:	f7fe fb2b 	bl	c0d00bc8 <io_seproxyhal_display>
c0d02572:	68a0      	ldr	r0, [r4, #8]
c0d02574:	1c40      	adds	r0, r0, #1
c0d02576:	60a0      	str	r0, [r4, #8]
}
c0d02578:	bdb0      	pop	{r4, r5, r7, pc}
c0d0257a:	46c0      	nop			; (mov r8, r8)
c0d0257c:	20001a98 	.word	0x20001a98
c0d02580:	b0105044 	.word	0xb0105044
c0d02584:	000016e0 	.word	0x000016e0
c0d02588:	00000087 	.word	0x00000087

c0d0258c <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d0258c:	b580      	push	{r7, lr}
c0d0258e:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d02590:	4905      	ldr	r1, [pc, #20]	; (c0d025a8 <bagl_ui_nanos_screen2_button+0x1c>)
c0d02592:	4288      	cmp	r0, r1
c0d02594:	d002      	beq.n	c0d0259c <bagl_ui_nanos_screen2_button+0x10>
c0d02596:	4905      	ldr	r1, [pc, #20]	; (c0d025ac <bagl_ui_nanos_screen2_button+0x20>)
c0d02598:	4288      	cmp	r0, r1
c0d0259a:	d102      	bne.n	c0d025a2 <bagl_ui_nanos_screen2_button+0x16>
c0d0259c:	2000      	movs	r0, #0
c0d0259e:	f7ff fe79 	bl	c0d02294 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d025a2:	2000      	movs	r0, #0
c0d025a4:	bd80      	pop	{r7, pc}
c0d025a6:	46c0      	nop			; (mov r8, r8)
c0d025a8:	80000002 	.word	0x80000002
c0d025ac:	80000001 	.word	0x80000001

c0d025b0 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d025b0:	b5b0      	push	{r4, r5, r7, lr}
c0d025b2:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d025b4:	2001      	movs	r0, #1
c0d025b6:	0204      	lsls	r4, r0, #8
c0d025b8:	f7ff fea8 	bl	c0d0230c <os_seph_features>
c0d025bc:	4220      	tst	r0, r4
c0d025be:	d136      	bne.n	c0d0262e <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d025c0:	4c3c      	ldr	r4, [pc, #240]	; (c0d026b4 <ui_idle+0x104>)
c0d025c2:	4840      	ldr	r0, [pc, #256]	; (c0d026c4 <ui_idle+0x114>)
c0d025c4:	4478      	add	r0, pc
c0d025c6:	6020      	str	r0, [r4, #0]
c0d025c8:	2004      	movs	r0, #4
c0d025ca:	6060      	str	r0, [r4, #4]
c0d025cc:	483e      	ldr	r0, [pc, #248]	; (c0d026c8 <ui_idle+0x118>)
c0d025ce:	4478      	add	r0, pc
c0d025d0:	6120      	str	r0, [r4, #16]
c0d025d2:	2500      	movs	r5, #0
c0d025d4:	60e5      	str	r5, [r4, #12]
c0d025d6:	2003      	movs	r0, #3
c0d025d8:	7620      	strb	r0, [r4, #24]
c0d025da:	61e5      	str	r5, [r4, #28]
c0d025dc:	4620      	mov	r0, r4
c0d025de:	3018      	adds	r0, #24
c0d025e0:	f7ff fe76 	bl	c0d022d0 <os_ux>
c0d025e4:	61e0      	str	r0, [r4, #28]
c0d025e6:	f7ff f837 	bl	c0d01658 <io_seproxyhal_init_ux>
c0d025ea:	60a5      	str	r5, [r4, #8]
c0d025ec:	6820      	ldr	r0, [r4, #0]
c0d025ee:	2800      	cmp	r0, #0
c0d025f0:	d05f      	beq.n	c0d026b2 <ui_idle+0x102>
c0d025f2:	69e0      	ldr	r0, [r4, #28]
c0d025f4:	4930      	ldr	r1, [pc, #192]	; (c0d026b8 <ui_idle+0x108>)
c0d025f6:	4288      	cmp	r0, r1
c0d025f8:	d116      	bne.n	c0d02628 <ui_idle+0x78>
c0d025fa:	e05a      	b.n	c0d026b2 <ui_idle+0x102>
c0d025fc:	6860      	ldr	r0, [r4, #4]
c0d025fe:	4285      	cmp	r5, r0
c0d02600:	d257      	bcs.n	c0d026b2 <ui_idle+0x102>
c0d02602:	f7ff febd 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d02606:	2800      	cmp	r0, #0
c0d02608:	d153      	bne.n	c0d026b2 <ui_idle+0x102>
c0d0260a:	68a0      	ldr	r0, [r4, #8]
c0d0260c:	68e1      	ldr	r1, [r4, #12]
c0d0260e:	2538      	movs	r5, #56	; 0x38
c0d02610:	4368      	muls	r0, r5
c0d02612:	6822      	ldr	r2, [r4, #0]
c0d02614:	1810      	adds	r0, r2, r0
c0d02616:	2900      	cmp	r1, #0
c0d02618:	d040      	beq.n	c0d0269c <ui_idle+0xec>
c0d0261a:	4788      	blx	r1
c0d0261c:	2800      	cmp	r0, #0
c0d0261e:	d13d      	bne.n	c0d0269c <ui_idle+0xec>
c0d02620:	68a0      	ldr	r0, [r4, #8]
c0d02622:	1c45      	adds	r5, r0, #1
c0d02624:	60a5      	str	r5, [r4, #8]
c0d02626:	6820      	ldr	r0, [r4, #0]
c0d02628:	2800      	cmp	r0, #0
c0d0262a:	d1e7      	bne.n	c0d025fc <ui_idle+0x4c>
c0d0262c:	e041      	b.n	c0d026b2 <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d0262e:	4c21      	ldr	r4, [pc, #132]	; (c0d026b4 <ui_idle+0x104>)
c0d02630:	4822      	ldr	r0, [pc, #136]	; (c0d026bc <ui_idle+0x10c>)
c0d02632:	4478      	add	r0, pc
c0d02634:	6020      	str	r0, [r4, #0]
c0d02636:	2004      	movs	r0, #4
c0d02638:	6060      	str	r0, [r4, #4]
c0d0263a:	4821      	ldr	r0, [pc, #132]	; (c0d026c0 <ui_idle+0x110>)
c0d0263c:	4478      	add	r0, pc
c0d0263e:	6120      	str	r0, [r4, #16]
c0d02640:	2500      	movs	r5, #0
c0d02642:	60e5      	str	r5, [r4, #12]
c0d02644:	2003      	movs	r0, #3
c0d02646:	7620      	strb	r0, [r4, #24]
c0d02648:	61e5      	str	r5, [r4, #28]
c0d0264a:	4620      	mov	r0, r4
c0d0264c:	3018      	adds	r0, #24
c0d0264e:	f7ff fe3f 	bl	c0d022d0 <os_ux>
c0d02652:	61e0      	str	r0, [r4, #28]
c0d02654:	f7ff f800 	bl	c0d01658 <io_seproxyhal_init_ux>
c0d02658:	60a5      	str	r5, [r4, #8]
c0d0265a:	6820      	ldr	r0, [r4, #0]
c0d0265c:	2800      	cmp	r0, #0
c0d0265e:	d028      	beq.n	c0d026b2 <ui_idle+0x102>
c0d02660:	69e0      	ldr	r0, [r4, #28]
c0d02662:	4915      	ldr	r1, [pc, #84]	; (c0d026b8 <ui_idle+0x108>)
c0d02664:	4288      	cmp	r0, r1
c0d02666:	d116      	bne.n	c0d02696 <ui_idle+0xe6>
c0d02668:	e023      	b.n	c0d026b2 <ui_idle+0x102>
c0d0266a:	6860      	ldr	r0, [r4, #4]
c0d0266c:	4285      	cmp	r5, r0
c0d0266e:	d220      	bcs.n	c0d026b2 <ui_idle+0x102>
c0d02670:	f7ff fe86 	bl	c0d02380 <io_seproxyhal_spi_is_status_sent>
c0d02674:	2800      	cmp	r0, #0
c0d02676:	d11c      	bne.n	c0d026b2 <ui_idle+0x102>
c0d02678:	68a0      	ldr	r0, [r4, #8]
c0d0267a:	68e1      	ldr	r1, [r4, #12]
c0d0267c:	2538      	movs	r5, #56	; 0x38
c0d0267e:	4368      	muls	r0, r5
c0d02680:	6822      	ldr	r2, [r4, #0]
c0d02682:	1810      	adds	r0, r2, r0
c0d02684:	2900      	cmp	r1, #0
c0d02686:	d009      	beq.n	c0d0269c <ui_idle+0xec>
c0d02688:	4788      	blx	r1
c0d0268a:	2800      	cmp	r0, #0
c0d0268c:	d106      	bne.n	c0d0269c <ui_idle+0xec>
c0d0268e:	68a0      	ldr	r0, [r4, #8]
c0d02690:	1c45      	adds	r5, r0, #1
c0d02692:	60a5      	str	r5, [r4, #8]
c0d02694:	6820      	ldr	r0, [r4, #0]
c0d02696:	2800      	cmp	r0, #0
c0d02698:	d1e7      	bne.n	c0d0266a <ui_idle+0xba>
c0d0269a:	e00a      	b.n	c0d026b2 <ui_idle+0x102>
c0d0269c:	2801      	cmp	r0, #1
c0d0269e:	d103      	bne.n	c0d026a8 <ui_idle+0xf8>
c0d026a0:	68a0      	ldr	r0, [r4, #8]
c0d026a2:	4345      	muls	r5, r0
c0d026a4:	6820      	ldr	r0, [r4, #0]
c0d026a6:	1940      	adds	r0, r0, r5
c0d026a8:	f7fe fa8e 	bl	c0d00bc8 <io_seproxyhal_display>
c0d026ac:	68a0      	ldr	r0, [r4, #8]
c0d026ae:	1c40      	adds	r0, r0, #1
c0d026b0:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d026b2:	bdb0      	pop	{r4, r5, r7, pc}
c0d026b4:	20001a98 	.word	0x20001a98
c0d026b8:	b0105044 	.word	0xb0105044
c0d026bc:	00001686 	.word	0x00001686
c0d026c0:	0000008d 	.word	0x0000008d
c0d026c4:	00001534 	.word	0x00001534
c0d026c8:	fffffe27 	.word	0xfffffe27

c0d026cc <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d026cc:	2000      	movs	r0, #0
c0d026ce:	4770      	bx	lr

c0d026d0 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d026d0:	b5d0      	push	{r4, r6, r7, lr}
c0d026d2:	af02      	add	r7, sp, #8
c0d026d4:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d026d6:	4620      	mov	r0, r4
c0d026d8:	f7ff fddc 	bl	c0d02294 <os_sched_exit>
    return NULL;
c0d026dc:	4620      	mov	r0, r4
c0d026de:	bdd0      	pop	{r4, r6, r7, pc}

c0d026e0 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d026e0:	4902      	ldr	r1, [pc, #8]	; (c0d026ec <USBD_LL_Init+0xc>)
c0d026e2:	2000      	movs	r0, #0
c0d026e4:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d026e6:	4902      	ldr	r1, [pc, #8]	; (c0d026f0 <USBD_LL_Init+0x10>)
c0d026e8:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d026ea:	4770      	bx	lr
c0d026ec:	20001d2c 	.word	0x20001d2c
c0d026f0:	20001d30 	.word	0x20001d30

c0d026f4 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d026f4:	b5d0      	push	{r4, r6, r7, lr}
c0d026f6:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d026f8:	4806      	ldr	r0, [pc, #24]	; (c0d02714 <USBD_LL_DeInit+0x20>)
c0d026fa:	214f      	movs	r1, #79	; 0x4f
c0d026fc:	7001      	strb	r1, [r0, #0]
c0d026fe:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02700:	7044      	strb	r4, [r0, #1]
c0d02702:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02704:	7081      	strb	r1, [r0, #2]
c0d02706:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02708:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0270a:	2104      	movs	r1, #4
c0d0270c:	f7ff fe1a 	bl	c0d02344 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02710:	4620      	mov	r0, r4
c0d02712:	bdd0      	pop	{r4, r6, r7, pc}
c0d02714:	20001a18 	.word	0x20001a18

c0d02718 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02718:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0271a:	af03      	add	r7, sp, #12
c0d0271c:	b083      	sub	sp, #12
c0d0271e:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02720:	264f      	movs	r6, #79	; 0x4f
c0d02722:	702e      	strb	r6, [r5, #0]
c0d02724:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02726:	706c      	strb	r4, [r5, #1]
c0d02728:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d0272a:	70a8      	strb	r0, [r5, #2]
c0d0272c:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0272e:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d02730:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02732:	2105      	movs	r1, #5
c0d02734:	4628      	mov	r0, r5
c0d02736:	f7ff fe05 	bl	c0d02344 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0273a:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d0273c:	706c      	strb	r4, [r5, #1]
c0d0273e:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d02740:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d02742:	70e8      	strb	r0, [r5, #3]
c0d02744:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d02746:	4628      	mov	r0, r5
c0d02748:	f7ff fdfc 	bl	c0d02344 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0274c:	4620      	mov	r0, r4
c0d0274e:	b003      	add	sp, #12
c0d02750:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02752 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d02752:	b5d0      	push	{r4, r6, r7, lr}
c0d02754:	af02      	add	r7, sp, #8
c0d02756:	b082      	sub	sp, #8
c0d02758:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0275a:	214f      	movs	r1, #79	; 0x4f
c0d0275c:	7001      	strb	r1, [r0, #0]
c0d0275e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02760:	7044      	strb	r4, [r0, #1]
c0d02762:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d02764:	7081      	strb	r1, [r0, #2]
c0d02766:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02768:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d0276a:	2104      	movs	r1, #4
c0d0276c:	f7ff fdea 	bl	c0d02344 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02770:	4620      	mov	r0, r4
c0d02772:	b002      	add	sp, #8
c0d02774:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02778 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d02778:	b5b0      	push	{r4, r5, r7, lr}
c0d0277a:	af02      	add	r7, sp, #8
c0d0277c:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d0277e:	480f      	ldr	r0, [pc, #60]	; (c0d027bc <USBD_LL_OpenEP+0x44>)
c0d02780:	2400      	movs	r4, #0
c0d02782:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d02784:	480e      	ldr	r0, [pc, #56]	; (c0d027c0 <USBD_LL_OpenEP+0x48>)
c0d02786:	6004      	str	r4, [r0, #0]
c0d02788:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0278a:	254f      	movs	r5, #79	; 0x4f
c0d0278c:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d0278e:	7044      	strb	r4, [r0, #1]
c0d02790:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d02792:	7085      	strb	r5, [r0, #2]
c0d02794:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02796:	70c5      	strb	r5, [r0, #3]
c0d02798:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d0279a:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d0279c:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d0279e:	2a03      	cmp	r2, #3
c0d027a0:	d802      	bhi.n	c0d027a8 <USBD_LL_OpenEP+0x30>
c0d027a2:	00d0      	lsls	r0, r2, #3
c0d027a4:	4c07      	ldr	r4, [pc, #28]	; (c0d027c4 <USBD_LL_OpenEP+0x4c>)
c0d027a6:	40c4      	lsrs	r4, r0
c0d027a8:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d027aa:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d027ac:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d027ae:	2108      	movs	r1, #8
c0d027b0:	f7ff fdc8 	bl	c0d02344 <io_seproxyhal_spi_send>
c0d027b4:	2000      	movs	r0, #0
  return USBD_OK; 
c0d027b6:	b002      	add	sp, #8
c0d027b8:	bdb0      	pop	{r4, r5, r7, pc}
c0d027ba:	46c0      	nop			; (mov r8, r8)
c0d027bc:	20001d2c 	.word	0x20001d2c
c0d027c0:	20001d30 	.word	0x20001d30
c0d027c4:	02030401 	.word	0x02030401

c0d027c8 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d027c8:	b5d0      	push	{r4, r6, r7, lr}
c0d027ca:	af02      	add	r7, sp, #8
c0d027cc:	b082      	sub	sp, #8
c0d027ce:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d027d0:	224f      	movs	r2, #79	; 0x4f
c0d027d2:	7002      	strb	r2, [r0, #0]
c0d027d4:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d027d6:	7044      	strb	r4, [r0, #1]
c0d027d8:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d027da:	7082      	strb	r2, [r0, #2]
c0d027dc:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d027de:	70c2      	strb	r2, [r0, #3]
c0d027e0:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d027e2:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d027e4:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d027e6:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d027e8:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d027ea:	2108      	movs	r1, #8
c0d027ec:	f7ff fdaa 	bl	c0d02344 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d027f0:	4620      	mov	r0, r4
c0d027f2:	b002      	add	sp, #8
c0d027f4:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d027f8 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d027f8:	b5b0      	push	{r4, r5, r7, lr}
c0d027fa:	af02      	add	r7, sp, #8
c0d027fc:	b082      	sub	sp, #8
c0d027fe:	460d      	mov	r5, r1
c0d02800:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02802:	2150      	movs	r1, #80	; 0x50
c0d02804:	7001      	strb	r1, [r0, #0]
c0d02806:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02808:	7044      	strb	r4, [r0, #1]
c0d0280a:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d0280c:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0280e:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02810:	2140      	movs	r1, #64	; 0x40
c0d02812:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02814:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02816:	2106      	movs	r1, #6
c0d02818:	f7ff fd94 	bl	c0d02344 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d0281c:	2080      	movs	r0, #128	; 0x80
c0d0281e:	4205      	tst	r5, r0
c0d02820:	d101      	bne.n	c0d02826 <USBD_LL_StallEP+0x2e>
c0d02822:	4807      	ldr	r0, [pc, #28]	; (c0d02840 <USBD_LL_StallEP+0x48>)
c0d02824:	e000      	b.n	c0d02828 <USBD_LL_StallEP+0x30>
c0d02826:	4805      	ldr	r0, [pc, #20]	; (c0d0283c <USBD_LL_StallEP+0x44>)
c0d02828:	6801      	ldr	r1, [r0, #0]
c0d0282a:	227f      	movs	r2, #127	; 0x7f
c0d0282c:	4015      	ands	r5, r2
c0d0282e:	2201      	movs	r2, #1
c0d02830:	40aa      	lsls	r2, r5
c0d02832:	430a      	orrs	r2, r1
c0d02834:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02836:	4620      	mov	r0, r4
c0d02838:	b002      	add	sp, #8
c0d0283a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0283c:	20001d2c 	.word	0x20001d2c
c0d02840:	20001d30 	.word	0x20001d30

c0d02844 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02844:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02846:	af03      	add	r7, sp, #12
c0d02848:	b083      	sub	sp, #12
c0d0284a:	460d      	mov	r5, r1
c0d0284c:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0284e:	2150      	movs	r1, #80	; 0x50
c0d02850:	7001      	strb	r1, [r0, #0]
c0d02852:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02854:	7044      	strb	r4, [r0, #1]
c0d02856:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02858:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0285a:	70c5      	strb	r5, [r0, #3]
c0d0285c:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d0285e:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d02860:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02862:	2106      	movs	r1, #6
c0d02864:	f7ff fd6e 	bl	c0d02344 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02868:	4235      	tst	r5, r6
c0d0286a:	d101      	bne.n	c0d02870 <USBD_LL_ClearStallEP+0x2c>
c0d0286c:	4807      	ldr	r0, [pc, #28]	; (c0d0288c <USBD_LL_ClearStallEP+0x48>)
c0d0286e:	e000      	b.n	c0d02872 <USBD_LL_ClearStallEP+0x2e>
c0d02870:	4805      	ldr	r0, [pc, #20]	; (c0d02888 <USBD_LL_ClearStallEP+0x44>)
c0d02872:	6801      	ldr	r1, [r0, #0]
c0d02874:	227f      	movs	r2, #127	; 0x7f
c0d02876:	4015      	ands	r5, r2
c0d02878:	2201      	movs	r2, #1
c0d0287a:	40aa      	lsls	r2, r5
c0d0287c:	4391      	bics	r1, r2
c0d0287e:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02880:	4620      	mov	r0, r4
c0d02882:	b003      	add	sp, #12
c0d02884:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02886:	46c0      	nop			; (mov r8, r8)
c0d02888:	20001d2c 	.word	0x20001d2c
c0d0288c:	20001d30 	.word	0x20001d30

c0d02890 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d02890:	2080      	movs	r0, #128	; 0x80
c0d02892:	4201      	tst	r1, r0
c0d02894:	d001      	beq.n	c0d0289a <USBD_LL_IsStallEP+0xa>
c0d02896:	4806      	ldr	r0, [pc, #24]	; (c0d028b0 <USBD_LL_IsStallEP+0x20>)
c0d02898:	e000      	b.n	c0d0289c <USBD_LL_IsStallEP+0xc>
c0d0289a:	4804      	ldr	r0, [pc, #16]	; (c0d028ac <USBD_LL_IsStallEP+0x1c>)
c0d0289c:	6800      	ldr	r0, [r0, #0]
c0d0289e:	227f      	movs	r2, #127	; 0x7f
c0d028a0:	4011      	ands	r1, r2
c0d028a2:	2201      	movs	r2, #1
c0d028a4:	408a      	lsls	r2, r1
c0d028a6:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d028a8:	b2d0      	uxtb	r0, r2
c0d028aa:	4770      	bx	lr
c0d028ac:	20001d30 	.word	0x20001d30
c0d028b0:	20001d2c 	.word	0x20001d2c

c0d028b4 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d028b4:	b5d0      	push	{r4, r6, r7, lr}
c0d028b6:	af02      	add	r7, sp, #8
c0d028b8:	b082      	sub	sp, #8
c0d028ba:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d028bc:	224f      	movs	r2, #79	; 0x4f
c0d028be:	7002      	strb	r2, [r0, #0]
c0d028c0:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d028c2:	7044      	strb	r4, [r0, #1]
c0d028c4:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d028c6:	7082      	strb	r2, [r0, #2]
c0d028c8:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d028ca:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d028cc:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d028ce:	2105      	movs	r1, #5
c0d028d0:	f7ff fd38 	bl	c0d02344 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d028d4:	4620      	mov	r0, r4
c0d028d6:	b002      	add	sp, #8
c0d028d8:	bdd0      	pop	{r4, r6, r7, pc}

c0d028da <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d028da:	b5b0      	push	{r4, r5, r7, lr}
c0d028dc:	af02      	add	r7, sp, #8
c0d028de:	b082      	sub	sp, #8
c0d028e0:	461c      	mov	r4, r3
c0d028e2:	4615      	mov	r5, r2
c0d028e4:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d028e6:	2250      	movs	r2, #80	; 0x50
c0d028e8:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d028ea:	1ce2      	adds	r2, r4, #3
c0d028ec:	0a13      	lsrs	r3, r2, #8
c0d028ee:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d028f0:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d028f2:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d028f4:	2120      	movs	r1, #32
c0d028f6:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d028f8:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d028fa:	2106      	movs	r1, #6
c0d028fc:	f7ff fd22 	bl	c0d02344 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02900:	4628      	mov	r0, r5
c0d02902:	4621      	mov	r1, r4
c0d02904:	f7ff fd1e 	bl	c0d02344 <io_seproxyhal_spi_send>
c0d02908:	2000      	movs	r0, #0
  return USBD_OK;   
c0d0290a:	b002      	add	sp, #8
c0d0290c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0290e <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d0290e:	b5d0      	push	{r4, r6, r7, lr}
c0d02910:	af02      	add	r7, sp, #8
c0d02912:	b082      	sub	sp, #8
c0d02914:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02916:	2350      	movs	r3, #80	; 0x50
c0d02918:	7003      	strb	r3, [r0, #0]
c0d0291a:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d0291c:	7044      	strb	r4, [r0, #1]
c0d0291e:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02920:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d02922:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02924:	2130      	movs	r1, #48	; 0x30
c0d02926:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02928:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0292a:	2106      	movs	r1, #6
c0d0292c:	f7ff fd0a 	bl	c0d02344 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d02930:	4620      	mov	r0, r4
c0d02932:	b002      	add	sp, #8
c0d02934:	bdd0      	pop	{r4, r6, r7, pc}

c0d02936 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02936:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02938:	af03      	add	r7, sp, #12
c0d0293a:	b081      	sub	sp, #4
c0d0293c:	4615      	mov	r5, r2
c0d0293e:	460e      	mov	r6, r1
c0d02940:	4604      	mov	r4, r0
c0d02942:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d02944:	2c00      	cmp	r4, #0
c0d02946:	d011      	beq.n	c0d0296c <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02948:	2049      	movs	r0, #73	; 0x49
c0d0294a:	0081      	lsls	r1, r0, #2
c0d0294c:	4620      	mov	r0, r4
c0d0294e:	f000 ffd7 	bl	c0d03900 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d02952:	2e00      	cmp	r6, #0
c0d02954:	d002      	beq.n	c0d0295c <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d02956:	2011      	movs	r0, #17
c0d02958:	0100      	lsls	r0, r0, #4
c0d0295a:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d0295c:	20fc      	movs	r0, #252	; 0xfc
c0d0295e:	2101      	movs	r1, #1
c0d02960:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d02962:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d02964:	4620      	mov	r0, r4
c0d02966:	f7ff febb 	bl	c0d026e0 <USBD_LL_Init>
c0d0296a:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d0296c:	b2c0      	uxtb	r0, r0
c0d0296e:	b001      	add	sp, #4
c0d02970:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02972 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d02972:	b5d0      	push	{r4, r6, r7, lr}
c0d02974:	af02      	add	r7, sp, #8
c0d02976:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02978:	20fc      	movs	r0, #252	; 0xfc
c0d0297a:	2101      	movs	r1, #1
c0d0297c:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d0297e:	2045      	movs	r0, #69	; 0x45
c0d02980:	0080      	lsls	r0, r0, #2
c0d02982:	5820      	ldr	r0, [r4, r0]
c0d02984:	2800      	cmp	r0, #0
c0d02986:	d006      	beq.n	c0d02996 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02988:	6840      	ldr	r0, [r0, #4]
c0d0298a:	f7ff fb1f 	bl	c0d01fcc <pic>
c0d0298e:	4602      	mov	r2, r0
c0d02990:	7921      	ldrb	r1, [r4, #4]
c0d02992:	4620      	mov	r0, r4
c0d02994:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d02996:	4620      	mov	r0, r4
c0d02998:	f7ff fedb 	bl	c0d02752 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d0299c:	4620      	mov	r0, r4
c0d0299e:	f7ff fea9 	bl	c0d026f4 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d029a2:	2000      	movs	r0, #0
c0d029a4:	bdd0      	pop	{r4, r6, r7, pc}

c0d029a6 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d029a6:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d029a8:	2900      	cmp	r1, #0
c0d029aa:	d003      	beq.n	c0d029b4 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d029ac:	2245      	movs	r2, #69	; 0x45
c0d029ae:	0092      	lsls	r2, r2, #2
c0d029b0:	5081      	str	r1, [r0, r2]
c0d029b2:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d029b4:	b2d0      	uxtb	r0, r2
c0d029b6:	4770      	bx	lr

c0d029b8 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d029b8:	b580      	push	{r7, lr}
c0d029ba:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d029bc:	f7ff feac 	bl	c0d02718 <USBD_LL_Start>
  
  return USBD_OK;  
c0d029c0:	2000      	movs	r0, #0
c0d029c2:	bd80      	pop	{r7, pc}

c0d029c4 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d029c4:	b5b0      	push	{r4, r5, r7, lr}
c0d029c6:	af02      	add	r7, sp, #8
c0d029c8:	460c      	mov	r4, r1
c0d029ca:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d029cc:	2045      	movs	r0, #69	; 0x45
c0d029ce:	0080      	lsls	r0, r0, #2
c0d029d0:	5828      	ldr	r0, [r5, r0]
c0d029d2:	2800      	cmp	r0, #0
c0d029d4:	d00c      	beq.n	c0d029f0 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d029d6:	6800      	ldr	r0, [r0, #0]
c0d029d8:	f7ff faf8 	bl	c0d01fcc <pic>
c0d029dc:	4602      	mov	r2, r0
c0d029de:	4628      	mov	r0, r5
c0d029e0:	4621      	mov	r1, r4
c0d029e2:	4790      	blx	r2
c0d029e4:	4601      	mov	r1, r0
c0d029e6:	2002      	movs	r0, #2
c0d029e8:	2900      	cmp	r1, #0
c0d029ea:	d100      	bne.n	c0d029ee <USBD_SetClassConfig+0x2a>
c0d029ec:	4608      	mov	r0, r1
c0d029ee:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d029f0:	2002      	movs	r0, #2
c0d029f2:	bdb0      	pop	{r4, r5, r7, pc}

c0d029f4 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d029f4:	b5b0      	push	{r4, r5, r7, lr}
c0d029f6:	af02      	add	r7, sp, #8
c0d029f8:	460c      	mov	r4, r1
c0d029fa:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d029fc:	2045      	movs	r0, #69	; 0x45
c0d029fe:	0080      	lsls	r0, r0, #2
c0d02a00:	5828      	ldr	r0, [r5, r0]
c0d02a02:	2800      	cmp	r0, #0
c0d02a04:	d006      	beq.n	c0d02a14 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02a06:	6840      	ldr	r0, [r0, #4]
c0d02a08:	f7ff fae0 	bl	c0d01fcc <pic>
c0d02a0c:	4602      	mov	r2, r0
c0d02a0e:	4628      	mov	r0, r5
c0d02a10:	4621      	mov	r1, r4
c0d02a12:	4790      	blx	r2
  }
  return USBD_OK;
c0d02a14:	2000      	movs	r0, #0
c0d02a16:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a18 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02a18:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a1a:	af03      	add	r7, sp, #12
c0d02a1c:	b081      	sub	sp, #4
c0d02a1e:	4604      	mov	r4, r0
c0d02a20:	2021      	movs	r0, #33	; 0x21
c0d02a22:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02a24:	19a5      	adds	r5, r4, r6
c0d02a26:	4628      	mov	r0, r5
c0d02a28:	f000 fb69 	bl	c0d030fe <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02a2c:	20f4      	movs	r0, #244	; 0xf4
c0d02a2e:	2101      	movs	r1, #1
c0d02a30:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d02a32:	2087      	movs	r0, #135	; 0x87
c0d02a34:	0040      	lsls	r0, r0, #1
c0d02a36:	5a20      	ldrh	r0, [r4, r0]
c0d02a38:	21f8      	movs	r1, #248	; 0xf8
c0d02a3a:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02a3c:	5da1      	ldrb	r1, [r4, r6]
c0d02a3e:	201f      	movs	r0, #31
c0d02a40:	4008      	ands	r0, r1
c0d02a42:	2802      	cmp	r0, #2
c0d02a44:	d008      	beq.n	c0d02a58 <USBD_LL_SetupStage+0x40>
c0d02a46:	2801      	cmp	r0, #1
c0d02a48:	d00b      	beq.n	c0d02a62 <USBD_LL_SetupStage+0x4a>
c0d02a4a:	2800      	cmp	r0, #0
c0d02a4c:	d10e      	bne.n	c0d02a6c <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d02a4e:	4620      	mov	r0, r4
c0d02a50:	4629      	mov	r1, r5
c0d02a52:	f000 f8f1 	bl	c0d02c38 <USBD_StdDevReq>
c0d02a56:	e00e      	b.n	c0d02a76 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02a58:	4620      	mov	r0, r4
c0d02a5a:	4629      	mov	r1, r5
c0d02a5c:	f000 fad3 	bl	c0d03006 <USBD_StdEPReq>
c0d02a60:	e009      	b.n	c0d02a76 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d02a62:	4620      	mov	r0, r4
c0d02a64:	4629      	mov	r1, r5
c0d02a66:	f000 faa6 	bl	c0d02fb6 <USBD_StdItfReq>
c0d02a6a:	e004      	b.n	c0d02a76 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d02a6c:	2080      	movs	r0, #128	; 0x80
c0d02a6e:	4001      	ands	r1, r0
c0d02a70:	4620      	mov	r0, r4
c0d02a72:	f7ff fec1 	bl	c0d027f8 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d02a76:	2000      	movs	r0, #0
c0d02a78:	b001      	add	sp, #4
c0d02a7a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a7c <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d02a7c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a7e:	af03      	add	r7, sp, #12
c0d02a80:	b081      	sub	sp, #4
c0d02a82:	4615      	mov	r5, r2
c0d02a84:	460e      	mov	r6, r1
c0d02a86:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02a88:	2e00      	cmp	r6, #0
c0d02a8a:	d011      	beq.n	c0d02ab0 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02a8c:	2045      	movs	r0, #69	; 0x45
c0d02a8e:	0080      	lsls	r0, r0, #2
c0d02a90:	5820      	ldr	r0, [r4, r0]
c0d02a92:	6980      	ldr	r0, [r0, #24]
c0d02a94:	2800      	cmp	r0, #0
c0d02a96:	d034      	beq.n	c0d02b02 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02a98:	21fc      	movs	r1, #252	; 0xfc
c0d02a9a:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02a9c:	2903      	cmp	r1, #3
c0d02a9e:	d130      	bne.n	c0d02b02 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02aa0:	f7ff fa94 	bl	c0d01fcc <pic>
c0d02aa4:	4603      	mov	r3, r0
c0d02aa6:	4620      	mov	r0, r4
c0d02aa8:	4631      	mov	r1, r6
c0d02aaa:	462a      	mov	r2, r5
c0d02aac:	4798      	blx	r3
c0d02aae:	e028      	b.n	c0d02b02 <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02ab0:	20f4      	movs	r0, #244	; 0xf4
c0d02ab2:	5820      	ldr	r0, [r4, r0]
c0d02ab4:	2803      	cmp	r0, #3
c0d02ab6:	d124      	bne.n	c0d02b02 <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02ab8:	2090      	movs	r0, #144	; 0x90
c0d02aba:	5820      	ldr	r0, [r4, r0]
c0d02abc:	218c      	movs	r1, #140	; 0x8c
c0d02abe:	5861      	ldr	r1, [r4, r1]
c0d02ac0:	4622      	mov	r2, r4
c0d02ac2:	328c      	adds	r2, #140	; 0x8c
c0d02ac4:	4281      	cmp	r1, r0
c0d02ac6:	d90a      	bls.n	c0d02ade <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02ac8:	1a09      	subs	r1, r1, r0
c0d02aca:	6011      	str	r1, [r2, #0]
c0d02acc:	4281      	cmp	r1, r0
c0d02ace:	d300      	bcc.n	c0d02ad2 <USBD_LL_DataOutStage+0x56>
c0d02ad0:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d02ad2:	b28a      	uxth	r2, r1
c0d02ad4:	4620      	mov	r0, r4
c0d02ad6:	4629      	mov	r1, r5
c0d02ad8:	f000 fc70 	bl	c0d033bc <USBD_CtlContinueRx>
c0d02adc:	e011      	b.n	c0d02b02 <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02ade:	2045      	movs	r0, #69	; 0x45
c0d02ae0:	0080      	lsls	r0, r0, #2
c0d02ae2:	5820      	ldr	r0, [r4, r0]
c0d02ae4:	6900      	ldr	r0, [r0, #16]
c0d02ae6:	2800      	cmp	r0, #0
c0d02ae8:	d008      	beq.n	c0d02afc <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02aea:	21fc      	movs	r1, #252	; 0xfc
c0d02aec:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02aee:	2903      	cmp	r1, #3
c0d02af0:	d104      	bne.n	c0d02afc <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02af2:	f7ff fa6b 	bl	c0d01fcc <pic>
c0d02af6:	4601      	mov	r1, r0
c0d02af8:	4620      	mov	r0, r4
c0d02afa:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02afc:	4620      	mov	r0, r4
c0d02afe:	f000 fc65 	bl	c0d033cc <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02b02:	2000      	movs	r0, #0
c0d02b04:	b001      	add	sp, #4
c0d02b06:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b08 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02b08:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b0a:	af03      	add	r7, sp, #12
c0d02b0c:	b081      	sub	sp, #4
c0d02b0e:	460d      	mov	r5, r1
c0d02b10:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02b12:	2d00      	cmp	r5, #0
c0d02b14:	d012      	beq.n	c0d02b3c <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02b16:	2045      	movs	r0, #69	; 0x45
c0d02b18:	0080      	lsls	r0, r0, #2
c0d02b1a:	5820      	ldr	r0, [r4, r0]
c0d02b1c:	2800      	cmp	r0, #0
c0d02b1e:	d054      	beq.n	c0d02bca <USBD_LL_DataInStage+0xc2>
c0d02b20:	6940      	ldr	r0, [r0, #20]
c0d02b22:	2800      	cmp	r0, #0
c0d02b24:	d051      	beq.n	c0d02bca <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02b26:	21fc      	movs	r1, #252	; 0xfc
c0d02b28:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02b2a:	2903      	cmp	r1, #3
c0d02b2c:	d14d      	bne.n	c0d02bca <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d02b2e:	f7ff fa4d 	bl	c0d01fcc <pic>
c0d02b32:	4602      	mov	r2, r0
c0d02b34:	4620      	mov	r0, r4
c0d02b36:	4629      	mov	r1, r5
c0d02b38:	4790      	blx	r2
c0d02b3a:	e046      	b.n	c0d02bca <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02b3c:	20f4      	movs	r0, #244	; 0xf4
c0d02b3e:	5820      	ldr	r0, [r4, r0]
c0d02b40:	2802      	cmp	r0, #2
c0d02b42:	d13a      	bne.n	c0d02bba <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02b44:	69e0      	ldr	r0, [r4, #28]
c0d02b46:	6a25      	ldr	r5, [r4, #32]
c0d02b48:	42a8      	cmp	r0, r5
c0d02b4a:	d90b      	bls.n	c0d02b64 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02b4c:	1b40      	subs	r0, r0, r5
c0d02b4e:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d02b50:	2109      	movs	r1, #9
c0d02b52:	014a      	lsls	r2, r1, #5
c0d02b54:	58a1      	ldr	r1, [r4, r2]
c0d02b56:	1949      	adds	r1, r1, r5
c0d02b58:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02b5a:	b282      	uxth	r2, r0
c0d02b5c:	4620      	mov	r0, r4
c0d02b5e:	f000 fc1e 	bl	c0d0339e <USBD_CtlContinueSendData>
c0d02b62:	e02a      	b.n	c0d02bba <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02b64:	69a6      	ldr	r6, [r4, #24]
c0d02b66:	4630      	mov	r0, r6
c0d02b68:	4629      	mov	r1, r5
c0d02b6a:	f000 fccf 	bl	c0d0350c <__aeabi_uidivmod>
c0d02b6e:	42ae      	cmp	r6, r5
c0d02b70:	d30f      	bcc.n	c0d02b92 <USBD_LL_DataInStage+0x8a>
c0d02b72:	2900      	cmp	r1, #0
c0d02b74:	d10d      	bne.n	c0d02b92 <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02b76:	20f8      	movs	r0, #248	; 0xf8
c0d02b78:	5820      	ldr	r0, [r4, r0]
c0d02b7a:	4625      	mov	r5, r4
c0d02b7c:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02b7e:	4286      	cmp	r6, r0
c0d02b80:	d207      	bcs.n	c0d02b92 <USBD_LL_DataInStage+0x8a>
c0d02b82:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02b84:	4620      	mov	r0, r4
c0d02b86:	4631      	mov	r1, r6
c0d02b88:	4632      	mov	r2, r6
c0d02b8a:	f000 fc08 	bl	c0d0339e <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02b8e:	602e      	str	r6, [r5, #0]
c0d02b90:	e013      	b.n	c0d02bba <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02b92:	2045      	movs	r0, #69	; 0x45
c0d02b94:	0080      	lsls	r0, r0, #2
c0d02b96:	5820      	ldr	r0, [r4, r0]
c0d02b98:	2800      	cmp	r0, #0
c0d02b9a:	d00b      	beq.n	c0d02bb4 <USBD_LL_DataInStage+0xac>
c0d02b9c:	68c0      	ldr	r0, [r0, #12]
c0d02b9e:	2800      	cmp	r0, #0
c0d02ba0:	d008      	beq.n	c0d02bb4 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02ba2:	21fc      	movs	r1, #252	; 0xfc
c0d02ba4:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02ba6:	2903      	cmp	r1, #3
c0d02ba8:	d104      	bne.n	c0d02bb4 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02baa:	f7ff fa0f 	bl	c0d01fcc <pic>
c0d02bae:	4601      	mov	r1, r0
c0d02bb0:	4620      	mov	r0, r4
c0d02bb2:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02bb4:	4620      	mov	r0, r4
c0d02bb6:	f000 fc16 	bl	c0d033e6 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02bba:	2001      	movs	r0, #1
c0d02bbc:	0201      	lsls	r1, r0, #8
c0d02bbe:	1860      	adds	r0, r4, r1
c0d02bc0:	5c61      	ldrb	r1, [r4, r1]
c0d02bc2:	2901      	cmp	r1, #1
c0d02bc4:	d101      	bne.n	c0d02bca <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02bc6:	2100      	movs	r1, #0
c0d02bc8:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02bca:	2000      	movs	r0, #0
c0d02bcc:	b001      	add	sp, #4
c0d02bce:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02bd0 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02bd0:	b5d0      	push	{r4, r6, r7, lr}
c0d02bd2:	af02      	add	r7, sp, #8
c0d02bd4:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02bd6:	2090      	movs	r0, #144	; 0x90
c0d02bd8:	2140      	movs	r1, #64	; 0x40
c0d02bda:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02bdc:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02bde:	20fc      	movs	r0, #252	; 0xfc
c0d02be0:	2101      	movs	r1, #1
c0d02be2:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02be4:	2045      	movs	r0, #69	; 0x45
c0d02be6:	0080      	lsls	r0, r0, #2
c0d02be8:	5820      	ldr	r0, [r4, r0]
c0d02bea:	2800      	cmp	r0, #0
c0d02bec:	d006      	beq.n	c0d02bfc <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02bee:	6840      	ldr	r0, [r0, #4]
c0d02bf0:	f7ff f9ec 	bl	c0d01fcc <pic>
c0d02bf4:	4602      	mov	r2, r0
c0d02bf6:	7921      	ldrb	r1, [r4, #4]
c0d02bf8:	4620      	mov	r0, r4
c0d02bfa:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02bfc:	2000      	movs	r0, #0
c0d02bfe:	bdd0      	pop	{r4, r6, r7, pc}

c0d02c00 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02c00:	7401      	strb	r1, [r0, #16]
c0d02c02:	2000      	movs	r0, #0
  return USBD_OK;
c0d02c04:	4770      	bx	lr

c0d02c06 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02c06:	2000      	movs	r0, #0
c0d02c08:	4770      	bx	lr

c0d02c0a <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02c0a:	2000      	movs	r0, #0
c0d02c0c:	4770      	bx	lr

c0d02c0e <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02c0e:	b5d0      	push	{r4, r6, r7, lr}
c0d02c10:	af02      	add	r7, sp, #8
c0d02c12:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02c14:	20fc      	movs	r0, #252	; 0xfc
c0d02c16:	5c20      	ldrb	r0, [r4, r0]
c0d02c18:	2803      	cmp	r0, #3
c0d02c1a:	d10a      	bne.n	c0d02c32 <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02c1c:	2045      	movs	r0, #69	; 0x45
c0d02c1e:	0080      	lsls	r0, r0, #2
c0d02c20:	5820      	ldr	r0, [r4, r0]
c0d02c22:	69c0      	ldr	r0, [r0, #28]
c0d02c24:	2800      	cmp	r0, #0
c0d02c26:	d004      	beq.n	c0d02c32 <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02c28:	f7ff f9d0 	bl	c0d01fcc <pic>
c0d02c2c:	4601      	mov	r1, r0
c0d02c2e:	4620      	mov	r0, r4
c0d02c30:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d02c32:	2000      	movs	r0, #0
c0d02c34:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02c38 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02c38:	b5d0      	push	{r4, r6, r7, lr}
c0d02c3a:	af02      	add	r7, sp, #8
c0d02c3c:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02c3e:	7848      	ldrb	r0, [r1, #1]
c0d02c40:	2809      	cmp	r0, #9
c0d02c42:	d810      	bhi.n	c0d02c66 <USBD_StdDevReq+0x2e>
c0d02c44:	4478      	add	r0, pc
c0d02c46:	7900      	ldrb	r0, [r0, #4]
c0d02c48:	0040      	lsls	r0, r0, #1
c0d02c4a:	4487      	add	pc, r0
c0d02c4c:	150c0804 	.word	0x150c0804
c0d02c50:	0c25190c 	.word	0x0c25190c
c0d02c54:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02c56:	4620      	mov	r0, r4
c0d02c58:	f000 f938 	bl	c0d02ecc <USBD_GetStatus>
c0d02c5c:	e01f      	b.n	c0d02c9e <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02c5e:	4620      	mov	r0, r4
c0d02c60:	f000 f976 	bl	c0d02f50 <USBD_ClrFeature>
c0d02c64:	e01b      	b.n	c0d02c9e <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02c66:	2180      	movs	r1, #128	; 0x80
c0d02c68:	4620      	mov	r0, r4
c0d02c6a:	f7ff fdc5 	bl	c0d027f8 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02c6e:	2100      	movs	r1, #0
c0d02c70:	4620      	mov	r0, r4
c0d02c72:	f7ff fdc1 	bl	c0d027f8 <USBD_LL_StallEP>
c0d02c76:	e012      	b.n	c0d02c9e <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02c78:	4620      	mov	r0, r4
c0d02c7a:	f000 f950 	bl	c0d02f1e <USBD_SetFeature>
c0d02c7e:	e00e      	b.n	c0d02c9e <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02c80:	4620      	mov	r0, r4
c0d02c82:	f000 f897 	bl	c0d02db4 <USBD_SetAddress>
c0d02c86:	e00a      	b.n	c0d02c9e <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02c88:	4620      	mov	r0, r4
c0d02c8a:	f000 f8ff 	bl	c0d02e8c <USBD_GetConfig>
c0d02c8e:	e006      	b.n	c0d02c9e <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02c90:	4620      	mov	r0, r4
c0d02c92:	f000 f8bd 	bl	c0d02e10 <USBD_SetConfig>
c0d02c96:	e002      	b.n	c0d02c9e <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02c98:	4620      	mov	r0, r4
c0d02c9a:	f000 f803 	bl	c0d02ca4 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02c9e:	2000      	movs	r0, #0
c0d02ca0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02ca4 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02ca4:	b5b0      	push	{r4, r5, r7, lr}
c0d02ca6:	af02      	add	r7, sp, #8
c0d02ca8:	b082      	sub	sp, #8
c0d02caa:	460d      	mov	r5, r1
c0d02cac:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02cae:	8868      	ldrh	r0, [r5, #2]
c0d02cb0:	0a01      	lsrs	r1, r0, #8
c0d02cb2:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02cb4:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02cb6:	2a0e      	cmp	r2, #14
c0d02cb8:	d83e      	bhi.n	c0d02d38 <USBD_GetDescriptor+0x94>
c0d02cba:	46c0      	nop			; (mov r8, r8)
c0d02cbc:	447a      	add	r2, pc
c0d02cbe:	7912      	ldrb	r2, [r2, #4]
c0d02cc0:	0052      	lsls	r2, r2, #1
c0d02cc2:	4497      	add	pc, r2
c0d02cc4:	390c2607 	.word	0x390c2607
c0d02cc8:	39362e39 	.word	0x39362e39
c0d02ccc:	39393939 	.word	0x39393939
c0d02cd0:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02cd4:	2011      	movs	r0, #17
c0d02cd6:	0100      	lsls	r0, r0, #4
c0d02cd8:	5820      	ldr	r0, [r4, r0]
c0d02cda:	6800      	ldr	r0, [r0, #0]
c0d02cdc:	e012      	b.n	c0d02d04 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02cde:	b2c0      	uxtb	r0, r0
c0d02ce0:	2805      	cmp	r0, #5
c0d02ce2:	d829      	bhi.n	c0d02d38 <USBD_GetDescriptor+0x94>
c0d02ce4:	4478      	add	r0, pc
c0d02ce6:	7900      	ldrb	r0, [r0, #4]
c0d02ce8:	0040      	lsls	r0, r0, #1
c0d02cea:	4487      	add	pc, r0
c0d02cec:	544f4a02 	.word	0x544f4a02
c0d02cf0:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02cf2:	2011      	movs	r0, #17
c0d02cf4:	0100      	lsls	r0, r0, #4
c0d02cf6:	5820      	ldr	r0, [r4, r0]
c0d02cf8:	6840      	ldr	r0, [r0, #4]
c0d02cfa:	e003      	b.n	c0d02d04 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02cfc:	2011      	movs	r0, #17
c0d02cfe:	0100      	lsls	r0, r0, #4
c0d02d00:	5820      	ldr	r0, [r4, r0]
c0d02d02:	69c0      	ldr	r0, [r0, #28]
c0d02d04:	f7ff f962 	bl	c0d01fcc <pic>
c0d02d08:	4602      	mov	r2, r0
c0d02d0a:	7c20      	ldrb	r0, [r4, #16]
c0d02d0c:	a901      	add	r1, sp, #4
c0d02d0e:	4790      	blx	r2
c0d02d10:	e025      	b.n	c0d02d5e <USBD_GetDescriptor+0xba>
c0d02d12:	2045      	movs	r0, #69	; 0x45
c0d02d14:	0080      	lsls	r0, r0, #2
c0d02d16:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02d18:	7c21      	ldrb	r1, [r4, #16]
c0d02d1a:	2900      	cmp	r1, #0
c0d02d1c:	d014      	beq.n	c0d02d48 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02d1e:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02d20:	e018      	b.n	c0d02d54 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02d22:	7c20      	ldrb	r0, [r4, #16]
c0d02d24:	2800      	cmp	r0, #0
c0d02d26:	d107      	bne.n	c0d02d38 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02d28:	2045      	movs	r0, #69	; 0x45
c0d02d2a:	0080      	lsls	r0, r0, #2
c0d02d2c:	5820      	ldr	r0, [r4, r0]
c0d02d2e:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02d30:	e010      	b.n	c0d02d54 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02d32:	7c20      	ldrb	r0, [r4, #16]
c0d02d34:	2800      	cmp	r0, #0
c0d02d36:	d009      	beq.n	c0d02d4c <USBD_GetDescriptor+0xa8>
c0d02d38:	4620      	mov	r0, r4
c0d02d3a:	f7ff fd5d 	bl	c0d027f8 <USBD_LL_StallEP>
c0d02d3e:	2100      	movs	r1, #0
c0d02d40:	4620      	mov	r0, r4
c0d02d42:	f7ff fd59 	bl	c0d027f8 <USBD_LL_StallEP>
c0d02d46:	e01a      	b.n	c0d02d7e <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02d48:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02d4a:	e003      	b.n	c0d02d54 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02d4c:	2045      	movs	r0, #69	; 0x45
c0d02d4e:	0080      	lsls	r0, r0, #2
c0d02d50:	5820      	ldr	r0, [r4, r0]
c0d02d52:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02d54:	f7ff f93a 	bl	c0d01fcc <pic>
c0d02d58:	4601      	mov	r1, r0
c0d02d5a:	a801      	add	r0, sp, #4
c0d02d5c:	4788      	blx	r1
c0d02d5e:	4601      	mov	r1, r0
c0d02d60:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02d62:	8802      	ldrh	r2, [r0, #0]
c0d02d64:	2a00      	cmp	r2, #0
c0d02d66:	d00a      	beq.n	c0d02d7e <USBD_GetDescriptor+0xda>
c0d02d68:	88e8      	ldrh	r0, [r5, #6]
c0d02d6a:	2800      	cmp	r0, #0
c0d02d6c:	d007      	beq.n	c0d02d7e <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02d6e:	4282      	cmp	r2, r0
c0d02d70:	d300      	bcc.n	c0d02d74 <USBD_GetDescriptor+0xd0>
c0d02d72:	4602      	mov	r2, r0
c0d02d74:	a801      	add	r0, sp, #4
c0d02d76:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02d78:	4620      	mov	r0, r4
c0d02d7a:	f000 faf9 	bl	c0d03370 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02d7e:	b002      	add	sp, #8
c0d02d80:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02d82:	2011      	movs	r0, #17
c0d02d84:	0100      	lsls	r0, r0, #4
c0d02d86:	5820      	ldr	r0, [r4, r0]
c0d02d88:	6880      	ldr	r0, [r0, #8]
c0d02d8a:	e7bb      	b.n	c0d02d04 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02d8c:	2011      	movs	r0, #17
c0d02d8e:	0100      	lsls	r0, r0, #4
c0d02d90:	5820      	ldr	r0, [r4, r0]
c0d02d92:	68c0      	ldr	r0, [r0, #12]
c0d02d94:	e7b6      	b.n	c0d02d04 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02d96:	2011      	movs	r0, #17
c0d02d98:	0100      	lsls	r0, r0, #4
c0d02d9a:	5820      	ldr	r0, [r4, r0]
c0d02d9c:	6900      	ldr	r0, [r0, #16]
c0d02d9e:	e7b1      	b.n	c0d02d04 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02da0:	2011      	movs	r0, #17
c0d02da2:	0100      	lsls	r0, r0, #4
c0d02da4:	5820      	ldr	r0, [r4, r0]
c0d02da6:	6940      	ldr	r0, [r0, #20]
c0d02da8:	e7ac      	b.n	c0d02d04 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02daa:	2011      	movs	r0, #17
c0d02dac:	0100      	lsls	r0, r0, #4
c0d02dae:	5820      	ldr	r0, [r4, r0]
c0d02db0:	6980      	ldr	r0, [r0, #24]
c0d02db2:	e7a7      	b.n	c0d02d04 <USBD_GetDescriptor+0x60>

c0d02db4 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02db4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02db6:	af03      	add	r7, sp, #12
c0d02db8:	b081      	sub	sp, #4
c0d02dba:	460a      	mov	r2, r1
c0d02dbc:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02dbe:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02dc0:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02dc2:	2800      	cmp	r0, #0
c0d02dc4:	d10b      	bne.n	c0d02dde <USBD_SetAddress+0x2a>
c0d02dc6:	88d0      	ldrh	r0, [r2, #6]
c0d02dc8:	2800      	cmp	r0, #0
c0d02dca:	d108      	bne.n	c0d02dde <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02dcc:	8850      	ldrh	r0, [r2, #2]
c0d02dce:	267f      	movs	r6, #127	; 0x7f
c0d02dd0:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02dd2:	20fc      	movs	r0, #252	; 0xfc
c0d02dd4:	5c20      	ldrb	r0, [r4, r0]
c0d02dd6:	4625      	mov	r5, r4
c0d02dd8:	35fc      	adds	r5, #252	; 0xfc
c0d02dda:	2803      	cmp	r0, #3
c0d02ddc:	d108      	bne.n	c0d02df0 <USBD_SetAddress+0x3c>
c0d02dde:	4620      	mov	r0, r4
c0d02de0:	f7ff fd0a 	bl	c0d027f8 <USBD_LL_StallEP>
c0d02de4:	2100      	movs	r1, #0
c0d02de6:	4620      	mov	r0, r4
c0d02de8:	f7ff fd06 	bl	c0d027f8 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02dec:	b001      	add	sp, #4
c0d02dee:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02df0:	20fe      	movs	r0, #254	; 0xfe
c0d02df2:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02df4:	b2f1      	uxtb	r1, r6
c0d02df6:	4620      	mov	r0, r4
c0d02df8:	f7ff fd5c 	bl	c0d028b4 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02dfc:	4620      	mov	r0, r4
c0d02dfe:	f000 fae5 	bl	c0d033cc <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02e02:	2002      	movs	r0, #2
c0d02e04:	2101      	movs	r1, #1
c0d02e06:	2e00      	cmp	r6, #0
c0d02e08:	d100      	bne.n	c0d02e0c <USBD_SetAddress+0x58>
c0d02e0a:	4608      	mov	r0, r1
c0d02e0c:	7028      	strb	r0, [r5, #0]
c0d02e0e:	e7ed      	b.n	c0d02dec <USBD_SetAddress+0x38>

c0d02e10 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02e10:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02e12:	af03      	add	r7, sp, #12
c0d02e14:	b081      	sub	sp, #4
c0d02e16:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02e18:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e1a:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02e1c:	2e02      	cmp	r6, #2
c0d02e1e:	d21d      	bcs.n	c0d02e5c <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02e20:	20fc      	movs	r0, #252	; 0xfc
c0d02e22:	5c21      	ldrb	r1, [r4, r0]
c0d02e24:	4620      	mov	r0, r4
c0d02e26:	30fc      	adds	r0, #252	; 0xfc
c0d02e28:	2903      	cmp	r1, #3
c0d02e2a:	d007      	beq.n	c0d02e3c <USBD_SetConfig+0x2c>
c0d02e2c:	2902      	cmp	r1, #2
c0d02e2e:	d115      	bne.n	c0d02e5c <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02e30:	2e00      	cmp	r6, #0
c0d02e32:	d026      	beq.n	c0d02e82 <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02e34:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02e36:	2103      	movs	r1, #3
c0d02e38:	7001      	strb	r1, [r0, #0]
c0d02e3a:	e009      	b.n	c0d02e50 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02e3c:	2e00      	cmp	r6, #0
c0d02e3e:	d016      	beq.n	c0d02e6e <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02e40:	6860      	ldr	r0, [r4, #4]
c0d02e42:	4286      	cmp	r6, r0
c0d02e44:	d01d      	beq.n	c0d02e82 <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02e46:	b2c1      	uxtb	r1, r0
c0d02e48:	4620      	mov	r0, r4
c0d02e4a:	f7ff fdd3 	bl	c0d029f4 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02e4e:	6066      	str	r6, [r4, #4]
c0d02e50:	4620      	mov	r0, r4
c0d02e52:	4631      	mov	r1, r6
c0d02e54:	f7ff fdb6 	bl	c0d029c4 <USBD_SetClassConfig>
c0d02e58:	2802      	cmp	r0, #2
c0d02e5a:	d112      	bne.n	c0d02e82 <USBD_SetConfig+0x72>
c0d02e5c:	4620      	mov	r0, r4
c0d02e5e:	4629      	mov	r1, r5
c0d02e60:	f7ff fcca 	bl	c0d027f8 <USBD_LL_StallEP>
c0d02e64:	2100      	movs	r1, #0
c0d02e66:	4620      	mov	r0, r4
c0d02e68:	f7ff fcc6 	bl	c0d027f8 <USBD_LL_StallEP>
c0d02e6c:	e00c      	b.n	c0d02e88 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02e6e:	2102      	movs	r1, #2
c0d02e70:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02e72:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02e74:	4620      	mov	r0, r4
c0d02e76:	4631      	mov	r1, r6
c0d02e78:	f7ff fdbc 	bl	c0d029f4 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02e7c:	4620      	mov	r0, r4
c0d02e7e:	f000 faa5 	bl	c0d033cc <USBD_CtlSendStatus>
c0d02e82:	4620      	mov	r0, r4
c0d02e84:	f000 faa2 	bl	c0d033cc <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02e88:	b001      	add	sp, #4
c0d02e8a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02e8c <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02e8c:	b5d0      	push	{r4, r6, r7, lr}
c0d02e8e:	af02      	add	r7, sp, #8
c0d02e90:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02e92:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e94:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02e96:	2801      	cmp	r0, #1
c0d02e98:	d10a      	bne.n	c0d02eb0 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02e9a:	20fc      	movs	r0, #252	; 0xfc
c0d02e9c:	5c20      	ldrb	r0, [r4, r0]
c0d02e9e:	2803      	cmp	r0, #3
c0d02ea0:	d00e      	beq.n	c0d02ec0 <USBD_GetConfig+0x34>
c0d02ea2:	2802      	cmp	r0, #2
c0d02ea4:	d104      	bne.n	c0d02eb0 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02ea6:	2000      	movs	r0, #0
c0d02ea8:	60a0      	str	r0, [r4, #8]
c0d02eaa:	4621      	mov	r1, r4
c0d02eac:	3108      	adds	r1, #8
c0d02eae:	e008      	b.n	c0d02ec2 <USBD_GetConfig+0x36>
c0d02eb0:	4620      	mov	r0, r4
c0d02eb2:	f7ff fca1 	bl	c0d027f8 <USBD_LL_StallEP>
c0d02eb6:	2100      	movs	r1, #0
c0d02eb8:	4620      	mov	r0, r4
c0d02eba:	f7ff fc9d 	bl	c0d027f8 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02ebe:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02ec0:	1d21      	adds	r1, r4, #4
c0d02ec2:	2201      	movs	r2, #1
c0d02ec4:	4620      	mov	r0, r4
c0d02ec6:	f000 fa53 	bl	c0d03370 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02eca:	bdd0      	pop	{r4, r6, r7, pc}

c0d02ecc <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02ecc:	b5b0      	push	{r4, r5, r7, lr}
c0d02ece:	af02      	add	r7, sp, #8
c0d02ed0:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02ed2:	20fc      	movs	r0, #252	; 0xfc
c0d02ed4:	5c20      	ldrb	r0, [r4, r0]
c0d02ed6:	21fe      	movs	r1, #254	; 0xfe
c0d02ed8:	4001      	ands	r1, r0
c0d02eda:	2902      	cmp	r1, #2
c0d02edc:	d116      	bne.n	c0d02f0c <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02ede:	2001      	movs	r0, #1
c0d02ee0:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02ee2:	2041      	movs	r0, #65	; 0x41
c0d02ee4:	0080      	lsls	r0, r0, #2
c0d02ee6:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02ee8:	4625      	mov	r5, r4
c0d02eea:	350c      	adds	r5, #12
c0d02eec:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02eee:	2900      	cmp	r1, #0
c0d02ef0:	d005      	beq.n	c0d02efe <USBD_GetStatus+0x32>
c0d02ef2:	4620      	mov	r0, r4
c0d02ef4:	f000 fa77 	bl	c0d033e6 <USBD_CtlReceiveStatus>
c0d02ef8:	68e1      	ldr	r1, [r4, #12]
c0d02efa:	2002      	movs	r0, #2
c0d02efc:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02efe:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02f00:	2202      	movs	r2, #2
c0d02f02:	4620      	mov	r0, r4
c0d02f04:	4629      	mov	r1, r5
c0d02f06:	f000 fa33 	bl	c0d03370 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02f0a:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f0c:	2180      	movs	r1, #128	; 0x80
c0d02f0e:	4620      	mov	r0, r4
c0d02f10:	f7ff fc72 	bl	c0d027f8 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02f14:	2100      	movs	r1, #0
c0d02f16:	4620      	mov	r0, r4
c0d02f18:	f7ff fc6e 	bl	c0d027f8 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02f1c:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f1e <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02f1e:	b5b0      	push	{r4, r5, r7, lr}
c0d02f20:	af02      	add	r7, sp, #8
c0d02f22:	460d      	mov	r5, r1
c0d02f24:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02f26:	8868      	ldrh	r0, [r5, #2]
c0d02f28:	2801      	cmp	r0, #1
c0d02f2a:	d110      	bne.n	c0d02f4e <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02f2c:	2041      	movs	r0, #65	; 0x41
c0d02f2e:	0080      	lsls	r0, r0, #2
c0d02f30:	2101      	movs	r1, #1
c0d02f32:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02f34:	2045      	movs	r0, #69	; 0x45
c0d02f36:	0080      	lsls	r0, r0, #2
c0d02f38:	5820      	ldr	r0, [r4, r0]
c0d02f3a:	6880      	ldr	r0, [r0, #8]
c0d02f3c:	f7ff f846 	bl	c0d01fcc <pic>
c0d02f40:	4602      	mov	r2, r0
c0d02f42:	4620      	mov	r0, r4
c0d02f44:	4629      	mov	r1, r5
c0d02f46:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02f48:	4620      	mov	r0, r4
c0d02f4a:	f000 fa3f 	bl	c0d033cc <USBD_CtlSendStatus>
  }

}
c0d02f4e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f50 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02f50:	b5b0      	push	{r4, r5, r7, lr}
c0d02f52:	af02      	add	r7, sp, #8
c0d02f54:	460d      	mov	r5, r1
c0d02f56:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02f58:	20fc      	movs	r0, #252	; 0xfc
c0d02f5a:	5c20      	ldrb	r0, [r4, r0]
c0d02f5c:	21fe      	movs	r1, #254	; 0xfe
c0d02f5e:	4001      	ands	r1, r0
c0d02f60:	2902      	cmp	r1, #2
c0d02f62:	d114      	bne.n	c0d02f8e <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02f64:	8868      	ldrh	r0, [r5, #2]
c0d02f66:	2801      	cmp	r0, #1
c0d02f68:	d119      	bne.n	c0d02f9e <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02f6a:	2041      	movs	r0, #65	; 0x41
c0d02f6c:	0080      	lsls	r0, r0, #2
c0d02f6e:	2100      	movs	r1, #0
c0d02f70:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02f72:	2045      	movs	r0, #69	; 0x45
c0d02f74:	0080      	lsls	r0, r0, #2
c0d02f76:	5820      	ldr	r0, [r4, r0]
c0d02f78:	6880      	ldr	r0, [r0, #8]
c0d02f7a:	f7ff f827 	bl	c0d01fcc <pic>
c0d02f7e:	4602      	mov	r2, r0
c0d02f80:	4620      	mov	r0, r4
c0d02f82:	4629      	mov	r1, r5
c0d02f84:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d02f86:	4620      	mov	r0, r4
c0d02f88:	f000 fa20 	bl	c0d033cc <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02f8c:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f8e:	2180      	movs	r1, #128	; 0x80
c0d02f90:	4620      	mov	r0, r4
c0d02f92:	f7ff fc31 	bl	c0d027f8 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02f96:	2100      	movs	r1, #0
c0d02f98:	4620      	mov	r0, r4
c0d02f9a:	f7ff fc2d 	bl	c0d027f8 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02f9e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02fa0 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02fa0:	b5d0      	push	{r4, r6, r7, lr}
c0d02fa2:	af02      	add	r7, sp, #8
c0d02fa4:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02fa6:	2180      	movs	r1, #128	; 0x80
c0d02fa8:	f7ff fc26 	bl	c0d027f8 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02fac:	2100      	movs	r1, #0
c0d02fae:	4620      	mov	r0, r4
c0d02fb0:	f7ff fc22 	bl	c0d027f8 <USBD_LL_StallEP>
}
c0d02fb4:	bdd0      	pop	{r4, r6, r7, pc}

c0d02fb6 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02fb6:	b5b0      	push	{r4, r5, r7, lr}
c0d02fb8:	af02      	add	r7, sp, #8
c0d02fba:	460d      	mov	r5, r1
c0d02fbc:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02fbe:	20fc      	movs	r0, #252	; 0xfc
c0d02fc0:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02fc2:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02fc4:	2803      	cmp	r0, #3
c0d02fc6:	d115      	bne.n	c0d02ff4 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02fc8:	88a8      	ldrh	r0, [r5, #4]
c0d02fca:	22fe      	movs	r2, #254	; 0xfe
c0d02fcc:	4002      	ands	r2, r0
c0d02fce:	2a01      	cmp	r2, #1
c0d02fd0:	d810      	bhi.n	c0d02ff4 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d02fd2:	2045      	movs	r0, #69	; 0x45
c0d02fd4:	0080      	lsls	r0, r0, #2
c0d02fd6:	5820      	ldr	r0, [r4, r0]
c0d02fd8:	6880      	ldr	r0, [r0, #8]
c0d02fda:	f7fe fff7 	bl	c0d01fcc <pic>
c0d02fde:	4602      	mov	r2, r0
c0d02fe0:	4620      	mov	r0, r4
c0d02fe2:	4629      	mov	r1, r5
c0d02fe4:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02fe6:	88e8      	ldrh	r0, [r5, #6]
c0d02fe8:	2800      	cmp	r0, #0
c0d02fea:	d10a      	bne.n	c0d03002 <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02fec:	4620      	mov	r0, r4
c0d02fee:	f000 f9ed 	bl	c0d033cc <USBD_CtlSendStatus>
c0d02ff2:	e006      	b.n	c0d03002 <USBD_StdItfReq+0x4c>
c0d02ff4:	4620      	mov	r0, r4
c0d02ff6:	f7ff fbff 	bl	c0d027f8 <USBD_LL_StallEP>
c0d02ffa:	2100      	movs	r1, #0
c0d02ffc:	4620      	mov	r0, r4
c0d02ffe:	f7ff fbfb 	bl	c0d027f8 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d03002:	2000      	movs	r0, #0
c0d03004:	bdb0      	pop	{r4, r5, r7, pc}

c0d03006 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d03006:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03008:	af03      	add	r7, sp, #12
c0d0300a:	b081      	sub	sp, #4
c0d0300c:	460e      	mov	r6, r1
c0d0300e:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d03010:	7830      	ldrb	r0, [r6, #0]
c0d03012:	2160      	movs	r1, #96	; 0x60
c0d03014:	4001      	ands	r1, r0
c0d03016:	2920      	cmp	r1, #32
c0d03018:	d10a      	bne.n	c0d03030 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d0301a:	2045      	movs	r0, #69	; 0x45
c0d0301c:	0080      	lsls	r0, r0, #2
c0d0301e:	5820      	ldr	r0, [r4, r0]
c0d03020:	6880      	ldr	r0, [r0, #8]
c0d03022:	f7fe ffd3 	bl	c0d01fcc <pic>
c0d03026:	4602      	mov	r2, r0
c0d03028:	4620      	mov	r0, r4
c0d0302a:	4631      	mov	r1, r6
c0d0302c:	4790      	blx	r2
c0d0302e:	e063      	b.n	c0d030f8 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d03030:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d03032:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d03034:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d03036:	2800      	cmp	r0, #0
c0d03038:	d012      	beq.n	c0d03060 <USBD_StdEPReq+0x5a>
c0d0303a:	2801      	cmp	r0, #1
c0d0303c:	d019      	beq.n	c0d03072 <USBD_StdEPReq+0x6c>
c0d0303e:	2803      	cmp	r0, #3
c0d03040:	d15a      	bne.n	c0d030f8 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d03042:	20fc      	movs	r0, #252	; 0xfc
c0d03044:	5c20      	ldrb	r0, [r4, r0]
c0d03046:	2803      	cmp	r0, #3
c0d03048:	d117      	bne.n	c0d0307a <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d0304a:	8870      	ldrh	r0, [r6, #2]
c0d0304c:	2800      	cmp	r0, #0
c0d0304e:	d12d      	bne.n	c0d030ac <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d03050:	4329      	orrs	r1, r5
c0d03052:	2980      	cmp	r1, #128	; 0x80
c0d03054:	d02a      	beq.n	c0d030ac <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d03056:	4620      	mov	r0, r4
c0d03058:	4629      	mov	r1, r5
c0d0305a:	f7ff fbcd 	bl	c0d027f8 <USBD_LL_StallEP>
c0d0305e:	e025      	b.n	c0d030ac <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d03060:	20fc      	movs	r0, #252	; 0xfc
c0d03062:	5c20      	ldrb	r0, [r4, r0]
c0d03064:	2803      	cmp	r0, #3
c0d03066:	d02f      	beq.n	c0d030c8 <USBD_StdEPReq+0xc2>
c0d03068:	2802      	cmp	r0, #2
c0d0306a:	d10e      	bne.n	c0d0308a <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d0306c:	0668      	lsls	r0, r5, #25
c0d0306e:	d109      	bne.n	c0d03084 <USBD_StdEPReq+0x7e>
c0d03070:	e042      	b.n	c0d030f8 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d03072:	20fc      	movs	r0, #252	; 0xfc
c0d03074:	5c20      	ldrb	r0, [r4, r0]
c0d03076:	2803      	cmp	r0, #3
c0d03078:	d00f      	beq.n	c0d0309a <USBD_StdEPReq+0x94>
c0d0307a:	2802      	cmp	r0, #2
c0d0307c:	d105      	bne.n	c0d0308a <USBD_StdEPReq+0x84>
c0d0307e:	4329      	orrs	r1, r5
c0d03080:	2980      	cmp	r1, #128	; 0x80
c0d03082:	d039      	beq.n	c0d030f8 <USBD_StdEPReq+0xf2>
c0d03084:	4620      	mov	r0, r4
c0d03086:	4629      	mov	r1, r5
c0d03088:	e004      	b.n	c0d03094 <USBD_StdEPReq+0x8e>
c0d0308a:	4620      	mov	r0, r4
c0d0308c:	f7ff fbb4 	bl	c0d027f8 <USBD_LL_StallEP>
c0d03090:	2100      	movs	r1, #0
c0d03092:	4620      	mov	r0, r4
c0d03094:	f7ff fbb0 	bl	c0d027f8 <USBD_LL_StallEP>
c0d03098:	e02e      	b.n	c0d030f8 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d0309a:	8870      	ldrh	r0, [r6, #2]
c0d0309c:	2800      	cmp	r0, #0
c0d0309e:	d12b      	bne.n	c0d030f8 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d030a0:	0668      	lsls	r0, r5, #25
c0d030a2:	d00d      	beq.n	c0d030c0 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d030a4:	4620      	mov	r0, r4
c0d030a6:	4629      	mov	r1, r5
c0d030a8:	f7ff fbcc 	bl	c0d02844 <USBD_LL_ClearStallEP>
c0d030ac:	2045      	movs	r0, #69	; 0x45
c0d030ae:	0080      	lsls	r0, r0, #2
c0d030b0:	5820      	ldr	r0, [r4, r0]
c0d030b2:	6880      	ldr	r0, [r0, #8]
c0d030b4:	f7fe ff8a 	bl	c0d01fcc <pic>
c0d030b8:	4602      	mov	r2, r0
c0d030ba:	4620      	mov	r0, r4
c0d030bc:	4631      	mov	r1, r6
c0d030be:	4790      	blx	r2
c0d030c0:	4620      	mov	r0, r4
c0d030c2:	f000 f983 	bl	c0d033cc <USBD_CtlSendStatus>
c0d030c6:	e017      	b.n	c0d030f8 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d030c8:	4626      	mov	r6, r4
c0d030ca:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d030cc:	4620      	mov	r0, r4
c0d030ce:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d030d0:	420d      	tst	r5, r1
c0d030d2:	d100      	bne.n	c0d030d6 <USBD_StdEPReq+0xd0>
c0d030d4:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d030d6:	4620      	mov	r0, r4
c0d030d8:	4629      	mov	r1, r5
c0d030da:	f7ff fbd9 	bl	c0d02890 <USBD_LL_IsStallEP>
c0d030de:	2101      	movs	r1, #1
c0d030e0:	2800      	cmp	r0, #0
c0d030e2:	d100      	bne.n	c0d030e6 <USBD_StdEPReq+0xe0>
c0d030e4:	4601      	mov	r1, r0
c0d030e6:	207f      	movs	r0, #127	; 0x7f
c0d030e8:	4005      	ands	r5, r0
c0d030ea:	0128      	lsls	r0, r5, #4
c0d030ec:	5031      	str	r1, [r6, r0]
c0d030ee:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d030f0:	2202      	movs	r2, #2
c0d030f2:	4620      	mov	r0, r4
c0d030f4:	f000 f93c 	bl	c0d03370 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d030f8:	2000      	movs	r0, #0
c0d030fa:	b001      	add	sp, #4
c0d030fc:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d030fe <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d030fe:	780a      	ldrb	r2, [r1, #0]
c0d03100:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d03102:	784a      	ldrb	r2, [r1, #1]
c0d03104:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d03106:	788a      	ldrb	r2, [r1, #2]
c0d03108:	78cb      	ldrb	r3, [r1, #3]
c0d0310a:	021b      	lsls	r3, r3, #8
c0d0310c:	4313      	orrs	r3, r2
c0d0310e:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d03110:	790a      	ldrb	r2, [r1, #4]
c0d03112:	794b      	ldrb	r3, [r1, #5]
c0d03114:	021b      	lsls	r3, r3, #8
c0d03116:	4313      	orrs	r3, r2
c0d03118:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d0311a:	798a      	ldrb	r2, [r1, #6]
c0d0311c:	79c9      	ldrb	r1, [r1, #7]
c0d0311e:	0209      	lsls	r1, r1, #8
c0d03120:	4311      	orrs	r1, r2
c0d03122:	80c1      	strh	r1, [r0, #6]

}
c0d03124:	4770      	bx	lr

c0d03126 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d03126:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03128:	af03      	add	r7, sp, #12
c0d0312a:	b083      	sub	sp, #12
c0d0312c:	460d      	mov	r5, r1
c0d0312e:	4604      	mov	r4, r0
c0d03130:	a802      	add	r0, sp, #8
c0d03132:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d03134:	8006      	strh	r6, [r0, #0]
c0d03136:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d03138:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d0313a:	7829      	ldrb	r1, [r5, #0]
c0d0313c:	2060      	movs	r0, #96	; 0x60
c0d0313e:	4008      	ands	r0, r1
c0d03140:	2800      	cmp	r0, #0
c0d03142:	d010      	beq.n	c0d03166 <USBD_HID_Setup+0x40>
c0d03144:	2820      	cmp	r0, #32
c0d03146:	d139      	bne.n	c0d031bc <USBD_HID_Setup+0x96>
c0d03148:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d0314a:	4601      	mov	r1, r0
c0d0314c:	390a      	subs	r1, #10
c0d0314e:	2902      	cmp	r1, #2
c0d03150:	d334      	bcc.n	c0d031bc <USBD_HID_Setup+0x96>
c0d03152:	2802      	cmp	r0, #2
c0d03154:	d01c      	beq.n	c0d03190 <USBD_HID_Setup+0x6a>
c0d03156:	2803      	cmp	r0, #3
c0d03158:	d01a      	beq.n	c0d03190 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d0315a:	4620      	mov	r0, r4
c0d0315c:	4629      	mov	r1, r5
c0d0315e:	f7ff ff1f 	bl	c0d02fa0 <USBD_CtlError>
c0d03162:	2602      	movs	r6, #2
c0d03164:	e02a      	b.n	c0d031bc <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d03166:	7868      	ldrb	r0, [r5, #1]
c0d03168:	280b      	cmp	r0, #11
c0d0316a:	d014      	beq.n	c0d03196 <USBD_HID_Setup+0x70>
c0d0316c:	280a      	cmp	r0, #10
c0d0316e:	d00f      	beq.n	c0d03190 <USBD_HID_Setup+0x6a>
c0d03170:	2806      	cmp	r0, #6
c0d03172:	d123      	bne.n	c0d031bc <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d03174:	8868      	ldrh	r0, [r5, #2]
c0d03176:	0a00      	lsrs	r0, r0, #8
c0d03178:	2600      	movs	r6, #0
c0d0317a:	2821      	cmp	r0, #33	; 0x21
c0d0317c:	d00f      	beq.n	c0d0319e <USBD_HID_Setup+0x78>
c0d0317e:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d03180:	4632      	mov	r2, r6
c0d03182:	4631      	mov	r1, r6
c0d03184:	d117      	bne.n	c0d031b6 <USBD_HID_Setup+0x90>
c0d03186:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d03188:	9000      	str	r0, [sp, #0]
c0d0318a:	f000 f847 	bl	c0d0321c <USBD_HID_GetReportDescriptor_impl>
c0d0318e:	e00a      	b.n	c0d031a6 <USBD_HID_Setup+0x80>
c0d03190:	a901      	add	r1, sp, #4
c0d03192:	2201      	movs	r2, #1
c0d03194:	e00f      	b.n	c0d031b6 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d03196:	4620      	mov	r0, r4
c0d03198:	f000 f918 	bl	c0d033cc <USBD_CtlSendStatus>
c0d0319c:	e00e      	b.n	c0d031bc <USBD_HID_Setup+0x96>
c0d0319e:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d031a0:	9000      	str	r0, [sp, #0]
c0d031a2:	f000 f833 	bl	c0d0320c <USBD_HID_GetHidDescriptor_impl>
c0d031a6:	9b00      	ldr	r3, [sp, #0]
c0d031a8:	4601      	mov	r1, r0
c0d031aa:	881a      	ldrh	r2, [r3, #0]
c0d031ac:	88e8      	ldrh	r0, [r5, #6]
c0d031ae:	4282      	cmp	r2, r0
c0d031b0:	d300      	bcc.n	c0d031b4 <USBD_HID_Setup+0x8e>
c0d031b2:	4602      	mov	r2, r0
c0d031b4:	801a      	strh	r2, [r3, #0]
c0d031b6:	4620      	mov	r0, r4
c0d031b8:	f000 f8da 	bl	c0d03370 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d031bc:	b2f0      	uxtb	r0, r6
c0d031be:	b003      	add	sp, #12
c0d031c0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d031c2 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d031c2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d031c4:	af03      	add	r7, sp, #12
c0d031c6:	b081      	sub	sp, #4
c0d031c8:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d031ca:	2182      	movs	r1, #130	; 0x82
c0d031cc:	2502      	movs	r5, #2
c0d031ce:	2640      	movs	r6, #64	; 0x40
c0d031d0:	462a      	mov	r2, r5
c0d031d2:	4633      	mov	r3, r6
c0d031d4:	f7ff fad0 	bl	c0d02778 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d031d8:	4620      	mov	r0, r4
c0d031da:	4629      	mov	r1, r5
c0d031dc:	462a      	mov	r2, r5
c0d031de:	4633      	mov	r3, r6
c0d031e0:	f7ff faca 	bl	c0d02778 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d031e4:	4620      	mov	r0, r4
c0d031e6:	4629      	mov	r1, r5
c0d031e8:	4632      	mov	r2, r6
c0d031ea:	f7ff fb90 	bl	c0d0290e <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d031ee:	2000      	movs	r0, #0
c0d031f0:	b001      	add	sp, #4
c0d031f2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d031f4 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d031f4:	b5d0      	push	{r4, r6, r7, lr}
c0d031f6:	af02      	add	r7, sp, #8
c0d031f8:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d031fa:	2182      	movs	r1, #130	; 0x82
c0d031fc:	f7ff fae4 	bl	c0d027c8 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d03200:	2102      	movs	r1, #2
c0d03202:	4620      	mov	r0, r4
c0d03204:	f7ff fae0 	bl	c0d027c8 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d03208:	2000      	movs	r0, #0
c0d0320a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0320c <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d0320c:	2109      	movs	r1, #9
c0d0320e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d03210:	4801      	ldr	r0, [pc, #4]	; (c0d03218 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d03212:	4478      	add	r0, pc
c0d03214:	4770      	bx	lr
c0d03216:	46c0      	nop			; (mov r8, r8)
c0d03218:	00000bca 	.word	0x00000bca

c0d0321c <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d0321c:	2122      	movs	r1, #34	; 0x22
c0d0321e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d03220:	4801      	ldr	r0, [pc, #4]	; (c0d03228 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d03222:	4478      	add	r0, pc
c0d03224:	4770      	bx	lr
c0d03226:	46c0      	nop			; (mov r8, r8)
c0d03228:	00000b95 	.word	0x00000b95

c0d0322c <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d0322c:	b5b0      	push	{r4, r5, r7, lr}
c0d0322e:	af02      	add	r7, sp, #8
c0d03230:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d03232:	2102      	movs	r1, #2
c0d03234:	2240      	movs	r2, #64	; 0x40
c0d03236:	f7ff fb6a 	bl	c0d0290e <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d0323a:	4d0d      	ldr	r5, [pc, #52]	; (c0d03270 <USBD_HID_DataOut_impl+0x44>)
c0d0323c:	7828      	ldrb	r0, [r5, #0]
c0d0323e:	2800      	cmp	r0, #0
c0d03240:	d113      	bne.n	c0d0326a <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d03242:	2002      	movs	r0, #2
c0d03244:	f7fe f928 	bl	c0d01498 <io_seproxyhal_get_ep_rx_size>
c0d03248:	4602      	mov	r2, r0
c0d0324a:	480d      	ldr	r0, [pc, #52]	; (c0d03280 <USBD_HID_DataOut_impl+0x54>)
c0d0324c:	4478      	add	r0, pc
c0d0324e:	4621      	mov	r1, r4
c0d03250:	f7fd ff86 	bl	c0d01160 <io_usb_hid_receive>
c0d03254:	2802      	cmp	r0, #2
c0d03256:	d108      	bne.n	c0d0326a <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d03258:	2001      	movs	r0, #1
c0d0325a:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d0325c:	4805      	ldr	r0, [pc, #20]	; (c0d03274 <USBD_HID_DataOut_impl+0x48>)
c0d0325e:	2107      	movs	r1, #7
c0d03260:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d03262:	4805      	ldr	r0, [pc, #20]	; (c0d03278 <USBD_HID_DataOut_impl+0x4c>)
c0d03264:	6800      	ldr	r0, [r0, #0]
c0d03266:	4905      	ldr	r1, [pc, #20]	; (c0d0327c <USBD_HID_DataOut_impl+0x50>)
c0d03268:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d0326a:	2000      	movs	r0, #0
c0d0326c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0326e:	46c0      	nop			; (mov r8, r8)
c0d03270:	20001d10 	.word	0x20001d10
c0d03274:	20001d18 	.word	0x20001d18
c0d03278:	20001c00 	.word	0x20001c00
c0d0327c:	20001d1c 	.word	0x20001d1c
c0d03280:	ffffe3a1 	.word	0xffffe3a1

c0d03284 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d03284:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03286:	af03      	add	r7, sp, #12
c0d03288:	b081      	sub	sp, #4
c0d0328a:	4604      	mov	r4, r0
c0d0328c:	2049      	movs	r0, #73	; 0x49
c0d0328e:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d03290:	4810      	ldr	r0, [pc, #64]	; (c0d032d4 <USB_power+0x50>)
c0d03292:	2100      	movs	r1, #0
c0d03294:	462a      	mov	r2, r5
c0d03296:	f7fe f80f 	bl	c0d012b8 <os_memset>

  if (enabled) {
c0d0329a:	2c00      	cmp	r4, #0
c0d0329c:	d015      	beq.n	c0d032ca <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d0329e:	4c0d      	ldr	r4, [pc, #52]	; (c0d032d4 <USB_power+0x50>)
c0d032a0:	2600      	movs	r6, #0
c0d032a2:	4620      	mov	r0, r4
c0d032a4:	4631      	mov	r1, r6
c0d032a6:	462a      	mov	r2, r5
c0d032a8:	f7fe f806 	bl	c0d012b8 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d032ac:	490a      	ldr	r1, [pc, #40]	; (c0d032d8 <USB_power+0x54>)
c0d032ae:	4479      	add	r1, pc
c0d032b0:	4620      	mov	r0, r4
c0d032b2:	4632      	mov	r2, r6
c0d032b4:	f7ff fb3f 	bl	c0d02936 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d032b8:	4908      	ldr	r1, [pc, #32]	; (c0d032dc <USB_power+0x58>)
c0d032ba:	4479      	add	r1, pc
c0d032bc:	4620      	mov	r0, r4
c0d032be:	f7ff fb72 	bl	c0d029a6 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d032c2:	4620      	mov	r0, r4
c0d032c4:	f7ff fb78 	bl	c0d029b8 <USBD_Start>
c0d032c8:	e002      	b.n	c0d032d0 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d032ca:	4802      	ldr	r0, [pc, #8]	; (c0d032d4 <USB_power+0x50>)
c0d032cc:	f7ff fb51 	bl	c0d02972 <USBD_DeInit>
  }
}
c0d032d0:	b001      	add	sp, #4
c0d032d2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d032d4:	20001d34 	.word	0x20001d34
c0d032d8:	00000b4a 	.word	0x00000b4a
c0d032dc:	00000b7a 	.word	0x00000b7a

c0d032e0 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d032e0:	2012      	movs	r0, #18
c0d032e2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d032e4:	4801      	ldr	r0, [pc, #4]	; (c0d032ec <USBD_DeviceDescriptor+0xc>)
c0d032e6:	4478      	add	r0, pc
c0d032e8:	4770      	bx	lr
c0d032ea:	46c0      	nop			; (mov r8, r8)
c0d032ec:	00000aff 	.word	0x00000aff

c0d032f0 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d032f0:	2004      	movs	r0, #4
c0d032f2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d032f4:	4801      	ldr	r0, [pc, #4]	; (c0d032fc <USBD_LangIDStrDescriptor+0xc>)
c0d032f6:	4478      	add	r0, pc
c0d032f8:	4770      	bx	lr
c0d032fa:	46c0      	nop			; (mov r8, r8)
c0d032fc:	00000b22 	.word	0x00000b22

c0d03300 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d03300:	200e      	movs	r0, #14
c0d03302:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d03304:	4801      	ldr	r0, [pc, #4]	; (c0d0330c <USBD_ManufacturerStrDescriptor+0xc>)
c0d03306:	4478      	add	r0, pc
c0d03308:	4770      	bx	lr
c0d0330a:	46c0      	nop			; (mov r8, r8)
c0d0330c:	00000b16 	.word	0x00000b16

c0d03310 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d03310:	200e      	movs	r0, #14
c0d03312:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d03314:	4801      	ldr	r0, [pc, #4]	; (c0d0331c <USBD_ProductStrDescriptor+0xc>)
c0d03316:	4478      	add	r0, pc
c0d03318:	4770      	bx	lr
c0d0331a:	46c0      	nop			; (mov r8, r8)
c0d0331c:	00000a93 	.word	0x00000a93

c0d03320 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d03320:	200a      	movs	r0, #10
c0d03322:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d03324:	4801      	ldr	r0, [pc, #4]	; (c0d0332c <USBD_SerialStrDescriptor+0xc>)
c0d03326:	4478      	add	r0, pc
c0d03328:	4770      	bx	lr
c0d0332a:	46c0      	nop			; (mov r8, r8)
c0d0332c:	00000b04 	.word	0x00000b04

c0d03330 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d03330:	200e      	movs	r0, #14
c0d03332:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d03334:	4801      	ldr	r0, [pc, #4]	; (c0d0333c <USBD_ConfigStrDescriptor+0xc>)
c0d03336:	4478      	add	r0, pc
c0d03338:	4770      	bx	lr
c0d0333a:	46c0      	nop			; (mov r8, r8)
c0d0333c:	00000a73 	.word	0x00000a73

c0d03340 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d03340:	200e      	movs	r0, #14
c0d03342:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d03344:	4801      	ldr	r0, [pc, #4]	; (c0d0334c <USBD_InterfaceStrDescriptor+0xc>)
c0d03346:	4478      	add	r0, pc
c0d03348:	4770      	bx	lr
c0d0334a:	46c0      	nop			; (mov r8, r8)
c0d0334c:	00000a63 	.word	0x00000a63

c0d03350 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d03350:	2129      	movs	r1, #41	; 0x29
c0d03352:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d03354:	4801      	ldr	r0, [pc, #4]	; (c0d0335c <USBD_GetCfgDesc_impl+0xc>)
c0d03356:	4478      	add	r0, pc
c0d03358:	4770      	bx	lr
c0d0335a:	46c0      	nop			; (mov r8, r8)
c0d0335c:	00000b16 	.word	0x00000b16

c0d03360 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d03360:	210a      	movs	r1, #10
c0d03362:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d03364:	4801      	ldr	r0, [pc, #4]	; (c0d0336c <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d03366:	4478      	add	r0, pc
c0d03368:	4770      	bx	lr
c0d0336a:	46c0      	nop			; (mov r8, r8)
c0d0336c:	00000b32 	.word	0x00000b32

c0d03370 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d03370:	b5b0      	push	{r4, r5, r7, lr}
c0d03372:	af02      	add	r7, sp, #8
c0d03374:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d03376:	21f4      	movs	r1, #244	; 0xf4
c0d03378:	2302      	movs	r3, #2
c0d0337a:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d0337c:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d0337e:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d03380:	2109      	movs	r1, #9
c0d03382:	0149      	lsls	r1, r1, #5
c0d03384:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d03386:	6a01      	ldr	r1, [r0, #32]
c0d03388:	428a      	cmp	r2, r1
c0d0338a:	d300      	bcc.n	c0d0338e <USBD_CtlSendData+0x1e>
c0d0338c:	460a      	mov	r2, r1
c0d0338e:	b293      	uxth	r3, r2
c0d03390:	2500      	movs	r5, #0
c0d03392:	4629      	mov	r1, r5
c0d03394:	4622      	mov	r2, r4
c0d03396:	f7ff faa0 	bl	c0d028da <USBD_LL_Transmit>
  
  return USBD_OK;
c0d0339a:	4628      	mov	r0, r5
c0d0339c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0339e <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d0339e:	b5b0      	push	{r4, r5, r7, lr}
c0d033a0:	af02      	add	r7, sp, #8
c0d033a2:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d033a4:	6a01      	ldr	r1, [r0, #32]
c0d033a6:	428a      	cmp	r2, r1
c0d033a8:	d300      	bcc.n	c0d033ac <USBD_CtlContinueSendData+0xe>
c0d033aa:	460a      	mov	r2, r1
c0d033ac:	b293      	uxth	r3, r2
c0d033ae:	2500      	movs	r5, #0
c0d033b0:	4629      	mov	r1, r5
c0d033b2:	4622      	mov	r2, r4
c0d033b4:	f7ff fa91 	bl	c0d028da <USBD_LL_Transmit>
  return USBD_OK;
c0d033b8:	4628      	mov	r0, r5
c0d033ba:	bdb0      	pop	{r4, r5, r7, pc}

c0d033bc <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d033bc:	b5d0      	push	{r4, r6, r7, lr}
c0d033be:	af02      	add	r7, sp, #8
c0d033c0:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d033c2:	4621      	mov	r1, r4
c0d033c4:	f7ff faa3 	bl	c0d0290e <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d033c8:	4620      	mov	r0, r4
c0d033ca:	bdd0      	pop	{r4, r6, r7, pc}

c0d033cc <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d033cc:	b5d0      	push	{r4, r6, r7, lr}
c0d033ce:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d033d0:	21f4      	movs	r1, #244	; 0xf4
c0d033d2:	2204      	movs	r2, #4
c0d033d4:	5042      	str	r2, [r0, r1]
c0d033d6:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d033d8:	4621      	mov	r1, r4
c0d033da:	4622      	mov	r2, r4
c0d033dc:	4623      	mov	r3, r4
c0d033de:	f7ff fa7c 	bl	c0d028da <USBD_LL_Transmit>
  
  return USBD_OK;
c0d033e2:	4620      	mov	r0, r4
c0d033e4:	bdd0      	pop	{r4, r6, r7, pc}

c0d033e6 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d033e6:	b5d0      	push	{r4, r6, r7, lr}
c0d033e8:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d033ea:	21f4      	movs	r1, #244	; 0xf4
c0d033ec:	2205      	movs	r2, #5
c0d033ee:	5042      	str	r2, [r0, r1]
c0d033f0:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d033f2:	4621      	mov	r1, r4
c0d033f4:	4622      	mov	r2, r4
c0d033f6:	f7ff fa8a 	bl	c0d0290e <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d033fa:	4620      	mov	r0, r4
c0d033fc:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d03400 <__aeabi_uidiv>:
c0d03400:	2200      	movs	r2, #0
c0d03402:	0843      	lsrs	r3, r0, #1
c0d03404:	428b      	cmp	r3, r1
c0d03406:	d374      	bcc.n	c0d034f2 <__aeabi_uidiv+0xf2>
c0d03408:	0903      	lsrs	r3, r0, #4
c0d0340a:	428b      	cmp	r3, r1
c0d0340c:	d35f      	bcc.n	c0d034ce <__aeabi_uidiv+0xce>
c0d0340e:	0a03      	lsrs	r3, r0, #8
c0d03410:	428b      	cmp	r3, r1
c0d03412:	d344      	bcc.n	c0d0349e <__aeabi_uidiv+0x9e>
c0d03414:	0b03      	lsrs	r3, r0, #12
c0d03416:	428b      	cmp	r3, r1
c0d03418:	d328      	bcc.n	c0d0346c <__aeabi_uidiv+0x6c>
c0d0341a:	0c03      	lsrs	r3, r0, #16
c0d0341c:	428b      	cmp	r3, r1
c0d0341e:	d30d      	bcc.n	c0d0343c <__aeabi_uidiv+0x3c>
c0d03420:	22ff      	movs	r2, #255	; 0xff
c0d03422:	0209      	lsls	r1, r1, #8
c0d03424:	ba12      	rev	r2, r2
c0d03426:	0c03      	lsrs	r3, r0, #16
c0d03428:	428b      	cmp	r3, r1
c0d0342a:	d302      	bcc.n	c0d03432 <__aeabi_uidiv+0x32>
c0d0342c:	1212      	asrs	r2, r2, #8
c0d0342e:	0209      	lsls	r1, r1, #8
c0d03430:	d065      	beq.n	c0d034fe <__aeabi_uidiv+0xfe>
c0d03432:	0b03      	lsrs	r3, r0, #12
c0d03434:	428b      	cmp	r3, r1
c0d03436:	d319      	bcc.n	c0d0346c <__aeabi_uidiv+0x6c>
c0d03438:	e000      	b.n	c0d0343c <__aeabi_uidiv+0x3c>
c0d0343a:	0a09      	lsrs	r1, r1, #8
c0d0343c:	0bc3      	lsrs	r3, r0, #15
c0d0343e:	428b      	cmp	r3, r1
c0d03440:	d301      	bcc.n	c0d03446 <__aeabi_uidiv+0x46>
c0d03442:	03cb      	lsls	r3, r1, #15
c0d03444:	1ac0      	subs	r0, r0, r3
c0d03446:	4152      	adcs	r2, r2
c0d03448:	0b83      	lsrs	r3, r0, #14
c0d0344a:	428b      	cmp	r3, r1
c0d0344c:	d301      	bcc.n	c0d03452 <__aeabi_uidiv+0x52>
c0d0344e:	038b      	lsls	r3, r1, #14
c0d03450:	1ac0      	subs	r0, r0, r3
c0d03452:	4152      	adcs	r2, r2
c0d03454:	0b43      	lsrs	r3, r0, #13
c0d03456:	428b      	cmp	r3, r1
c0d03458:	d301      	bcc.n	c0d0345e <__aeabi_uidiv+0x5e>
c0d0345a:	034b      	lsls	r3, r1, #13
c0d0345c:	1ac0      	subs	r0, r0, r3
c0d0345e:	4152      	adcs	r2, r2
c0d03460:	0b03      	lsrs	r3, r0, #12
c0d03462:	428b      	cmp	r3, r1
c0d03464:	d301      	bcc.n	c0d0346a <__aeabi_uidiv+0x6a>
c0d03466:	030b      	lsls	r3, r1, #12
c0d03468:	1ac0      	subs	r0, r0, r3
c0d0346a:	4152      	adcs	r2, r2
c0d0346c:	0ac3      	lsrs	r3, r0, #11
c0d0346e:	428b      	cmp	r3, r1
c0d03470:	d301      	bcc.n	c0d03476 <__aeabi_uidiv+0x76>
c0d03472:	02cb      	lsls	r3, r1, #11
c0d03474:	1ac0      	subs	r0, r0, r3
c0d03476:	4152      	adcs	r2, r2
c0d03478:	0a83      	lsrs	r3, r0, #10
c0d0347a:	428b      	cmp	r3, r1
c0d0347c:	d301      	bcc.n	c0d03482 <__aeabi_uidiv+0x82>
c0d0347e:	028b      	lsls	r3, r1, #10
c0d03480:	1ac0      	subs	r0, r0, r3
c0d03482:	4152      	adcs	r2, r2
c0d03484:	0a43      	lsrs	r3, r0, #9
c0d03486:	428b      	cmp	r3, r1
c0d03488:	d301      	bcc.n	c0d0348e <__aeabi_uidiv+0x8e>
c0d0348a:	024b      	lsls	r3, r1, #9
c0d0348c:	1ac0      	subs	r0, r0, r3
c0d0348e:	4152      	adcs	r2, r2
c0d03490:	0a03      	lsrs	r3, r0, #8
c0d03492:	428b      	cmp	r3, r1
c0d03494:	d301      	bcc.n	c0d0349a <__aeabi_uidiv+0x9a>
c0d03496:	020b      	lsls	r3, r1, #8
c0d03498:	1ac0      	subs	r0, r0, r3
c0d0349a:	4152      	adcs	r2, r2
c0d0349c:	d2cd      	bcs.n	c0d0343a <__aeabi_uidiv+0x3a>
c0d0349e:	09c3      	lsrs	r3, r0, #7
c0d034a0:	428b      	cmp	r3, r1
c0d034a2:	d301      	bcc.n	c0d034a8 <__aeabi_uidiv+0xa8>
c0d034a4:	01cb      	lsls	r3, r1, #7
c0d034a6:	1ac0      	subs	r0, r0, r3
c0d034a8:	4152      	adcs	r2, r2
c0d034aa:	0983      	lsrs	r3, r0, #6
c0d034ac:	428b      	cmp	r3, r1
c0d034ae:	d301      	bcc.n	c0d034b4 <__aeabi_uidiv+0xb4>
c0d034b0:	018b      	lsls	r3, r1, #6
c0d034b2:	1ac0      	subs	r0, r0, r3
c0d034b4:	4152      	adcs	r2, r2
c0d034b6:	0943      	lsrs	r3, r0, #5
c0d034b8:	428b      	cmp	r3, r1
c0d034ba:	d301      	bcc.n	c0d034c0 <__aeabi_uidiv+0xc0>
c0d034bc:	014b      	lsls	r3, r1, #5
c0d034be:	1ac0      	subs	r0, r0, r3
c0d034c0:	4152      	adcs	r2, r2
c0d034c2:	0903      	lsrs	r3, r0, #4
c0d034c4:	428b      	cmp	r3, r1
c0d034c6:	d301      	bcc.n	c0d034cc <__aeabi_uidiv+0xcc>
c0d034c8:	010b      	lsls	r3, r1, #4
c0d034ca:	1ac0      	subs	r0, r0, r3
c0d034cc:	4152      	adcs	r2, r2
c0d034ce:	08c3      	lsrs	r3, r0, #3
c0d034d0:	428b      	cmp	r3, r1
c0d034d2:	d301      	bcc.n	c0d034d8 <__aeabi_uidiv+0xd8>
c0d034d4:	00cb      	lsls	r3, r1, #3
c0d034d6:	1ac0      	subs	r0, r0, r3
c0d034d8:	4152      	adcs	r2, r2
c0d034da:	0883      	lsrs	r3, r0, #2
c0d034dc:	428b      	cmp	r3, r1
c0d034de:	d301      	bcc.n	c0d034e4 <__aeabi_uidiv+0xe4>
c0d034e0:	008b      	lsls	r3, r1, #2
c0d034e2:	1ac0      	subs	r0, r0, r3
c0d034e4:	4152      	adcs	r2, r2
c0d034e6:	0843      	lsrs	r3, r0, #1
c0d034e8:	428b      	cmp	r3, r1
c0d034ea:	d301      	bcc.n	c0d034f0 <__aeabi_uidiv+0xf0>
c0d034ec:	004b      	lsls	r3, r1, #1
c0d034ee:	1ac0      	subs	r0, r0, r3
c0d034f0:	4152      	adcs	r2, r2
c0d034f2:	1a41      	subs	r1, r0, r1
c0d034f4:	d200      	bcs.n	c0d034f8 <__aeabi_uidiv+0xf8>
c0d034f6:	4601      	mov	r1, r0
c0d034f8:	4152      	adcs	r2, r2
c0d034fa:	4610      	mov	r0, r2
c0d034fc:	4770      	bx	lr
c0d034fe:	e7ff      	b.n	c0d03500 <__aeabi_uidiv+0x100>
c0d03500:	b501      	push	{r0, lr}
c0d03502:	2000      	movs	r0, #0
c0d03504:	f000 f8f0 	bl	c0d036e8 <__aeabi_idiv0>
c0d03508:	bd02      	pop	{r1, pc}
c0d0350a:	46c0      	nop			; (mov r8, r8)

c0d0350c <__aeabi_uidivmod>:
c0d0350c:	2900      	cmp	r1, #0
c0d0350e:	d0f7      	beq.n	c0d03500 <__aeabi_uidiv+0x100>
c0d03510:	e776      	b.n	c0d03400 <__aeabi_uidiv>
c0d03512:	4770      	bx	lr

c0d03514 <__aeabi_idiv>:
c0d03514:	4603      	mov	r3, r0
c0d03516:	430b      	orrs	r3, r1
c0d03518:	d47f      	bmi.n	c0d0361a <__aeabi_idiv+0x106>
c0d0351a:	2200      	movs	r2, #0
c0d0351c:	0843      	lsrs	r3, r0, #1
c0d0351e:	428b      	cmp	r3, r1
c0d03520:	d374      	bcc.n	c0d0360c <__aeabi_idiv+0xf8>
c0d03522:	0903      	lsrs	r3, r0, #4
c0d03524:	428b      	cmp	r3, r1
c0d03526:	d35f      	bcc.n	c0d035e8 <__aeabi_idiv+0xd4>
c0d03528:	0a03      	lsrs	r3, r0, #8
c0d0352a:	428b      	cmp	r3, r1
c0d0352c:	d344      	bcc.n	c0d035b8 <__aeabi_idiv+0xa4>
c0d0352e:	0b03      	lsrs	r3, r0, #12
c0d03530:	428b      	cmp	r3, r1
c0d03532:	d328      	bcc.n	c0d03586 <__aeabi_idiv+0x72>
c0d03534:	0c03      	lsrs	r3, r0, #16
c0d03536:	428b      	cmp	r3, r1
c0d03538:	d30d      	bcc.n	c0d03556 <__aeabi_idiv+0x42>
c0d0353a:	22ff      	movs	r2, #255	; 0xff
c0d0353c:	0209      	lsls	r1, r1, #8
c0d0353e:	ba12      	rev	r2, r2
c0d03540:	0c03      	lsrs	r3, r0, #16
c0d03542:	428b      	cmp	r3, r1
c0d03544:	d302      	bcc.n	c0d0354c <__aeabi_idiv+0x38>
c0d03546:	1212      	asrs	r2, r2, #8
c0d03548:	0209      	lsls	r1, r1, #8
c0d0354a:	d065      	beq.n	c0d03618 <__aeabi_idiv+0x104>
c0d0354c:	0b03      	lsrs	r3, r0, #12
c0d0354e:	428b      	cmp	r3, r1
c0d03550:	d319      	bcc.n	c0d03586 <__aeabi_idiv+0x72>
c0d03552:	e000      	b.n	c0d03556 <__aeabi_idiv+0x42>
c0d03554:	0a09      	lsrs	r1, r1, #8
c0d03556:	0bc3      	lsrs	r3, r0, #15
c0d03558:	428b      	cmp	r3, r1
c0d0355a:	d301      	bcc.n	c0d03560 <__aeabi_idiv+0x4c>
c0d0355c:	03cb      	lsls	r3, r1, #15
c0d0355e:	1ac0      	subs	r0, r0, r3
c0d03560:	4152      	adcs	r2, r2
c0d03562:	0b83      	lsrs	r3, r0, #14
c0d03564:	428b      	cmp	r3, r1
c0d03566:	d301      	bcc.n	c0d0356c <__aeabi_idiv+0x58>
c0d03568:	038b      	lsls	r3, r1, #14
c0d0356a:	1ac0      	subs	r0, r0, r3
c0d0356c:	4152      	adcs	r2, r2
c0d0356e:	0b43      	lsrs	r3, r0, #13
c0d03570:	428b      	cmp	r3, r1
c0d03572:	d301      	bcc.n	c0d03578 <__aeabi_idiv+0x64>
c0d03574:	034b      	lsls	r3, r1, #13
c0d03576:	1ac0      	subs	r0, r0, r3
c0d03578:	4152      	adcs	r2, r2
c0d0357a:	0b03      	lsrs	r3, r0, #12
c0d0357c:	428b      	cmp	r3, r1
c0d0357e:	d301      	bcc.n	c0d03584 <__aeabi_idiv+0x70>
c0d03580:	030b      	lsls	r3, r1, #12
c0d03582:	1ac0      	subs	r0, r0, r3
c0d03584:	4152      	adcs	r2, r2
c0d03586:	0ac3      	lsrs	r3, r0, #11
c0d03588:	428b      	cmp	r3, r1
c0d0358a:	d301      	bcc.n	c0d03590 <__aeabi_idiv+0x7c>
c0d0358c:	02cb      	lsls	r3, r1, #11
c0d0358e:	1ac0      	subs	r0, r0, r3
c0d03590:	4152      	adcs	r2, r2
c0d03592:	0a83      	lsrs	r3, r0, #10
c0d03594:	428b      	cmp	r3, r1
c0d03596:	d301      	bcc.n	c0d0359c <__aeabi_idiv+0x88>
c0d03598:	028b      	lsls	r3, r1, #10
c0d0359a:	1ac0      	subs	r0, r0, r3
c0d0359c:	4152      	adcs	r2, r2
c0d0359e:	0a43      	lsrs	r3, r0, #9
c0d035a0:	428b      	cmp	r3, r1
c0d035a2:	d301      	bcc.n	c0d035a8 <__aeabi_idiv+0x94>
c0d035a4:	024b      	lsls	r3, r1, #9
c0d035a6:	1ac0      	subs	r0, r0, r3
c0d035a8:	4152      	adcs	r2, r2
c0d035aa:	0a03      	lsrs	r3, r0, #8
c0d035ac:	428b      	cmp	r3, r1
c0d035ae:	d301      	bcc.n	c0d035b4 <__aeabi_idiv+0xa0>
c0d035b0:	020b      	lsls	r3, r1, #8
c0d035b2:	1ac0      	subs	r0, r0, r3
c0d035b4:	4152      	adcs	r2, r2
c0d035b6:	d2cd      	bcs.n	c0d03554 <__aeabi_idiv+0x40>
c0d035b8:	09c3      	lsrs	r3, r0, #7
c0d035ba:	428b      	cmp	r3, r1
c0d035bc:	d301      	bcc.n	c0d035c2 <__aeabi_idiv+0xae>
c0d035be:	01cb      	lsls	r3, r1, #7
c0d035c0:	1ac0      	subs	r0, r0, r3
c0d035c2:	4152      	adcs	r2, r2
c0d035c4:	0983      	lsrs	r3, r0, #6
c0d035c6:	428b      	cmp	r3, r1
c0d035c8:	d301      	bcc.n	c0d035ce <__aeabi_idiv+0xba>
c0d035ca:	018b      	lsls	r3, r1, #6
c0d035cc:	1ac0      	subs	r0, r0, r3
c0d035ce:	4152      	adcs	r2, r2
c0d035d0:	0943      	lsrs	r3, r0, #5
c0d035d2:	428b      	cmp	r3, r1
c0d035d4:	d301      	bcc.n	c0d035da <__aeabi_idiv+0xc6>
c0d035d6:	014b      	lsls	r3, r1, #5
c0d035d8:	1ac0      	subs	r0, r0, r3
c0d035da:	4152      	adcs	r2, r2
c0d035dc:	0903      	lsrs	r3, r0, #4
c0d035de:	428b      	cmp	r3, r1
c0d035e0:	d301      	bcc.n	c0d035e6 <__aeabi_idiv+0xd2>
c0d035e2:	010b      	lsls	r3, r1, #4
c0d035e4:	1ac0      	subs	r0, r0, r3
c0d035e6:	4152      	adcs	r2, r2
c0d035e8:	08c3      	lsrs	r3, r0, #3
c0d035ea:	428b      	cmp	r3, r1
c0d035ec:	d301      	bcc.n	c0d035f2 <__aeabi_idiv+0xde>
c0d035ee:	00cb      	lsls	r3, r1, #3
c0d035f0:	1ac0      	subs	r0, r0, r3
c0d035f2:	4152      	adcs	r2, r2
c0d035f4:	0883      	lsrs	r3, r0, #2
c0d035f6:	428b      	cmp	r3, r1
c0d035f8:	d301      	bcc.n	c0d035fe <__aeabi_idiv+0xea>
c0d035fa:	008b      	lsls	r3, r1, #2
c0d035fc:	1ac0      	subs	r0, r0, r3
c0d035fe:	4152      	adcs	r2, r2
c0d03600:	0843      	lsrs	r3, r0, #1
c0d03602:	428b      	cmp	r3, r1
c0d03604:	d301      	bcc.n	c0d0360a <__aeabi_idiv+0xf6>
c0d03606:	004b      	lsls	r3, r1, #1
c0d03608:	1ac0      	subs	r0, r0, r3
c0d0360a:	4152      	adcs	r2, r2
c0d0360c:	1a41      	subs	r1, r0, r1
c0d0360e:	d200      	bcs.n	c0d03612 <__aeabi_idiv+0xfe>
c0d03610:	4601      	mov	r1, r0
c0d03612:	4152      	adcs	r2, r2
c0d03614:	4610      	mov	r0, r2
c0d03616:	4770      	bx	lr
c0d03618:	e05d      	b.n	c0d036d6 <__aeabi_idiv+0x1c2>
c0d0361a:	0fca      	lsrs	r2, r1, #31
c0d0361c:	d000      	beq.n	c0d03620 <__aeabi_idiv+0x10c>
c0d0361e:	4249      	negs	r1, r1
c0d03620:	1003      	asrs	r3, r0, #32
c0d03622:	d300      	bcc.n	c0d03626 <__aeabi_idiv+0x112>
c0d03624:	4240      	negs	r0, r0
c0d03626:	4053      	eors	r3, r2
c0d03628:	2200      	movs	r2, #0
c0d0362a:	469c      	mov	ip, r3
c0d0362c:	0903      	lsrs	r3, r0, #4
c0d0362e:	428b      	cmp	r3, r1
c0d03630:	d32d      	bcc.n	c0d0368e <__aeabi_idiv+0x17a>
c0d03632:	0a03      	lsrs	r3, r0, #8
c0d03634:	428b      	cmp	r3, r1
c0d03636:	d312      	bcc.n	c0d0365e <__aeabi_idiv+0x14a>
c0d03638:	22fc      	movs	r2, #252	; 0xfc
c0d0363a:	0189      	lsls	r1, r1, #6
c0d0363c:	ba12      	rev	r2, r2
c0d0363e:	0a03      	lsrs	r3, r0, #8
c0d03640:	428b      	cmp	r3, r1
c0d03642:	d30c      	bcc.n	c0d0365e <__aeabi_idiv+0x14a>
c0d03644:	0189      	lsls	r1, r1, #6
c0d03646:	1192      	asrs	r2, r2, #6
c0d03648:	428b      	cmp	r3, r1
c0d0364a:	d308      	bcc.n	c0d0365e <__aeabi_idiv+0x14a>
c0d0364c:	0189      	lsls	r1, r1, #6
c0d0364e:	1192      	asrs	r2, r2, #6
c0d03650:	428b      	cmp	r3, r1
c0d03652:	d304      	bcc.n	c0d0365e <__aeabi_idiv+0x14a>
c0d03654:	0189      	lsls	r1, r1, #6
c0d03656:	d03a      	beq.n	c0d036ce <__aeabi_idiv+0x1ba>
c0d03658:	1192      	asrs	r2, r2, #6
c0d0365a:	e000      	b.n	c0d0365e <__aeabi_idiv+0x14a>
c0d0365c:	0989      	lsrs	r1, r1, #6
c0d0365e:	09c3      	lsrs	r3, r0, #7
c0d03660:	428b      	cmp	r3, r1
c0d03662:	d301      	bcc.n	c0d03668 <__aeabi_idiv+0x154>
c0d03664:	01cb      	lsls	r3, r1, #7
c0d03666:	1ac0      	subs	r0, r0, r3
c0d03668:	4152      	adcs	r2, r2
c0d0366a:	0983      	lsrs	r3, r0, #6
c0d0366c:	428b      	cmp	r3, r1
c0d0366e:	d301      	bcc.n	c0d03674 <__aeabi_idiv+0x160>
c0d03670:	018b      	lsls	r3, r1, #6
c0d03672:	1ac0      	subs	r0, r0, r3
c0d03674:	4152      	adcs	r2, r2
c0d03676:	0943      	lsrs	r3, r0, #5
c0d03678:	428b      	cmp	r3, r1
c0d0367a:	d301      	bcc.n	c0d03680 <__aeabi_idiv+0x16c>
c0d0367c:	014b      	lsls	r3, r1, #5
c0d0367e:	1ac0      	subs	r0, r0, r3
c0d03680:	4152      	adcs	r2, r2
c0d03682:	0903      	lsrs	r3, r0, #4
c0d03684:	428b      	cmp	r3, r1
c0d03686:	d301      	bcc.n	c0d0368c <__aeabi_idiv+0x178>
c0d03688:	010b      	lsls	r3, r1, #4
c0d0368a:	1ac0      	subs	r0, r0, r3
c0d0368c:	4152      	adcs	r2, r2
c0d0368e:	08c3      	lsrs	r3, r0, #3
c0d03690:	428b      	cmp	r3, r1
c0d03692:	d301      	bcc.n	c0d03698 <__aeabi_idiv+0x184>
c0d03694:	00cb      	lsls	r3, r1, #3
c0d03696:	1ac0      	subs	r0, r0, r3
c0d03698:	4152      	adcs	r2, r2
c0d0369a:	0883      	lsrs	r3, r0, #2
c0d0369c:	428b      	cmp	r3, r1
c0d0369e:	d301      	bcc.n	c0d036a4 <__aeabi_idiv+0x190>
c0d036a0:	008b      	lsls	r3, r1, #2
c0d036a2:	1ac0      	subs	r0, r0, r3
c0d036a4:	4152      	adcs	r2, r2
c0d036a6:	d2d9      	bcs.n	c0d0365c <__aeabi_idiv+0x148>
c0d036a8:	0843      	lsrs	r3, r0, #1
c0d036aa:	428b      	cmp	r3, r1
c0d036ac:	d301      	bcc.n	c0d036b2 <__aeabi_idiv+0x19e>
c0d036ae:	004b      	lsls	r3, r1, #1
c0d036b0:	1ac0      	subs	r0, r0, r3
c0d036b2:	4152      	adcs	r2, r2
c0d036b4:	1a41      	subs	r1, r0, r1
c0d036b6:	d200      	bcs.n	c0d036ba <__aeabi_idiv+0x1a6>
c0d036b8:	4601      	mov	r1, r0
c0d036ba:	4663      	mov	r3, ip
c0d036bc:	4152      	adcs	r2, r2
c0d036be:	105b      	asrs	r3, r3, #1
c0d036c0:	4610      	mov	r0, r2
c0d036c2:	d301      	bcc.n	c0d036c8 <__aeabi_idiv+0x1b4>
c0d036c4:	4240      	negs	r0, r0
c0d036c6:	2b00      	cmp	r3, #0
c0d036c8:	d500      	bpl.n	c0d036cc <__aeabi_idiv+0x1b8>
c0d036ca:	4249      	negs	r1, r1
c0d036cc:	4770      	bx	lr
c0d036ce:	4663      	mov	r3, ip
c0d036d0:	105b      	asrs	r3, r3, #1
c0d036d2:	d300      	bcc.n	c0d036d6 <__aeabi_idiv+0x1c2>
c0d036d4:	4240      	negs	r0, r0
c0d036d6:	b501      	push	{r0, lr}
c0d036d8:	2000      	movs	r0, #0
c0d036da:	f000 f805 	bl	c0d036e8 <__aeabi_idiv0>
c0d036de:	bd02      	pop	{r1, pc}

c0d036e0 <__aeabi_idivmod>:
c0d036e0:	2900      	cmp	r1, #0
c0d036e2:	d0f8      	beq.n	c0d036d6 <__aeabi_idiv+0x1c2>
c0d036e4:	e716      	b.n	c0d03514 <__aeabi_idiv>
c0d036e6:	4770      	bx	lr

c0d036e8 <__aeabi_idiv0>:
c0d036e8:	4770      	bx	lr
c0d036ea:	46c0      	nop			; (mov r8, r8)

c0d036ec <__aeabi_uldivmod>:
c0d036ec:	2b00      	cmp	r3, #0
c0d036ee:	d111      	bne.n	c0d03714 <__aeabi_uldivmod+0x28>
c0d036f0:	2a00      	cmp	r2, #0
c0d036f2:	d10f      	bne.n	c0d03714 <__aeabi_uldivmod+0x28>
c0d036f4:	2900      	cmp	r1, #0
c0d036f6:	d100      	bne.n	c0d036fa <__aeabi_uldivmod+0xe>
c0d036f8:	2800      	cmp	r0, #0
c0d036fa:	d002      	beq.n	c0d03702 <__aeabi_uldivmod+0x16>
c0d036fc:	2100      	movs	r1, #0
c0d036fe:	43c9      	mvns	r1, r1
c0d03700:	1c08      	adds	r0, r1, #0
c0d03702:	b407      	push	{r0, r1, r2}
c0d03704:	4802      	ldr	r0, [pc, #8]	; (c0d03710 <__aeabi_uldivmod+0x24>)
c0d03706:	a102      	add	r1, pc, #8	; (adr r1, c0d03710 <__aeabi_uldivmod+0x24>)
c0d03708:	1840      	adds	r0, r0, r1
c0d0370a:	9002      	str	r0, [sp, #8]
c0d0370c:	bd03      	pop	{r0, r1, pc}
c0d0370e:	46c0      	nop			; (mov r8, r8)
c0d03710:	ffffffd9 	.word	0xffffffd9
c0d03714:	b403      	push	{r0, r1}
c0d03716:	4668      	mov	r0, sp
c0d03718:	b501      	push	{r0, lr}
c0d0371a:	9802      	ldr	r0, [sp, #8]
c0d0371c:	f000 f806 	bl	c0d0372c <__udivmoddi4>
c0d03720:	9b01      	ldr	r3, [sp, #4]
c0d03722:	469e      	mov	lr, r3
c0d03724:	b002      	add	sp, #8
c0d03726:	bc0c      	pop	{r2, r3}
c0d03728:	4770      	bx	lr
c0d0372a:	46c0      	nop			; (mov r8, r8)

c0d0372c <__udivmoddi4>:
c0d0372c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0372e:	464d      	mov	r5, r9
c0d03730:	4656      	mov	r6, sl
c0d03732:	4644      	mov	r4, r8
c0d03734:	465f      	mov	r7, fp
c0d03736:	b4f0      	push	{r4, r5, r6, r7}
c0d03738:	4692      	mov	sl, r2
c0d0373a:	b083      	sub	sp, #12
c0d0373c:	0004      	movs	r4, r0
c0d0373e:	000d      	movs	r5, r1
c0d03740:	4699      	mov	r9, r3
c0d03742:	428b      	cmp	r3, r1
c0d03744:	d82f      	bhi.n	c0d037a6 <__udivmoddi4+0x7a>
c0d03746:	d02c      	beq.n	c0d037a2 <__udivmoddi4+0x76>
c0d03748:	4649      	mov	r1, r9
c0d0374a:	4650      	mov	r0, sl
c0d0374c:	f000 f8ae 	bl	c0d038ac <__clzdi2>
c0d03750:	0029      	movs	r1, r5
c0d03752:	0006      	movs	r6, r0
c0d03754:	0020      	movs	r0, r4
c0d03756:	f000 f8a9 	bl	c0d038ac <__clzdi2>
c0d0375a:	1a33      	subs	r3, r6, r0
c0d0375c:	4698      	mov	r8, r3
c0d0375e:	3b20      	subs	r3, #32
c0d03760:	469b      	mov	fp, r3
c0d03762:	d500      	bpl.n	c0d03766 <__udivmoddi4+0x3a>
c0d03764:	e074      	b.n	c0d03850 <__udivmoddi4+0x124>
c0d03766:	4653      	mov	r3, sl
c0d03768:	465a      	mov	r2, fp
c0d0376a:	4093      	lsls	r3, r2
c0d0376c:	001f      	movs	r7, r3
c0d0376e:	4653      	mov	r3, sl
c0d03770:	4642      	mov	r2, r8
c0d03772:	4093      	lsls	r3, r2
c0d03774:	001e      	movs	r6, r3
c0d03776:	42af      	cmp	r7, r5
c0d03778:	d829      	bhi.n	c0d037ce <__udivmoddi4+0xa2>
c0d0377a:	d026      	beq.n	c0d037ca <__udivmoddi4+0x9e>
c0d0377c:	465b      	mov	r3, fp
c0d0377e:	1ba4      	subs	r4, r4, r6
c0d03780:	41bd      	sbcs	r5, r7
c0d03782:	2b00      	cmp	r3, #0
c0d03784:	da00      	bge.n	c0d03788 <__udivmoddi4+0x5c>
c0d03786:	e079      	b.n	c0d0387c <__udivmoddi4+0x150>
c0d03788:	2200      	movs	r2, #0
c0d0378a:	2300      	movs	r3, #0
c0d0378c:	9200      	str	r2, [sp, #0]
c0d0378e:	9301      	str	r3, [sp, #4]
c0d03790:	2301      	movs	r3, #1
c0d03792:	465a      	mov	r2, fp
c0d03794:	4093      	lsls	r3, r2
c0d03796:	9301      	str	r3, [sp, #4]
c0d03798:	2301      	movs	r3, #1
c0d0379a:	4642      	mov	r2, r8
c0d0379c:	4093      	lsls	r3, r2
c0d0379e:	9300      	str	r3, [sp, #0]
c0d037a0:	e019      	b.n	c0d037d6 <__udivmoddi4+0xaa>
c0d037a2:	4282      	cmp	r2, r0
c0d037a4:	d9d0      	bls.n	c0d03748 <__udivmoddi4+0x1c>
c0d037a6:	2200      	movs	r2, #0
c0d037a8:	2300      	movs	r3, #0
c0d037aa:	9200      	str	r2, [sp, #0]
c0d037ac:	9301      	str	r3, [sp, #4]
c0d037ae:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d037b0:	2b00      	cmp	r3, #0
c0d037b2:	d001      	beq.n	c0d037b8 <__udivmoddi4+0x8c>
c0d037b4:	601c      	str	r4, [r3, #0]
c0d037b6:	605d      	str	r5, [r3, #4]
c0d037b8:	9800      	ldr	r0, [sp, #0]
c0d037ba:	9901      	ldr	r1, [sp, #4]
c0d037bc:	b003      	add	sp, #12
c0d037be:	bc3c      	pop	{r2, r3, r4, r5}
c0d037c0:	4690      	mov	r8, r2
c0d037c2:	4699      	mov	r9, r3
c0d037c4:	46a2      	mov	sl, r4
c0d037c6:	46ab      	mov	fp, r5
c0d037c8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d037ca:	42a3      	cmp	r3, r4
c0d037cc:	d9d6      	bls.n	c0d0377c <__udivmoddi4+0x50>
c0d037ce:	2200      	movs	r2, #0
c0d037d0:	2300      	movs	r3, #0
c0d037d2:	9200      	str	r2, [sp, #0]
c0d037d4:	9301      	str	r3, [sp, #4]
c0d037d6:	4643      	mov	r3, r8
c0d037d8:	2b00      	cmp	r3, #0
c0d037da:	d0e8      	beq.n	c0d037ae <__udivmoddi4+0x82>
c0d037dc:	07fb      	lsls	r3, r7, #31
c0d037de:	0872      	lsrs	r2, r6, #1
c0d037e0:	431a      	orrs	r2, r3
c0d037e2:	4646      	mov	r6, r8
c0d037e4:	087b      	lsrs	r3, r7, #1
c0d037e6:	e00e      	b.n	c0d03806 <__udivmoddi4+0xda>
c0d037e8:	42ab      	cmp	r3, r5
c0d037ea:	d101      	bne.n	c0d037f0 <__udivmoddi4+0xc4>
c0d037ec:	42a2      	cmp	r2, r4
c0d037ee:	d80c      	bhi.n	c0d0380a <__udivmoddi4+0xde>
c0d037f0:	1aa4      	subs	r4, r4, r2
c0d037f2:	419d      	sbcs	r5, r3
c0d037f4:	2001      	movs	r0, #1
c0d037f6:	1924      	adds	r4, r4, r4
c0d037f8:	416d      	adcs	r5, r5
c0d037fa:	2100      	movs	r1, #0
c0d037fc:	3e01      	subs	r6, #1
c0d037fe:	1824      	adds	r4, r4, r0
c0d03800:	414d      	adcs	r5, r1
c0d03802:	2e00      	cmp	r6, #0
c0d03804:	d006      	beq.n	c0d03814 <__udivmoddi4+0xe8>
c0d03806:	42ab      	cmp	r3, r5
c0d03808:	d9ee      	bls.n	c0d037e8 <__udivmoddi4+0xbc>
c0d0380a:	3e01      	subs	r6, #1
c0d0380c:	1924      	adds	r4, r4, r4
c0d0380e:	416d      	adcs	r5, r5
c0d03810:	2e00      	cmp	r6, #0
c0d03812:	d1f8      	bne.n	c0d03806 <__udivmoddi4+0xda>
c0d03814:	465b      	mov	r3, fp
c0d03816:	9800      	ldr	r0, [sp, #0]
c0d03818:	9901      	ldr	r1, [sp, #4]
c0d0381a:	1900      	adds	r0, r0, r4
c0d0381c:	4169      	adcs	r1, r5
c0d0381e:	2b00      	cmp	r3, #0
c0d03820:	db22      	blt.n	c0d03868 <__udivmoddi4+0x13c>
c0d03822:	002b      	movs	r3, r5
c0d03824:	465a      	mov	r2, fp
c0d03826:	40d3      	lsrs	r3, r2
c0d03828:	002a      	movs	r2, r5
c0d0382a:	4644      	mov	r4, r8
c0d0382c:	40e2      	lsrs	r2, r4
c0d0382e:	001c      	movs	r4, r3
c0d03830:	465b      	mov	r3, fp
c0d03832:	0015      	movs	r5, r2
c0d03834:	2b00      	cmp	r3, #0
c0d03836:	db2c      	blt.n	c0d03892 <__udivmoddi4+0x166>
c0d03838:	0026      	movs	r6, r4
c0d0383a:	409e      	lsls	r6, r3
c0d0383c:	0033      	movs	r3, r6
c0d0383e:	0026      	movs	r6, r4
c0d03840:	4647      	mov	r7, r8
c0d03842:	40be      	lsls	r6, r7
c0d03844:	0032      	movs	r2, r6
c0d03846:	1a80      	subs	r0, r0, r2
c0d03848:	4199      	sbcs	r1, r3
c0d0384a:	9000      	str	r0, [sp, #0]
c0d0384c:	9101      	str	r1, [sp, #4]
c0d0384e:	e7ae      	b.n	c0d037ae <__udivmoddi4+0x82>
c0d03850:	4642      	mov	r2, r8
c0d03852:	2320      	movs	r3, #32
c0d03854:	1a9b      	subs	r3, r3, r2
c0d03856:	4652      	mov	r2, sl
c0d03858:	40da      	lsrs	r2, r3
c0d0385a:	4641      	mov	r1, r8
c0d0385c:	0013      	movs	r3, r2
c0d0385e:	464a      	mov	r2, r9
c0d03860:	408a      	lsls	r2, r1
c0d03862:	0017      	movs	r7, r2
c0d03864:	431f      	orrs	r7, r3
c0d03866:	e782      	b.n	c0d0376e <__udivmoddi4+0x42>
c0d03868:	4642      	mov	r2, r8
c0d0386a:	2320      	movs	r3, #32
c0d0386c:	1a9b      	subs	r3, r3, r2
c0d0386e:	002a      	movs	r2, r5
c0d03870:	4646      	mov	r6, r8
c0d03872:	409a      	lsls	r2, r3
c0d03874:	0023      	movs	r3, r4
c0d03876:	40f3      	lsrs	r3, r6
c0d03878:	4313      	orrs	r3, r2
c0d0387a:	e7d5      	b.n	c0d03828 <__udivmoddi4+0xfc>
c0d0387c:	4642      	mov	r2, r8
c0d0387e:	2320      	movs	r3, #32
c0d03880:	2100      	movs	r1, #0
c0d03882:	1a9b      	subs	r3, r3, r2
c0d03884:	2200      	movs	r2, #0
c0d03886:	9100      	str	r1, [sp, #0]
c0d03888:	9201      	str	r2, [sp, #4]
c0d0388a:	2201      	movs	r2, #1
c0d0388c:	40da      	lsrs	r2, r3
c0d0388e:	9201      	str	r2, [sp, #4]
c0d03890:	e782      	b.n	c0d03798 <__udivmoddi4+0x6c>
c0d03892:	4642      	mov	r2, r8
c0d03894:	2320      	movs	r3, #32
c0d03896:	0026      	movs	r6, r4
c0d03898:	1a9b      	subs	r3, r3, r2
c0d0389a:	40de      	lsrs	r6, r3
c0d0389c:	002f      	movs	r7, r5
c0d0389e:	46b4      	mov	ip, r6
c0d038a0:	4097      	lsls	r7, r2
c0d038a2:	4666      	mov	r6, ip
c0d038a4:	003b      	movs	r3, r7
c0d038a6:	4333      	orrs	r3, r6
c0d038a8:	e7c9      	b.n	c0d0383e <__udivmoddi4+0x112>
c0d038aa:	46c0      	nop			; (mov r8, r8)

c0d038ac <__clzdi2>:
c0d038ac:	b510      	push	{r4, lr}
c0d038ae:	2900      	cmp	r1, #0
c0d038b0:	d103      	bne.n	c0d038ba <__clzdi2+0xe>
c0d038b2:	f000 f807 	bl	c0d038c4 <__clzsi2>
c0d038b6:	3020      	adds	r0, #32
c0d038b8:	e002      	b.n	c0d038c0 <__clzdi2+0x14>
c0d038ba:	1c08      	adds	r0, r1, #0
c0d038bc:	f000 f802 	bl	c0d038c4 <__clzsi2>
c0d038c0:	bd10      	pop	{r4, pc}
c0d038c2:	46c0      	nop			; (mov r8, r8)

c0d038c4 <__clzsi2>:
c0d038c4:	211c      	movs	r1, #28
c0d038c6:	2301      	movs	r3, #1
c0d038c8:	041b      	lsls	r3, r3, #16
c0d038ca:	4298      	cmp	r0, r3
c0d038cc:	d301      	bcc.n	c0d038d2 <__clzsi2+0xe>
c0d038ce:	0c00      	lsrs	r0, r0, #16
c0d038d0:	3910      	subs	r1, #16
c0d038d2:	0a1b      	lsrs	r3, r3, #8
c0d038d4:	4298      	cmp	r0, r3
c0d038d6:	d301      	bcc.n	c0d038dc <__clzsi2+0x18>
c0d038d8:	0a00      	lsrs	r0, r0, #8
c0d038da:	3908      	subs	r1, #8
c0d038dc:	091b      	lsrs	r3, r3, #4
c0d038de:	4298      	cmp	r0, r3
c0d038e0:	d301      	bcc.n	c0d038e6 <__clzsi2+0x22>
c0d038e2:	0900      	lsrs	r0, r0, #4
c0d038e4:	3904      	subs	r1, #4
c0d038e6:	a202      	add	r2, pc, #8	; (adr r2, c0d038f0 <__clzsi2+0x2c>)
c0d038e8:	5c10      	ldrb	r0, [r2, r0]
c0d038ea:	1840      	adds	r0, r0, r1
c0d038ec:	4770      	bx	lr
c0d038ee:	46c0      	nop			; (mov r8, r8)
c0d038f0:	02020304 	.word	0x02020304
c0d038f4:	01010101 	.word	0x01010101
	...

c0d03900 <__aeabi_memclr>:
c0d03900:	b510      	push	{r4, lr}
c0d03902:	2200      	movs	r2, #0
c0d03904:	f000 f806 	bl	c0d03914 <__aeabi_memset>
c0d03908:	bd10      	pop	{r4, pc}
c0d0390a:	46c0      	nop			; (mov r8, r8)

c0d0390c <__aeabi_memcpy>:
c0d0390c:	b510      	push	{r4, lr}
c0d0390e:	f000 f809 	bl	c0d03924 <memcpy>
c0d03912:	bd10      	pop	{r4, pc}

c0d03914 <__aeabi_memset>:
c0d03914:	0013      	movs	r3, r2
c0d03916:	b510      	push	{r4, lr}
c0d03918:	000a      	movs	r2, r1
c0d0391a:	0019      	movs	r1, r3
c0d0391c:	f000 f840 	bl	c0d039a0 <memset>
c0d03920:	bd10      	pop	{r4, pc}
c0d03922:	46c0      	nop			; (mov r8, r8)

c0d03924 <memcpy>:
c0d03924:	b570      	push	{r4, r5, r6, lr}
c0d03926:	2a0f      	cmp	r2, #15
c0d03928:	d932      	bls.n	c0d03990 <memcpy+0x6c>
c0d0392a:	000c      	movs	r4, r1
c0d0392c:	4304      	orrs	r4, r0
c0d0392e:	000b      	movs	r3, r1
c0d03930:	07a4      	lsls	r4, r4, #30
c0d03932:	d131      	bne.n	c0d03998 <memcpy+0x74>
c0d03934:	0015      	movs	r5, r2
c0d03936:	0004      	movs	r4, r0
c0d03938:	3d10      	subs	r5, #16
c0d0393a:	092d      	lsrs	r5, r5, #4
c0d0393c:	3501      	adds	r5, #1
c0d0393e:	012d      	lsls	r5, r5, #4
c0d03940:	1949      	adds	r1, r1, r5
c0d03942:	681e      	ldr	r6, [r3, #0]
c0d03944:	6026      	str	r6, [r4, #0]
c0d03946:	685e      	ldr	r6, [r3, #4]
c0d03948:	6066      	str	r6, [r4, #4]
c0d0394a:	689e      	ldr	r6, [r3, #8]
c0d0394c:	60a6      	str	r6, [r4, #8]
c0d0394e:	68de      	ldr	r6, [r3, #12]
c0d03950:	3310      	adds	r3, #16
c0d03952:	60e6      	str	r6, [r4, #12]
c0d03954:	3410      	adds	r4, #16
c0d03956:	4299      	cmp	r1, r3
c0d03958:	d1f3      	bne.n	c0d03942 <memcpy+0x1e>
c0d0395a:	230f      	movs	r3, #15
c0d0395c:	1945      	adds	r5, r0, r5
c0d0395e:	4013      	ands	r3, r2
c0d03960:	2b03      	cmp	r3, #3
c0d03962:	d91b      	bls.n	c0d0399c <memcpy+0x78>
c0d03964:	1f1c      	subs	r4, r3, #4
c0d03966:	2300      	movs	r3, #0
c0d03968:	08a4      	lsrs	r4, r4, #2
c0d0396a:	3401      	adds	r4, #1
c0d0396c:	00a4      	lsls	r4, r4, #2
c0d0396e:	58ce      	ldr	r6, [r1, r3]
c0d03970:	50ee      	str	r6, [r5, r3]
c0d03972:	3304      	adds	r3, #4
c0d03974:	429c      	cmp	r4, r3
c0d03976:	d1fa      	bne.n	c0d0396e <memcpy+0x4a>
c0d03978:	2303      	movs	r3, #3
c0d0397a:	192d      	adds	r5, r5, r4
c0d0397c:	1909      	adds	r1, r1, r4
c0d0397e:	401a      	ands	r2, r3
c0d03980:	d005      	beq.n	c0d0398e <memcpy+0x6a>
c0d03982:	2300      	movs	r3, #0
c0d03984:	5ccc      	ldrb	r4, [r1, r3]
c0d03986:	54ec      	strb	r4, [r5, r3]
c0d03988:	3301      	adds	r3, #1
c0d0398a:	429a      	cmp	r2, r3
c0d0398c:	d1fa      	bne.n	c0d03984 <memcpy+0x60>
c0d0398e:	bd70      	pop	{r4, r5, r6, pc}
c0d03990:	0005      	movs	r5, r0
c0d03992:	2a00      	cmp	r2, #0
c0d03994:	d1f5      	bne.n	c0d03982 <memcpy+0x5e>
c0d03996:	e7fa      	b.n	c0d0398e <memcpy+0x6a>
c0d03998:	0005      	movs	r5, r0
c0d0399a:	e7f2      	b.n	c0d03982 <memcpy+0x5e>
c0d0399c:	001a      	movs	r2, r3
c0d0399e:	e7f8      	b.n	c0d03992 <memcpy+0x6e>

c0d039a0 <memset>:
c0d039a0:	b570      	push	{r4, r5, r6, lr}
c0d039a2:	0783      	lsls	r3, r0, #30
c0d039a4:	d03f      	beq.n	c0d03a26 <memset+0x86>
c0d039a6:	1e54      	subs	r4, r2, #1
c0d039a8:	2a00      	cmp	r2, #0
c0d039aa:	d03b      	beq.n	c0d03a24 <memset+0x84>
c0d039ac:	b2ce      	uxtb	r6, r1
c0d039ae:	0003      	movs	r3, r0
c0d039b0:	2503      	movs	r5, #3
c0d039b2:	e003      	b.n	c0d039bc <memset+0x1c>
c0d039b4:	1e62      	subs	r2, r4, #1
c0d039b6:	2c00      	cmp	r4, #0
c0d039b8:	d034      	beq.n	c0d03a24 <memset+0x84>
c0d039ba:	0014      	movs	r4, r2
c0d039bc:	3301      	adds	r3, #1
c0d039be:	1e5a      	subs	r2, r3, #1
c0d039c0:	7016      	strb	r6, [r2, #0]
c0d039c2:	422b      	tst	r3, r5
c0d039c4:	d1f6      	bne.n	c0d039b4 <memset+0x14>
c0d039c6:	2c03      	cmp	r4, #3
c0d039c8:	d924      	bls.n	c0d03a14 <memset+0x74>
c0d039ca:	25ff      	movs	r5, #255	; 0xff
c0d039cc:	400d      	ands	r5, r1
c0d039ce:	022a      	lsls	r2, r5, #8
c0d039d0:	4315      	orrs	r5, r2
c0d039d2:	042a      	lsls	r2, r5, #16
c0d039d4:	4315      	orrs	r5, r2
c0d039d6:	2c0f      	cmp	r4, #15
c0d039d8:	d911      	bls.n	c0d039fe <memset+0x5e>
c0d039da:	0026      	movs	r6, r4
c0d039dc:	3e10      	subs	r6, #16
c0d039de:	0936      	lsrs	r6, r6, #4
c0d039e0:	3601      	adds	r6, #1
c0d039e2:	0136      	lsls	r6, r6, #4
c0d039e4:	001a      	movs	r2, r3
c0d039e6:	199b      	adds	r3, r3, r6
c0d039e8:	6015      	str	r5, [r2, #0]
c0d039ea:	6055      	str	r5, [r2, #4]
c0d039ec:	6095      	str	r5, [r2, #8]
c0d039ee:	60d5      	str	r5, [r2, #12]
c0d039f0:	3210      	adds	r2, #16
c0d039f2:	4293      	cmp	r3, r2
c0d039f4:	d1f8      	bne.n	c0d039e8 <memset+0x48>
c0d039f6:	220f      	movs	r2, #15
c0d039f8:	4014      	ands	r4, r2
c0d039fa:	2c03      	cmp	r4, #3
c0d039fc:	d90a      	bls.n	c0d03a14 <memset+0x74>
c0d039fe:	1f26      	subs	r6, r4, #4
c0d03a00:	08b6      	lsrs	r6, r6, #2
c0d03a02:	3601      	adds	r6, #1
c0d03a04:	00b6      	lsls	r6, r6, #2
c0d03a06:	001a      	movs	r2, r3
c0d03a08:	199b      	adds	r3, r3, r6
c0d03a0a:	c220      	stmia	r2!, {r5}
c0d03a0c:	4293      	cmp	r3, r2
c0d03a0e:	d1fc      	bne.n	c0d03a0a <memset+0x6a>
c0d03a10:	2203      	movs	r2, #3
c0d03a12:	4014      	ands	r4, r2
c0d03a14:	2c00      	cmp	r4, #0
c0d03a16:	d005      	beq.n	c0d03a24 <memset+0x84>
c0d03a18:	b2c9      	uxtb	r1, r1
c0d03a1a:	191c      	adds	r4, r3, r4
c0d03a1c:	7019      	strb	r1, [r3, #0]
c0d03a1e:	3301      	adds	r3, #1
c0d03a20:	429c      	cmp	r4, r3
c0d03a22:	d1fb      	bne.n	c0d03a1c <memset+0x7c>
c0d03a24:	bd70      	pop	{r4, r5, r6, pc}
c0d03a26:	0014      	movs	r4, r2
c0d03a28:	0003      	movs	r3, r0
c0d03a2a:	e7cc      	b.n	c0d039c6 <memset+0x26>

c0d03a2c <setjmp>:
c0d03a2c:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d03a2e:	4641      	mov	r1, r8
c0d03a30:	464a      	mov	r2, r9
c0d03a32:	4653      	mov	r3, sl
c0d03a34:	465c      	mov	r4, fp
c0d03a36:	466d      	mov	r5, sp
c0d03a38:	4676      	mov	r6, lr
c0d03a3a:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d03a3c:	3828      	subs	r0, #40	; 0x28
c0d03a3e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03a40:	2000      	movs	r0, #0
c0d03a42:	4770      	bx	lr

c0d03a44 <longjmp>:
c0d03a44:	3010      	adds	r0, #16
c0d03a46:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03a48:	4690      	mov	r8, r2
c0d03a4a:	4699      	mov	r9, r3
c0d03a4c:	46a2      	mov	sl, r4
c0d03a4e:	46ab      	mov	fp, r5
c0d03a50:	46b5      	mov	sp, r6
c0d03a52:	c808      	ldmia	r0!, {r3}
c0d03a54:	3828      	subs	r0, #40	; 0x28
c0d03a56:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03a58:	1c08      	adds	r0, r1, #0
c0d03a5a:	d100      	bne.n	c0d03a5e <longjmp+0x1a>
c0d03a5c:	2001      	movs	r0, #1
c0d03a5e:	4718      	bx	r3

c0d03a60 <strlen>:
c0d03a60:	b510      	push	{r4, lr}
c0d03a62:	0783      	lsls	r3, r0, #30
c0d03a64:	d027      	beq.n	c0d03ab6 <strlen+0x56>
c0d03a66:	7803      	ldrb	r3, [r0, #0]
c0d03a68:	2b00      	cmp	r3, #0
c0d03a6a:	d026      	beq.n	c0d03aba <strlen+0x5a>
c0d03a6c:	0003      	movs	r3, r0
c0d03a6e:	2103      	movs	r1, #3
c0d03a70:	e002      	b.n	c0d03a78 <strlen+0x18>
c0d03a72:	781a      	ldrb	r2, [r3, #0]
c0d03a74:	2a00      	cmp	r2, #0
c0d03a76:	d01c      	beq.n	c0d03ab2 <strlen+0x52>
c0d03a78:	3301      	adds	r3, #1
c0d03a7a:	420b      	tst	r3, r1
c0d03a7c:	d1f9      	bne.n	c0d03a72 <strlen+0x12>
c0d03a7e:	6819      	ldr	r1, [r3, #0]
c0d03a80:	4a0f      	ldr	r2, [pc, #60]	; (c0d03ac0 <strlen+0x60>)
c0d03a82:	4c10      	ldr	r4, [pc, #64]	; (c0d03ac4 <strlen+0x64>)
c0d03a84:	188a      	adds	r2, r1, r2
c0d03a86:	438a      	bics	r2, r1
c0d03a88:	4222      	tst	r2, r4
c0d03a8a:	d10f      	bne.n	c0d03aac <strlen+0x4c>
c0d03a8c:	3304      	adds	r3, #4
c0d03a8e:	6819      	ldr	r1, [r3, #0]
c0d03a90:	4a0b      	ldr	r2, [pc, #44]	; (c0d03ac0 <strlen+0x60>)
c0d03a92:	188a      	adds	r2, r1, r2
c0d03a94:	438a      	bics	r2, r1
c0d03a96:	4222      	tst	r2, r4
c0d03a98:	d108      	bne.n	c0d03aac <strlen+0x4c>
c0d03a9a:	3304      	adds	r3, #4
c0d03a9c:	6819      	ldr	r1, [r3, #0]
c0d03a9e:	4a08      	ldr	r2, [pc, #32]	; (c0d03ac0 <strlen+0x60>)
c0d03aa0:	188a      	adds	r2, r1, r2
c0d03aa2:	438a      	bics	r2, r1
c0d03aa4:	4222      	tst	r2, r4
c0d03aa6:	d0f1      	beq.n	c0d03a8c <strlen+0x2c>
c0d03aa8:	e000      	b.n	c0d03aac <strlen+0x4c>
c0d03aaa:	3301      	adds	r3, #1
c0d03aac:	781a      	ldrb	r2, [r3, #0]
c0d03aae:	2a00      	cmp	r2, #0
c0d03ab0:	d1fb      	bne.n	c0d03aaa <strlen+0x4a>
c0d03ab2:	1a18      	subs	r0, r3, r0
c0d03ab4:	bd10      	pop	{r4, pc}
c0d03ab6:	0003      	movs	r3, r0
c0d03ab8:	e7e1      	b.n	c0d03a7e <strlen+0x1e>
c0d03aba:	2000      	movs	r0, #0
c0d03abc:	e7fa      	b.n	c0d03ab4 <strlen+0x54>
c0d03abe:	46c0      	nop			; (mov r8, r8)
c0d03ac0:	fefefeff 	.word	0xfefefeff
c0d03ac4:	80808080 	.word	0x80808080

c0d03ac8 <HALF_3>:
c0d03ac8:	f16b9c2d dd01633c 3d8cf0ee b09a028b     -.k.<c.....=....
c0d03ad8:	246cd94a f1c6d805 6cee5506 da330aa3     J.l$.....U.l..3.
c0d03ae8:	fde381a1 fe13f810 f97f039e 1b3dc3ce     ..............=.
c0d03af8:	00000001                                ....

c0d03afc <bagl_ui_nanos_screen1>:
c0d03afc:	00000003 00800000 00000020 00000001     ........ .......
c0d03b0c:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03b34:	00000107 0080000c 00000020 00000000     ........ .......
c0d03b44:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03b6c:	00030005 0007000c 00000007 00000000     ................
	...
c0d03b84:	00070000 00000000 00000000 00000000     ................
	...
c0d03ba4:	00750005 0008000d 00000006 00000000     ..u.............
c0d03bb4:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03bdc <bagl_ui_nanos_screen2>:
c0d03bdc:	00000003 00800000 00000020 00000001     ........ .......
c0d03bec:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03c14:	00000107 00800012 00000020 00000000     ........ .......
c0d03c24:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03c4c:	00030005 0007000c 00000007 00000000     ................
	...
c0d03c64:	00070000 00000000 00000000 00000000     ................
	...
c0d03c84:	00750005 0008000d 00000006 00000000     ..u.............
c0d03c94:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03cbc <bagl_ui_sample_blue>:
c0d03cbc:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03ccc:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03cf4:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03d04:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03d2c:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03d3c:	00ffffff 001d2028 00002004 c0d03d9c     ....( ... ...=..
	...
c0d03d64:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03d74:	0041ccb4 00f9f9f9 0000a004 c0d03da8     ..A..........=..
c0d03d84:	00000000 0037ae99 00f9f9f9 c0d026d1     ......7......&..
	...
c0d03d9c:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03dad <USBD_PRODUCT_FS_STRING>:
c0d03dad:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d03dbb <HID_ReportDesc>:
c0d03dbb:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d03dcb:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d03ddb:	0000c008 11210900                                .....

c0d03de0 <USBD_HID_Desc>:
c0d03de0:	01112109 22220100 00011200                       .!...."".

c0d03de9 <USBD_DeviceDesc>:
c0d03de9:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03df9:	e1000103                                         ...

c0d03dfc <HID_Desc>:
c0d03dfc:	c0d032e1 c0d032f1 c0d03301 c0d03311     .2...2...3...3..
c0d03e0c:	c0d03321 c0d03331 c0d03341 00000000     !3..13..A3......

c0d03e1c <USBD_LangIDDesc>:
c0d03e1c:	04090304                                ....

c0d03e20 <USBD_MANUFACTURER_STRING>:
c0d03e20:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03e2e <USB_SERIAL_STRING>:
c0d03e2e:	0030030a 00300030 31c30031                       ..0.0.0.1.

c0d03e38 <USBD_HID>:
c0d03e38:	c0d031c3 c0d031f5 c0d03127 00000000     .1...1..'1......
	...
c0d03e50:	c0d0322d 00000000 00000000 00000000     -2..............
c0d03e60:	c0d03351 c0d03351 c0d03351 c0d03361     Q3..Q3..Q3..a3..

c0d03e70 <USBD_CfgDesc>:
c0d03e70:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03e80:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03e90:	05070100 00400302 00000001              ......@.....

c0d03e9c <USBD_DeviceQualifierDesc>:
c0d03e9c:	0200060a 40000000 00000001              .......@....

c0d03ea8 <_etext>:
	...

c0d03ec0 <N_storage_real>:
	...
