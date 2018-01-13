
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
c0d00014:	f001 f9f0 	bl	c0d013f8 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f001 f93c 	bl	c0d01294 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 fda1 	bl	c0d03b6c <setjmp>
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
c0d00040:	f001 fb80 	bl	c0d01744 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f002 f861 	bl	c0d0210c <pic>
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
c0d0005a:	f002 f857 	bl	c0d0210c <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f002 f8a5 	bl	c0d021b0 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f003 f9ac 	bl	c0d033c4 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f003 f9a9 	bl	c0d033c4 <USB_power>

            ui_idle();
c0d00072:	f002 fb3d 	bl	c0d026f0 <ui_idle>

            IOTA_main();
c0d00076:	f000 ffa5 	bl	c0d00fc4 <IOTA_main>
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
c0d0008c:	f003 fd7a 	bl	c0d03b84 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d040c0 	.word	0xc0d040c0

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
c0d000c8:	f003 fac0 	bl	c0d0364c <__aeabi_uidivmod>
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
c0d000e6:	f003 fa2b 	bl	c0d03540 <__aeabi_uidiv>
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
c0d000fa:	f000 f91e 	bl	c0d0033a <trits_to_trint>
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
c0d00114:	f000 f998 	bl	c0d00448 <trint_to_trits>
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
c0d00144:	f000 f8f9 	bl	c0d0033a <trits_to_trint>
c0d00148:	4605      	mov	r5, r0
c0d0014a:	2000      	movs	r0, #0
c0d0014c:	9a06      	ldr	r2, [sp, #24]
c0d0014e:	2a05      	cmp	r2, #5
c0d00150:	d303      	bcc.n	c0d0015a <add_index_to_seed_trints+0xb6>
                else trints[(uint8_t)(offset/5)] = trits_to_trint(&trits[0], send);
c0d00152:	2105      	movs	r1, #5
c0d00154:	4610      	mov	r0, r2
c0d00156:	f003 f9f3 	bl	c0d03540 <__aeabi_uidiv>
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
c0d0017e:	f000 fcfd 	bl	c0d00b7c <kerl_initialize>
c0d00182:	2631      	movs	r6, #49	; 0x31
    kerl_absorb_trints(&seed_trints[0], 49);
c0d00184:	4628      	mov	r0, r5
c0d00186:	4631      	mov	r1, r6
c0d00188:	f000 fd18 	bl	c0d00bbc <kerl_absorb_trints>
c0d0018c:	9400      	str	r4, [sp, #0]
    kerl_squeeze_trints(&private_key[0], 49);
c0d0018e:	4620      	mov	r0, r4
c0d00190:	4631      	mov	r1, r6
c0d00192:	f000 fd43 	bl	c0d00c1c <kerl_squeeze_trints>

    kerl_initialize();
c0d00196:	f000 fcf1 	bl	c0d00b7c <kerl_initialize>
    kerl_absorb_trints(&seed_trints[0], 49);
c0d0019a:	4628      	mov	r0, r5
c0d0019c:	4631      	mov	r1, r6
c0d0019e:	f000 fd0d 	bl	c0d00bbc <kerl_absorb_trints>
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
c0d001b2:	f000 fd33 	bl	c0d00c1c <kerl_squeeze_trints>
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
c0d001ec:	b085      	sub	sp, #20
c0d001ee:	9200      	str	r2, [sp, #0]
c0d001f0:	9101      	str	r1, [sp, #4]
c0d001f2:	4606      	mov	r6, r0
c0d001f4:	2000      	movs	r0, #0
c0d001f6:	9002      	str	r0, [sp, #8]
c0d001f8:	4601      	mov	r1, r0
c0d001fa:	9603      	str	r6, [sp, #12]
c0d001fc:	2031      	movs	r0, #49	; 0x31
c0d001fe:	9104      	str	r1, [sp, #16]
c0d00200:	4348      	muls	r0, r1
c0d00202:	1834      	adds	r4, r6, r0
c0d00204:	9d02      	ldr	r5, [sp, #8]
    for(uint8_t j = 0; j < 27; j++) {
        // each piece get's kerl'd 26 times(?)
        for(uint8_t k = 0; k < 26; k++) {
            //temp set k=25 to make this a LOT faster
            //k = 25;
            kerl_initialize();
c0d00206:	f000 fcb9 	bl	c0d00b7c <kerl_initialize>
c0d0020a:	2631      	movs	r6, #49	; 0x31
            kerl_absorb_trints(&private_key[j*49], 49);
c0d0020c:	4620      	mov	r0, r4
c0d0020e:	4631      	mov	r1, r6
c0d00210:	f000 fcd4 	bl	c0d00bbc <kerl_absorb_trints>
            kerl_squeeze_trints(&private_key[j*49], 49);
c0d00214:	4620      	mov	r0, r4
c0d00216:	4631      	mov	r1, r6
c0d00218:	f000 fd00 	bl	c0d00c1c <kerl_squeeze_trints>
//Use level 1 to generate first half, level 2 to generate second half
int generate_public_address_half(trint_t *private_key, trint_t *address_out, uint8_t level)
{
    for(uint8_t j = 0; j < 27; j++) {
        // each piece get's kerl'd 26 times(?)
        for(uint8_t k = 0; k < 26; k++) {
c0d0021c:	1c6d      	adds	r5, r5, #1
c0d0021e:	b2e8      	uxtb	r0, r5
c0d00220:	281a      	cmp	r0, #26
c0d00222:	d3f0      	bcc.n	c0d00206 <generate_public_address_half+0x1e>
c0d00224:	9904      	ldr	r1, [sp, #16]

//Generate the public key half at a time
//Use level 1 to generate first half, level 2 to generate second half
int generate_public_address_half(trint_t *private_key, trint_t *address_out, uint8_t level)
{
    for(uint8_t j = 0; j < 27; j++) {
c0d00226:	1c49      	adds	r1, r1, #1
c0d00228:	291b      	cmp	r1, #27
c0d0022a:	9e03      	ldr	r6, [sp, #12]
c0d0022c:	d1e6      	bne.n	c0d001fc <generate_public_address_half+0x14>
            kerl_squeeze_trints(&private_key[j*49], 49);
        }
    }

    //the 27th kerl generates the digests
    kerl_initialize();
c0d0022e:	f000 fca5 	bl	c0d00b7c <kerl_initialize>
    kerl_absorb_trints(private_key, 49*27); // re-absorb the entire private key
c0d00232:	4910      	ldr	r1, [pc, #64]	; (c0d00274 <generate_public_address_half+0x8c>)
c0d00234:	4630      	mov	r0, r6
c0d00236:	f000 fcc1 	bl	c0d00bbc <kerl_absorb_trints>

    // use level 1 to pass the first half of the private key, store
    // digest in public key for now to save RAM
    if(level == 1)
c0d0023a:	9800      	ldr	r0, [sp, #0]
c0d0023c:	2801      	cmp	r0, #1
c0d0023e:	d102      	bne.n	c0d00246 <generate_public_address_half+0x5e>
        kerl_squeeze_trints(address_out, 49); // Store the first digest just in address_out{
c0d00240:	2131      	movs	r1, #49	; 0x31
c0d00242:	9801      	ldr	r0, [sp, #4]
c0d00244:	e011      	b.n	c0d0026a <generate_public_address_half+0x82>
c0d00246:	2431      	movs	r4, #49	; 0x31
    else {
        //done with private key, so store the second digest in private key
        kerl_squeeze_trints(private_key, 49);
c0d00248:	4630      	mov	r0, r6
c0d0024a:	4621      	mov	r1, r4
c0d0024c:	f000 fce6 	bl	c0d00c1c <kerl_squeeze_trints>

        //now get address
        kerl_initialize();
c0d00250:	f000 fc94 	bl	c0d00b7c <kerl_initialize>
c0d00254:	9d01      	ldr	r5, [sp, #4]
        //address out stores first half, private key stores second half
        kerl_absorb_trints(address_out, 49);
c0d00256:	4628      	mov	r0, r5
c0d00258:	4621      	mov	r1, r4
c0d0025a:	f000 fcaf 	bl	c0d00bbc <kerl_absorb_trints>
        kerl_absorb_trints(private_key, 49);
c0d0025e:	4630      	mov	r0, r6
c0d00260:	4621      	mov	r1, r4
c0d00262:	f000 fcab 	bl	c0d00bbc <kerl_absorb_trints>
        //finally publish the public key
        kerl_squeeze_trints(address_out, 49);
c0d00266:	4628      	mov	r0, r5
c0d00268:	4621      	mov	r1, r4
c0d0026a:	f000 fcd7 	bl	c0d00c1c <kerl_squeeze_trints>
    }

    return 0;
c0d0026e:	2000      	movs	r0, #0
c0d00270:	b005      	add	sp, #20
c0d00272:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00274:	0000052b 	.word	0x0000052b

c0d00278 <write_debug>:

char debug_str[64];

//write_debug(&words, sizeof(words), TYPE_STR);
//write_debug(&int_val, sizeof(int_val), TYPE_INT);
void write_debug(void* o, unsigned int sz, uint8_t t) {
c0d00278:	b580      	push	{r7, lr}
c0d0027a:	af00      	add	r7, sp, #0
c0d0027c:	4603      	mov	r3, r0

    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
c0d0027e:	2a03      	cmp	r2, #3
c0d00280:	d007      	beq.n	c0d00292 <write_debug+0x1a>
c0d00282:	2a02      	cmp	r2, #2
c0d00284:	d008      	beq.n	c0d00298 <write_debug+0x20>
c0d00286:	2a01      	cmp	r2, #1
c0d00288:	d10b      	bne.n	c0d002a2 <write_debug+0x2a>
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
c0d0028a:	681b      	ldr	r3, [r3, #0]
c0d0028c:	4805      	ldr	r0, [pc, #20]	; (c0d002a4 <write_debug+0x2c>)
c0d0028e:	a208      	add	r2, pc, #32	; (adr r2, c0d002b0 <write_debug+0x38>)
c0d00290:	e005      	b.n	c0d0029e <write_debug+0x26>
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
c0d00292:	4804      	ldr	r0, [pc, #16]	; (c0d002a4 <write_debug+0x2c>)
c0d00294:	a204      	add	r2, pc, #16	; (adr r2, c0d002a8 <write_debug+0x30>)
c0d00296:	e002      	b.n	c0d0029e <write_debug+0x26>
    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
c0d00298:	681b      	ldr	r3, [r3, #0]
c0d0029a:	4802      	ldr	r0, [pc, #8]	; (c0d002a4 <write_debug+0x2c>)
c0d0029c:	a203      	add	r2, pc, #12	; (adr r2, c0d002ac <write_debug+0x34>)
c0d0029e:	f001 fce5 	bl	c0d01c6c <snprintf>
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
    }
}
c0d002a2:	bd80      	pop	{r7, pc}
c0d002a4:	20001800 	.word	0x20001800
c0d002a8:	00007325 	.word	0x00007325
c0d002ac:	00007525 	.word	0x00007525
c0d002b0:	00006425 	.word	0x00006425

c0d002b4 <specific_243trits_to_49trints>:

void specific_243trits_to_49trints(int8_t *trits, int8_t *trints_r) {
c0d002b4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d002b6:	af03      	add	r7, sp, #12
c0d002b8:	b086      	sub	sp, #24
c0d002ba:	2500      	movs	r5, #0
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d002bc:	43eb      	mvns	r3, r5
c0d002be:	2205      	movs	r2, #5
c0d002c0:	9201      	str	r2, [sp, #4]
c0d002c2:	43d6      	mvns	r6, r2
c0d002c4:	1f80      	subs	r0, r0, #6
}

void specific_243trits_to_49trints(int8_t *trits, int8_t *trints_r) {
    uint8_t send = 0, count = 0;
    //send all trits in groups of 5 (last one just 3)
    for(uint8_t i = 0; i < 243; i += 5) {
c0d002c6:	1d00      	adds	r0, r0, #4
c0d002c8:	9000      	str	r0, [sp, #0]
c0d002ca:	462a      	mov	r2, r5
c0d002cc:	9102      	str	r1, [sp, #8]
c0d002ce:	9605      	str	r6, [sp, #20]
        send = ((243 - i) < 5) ? 243 - i : 5;
c0d002d0:	20f3      	movs	r0, #243	; 0xf3
c0d002d2:	9204      	str	r2, [sp, #16]
c0d002d4:	1a80      	subs	r0, r0, r2
c0d002d6:	2805      	cmp	r0, #5
c0d002d8:	db00      	blt.n	c0d002dc <specific_243trits_to_49trints+0x28>
c0d002da:	9801      	ldr	r0, [sp, #4]
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d002dc:	b2c0      	uxtb	r0, r0
c0d002de:	30ff      	adds	r0, #255	; 0xff
c0d002e0:	b242      	sxtb	r2, r0
c0d002e2:	2400      	movs	r4, #0
c0d002e4:	429a      	cmp	r2, r3
c0d002e6:	9a04      	ldr	r2, [sp, #16]
c0d002e8:	dd1f      	ble.n	c0d0032a <specific_243trits_to_49trints+0x76>
c0d002ea:	9503      	str	r5, [sp, #12]
c0d002ec:	2105      	movs	r1, #5
c0d002ee:	43cc      	mvns	r4, r1
c0d002f0:	4611      	mov	r1, r2
c0d002f2:	39f4      	subs	r1, #244	; 0xf4
c0d002f4:	42a1      	cmp	r1, r4
c0d002f6:	dc00      	bgt.n	c0d002fa <specific_243trits_to_49trints+0x46>
c0d002f8:	4631      	mov	r1, r6
c0d002fa:	1a51      	subs	r1, r2, r1
c0d002fc:	9a00      	ldr	r2, [sp, #0]
c0d002fe:	1856      	adds	r6, r2, r1
c0d00300:	2101      	movs	r1, #1
c0d00302:	2400      	movs	r4, #0
    {
        ret += trits[i]*pow3_val;
c0d00304:	b24a      	sxtb	r2, r1
        pow3_val *= 3;
c0d00306:	2103      	movs	r1, #3
c0d00308:	4351      	muls	r1, r2
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
    {
        ret += trits[i]*pow3_val;
c0d0030a:	7835      	ldrb	r5, [r6, #0]
c0d0030c:	b26d      	sxtb	r5, r5
c0d0030e:	4355      	muls	r5, r2
c0d00310:	b2e2      	uxtb	r2, r4
c0d00312:	18ac      	adds	r4, r5, r2
c0d00314:	9a05      	ldr	r2, [sp, #20]
c0d00316:	18b2      	adds	r2, r6, r2
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d00318:	1d56      	adds	r6, r2, #5
c0d0031a:	1e40      	subs	r0, r0, #1
c0d0031c:	b240      	sxtb	r0, r0
c0d0031e:	4298      	cmp	r0, r3
c0d00320:	dcf0      	bgt.n	c0d00304 <specific_243trits_to_49trints+0x50>
c0d00322:	9902      	ldr	r1, [sp, #8]
c0d00324:	9d03      	ldr	r5, [sp, #12]
c0d00326:	9e05      	ldr	r6, [sp, #20]
c0d00328:	9a04      	ldr	r2, [sp, #16]
    //send all trits in groups of 5 (last one just 3)
    for(uint8_t i = 0; i < 243; i += 5) {
        send = ((243 - i) < 5) ? 243 - i : 5;

        //incr count as we get trints
        trints_r[count++] = trits_to_trint(&trits[i], send);
c0d0032a:	554c      	strb	r4, [r1, r5]
c0d0032c:	1c6d      	adds	r5, r5, #1
}

void specific_243trits_to_49trints(int8_t *trits, int8_t *trints_r) {
    uint8_t send = 0, count = 0;
    //send all trits in groups of 5 (last one just 3)
    for(uint8_t i = 0; i < 243; i += 5) {
c0d0032e:	1d50      	adds	r0, r2, #5
c0d00330:	b2c2      	uxtb	r2, r0
c0d00332:	2d31      	cmp	r5, #49	; 0x31
c0d00334:	d1cc      	bne.n	c0d002d0 <specific_243trits_to_49trints+0x1c>
        send = ((243 - i) < 5) ? 243 - i : 5;

        //incr count as we get trints
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}
c0d00336:	b006      	add	sp, #24
c0d00338:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0033a <trits_to_trint>:
        pow3_val /= 3;
    }
}

//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
c0d0033a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0033c:	af03      	add	r7, sp, #12
c0d0033e:	2200      	movs	r2, #0
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d00340:	43d3      	mvns	r3, r2
c0d00342:	b2c9      	uxtb	r1, r1
c0d00344:	31ff      	adds	r1, #255	; 0xff
c0d00346:	b24c      	sxtb	r4, r1
c0d00348:	2c00      	cmp	r4, #0
c0d0034a:	db0f      	blt.n	c0d0036c <trits_to_trint+0x32>
c0d0034c:	1900      	adds	r0, r0, r4
c0d0034e:	2401      	movs	r4, #1
c0d00350:	2200      	movs	r2, #0
    {
        ret += trits[i]*pow3_val;
c0d00352:	b265      	sxtb	r5, r4
        pow3_val *= 3;
c0d00354:	2403      	movs	r4, #3
c0d00356:	436c      	muls	r4, r5
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
    {
        ret += trits[i]*pow3_val;
c0d00358:	7806      	ldrb	r6, [r0, #0]
c0d0035a:	b276      	sxtb	r6, r6
c0d0035c:	436e      	muls	r6, r5
c0d0035e:	b2d2      	uxtb	r2, r2
c0d00360:	18b2      	adds	r2, r6, r2
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d00362:	1e40      	subs	r0, r0, #1
c0d00364:	1e49      	subs	r1, r1, #1
c0d00366:	b249      	sxtb	r1, r1
c0d00368:	4299      	cmp	r1, r3
c0d0036a:	dcf2      	bgt.n	c0d00352 <trits_to_trint+0x18>
    {
        ret += trits[i]*pow3_val;
        pow3_val *= 3;
    }

    return ret;
c0d0036c:	b250      	sxtb	r0, r2
c0d0036e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00370 <specific_49trints_to_243trits>:
        //incr count as we get trints
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
c0d00370:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00372:	af03      	add	r7, sp, #12
c0d00374:	b089      	sub	sp, #36	; 0x24
c0d00376:	460c      	mov	r4, r1
c0d00378:	9001      	str	r0, [sp, #4]
c0d0037a:	2200      	movs	r2, #0
c0d0037c:	9400      	str	r4, [sp, #0]
    for(uint8_t i = 0; i < 48; i++) {
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
c0d0037e:	9801      	ldr	r0, [sp, #4]
c0d00380:	9203      	str	r2, [sp, #12]
c0d00382:	5c82      	ldrb	r2, [r0, r2]
c0d00384:	20ff      	movs	r0, #255	; 0xff
c0d00386:	9005      	str	r0, [sp, #20]
c0d00388:	0600      	lsls	r0, r0, #24
c0d0038a:	9004      	str	r0, [sp, #16]
c0d0038c:	2001      	movs	r0, #1
c0d0038e:	9006      	str	r0, [sp, #24]
c0d00390:	0600      	lsls	r0, r0, #24
c0d00392:	9007      	str	r0, [sp, #28]
c0d00394:	2051      	movs	r0, #81	; 0x51
c0d00396:	2505      	movs	r5, #5
c0d00398:	9402      	str	r4, [sp, #8]
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d0039a:	b2c6      	uxtb	r6, r0
c0d0039c:	b250      	sxtb	r0, r2
c0d0039e:	9008      	str	r0, [sp, #32]
c0d003a0:	0040      	lsls	r0, r0, #1
c0d003a2:	4631      	mov	r1, r6
c0d003a4:	f003 f956 	bl	c0d03654 <__aeabi_idiv>
c0d003a8:	7020      	strb	r0, [r4, #0]


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d003aa:	0602      	lsls	r2, r0, #24
c0d003ac:	9907      	ldr	r1, [sp, #28]
c0d003ae:	428a      	cmp	r2, r1
c0d003b0:	9906      	ldr	r1, [sp, #24]
c0d003b2:	dc03      	bgt.n	c0d003bc <specific_49trints_to_243trits+0x4c>
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d003b4:	9904      	ldr	r1, [sp, #16]
c0d003b6:	428a      	cmp	r2, r1
c0d003b8:	9905      	ldr	r1, [sp, #20]
c0d003ba:	da01      	bge.n	c0d003c0 <specific_49trints_to_243trits+0x50>
c0d003bc:	7021      	strb	r1, [r4, #0]
c0d003be:	e000      	b.n	c0d003c2 <specific_49trints_to_243trits+0x52>

        integ -= trits_r[j] * pow3_val;
c0d003c0:	4601      	mov	r1, r0
c0d003c2:	9a08      	ldr	r2, [sp, #32]
c0d003c4:	b248      	sxtb	r0, r1
c0d003c6:	4370      	muls	r0, r6
c0d003c8:	1a10      	subs	r0, r2, r0
        pow3_val /= 3;
c0d003ca:	9008      	str	r0, [sp, #32]
c0d003cc:	2103      	movs	r1, #3
c0d003ce:	4630      	mov	r0, r6
c0d003d0:	f003 f8b6 	bl	c0d03540 <__aeabi_uidiv>
c0d003d4:	9a08      	ldr	r2, [sp, #32]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d003d6:	1e6d      	subs	r5, r5, #1
c0d003d8:	1c64      	adds	r4, r4, #1
c0d003da:	2d00      	cmp	r5, #0
c0d003dc:	d1dd      	bne.n	c0d0039a <specific_49trints_to_243trits+0x2a>
c0d003de:	9c02      	ldr	r4, [sp, #8]
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
    for(uint8_t i = 0; i < 48; i++) {
c0d003e0:	1d64      	adds	r4, r4, #5
c0d003e2:	9a03      	ldr	r2, [sp, #12]
c0d003e4:	1c52      	adds	r2, r2, #1
c0d003e6:	2a30      	cmp	r2, #48	; 0x30
c0d003e8:	d1c9      	bne.n	c0d0037e <specific_49trints_to_243trits+0xe>
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
c0d003ea:	2030      	movs	r0, #48	; 0x30
c0d003ec:	9901      	ldr	r1, [sp, #4]
c0d003ee:	5c0d      	ldrb	r5, [r1, r0]
c0d003f0:	20ef      	movs	r0, #239	; 0xef
c0d003f2:	43c4      	mvns	r4, r0
c0d003f4:	2009      	movs	r0, #9
c0d003f6:	9406      	str	r4, [sp, #24]
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d003f8:	b2c6      	uxtb	r6, r0
c0d003fa:	b26d      	sxtb	r5, r5
c0d003fc:	0068      	lsls	r0, r5, #1
c0d003fe:	4631      	mov	r1, r6
c0d00400:	f003 f928 	bl	c0d03654 <__aeabi_idiv>
c0d00404:	9906      	ldr	r1, [sp, #24]
c0d00406:	31ef      	adds	r1, #239	; 0xef
c0d00408:	4361      	muls	r1, r4
c0d0040a:	9a00      	ldr	r2, [sp, #0]
c0d0040c:	5450      	strb	r0, [r2, r1]
c0d0040e:	1851      	adds	r1, r2, r1


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d00410:	9108      	str	r1, [sp, #32]
c0d00412:	0603      	lsls	r3, r0, #24
c0d00414:	2101      	movs	r1, #1
c0d00416:	9a07      	ldr	r2, [sp, #28]
c0d00418:	4293      	cmp	r3, r2
c0d0041a:	dc03      	bgt.n	c0d00424 <specific_49trints_to_243trits+0xb4>
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d0041c:	9904      	ldr	r1, [sp, #16]
c0d0041e:	428b      	cmp	r3, r1
c0d00420:	9905      	ldr	r1, [sp, #20]
c0d00422:	da02      	bge.n	c0d0042a <specific_49trints_to_243trits+0xba>
c0d00424:	9808      	ldr	r0, [sp, #32]
c0d00426:	7001      	strb	r1, [r0, #0]
c0d00428:	e000      	b.n	c0d0042c <specific_49trints_to_243trits+0xbc>

        integ -= trits_r[j] * pow3_val;
c0d0042a:	4601      	mov	r1, r0
c0d0042c:	b248      	sxtb	r0, r1
c0d0042e:	4370      	muls	r0, r6
c0d00430:	1a2d      	subs	r5, r5, r0
        pow3_val /= 3;
c0d00432:	2103      	movs	r1, #3
c0d00434:	4630      	mov	r0, r6
c0d00436:	f003 f883 	bl	c0d03540 <__aeabi_uidiv>
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d0043a:	1e64      	subs	r4, r4, #1
c0d0043c:	4621      	mov	r1, r4
c0d0043e:	31f3      	adds	r1, #243	; 0xf3
c0d00440:	d1da      	bne.n	c0d003f8 <specific_49trints_to_243trits+0x88>
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
}
c0d00442:	b009      	add	sp, #36	; 0x24
c0d00444:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00448 <trint_to_trits>:

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
c0d00448:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0044a:	af03      	add	r7, sp, #12
c0d0044c:	b083      	sub	sp, #12
c0d0044e:	9100      	str	r1, [sp, #0]
c0d00450:	4603      	mov	r3, r0
c0d00452:	9201      	str	r2, [sp, #4]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d00454:	2a01      	cmp	r2, #1
c0d00456:	db2b      	blt.n	c0d004b0 <trint_to_trits+0x68>
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
c0d00458:	2009      	movs	r0, #9
c0d0045a:	2151      	movs	r1, #81	; 0x51
c0d0045c:	9a01      	ldr	r2, [sp, #4]
c0d0045e:	2a03      	cmp	r2, #3
c0d00460:	d000      	beq.n	c0d00464 <trint_to_trits+0x1c>
c0d00462:	4608      	mov	r0, r1
c0d00464:	2500      	movs	r5, #0
c0d00466:	462e      	mov	r6, r5
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d00468:	b2c4      	uxtb	r4, r0
c0d0046a:	b258      	sxtb	r0, r3
c0d0046c:	9002      	str	r0, [sp, #8]
c0d0046e:	0040      	lsls	r0, r0, #1
c0d00470:	4621      	mov	r1, r4
c0d00472:	f003 f8ef 	bl	c0d03654 <__aeabi_idiv>
c0d00476:	9900      	ldr	r1, [sp, #0]
c0d00478:	5548      	strb	r0, [r1, r5]
c0d0047a:	194a      	adds	r2, r1, r5


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d0047c:	0603      	lsls	r3, r0, #24
c0d0047e:	2101      	movs	r1, #1
c0d00480:	060d      	lsls	r5, r1, #24
c0d00482:	42ab      	cmp	r3, r5
c0d00484:	dc03      	bgt.n	c0d0048e <trint_to_trits+0x46>
c0d00486:	21ff      	movs	r1, #255	; 0xff
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d00488:	4d0a      	ldr	r5, [pc, #40]	; (c0d004b4 <trint_to_trits+0x6c>)
c0d0048a:	42ab      	cmp	r3, r5
c0d0048c:	dc01      	bgt.n	c0d00492 <trint_to_trits+0x4a>
c0d0048e:	7011      	strb	r1, [r2, #0]
c0d00490:	e000      	b.n	c0d00494 <trint_to_trits+0x4c>

        integ -= trits_r[j] * pow3_val;
c0d00492:	4601      	mov	r1, r0
c0d00494:	9a02      	ldr	r2, [sp, #8]
c0d00496:	b248      	sxtb	r0, r1
c0d00498:	4360      	muls	r0, r4
c0d0049a:	1a15      	subs	r5, r2, r0
        pow3_val /= 3;
c0d0049c:	2103      	movs	r1, #3
c0d0049e:	4620      	mov	r0, r4
c0d004a0:	f003 f84e 	bl	c0d03540 <__aeabi_uidiv>
c0d004a4:	462b      	mov	r3, r5
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d004a6:	1c76      	adds	r6, r6, #1
c0d004a8:	b2f5      	uxtb	r5, r6
c0d004aa:	9901      	ldr	r1, [sp, #4]
c0d004ac:	428d      	cmp	r5, r1
c0d004ae:	dbdb      	blt.n	c0d00468 <trint_to_trits+0x20>
        else if(trits_r[j] < -1) trits_r[j] = -1;

        integ -= trits_r[j] * pow3_val;
        pow3_val /= 3;
    }
}
c0d004b0:	b003      	add	sp, #12
c0d004b2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d004b4:	feffffff 	.word	0xfeffffff

c0d004b8 <get_seed>:
    return ret;
}

void do_nothing() {}

void get_seed(unsigned char *privateKey, uint8_t sz, char *msg) {
c0d004b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004ba:	af03      	add	r7, sp, #12
c0d004bc:	b0e1      	sub	sp, #388	; 0x184
c0d004be:	9201      	str	r2, [sp, #4]
c0d004c0:	460e      	mov	r6, r1
c0d004c2:	4605      	mov	r5, r0

    //kerl requires 424 bytes
    kerl_initialize();
c0d004c4:	9500      	str	r5, [sp, #0]
c0d004c6:	f000 fb59 	bl	c0d00b7c <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d004ca:	f000 fb57 	bl	c0d00b7c <kerl_initialize>
c0d004ce:	ac02      	add	r4, sp, #8

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d004d0:	4620      	mov	r0, r4
c0d004d2:	4629      	mov	r1, r5
c0d004d4:	4632      	mov	r2, r6
c0d004d6:	f003 fab9 	bl	c0d03a4c <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d004da:	19a0      	adds	r0, r4, r6
c0d004dc:	2530      	movs	r5, #48	; 0x30
c0d004de:	1baa      	subs	r2, r5, r6
c0d004e0:	9900      	ldr	r1, [sp, #0]
c0d004e2:	f003 fab3 	bl	c0d03a4c <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d004e6:	4620      	mov	r0, r4
c0d004e8:	4629      	mov	r1, r5
c0d004ea:	f000 fb53 	bl	c0d00b94 <kerl_absorb_bytes>
c0d004ee:	ae3f      	add	r6, sp, #252	; 0xfc
c0d004f0:	2551      	movs	r5, #81	; 0x51
    // A trint_t is 5 trits encoded as 1 int8_t - Used to massively
    // reduce RAM required
    trint_t seed_trints[49];
    // kerl_squeeze_trints(&seed_trints[0], 49);
    {
      tryte_t seed_trytes[81] = {0};
c0d004f2:	4630      	mov	r0, r6
c0d004f4:	4629      	mov	r1, r5
c0d004f6:	f003 faa3 	bl	c0d03a40 <__aeabi_memclr>
c0d004fa:	ac02      	add	r4, sp, #8
      {
        char test_seed[] = "UTVXGSTTZVZFROBJSGHDUZIPQEGXRNAEQPQHAKB9BTSLOJVFBVNWAMSNBXCZLJTHSCOVMPARZEXQJFEXQ";
c0d004fc:	4910      	ldr	r1, [pc, #64]	; (c0d00540 <get_seed+0x88>)
c0d004fe:	4479      	add	r1, pc
c0d00500:	2252      	movs	r2, #82	; 0x52
c0d00502:	4620      	mov	r0, r4
c0d00504:	f003 faa2 	bl	c0d03a4c <__aeabi_memcpy>
        chars_to_trytes(test_seed, seed_trytes, 81);
c0d00508:	4620      	mov	r0, r4
c0d0050a:	4631      	mov	r1, r6
c0d0050c:	462a      	mov	r2, r5
c0d0050e:	f000 f999 	bl	c0d00844 <chars_to_trytes>
c0d00512:	ac02      	add	r4, sp, #8
      }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d00514:	21f3      	movs	r1, #243	; 0xf3
c0d00516:	4620      	mov	r0, r4
c0d00518:	f003 fa92 	bl	c0d03a40 <__aeabi_memclr>
        trytes_to_trits(seed_trytes, seed_trits, 81);
c0d0051c:	4630      	mov	r0, r6
c0d0051e:	4621      	mov	r1, r4
c0d00520:	462a      	mov	r2, r5
c0d00522:	f000 f971 	bl	c0d00808 <trytes_to_trits>
c0d00526:	ad54      	add	r5, sp, #336	; 0x150
        specific_243trits_to_49trints(seed_trits, seed_trints);
c0d00528:	4620      	mov	r0, r4
c0d0052a:	4629      	mov	r1, r5
c0d0052c:	f7ff fec2 	bl	c0d002b4 <specific_243trits_to_49trints>

    //null terminate seed
    //seed_chars[81] = '\0';

    //pass trints to private key func and let it handle the response
    get_private_key(&seed_trints[0], 0, msg);
c0d00530:	2100      	movs	r1, #0
c0d00532:	4628      	mov	r0, r5
c0d00534:	9a01      	ldr	r2, [sp, #4]
c0d00536:	f000 f805 	bl	c0d00544 <get_private_key>
}
c0d0053a:	b061      	add	sp, #388	; 0x184
c0d0053c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0053e:	46c0      	nop			; (mov r8, r8)
c0d00540:	00003706 	.word	0x00003706

c0d00544 <get_private_key>:

//write func to get private key
void get_private_key(trint_t *seed_trints, uint32_t idx, char *msg) {
c0d00544:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00546:	af03      	add	r7, sp, #12
c0d00548:	b0ff      	sub	sp, #508	; 0x1fc
c0d0054a:	b0ff      	sub	sp, #508	; 0x1fc
c0d0054c:	b0f3      	sub	sp, #460	; 0x1cc
    { // localize the memory for private key
        //currently able to store 31 - [-1][-1][-1][0][-1]
        trint_t private_key_trints[49 * 27]; //trints are still just int8_t but encoded

        //generate private key using level 1 for first half
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 1, msg);
c0d0054e:	ab01      	add	r3, sp, #4
c0d00550:	c307      	stmia	r3!, {r0, r1, r2}
c0d00552:	466b      	mov	r3, sp
c0d00554:	601a      	str	r2, [r3, #0]
c0d00556:	ad19      	add	r5, sp, #100	; 0x64
c0d00558:	2601      	movs	r6, #1
c0d0055a:	462a      	mov	r2, r5
c0d0055c:	4633      	mov	r3, r6
c0d0055e:	f7ff fe06 	bl	c0d0016e <generate_private_key_half>
c0d00562:	4c17      	ldr	r4, [pc, #92]	; (c0d005c0 <get_private_key+0x7c>)
c0d00564:	446c      	add	r4, sp
        //use this half to generate half public key 1
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 1);
c0d00566:	4628      	mov	r0, r5
c0d00568:	4621      	mov	r1, r4
c0d0056a:	4632      	mov	r2, r6
c0d0056c:	f7ff fe3c 	bl	c0d001e8 <generate_public_address_half>

        //use level 2 to generate second half of private key
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 2, msg);
c0d00570:	4668      	mov	r0, sp
c0d00572:	9903      	ldr	r1, [sp, #12]
c0d00574:	6001      	str	r1, [r0, #0]
c0d00576:	2602      	movs	r6, #2
c0d00578:	9801      	ldr	r0, [sp, #4]
c0d0057a:	9902      	ldr	r1, [sp, #8]
c0d0057c:	462a      	mov	r2, r5
c0d0057e:	4633      	mov	r3, r6
c0d00580:	f7ff fdf5 	bl	c0d0016e <generate_private_key_half>

        //finally level 2 to generate second half of public key (and then digests both)
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 2);
c0d00584:	4628      	mov	r0, r5
c0d00586:	4621      	mov	r1, r4
c0d00588:	4632      	mov	r2, r6
c0d0058a:	f7ff fe2d 	bl	c0d001e8 <generate_public_address_half>
c0d0058e:	ad19      	add	r5, sp, #100	; 0x64
    }
    // 12s to get here if k=25, 2min otherwise
    //now public key will hold the actual public address
    trit_t pub_trits[243];
    specific_49trints_to_243trits(&public_key_trints[0], &pub_trits[0]);
c0d00590:	4620      	mov	r0, r4
c0d00592:	4629      	mov	r1, r5
c0d00594:	f7ff feec 	bl	c0d00370 <specific_49trints_to_243trits>
c0d00598:	ac04      	add	r4, sp, #16

    tryte_t seed_trytes[81];
    trits_to_trytes(pub_trits, seed_trytes, 243);
c0d0059a:	22f3      	movs	r2, #243	; 0xf3
c0d0059c:	4628      	mov	r0, r5
c0d0059e:	4621      	mov	r1, r4
c0d005a0:	f000 f8fd 	bl	c0d0079e <trits_to_trytes>
c0d005a4:	2551      	movs	r5, #81	; 0x51

    trytes_to_chars(seed_trytes, msg, 81);
c0d005a6:	4620      	mov	r0, r4
c0d005a8:	9c03      	ldr	r4, [sp, #12]
c0d005aa:	4621      	mov	r1, r4
c0d005ac:	462a      	mov	r2, r5
c0d005ae:	f000 f95f 	bl	c0d00870 <trytes_to_chars>

    //null terminate the public key
    msg[81] = '\0';
c0d005b2:	2000      	movs	r0, #0
c0d005b4:	5560      	strb	r0, [r4, r5]
}
c0d005b6:	1ffc      	subs	r4, r7, #7
c0d005b8:	3c05      	subs	r4, #5
c0d005ba:	46a5      	mov	sp, r4
c0d005bc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d005be:	46c0      	nop			; (mov r8, r8)
c0d005c0:	00000590 	.word	0x00000590

c0d005c4 <bigint_add_int>:
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
    return ret;
}

int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
c0d005c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005c6:	af03      	add	r7, sp, #12
c0d005c8:	b087      	sub	sp, #28
c0d005ca:	9105      	str	r1, [sp, #20]
c0d005cc:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d005ce:	2b00      	cmp	r3, #0
c0d005d0:	d03a      	beq.n	c0d00648 <bigint_add_int+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005d2:	2100      	movs	r1, #0
c0d005d4:	43cc      	mvns	r4, r1
c0d005d6:	9400      	str	r4, [sp, #0]
c0d005d8:	460e      	mov	r6, r1
c0d005da:	460c      	mov	r4, r1
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_in[i], val.low, val.hi);
c0d005dc:	9101      	str	r1, [sp, #4]
c0d005de:	9302      	str	r3, [sp, #8]
c0d005e0:	9203      	str	r2, [sp, #12]
c0d005e2:	9b00      	ldr	r3, [sp, #0]
c0d005e4:	460a      	mov	r2, r1
c0d005e6:	4605      	mov	r5, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d005e8:	cd01      	ldmia	r5!, {r0}
c0d005ea:	9504      	str	r5, [sp, #16]
c0d005ec:	9905      	ldr	r1, [sp, #20]
c0d005ee:	1841      	adds	r1, r0, r1
c0d005f0:	4156      	adcs	r6, r2
c0d005f2:	9106      	str	r1, [sp, #24]
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d005f4:	4019      	ands	r1, r3
c0d005f6:	1c49      	adds	r1, r1, #1
c0d005f8:	4615      	mov	r5, r2
c0d005fa:	416d      	adcs	r5, r5
c0d005fc:	2001      	movs	r0, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d005fe:	4004      	ands	r4, r0
c0d00600:	4622      	mov	r2, r4
c0d00602:	2c00      	cmp	r4, #0
c0d00604:	d100      	bne.n	c0d00608 <bigint_add_int+0x44>
c0d00606:	9906      	ldr	r1, [sp, #24]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00608:	4299      	cmp	r1, r3
c0d0060a:	9006      	str	r0, [sp, #24]
c0d0060c:	d800      	bhi.n	c0d00610 <bigint_add_int+0x4c>
c0d0060e:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00610:	2a00      	cmp	r2, #0
c0d00612:	4632      	mov	r2, r6
c0d00614:	d100      	bne.n	c0d00618 <bigint_add_int+0x54>
c0d00616:	4615      	mov	r5, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00618:	2d00      	cmp	r5, #0
c0d0061a:	9e06      	ldr	r6, [sp, #24]
c0d0061c:	d100      	bne.n	c0d00620 <bigint_add_int+0x5c>
c0d0061e:	462e      	mov	r6, r5
c0d00620:	2d00      	cmp	r5, #0
c0d00622:	d000      	beq.n	c0d00626 <bigint_add_int+0x62>
c0d00624:	4630      	mov	r0, r6
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00626:	4310      	orrs	r0, r2
c0d00628:	b2c0      	uxtb	r0, r0
c0d0062a:	2800      	cmp	r0, #0
c0d0062c:	9b02      	ldr	r3, [sp, #8]
c0d0062e:	9a03      	ldr	r2, [sp, #12]
c0d00630:	9c01      	ldr	r4, [sp, #4]
c0d00632:	d100      	bne.n	c0d00636 <bigint_add_int+0x72>
c0d00634:	9006      	str	r0, [sp, #24]
        val = full_add(bigint_in[i], val.low, val.hi);
        bigint_out[i] = val.low;
c0d00636:	c202      	stmia	r2!, {r1}
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00638:	1e5b      	subs	r3, r3, #1
c0d0063a:	9405      	str	r4, [sp, #20]
c0d0063c:	4626      	mov	r6, r4
c0d0063e:	9d06      	ldr	r5, [sp, #24]
c0d00640:	4621      	mov	r1, r4
c0d00642:	462c      	mov	r4, r5
c0d00644:	9804      	ldr	r0, [sp, #16]
c0d00646:	d1ca      	bne.n	c0d005de <bigint_add_int+0x1a>
        bigint_out[i] = val.low;
        val.low = 0;
    }

    if (val.hi) {
        return -1;
c0d00648:	4268      	negs	r0, r5
    }
    return 0;
}
c0d0064a:	b007      	add	sp, #28
c0d0064c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0064e <bigint_add_bigint>:

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d0064e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00650:	af03      	add	r7, sp, #12
c0d00652:	b086      	sub	sp, #24
c0d00654:	461c      	mov	r4, r3
c0d00656:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00658:	2c00      	cmp	r4, #0
c0d0065a:	d034      	beq.n	c0d006c6 <bigint_add_bigint+0x78>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0065c:	2600      	movs	r6, #0
c0d0065e:	43f3      	mvns	r3, r6
c0d00660:	9300      	str	r3, [sp, #0]
c0d00662:	9601      	str	r6, [sp, #4]
c0d00664:	9202      	str	r2, [sp, #8]
c0d00666:	9403      	str	r4, [sp, #12]
c0d00668:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0066a:	cc01      	ldmia	r4!, {r0}
c0d0066c:	9404      	str	r4, [sp, #16]
c0d0066e:	460c      	mov	r4, r1
c0d00670:	cc02      	ldmia	r4!, {r1}
c0d00672:	9405      	str	r4, [sp, #20]
c0d00674:	180a      	adds	r2, r1, r0
c0d00676:	9d01      	ldr	r5, [sp, #4]
c0d00678:	462c      	mov	r4, r5
c0d0067a:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d0067c:	4611      	mov	r1, r2
c0d0067e:	9800      	ldr	r0, [sp, #0]
c0d00680:	4001      	ands	r1, r0
c0d00682:	1c4b      	adds	r3, r1, #1
c0d00684:	4629      	mov	r1, r5
c0d00686:	4149      	adcs	r1, r1
c0d00688:	2501      	movs	r5, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0068a:	402e      	ands	r6, r5
c0d0068c:	2e00      	cmp	r6, #0
c0d0068e:	d100      	bne.n	c0d00692 <bigint_add_bigint+0x44>
c0d00690:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00692:	4283      	cmp	r3, r0
c0d00694:	4628      	mov	r0, r5
c0d00696:	d800      	bhi.n	c0d0069a <bigint_add_bigint+0x4c>
c0d00698:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0069a:	2e00      	cmp	r6, #0
c0d0069c:	9a02      	ldr	r2, [sp, #8]
c0d0069e:	d100      	bne.n	c0d006a2 <bigint_add_bigint+0x54>
c0d006a0:	4621      	mov	r1, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d006a2:	2900      	cmp	r1, #0
c0d006a4:	462e      	mov	r6, r5
c0d006a6:	d100      	bne.n	c0d006aa <bigint_add_bigint+0x5c>
c0d006a8:	460e      	mov	r6, r1
c0d006aa:	2900      	cmp	r1, #0
c0d006ac:	d000      	beq.n	c0d006b0 <bigint_add_bigint+0x62>
c0d006ae:	4630      	mov	r0, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d006b0:	4320      	orrs	r0, r4

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d006b2:	2800      	cmp	r0, #0
c0d006b4:	9905      	ldr	r1, [sp, #20]
c0d006b6:	d100      	bne.n	c0d006ba <bigint_add_bigint+0x6c>
c0d006b8:	4605      	mov	r5, r0
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d006ba:	c208      	stmia	r2!, {r3}
c0d006bc:	9c03      	ldr	r4, [sp, #12]

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d006be:	1e64      	subs	r4, r4, #1
c0d006c0:	462e      	mov	r6, r5
c0d006c2:	9804      	ldr	r0, [sp, #16]
c0d006c4:	d1ce      	bne.n	c0d00664 <bigint_add_bigint+0x16>
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }

    if (val.hi) {
        return -1;
c0d006c6:	4268      	negs	r0, r5
    }
    return 0;
}
c0d006c8:	b006      	add	sp, #24
c0d006ca:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d006cc <bigint_sub_bigint>:

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d006cc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006ce:	af03      	add	r7, sp, #12
c0d006d0:	b087      	sub	sp, #28
c0d006d2:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d006d4:	2d00      	cmp	r5, #0
c0d006d6:	d037      	beq.n	c0d00748 <bigint_sub_bigint+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d006d8:	2400      	movs	r4, #0
c0d006da:	9402      	str	r4, [sp, #8]
c0d006dc:	43e3      	mvns	r3, r4
c0d006de:	9301      	str	r3, [sp, #4]
c0d006e0:	2601      	movs	r6, #1
c0d006e2:	9600      	str	r6, [sp, #0]
c0d006e4:	9203      	str	r2, [sp, #12]
c0d006e6:	9504      	str	r5, [sp, #16]
c0d006e8:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d006ea:	cc01      	ldmia	r4!, {r0}
c0d006ec:	9405      	str	r4, [sp, #20]
c0d006ee:	460c      	mov	r4, r1
int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d006f0:	cc02      	ldmia	r4!, {r1}
c0d006f2:	9406      	str	r4, [sp, #24]
c0d006f4:	43c9      	mvns	r1, r1
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d006f6:	180a      	adds	r2, r1, r0
c0d006f8:	9902      	ldr	r1, [sp, #8]
c0d006fa:	460c      	mov	r4, r1
c0d006fc:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d006fe:	4610      	mov	r0, r2
c0d00700:	9d01      	ldr	r5, [sp, #4]
c0d00702:	4028      	ands	r0, r5
c0d00704:	1c43      	adds	r3, r0, #1
c0d00706:	4608      	mov	r0, r1
c0d00708:	4140      	adcs	r0, r0
c0d0070a:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0070c:	400e      	ands	r6, r1
c0d0070e:	2e00      	cmp	r6, #0
c0d00710:	d100      	bne.n	c0d00714 <bigint_sub_bigint+0x48>
c0d00712:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00714:	42ab      	cmp	r3, r5
c0d00716:	460d      	mov	r5, r1
c0d00718:	d800      	bhi.n	c0d0071c <bigint_sub_bigint+0x50>
c0d0071a:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0071c:	2e00      	cmp	r6, #0
c0d0071e:	9a03      	ldr	r2, [sp, #12]
c0d00720:	d100      	bne.n	c0d00724 <bigint_sub_bigint+0x58>
c0d00722:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00724:	2800      	cmp	r0, #0
c0d00726:	460e      	mov	r6, r1
c0d00728:	d100      	bne.n	c0d0072c <bigint_sub_bigint+0x60>
c0d0072a:	4606      	mov	r6, r0
c0d0072c:	2800      	cmp	r0, #0
c0d0072e:	d000      	beq.n	c0d00732 <bigint_sub_bigint+0x66>
c0d00730:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d00732:	4325      	orrs	r5, r4

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00734:	2d00      	cmp	r5, #0
c0d00736:	460e      	mov	r6, r1
c0d00738:	9805      	ldr	r0, [sp, #20]
c0d0073a:	d100      	bne.n	c0d0073e <bigint_sub_bigint+0x72>
c0d0073c:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d0073e:	c208      	stmia	r2!, {r3}
c0d00740:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00742:	1e6d      	subs	r5, r5, #1
c0d00744:	9906      	ldr	r1, [sp, #24]
c0d00746:	d1cd      	bne.n	c0d006e4 <bigint_sub_bigint+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d00748:	2000      	movs	r0, #0
c0d0074a:	b007      	add	sp, #28
c0d0074c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0074e <bigint_cmp_bigint>:
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
c0d0074e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00750:	af03      	add	r7, sp, #12
c0d00752:	b081      	sub	sp, #4
c0d00754:	2400      	movs	r4, #0
c0d00756:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d00758:	32ff      	adds	r2, #255	; 0xff
c0d0075a:	b253      	sxtb	r3, r2
c0d0075c:	2b00      	cmp	r3, #0
c0d0075e:	db0f      	blt.n	c0d00780 <bigint_cmp_bigint+0x32>
c0d00760:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d00762:	009b      	lsls	r3, r3, #2
c0d00764:	58ce      	ldr	r6, [r1, r3]
c0d00766:	58c4      	ldr	r4, [r0, r3]
c0d00768:	2301      	movs	r3, #1
c0d0076a:	42b4      	cmp	r4, r6
c0d0076c:	dc0b      	bgt.n	c0d00786 <bigint_cmp_bigint+0x38>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d0076e:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d00770:	42b4      	cmp	r4, r6
c0d00772:	db07      	blt.n	c0d00784 <bigint_cmp_bigint+0x36>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00774:	b253      	sxtb	r3, r2
c0d00776:	42ab      	cmp	r3, r5
c0d00778:	461a      	mov	r2, r3
c0d0077a:	dcf2      	bgt.n	c0d00762 <bigint_cmp_bigint+0x14>
c0d0077c:	9b00      	ldr	r3, [sp, #0]
c0d0077e:	e002      	b.n	c0d00786 <bigint_cmp_bigint+0x38>
c0d00780:	4623      	mov	r3, r4
c0d00782:	e000      	b.n	c0d00786 <bigint_cmp_bigint+0x38>
c0d00784:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d00786:	4618      	mov	r0, r3
c0d00788:	b001      	add	sp, #4
c0d0078a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0078c <bigint_not>:

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0078c:	2900      	cmp	r1, #0
c0d0078e:	d004      	beq.n	c0d0079a <bigint_not+0xe>
        bigint[i] = ~bigint[i];
c0d00790:	6802      	ldr	r2, [r0, #0]
c0d00792:	43d2      	mvns	r2, r2
c0d00794:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00796:	1e49      	subs	r1, r1, #1
c0d00798:	d1fa      	bne.n	c0d00790 <bigint_not+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d0079a:	2000      	movs	r0, #0
c0d0079c:	4770      	bx	lr

c0d0079e <trits_to_trytes>:

static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";


int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len)
{
c0d0079e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007a0:	af03      	add	r7, sp, #12
c0d007a2:	b083      	sub	sp, #12
c0d007a4:	4616      	mov	r6, r2
c0d007a6:	460c      	mov	r4, r1
c0d007a8:	4605      	mov	r5, r0
    if (trit_len % 3 != 0) {
c0d007aa:	2103      	movs	r1, #3
c0d007ac:	4630      	mov	r0, r6
c0d007ae:	f002 ff4d 	bl	c0d0364c <__aeabi_uidivmod>
c0d007b2:	2000      	movs	r0, #0
c0d007b4:	43c2      	mvns	r2, r0
c0d007b6:	2900      	cmp	r1, #0
c0d007b8:	d123      	bne.n	c0d00802 <trits_to_trytes+0x64>
c0d007ba:	9502      	str	r5, [sp, #8]
c0d007bc:	4635      	mov	r5, r6
c0d007be:	2603      	movs	r6, #3
c0d007c0:	9001      	str	r0, [sp, #4]
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;
c0d007c2:	4628      	mov	r0, r5
c0d007c4:	4631      	mov	r1, r6
c0d007c6:	f002 febb 	bl	c0d03540 <__aeabi_uidiv>

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d007ca:	2d03      	cmp	r5, #3
c0d007cc:	9a01      	ldr	r2, [sp, #4]
c0d007ce:	d318      	bcc.n	c0d00802 <trits_to_trytes+0x64>
c0d007d0:	2200      	movs	r2, #0
c0d007d2:	9200      	str	r2, [sp, #0]
c0d007d4:	9601      	str	r6, [sp, #4]
c0d007d6:	9e01      	ldr	r6, [sp, #4]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
c0d007d8:	4633      	mov	r3, r6
c0d007da:	4353      	muls	r3, r2
c0d007dc:	4625      	mov	r5, r4
c0d007de:	9902      	ldr	r1, [sp, #8]
c0d007e0:	5ccc      	ldrb	r4, [r1, r3]
c0d007e2:	18cb      	adds	r3, r1, r3
c0d007e4:	2101      	movs	r1, #1
c0d007e6:	5659      	ldrsb	r1, [r3, r1]
c0d007e8:	4371      	muls	r1, r6
c0d007ea:	1909      	adds	r1, r1, r4
c0d007ec:	2402      	movs	r4, #2
c0d007ee:	571b      	ldrsb	r3, [r3, r4]
c0d007f0:	2409      	movs	r4, #9
c0d007f2:	435c      	muls	r4, r3
c0d007f4:	1909      	adds	r1, r1, r4
c0d007f6:	462c      	mov	r4, r5
c0d007f8:	54a1      	strb	r1, [r4, r2]
    if (trit_len % 3 != 0) {
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d007fa:	1c52      	adds	r2, r2, #1
c0d007fc:	4282      	cmp	r2, r0
c0d007fe:	d3eb      	bcc.n	c0d007d8 <trits_to_trytes+0x3a>
c0d00800:	9a00      	ldr	r2, [sp, #0]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
    }
    return 0;
}
c0d00802:	4610      	mov	r0, r2
c0d00804:	b003      	add	sp, #12
c0d00806:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00808 <trytes_to_trits>:

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
c0d00808:	b5b0      	push	{r4, r5, r7, lr}
c0d0080a:	af02      	add	r7, sp, #8
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d0080c:	2a00      	cmp	r2, #0
c0d0080e:	d015      	beq.n	c0d0083c <trytes_to_trits+0x34>
c0d00810:	4b0b      	ldr	r3, [pc, #44]	; (c0d00840 <trytes_to_trits+0x38>)
c0d00812:	447b      	add	r3, pc
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00814:	240d      	movs	r4, #13
c0d00816:	0624      	lsls	r4, r4, #24
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
c0d00818:	7805      	ldrb	r5, [r0, #0]
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d0081a:	062d      	lsls	r5, r5, #24
c0d0081c:	192c      	adds	r4, r5, r4
c0d0081e:	1624      	asrs	r4, r4, #24
c0d00820:	2503      	movs	r5, #3
c0d00822:	4365      	muls	r5, r4
c0d00824:	5d5c      	ldrb	r4, [r3, r5]
c0d00826:	700c      	strb	r4, [r1, #0]
c0d00828:	195c      	adds	r4, r3, r5
        trits_out[i*3+1] = trits_mapping[idx][1];
c0d0082a:	7865      	ldrb	r5, [r4, #1]
c0d0082c:	704d      	strb	r5, [r1, #1]
        trits_out[i*3+2] = trits_mapping[idx][2];
c0d0082e:	78a4      	ldrb	r4, [r4, #2]
c0d00830:	708c      	strb	r4, [r1, #2]
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00832:	1e52      	subs	r2, r2, #1
c0d00834:	1cc9      	adds	r1, r1, #3
c0d00836:	1c40      	adds	r0, r0, #1
c0d00838:	2a00      	cmp	r2, #0
c0d0083a:	d1eb      	bne.n	c0d00814 <trytes_to_trits+0xc>
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
c0d0083c:	2000      	movs	r0, #0
c0d0083e:	bdb0      	pop	{r4, r5, r7, pc}
c0d00840:	00003446 	.word	0x00003446

c0d00844 <chars_to_trytes>:
    }
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
c0d00844:	b5d0      	push	{r4, r6, r7, lr}
c0d00846:	af02      	add	r7, sp, #8
c0d00848:	e00e      	b.n	c0d00868 <chars_to_trytes+0x24>
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
c0d0084a:	7803      	ldrb	r3, [r0, #0]
c0d0084c:	b25b      	sxtb	r3, r3
c0d0084e:	2400      	movs	r4, #0
c0d00850:	2b39      	cmp	r3, #57	; 0x39
c0d00852:	d005      	beq.n	c0d00860 <chars_to_trytes+0x1c>
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
c0d00854:	2b4e      	cmp	r3, #78	; 0x4e
c0d00856:	db01      	blt.n	c0d0085c <chars_to_trytes+0x18>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
c0d00858:	33a5      	adds	r3, #165	; 0xa5
c0d0085a:	e000      	b.n	c0d0085e <chars_to_trytes+0x1a>
c0d0085c:	33c0      	adds	r3, #192	; 0xc0
c0d0085e:	461c      	mov	r4, r3
c0d00860:	700c      	strb	r4, [r1, #0]
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00862:	1e52      	subs	r2, r2, #1
c0d00864:	1c40      	adds	r0, r0, #1
c0d00866:	1c49      	adds	r1, r1, #1
c0d00868:	2a00      	cmp	r2, #0
c0d0086a:	d1ee      	bne.n	c0d0084a <chars_to_trytes+0x6>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
c0d0086c:	2000      	movs	r0, #0
c0d0086e:	bdd0      	pop	{r4, r6, r7, pc}

c0d00870 <trytes_to_chars>:
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
c0d00870:	b5d0      	push	{r4, r6, r7, lr}
c0d00872:	af02      	add	r7, sp, #8
    for (uint16_t i = 0; i < len; i++) {
c0d00874:	2a00      	cmp	r2, #0
c0d00876:	d00a      	beq.n	c0d0088e <trytes_to_chars+0x1e>
c0d00878:	a306      	add	r3, pc, #24	; (adr r3, c0d00894 <tryte_to_char_mapping>)
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
c0d0087a:	7804      	ldrb	r4, [r0, #0]
c0d0087c:	b264      	sxtb	r4, r4
c0d0087e:	191c      	adds	r4, r3, r4
c0d00880:	7b64      	ldrb	r4, [r4, #13]
c0d00882:	700c      	strb	r4, [r1, #0]
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
    for (uint16_t i = 0; i < len; i++) {
c0d00884:	1e52      	subs	r2, r2, #1
c0d00886:	1c40      	adds	r0, r0, #1
c0d00888:	1c49      	adds	r1, r1, #1
c0d0088a:	2a00      	cmp	r2, #0
c0d0088c:	d1f5      	bne.n	c0d0087a <trytes_to_chars+0xa>
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
    }

    return 0;
c0d0088e:	2000      	movs	r0, #0
c0d00890:	bdd0      	pop	{r4, r6, r7, pc}
c0d00892:	46c0      	nop			; (mov r8, r8)

c0d00894 <tryte_to_char_mapping>:
c0d00894:	51504f4e 	.word	0x51504f4e
c0d00898:	55545352 	.word	0x55545352
c0d0089c:	59585756 	.word	0x59585756
c0d008a0:	4241395a 	.word	0x4241395a
c0d008a4:	46454443 	.word	0x46454443
c0d008a8:	4a494847 	.word	0x4a494847
c0d008ac:	004d4c4b 	.word	0x004d4c4b

c0d008b0 <words_to_bytes>:
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
c0d008b0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d008b2:	af03      	add	r7, sp, #12
c0d008b4:	b082      	sub	sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d008b6:	2a00      	cmp	r2, #0
c0d008b8:	d01a      	beq.n	c0d008f0 <words_to_bytes+0x40>
c0d008ba:	0093      	lsls	r3, r2, #2
c0d008bc:	18c0      	adds	r0, r0, r3
c0d008be:	1f00      	subs	r0, r0, #4
c0d008c0:	2303      	movs	r3, #3
c0d008c2:	43db      	mvns	r3, r3
c0d008c4:	9301      	str	r3, [sp, #4]
c0d008c6:	4252      	negs	r2, r2
c0d008c8:	9200      	str	r2, [sp, #0]
c0d008ca:	2400      	movs	r4, #0
        bytes_out[i*4+0] = (words_in[word_len-1-i] >> 24);
c0d008cc:	9d01      	ldr	r5, [sp, #4]
c0d008ce:	4365      	muls	r5, r4
c0d008d0:	00a6      	lsls	r6, r4, #2
c0d008d2:	1983      	adds	r3, r0, r6
c0d008d4:	78da      	ldrb	r2, [r3, #3]
c0d008d6:	554a      	strb	r2, [r1, r5]
c0d008d8:	194a      	adds	r2, r1, r5
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
c0d008da:	885b      	ldrh	r3, [r3, #2]
c0d008dc:	7053      	strb	r3, [r2, #1]
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
c0d008de:	5983      	ldr	r3, [r0, r6]
c0d008e0:	0a1b      	lsrs	r3, r3, #8
c0d008e2:	7093      	strb	r3, [r2, #2]
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
c0d008e4:	5983      	ldr	r3, [r0, r6]
c0d008e6:	70d3      	strb	r3, [r2, #3]
    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d008e8:	1e64      	subs	r4, r4, #1
c0d008ea:	9a00      	ldr	r2, [sp, #0]
c0d008ec:	42a2      	cmp	r2, r4
c0d008ee:	d1ed      	bne.n	c0d008cc <words_to_bytes+0x1c>
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
    }

    return 0;
c0d008f0:	2000      	movs	r0, #0
c0d008f2:	b002      	add	sp, #8
c0d008f4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d008f6 <bytes_to_words>:
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
c0d008f6:	b5d0      	push	{r4, r6, r7, lr}
c0d008f8:	af02      	add	r7, sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d008fa:	2a00      	cmp	r2, #0
c0d008fc:	d015      	beq.n	c0d0092a <bytes_to_words+0x34>
c0d008fe:	0093      	lsls	r3, r2, #2
c0d00900:	18c0      	adds	r0, r0, r3
c0d00902:	1f00      	subs	r0, r0, #4
c0d00904:	2300      	movs	r3, #0
        words_out[i] = 0;
c0d00906:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
c0d00908:	7803      	ldrb	r3, [r0, #0]
c0d0090a:	061b      	lsls	r3, r3, #24
c0d0090c:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
c0d0090e:	7844      	ldrb	r4, [r0, #1]
c0d00910:	0424      	lsls	r4, r4, #16
c0d00912:	431c      	orrs	r4, r3
c0d00914:	600c      	str	r4, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
c0d00916:	7883      	ldrb	r3, [r0, #2]
c0d00918:	021b      	lsls	r3, r3, #8
c0d0091a:	4323      	orrs	r3, r4
c0d0091c:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
c0d0091e:	78c4      	ldrb	r4, [r0, #3]
c0d00920:	431c      	orrs	r4, r3
c0d00922:	c110      	stmia	r1!, {r4}
    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d00924:	1f00      	subs	r0, r0, #4
c0d00926:	1e52      	subs	r2, r2, #1
c0d00928:	d1ec      	bne.n	c0d00904 <bytes_to_words+0xe>
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
    }
    return 0;
c0d0092a:	2000      	movs	r0, #0
c0d0092c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d00930 <trints_to_words>:
}

//custom conversion straight from trints to words
int trints_to_words(trint_t *trints_in, int32_t words_out[])
{
c0d00930:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00932:	af03      	add	r7, sp, #12
c0d00934:	b0a1      	sub	sp, #132	; 0x84
c0d00936:	9101      	str	r1, [sp, #4]
c0d00938:	9002      	str	r0, [sp, #8]
c0d0093a:	a814      	add	r0, sp, #80	; 0x50
    int32_t base[13] = {0};
c0d0093c:	2134      	movs	r1, #52	; 0x34
c0d0093e:	f003 f87f 	bl	c0d03a40 <__aeabi_memclr>
c0d00942:	2430      	movs	r4, #48	; 0x30
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
c0d00944:	2603      	movs	r6, #3
c0d00946:	2005      	movs	r0, #5
c0d00948:	2c30      	cmp	r4, #48	; 0x30
c0d0094a:	d000      	beq.n	c0d0094e <trints_to_words+0x1e>
c0d0094c:	4606      	mov	r6, r0
        trint_to_trits(trints_in[x], &trits[0], get);
c0d0094e:	9802      	ldr	r0, [sp, #8]
c0d00950:	5700      	ldrsb	r0, [r0, r4]
c0d00952:	a912      	add	r1, sp, #72	; 0x48
c0d00954:	4632      	mov	r2, r6
c0d00956:	f7ff fd77 	bl	c0d00448 <trint_to_trits>
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d0095a:	4833      	ldr	r0, [pc, #204]	; (c0d00a28 <trints_to_words+0xf8>)
c0d0095c:	1832      	adds	r2, r6, r0
c0d0095e:	2006      	movs	r0, #6
c0d00960:	4010      	ands	r0, r2
            // multiply
            {
                int32_t sz = size;
                int32_t carry = 0;
                
                for (int32_t j = 0; j < sz; j++) {
c0d00962:	1e76      	subs	r6, r6, #1
c0d00964:	9403      	str	r4, [sp, #12]
            
            // add
            {
                int32_t tmp[12];
                // Ignore the last trit (48 is last trint, 2 is last trit in that trint)
                if (x == 48 & i == 2) {
c0d00966:	2c30      	cmp	r4, #48	; 0x30
c0d00968:	9204      	str	r2, [sp, #16]
c0d0096a:	d105      	bne.n	c0d00978 <trints_to_words+0x48>
c0d0096c:	b2b1      	uxth	r1, r6
c0d0096e:	2902      	cmp	r1, #2
c0d00970:	d102      	bne.n	c0d00978 <trints_to_words+0x48>
c0d00972:	a814      	add	r0, sp, #80	; 0x50
                    bigint_add_int(base, 1, tmp, 13);
c0d00974:	2101      	movs	r1, #1
c0d00976:	e003      	b.n	c0d00980 <trints_to_words+0x50>
c0d00978:	a912      	add	r1, sp, #72	; 0x48
                } else {
                    bigint_add_int(base, trits[i]+1, tmp, 13);
c0d0097a:	5608      	ldrsb	r0, [r1, r0]
c0d0097c:	1c41      	adds	r1, r0, #1
c0d0097e:	a814      	add	r0, sp, #80	; 0x50
c0d00980:	aa05      	add	r2, sp, #20
c0d00982:	230d      	movs	r3, #13
c0d00984:	f7ff fe1e 	bl	c0d005c4 <bigint_add_int>
c0d00988:	a805      	add	r0, sp, #20
c0d0098a:	a914      	add	r1, sp, #80	; 0x50
                }
                memcpy(base, tmp, 52);
c0d0098c:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d0098e:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00990:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00992:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00994:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00996:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00998:	c83c      	ldmia	r0!, {r2, r3, r4, r5}
c0d0099a:	c13c      	stmia	r1!, {r2, r3, r4, r5}
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
        trint_to_trits(trints_in[x], &trits[0], get);
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d0099c:	1e76      	subs	r6, r6, #1
c0d0099e:	9804      	ldr	r0, [sp, #16]
c0d009a0:	1e40      	subs	r0, r0, #1
c0d009a2:	b200      	sxth	r0, r0
c0d009a4:	2800      	cmp	r0, #0
c0d009a6:	4602      	mov	r2, r0
c0d009a8:	9c03      	ldr	r4, [sp, #12]
c0d009aa:	dadc      	bge.n	c0d00966 <trints_to_words+0x36>
    int32_t size = 13;
    trit_t trits[5]; // on final call only left 3 trits matter
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
c0d009ac:	1e60      	subs	r0, r4, #1
c0d009ae:	2c00      	cmp	r4, #0
c0d009b0:	4604      	mov	r4, r0
c0d009b2:	dcc7      	bgt.n	c0d00944 <trints_to_words+0x14>
                // todo sz>size stuff
            }
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
c0d009b4:	481d      	ldr	r0, [pc, #116]	; (c0d00a2c <trints_to_words+0xfc>)
c0d009b6:	4478      	add	r0, pc
c0d009b8:	a914      	add	r1, sp, #80	; 0x50
c0d009ba:	220d      	movs	r2, #13
c0d009bc:	f7ff fec7 	bl	c0d0074e <bigint_cmp_bigint>
c0d009c0:	2801      	cmp	r0, #1
c0d009c2:	db14      	blt.n	c0d009ee <trints_to_words+0xbe>
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d009c4:	481b      	ldr	r0, [pc, #108]	; (c0d00a34 <trints_to_words+0x104>)
c0d009c6:	4478      	add	r0, pc
c0d009c8:	ad14      	add	r5, sp, #80	; 0x50
c0d009ca:	ac05      	add	r4, sp, #20
c0d009cc:	260d      	movs	r6, #13
c0d009ce:	4629      	mov	r1, r5
c0d009d0:	4622      	mov	r2, r4
c0d009d2:	4633      	mov	r3, r6
c0d009d4:	f7ff fe7a 	bl	c0d006cc <bigint_sub_bigint>
        bigint_not(tmp, 13);
c0d009d8:	4620      	mov	r0, r4
c0d009da:	4631      	mov	r1, r6
c0d009dc:	f7ff fed6 	bl	c0d0078c <bigint_not>
        bigint_add_int(tmp, 1, base, 13);
c0d009e0:	2101      	movs	r1, #1
c0d009e2:	4620      	mov	r0, r4
c0d009e4:	462a      	mov	r2, r5
c0d009e6:	4633      	mov	r3, r6
c0d009e8:	f7ff fdec 	bl	c0d005c4 <bigint_add_int>
c0d009ec:	e010      	b.n	c0d00a10 <trints_to_words+0xe0>
c0d009ee:	ad14      	add	r5, sp, #80	; 0x50
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
c0d009f0:	490f      	ldr	r1, [pc, #60]	; (c0d00a30 <trints_to_words+0x100>)
c0d009f2:	4479      	add	r1, pc
c0d009f4:	ae05      	add	r6, sp, #20
c0d009f6:	230d      	movs	r3, #13
c0d009f8:	4628      	mov	r0, r5
c0d009fa:	4632      	mov	r2, r6
c0d009fc:	f7ff fe66 	bl	c0d006cc <bigint_sub_bigint>
        memcpy(base, tmp, 52);
c0d00a00:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d00a02:	c507      	stmia	r5!, {r0, r1, r2}
c0d00a04:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d00a06:	c507      	stmia	r5!, {r0, r1, r2}
c0d00a08:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d00a0a:	c507      	stmia	r5!, {r0, r1, r2}
c0d00a0c:	ce0f      	ldmia	r6!, {r0, r1, r2, r3}
c0d00a0e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d00a10:	a814      	add	r0, sp, #80	; 0x50
c0d00a12:	9d01      	ldr	r5, [sp, #4]
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }
    
    
    memcpy(words_out, base, 48);
c0d00a14:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00a16:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00a18:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00a1a:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00a1c:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00a1e:	c51e      	stmia	r5!, {r1, r2, r3, r4}
    return 0;
c0d00a20:	2000      	movs	r0, #0
c0d00a22:	b021      	add	sp, #132	; 0x84
c0d00a24:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00a26:	46c0      	nop			; (mov r8, r8)
c0d00a28:	0000ffff 	.word	0x0000ffff
c0d00a2c:	000032f6 	.word	0x000032f6
c0d00a30:	000032ba 	.word	0x000032ba
c0d00a34:	000032e6 	.word	0x000032e6

c0d00a38 <words_to_trints>:
}

//straight from words into trints
int words_to_trints(const int32_t words_in[], trint_t *trints_out)
{
c0d00a38:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a3a:	af03      	add	r7, sp, #12
c0d00a3c:	b0a5      	sub	sp, #148	; 0x94
c0d00a3e:	9100      	str	r1, [sp, #0]
c0d00a40:	4604      	mov	r4, r0
    int32_t base[13] = {0};
c0d00a42:	9408      	str	r4, [sp, #32]
c0d00a44:	a818      	add	r0, sp, #96	; 0x60
c0d00a46:	2134      	movs	r1, #52	; 0x34
c0d00a48:	f002 fffa 	bl	c0d03a40 <__aeabi_memclr>
c0d00a4c:	2500      	movs	r5, #0
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
c0d00a4e:	9517      	str	r5, [sp, #92]	; 0x5c
c0d00a50:	a80b      	add	r0, sp, #44	; 0x2c
c0d00a52:	4621      	mov	r1, r4
c0d00a54:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d00a56:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00a58:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d00a5a:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00a5c:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d00a5e:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00a60:	20fe      	movs	r0, #254	; 0xfe
c0d00a62:	43c1      	mvns	r1, r0
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
c0d00a64:	9808      	ldr	r0, [sp, #32]
c0d00a66:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d00a68:	2800      	cmp	r0, #0
c0d00a6a:	9103      	str	r1, [sp, #12]
c0d00a6c:	db08      	blt.n	c0d00a80 <words_to_trints+0x48>
c0d00a6e:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
c0d00a70:	4941      	ldr	r1, [pc, #260]	; (c0d00b78 <words_to_trints+0x140>)
c0d00a72:	4479      	add	r1, pc
c0d00a74:	aa18      	add	r2, sp, #96	; 0x60
c0d00a76:	230d      	movs	r3, #13
c0d00a78:	f7ff fde9 	bl	c0d0064e <bigint_add_bigint>
c0d00a7c:	9502      	str	r5, [sp, #8]
c0d00a7e:	e01b      	b.n	c0d00ab8 <words_to_trints+0x80>
c0d00a80:	9501      	str	r5, [sp, #4]
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
c0d00a82:	4608      	mov	r0, r1
c0d00a84:	30fe      	adds	r0, #254	; 0xfe
c0d00a86:	9017      	str	r0, [sp, #92]	; 0x5c
c0d00a88:	ad0b      	add	r5, sp, #44	; 0x2c
c0d00a8a:	260d      	movs	r6, #13
        bigint_not(tmp, 13);
c0d00a8c:	4628      	mov	r0, r5
c0d00a8e:	4631      	mov	r1, r6
c0d00a90:	f7ff fe7c 	bl	c0d0078c <bigint_not>
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
c0d00a94:	4935      	ldr	r1, [pc, #212]	; (c0d00b6c <words_to_trints+0x134>)
c0d00a96:	4479      	add	r1, pc
c0d00a98:	4628      	mov	r0, r5
c0d00a9a:	4632      	mov	r2, r6
c0d00a9c:	f7ff fe57 	bl	c0d0074e <bigint_cmp_bigint>
c0d00aa0:	2801      	cmp	r0, #1
c0d00aa2:	db49      	blt.n	c0d00b38 <words_to_trints+0x100>
c0d00aa4:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(tmp, HALF_3, base, 13);
c0d00aa6:	4932      	ldr	r1, [pc, #200]	; (c0d00b70 <words_to_trints+0x138>)
c0d00aa8:	4479      	add	r1, pc
c0d00aaa:	aa18      	add	r2, sp, #96	; 0x60
c0d00aac:	230d      	movs	r3, #13
c0d00aae:	f7ff fe0d 	bl	c0d006cc <bigint_sub_bigint>
c0d00ab2:	2001      	movs	r0, #1
c0d00ab4:	9002      	str	r0, [sp, #8]
c0d00ab6:	9d01      	ldr	r5, [sp, #4]
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
c0d00ab8:	2403      	movs	r4, #3
c0d00aba:	2005      	movs	r0, #5
c0d00abc:	9501      	str	r5, [sp, #4]
c0d00abe:	2d30      	cmp	r5, #48	; 0x30
c0d00ac0:	d000      	beq.n	c0d00ac4 <words_to_trints+0x8c>
c0d00ac2:	4604      	mov	r4, r0
c0d00ac4:	a809      	add	r0, sp, #36	; 0x24
        trits_to_trint(&trits[0], send);
c0d00ac6:	4621      	mov	r1, r4
c0d00ac8:	f7ff fc37 	bl	c0d0033a <trits_to_trint>
c0d00acc:	2000      	movs	r0, #0
c0d00ace:	4601      	mov	r1, r0
c0d00ad0:	9004      	str	r0, [sp, #16]
c0d00ad2:	9405      	str	r4, [sp, #20]
c0d00ad4:	9106      	str	r1, [sp, #24]
c0d00ad6:	9007      	str	r0, [sp, #28]
c0d00ad8:	250c      	movs	r5, #12
c0d00ada:	9a04      	ldr	r2, [sp, #16]
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
                uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
c0d00adc:	00a9      	lsls	r1, r5, #2
c0d00ade:	ac18      	add	r4, sp, #96	; 0x60
c0d00ae0:	5860      	ldr	r0, [r4, r1]
c0d00ae2:	2a00      	cmp	r2, #0
c0d00ae4:	9108      	str	r1, [sp, #32]
c0d00ae6:	2603      	movs	r6, #3
c0d00ae8:	2300      	movs	r3, #0
                uint64_t q = (lhs / 3) & 0xFFFFFFFF;
                uint8_t r = lhs % 3;
c0d00aea:	4611      	mov	r1, r2
c0d00aec:	4632      	mov	r2, r6
c0d00aee:	f002 fe9d 	bl	c0d0382c <__aeabi_uldivmod>
                
                base[j] = q;
c0d00af2:	9908      	ldr	r1, [sp, #32]
c0d00af4:	5060      	str	r0, [r4, r1]
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
c0d00af6:	1e68      	subs	r0, r5, #1
c0d00af8:	2d00      	cmp	r5, #0
c0d00afa:	4605      	mov	r5, r0
c0d00afc:	dcee      	bgt.n	c0d00adc <words_to_trints+0xa4>
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
            if (flip_trits) {
                trits[i] = -trits[i];
c0d00afe:	9803      	ldr	r0, [sp, #12]
c0d00b00:	1a80      	subs	r0, r0, r2
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d00b02:	32ff      	adds	r2, #255	; 0xff
            if (flip_trits) {
c0d00b04:	9902      	ldr	r1, [sp, #8]
c0d00b06:	2900      	cmp	r1, #0
c0d00b08:	d100      	bne.n	c0d00b0c <words_to_trints+0xd4>
c0d00b0a:	4610      	mov	r0, r2
c0d00b0c:	a909      	add	r1, sp, #36	; 0x24
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d00b0e:	9a06      	ldr	r2, [sp, #24]
c0d00b10:	5488      	strb	r0, [r1, r2]
c0d00b12:	9807      	ldr	r0, [sp, #28]
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
c0d00b14:	1c40      	adds	r0, r0, #1
c0d00b16:	b201      	sxth	r1, r0
c0d00b18:	9c05      	ldr	r4, [sp, #20]
c0d00b1a:	42a1      	cmp	r1, r4
c0d00b1c:	dbda      	blt.n	c0d00ad4 <words_to_trints+0x9c>
c0d00b1e:	a809      	add	r0, sp, #36	; 0x24
            if (flip_trits) {
                trits[i] = -trits[i];
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
c0d00b20:	4621      	mov	r1, r4
c0d00b22:	f7ff fc0a 	bl	c0d0033a <trits_to_trint>
c0d00b26:	9900      	ldr	r1, [sp, #0]
c0d00b28:	9d01      	ldr	r5, [sp, #4]
c0d00b2a:	5548      	strb	r0, [r1, r5]
    }
    
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
c0d00b2c:	1c6d      	adds	r5, r5, #1
c0d00b2e:	2d31      	cmp	r5, #49	; 0x31
c0d00b30:	d1c2      	bne.n	c0d00ab8 <words_to_trints+0x80>
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
    }
    return 0;
c0d00b32:	2000      	movs	r0, #0
c0d00b34:	b025      	add	sp, #148	; 0x94
c0d00b36:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00b38:	ad0b      	add	r5, sp, #44	; 0x2c
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
c0d00b3a:	2101      	movs	r1, #1
c0d00b3c:	ae18      	add	r6, sp, #96	; 0x60
c0d00b3e:	240d      	movs	r4, #13
c0d00b40:	4628      	mov	r0, r5
c0d00b42:	4632      	mov	r2, r6
c0d00b44:	4623      	mov	r3, r4
c0d00b46:	f7ff fd3d 	bl	c0d005c4 <bigint_add_int>
            bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d00b4a:	480a      	ldr	r0, [pc, #40]	; (c0d00b74 <words_to_trints+0x13c>)
c0d00b4c:	4478      	add	r0, pc
c0d00b4e:	4631      	mov	r1, r6
c0d00b50:	462a      	mov	r2, r5
c0d00b52:	4623      	mov	r3, r4
c0d00b54:	f7ff fdba 	bl	c0d006cc <bigint_sub_bigint>
            memcpy(base, tmp, 52);
c0d00b58:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00b5a:	c607      	stmia	r6!, {r0, r1, r2}
c0d00b5c:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00b5e:	c607      	stmia	r6!, {r0, r1, r2}
c0d00b60:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00b62:	c607      	stmia	r6!, {r0, r1, r2}
c0d00b64:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00b66:	c60f      	stmia	r6!, {r0, r1, r2, r3}
c0d00b68:	9d01      	ldr	r5, [sp, #4]
c0d00b6a:	e787      	b.n	c0d00a7c <words_to_trints+0x44>
c0d00b6c:	00003216 	.word	0x00003216
c0d00b70:	00003204 	.word	0x00003204
c0d00b74:	00003160 	.word	0x00003160
c0d00b78:	0000323a 	.word	0x0000323a

c0d00b7c <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00b7c:	b580      	push	{r7, lr}
c0d00b7e:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00b80:	2003      	movs	r0, #3
c0d00b82:	01c1      	lsls	r1, r0, #7
c0d00b84:	4802      	ldr	r0, [pc, #8]	; (c0d00b90 <kerl_initialize+0x14>)
c0d00b86:	f001 fb6d 	bl	c0d02264 <cx_keccak_init>
    return 0;
c0d00b8a:	2000      	movs	r0, #0
c0d00b8c:	bd80      	pop	{r7, pc}
c0d00b8e:	46c0      	nop			; (mov r8, r8)
c0d00b90:	20001840 	.word	0x20001840

c0d00b94 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00b94:	b580      	push	{r7, lr}
c0d00b96:	af00      	add	r7, sp, #0
c0d00b98:	b082      	sub	sp, #8
c0d00b9a:	460b      	mov	r3, r1
c0d00b9c:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00b9e:	4805      	ldr	r0, [pc, #20]	; (c0d00bb4 <kerl_absorb_bytes+0x20>)
c0d00ba0:	4669      	mov	r1, sp
c0d00ba2:	6008      	str	r0, [r1, #0]
c0d00ba4:	4804      	ldr	r0, [pc, #16]	; (c0d00bb8 <kerl_absorb_bytes+0x24>)
c0d00ba6:	2101      	movs	r1, #1
c0d00ba8:	f001 fb7a 	bl	c0d022a0 <cx_hash>
c0d00bac:	2000      	movs	r0, #0
    return 0;
c0d00bae:	b002      	add	sp, #8
c0d00bb0:	bd80      	pop	{r7, pc}
c0d00bb2:	46c0      	nop			; (mov r8, r8)
c0d00bb4:	200019e8 	.word	0x200019e8
c0d00bb8:	20001840 	.word	0x20001840

c0d00bbc <kerl_absorb_trints>:
    return 0;
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
c0d00bbc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00bbe:	af03      	add	r7, sp, #12
c0d00bc0:	b09b      	sub	sp, #108	; 0x6c
c0d00bc2:	460e      	mov	r6, r1
c0d00bc4:	4604      	mov	r4, r0
c0d00bc6:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00bc8:	4630      	mov	r0, r6
c0d00bca:	f002 fcb9 	bl	c0d03540 <__aeabi_uidiv>
c0d00bce:	2e31      	cmp	r6, #49	; 0x31
c0d00bd0:	d31c      	bcc.n	c0d00c0c <kerl_absorb_trints+0x50>
c0d00bd2:	2500      	movs	r5, #0
c0d00bd4:	9402      	str	r4, [sp, #8]
c0d00bd6:	9001      	str	r0, [sp, #4]
c0d00bd8:	ae0f      	add	r6, sp, #60	; 0x3c
        // First, convert to bytes
        int32_t words[12];
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
c0d00bda:	4620      	mov	r0, r4
c0d00bdc:	4631      	mov	r1, r6
c0d00bde:	f7ff fea7 	bl	c0d00930 <trints_to_words>
c0d00be2:	ac03      	add	r4, sp, #12
        words_to_bytes(words, bytes, 12);
c0d00be4:	220c      	movs	r2, #12
c0d00be6:	4630      	mov	r0, r6
c0d00be8:	4621      	mov	r1, r4
c0d00bea:	f7ff fe61 	bl	c0d008b0 <words_to_bytes>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00bee:	4668      	mov	r0, sp
c0d00bf0:	4908      	ldr	r1, [pc, #32]	; (c0d00c14 <kerl_absorb_trints+0x58>)
c0d00bf2:	6001      	str	r1, [r0, #0]
c0d00bf4:	2101      	movs	r1, #1
c0d00bf6:	2330      	movs	r3, #48	; 0x30
c0d00bf8:	4807      	ldr	r0, [pc, #28]	; (c0d00c18 <kerl_absorb_trints+0x5c>)
c0d00bfa:	4622      	mov	r2, r4
c0d00bfc:	9c02      	ldr	r4, [sp, #8]
c0d00bfe:	f001 fb4f 	bl	c0d022a0 <cx_hash>
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00c02:	1c6d      	adds	r5, r5, #1
c0d00c04:	b2e8      	uxtb	r0, r5
c0d00c06:	9901      	ldr	r1, [sp, #4]
c0d00c08:	4288      	cmp	r0, r1
c0d00c0a:	d3e5      	bcc.n	c0d00bd8 <kerl_absorb_trints+0x1c>
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
c0d00c0c:	2000      	movs	r0, #0
c0d00c0e:	b01b      	add	sp, #108	; 0x6c
c0d00c10:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00c12:	46c0      	nop			; (mov r8, r8)
c0d00c14:	200019e8 	.word	0x200019e8
c0d00c18:	20001840 	.word	0x20001840

c0d00c1c <kerl_squeeze_trints>:
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
c0d00c1c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c1e:	af03      	add	r7, sp, #12
c0d00c20:	b091      	sub	sp, #68	; 0x44
c0d00c22:	4605      	mov	r5, r0
    (void) len;

    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
c0d00c24:	4c1b      	ldr	r4, [pc, #108]	; (c0d00c94 <kerl_squeeze_trints+0x78>)
c0d00c26:	ae05      	add	r6, sp, #20
c0d00c28:	220c      	movs	r2, #12
c0d00c2a:	4620      	mov	r0, r4
c0d00c2c:	4631      	mov	r1, r6
c0d00c2e:	f7ff fe62 	bl	c0d008f6 <bytes_to_words>
    words_to_trints(words, &trints_out[0]);
c0d00c32:	4630      	mov	r0, r6
c0d00c34:	9502      	str	r5, [sp, #8]
c0d00c36:	4629      	mov	r1, r5
c0d00c38:	f7ff fefe 	bl	c0d00a38 <words_to_trints>


    //-- Setting last trit to 0
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
c0d00c3c:	2030      	movs	r0, #48	; 0x30
c0d00c3e:	9003      	str	r0, [sp, #12]
c0d00c40:	5628      	ldrsb	r0, [r5, r0]
c0d00c42:	ad04      	add	r5, sp, #16
c0d00c44:	2203      	movs	r2, #3
c0d00c46:	9201      	str	r2, [sp, #4]
c0d00c48:	4629      	mov	r1, r5
c0d00c4a:	f7ff fbfd 	bl	c0d00448 <trint_to_trits>
c0d00c4e:	2600      	movs	r6, #0
    trits[2] = 0; //set last trit to 0
c0d00c50:	70ae      	strb	r6, [r5, #2]
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00c52:	4628      	mov	r0, r5
c0d00c54:	9d01      	ldr	r5, [sp, #4]
c0d00c56:	4629      	mov	r1, r5
c0d00c58:	f7ff fb6f 	bl	c0d0033a <trits_to_trint>
c0d00c5c:	9903      	ldr	r1, [sp, #12]
c0d00c5e:	9a02      	ldr	r2, [sp, #8]
c0d00c60:	5450      	strb	r0, [r2, r1]

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
c0d00c62:	1ba0      	subs	r0, r4, r6
c0d00c64:	7801      	ldrb	r1, [r0, #0]
c0d00c66:	43c9      	mvns	r1, r1
c0d00c68:	7001      	strb	r1, [r0, #0]
    trints_out[48] = trits_to_trint(&trits[0], 3);

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d00c6a:	1e76      	subs	r6, r6, #1
c0d00c6c:	4630      	mov	r0, r6
c0d00c6e:	3030      	adds	r0, #48	; 0x30
c0d00c70:	d1f7      	bne.n	c0d00c62 <kerl_squeeze_trints+0x46>
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d00c72:	01e9      	lsls	r1, r5, #7
c0d00c74:	4d08      	ldr	r5, [pc, #32]	; (c0d00c98 <kerl_squeeze_trints+0x7c>)
c0d00c76:	4628      	mov	r0, r5
c0d00c78:	f001 faf4 	bl	c0d02264 <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00c7c:	4668      	mov	r0, sp
c0d00c7e:	6004      	str	r4, [r0, #0]
c0d00c80:	2101      	movs	r1, #1
c0d00c82:	2330      	movs	r3, #48	; 0x30
c0d00c84:	4628      	mov	r0, r5
c0d00c86:	4622      	mov	r2, r4
c0d00c88:	f001 fb0a 	bl	c0d022a0 <cx_hash>
c0d00c8c:	2000      	movs	r0, #0
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
c0d00c8e:	b011      	add	sp, #68	; 0x44
c0d00c90:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00c92:	46c0      	nop			; (mov r8, r8)
c0d00c94:	200019e8 	.word	0x200019e8
c0d00c98:	20001840 	.word	0x20001840

c0d00c9c <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00c9c:	b580      	push	{r7, lr}
c0d00c9e:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00ca0:	4804      	ldr	r0, [pc, #16]	; (c0d00cb4 <nvram_is_init+0x18>)
c0d00ca2:	f001 fa33 	bl	c0d0210c <pic>
c0d00ca6:	7801      	ldrb	r1, [r0, #0]
c0d00ca8:	2000      	movs	r0, #0
c0d00caa:	2901      	cmp	r1, #1
c0d00cac:	d100      	bne.n	c0d00cb0 <nvram_is_init+0x14>
c0d00cae:	4608      	mov	r0, r1
    else return true;
}
c0d00cb0:	bd80      	pop	{r7, pc}
c0d00cb2:	46c0      	nop			; (mov r8, r8)
c0d00cb4:	c0d040c0 	.word	0xc0d040c0

c0d00cb8 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00cb8:	b5b0      	push	{r4, r5, r7, lr}
c0d00cba:	af02      	add	r7, sp, #8
c0d00cbc:	4605      	mov	r5, r0
c0d00cbe:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00cc0:	4028      	ands	r0, r5
c0d00cc2:	2400      	movs	r4, #0
c0d00cc4:	2801      	cmp	r0, #1
c0d00cc6:	d013      	beq.n	c0d00cf0 <io_exchange_al+0x38>
c0d00cc8:	2802      	cmp	r0, #2
c0d00cca:	d113      	bne.n	c0d00cf4 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00ccc:	2900      	cmp	r1, #0
c0d00cce:	d008      	beq.n	c0d00ce2 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00cd0:	480b      	ldr	r0, [pc, #44]	; (c0d00d00 <io_exchange_al+0x48>)
c0d00cd2:	f001 fbd7 	bl	c0d02484 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d00cd6:	b268      	sxtb	r0, r5
c0d00cd8:	2800      	cmp	r0, #0
c0d00cda:	da09      	bge.n	c0d00cf0 <io_exchange_al+0x38>
                reset();
c0d00cdc:	f001 fa4c 	bl	c0d02178 <reset>
c0d00ce0:	e006      	b.n	c0d00cf0 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00ce2:	2041      	movs	r0, #65	; 0x41
c0d00ce4:	0081      	lsls	r1, r0, #2
c0d00ce6:	4806      	ldr	r0, [pc, #24]	; (c0d00d00 <io_exchange_al+0x48>)
c0d00ce8:	2200      	movs	r2, #0
c0d00cea:	f001 fc05 	bl	c0d024f8 <io_seproxyhal_spi_recv>
c0d00cee:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00cf0:	4620      	mov	r0, r4
c0d00cf2:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00cf4:	4803      	ldr	r0, [pc, #12]	; (c0d00d04 <io_exchange_al+0x4c>)
c0d00cf6:	6800      	ldr	r0, [r0, #0]
c0d00cf8:	2102      	movs	r1, #2
c0d00cfa:	f002 ff43 	bl	c0d03b84 <longjmp>
c0d00cfe:	46c0      	nop			; (mov r8, r8)
c0d00d00:	20001c08 	.word	0x20001c08
c0d00d04:	20001bb8 	.word	0x20001bb8

c0d00d08 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00d08:	b580      	push	{r7, lr}
c0d00d0a:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00d0c:	f000 fe8e 	bl	c0d01a2c <io_seproxyhal_display_default>
}
c0d00d10:	bd80      	pop	{r7, pc}
	...

c0d00d14 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00d14:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00d16:	af03      	add	r7, sp, #12
c0d00d18:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00d1a:	48a6      	ldr	r0, [pc, #664]	; (c0d00fb4 <io_event+0x2a0>)
c0d00d1c:	7800      	ldrb	r0, [r0, #0]
c0d00d1e:	2805      	cmp	r0, #5
c0d00d20:	d02e      	beq.n	c0d00d80 <io_event+0x6c>
c0d00d22:	280d      	cmp	r0, #13
c0d00d24:	d04e      	beq.n	c0d00dc4 <io_event+0xb0>
c0d00d26:	280c      	cmp	r0, #12
c0d00d28:	d000      	beq.n	c0d00d2c <io_event+0x18>
c0d00d2a:	e13a      	b.n	c0d00fa2 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00d2c:	4ea2      	ldr	r6, [pc, #648]	; (c0d00fb8 <io_event+0x2a4>)
c0d00d2e:	2001      	movs	r0, #1
c0d00d30:	7630      	strb	r0, [r6, #24]
c0d00d32:	2500      	movs	r5, #0
c0d00d34:	61f5      	str	r5, [r6, #28]
c0d00d36:	4634      	mov	r4, r6
c0d00d38:	3418      	adds	r4, #24
c0d00d3a:	4620      	mov	r0, r4
c0d00d3c:	f001 fb68 	bl	c0d02410 <os_ux>
c0d00d40:	61f0      	str	r0, [r6, #28]
c0d00d42:	499e      	ldr	r1, [pc, #632]	; (c0d00fbc <io_event+0x2a8>)
c0d00d44:	4288      	cmp	r0, r1
c0d00d46:	d100      	bne.n	c0d00d4a <io_event+0x36>
c0d00d48:	e12b      	b.n	c0d00fa2 <io_event+0x28e>
c0d00d4a:	2800      	cmp	r0, #0
c0d00d4c:	d100      	bne.n	c0d00d50 <io_event+0x3c>
c0d00d4e:	e128      	b.n	c0d00fa2 <io_event+0x28e>
c0d00d50:	499b      	ldr	r1, [pc, #620]	; (c0d00fc0 <io_event+0x2ac>)
c0d00d52:	4288      	cmp	r0, r1
c0d00d54:	d000      	beq.n	c0d00d58 <io_event+0x44>
c0d00d56:	e0ac      	b.n	c0d00eb2 <io_event+0x19e>
c0d00d58:	2003      	movs	r0, #3
c0d00d5a:	7630      	strb	r0, [r6, #24]
c0d00d5c:	61f5      	str	r5, [r6, #28]
c0d00d5e:	4620      	mov	r0, r4
c0d00d60:	f001 fb56 	bl	c0d02410 <os_ux>
c0d00d64:	61f0      	str	r0, [r6, #28]
c0d00d66:	f000 fd17 	bl	c0d01798 <io_seproxyhal_init_ux>
c0d00d6a:	60b5      	str	r5, [r6, #8]
c0d00d6c:	6830      	ldr	r0, [r6, #0]
c0d00d6e:	2800      	cmp	r0, #0
c0d00d70:	d100      	bne.n	c0d00d74 <io_event+0x60>
c0d00d72:	e116      	b.n	c0d00fa2 <io_event+0x28e>
c0d00d74:	69f0      	ldr	r0, [r6, #28]
c0d00d76:	4991      	ldr	r1, [pc, #580]	; (c0d00fbc <io_event+0x2a8>)
c0d00d78:	4288      	cmp	r0, r1
c0d00d7a:	d000      	beq.n	c0d00d7e <io_event+0x6a>
c0d00d7c:	e096      	b.n	c0d00eac <io_event+0x198>
c0d00d7e:	e110      	b.n	c0d00fa2 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00d80:	4d8d      	ldr	r5, [pc, #564]	; (c0d00fb8 <io_event+0x2a4>)
c0d00d82:	2001      	movs	r0, #1
c0d00d84:	7628      	strb	r0, [r5, #24]
c0d00d86:	2600      	movs	r6, #0
c0d00d88:	61ee      	str	r6, [r5, #28]
c0d00d8a:	462c      	mov	r4, r5
c0d00d8c:	3418      	adds	r4, #24
c0d00d8e:	4620      	mov	r0, r4
c0d00d90:	f001 fb3e 	bl	c0d02410 <os_ux>
c0d00d94:	4601      	mov	r1, r0
c0d00d96:	61e9      	str	r1, [r5, #28]
c0d00d98:	4889      	ldr	r0, [pc, #548]	; (c0d00fc0 <io_event+0x2ac>)
c0d00d9a:	4281      	cmp	r1, r0
c0d00d9c:	d15d      	bne.n	c0d00e5a <io_event+0x146>
c0d00d9e:	2003      	movs	r0, #3
c0d00da0:	7628      	strb	r0, [r5, #24]
c0d00da2:	61ee      	str	r6, [r5, #28]
c0d00da4:	4620      	mov	r0, r4
c0d00da6:	f001 fb33 	bl	c0d02410 <os_ux>
c0d00daa:	61e8      	str	r0, [r5, #28]
c0d00dac:	f000 fcf4 	bl	c0d01798 <io_seproxyhal_init_ux>
c0d00db0:	60ae      	str	r6, [r5, #8]
c0d00db2:	6828      	ldr	r0, [r5, #0]
c0d00db4:	2800      	cmp	r0, #0
c0d00db6:	d100      	bne.n	c0d00dba <io_event+0xa6>
c0d00db8:	e0f3      	b.n	c0d00fa2 <io_event+0x28e>
c0d00dba:	69e8      	ldr	r0, [r5, #28]
c0d00dbc:	497f      	ldr	r1, [pc, #508]	; (c0d00fbc <io_event+0x2a8>)
c0d00dbe:	4288      	cmp	r0, r1
c0d00dc0:	d148      	bne.n	c0d00e54 <io_event+0x140>
c0d00dc2:	e0ee      	b.n	c0d00fa2 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00dc4:	4d7c      	ldr	r5, [pc, #496]	; (c0d00fb8 <io_event+0x2a4>)
c0d00dc6:	6868      	ldr	r0, [r5, #4]
c0d00dc8:	68a9      	ldr	r1, [r5, #8]
c0d00dca:	4281      	cmp	r1, r0
c0d00dcc:	d300      	bcc.n	c0d00dd0 <io_event+0xbc>
c0d00dce:	e0e8      	b.n	c0d00fa2 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00dd0:	2001      	movs	r0, #1
c0d00dd2:	7628      	strb	r0, [r5, #24]
c0d00dd4:	2600      	movs	r6, #0
c0d00dd6:	61ee      	str	r6, [r5, #28]
c0d00dd8:	462c      	mov	r4, r5
c0d00dda:	3418      	adds	r4, #24
c0d00ddc:	4620      	mov	r0, r4
c0d00dde:	f001 fb17 	bl	c0d02410 <os_ux>
c0d00de2:	61e8      	str	r0, [r5, #28]
c0d00de4:	4975      	ldr	r1, [pc, #468]	; (c0d00fbc <io_event+0x2a8>)
c0d00de6:	4288      	cmp	r0, r1
c0d00de8:	d100      	bne.n	c0d00dec <io_event+0xd8>
c0d00dea:	e0da      	b.n	c0d00fa2 <io_event+0x28e>
c0d00dec:	2800      	cmp	r0, #0
c0d00dee:	d100      	bne.n	c0d00df2 <io_event+0xde>
c0d00df0:	e0d7      	b.n	c0d00fa2 <io_event+0x28e>
c0d00df2:	4973      	ldr	r1, [pc, #460]	; (c0d00fc0 <io_event+0x2ac>)
c0d00df4:	4288      	cmp	r0, r1
c0d00df6:	d000      	beq.n	c0d00dfa <io_event+0xe6>
c0d00df8:	e08d      	b.n	c0d00f16 <io_event+0x202>
c0d00dfa:	2003      	movs	r0, #3
c0d00dfc:	7628      	strb	r0, [r5, #24]
c0d00dfe:	61ee      	str	r6, [r5, #28]
c0d00e00:	4620      	mov	r0, r4
c0d00e02:	f001 fb05 	bl	c0d02410 <os_ux>
c0d00e06:	61e8      	str	r0, [r5, #28]
c0d00e08:	f000 fcc6 	bl	c0d01798 <io_seproxyhal_init_ux>
c0d00e0c:	60ae      	str	r6, [r5, #8]
c0d00e0e:	6828      	ldr	r0, [r5, #0]
c0d00e10:	2800      	cmp	r0, #0
c0d00e12:	d100      	bne.n	c0d00e16 <io_event+0x102>
c0d00e14:	e0c5      	b.n	c0d00fa2 <io_event+0x28e>
c0d00e16:	69e8      	ldr	r0, [r5, #28]
c0d00e18:	4968      	ldr	r1, [pc, #416]	; (c0d00fbc <io_event+0x2a8>)
c0d00e1a:	4288      	cmp	r0, r1
c0d00e1c:	d178      	bne.n	c0d00f10 <io_event+0x1fc>
c0d00e1e:	e0c0      	b.n	c0d00fa2 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00e20:	6868      	ldr	r0, [r5, #4]
c0d00e22:	4286      	cmp	r6, r0
c0d00e24:	d300      	bcc.n	c0d00e28 <io_event+0x114>
c0d00e26:	e0bc      	b.n	c0d00fa2 <io_event+0x28e>
c0d00e28:	f001 fb4a 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d00e2c:	2800      	cmp	r0, #0
c0d00e2e:	d000      	beq.n	c0d00e32 <io_event+0x11e>
c0d00e30:	e0b7      	b.n	c0d00fa2 <io_event+0x28e>
c0d00e32:	68a8      	ldr	r0, [r5, #8]
c0d00e34:	68e9      	ldr	r1, [r5, #12]
c0d00e36:	2438      	movs	r4, #56	; 0x38
c0d00e38:	4360      	muls	r0, r4
c0d00e3a:	682a      	ldr	r2, [r5, #0]
c0d00e3c:	1810      	adds	r0, r2, r0
c0d00e3e:	2900      	cmp	r1, #0
c0d00e40:	d100      	bne.n	c0d00e44 <io_event+0x130>
c0d00e42:	e085      	b.n	c0d00f50 <io_event+0x23c>
c0d00e44:	4788      	blx	r1
c0d00e46:	2800      	cmp	r0, #0
c0d00e48:	d000      	beq.n	c0d00e4c <io_event+0x138>
c0d00e4a:	e081      	b.n	c0d00f50 <io_event+0x23c>
c0d00e4c:	68a8      	ldr	r0, [r5, #8]
c0d00e4e:	1c46      	adds	r6, r0, #1
c0d00e50:	60ae      	str	r6, [r5, #8]
c0d00e52:	6828      	ldr	r0, [r5, #0]
c0d00e54:	2800      	cmp	r0, #0
c0d00e56:	d1e3      	bne.n	c0d00e20 <io_event+0x10c>
c0d00e58:	e0a3      	b.n	c0d00fa2 <io_event+0x28e>
c0d00e5a:	6928      	ldr	r0, [r5, #16]
c0d00e5c:	2800      	cmp	r0, #0
c0d00e5e:	d100      	bne.n	c0d00e62 <io_event+0x14e>
c0d00e60:	e09f      	b.n	c0d00fa2 <io_event+0x28e>
c0d00e62:	4a56      	ldr	r2, [pc, #344]	; (c0d00fbc <io_event+0x2a8>)
c0d00e64:	4291      	cmp	r1, r2
c0d00e66:	d100      	bne.n	c0d00e6a <io_event+0x156>
c0d00e68:	e09b      	b.n	c0d00fa2 <io_event+0x28e>
c0d00e6a:	2900      	cmp	r1, #0
c0d00e6c:	d100      	bne.n	c0d00e70 <io_event+0x15c>
c0d00e6e:	e098      	b.n	c0d00fa2 <io_event+0x28e>
c0d00e70:	4950      	ldr	r1, [pc, #320]	; (c0d00fb4 <io_event+0x2a0>)
c0d00e72:	78c9      	ldrb	r1, [r1, #3]
c0d00e74:	0849      	lsrs	r1, r1, #1
c0d00e76:	f000 fe1b 	bl	c0d01ab0 <io_seproxyhal_button_push>
c0d00e7a:	e092      	b.n	c0d00fa2 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00e7c:	6870      	ldr	r0, [r6, #4]
c0d00e7e:	4285      	cmp	r5, r0
c0d00e80:	d300      	bcc.n	c0d00e84 <io_event+0x170>
c0d00e82:	e08e      	b.n	c0d00fa2 <io_event+0x28e>
c0d00e84:	f001 fb1c 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d00e88:	2800      	cmp	r0, #0
c0d00e8a:	d000      	beq.n	c0d00e8e <io_event+0x17a>
c0d00e8c:	e089      	b.n	c0d00fa2 <io_event+0x28e>
c0d00e8e:	68b0      	ldr	r0, [r6, #8]
c0d00e90:	68f1      	ldr	r1, [r6, #12]
c0d00e92:	2438      	movs	r4, #56	; 0x38
c0d00e94:	4360      	muls	r0, r4
c0d00e96:	6832      	ldr	r2, [r6, #0]
c0d00e98:	1810      	adds	r0, r2, r0
c0d00e9a:	2900      	cmp	r1, #0
c0d00e9c:	d076      	beq.n	c0d00f8c <io_event+0x278>
c0d00e9e:	4788      	blx	r1
c0d00ea0:	2800      	cmp	r0, #0
c0d00ea2:	d173      	bne.n	c0d00f8c <io_event+0x278>
c0d00ea4:	68b0      	ldr	r0, [r6, #8]
c0d00ea6:	1c45      	adds	r5, r0, #1
c0d00ea8:	60b5      	str	r5, [r6, #8]
c0d00eaa:	6830      	ldr	r0, [r6, #0]
c0d00eac:	2800      	cmp	r0, #0
c0d00eae:	d1e5      	bne.n	c0d00e7c <io_event+0x168>
c0d00eb0:	e077      	b.n	c0d00fa2 <io_event+0x28e>
c0d00eb2:	88b0      	ldrh	r0, [r6, #4]
c0d00eb4:	9004      	str	r0, [sp, #16]
c0d00eb6:	6830      	ldr	r0, [r6, #0]
c0d00eb8:	9003      	str	r0, [sp, #12]
c0d00eba:	483e      	ldr	r0, [pc, #248]	; (c0d00fb4 <io_event+0x2a0>)
c0d00ebc:	4601      	mov	r1, r0
c0d00ebe:	79cc      	ldrb	r4, [r1, #7]
c0d00ec0:	798b      	ldrb	r3, [r1, #6]
c0d00ec2:	794d      	ldrb	r5, [r1, #5]
c0d00ec4:	790a      	ldrb	r2, [r1, #4]
c0d00ec6:	4630      	mov	r0, r6
c0d00ec8:	78ce      	ldrb	r6, [r1, #3]
c0d00eca:	68c1      	ldr	r1, [r0, #12]
c0d00ecc:	4668      	mov	r0, sp
c0d00ece:	6006      	str	r6, [r0, #0]
c0d00ed0:	6041      	str	r1, [r0, #4]
c0d00ed2:	0212      	lsls	r2, r2, #8
c0d00ed4:	432a      	orrs	r2, r5
c0d00ed6:	021b      	lsls	r3, r3, #8
c0d00ed8:	4323      	orrs	r3, r4
c0d00eda:	9803      	ldr	r0, [sp, #12]
c0d00edc:	9904      	ldr	r1, [sp, #16]
c0d00ede:	f000 fcd5 	bl	c0d0188c <io_seproxyhal_touch_element_callback>
c0d00ee2:	e05e      	b.n	c0d00fa2 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00ee4:	6868      	ldr	r0, [r5, #4]
c0d00ee6:	4286      	cmp	r6, r0
c0d00ee8:	d25b      	bcs.n	c0d00fa2 <io_event+0x28e>
c0d00eea:	f001 fae9 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d00eee:	2800      	cmp	r0, #0
c0d00ef0:	d157      	bne.n	c0d00fa2 <io_event+0x28e>
c0d00ef2:	68a8      	ldr	r0, [r5, #8]
c0d00ef4:	68e9      	ldr	r1, [r5, #12]
c0d00ef6:	2438      	movs	r4, #56	; 0x38
c0d00ef8:	4360      	muls	r0, r4
c0d00efa:	682a      	ldr	r2, [r5, #0]
c0d00efc:	1810      	adds	r0, r2, r0
c0d00efe:	2900      	cmp	r1, #0
c0d00f00:	d026      	beq.n	c0d00f50 <io_event+0x23c>
c0d00f02:	4788      	blx	r1
c0d00f04:	2800      	cmp	r0, #0
c0d00f06:	d123      	bne.n	c0d00f50 <io_event+0x23c>
c0d00f08:	68a8      	ldr	r0, [r5, #8]
c0d00f0a:	1c46      	adds	r6, r0, #1
c0d00f0c:	60ae      	str	r6, [r5, #8]
c0d00f0e:	6828      	ldr	r0, [r5, #0]
c0d00f10:	2800      	cmp	r0, #0
c0d00f12:	d1e7      	bne.n	c0d00ee4 <io_event+0x1d0>
c0d00f14:	e045      	b.n	c0d00fa2 <io_event+0x28e>
c0d00f16:	6828      	ldr	r0, [r5, #0]
c0d00f18:	2800      	cmp	r0, #0
c0d00f1a:	d030      	beq.n	c0d00f7e <io_event+0x26a>
c0d00f1c:	68a8      	ldr	r0, [r5, #8]
c0d00f1e:	6869      	ldr	r1, [r5, #4]
c0d00f20:	4288      	cmp	r0, r1
c0d00f22:	d22c      	bcs.n	c0d00f7e <io_event+0x26a>
c0d00f24:	f001 facc 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d00f28:	2800      	cmp	r0, #0
c0d00f2a:	d128      	bne.n	c0d00f7e <io_event+0x26a>
c0d00f2c:	68a8      	ldr	r0, [r5, #8]
c0d00f2e:	68e9      	ldr	r1, [r5, #12]
c0d00f30:	2438      	movs	r4, #56	; 0x38
c0d00f32:	4360      	muls	r0, r4
c0d00f34:	682a      	ldr	r2, [r5, #0]
c0d00f36:	1810      	adds	r0, r2, r0
c0d00f38:	2900      	cmp	r1, #0
c0d00f3a:	d015      	beq.n	c0d00f68 <io_event+0x254>
c0d00f3c:	4788      	blx	r1
c0d00f3e:	2800      	cmp	r0, #0
c0d00f40:	d112      	bne.n	c0d00f68 <io_event+0x254>
c0d00f42:	68a8      	ldr	r0, [r5, #8]
c0d00f44:	1c40      	adds	r0, r0, #1
c0d00f46:	60a8      	str	r0, [r5, #8]
c0d00f48:	6829      	ldr	r1, [r5, #0]
c0d00f4a:	2900      	cmp	r1, #0
c0d00f4c:	d1e7      	bne.n	c0d00f1e <io_event+0x20a>
c0d00f4e:	e016      	b.n	c0d00f7e <io_event+0x26a>
c0d00f50:	2801      	cmp	r0, #1
c0d00f52:	d103      	bne.n	c0d00f5c <io_event+0x248>
c0d00f54:	68a8      	ldr	r0, [r5, #8]
c0d00f56:	4344      	muls	r4, r0
c0d00f58:	6828      	ldr	r0, [r5, #0]
c0d00f5a:	1900      	adds	r0, r0, r4
c0d00f5c:	f000 fd66 	bl	c0d01a2c <io_seproxyhal_display_default>
c0d00f60:	68a8      	ldr	r0, [r5, #8]
c0d00f62:	1c40      	adds	r0, r0, #1
c0d00f64:	60a8      	str	r0, [r5, #8]
c0d00f66:	e01c      	b.n	c0d00fa2 <io_event+0x28e>
c0d00f68:	2801      	cmp	r0, #1
c0d00f6a:	d103      	bne.n	c0d00f74 <io_event+0x260>
c0d00f6c:	68a8      	ldr	r0, [r5, #8]
c0d00f6e:	4344      	muls	r4, r0
c0d00f70:	6828      	ldr	r0, [r5, #0]
c0d00f72:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00f74:	f000 fd5a 	bl	c0d01a2c <io_seproxyhal_display_default>
c0d00f78:	68a8      	ldr	r0, [r5, #8]
c0d00f7a:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00f7c:	60a8      	str	r0, [r5, #8]
c0d00f7e:	6868      	ldr	r0, [r5, #4]
c0d00f80:	68a9      	ldr	r1, [r5, #8]
c0d00f82:	4281      	cmp	r1, r0
c0d00f84:	d30d      	bcc.n	c0d00fa2 <io_event+0x28e>
c0d00f86:	f001 fa9b 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d00f8a:	e00a      	b.n	c0d00fa2 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00f8c:	2801      	cmp	r0, #1
c0d00f8e:	d103      	bne.n	c0d00f98 <io_event+0x284>
c0d00f90:	68b0      	ldr	r0, [r6, #8]
c0d00f92:	4344      	muls	r4, r0
c0d00f94:	6830      	ldr	r0, [r6, #0]
c0d00f96:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00f98:	f000 fd48 	bl	c0d01a2c <io_seproxyhal_display_default>
c0d00f9c:	68b0      	ldr	r0, [r6, #8]
c0d00f9e:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00fa0:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00fa2:	f001 fa8d 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d00fa6:	2800      	cmp	r0, #0
c0d00fa8:	d101      	bne.n	c0d00fae <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00faa:	f000 fac9 	bl	c0d01540 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00fae:	2001      	movs	r0, #1
c0d00fb0:	b005      	add	sp, #20
c0d00fb2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00fb4:	20001a18 	.word	0x20001a18
c0d00fb8:	20001a98 	.word	0x20001a98
c0d00fbc:	b0105044 	.word	0xb0105044
c0d00fc0:	b0105055 	.word	0xb0105055

c0d00fc4 <IOTA_main>:





static void IOTA_main(void) {
c0d00fc4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00fc6:	af03      	add	r7, sp, #12
c0d00fc8:	b0dd      	sub	sp, #372	; 0x174
c0d00fca:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00fcc:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00fce:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00fd0:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00fd2:	a0a1      	add	r0, pc, #644	; (adr r0, c0d01258 <IOTA_main+0x294>)
c0d00fd4:	2110      	movs	r1, #16
c0d00fd6:	2203      	movs	r2, #3
c0d00fd8:	9109      	str	r1, [sp, #36]	; 0x24
c0d00fda:	9208      	str	r2, [sp, #32]
c0d00fdc:	f7ff f94c 	bl	c0d00278 <write_debug>
c0d00fe0:	a80e      	add	r0, sp, #56	; 0x38
c0d00fe2:	304d      	adds	r0, #77	; 0x4d
c0d00fe4:	9007      	str	r0, [sp, #28]
c0d00fe6:	a80b      	add	r0, sp, #44	; 0x2c
c0d00fe8:	1dc1      	adds	r1, r0, #7
c0d00fea:	9106      	str	r1, [sp, #24]
c0d00fec:	1d00      	adds	r0, r0, #4
c0d00fee:	9005      	str	r0, [sp, #20]
c0d00ff0:	4e9d      	ldr	r6, [pc, #628]	; (c0d01268 <IOTA_main+0x2a4>)
c0d00ff2:	6830      	ldr	r0, [r6, #0]
c0d00ff4:	e08d      	b.n	c0d01112 <IOTA_main+0x14e>
c0d00ff6:	489f      	ldr	r0, [pc, #636]	; (c0d01274 <IOTA_main+0x2b0>)
c0d00ff8:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00ffa:	4330      	orrs	r0, r6
c0d00ffc:	2880      	cmp	r0, #128	; 0x80
c0d00ffe:	d000      	beq.n	c0d01002 <IOTA_main+0x3e>
c0d01000:	e11e      	b.n	c0d01240 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d01002:	7810      	ldrb	r0, [r2, #0]
c0d01004:	2800      	cmp	r0, #0
c0d01006:	4e98      	ldr	r6, [pc, #608]	; (c0d01268 <IOTA_main+0x2a4>)
c0d01008:	d004      	beq.n	c0d01014 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d0100a:	489c      	ldr	r0, [pc, #624]	; (c0d0127c <IOTA_main+0x2b8>)
c0d0100c:	f001 f90c 	bl	c0d02228 <cx_sha256_init>
                        hashTainted = 0;
c0d01010:	4899      	ldr	r0, [pc, #612]	; (c0d01278 <IOTA_main+0x2b4>)
c0d01012:	7004      	strb	r4, [r0, #0]
c0d01014:	4897      	ldr	r0, [pc, #604]	; (c0d01274 <IOTA_main+0x2b0>)
c0d01016:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d01018:	7908      	ldrb	r0, [r1, #4]
c0d0101a:	1808      	adds	r0, r1, r0
c0d0101c:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d0101e:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d01020:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01022:	4308      	orrs	r0, r1
c0d01024:	905a      	str	r0, [sp, #360]	; 0x168
c0d01026:	e0e5      	b.n	c0d011f4 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d01028:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d0102a:	2818      	cmp	r0, #24
c0d0102c:	d800      	bhi.n	c0d01030 <IOTA_main+0x6c>
c0d0102e:	e10c      	b.n	c0d0124a <IOTA_main+0x286>
c0d01030:	950a      	str	r5, [sp, #40]	; 0x28
c0d01032:	4d90      	ldr	r5, [pc, #576]	; (c0d01274 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d01034:	00a0      	lsls	r0, r4, #2
c0d01036:	1829      	adds	r1, r5, r0
c0d01038:	794a      	ldrb	r2, [r1, #5]
c0d0103a:	0612      	lsls	r2, r2, #24
c0d0103c:	798b      	ldrb	r3, [r1, #6]
c0d0103e:	041b      	lsls	r3, r3, #16
c0d01040:	4313      	orrs	r3, r2
c0d01042:	79ca      	ldrb	r2, [r1, #7]
c0d01044:	0212      	lsls	r2, r2, #8
c0d01046:	431a      	orrs	r2, r3
c0d01048:	7a09      	ldrb	r1, [r1, #8]
c0d0104a:	4311      	orrs	r1, r2
c0d0104c:	aa2b      	add	r2, sp, #172	; 0xac
c0d0104e:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d01050:	1c64      	adds	r4, r4, #1
c0d01052:	2c05      	cmp	r4, #5
c0d01054:	d1ee      	bne.n	c0d01034 <IOTA_main+0x70>
c0d01056:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d01058:	9103      	str	r1, [sp, #12]
c0d0105a:	4668      	mov	r0, sp
c0d0105c:	6001      	str	r1, [r0, #0]
c0d0105e:	2421      	movs	r4, #33	; 0x21
c0d01060:	a92b      	add	r1, sp, #172	; 0xac
c0d01062:	2205      	movs	r2, #5
c0d01064:	ad23      	add	r5, sp, #140	; 0x8c
c0d01066:	9502      	str	r5, [sp, #8]
c0d01068:	4620      	mov	r0, r4
c0d0106a:	462b      	mov	r3, r5
c0d0106c:	f001 f992 	bl	c0d02394 <os_perso_derive_node_bip32>
c0d01070:	2220      	movs	r2, #32
c0d01072:	9204      	str	r2, [sp, #16]
c0d01074:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d01076:	9301      	str	r3, [sp, #4]
c0d01078:	4620      	mov	r0, r4
c0d0107a:	4629      	mov	r1, r5
c0d0107c:	f001 f94e 	bl	c0d0231c <cx_ecfp_init_private_key>
c0d01080:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d01082:	4620      	mov	r0, r4
c0d01084:	9903      	ldr	r1, [sp, #12]
c0d01086:	460a      	mov	r2, r1
c0d01088:	462b      	mov	r3, r5
c0d0108a:	f001 f929 	bl	c0d022e0 <cx_ecfp_init_public_key>
c0d0108e:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d01090:	4620      	mov	r0, r4
c0d01092:	4629      	mov	r1, r5
c0d01094:	9a01      	ldr	r2, [sp, #4]
c0d01096:	f001 f95f 	bl	c0d02358 <cx_ecfp_generate_pair>
c0d0109a:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d0109c:	9802      	ldr	r0, [sp, #8]
c0d0109e:	9904      	ldr	r1, [sp, #16]
c0d010a0:	4622      	mov	r2, r4
c0d010a2:	f7ff fa09 	bl	c0d004b8 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d010a6:	2552      	movs	r5, #82	; 0x52
c0d010a8:	4872      	ldr	r0, [pc, #456]	; (c0d01274 <IOTA_main+0x2b0>)
c0d010aa:	4621      	mov	r1, r4
c0d010ac:	462a      	mov	r2, r5
c0d010ae:	f000 f9ad 	bl	c0d0140c <os_memmove>
                    tx = 82;
c0d010b2:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d010b4:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d010b6:	1c41      	adds	r1, r0, #1
c0d010b8:	915b      	str	r1, [sp, #364]	; 0x16c
c0d010ba:	3610      	adds	r6, #16
c0d010bc:	4a6d      	ldr	r2, [pc, #436]	; (c0d01274 <IOTA_main+0x2b0>)
c0d010be:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d010c0:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d010c2:	1c41      	adds	r1, r0, #1
c0d010c4:	915b      	str	r1, [sp, #364]	; 0x16c
c0d010c6:	9903      	ldr	r1, [sp, #12]
c0d010c8:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d010ca:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d010cc:	b281      	uxth	r1, r0
c0d010ce:	9804      	ldr	r0, [sp, #16]
c0d010d0:	f000 fd2a 	bl	c0d01b28 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d010d4:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d010d6:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d010d8:	4308      	orrs	r0, r1
c0d010da:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d010dc:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d010de:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d010e0:	202e      	movs	r0, #46	; 0x2e
c0d010e2:	9905      	ldr	r1, [sp, #20]
c0d010e4:	7048      	strb	r0, [r1, #1]
c0d010e6:	7008      	strb	r0, [r1, #0]
c0d010e8:	7088      	strb	r0, [r1, #2]
c0d010ea:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d010ec:	78c8      	ldrb	r0, [r1, #3]
c0d010ee:	9a06      	ldr	r2, [sp, #24]
c0d010f0:	70d0      	strb	r0, [r2, #3]
c0d010f2:	7888      	ldrb	r0, [r1, #2]
c0d010f4:	7090      	strb	r0, [r2, #2]
c0d010f6:	7848      	ldrb	r0, [r1, #1]
c0d010f8:	7050      	strb	r0, [r2, #1]
c0d010fa:	7808      	ldrb	r0, [r1, #0]
c0d010fc:	7010      	strb	r0, [r2, #0]
c0d010fe:	7908      	ldrb	r0, [r1, #4]
c0d01100:	7110      	strb	r0, [r2, #4]
c0d01102:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d01104:	2140      	movs	r1, #64	; 0x40
c0d01106:	2203      	movs	r2, #3
c0d01108:	f001 fa8a 	bl	c0d02620 <ui_display_debug>
c0d0110c:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d0110e:	4e56      	ldr	r6, [pc, #344]	; (c0d01268 <IOTA_main+0x2a4>)
c0d01110:	e070      	b.n	c0d011f4 <IOTA_main+0x230>
c0d01112:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d01114:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d01116:	9057      	str	r0, [sp, #348]	; 0x15c
c0d01118:	ac4d      	add	r4, sp, #308	; 0x134
c0d0111a:	4620      	mov	r0, r4
c0d0111c:	f002 fd26 	bl	c0d03b6c <setjmp>
c0d01120:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d01122:	6034      	str	r4, [r6, #0]
c0d01124:	4951      	ldr	r1, [pc, #324]	; (c0d0126c <IOTA_main+0x2a8>)
c0d01126:	4208      	tst	r0, r1
c0d01128:	d011      	beq.n	c0d0114e <IOTA_main+0x18a>
c0d0112a:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d0112c:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d0112e:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d01130:	6031      	str	r1, [r6, #0]
c0d01132:	210f      	movs	r1, #15
c0d01134:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d01136:	4001      	ands	r1, r0
c0d01138:	2209      	movs	r2, #9
c0d0113a:	0312      	lsls	r2, r2, #12
c0d0113c:	4291      	cmp	r1, r2
c0d0113e:	d003      	beq.n	c0d01148 <IOTA_main+0x184>
c0d01140:	9a08      	ldr	r2, [sp, #32]
c0d01142:	0352      	lsls	r2, r2, #13
c0d01144:	4291      	cmp	r1, r2
c0d01146:	d142      	bne.n	c0d011ce <IOTA_main+0x20a>
c0d01148:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d0114a:	8008      	strh	r0, [r1, #0]
c0d0114c:	e046      	b.n	c0d011dc <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d0114e:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d01150:	905c      	str	r0, [sp, #368]	; 0x170
c0d01152:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d01154:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d01156:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d01158:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d0115a:	b2c0      	uxtb	r0, r0
c0d0115c:	b289      	uxth	r1, r1
c0d0115e:	f000 fce3 	bl	c0d01b28 <io_exchange>
c0d01162:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d01164:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d01166:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d01168:	2800      	cmp	r0, #0
c0d0116a:	d053      	beq.n	c0d01214 <IOTA_main+0x250>
c0d0116c:	4941      	ldr	r1, [pc, #260]	; (c0d01274 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d0116e:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d01170:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d01172:	2880      	cmp	r0, #128	; 0x80
c0d01174:	4a40      	ldr	r2, [pc, #256]	; (c0d01278 <IOTA_main+0x2b4>)
c0d01176:	d155      	bne.n	c0d01224 <IOTA_main+0x260>
c0d01178:	7848      	ldrb	r0, [r1, #1]
c0d0117a:	216d      	movs	r1, #109	; 0x6d
c0d0117c:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d0117e:	2807      	cmp	r0, #7
c0d01180:	dc3f      	bgt.n	c0d01202 <IOTA_main+0x23e>
c0d01182:	2802      	cmp	r0, #2
c0d01184:	d100      	bne.n	c0d01188 <IOTA_main+0x1c4>
c0d01186:	e74f      	b.n	c0d01028 <IOTA_main+0x64>
c0d01188:	2804      	cmp	r0, #4
c0d0118a:	d153      	bne.n	c0d01234 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d0118c:	210b      	movs	r1, #11
c0d0118e:	2203      	movs	r2, #3
c0d01190:	a03c      	add	r0, pc, #240	; (adr r0, c0d01284 <IOTA_main+0x2c0>)
c0d01192:	f7ff f871 	bl	c0d00278 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d01196:	2048      	movs	r0, #72	; 0x48
c0d01198:	4936      	ldr	r1, [pc, #216]	; (c0d01274 <IOTA_main+0x2b0>)
c0d0119a:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d0119c:	2049      	movs	r0, #73	; 0x49
c0d0119e:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d011a0:	2021      	movs	r0, #33	; 0x21
c0d011a2:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d011a4:	3610      	adds	r6, #16
c0d011a6:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d011a8:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d011aa:	2005      	movs	r0, #5
c0d011ac:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d011ae:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d011b0:	b281      	uxth	r1, r0
c0d011b2:	2020      	movs	r0, #32
c0d011b4:	f000 fcb8 	bl	c0d01b28 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d011b8:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d011ba:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d011bc:	4308      	orrs	r0, r1
c0d011be:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d011c0:	4620      	mov	r0, r4
c0d011c2:	4621      	mov	r1, r4
c0d011c4:	4622      	mov	r2, r4
c0d011c6:	f001 fa2b 	bl	c0d02620 <ui_display_debug>
c0d011ca:	4e27      	ldr	r6, [pc, #156]	; (c0d01268 <IOTA_main+0x2a4>)
c0d011cc:	e012      	b.n	c0d011f4 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d011ce:	4928      	ldr	r1, [pc, #160]	; (c0d01270 <IOTA_main+0x2ac>)
c0d011d0:	4008      	ands	r0, r1
c0d011d2:	210d      	movs	r1, #13
c0d011d4:	02c9      	lsls	r1, r1, #11
c0d011d6:	4301      	orrs	r1, r0
c0d011d8:	a859      	add	r0, sp, #356	; 0x164
c0d011da:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d011dc:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d011de:	0a00      	lsrs	r0, r0, #8
c0d011e0:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d011e2:	4a24      	ldr	r2, [pc, #144]	; (c0d01274 <IOTA_main+0x2b0>)
c0d011e4:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d011e6:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d011e8:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d011ea:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d011ec:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d011ee:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d011f0:	1c80      	adds	r0, r0, #2
c0d011f2:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d011f4:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d011f6:	6030      	str	r0, [r6, #0]
c0d011f8:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d011fa:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d011fc:	2900      	cmp	r1, #0
c0d011fe:	d088      	beq.n	c0d01112 <IOTA_main+0x14e>
c0d01200:	e006      	b.n	c0d01210 <IOTA_main+0x24c>
c0d01202:	2808      	cmp	r0, #8
c0d01204:	d100      	bne.n	c0d01208 <IOTA_main+0x244>
c0d01206:	e6f6      	b.n	c0d00ff6 <IOTA_main+0x32>
c0d01208:	28ff      	cmp	r0, #255	; 0xff
c0d0120a:	d113      	bne.n	c0d01234 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d0120c:	b05d      	add	sp, #372	; 0x174
c0d0120e:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d01210:	f002 fcb8 	bl	c0d03b84 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d01214:	2001      	movs	r0, #1
c0d01216:	4918      	ldr	r1, [pc, #96]	; (c0d01278 <IOTA_main+0x2b4>)
c0d01218:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d0121a:	4813      	ldr	r0, [pc, #76]	; (c0d01268 <IOTA_main+0x2a4>)
c0d0121c:	6800      	ldr	r0, [r0, #0]
c0d0121e:	491c      	ldr	r1, [pc, #112]	; (c0d01290 <IOTA_main+0x2cc>)
c0d01220:	f002 fcb0 	bl	c0d03b84 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d01224:	2001      	movs	r0, #1
c0d01226:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d01228:	480f      	ldr	r0, [pc, #60]	; (c0d01268 <IOTA_main+0x2a4>)
c0d0122a:	6800      	ldr	r0, [r0, #0]
c0d0122c:	2137      	movs	r1, #55	; 0x37
c0d0122e:	0249      	lsls	r1, r1, #9
c0d01230:	f002 fca8 	bl	c0d03b84 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d01234:	2001      	movs	r0, #1
c0d01236:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d01238:	480b      	ldr	r0, [pc, #44]	; (c0d01268 <IOTA_main+0x2a4>)
c0d0123a:	6800      	ldr	r0, [r0, #0]
c0d0123c:	f002 fca2 	bl	c0d03b84 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d01240:	4809      	ldr	r0, [pc, #36]	; (c0d01268 <IOTA_main+0x2a4>)
c0d01242:	6800      	ldr	r0, [r0, #0]
c0d01244:	490e      	ldr	r1, [pc, #56]	; (c0d01280 <IOTA_main+0x2bc>)
c0d01246:	f002 fc9d 	bl	c0d03b84 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d0124a:	2001      	movs	r0, #1
c0d0124c:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d0124e:	4806      	ldr	r0, [pc, #24]	; (c0d01268 <IOTA_main+0x2a4>)
c0d01250:	6800      	ldr	r0, [r0, #0]
c0d01252:	3109      	adds	r1, #9
c0d01254:	f002 fc96 	bl	c0d03b84 <longjmp>
c0d01258:	74696157 	.word	0x74696157
c0d0125c:	20676e69 	.word	0x20676e69
c0d01260:	20726f66 	.word	0x20726f66
c0d01264:	0067736d 	.word	0x0067736d
c0d01268:	20001bb8 	.word	0x20001bb8
c0d0126c:	0000ffff 	.word	0x0000ffff
c0d01270:	000007ff 	.word	0x000007ff
c0d01274:	20001c08 	.word	0x20001c08
c0d01278:	20001b48 	.word	0x20001b48
c0d0127c:	20001b4c 	.word	0x20001b4c
c0d01280:	00006a86 	.word	0x00006a86
c0d01284:	20646142 	.word	0x20646142
c0d01288:	6b627550 	.word	0x6b627550
c0d0128c:	00007965 	.word	0x00007965
c0d01290:	00006982 	.word	0x00006982

c0d01294 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d01294:	4801      	ldr	r0, [pc, #4]	; (c0d0129c <os_boot+0x8>)
c0d01296:	2100      	movs	r1, #0
c0d01298:	6001      	str	r1, [r0, #0]
}
c0d0129a:	4770      	bx	lr
c0d0129c:	20001bb8 	.word	0x20001bb8

c0d012a0 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d012a0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d012a2:	af03      	add	r7, sp, #12
c0d012a4:	b083      	sub	sp, #12
c0d012a6:	9202      	str	r2, [sp, #8]
c0d012a8:	460c      	mov	r4, r1
c0d012aa:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d012ac:	4d4a      	ldr	r5, [pc, #296]	; (c0d013d8 <io_usb_hid_receive+0x138>)
c0d012ae:	42ac      	cmp	r4, r5
c0d012b0:	d00f      	beq.n	c0d012d2 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d012b2:	4e49      	ldr	r6, [pc, #292]	; (c0d013d8 <io_usb_hid_receive+0x138>)
c0d012b4:	2540      	movs	r5, #64	; 0x40
c0d012b6:	4630      	mov	r0, r6
c0d012b8:	4629      	mov	r1, r5
c0d012ba:	f002 fbc1 	bl	c0d03a40 <__aeabi_memclr>
c0d012be:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d012c0:	2840      	cmp	r0, #64	; 0x40
c0d012c2:	4602      	mov	r2, r0
c0d012c4:	d300      	bcc.n	c0d012c8 <io_usb_hid_receive+0x28>
c0d012c6:	462a      	mov	r2, r5
c0d012c8:	4630      	mov	r0, r6
c0d012ca:	4621      	mov	r1, r4
c0d012cc:	f000 f89e 	bl	c0d0140c <os_memmove>
c0d012d0:	4d41      	ldr	r5, [pc, #260]	; (c0d013d8 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d012d2:	78a8      	ldrb	r0, [r5, #2]
c0d012d4:	2805      	cmp	r0, #5
c0d012d6:	d900      	bls.n	c0d012da <io_usb_hid_receive+0x3a>
c0d012d8:	e076      	b.n	c0d013c8 <io_usb_hid_receive+0x128>
c0d012da:	46c0      	nop			; (mov r8, r8)
c0d012dc:	4478      	add	r0, pc
c0d012de:	7900      	ldrb	r0, [r0, #4]
c0d012e0:	0040      	lsls	r0, r0, #1
c0d012e2:	4487      	add	pc, r0
c0d012e4:	71130c02 	.word	0x71130c02
c0d012e8:	1f71      	.short	0x1f71
c0d012ea:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d012ec:	71ae      	strb	r6, [r5, #6]
c0d012ee:	716e      	strb	r6, [r5, #5]
c0d012f0:	712e      	strb	r6, [r5, #4]
c0d012f2:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d012f4:	2140      	movs	r1, #64	; 0x40
c0d012f6:	4628      	mov	r0, r5
c0d012f8:	9a01      	ldr	r2, [sp, #4]
c0d012fa:	4790      	blx	r2
c0d012fc:	e00b      	b.n	c0d01316 <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d012fe:	1ce8      	adds	r0, r5, #3
c0d01300:	2104      	movs	r1, #4
c0d01302:	f000 ff73 	bl	c0d021ec <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d01306:	2140      	movs	r1, #64	; 0x40
c0d01308:	4628      	mov	r0, r5
c0d0130a:	e001      	b.n	c0d01310 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d0130c:	4832      	ldr	r0, [pc, #200]	; (c0d013d8 <io_usb_hid_receive+0x138>)
c0d0130e:	2140      	movs	r1, #64	; 0x40
c0d01310:	9a01      	ldr	r2, [sp, #4]
c0d01312:	4790      	blx	r2
c0d01314:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01316:	4831      	ldr	r0, [pc, #196]	; (c0d013dc <io_usb_hid_receive+0x13c>)
c0d01318:	2100      	movs	r1, #0
c0d0131a:	6001      	str	r1, [r0, #0]
c0d0131c:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d0131e:	b2c0      	uxtb	r0, r0
c0d01320:	b003      	add	sp, #12
c0d01322:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d01324:	78e8      	ldrb	r0, [r5, #3]
c0d01326:	4c2d      	ldr	r4, [pc, #180]	; (c0d013dc <io_usb_hid_receive+0x13c>)
c0d01328:	6821      	ldr	r1, [r4, #0]
c0d0132a:	0a09      	lsrs	r1, r1, #8
c0d0132c:	2600      	movs	r6, #0
c0d0132e:	4288      	cmp	r0, r1
c0d01330:	d1f1      	bne.n	c0d01316 <io_usb_hid_receive+0x76>
c0d01332:	7928      	ldrb	r0, [r5, #4]
c0d01334:	6821      	ldr	r1, [r4, #0]
c0d01336:	b2c9      	uxtb	r1, r1
c0d01338:	4288      	cmp	r0, r1
c0d0133a:	d1ec      	bne.n	c0d01316 <io_usb_hid_receive+0x76>
c0d0133c:	4b28      	ldr	r3, [pc, #160]	; (c0d013e0 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d0133e:	9802      	ldr	r0, [sp, #8]
c0d01340:	18c0      	adds	r0, r0, r3
c0d01342:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d01344:	6820      	ldr	r0, [r4, #0]
c0d01346:	2800      	cmp	r0, #0
c0d01348:	d00e      	beq.n	c0d01368 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d0134a:	4629      	mov	r1, r5
c0d0134c:	4019      	ands	r1, r3
c0d0134e:	4825      	ldr	r0, [pc, #148]	; (c0d013e4 <io_usb_hid_receive+0x144>)
c0d01350:	6802      	ldr	r2, [r0, #0]
c0d01352:	4291      	cmp	r1, r2
c0d01354:	461e      	mov	r6, r3
c0d01356:	d900      	bls.n	c0d0135a <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d01358:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d0135a:	462a      	mov	r2, r5
c0d0135c:	4032      	ands	r2, r6
c0d0135e:	4822      	ldr	r0, [pc, #136]	; (c0d013e8 <io_usb_hid_receive+0x148>)
c0d01360:	6800      	ldr	r0, [r0, #0]
c0d01362:	491d      	ldr	r1, [pc, #116]	; (c0d013d8 <io_usb_hid_receive+0x138>)
c0d01364:	1d49      	adds	r1, r1, #5
c0d01366:	e021      	b.n	c0d013ac <io_usb_hid_receive+0x10c>
c0d01368:	9301      	str	r3, [sp, #4]
c0d0136a:	491b      	ldr	r1, [pc, #108]	; (c0d013d8 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d0136c:	7988      	ldrb	r0, [r1, #6]
c0d0136e:	7949      	ldrb	r1, [r1, #5]
c0d01370:	0209      	lsls	r1, r1, #8
c0d01372:	4301      	orrs	r1, r0
c0d01374:	481d      	ldr	r0, [pc, #116]	; (c0d013ec <io_usb_hid_receive+0x14c>)
c0d01376:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d01378:	6801      	ldr	r1, [r0, #0]
c0d0137a:	2241      	movs	r2, #65	; 0x41
c0d0137c:	0092      	lsls	r2, r2, #2
c0d0137e:	4291      	cmp	r1, r2
c0d01380:	d8c9      	bhi.n	c0d01316 <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d01382:	6801      	ldr	r1, [r0, #0]
c0d01384:	4817      	ldr	r0, [pc, #92]	; (c0d013e4 <io_usb_hid_receive+0x144>)
c0d01386:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01388:	4917      	ldr	r1, [pc, #92]	; (c0d013e8 <io_usb_hid_receive+0x148>)
c0d0138a:	4a19      	ldr	r2, [pc, #100]	; (c0d013f0 <io_usb_hid_receive+0x150>)
c0d0138c:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d0138e:	4919      	ldr	r1, [pc, #100]	; (c0d013f4 <io_usb_hid_receive+0x154>)
c0d01390:	9a02      	ldr	r2, [sp, #8]
c0d01392:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d01394:	4629      	mov	r1, r5
c0d01396:	9e01      	ldr	r6, [sp, #4]
c0d01398:	4031      	ands	r1, r6
c0d0139a:	6802      	ldr	r2, [r0, #0]
c0d0139c:	4291      	cmp	r1, r2
c0d0139e:	d900      	bls.n	c0d013a2 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d013a0:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d013a2:	462a      	mov	r2, r5
c0d013a4:	4032      	ands	r2, r6
c0d013a6:	480c      	ldr	r0, [pc, #48]	; (c0d013d8 <io_usb_hid_receive+0x138>)
c0d013a8:	1dc1      	adds	r1, r0, #7
c0d013aa:	4811      	ldr	r0, [pc, #68]	; (c0d013f0 <io_usb_hid_receive+0x150>)
c0d013ac:	f000 f82e 	bl	c0d0140c <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d013b0:	4035      	ands	r5, r6
c0d013b2:	480d      	ldr	r0, [pc, #52]	; (c0d013e8 <io_usb_hid_receive+0x148>)
c0d013b4:	6801      	ldr	r1, [r0, #0]
c0d013b6:	1949      	adds	r1, r1, r5
c0d013b8:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d013ba:	480a      	ldr	r0, [pc, #40]	; (c0d013e4 <io_usb_hid_receive+0x144>)
c0d013bc:	6801      	ldr	r1, [r0, #0]
c0d013be:	1b49      	subs	r1, r1, r5
c0d013c0:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d013c2:	6820      	ldr	r0, [r4, #0]
c0d013c4:	1c40      	adds	r0, r0, #1
c0d013c6:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d013c8:	4806      	ldr	r0, [pc, #24]	; (c0d013e4 <io_usb_hid_receive+0x144>)
c0d013ca:	6801      	ldr	r1, [r0, #0]
c0d013cc:	2001      	movs	r0, #1
c0d013ce:	2602      	movs	r6, #2
c0d013d0:	2900      	cmp	r1, #0
c0d013d2:	d1a4      	bne.n	c0d0131e <io_usb_hid_receive+0x7e>
c0d013d4:	e79f      	b.n	c0d01316 <io_usb_hid_receive+0x76>
c0d013d6:	46c0      	nop			; (mov r8, r8)
c0d013d8:	20001bbc 	.word	0x20001bbc
c0d013dc:	20001bfc 	.word	0x20001bfc
c0d013e0:	0000ffff 	.word	0x0000ffff
c0d013e4:	20001c04 	.word	0x20001c04
c0d013e8:	20001d0c 	.word	0x20001d0c
c0d013ec:	20001c00 	.word	0x20001c00
c0d013f0:	20001c08 	.word	0x20001c08
c0d013f4:	0001fff9 	.word	0x0001fff9

c0d013f8 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d013f8:	b580      	push	{r7, lr}
c0d013fa:	af00      	add	r7, sp, #0
c0d013fc:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d013fe:	2a00      	cmp	r2, #0
c0d01400:	d003      	beq.n	c0d0140a <os_memset+0x12>
    DSTCHAR[length] = c;
c0d01402:	4611      	mov	r1, r2
c0d01404:	461a      	mov	r2, r3
c0d01406:	f002 fb25 	bl	c0d03a54 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d0140a:	bd80      	pop	{r7, pc}

c0d0140c <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d0140c:	b5b0      	push	{r4, r5, r7, lr}
c0d0140e:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d01410:	4288      	cmp	r0, r1
c0d01412:	d90d      	bls.n	c0d01430 <os_memmove+0x24>
    while(length--) {
c0d01414:	2a00      	cmp	r2, #0
c0d01416:	d014      	beq.n	c0d01442 <os_memmove+0x36>
c0d01418:	1e49      	subs	r1, r1, #1
c0d0141a:	4252      	negs	r2, r2
c0d0141c:	1e40      	subs	r0, r0, #1
c0d0141e:	2300      	movs	r3, #0
c0d01420:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d01422:	461c      	mov	r4, r3
c0d01424:	4354      	muls	r4, r2
c0d01426:	5d0d      	ldrb	r5, [r1, r4]
c0d01428:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d0142a:	1c52      	adds	r2, r2, #1
c0d0142c:	d1f9      	bne.n	c0d01422 <os_memmove+0x16>
c0d0142e:	e008      	b.n	c0d01442 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01430:	2a00      	cmp	r2, #0
c0d01432:	d006      	beq.n	c0d01442 <os_memmove+0x36>
c0d01434:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d01436:	b29c      	uxth	r4, r3
c0d01438:	5d0d      	ldrb	r5, [r1, r4]
c0d0143a:	5505      	strb	r5, [r0, r4]
      l++;
c0d0143c:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d0143e:	1e52      	subs	r2, r2, #1
c0d01440:	d1f9      	bne.n	c0d01436 <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d01442:	bdb0      	pop	{r4, r5, r7, pc}

c0d01444 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01444:	4801      	ldr	r0, [pc, #4]	; (c0d0144c <io_usb_hid_init+0x8>)
c0d01446:	2100      	movs	r1, #0
c0d01448:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d0144a:	4770      	bx	lr
c0d0144c:	20001bfc 	.word	0x20001bfc

c0d01450 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d01450:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01452:	af03      	add	r7, sp, #12
c0d01454:	b087      	sub	sp, #28
c0d01456:	9301      	str	r3, [sp, #4]
c0d01458:	9203      	str	r2, [sp, #12]
c0d0145a:	460e      	mov	r6, r1
c0d0145c:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d0145e:	2e00      	cmp	r6, #0
c0d01460:	d042      	beq.n	c0d014e8 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d01462:	4d31      	ldr	r5, [pc, #196]	; (c0d01528 <io_usb_hid_exchange+0xd8>)
c0d01464:	2000      	movs	r0, #0
c0d01466:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01468:	4930      	ldr	r1, [pc, #192]	; (c0d0152c <io_usb_hid_exchange+0xdc>)
c0d0146a:	4831      	ldr	r0, [pc, #196]	; (c0d01530 <io_usb_hid_exchange+0xe0>)
c0d0146c:	6008      	str	r0, [r1, #0]
c0d0146e:	4c31      	ldr	r4, [pc, #196]	; (c0d01534 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01470:	1d60      	adds	r0, r4, #5
c0d01472:	213b      	movs	r1, #59	; 0x3b
c0d01474:	9005      	str	r0, [sp, #20]
c0d01476:	9102      	str	r1, [sp, #8]
c0d01478:	f002 fae2 	bl	c0d03a40 <__aeabi_memclr>
c0d0147c:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d0147e:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d01480:	6828      	ldr	r0, [r5, #0]
c0d01482:	0a00      	lsrs	r0, r0, #8
c0d01484:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d01486:	6828      	ldr	r0, [r5, #0]
c0d01488:	7120      	strb	r0, [r4, #4]
c0d0148a:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d0148c:	6828      	ldr	r0, [r5, #0]
c0d0148e:	2800      	cmp	r0, #0
c0d01490:	9106      	str	r1, [sp, #24]
c0d01492:	d009      	beq.n	c0d014a8 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d01494:	293b      	cmp	r1, #59	; 0x3b
c0d01496:	460a      	mov	r2, r1
c0d01498:	d300      	bcc.n	c0d0149c <io_usb_hid_exchange+0x4c>
c0d0149a:	9a02      	ldr	r2, [sp, #8]
c0d0149c:	4823      	ldr	r0, [pc, #140]	; (c0d0152c <io_usb_hid_exchange+0xdc>)
c0d0149e:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d014a0:	6819      	ldr	r1, [r3, #0]
c0d014a2:	9805      	ldr	r0, [sp, #20]
c0d014a4:	461e      	mov	r6, r3
c0d014a6:	e00a      	b.n	c0d014be <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d014a8:	0a30      	lsrs	r0, r6, #8
c0d014aa:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d014ac:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d014ae:	2039      	movs	r0, #57	; 0x39
c0d014b0:	2939      	cmp	r1, #57	; 0x39
c0d014b2:	460a      	mov	r2, r1
c0d014b4:	d300      	bcc.n	c0d014b8 <io_usb_hid_exchange+0x68>
c0d014b6:	4602      	mov	r2, r0
c0d014b8:	4e1c      	ldr	r6, [pc, #112]	; (c0d0152c <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d014ba:	6831      	ldr	r1, [r6, #0]
c0d014bc:	1de0      	adds	r0, r4, #7
c0d014be:	9205      	str	r2, [sp, #20]
c0d014c0:	f7ff ffa4 	bl	c0d0140c <os_memmove>
c0d014c4:	4d18      	ldr	r5, [pc, #96]	; (c0d01528 <io_usb_hid_exchange+0xd8>)
c0d014c6:	6830      	ldr	r0, [r6, #0]
c0d014c8:	4631      	mov	r1, r6
c0d014ca:	9e05      	ldr	r6, [sp, #20]
c0d014cc:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d014ce:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d014d0:	6828      	ldr	r0, [r5, #0]
c0d014d2:	1c40      	adds	r0, r0, #1
c0d014d4:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d014d6:	2140      	movs	r1, #64	; 0x40
c0d014d8:	4620      	mov	r0, r4
c0d014da:	9a04      	ldr	r2, [sp, #16]
c0d014dc:	4790      	blx	r2
c0d014de:	9806      	ldr	r0, [sp, #24]
c0d014e0:	1b86      	subs	r6, r0, r6
c0d014e2:	4815      	ldr	r0, [pc, #84]	; (c0d01538 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d014e4:	4206      	tst	r6, r0
c0d014e6:	d1c3      	bne.n	c0d01470 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d014e8:	480f      	ldr	r0, [pc, #60]	; (c0d01528 <io_usb_hid_exchange+0xd8>)
c0d014ea:	2400      	movs	r4, #0
c0d014ec:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d014ee:	2080      	movs	r0, #128	; 0x80
c0d014f0:	9901      	ldr	r1, [sp, #4]
c0d014f2:	4201      	tst	r1, r0
c0d014f4:	d001      	beq.n	c0d014fa <io_usb_hid_exchange+0xaa>
    reset();
c0d014f6:	f000 fe3f 	bl	c0d02178 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d014fa:	9801      	ldr	r0, [sp, #4]
c0d014fc:	0680      	lsls	r0, r0, #26
c0d014fe:	d40f      	bmi.n	c0d01520 <io_usb_hid_exchange+0xd0>
c0d01500:	4c0c      	ldr	r4, [pc, #48]	; (c0d01534 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d01502:	2140      	movs	r1, #64	; 0x40
c0d01504:	4620      	mov	r0, r4
c0d01506:	9a03      	ldr	r2, [sp, #12]
c0d01508:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d0150a:	b2c2      	uxtb	r2, r0
c0d0150c:	2a40      	cmp	r2, #64	; 0x40
c0d0150e:	d8f8      	bhi.n	c0d01502 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d01510:	9804      	ldr	r0, [sp, #16]
c0d01512:	4621      	mov	r1, r4
c0d01514:	f7ff fec4 	bl	c0d012a0 <io_usb_hid_receive>
c0d01518:	2802      	cmp	r0, #2
c0d0151a:	d1f2      	bne.n	c0d01502 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d0151c:	4807      	ldr	r0, [pc, #28]	; (c0d0153c <io_usb_hid_exchange+0xec>)
c0d0151e:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d01520:	b2a0      	uxth	r0, r4
c0d01522:	b007      	add	sp, #28
c0d01524:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01526:	46c0      	nop			; (mov r8, r8)
c0d01528:	20001bfc 	.word	0x20001bfc
c0d0152c:	20001d0c 	.word	0x20001d0c
c0d01530:	20001c08 	.word	0x20001c08
c0d01534:	20001bbc 	.word	0x20001bbc
c0d01538:	0000ffff 	.word	0x0000ffff
c0d0153c:	20001c00 	.word	0x20001c00

c0d01540 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d01540:	b580      	push	{r7, lr}
c0d01542:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d01544:	f000 ffbc 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d01548:	2800      	cmp	r0, #0
c0d0154a:	d10b      	bne.n	c0d01564 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d0154c:	4806      	ldr	r0, [pc, #24]	; (c0d01568 <io_seproxyhal_general_status+0x28>)
c0d0154e:	2160      	movs	r1, #96	; 0x60
c0d01550:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d01552:	2100      	movs	r1, #0
c0d01554:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d01556:	2202      	movs	r2, #2
c0d01558:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d0155a:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d0155c:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d0155e:	2105      	movs	r1, #5
c0d01560:	f000 ff90 	bl	c0d02484 <io_seproxyhal_spi_send>
}
c0d01564:	bd80      	pop	{r7, pc}
c0d01566:	46c0      	nop			; (mov r8, r8)
c0d01568:	20001a18 	.word	0x20001a18

c0d0156c <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d0156c:	b5d0      	push	{r4, r6, r7, lr}
c0d0156e:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d01570:	4815      	ldr	r0, [pc, #84]	; (c0d015c8 <io_seproxyhal_handle_usb_event+0x5c>)
c0d01572:	78c0      	ldrb	r0, [r0, #3]
c0d01574:	1e40      	subs	r0, r0, #1
c0d01576:	2807      	cmp	r0, #7
c0d01578:	d824      	bhi.n	c0d015c4 <io_seproxyhal_handle_usb_event+0x58>
c0d0157a:	46c0      	nop			; (mov r8, r8)
c0d0157c:	4478      	add	r0, pc
c0d0157e:	7900      	ldrb	r0, [r0, #4]
c0d01580:	0040      	lsls	r0, r0, #1
c0d01582:	4487      	add	pc, r0
c0d01584:	141f1803 	.word	0x141f1803
c0d01588:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d0158c:	4c0f      	ldr	r4, [pc, #60]	; (c0d015cc <io_seproxyhal_handle_usb_event+0x60>)
c0d0158e:	2101      	movs	r1, #1
c0d01590:	4620      	mov	r0, r4
c0d01592:	f001 fbd5 	bl	c0d02d40 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d01596:	4620      	mov	r0, r4
c0d01598:	f001 fbba 	bl	c0d02d10 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d0159c:	480c      	ldr	r0, [pc, #48]	; (c0d015d0 <io_seproxyhal_handle_usb_event+0x64>)
c0d0159e:	7800      	ldrb	r0, [r0, #0]
c0d015a0:	2801      	cmp	r0, #1
c0d015a2:	d10f      	bne.n	c0d015c4 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d015a4:	480b      	ldr	r0, [pc, #44]	; (c0d015d4 <io_seproxyhal_handle_usb_event+0x68>)
c0d015a6:	6800      	ldr	r0, [r0, #0]
c0d015a8:	2110      	movs	r1, #16
c0d015aa:	f002 faeb 	bl	c0d03b84 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d015ae:	4807      	ldr	r0, [pc, #28]	; (c0d015cc <io_seproxyhal_handle_usb_event+0x60>)
c0d015b0:	f001 fbc9 	bl	c0d02d46 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d015b4:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d015b6:	4805      	ldr	r0, [pc, #20]	; (c0d015cc <io_seproxyhal_handle_usb_event+0x60>)
c0d015b8:	f001 fbc9 	bl	c0d02d4e <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d015bc:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d015be:	4803      	ldr	r0, [pc, #12]	; (c0d015cc <io_seproxyhal_handle_usb_event+0x60>)
c0d015c0:	f001 fbc3 	bl	c0d02d4a <USBD_LL_Resume>
      break;
  }
}
c0d015c4:	bdd0      	pop	{r4, r6, r7, pc}
c0d015c6:	46c0      	nop			; (mov r8, r8)
c0d015c8:	20001a18 	.word	0x20001a18
c0d015cc:	20001d34 	.word	0x20001d34
c0d015d0:	20001d10 	.word	0x20001d10
c0d015d4:	20001bb8 	.word	0x20001bb8

c0d015d8 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d015d8:	217f      	movs	r1, #127	; 0x7f
c0d015da:	4001      	ands	r1, r0
c0d015dc:	4801      	ldr	r0, [pc, #4]	; (c0d015e4 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d015de:	5c40      	ldrb	r0, [r0, r1]
c0d015e0:	4770      	bx	lr
c0d015e2:	46c0      	nop			; (mov r8, r8)
c0d015e4:	20001d11 	.word	0x20001d11

c0d015e8 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d015e8:	b580      	push	{r7, lr}
c0d015ea:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d015ec:	480f      	ldr	r0, [pc, #60]	; (c0d0162c <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d015ee:	7901      	ldrb	r1, [r0, #4]
c0d015f0:	2904      	cmp	r1, #4
c0d015f2:	d008      	beq.n	c0d01606 <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d015f4:	2902      	cmp	r1, #2
c0d015f6:	d011      	beq.n	c0d0161c <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d015f8:	2901      	cmp	r1, #1
c0d015fa:	d10e      	bne.n	c0d0161a <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d015fc:	1d81      	adds	r1, r0, #6
c0d015fe:	480d      	ldr	r0, [pc, #52]	; (c0d01634 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01600:	f001 faaa 	bl	c0d02b58 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d01604:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d01606:	78c2      	ldrb	r2, [r0, #3]
c0d01608:	217f      	movs	r1, #127	; 0x7f
c0d0160a:	4011      	ands	r1, r2
c0d0160c:	7942      	ldrb	r2, [r0, #5]
c0d0160e:	4b08      	ldr	r3, [pc, #32]	; (c0d01630 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d01610:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01612:	1d82      	adds	r2, r0, #6
c0d01614:	4807      	ldr	r0, [pc, #28]	; (c0d01634 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01616:	f001 fad1 	bl	c0d02bbc <USBD_LL_DataOutStage>
      break;
  }
}
c0d0161a:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d0161c:	78c2      	ldrb	r2, [r0, #3]
c0d0161e:	217f      	movs	r1, #127	; 0x7f
c0d01620:	4011      	ands	r1, r2
c0d01622:	1d82      	adds	r2, r0, #6
c0d01624:	4803      	ldr	r0, [pc, #12]	; (c0d01634 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01626:	f001 fb0f 	bl	c0d02c48 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d0162a:	bd80      	pop	{r7, pc}
c0d0162c:	20001a18 	.word	0x20001a18
c0d01630:	20001d11 	.word	0x20001d11
c0d01634:	20001d34 	.word	0x20001d34

c0d01638 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d01638:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0163a:	af03      	add	r7, sp, #12
c0d0163c:	b083      	sub	sp, #12
c0d0163e:	9201      	str	r2, [sp, #4]
c0d01640:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d01642:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d01644:	2b00      	cmp	r3, #0
c0d01646:	d100      	bne.n	c0d0164a <io_usb_send_ep+0x12>
c0d01648:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d0164a:	9801      	ldr	r0, [sp, #4]
c0d0164c:	28ff      	cmp	r0, #255	; 0xff
c0d0164e:	d843      	bhi.n	c0d016d8 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01650:	4e25      	ldr	r6, [pc, #148]	; (c0d016e8 <io_usb_send_ep+0xb0>)
c0d01652:	2050      	movs	r0, #80	; 0x50
c0d01654:	7030      	strb	r0, [r6, #0]
c0d01656:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d01658:	1ce0      	adds	r0, r4, #3
c0d0165a:	9100      	str	r1, [sp, #0]
c0d0165c:	0a01      	lsrs	r1, r0, #8
c0d0165e:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d01660:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d01662:	2080      	movs	r0, #128	; 0x80
c0d01664:	4302      	orrs	r2, r0
c0d01666:	9202      	str	r2, [sp, #8]
c0d01668:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0166a:	2020      	movs	r0, #32
c0d0166c:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d0166e:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d01670:	2106      	movs	r1, #6
c0d01672:	4630      	mov	r0, r6
c0d01674:	f000 ff06 	bl	c0d02484 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d01678:	9800      	ldr	r0, [sp, #0]
c0d0167a:	4621      	mov	r1, r4
c0d0167c:	f000 ff02 	bl	c0d02484 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d01680:	2d00      	cmp	r5, #0
c0d01682:	d10d      	bne.n	c0d016a0 <io_usb_send_ep+0x68>
c0d01684:	e028      	b.n	c0d016d8 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d01686:	2d00      	cmp	r5, #0
c0d01688:	d002      	beq.n	c0d01690 <io_usb_send_ep+0x58>
c0d0168a:	1e6c      	subs	r4, r5, #1
c0d0168c:	2d01      	cmp	r5, #1
c0d0168e:	d025      	beq.n	c0d016dc <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d01690:	2915      	cmp	r1, #21
c0d01692:	d102      	bne.n	c0d0169a <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d01694:	79b0      	ldrb	r0, [r6, #6]
c0d01696:	0700      	lsls	r0, r0, #28
c0d01698:	d520      	bpl.n	c0d016dc <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d0169a:	f000 f829 	bl	c0d016f0 <io_seproxyhal_handle_event>
c0d0169e:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d016a0:	f000 ff0e 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d016a4:	2800      	cmp	r0, #0
c0d016a6:	d101      	bne.n	c0d016ac <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d016a8:	f7ff ff4a 	bl	c0d01540 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d016ac:	2180      	movs	r1, #128	; 0x80
c0d016ae:	2400      	movs	r4, #0
c0d016b0:	4630      	mov	r0, r6
c0d016b2:	4622      	mov	r2, r4
c0d016b4:	f000 ff20 	bl	c0d024f8 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d016b8:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d016ba:	2806      	cmp	r0, #6
c0d016bc:	d1e3      	bne.n	c0d01686 <io_usb_send_ep+0x4e>
c0d016be:	2910      	cmp	r1, #16
c0d016c0:	d1e1      	bne.n	c0d01686 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d016c2:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d016c4:	9a02      	ldr	r2, [sp, #8]
c0d016c6:	4290      	cmp	r0, r2
c0d016c8:	d1dd      	bne.n	c0d01686 <io_usb_send_ep+0x4e>
c0d016ca:	7930      	ldrb	r0, [r6, #4]
c0d016cc:	2802      	cmp	r0, #2
c0d016ce:	d1da      	bne.n	c0d01686 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d016d0:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d016d2:	9a01      	ldr	r2, [sp, #4]
c0d016d4:	4290      	cmp	r0, r2
c0d016d6:	d1d6      	bne.n	c0d01686 <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d016d8:	b003      	add	sp, #12
c0d016da:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d016dc:	4803      	ldr	r0, [pc, #12]	; (c0d016ec <io_usb_send_ep+0xb4>)
c0d016de:	6800      	ldr	r0, [r0, #0]
c0d016e0:	2110      	movs	r1, #16
c0d016e2:	f002 fa4f 	bl	c0d03b84 <longjmp>
c0d016e6:	46c0      	nop			; (mov r8, r8)
c0d016e8:	20001a18 	.word	0x20001a18
c0d016ec:	20001bb8 	.word	0x20001bb8

c0d016f0 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d016f0:	b580      	push	{r7, lr}
c0d016f2:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d016f4:	480d      	ldr	r0, [pc, #52]	; (c0d0172c <io_seproxyhal_handle_event+0x3c>)
c0d016f6:	7882      	ldrb	r2, [r0, #2]
c0d016f8:	7841      	ldrb	r1, [r0, #1]
c0d016fa:	0209      	lsls	r1, r1, #8
c0d016fc:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d016fe:	7800      	ldrb	r0, [r0, #0]
c0d01700:	2810      	cmp	r0, #16
c0d01702:	d008      	beq.n	c0d01716 <io_seproxyhal_handle_event+0x26>
c0d01704:	280f      	cmp	r0, #15
c0d01706:	d10d      	bne.n	c0d01724 <io_seproxyhal_handle_event+0x34>
c0d01708:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d0170a:	2904      	cmp	r1, #4
c0d0170c:	d10d      	bne.n	c0d0172a <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d0170e:	f7ff ff2d 	bl	c0d0156c <io_seproxyhal_handle_usb_event>
c0d01712:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01714:	bd80      	pop	{r7, pc}
c0d01716:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d01718:	2906      	cmp	r1, #6
c0d0171a:	d306      	bcc.n	c0d0172a <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d0171c:	f7ff ff64 	bl	c0d015e8 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d01720:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01722:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d01724:	2002      	movs	r0, #2
c0d01726:	f7ff faf5 	bl	c0d00d14 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d0172a:	bd80      	pop	{r7, pc}
c0d0172c:	20001a18 	.word	0x20001a18

c0d01730 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01730:	b580      	push	{r7, lr}
c0d01732:	af00      	add	r7, sp, #0
c0d01734:	460a      	mov	r2, r1
c0d01736:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01738:	2082      	movs	r0, #130	; 0x82
c0d0173a:	2314      	movs	r3, #20
c0d0173c:	f7ff ff7c 	bl	c0d01638 <io_usb_send_ep>
}
c0d01740:	bd80      	pop	{r7, pc}
	...

c0d01744 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01744:	b5d0      	push	{r4, r6, r7, lr}
c0d01746:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01748:	2007      	movs	r0, #7
c0d0174a:	f000 fcf7 	bl	c0d0213c <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d0174e:	480a      	ldr	r0, [pc, #40]	; (c0d01778 <io_seproxyhal_init+0x34>)
c0d01750:	2400      	movs	r4, #0
c0d01752:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01754:	4809      	ldr	r0, [pc, #36]	; (c0d0177c <io_seproxyhal_init+0x38>)
c0d01756:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d01758:	4809      	ldr	r0, [pc, #36]	; (c0d01780 <io_seproxyhal_init+0x3c>)
c0d0175a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d0175c:	4809      	ldr	r0, [pc, #36]	; (c0d01784 <io_seproxyhal_init+0x40>)
c0d0175e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01760:	4809      	ldr	r0, [pc, #36]	; (c0d01788 <io_seproxyhal_init+0x44>)
c0d01762:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d01764:	f7ff fe6e 	bl	c0d01444 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01768:	4808      	ldr	r0, [pc, #32]	; (c0d0178c <io_seproxyhal_init+0x48>)
c0d0176a:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d0176c:	4808      	ldr	r0, [pc, #32]	; (c0d01790 <io_seproxyhal_init+0x4c>)
c0d0176e:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d01770:	4808      	ldr	r0, [pc, #32]	; (c0d01794 <io_seproxyhal_init+0x50>)
c0d01772:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d01774:	bdd0      	pop	{r4, r6, r7, pc}
c0d01776:	46c0      	nop			; (mov r8, r8)
c0d01778:	20001d18 	.word	0x20001d18
c0d0177c:	20001d1a 	.word	0x20001d1a
c0d01780:	20001d1c 	.word	0x20001d1c
c0d01784:	20001d1e 	.word	0x20001d1e
c0d01788:	20001d10 	.word	0x20001d10
c0d0178c:	20001d20 	.word	0x20001d20
c0d01790:	20001d24 	.word	0x20001d24
c0d01794:	20001d28 	.word	0x20001d28

c0d01798 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01798:	4801      	ldr	r0, [pc, #4]	; (c0d017a0 <io_seproxyhal_init_ux+0x8>)
c0d0179a:	2100      	movs	r1, #0
c0d0179c:	6001      	str	r1, [r0, #0]

}
c0d0179e:	4770      	bx	lr
c0d017a0:	20001d20 	.word	0x20001d20

c0d017a4 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d017a4:	b5b0      	push	{r4, r5, r7, lr}
c0d017a6:	af02      	add	r7, sp, #8
c0d017a8:	460d      	mov	r5, r1
c0d017aa:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d017ac:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d017ae:	2800      	cmp	r0, #0
c0d017b0:	d00c      	beq.n	c0d017cc <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d017b2:	f000 fcab 	bl	c0d0210c <pic>
c0d017b6:	4601      	mov	r1, r0
c0d017b8:	4620      	mov	r0, r4
c0d017ba:	4788      	blx	r1
c0d017bc:	f000 fca6 	bl	c0d0210c <pic>
c0d017c0:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d017c2:	2800      	cmp	r0, #0
c0d017c4:	d010      	beq.n	c0d017e8 <io_seproxyhal_touch_out+0x44>
c0d017c6:	2801      	cmp	r0, #1
c0d017c8:	d000      	beq.n	c0d017cc <io_seproxyhal_touch_out+0x28>
c0d017ca:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d017cc:	2d00      	cmp	r5, #0
c0d017ce:	d007      	beq.n	c0d017e0 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d017d0:	4620      	mov	r0, r4
c0d017d2:	47a8      	blx	r5
c0d017d4:	2100      	movs	r1, #0
    if (!el) {
c0d017d6:	2800      	cmp	r0, #0
c0d017d8:	d006      	beq.n	c0d017e8 <io_seproxyhal_touch_out+0x44>
c0d017da:	2801      	cmp	r0, #1
c0d017dc:	d000      	beq.n	c0d017e0 <io_seproxyhal_touch_out+0x3c>
c0d017de:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d017e0:	4620      	mov	r0, r4
c0d017e2:	f7ff fa91 	bl	c0d00d08 <io_seproxyhal_display>
c0d017e6:	2101      	movs	r1, #1
  return 1;
}
c0d017e8:	4608      	mov	r0, r1
c0d017ea:	bdb0      	pop	{r4, r5, r7, pc}

c0d017ec <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d017ec:	b5b0      	push	{r4, r5, r7, lr}
c0d017ee:	af02      	add	r7, sp, #8
c0d017f0:	b08e      	sub	sp, #56	; 0x38
c0d017f2:	460c      	mov	r4, r1
c0d017f4:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d017f6:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d017f8:	2800      	cmp	r0, #0
c0d017fa:	d00c      	beq.n	c0d01816 <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d017fc:	f000 fc86 	bl	c0d0210c <pic>
c0d01800:	4601      	mov	r1, r0
c0d01802:	4628      	mov	r0, r5
c0d01804:	4788      	blx	r1
c0d01806:	f000 fc81 	bl	c0d0210c <pic>
c0d0180a:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0180c:	2800      	cmp	r0, #0
c0d0180e:	d016      	beq.n	c0d0183e <io_seproxyhal_touch_over+0x52>
c0d01810:	2801      	cmp	r0, #1
c0d01812:	d000      	beq.n	c0d01816 <io_seproxyhal_touch_over+0x2a>
c0d01814:	4605      	mov	r5, r0
c0d01816:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d01818:	2238      	movs	r2, #56	; 0x38
c0d0181a:	4629      	mov	r1, r5
c0d0181c:	f7ff fdf6 	bl	c0d0140c <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d01820:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01822:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01824:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d01826:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d01828:	2c00      	cmp	r4, #0
c0d0182a:	d004      	beq.n	c0d01836 <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d0182c:	4628      	mov	r0, r5
c0d0182e:	47a0      	blx	r4
c0d01830:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d01832:	2800      	cmp	r0, #0
c0d01834:	d003      	beq.n	c0d0183e <io_seproxyhal_touch_over+0x52>
c0d01836:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01838:	f7ff fa66 	bl	c0d00d08 <io_seproxyhal_display>
c0d0183c:	2101      	movs	r1, #1
  return 1;
}
c0d0183e:	4608      	mov	r0, r1
c0d01840:	b00e      	add	sp, #56	; 0x38
c0d01842:	bdb0      	pop	{r4, r5, r7, pc}

c0d01844 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01844:	b5b0      	push	{r4, r5, r7, lr}
c0d01846:	af02      	add	r7, sp, #8
c0d01848:	460d      	mov	r5, r1
c0d0184a:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d0184c:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d0184e:	2800      	cmp	r0, #0
c0d01850:	d00c      	beq.n	c0d0186c <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d01852:	f000 fc5b 	bl	c0d0210c <pic>
c0d01856:	4601      	mov	r1, r0
c0d01858:	4620      	mov	r0, r4
c0d0185a:	4788      	blx	r1
c0d0185c:	f000 fc56 	bl	c0d0210c <pic>
c0d01860:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01862:	2800      	cmp	r0, #0
c0d01864:	d010      	beq.n	c0d01888 <io_seproxyhal_touch_tap+0x44>
c0d01866:	2801      	cmp	r0, #1
c0d01868:	d000      	beq.n	c0d0186c <io_seproxyhal_touch_tap+0x28>
c0d0186a:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d0186c:	2d00      	cmp	r5, #0
c0d0186e:	d007      	beq.n	c0d01880 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d01870:	4620      	mov	r0, r4
c0d01872:	47a8      	blx	r5
c0d01874:	2100      	movs	r1, #0
    if (!el) {
c0d01876:	2800      	cmp	r0, #0
c0d01878:	d006      	beq.n	c0d01888 <io_seproxyhal_touch_tap+0x44>
c0d0187a:	2801      	cmp	r0, #1
c0d0187c:	d000      	beq.n	c0d01880 <io_seproxyhal_touch_tap+0x3c>
c0d0187e:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d01880:	4620      	mov	r0, r4
c0d01882:	f7ff fa41 	bl	c0d00d08 <io_seproxyhal_display>
c0d01886:	2101      	movs	r1, #1
  return 1;
}
c0d01888:	4608      	mov	r0, r1
c0d0188a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0188c <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d0188c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0188e:	af03      	add	r7, sp, #12
c0d01890:	b087      	sub	sp, #28
c0d01892:	9302      	str	r3, [sp, #8]
c0d01894:	9203      	str	r2, [sp, #12]
c0d01896:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01898:	2900      	cmp	r1, #0
c0d0189a:	d076      	beq.n	c0d0198a <io_seproxyhal_touch_element_callback+0xfe>
c0d0189c:	9004      	str	r0, [sp, #16]
c0d0189e:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d018a0:	9001      	str	r0, [sp, #4]
c0d018a2:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d018a4:	9000      	str	r0, [sp, #0]
c0d018a6:	2600      	movs	r6, #0
c0d018a8:	9606      	str	r6, [sp, #24]
c0d018aa:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d018ac:	f000 fe08 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d018b0:	2800      	cmp	r0, #0
c0d018b2:	d155      	bne.n	c0d01960 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d018b4:	2038      	movs	r0, #56	; 0x38
c0d018b6:	4370      	muls	r0, r6
c0d018b8:	9d04      	ldr	r5, [sp, #16]
c0d018ba:	182e      	adds	r6, r5, r0
c0d018bc:	4b36      	ldr	r3, [pc, #216]	; (c0d01998 <io_seproxyhal_touch_element_callback+0x10c>)
c0d018be:	681a      	ldr	r2, [r3, #0]
c0d018c0:	2101      	movs	r1, #1
c0d018c2:	4296      	cmp	r6, r2
c0d018c4:	d000      	beq.n	c0d018c8 <io_seproxyhal_touch_element_callback+0x3c>
c0d018c6:	9906      	ldr	r1, [sp, #24]
c0d018c8:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d018ca:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d018cc:	2800      	cmp	r0, #0
c0d018ce:	da41      	bge.n	c0d01954 <io_seproxyhal_touch_element_callback+0xc8>
c0d018d0:	2020      	movs	r0, #32
c0d018d2:	5c35      	ldrb	r5, [r6, r0]
c0d018d4:	2102      	movs	r1, #2
c0d018d6:	5e71      	ldrsh	r1, [r6, r1]
c0d018d8:	1b4a      	subs	r2, r1, r5
c0d018da:	9803      	ldr	r0, [sp, #12]
c0d018dc:	4282      	cmp	r2, r0
c0d018de:	dc39      	bgt.n	c0d01954 <io_seproxyhal_touch_element_callback+0xc8>
c0d018e0:	1869      	adds	r1, r5, r1
c0d018e2:	88f2      	ldrh	r2, [r6, #6]
c0d018e4:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d018e6:	9803      	ldr	r0, [sp, #12]
c0d018e8:	4288      	cmp	r0, r1
c0d018ea:	da33      	bge.n	c0d01954 <io_seproxyhal_touch_element_callback+0xc8>
c0d018ec:	2104      	movs	r1, #4
c0d018ee:	5e70      	ldrsh	r0, [r6, r1]
c0d018f0:	1b42      	subs	r2, r0, r5
c0d018f2:	9902      	ldr	r1, [sp, #8]
c0d018f4:	428a      	cmp	r2, r1
c0d018f6:	dc2d      	bgt.n	c0d01954 <io_seproxyhal_touch_element_callback+0xc8>
c0d018f8:	1940      	adds	r0, r0, r5
c0d018fa:	8931      	ldrh	r1, [r6, #8]
c0d018fc:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d018fe:	9902      	ldr	r1, [sp, #8]
c0d01900:	4281      	cmp	r1, r0
c0d01902:	da27      	bge.n	c0d01954 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01904:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d01906:	4286      	cmp	r6, r0
c0d01908:	d010      	beq.n	c0d0192c <io_seproxyhal_touch_element_callback+0xa0>
c0d0190a:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d0190c:	2800      	cmp	r0, #0
c0d0190e:	d00d      	beq.n	c0d0192c <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d01910:	9801      	ldr	r0, [sp, #4]
c0d01912:	2800      	cmp	r0, #0
c0d01914:	d005      	beq.n	c0d01922 <io_seproxyhal_touch_element_callback+0x96>
c0d01916:	4630      	mov	r0, r6
c0d01918:	9901      	ldr	r1, [sp, #4]
c0d0191a:	4788      	blx	r1
c0d0191c:	4b1e      	ldr	r3, [pc, #120]	; (c0d01998 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0191e:	2800      	cmp	r0, #0
c0d01920:	d018      	beq.n	c0d01954 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01922:	6818      	ldr	r0, [r3, #0]
c0d01924:	9901      	ldr	r1, [sp, #4]
c0d01926:	f7ff ff3d 	bl	c0d017a4 <io_seproxyhal_touch_out>
c0d0192a:	e008      	b.n	c0d0193e <io_seproxyhal_touch_element_callback+0xb2>
c0d0192c:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d0192e:	2801      	cmp	r0, #1
c0d01930:	d009      	beq.n	c0d01946 <io_seproxyhal_touch_element_callback+0xba>
c0d01932:	2802      	cmp	r0, #2
c0d01934:	d10e      	bne.n	c0d01954 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d01936:	4630      	mov	r0, r6
c0d01938:	9901      	ldr	r1, [sp, #4]
c0d0193a:	f7ff ff83 	bl	c0d01844 <io_seproxyhal_touch_tap>
c0d0193e:	4b16      	ldr	r3, [pc, #88]	; (c0d01998 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01940:	2800      	cmp	r0, #0
c0d01942:	d007      	beq.n	c0d01954 <io_seproxyhal_touch_element_callback+0xc8>
c0d01944:	e023      	b.n	c0d0198e <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d01946:	4630      	mov	r0, r6
c0d01948:	9901      	ldr	r1, [sp, #4]
c0d0194a:	f7ff ff4f 	bl	c0d017ec <io_seproxyhal_touch_over>
c0d0194e:	4b12      	ldr	r3, [pc, #72]	; (c0d01998 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01950:	2800      	cmp	r0, #0
c0d01952:	d11f      	bne.n	c0d01994 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01954:	1c64      	adds	r4, r4, #1
c0d01956:	b2e6      	uxtb	r6, r4
c0d01958:	9805      	ldr	r0, [sp, #20]
c0d0195a:	4286      	cmp	r6, r0
c0d0195c:	d3a6      	bcc.n	c0d018ac <io_seproxyhal_touch_element_callback+0x20>
c0d0195e:	e000      	b.n	c0d01962 <io_seproxyhal_touch_element_callback+0xd6>
c0d01960:	4b0d      	ldr	r3, [pc, #52]	; (c0d01998 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d01962:	9806      	ldr	r0, [sp, #24]
c0d01964:	0600      	lsls	r0, r0, #24
c0d01966:	d010      	beq.n	c0d0198a <io_seproxyhal_touch_element_callback+0xfe>
c0d01968:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d0196a:	2800      	cmp	r0, #0
c0d0196c:	d00d      	beq.n	c0d0198a <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0196e:	f000 fda7 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d01972:	4909      	ldr	r1, [pc, #36]	; (c0d01998 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01974:	2800      	cmp	r0, #0
c0d01976:	d108      	bne.n	c0d0198a <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01978:	6808      	ldr	r0, [r1, #0]
c0d0197a:	9901      	ldr	r1, [sp, #4]
c0d0197c:	f7ff ff12 	bl	c0d017a4 <io_seproxyhal_touch_out>
c0d01980:	4d05      	ldr	r5, [pc, #20]	; (c0d01998 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01982:	2800      	cmp	r0, #0
c0d01984:	d001      	beq.n	c0d0198a <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d01986:	2000      	movs	r0, #0
c0d01988:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d0198a:	b007      	add	sp, #28
c0d0198c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0198e:	2000      	movs	r0, #0
c0d01990:	6018      	str	r0, [r3, #0]
c0d01992:	e7fa      	b.n	c0d0198a <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d01994:	601e      	str	r6, [r3, #0]
c0d01996:	e7f8      	b.n	c0d0198a <io_seproxyhal_touch_element_callback+0xfe>
c0d01998:	20001d20 	.word	0x20001d20

c0d0199c <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d0199c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0199e:	af03      	add	r7, sp, #12
c0d019a0:	b08b      	sub	sp, #44	; 0x2c
c0d019a2:	460c      	mov	r4, r1
c0d019a4:	4601      	mov	r1, r0
c0d019a6:	ad04      	add	r5, sp, #16
c0d019a8:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d019aa:	4628      	mov	r0, r5
c0d019ac:	9203      	str	r2, [sp, #12]
c0d019ae:	f7ff fd2d 	bl	c0d0140c <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d019b2:	6821      	ldr	r1, [r4, #0]
c0d019b4:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d019b6:	6862      	ldr	r2, [r4, #4]
c0d019b8:	9502      	str	r5, [sp, #8]
c0d019ba:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d019bc:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d019be:	4e1a      	ldr	r6, [pc, #104]	; (c0d01a28 <io_seproxyhal_display_icon+0x8c>)
c0d019c0:	2365      	movs	r3, #101	; 0x65
c0d019c2:	4635      	mov	r5, r6
c0d019c4:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d019c6:	b292      	uxth	r2, r2
c0d019c8:	4342      	muls	r2, r0
c0d019ca:	b28b      	uxth	r3, r1
c0d019cc:	4353      	muls	r3, r2
c0d019ce:	08d9      	lsrs	r1, r3, #3
c0d019d0:	1c4e      	adds	r6, r1, #1
c0d019d2:	2207      	movs	r2, #7
c0d019d4:	4213      	tst	r3, r2
c0d019d6:	d100      	bne.n	c0d019da <io_seproxyhal_display_icon+0x3e>
c0d019d8:	460e      	mov	r6, r1
c0d019da:	4631      	mov	r1, r6
c0d019dc:	9101      	str	r1, [sp, #4]
c0d019de:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d019e0:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d019e2:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d019e4:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d019e6:	0a01      	lsrs	r1, r0, #8
c0d019e8:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d019ea:	70a8      	strb	r0, [r5, #2]
c0d019ec:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d019ee:	4628      	mov	r0, r5
c0d019f0:	f000 fd48 	bl	c0d02484 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d019f4:	9802      	ldr	r0, [sp, #8]
c0d019f6:	9903      	ldr	r1, [sp, #12]
c0d019f8:	f000 fd44 	bl	c0d02484 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d019fc:	68a0      	ldr	r0, [r4, #8]
c0d019fe:	7028      	strb	r0, [r5, #0]
c0d01a00:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d01a02:	4628      	mov	r0, r5
c0d01a04:	f000 fd3e 	bl	c0d02484 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d01a08:	68e0      	ldr	r0, [r4, #12]
c0d01a0a:	f000 fb7f 	bl	c0d0210c <pic>
c0d01a0e:	b2b1      	uxth	r1, r6
c0d01a10:	f000 fd38 	bl	c0d02484 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01a14:	9801      	ldr	r0, [sp, #4]
c0d01a16:	b285      	uxth	r5, r0
c0d01a18:	6920      	ldr	r0, [r4, #16]
c0d01a1a:	f000 fb77 	bl	c0d0210c <pic>
c0d01a1e:	4629      	mov	r1, r5
c0d01a20:	f000 fd30 	bl	c0d02484 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01a24:	b00b      	add	sp, #44	; 0x2c
c0d01a26:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01a28:	20001a18 	.word	0x20001a18

c0d01a2c <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01a2c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a2e:	af03      	add	r7, sp, #12
c0d01a30:	b081      	sub	sp, #4
c0d01a32:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01a34:	7820      	ldrb	r0, [r4, #0]
c0d01a36:	267f      	movs	r6, #127	; 0x7f
c0d01a38:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d01a3a:	2e00      	cmp	r6, #0
c0d01a3c:	d02e      	beq.n	c0d01a9c <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d01a3e:	69e0      	ldr	r0, [r4, #28]
c0d01a40:	2800      	cmp	r0, #0
c0d01a42:	d01d      	beq.n	c0d01a80 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01a44:	f000 fb62 	bl	c0d0210c <pic>
c0d01a48:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d01a4a:	2e05      	cmp	r6, #5
c0d01a4c:	d102      	bne.n	c0d01a54 <io_seproxyhal_display_default+0x28>
c0d01a4e:	7ea0      	ldrb	r0, [r4, #26]
c0d01a50:	2800      	cmp	r0, #0
c0d01a52:	d025      	beq.n	c0d01aa0 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01a54:	4628      	mov	r0, r5
c0d01a56:	f002 f8a3 	bl	c0d03ba0 <strlen>
c0d01a5a:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01a5c:	4813      	ldr	r0, [pc, #76]	; (c0d01aac <io_seproxyhal_display_default+0x80>)
c0d01a5e:	2165      	movs	r1, #101	; 0x65
c0d01a60:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01a62:	4631      	mov	r1, r6
c0d01a64:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01a66:	0a0a      	lsrs	r2, r1, #8
c0d01a68:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d01a6a:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01a6c:	2103      	movs	r1, #3
c0d01a6e:	f000 fd09 	bl	c0d02484 <io_seproxyhal_spi_send>
c0d01a72:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01a74:	4620      	mov	r0, r4
c0d01a76:	f000 fd05 	bl	c0d02484 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d01a7a:	b2b1      	uxth	r1, r6
c0d01a7c:	4628      	mov	r0, r5
c0d01a7e:	e00b      	b.n	c0d01a98 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01a80:	480a      	ldr	r0, [pc, #40]	; (c0d01aac <io_seproxyhal_display_default+0x80>)
c0d01a82:	2165      	movs	r1, #101	; 0x65
c0d01a84:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01a86:	2100      	movs	r1, #0
c0d01a88:	7041      	strb	r1, [r0, #1]
c0d01a8a:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01a8c:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01a8e:	2103      	movs	r1, #3
c0d01a90:	f000 fcf8 	bl	c0d02484 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01a94:	4620      	mov	r0, r4
c0d01a96:	4629      	mov	r1, r5
c0d01a98:	f000 fcf4 	bl	c0d02484 <io_seproxyhal_spi_send>
    }
  }
}
c0d01a9c:	b001      	add	sp, #4
c0d01a9e:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d01aa0:	4620      	mov	r0, r4
c0d01aa2:	4629      	mov	r1, r5
c0d01aa4:	f7ff ff7a 	bl	c0d0199c <io_seproxyhal_display_icon>
c0d01aa8:	e7f8      	b.n	c0d01a9c <io_seproxyhal_display_default+0x70>
c0d01aaa:	46c0      	nop			; (mov r8, r8)
c0d01aac:	20001a18 	.word	0x20001a18

c0d01ab0 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d01ab0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01ab2:	af03      	add	r7, sp, #12
c0d01ab4:	b081      	sub	sp, #4
c0d01ab6:	4604      	mov	r4, r0
  if (button_callback) {
c0d01ab8:	2c00      	cmp	r4, #0
c0d01aba:	d02e      	beq.n	c0d01b1a <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d01abc:	4818      	ldr	r0, [pc, #96]	; (c0d01b20 <io_seproxyhal_button_push+0x70>)
c0d01abe:	6802      	ldr	r2, [r0, #0]
c0d01ac0:	428a      	cmp	r2, r1
c0d01ac2:	d103      	bne.n	c0d01acc <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01ac4:	4a17      	ldr	r2, [pc, #92]	; (c0d01b24 <io_seproxyhal_button_push+0x74>)
c0d01ac6:	6813      	ldr	r3, [r2, #0]
c0d01ac8:	1c5b      	adds	r3, r3, #1
c0d01aca:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01acc:	6806      	ldr	r6, [r0, #0]
c0d01ace:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d01ad0:	4a14      	ldr	r2, [pc, #80]	; (c0d01b24 <io_seproxyhal_button_push+0x74>)
c0d01ad2:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01ad4:	2900      	cmp	r1, #0
c0d01ad6:	d001      	beq.n	c0d01adc <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01ad8:	6006      	str	r6, [r0, #0]
c0d01ada:	e005      	b.n	c0d01ae8 <io_seproxyhal_button_push+0x38>
c0d01adc:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d01ade:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d01ae0:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d01ae2:	2301      	movs	r3, #1
c0d01ae4:	07db      	lsls	r3, r3, #31
c0d01ae6:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d01ae8:	6800      	ldr	r0, [r0, #0]
c0d01aea:	4288      	cmp	r0, r1
c0d01aec:	d001      	beq.n	c0d01af2 <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d01aee:	2000      	movs	r0, #0
c0d01af0:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d01af2:	2d08      	cmp	r5, #8
c0d01af4:	d30e      	bcc.n	c0d01b14 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01af6:	2103      	movs	r1, #3
c0d01af8:	4628      	mov	r0, r5
c0d01afa:	f001 fda7 	bl	c0d0364c <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d01afe:	2001      	movs	r0, #1
c0d01b00:	0780      	lsls	r0, r0, #30
c0d01b02:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01b04:	2900      	cmp	r1, #0
c0d01b06:	4601      	mov	r1, r0
c0d01b08:	d000      	beq.n	c0d01b0c <io_seproxyhal_button_push+0x5c>
c0d01b0a:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01b0c:	2900      	cmp	r1, #0
c0d01b0e:	db02      	blt.n	c0d01b16 <io_seproxyhal_button_push+0x66>
c0d01b10:	4608      	mov	r0, r1
c0d01b12:	e000      	b.n	c0d01b16 <io_seproxyhal_button_push+0x66>
c0d01b14:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01b16:	4629      	mov	r1, r5
c0d01b18:	47a0      	blx	r4
  }
}
c0d01b1a:	b001      	add	sp, #4
c0d01b1c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01b1e:	46c0      	nop			; (mov r8, r8)
c0d01b20:	20001d24 	.word	0x20001d24
c0d01b24:	20001d28 	.word	0x20001d28

c0d01b28 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01b28:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01b2a:	af03      	add	r7, sp, #12
c0d01b2c:	b081      	sub	sp, #4
c0d01b2e:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01b30:	200f      	movs	r0, #15
c0d01b32:	4204      	tst	r4, r0
c0d01b34:	d006      	beq.n	c0d01b44 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01b36:	4620      	mov	r0, r4
c0d01b38:	f7ff f8be 	bl	c0d00cb8 <io_exchange_al>
c0d01b3c:	4605      	mov	r5, r0
  }
}
c0d01b3e:	b2a8      	uxth	r0, r5
c0d01b40:	b001      	add	sp, #4
c0d01b42:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01b44:	2610      	movs	r6, #16
c0d01b46:	4026      	ands	r6, r4
c0d01b48:	2900      	cmp	r1, #0
c0d01b4a:	d02a      	beq.n	c0d01ba2 <io_exchange+0x7a>
c0d01b4c:	2e00      	cmp	r6, #0
c0d01b4e:	d128      	bne.n	c0d01ba2 <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01b50:	483d      	ldr	r0, [pc, #244]	; (c0d01c48 <io_exchange+0x120>)
c0d01b52:	7800      	ldrb	r0, [r0, #0]
c0d01b54:	2807      	cmp	r0, #7
c0d01b56:	d00b      	beq.n	c0d01b70 <io_exchange+0x48>
c0d01b58:	2800      	cmp	r0, #0
c0d01b5a:	d004      	beq.n	c0d01b66 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01b5c:	4620      	mov	r0, r4
c0d01b5e:	f7ff f8ab 	bl	c0d00cb8 <io_exchange_al>
c0d01b62:	2800      	cmp	r0, #0
c0d01b64:	d00a      	beq.n	c0d01b7c <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01b66:	4839      	ldr	r0, [pc, #228]	; (c0d01c4c <io_exchange+0x124>)
c0d01b68:	6800      	ldr	r0, [r0, #0]
c0d01b6a:	2109      	movs	r1, #9
c0d01b6c:	f002 f80a 	bl	c0d03b84 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01b70:	483d      	ldr	r0, [pc, #244]	; (c0d01c68 <io_exchange+0x140>)
c0d01b72:	4478      	add	r0, pc
c0d01b74:	2200      	movs	r2, #0
c0d01b76:	2320      	movs	r3, #32
c0d01b78:	f7ff fc6a 	bl	c0d01450 <io_usb_hid_exchange>
c0d01b7c:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d01b7e:	4832      	ldr	r0, [pc, #200]	; (c0d01c48 <io_exchange+0x120>)
c0d01b80:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d01b82:	4833      	ldr	r0, [pc, #204]	; (c0d01c50 <io_exchange+0x128>)
c0d01b84:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01b86:	4833      	ldr	r0, [pc, #204]	; (c0d01c54 <io_exchange+0x12c>)
c0d01b88:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01b8a:	4833      	ldr	r0, [pc, #204]	; (c0d01c58 <io_exchange+0x130>)
c0d01b8c:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01b8e:	4833      	ldr	r0, [pc, #204]	; (c0d01c5c <io_exchange+0x134>)
c0d01b90:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d01b92:	06a0      	lsls	r0, r4, #26
c0d01b94:	d4d3      	bmi.n	c0d01b3e <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01b96:	f7ff fcd3 	bl	c0d01540 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01b9a:	0620      	lsls	r0, r4, #24
c0d01b9c:	d501      	bpl.n	c0d01ba2 <io_exchange+0x7a>
        reset();
c0d01b9e:	f000 faeb 	bl	c0d02178 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d01ba2:	2e00      	cmp	r6, #0
c0d01ba4:	d10c      	bne.n	c0d01bc0 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01ba6:	0660      	lsls	r0, r4, #25
c0d01ba8:	d448      	bmi.n	c0d01c3c <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d01baa:	4827      	ldr	r0, [pc, #156]	; (c0d01c48 <io_exchange+0x120>)
c0d01bac:	2100      	movs	r1, #0
c0d01bae:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d01bb0:	4827      	ldr	r0, [pc, #156]	; (c0d01c50 <io_exchange+0x128>)
c0d01bb2:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d01bb4:	4827      	ldr	r0, [pc, #156]	; (c0d01c54 <io_exchange+0x12c>)
c0d01bb6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d01bb8:	4827      	ldr	r0, [pc, #156]	; (c0d01c58 <io_exchange+0x130>)
c0d01bba:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01bbc:	4827      	ldr	r0, [pc, #156]	; (c0d01c5c <io_exchange+0x134>)
c0d01bbe:	7001      	strb	r1, [r0, #0]
c0d01bc0:	4c28      	ldr	r4, [pc, #160]	; (c0d01c64 <io_exchange+0x13c>)
c0d01bc2:	4e24      	ldr	r6, [pc, #144]	; (c0d01c54 <io_exchange+0x12c>)
c0d01bc4:	e008      	b.n	c0d01bd8 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d01bc6:	f7ff fd0f 	bl	c0d015e8 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01bca:	8830      	ldrh	r0, [r6, #0]
c0d01bcc:	2800      	cmp	r0, #0
c0d01bce:	d003      	beq.n	c0d01bd8 <io_exchange+0xb0>
c0d01bd0:	e032      	b.n	c0d01c38 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d01bd2:	2002      	movs	r0, #2
c0d01bd4:	f7ff f89e 	bl	c0d00d14 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01bd8:	f000 fc72 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d01bdc:	2800      	cmp	r0, #0
c0d01bde:	d101      	bne.n	c0d01be4 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01be0:	f7ff fcae 	bl	c0d01540 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01be4:	2180      	movs	r1, #128	; 0x80
c0d01be6:	2500      	movs	r5, #0
c0d01be8:	4620      	mov	r0, r4
c0d01bea:	462a      	mov	r2, r5
c0d01bec:	f000 fc84 	bl	c0d024f8 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01bf0:	1ec1      	subs	r1, r0, #3
c0d01bf2:	78a2      	ldrb	r2, [r4, #2]
c0d01bf4:	7863      	ldrb	r3, [r4, #1]
c0d01bf6:	021b      	lsls	r3, r3, #8
c0d01bf8:	4313      	orrs	r3, r2
c0d01bfa:	4299      	cmp	r1, r3
c0d01bfc:	d110      	bne.n	c0d01c20 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01bfe:	4917      	ldr	r1, [pc, #92]	; (c0d01c5c <io_exchange+0x134>)
c0d01c00:	7809      	ldrb	r1, [r1, #0]
c0d01c02:	2900      	cmp	r1, #0
c0d01c04:	d002      	beq.n	c0d01c0c <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01c06:	f7ff fd73 	bl	c0d016f0 <io_seproxyhal_handle_event>
c0d01c0a:	e7e5      	b.n	c0d01bd8 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01c0c:	7821      	ldrb	r1, [r4, #0]
c0d01c0e:	2910      	cmp	r1, #16
c0d01c10:	d00f      	beq.n	c0d01c32 <io_exchange+0x10a>
c0d01c12:	290f      	cmp	r1, #15
c0d01c14:	d1dd      	bne.n	c0d01bd2 <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01c16:	2804      	cmp	r0, #4
c0d01c18:	d102      	bne.n	c0d01c20 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01c1a:	f7ff fca7 	bl	c0d0156c <io_seproxyhal_handle_usb_event>
c0d01c1e:	e7db      	b.n	c0d01bd8 <io_exchange+0xb0>
c0d01c20:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d01c22:	4909      	ldr	r1, [pc, #36]	; (c0d01c48 <io_exchange+0x120>)
c0d01c24:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01c26:	490a      	ldr	r1, [pc, #40]	; (c0d01c50 <io_exchange+0x128>)
c0d01c28:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01c2a:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01c2c:	490a      	ldr	r1, [pc, #40]	; (c0d01c58 <io_exchange+0x130>)
c0d01c2e:	8008      	strh	r0, [r1, #0]
c0d01c30:	e7d2      	b.n	c0d01bd8 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01c32:	2806      	cmp	r0, #6
c0d01c34:	d2c7      	bcs.n	c0d01bc6 <io_exchange+0x9e>
c0d01c36:	e782      	b.n	c0d01b3e <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01c38:	8835      	ldrh	r5, [r6, #0]
c0d01c3a:	e780      	b.n	c0d01b3e <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01c3c:	4805      	ldr	r0, [pc, #20]	; (c0d01c54 <io_exchange+0x12c>)
c0d01c3e:	8800      	ldrh	r0, [r0, #0]
c0d01c40:	4907      	ldr	r1, [pc, #28]	; (c0d01c60 <io_exchange+0x138>)
c0d01c42:	1845      	adds	r5, r0, r1
c0d01c44:	e77b      	b.n	c0d01b3e <io_exchange+0x16>
c0d01c46:	46c0      	nop			; (mov r8, r8)
c0d01c48:	20001d18 	.word	0x20001d18
c0d01c4c:	20001bb8 	.word	0x20001bb8
c0d01c50:	20001d1a 	.word	0x20001d1a
c0d01c54:	20001d1c 	.word	0x20001d1c
c0d01c58:	20001d1e 	.word	0x20001d1e
c0d01c5c:	20001d10 	.word	0x20001d10
c0d01c60:	0000fffb 	.word	0x0000fffb
c0d01c64:	20001a18 	.word	0x20001a18
c0d01c68:	fffffbbb 	.word	0xfffffbbb

c0d01c6c <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01c6c:	b081      	sub	sp, #4
c0d01c6e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c70:	af03      	add	r7, sp, #12
c0d01c72:	b094      	sub	sp, #80	; 0x50
c0d01c74:	4616      	mov	r6, r2
c0d01c76:	460d      	mov	r5, r1
c0d01c78:	900e      	str	r0, [sp, #56]	; 0x38
c0d01c7a:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01c7c:	2d02      	cmp	r5, #2
c0d01c7e:	d200      	bcs.n	c0d01c82 <snprintf+0x16>
c0d01c80:	e22a      	b.n	c0d020d8 <snprintf+0x46c>
c0d01c82:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01c84:	2800      	cmp	r0, #0
c0d01c86:	d100      	bne.n	c0d01c8a <snprintf+0x1e>
c0d01c88:	e226      	b.n	c0d020d8 <snprintf+0x46c>
c0d01c8a:	2e00      	cmp	r6, #0
c0d01c8c:	d100      	bne.n	c0d01c90 <snprintf+0x24>
c0d01c8e:	e223      	b.n	c0d020d8 <snprintf+0x46c>
c0d01c90:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d01c92:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01c94:	9109      	str	r1, [sp, #36]	; 0x24
c0d01c96:	462a      	mov	r2, r5
c0d01c98:	f7ff fbae 	bl	c0d013f8 <os_memset>
c0d01c9c:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01c9e:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01ca0:	7830      	ldrb	r0, [r6, #0]
c0d01ca2:	2800      	cmp	r0, #0
c0d01ca4:	d100      	bne.n	c0d01ca8 <snprintf+0x3c>
c0d01ca6:	e217      	b.n	c0d020d8 <snprintf+0x46c>
c0d01ca8:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01caa:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01cac:	1e6b      	subs	r3, r5, #1
c0d01cae:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01cb0:	460a      	mov	r2, r1
c0d01cb2:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01cb4:	e003      	b.n	c0d01cbe <snprintf+0x52>
c0d01cb6:	1970      	adds	r0, r6, r5
c0d01cb8:	7840      	ldrb	r0, [r0, #1]
c0d01cba:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01cbc:	1c6d      	adds	r5, r5, #1
c0d01cbe:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01cc0:	2800      	cmp	r0, #0
c0d01cc2:	d001      	beq.n	c0d01cc8 <snprintf+0x5c>
c0d01cc4:	2825      	cmp	r0, #37	; 0x25
c0d01cc6:	d1f6      	bne.n	c0d01cb6 <snprintf+0x4a>
c0d01cc8:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01cca:	429d      	cmp	r5, r3
c0d01ccc:	d300      	bcc.n	c0d01cd0 <snprintf+0x64>
c0d01cce:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01cd0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01cd2:	4631      	mov	r1, r6
c0d01cd4:	462a      	mov	r2, r5
c0d01cd6:	461c      	mov	r4, r3
c0d01cd8:	f7ff fb98 	bl	c0d0140c <os_memmove>
c0d01cdc:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01cde:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01ce0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01ce2:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01ce4:	2b00      	cmp	r3, #0
c0d01ce6:	d100      	bne.n	c0d01cea <snprintf+0x7e>
c0d01ce8:	e1f6      	b.n	c0d020d8 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01cea:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01cec:	5d71      	ldrb	r1, [r6, r5]
c0d01cee:	2925      	cmp	r1, #37	; 0x25
c0d01cf0:	d000      	beq.n	c0d01cf4 <snprintf+0x88>
c0d01cf2:	e0ab      	b.n	c0d01e4c <snprintf+0x1e0>
c0d01cf4:	9304      	str	r3, [sp, #16]
c0d01cf6:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01cf8:	1c40      	adds	r0, r0, #1
c0d01cfa:	2100      	movs	r1, #0
c0d01cfc:	2220      	movs	r2, #32
c0d01cfe:	920a      	str	r2, [sp, #40]	; 0x28
c0d01d00:	220a      	movs	r2, #10
c0d01d02:	9203      	str	r2, [sp, #12]
c0d01d04:	9102      	str	r1, [sp, #8]
c0d01d06:	9106      	str	r1, [sp, #24]
c0d01d08:	910d      	str	r1, [sp, #52]	; 0x34
c0d01d0a:	460b      	mov	r3, r1
c0d01d0c:	2102      	movs	r1, #2
c0d01d0e:	910c      	str	r1, [sp, #48]	; 0x30
c0d01d10:	4606      	mov	r6, r0
c0d01d12:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01d14:	7831      	ldrb	r1, [r6, #0]
c0d01d16:	1c76      	adds	r6, r6, #1
c0d01d18:	2300      	movs	r3, #0
c0d01d1a:	2962      	cmp	r1, #98	; 0x62
c0d01d1c:	dc41      	bgt.n	c0d01da2 <snprintf+0x136>
c0d01d1e:	4608      	mov	r0, r1
c0d01d20:	3825      	subs	r0, #37	; 0x25
c0d01d22:	2823      	cmp	r0, #35	; 0x23
c0d01d24:	d900      	bls.n	c0d01d28 <snprintf+0xbc>
c0d01d26:	e094      	b.n	c0d01e52 <snprintf+0x1e6>
c0d01d28:	0040      	lsls	r0, r0, #1
c0d01d2a:	46c0      	nop			; (mov r8, r8)
c0d01d2c:	4478      	add	r0, pc
c0d01d2e:	8880      	ldrh	r0, [r0, #4]
c0d01d30:	0040      	lsls	r0, r0, #1
c0d01d32:	4487      	add	pc, r0
c0d01d34:	0186012d 	.word	0x0186012d
c0d01d38:	01860186 	.word	0x01860186
c0d01d3c:	00510186 	.word	0x00510186
c0d01d40:	01860186 	.word	0x01860186
c0d01d44:	00580023 	.word	0x00580023
c0d01d48:	00240186 	.word	0x00240186
c0d01d4c:	00240024 	.word	0x00240024
c0d01d50:	00240024 	.word	0x00240024
c0d01d54:	00240024 	.word	0x00240024
c0d01d58:	00240024 	.word	0x00240024
c0d01d5c:	01860024 	.word	0x01860024
c0d01d60:	01860186 	.word	0x01860186
c0d01d64:	01860186 	.word	0x01860186
c0d01d68:	01860186 	.word	0x01860186
c0d01d6c:	01860186 	.word	0x01860186
c0d01d70:	01860186 	.word	0x01860186
c0d01d74:	01860186 	.word	0x01860186
c0d01d78:	006c0186 	.word	0x006c0186
c0d01d7c:	e7c9      	b.n	c0d01d12 <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01d7e:	2930      	cmp	r1, #48	; 0x30
c0d01d80:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01d82:	4603      	mov	r3, r0
c0d01d84:	d100      	bne.n	c0d01d88 <snprintf+0x11c>
c0d01d86:	460b      	mov	r3, r1
c0d01d88:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01d8a:	2c00      	cmp	r4, #0
c0d01d8c:	d000      	beq.n	c0d01d90 <snprintf+0x124>
c0d01d8e:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01d90:	200a      	movs	r0, #10
c0d01d92:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01d94:	1840      	adds	r0, r0, r1
c0d01d96:	3830      	subs	r0, #48	; 0x30
c0d01d98:	900d      	str	r0, [sp, #52]	; 0x34
c0d01d9a:	4630      	mov	r0, r6
c0d01d9c:	930a      	str	r3, [sp, #40]	; 0x28
c0d01d9e:	4613      	mov	r3, r2
c0d01da0:	e7b4      	b.n	c0d01d0c <snprintf+0xa0>
c0d01da2:	296f      	cmp	r1, #111	; 0x6f
c0d01da4:	dd11      	ble.n	c0d01dca <snprintf+0x15e>
c0d01da6:	3970      	subs	r1, #112	; 0x70
c0d01da8:	2908      	cmp	r1, #8
c0d01daa:	d900      	bls.n	c0d01dae <snprintf+0x142>
c0d01dac:	e149      	b.n	c0d02042 <snprintf+0x3d6>
c0d01dae:	0049      	lsls	r1, r1, #1
c0d01db0:	4479      	add	r1, pc
c0d01db2:	8889      	ldrh	r1, [r1, #4]
c0d01db4:	0049      	lsls	r1, r1, #1
c0d01db6:	448f      	add	pc, r1
c0d01db8:	01440051 	.word	0x01440051
c0d01dbc:	002e0144 	.word	0x002e0144
c0d01dc0:	00590144 	.word	0x00590144
c0d01dc4:	01440144 	.word	0x01440144
c0d01dc8:	0051      	.short	0x0051
c0d01dca:	2963      	cmp	r1, #99	; 0x63
c0d01dcc:	d054      	beq.n	c0d01e78 <snprintf+0x20c>
c0d01dce:	2964      	cmp	r1, #100	; 0x64
c0d01dd0:	d057      	beq.n	c0d01e82 <snprintf+0x216>
c0d01dd2:	2968      	cmp	r1, #104	; 0x68
c0d01dd4:	d01d      	beq.n	c0d01e12 <snprintf+0x1a6>
c0d01dd6:	e134      	b.n	c0d02042 <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01dd8:	7830      	ldrb	r0, [r6, #0]
c0d01dda:	2873      	cmp	r0, #115	; 0x73
c0d01ddc:	d000      	beq.n	c0d01de0 <snprintf+0x174>
c0d01dde:	e130      	b.n	c0d02042 <snprintf+0x3d6>
c0d01de0:	4630      	mov	r0, r6
c0d01de2:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01de4:	e00d      	b.n	c0d01e02 <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01de6:	7830      	ldrb	r0, [r6, #0]
c0d01de8:	282a      	cmp	r0, #42	; 0x2a
c0d01dea:	d000      	beq.n	c0d01dee <snprintf+0x182>
c0d01dec:	e129      	b.n	c0d02042 <snprintf+0x3d6>
c0d01dee:	7871      	ldrb	r1, [r6, #1]
c0d01df0:	1c70      	adds	r0, r6, #1
c0d01df2:	2301      	movs	r3, #1
c0d01df4:	2948      	cmp	r1, #72	; 0x48
c0d01df6:	d004      	beq.n	c0d01e02 <snprintf+0x196>
c0d01df8:	2968      	cmp	r1, #104	; 0x68
c0d01dfa:	d002      	beq.n	c0d01e02 <snprintf+0x196>
c0d01dfc:	2973      	cmp	r1, #115	; 0x73
c0d01dfe:	d000      	beq.n	c0d01e02 <snprintf+0x196>
c0d01e00:	e11f      	b.n	c0d02042 <snprintf+0x3d6>
c0d01e02:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01e04:	1d0a      	adds	r2, r1, #4
c0d01e06:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01e08:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01e0a:	9102      	str	r1, [sp, #8]
c0d01e0c:	e77e      	b.n	c0d01d0c <snprintf+0xa0>
c0d01e0e:	2001      	movs	r0, #1
c0d01e10:	9006      	str	r0, [sp, #24]
c0d01e12:	2010      	movs	r0, #16
c0d01e14:	9003      	str	r0, [sp, #12]
c0d01e16:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01e18:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01e1a:	1d01      	adds	r1, r0, #4
c0d01e1c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01e1e:	2103      	movs	r1, #3
c0d01e20:	400a      	ands	r2, r1
c0d01e22:	1c5b      	adds	r3, r3, #1
c0d01e24:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01e26:	2a01      	cmp	r2, #1
c0d01e28:	d100      	bne.n	c0d01e2c <snprintf+0x1c0>
c0d01e2a:	e0b8      	b.n	c0d01f9e <snprintf+0x332>
c0d01e2c:	2a02      	cmp	r2, #2
c0d01e2e:	d100      	bne.n	c0d01e32 <snprintf+0x1c6>
c0d01e30:	e104      	b.n	c0d0203c <snprintf+0x3d0>
c0d01e32:	2a03      	cmp	r2, #3
c0d01e34:	4630      	mov	r0, r6
c0d01e36:	d100      	bne.n	c0d01e3a <snprintf+0x1ce>
c0d01e38:	e768      	b.n	c0d01d0c <snprintf+0xa0>
c0d01e3a:	9c08      	ldr	r4, [sp, #32]
c0d01e3c:	4625      	mov	r5, r4
c0d01e3e:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01e40:	1948      	adds	r0, r1, r5
c0d01e42:	7840      	ldrb	r0, [r0, #1]
c0d01e44:	1c6d      	adds	r5, r5, #1
c0d01e46:	2800      	cmp	r0, #0
c0d01e48:	d1fa      	bne.n	c0d01e40 <snprintf+0x1d4>
c0d01e4a:	e0ab      	b.n	c0d01fa4 <snprintf+0x338>
c0d01e4c:	4606      	mov	r6, r0
c0d01e4e:	920e      	str	r2, [sp, #56]	; 0x38
c0d01e50:	e109      	b.n	c0d02066 <snprintf+0x3fa>
c0d01e52:	2958      	cmp	r1, #88	; 0x58
c0d01e54:	d000      	beq.n	c0d01e58 <snprintf+0x1ec>
c0d01e56:	e0f4      	b.n	c0d02042 <snprintf+0x3d6>
c0d01e58:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01e5a:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01e5c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01e5e:	1d01      	adds	r1, r0, #4
c0d01e60:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01e62:	6802      	ldr	r2, [r0, #0]
c0d01e64:	2000      	movs	r0, #0
c0d01e66:	9005      	str	r0, [sp, #20]
c0d01e68:	2510      	movs	r5, #16
c0d01e6a:	e014      	b.n	c0d01e96 <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01e6c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01e6e:	1d01      	adds	r1, r0, #4
c0d01e70:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01e72:	6802      	ldr	r2, [r0, #0]
c0d01e74:	2000      	movs	r0, #0
c0d01e76:	e00c      	b.n	c0d01e92 <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01e78:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01e7a:	1d01      	adds	r1, r0, #4
c0d01e7c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01e7e:	6800      	ldr	r0, [r0, #0]
c0d01e80:	e087      	b.n	c0d01f92 <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01e82:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01e84:	1d01      	adds	r1, r0, #4
c0d01e86:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01e88:	6800      	ldr	r0, [r0, #0]
c0d01e8a:	17c1      	asrs	r1, r0, #31
c0d01e8c:	1842      	adds	r2, r0, r1
c0d01e8e:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01e90:	0fc0      	lsrs	r0, r0, #31
c0d01e92:	9005      	str	r0, [sp, #20]
c0d01e94:	250a      	movs	r5, #10
c0d01e96:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01e98:	4295      	cmp	r5, r2
c0d01e9a:	920e      	str	r2, [sp, #56]	; 0x38
c0d01e9c:	d814      	bhi.n	c0d01ec8 <snprintf+0x25c>
c0d01e9e:	2201      	movs	r2, #1
c0d01ea0:	4628      	mov	r0, r5
c0d01ea2:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01ea4:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01ea6:	4629      	mov	r1, r5
c0d01ea8:	f001 fb4a 	bl	c0d03540 <__aeabi_uidiv>
c0d01eac:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01eae:	4288      	cmp	r0, r1
c0d01eb0:	d109      	bne.n	c0d01ec6 <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01eb2:	4628      	mov	r0, r5
c0d01eb4:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01eb6:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01eb8:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01eba:	910d      	str	r1, [sp, #52]	; 0x34
c0d01ebc:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01ebe:	4288      	cmp	r0, r1
c0d01ec0:	4622      	mov	r2, r4
c0d01ec2:	d9ee      	bls.n	c0d01ea2 <snprintf+0x236>
c0d01ec4:	e000      	b.n	c0d01ec8 <snprintf+0x25c>
c0d01ec6:	460c      	mov	r4, r1
c0d01ec8:	950c      	str	r5, [sp, #48]	; 0x30
c0d01eca:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01ecc:	2000      	movs	r0, #0
c0d01ece:	4603      	mov	r3, r0
c0d01ed0:	43c1      	mvns	r1, r0
c0d01ed2:	9c05      	ldr	r4, [sp, #20]
c0d01ed4:	2c00      	cmp	r4, #0
c0d01ed6:	d100      	bne.n	c0d01eda <snprintf+0x26e>
c0d01ed8:	4621      	mov	r1, r4
c0d01eda:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01edc:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01ede:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01ee0:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01ee2:	b2ca      	uxtb	r2, r1
c0d01ee4:	2a30      	cmp	r2, #48	; 0x30
c0d01ee6:	d106      	bne.n	c0d01ef6 <snprintf+0x28a>
c0d01ee8:	2c00      	cmp	r4, #0
c0d01eea:	d004      	beq.n	c0d01ef6 <snprintf+0x28a>
c0d01eec:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01eee:	232d      	movs	r3, #45	; 0x2d
c0d01ef0:	700b      	strb	r3, [r1, #0]
c0d01ef2:	2400      	movs	r4, #0
c0d01ef4:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01ef6:	1e81      	subs	r1, r0, #2
c0d01ef8:	290d      	cmp	r1, #13
c0d01efa:	d80d      	bhi.n	c0d01f18 <snprintf+0x2ac>
c0d01efc:	1e41      	subs	r1, r0, #1
c0d01efe:	d00b      	beq.n	c0d01f18 <snprintf+0x2ac>
c0d01f00:	a810      	add	r0, sp, #64	; 0x40
c0d01f02:	9405      	str	r4, [sp, #20]
c0d01f04:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01f06:	4320      	orrs	r0, r4
c0d01f08:	f001 fda4 	bl	c0d03a54 <__aeabi_memset>
c0d01f0c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01f0e:	1900      	adds	r0, r0, r4
c0d01f10:	9c05      	ldr	r4, [sp, #20]
c0d01f12:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01f14:	1840      	adds	r0, r0, r1
c0d01f16:	1e43      	subs	r3, r0, #1
c0d01f18:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01f1a:	2c00      	cmp	r4, #0
c0d01f1c:	9601      	str	r6, [sp, #4]
c0d01f1e:	d003      	beq.n	c0d01f28 <snprintf+0x2bc>
c0d01f20:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01f22:	222d      	movs	r2, #45	; 0x2d
c0d01f24:	54c2      	strb	r2, [r0, r3]
c0d01f26:	1c5b      	adds	r3, r3, #1
c0d01f28:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01f2a:	2900      	cmp	r1, #0
c0d01f2c:	d003      	beq.n	c0d01f36 <snprintf+0x2ca>
c0d01f2e:	2800      	cmp	r0, #0
c0d01f30:	d003      	beq.n	c0d01f3a <snprintf+0x2ce>
c0d01f32:	a06c      	add	r0, pc, #432	; (adr r0, c0d020e4 <g_pcHex_cap>)
c0d01f34:	e002      	b.n	c0d01f3c <snprintf+0x2d0>
c0d01f36:	461c      	mov	r4, r3
c0d01f38:	e016      	b.n	c0d01f68 <snprintf+0x2fc>
c0d01f3a:	a06e      	add	r0, pc, #440	; (adr r0, c0d020f4 <g_pcHex>)
c0d01f3c:	900d      	str	r0, [sp, #52]	; 0x34
c0d01f3e:	461c      	mov	r4, r3
c0d01f40:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01f42:	460e      	mov	r6, r1
c0d01f44:	f001 fafc 	bl	c0d03540 <__aeabi_uidiv>
c0d01f48:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01f4a:	4629      	mov	r1, r5
c0d01f4c:	f001 fb7e 	bl	c0d0364c <__aeabi_uidivmod>
c0d01f50:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01f52:	5c40      	ldrb	r0, [r0, r1]
c0d01f54:	a910      	add	r1, sp, #64	; 0x40
c0d01f56:	5508      	strb	r0, [r1, r4]
c0d01f58:	4630      	mov	r0, r6
c0d01f5a:	4629      	mov	r1, r5
c0d01f5c:	f001 faf0 	bl	c0d03540 <__aeabi_uidiv>
c0d01f60:	1c64      	adds	r4, r4, #1
c0d01f62:	42b5      	cmp	r5, r6
c0d01f64:	4601      	mov	r1, r0
c0d01f66:	d9eb      	bls.n	c0d01f40 <snprintf+0x2d4>
c0d01f68:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01f6a:	429c      	cmp	r4, r3
c0d01f6c:	4625      	mov	r5, r4
c0d01f6e:	d300      	bcc.n	c0d01f72 <snprintf+0x306>
c0d01f70:	461d      	mov	r5, r3
c0d01f72:	a910      	add	r1, sp, #64	; 0x40
c0d01f74:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01f76:	4620      	mov	r0, r4
c0d01f78:	462a      	mov	r2, r5
c0d01f7a:	461e      	mov	r6, r3
c0d01f7c:	f7ff fa46 	bl	c0d0140c <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01f80:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d01f82:	1961      	adds	r1, r4, r5
c0d01f84:	910e      	str	r1, [sp, #56]	; 0x38
c0d01f86:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01f88:	2800      	cmp	r0, #0
c0d01f8a:	9e01      	ldr	r6, [sp, #4]
c0d01f8c:	d16b      	bne.n	c0d02066 <snprintf+0x3fa>
c0d01f8e:	e0a3      	b.n	c0d020d8 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01f90:	2025      	movs	r0, #37	; 0x25
c0d01f92:	9907      	ldr	r1, [sp, #28]
c0d01f94:	7008      	strb	r0, [r1, #0]
c0d01f96:	9804      	ldr	r0, [sp, #16]
c0d01f98:	1e40      	subs	r0, r0, #1
c0d01f9a:	1c49      	adds	r1, r1, #1
c0d01f9c:	e05f      	b.n	c0d0205e <snprintf+0x3f2>
c0d01f9e:	9d02      	ldr	r5, [sp, #8]
c0d01fa0:	9c08      	ldr	r4, [sp, #32]
c0d01fa2:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01fa4:	9803      	ldr	r0, [sp, #12]
c0d01fa6:	2810      	cmp	r0, #16
c0d01fa8:	9807      	ldr	r0, [sp, #28]
c0d01faa:	d161      	bne.n	c0d02070 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01fac:	2d00      	cmp	r5, #0
c0d01fae:	d06a      	beq.n	c0d02086 <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01fb0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01fb2:	1900      	adds	r0, r0, r4
c0d01fb4:	900e      	str	r0, [sp, #56]	; 0x38
c0d01fb6:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01fb8:	1aa0      	subs	r0, r4, r2
c0d01fba:	9b05      	ldr	r3, [sp, #20]
c0d01fbc:	4283      	cmp	r3, r0
c0d01fbe:	d800      	bhi.n	c0d01fc2 <snprintf+0x356>
c0d01fc0:	4603      	mov	r3, r0
c0d01fc2:	930c      	str	r3, [sp, #48]	; 0x30
c0d01fc4:	435c      	muls	r4, r3
c0d01fc6:	940a      	str	r4, [sp, #40]	; 0x28
c0d01fc8:	1c60      	adds	r0, r4, #1
c0d01fca:	9007      	str	r0, [sp, #28]
c0d01fcc:	2000      	movs	r0, #0
c0d01fce:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01fd0:	9100      	str	r1, [sp, #0]
c0d01fd2:	940e      	str	r4, [sp, #56]	; 0x38
c0d01fd4:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01fd6:	18e3      	adds	r3, r4, r3
c0d01fd8:	900d      	str	r0, [sp, #52]	; 0x34
c0d01fda:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01fdc:	200f      	movs	r0, #15
c0d01fde:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01fe0:	0909      	lsrs	r1, r1, #4
c0d01fe2:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01fe4:	18a4      	adds	r4, r4, r2
c0d01fe6:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01fe8:	2c02      	cmp	r4, #2
c0d01fea:	d375      	bcc.n	c0d020d8 <snprintf+0x46c>
c0d01fec:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01fee:	2c01      	cmp	r4, #1
c0d01ff0:	d003      	beq.n	c0d01ffa <snprintf+0x38e>
c0d01ff2:	2c00      	cmp	r4, #0
c0d01ff4:	d108      	bne.n	c0d02008 <snprintf+0x39c>
c0d01ff6:	a43f      	add	r4, pc, #252	; (adr r4, c0d020f4 <g_pcHex>)
c0d01ff8:	e000      	b.n	c0d01ffc <snprintf+0x390>
c0d01ffa:	a43a      	add	r4, pc, #232	; (adr r4, c0d020e4 <g_pcHex_cap>)
c0d01ffc:	b2c9      	uxtb	r1, r1
c0d01ffe:	5c61      	ldrb	r1, [r4, r1]
c0d02000:	7019      	strb	r1, [r3, #0]
c0d02002:	b2c0      	uxtb	r0, r0
c0d02004:	5c20      	ldrb	r0, [r4, r0]
c0d02006:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d02008:	9807      	ldr	r0, [sp, #28]
c0d0200a:	4290      	cmp	r0, r2
c0d0200c:	d064      	beq.n	c0d020d8 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d0200e:	1e92      	subs	r2, r2, #2
c0d02010:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d02012:	1ca4      	adds	r4, r4, #2
c0d02014:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d02016:	1c40      	adds	r0, r0, #1
c0d02018:	42a8      	cmp	r0, r5
c0d0201a:	9900      	ldr	r1, [sp, #0]
c0d0201c:	d3d9      	bcc.n	c0d01fd2 <snprintf+0x366>
c0d0201e:	900d      	str	r0, [sp, #52]	; 0x34
c0d02020:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d02022:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d02024:	1a08      	subs	r0, r1, r0
c0d02026:	9b05      	ldr	r3, [sp, #20]
c0d02028:	4283      	cmp	r3, r0
c0d0202a:	d800      	bhi.n	c0d0202e <snprintf+0x3c2>
c0d0202c:	4603      	mov	r3, r0
c0d0202e:	4608      	mov	r0, r1
c0d02030:	4358      	muls	r0, r3
c0d02032:	1820      	adds	r0, r4, r0
c0d02034:	900e      	str	r0, [sp, #56]	; 0x38
c0d02036:	1898      	adds	r0, r3, r2
c0d02038:	1c43      	adds	r3, r0, #1
c0d0203a:	e038      	b.n	c0d020ae <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d0203c:	7808      	ldrb	r0, [r1, #0]
c0d0203e:	2800      	cmp	r0, #0
c0d02040:	d023      	beq.n	c0d0208a <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d02042:	2005      	movs	r0, #5
c0d02044:	9d04      	ldr	r5, [sp, #16]
c0d02046:	2d05      	cmp	r5, #5
c0d02048:	462c      	mov	r4, r5
c0d0204a:	d300      	bcc.n	c0d0204e <snprintf+0x3e2>
c0d0204c:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d0204e:	9807      	ldr	r0, [sp, #28]
c0d02050:	a12c      	add	r1, pc, #176	; (adr r1, c0d02104 <g_pcHex+0x10>)
c0d02052:	4622      	mov	r2, r4
c0d02054:	f7ff f9da 	bl	c0d0140c <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d02058:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d0205a:	9907      	ldr	r1, [sp, #28]
c0d0205c:	1909      	adds	r1, r1, r4
c0d0205e:	910e      	str	r1, [sp, #56]	; 0x38
c0d02060:	4603      	mov	r3, r0
c0d02062:	2800      	cmp	r0, #0
c0d02064:	d038      	beq.n	c0d020d8 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d02066:	7830      	ldrb	r0, [r6, #0]
c0d02068:	2800      	cmp	r0, #0
c0d0206a:	9908      	ldr	r1, [sp, #32]
c0d0206c:	d034      	beq.n	c0d020d8 <snprintf+0x46c>
c0d0206e:	e61f      	b.n	c0d01cb0 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d02070:	429d      	cmp	r5, r3
c0d02072:	d300      	bcc.n	c0d02076 <snprintf+0x40a>
c0d02074:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d02076:	462a      	mov	r2, r5
c0d02078:	461c      	mov	r4, r3
c0d0207a:	f7ff f9c7 	bl	c0d0140c <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d0207e:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d02080:	9907      	ldr	r1, [sp, #28]
c0d02082:	1949      	adds	r1, r1, r5
c0d02084:	e00f      	b.n	c0d020a6 <snprintf+0x43a>
c0d02086:	900e      	str	r0, [sp, #56]	; 0x38
c0d02088:	e7ed      	b.n	c0d02066 <snprintf+0x3fa>
c0d0208a:	9b04      	ldr	r3, [sp, #16]
c0d0208c:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d0208e:	429c      	cmp	r4, r3
c0d02090:	d300      	bcc.n	c0d02094 <snprintf+0x428>
c0d02092:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d02094:	2120      	movs	r1, #32
c0d02096:	9807      	ldr	r0, [sp, #28]
c0d02098:	4622      	mov	r2, r4
c0d0209a:	f7ff f9ad 	bl	c0d013f8 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d0209e:	9804      	ldr	r0, [sp, #16]
c0d020a0:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d020a2:	9907      	ldr	r1, [sp, #28]
c0d020a4:	1909      	adds	r1, r1, r4
c0d020a6:	910e      	str	r1, [sp, #56]	; 0x38
c0d020a8:	4603      	mov	r3, r0
c0d020aa:	2800      	cmp	r0, #0
c0d020ac:	d014      	beq.n	c0d020d8 <snprintf+0x46c>
c0d020ae:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d020b0:	42a8      	cmp	r0, r5
c0d020b2:	d9d8      	bls.n	c0d02066 <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d020b4:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d020b6:	429a      	cmp	r2, r3
c0d020b8:	d300      	bcc.n	c0d020bc <snprintf+0x450>
c0d020ba:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d020bc:	2120      	movs	r1, #32
c0d020be:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d020c0:	4628      	mov	r0, r5
c0d020c2:	920d      	str	r2, [sp, #52]	; 0x34
c0d020c4:	461c      	mov	r4, r3
c0d020c6:	f7ff f997 	bl	c0d013f8 <os_memset>
c0d020ca:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d020cc:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d020ce:	182d      	adds	r5, r5, r0
c0d020d0:	950e      	str	r5, [sp, #56]	; 0x38
c0d020d2:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d020d4:	2c00      	cmp	r4, #0
c0d020d6:	d1c6      	bne.n	c0d02066 <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d020d8:	2000      	movs	r0, #0
c0d020da:	b014      	add	sp, #80	; 0x50
c0d020dc:	bcf0      	pop	{r4, r5, r6, r7}
c0d020de:	bc02      	pop	{r1}
c0d020e0:	b001      	add	sp, #4
c0d020e2:	4708      	bx	r1

c0d020e4 <g_pcHex_cap>:
c0d020e4:	33323130 	.word	0x33323130
c0d020e8:	37363534 	.word	0x37363534
c0d020ec:	42413938 	.word	0x42413938
c0d020f0:	46454443 	.word	0x46454443

c0d020f4 <g_pcHex>:
c0d020f4:	33323130 	.word	0x33323130
c0d020f8:	37363534 	.word	0x37363534
c0d020fc:	62613938 	.word	0x62613938
c0d02100:	66656463 	.word	0x66656463
c0d02104:	4f525245 	.word	0x4f525245
c0d02108:	00000052 	.word	0x00000052

c0d0210c <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d0210c:	b580      	push	{r7, lr}
c0d0210e:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d02110:	4904      	ldr	r1, [pc, #16]	; (c0d02124 <pic+0x18>)
c0d02112:	4288      	cmp	r0, r1
c0d02114:	d304      	bcc.n	c0d02120 <pic+0x14>
c0d02116:	4904      	ldr	r1, [pc, #16]	; (c0d02128 <pic+0x1c>)
c0d02118:	4288      	cmp	r0, r1
c0d0211a:	d201      	bcs.n	c0d02120 <pic+0x14>
		link_address = pic_internal(link_address);
c0d0211c:	f000 f806 	bl	c0d0212c <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d02120:	bd80      	pop	{r7, pc}
c0d02122:	46c0      	nop			; (mov r8, r8)
c0d02124:	c0d00000 	.word	0xc0d00000
c0d02128:	c0d04100 	.word	0xc0d04100

c0d0212c <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d0212c:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d0212e:	4902      	ldr	r1, [pc, #8]	; (c0d02138 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d02130:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d02132:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d02134:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d02136:	4770      	bx	lr
c0d02138:	c0d0212d 	.word	0xc0d0212d

c0d0213c <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d0213c:	b580      	push	{r7, lr}
c0d0213e:	af00      	add	r7, sp, #0
c0d02140:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d02142:	490a      	ldr	r1, [pc, #40]	; (c0d0216c <check_api_level+0x30>)
c0d02144:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02146:	490a      	ldr	r1, [pc, #40]	; (c0d02170 <check_api_level+0x34>)
c0d02148:	680a      	ldr	r2, [r1, #0]
c0d0214a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d0214c:	9003      	str	r0, [sp, #12]
c0d0214e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02150:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02152:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02154:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d02156:	4807      	ldr	r0, [pc, #28]	; (c0d02174 <check_api_level+0x38>)
c0d02158:	9a01      	ldr	r2, [sp, #4]
c0d0215a:	4282      	cmp	r2, r0
c0d0215c:	d101      	bne.n	c0d02162 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0215e:	b004      	add	sp, #16
c0d02160:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02162:	6808      	ldr	r0, [r1, #0]
c0d02164:	2104      	movs	r1, #4
c0d02166:	f001 fd0d 	bl	c0d03b84 <longjmp>
c0d0216a:	46c0      	nop			; (mov r8, r8)
c0d0216c:	60000137 	.word	0x60000137
c0d02170:	20001bb8 	.word	0x20001bb8
c0d02174:	900001c6 	.word	0x900001c6

c0d02178 <reset>:
  }
}

void reset ( void ) 
{
c0d02178:	b580      	push	{r7, lr}
c0d0217a:	af00      	add	r7, sp, #0
c0d0217c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d0217e:	4809      	ldr	r0, [pc, #36]	; (c0d021a4 <reset+0x2c>)
c0d02180:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02182:	4809      	ldr	r0, [pc, #36]	; (c0d021a8 <reset+0x30>)
c0d02184:	6801      	ldr	r1, [r0, #0]
c0d02186:	9101      	str	r1, [sp, #4]
c0d02188:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0218a:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d0218c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0218e:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d02190:	4906      	ldr	r1, [pc, #24]	; (c0d021ac <reset+0x34>)
c0d02192:	9a00      	ldr	r2, [sp, #0]
c0d02194:	428a      	cmp	r2, r1
c0d02196:	d101      	bne.n	c0d0219c <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02198:	b002      	add	sp, #8
c0d0219a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0219c:	6800      	ldr	r0, [r0, #0]
c0d0219e:	2104      	movs	r1, #4
c0d021a0:	f001 fcf0 	bl	c0d03b84 <longjmp>
c0d021a4:	60000200 	.word	0x60000200
c0d021a8:	20001bb8 	.word	0x20001bb8
c0d021ac:	900002f1 	.word	0x900002f1

c0d021b0 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d021b0:	b5d0      	push	{r4, r6, r7, lr}
c0d021b2:	af02      	add	r7, sp, #8
c0d021b4:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d021b6:	4b0a      	ldr	r3, [pc, #40]	; (c0d021e0 <nvm_write+0x30>)
c0d021b8:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021ba:	4b0a      	ldr	r3, [pc, #40]	; (c0d021e4 <nvm_write+0x34>)
c0d021bc:	681c      	ldr	r4, [r3, #0]
c0d021be:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d021c0:	ac03      	add	r4, sp, #12
c0d021c2:	c407      	stmia	r4!, {r0, r1, r2}
c0d021c4:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021c6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021c8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021ca:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d021cc:	4806      	ldr	r0, [pc, #24]	; (c0d021e8 <nvm_write+0x38>)
c0d021ce:	9901      	ldr	r1, [sp, #4]
c0d021d0:	4281      	cmp	r1, r0
c0d021d2:	d101      	bne.n	c0d021d8 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d021d4:	b006      	add	sp, #24
c0d021d6:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021d8:	6818      	ldr	r0, [r3, #0]
c0d021da:	2104      	movs	r1, #4
c0d021dc:	f001 fcd2 	bl	c0d03b84 <longjmp>
c0d021e0:	6000037f 	.word	0x6000037f
c0d021e4:	20001bb8 	.word	0x20001bb8
c0d021e8:	900003bc 	.word	0x900003bc

c0d021ec <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d021ec:	b580      	push	{r7, lr}
c0d021ee:	af00      	add	r7, sp, #0
c0d021f0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d021f2:	4a0a      	ldr	r2, [pc, #40]	; (c0d0221c <cx_rng+0x30>)
c0d021f4:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021f6:	4a0a      	ldr	r2, [pc, #40]	; (c0d02220 <cx_rng+0x34>)
c0d021f8:	6813      	ldr	r3, [r2, #0]
c0d021fa:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d021fc:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d021fe:	9103      	str	r1, [sp, #12]
c0d02200:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02202:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02204:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02206:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d02208:	4906      	ldr	r1, [pc, #24]	; (c0d02224 <cx_rng+0x38>)
c0d0220a:	9b00      	ldr	r3, [sp, #0]
c0d0220c:	428b      	cmp	r3, r1
c0d0220e:	d101      	bne.n	c0d02214 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d02210:	b004      	add	sp, #16
c0d02212:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02214:	6810      	ldr	r0, [r2, #0]
c0d02216:	2104      	movs	r1, #4
c0d02218:	f001 fcb4 	bl	c0d03b84 <longjmp>
c0d0221c:	6000052c 	.word	0x6000052c
c0d02220:	20001bb8 	.word	0x20001bb8
c0d02224:	90000567 	.word	0x90000567

c0d02228 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d02228:	b580      	push	{r7, lr}
c0d0222a:	af00      	add	r7, sp, #0
c0d0222c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d0222e:	490a      	ldr	r1, [pc, #40]	; (c0d02258 <cx_sha256_init+0x30>)
c0d02230:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02232:	490a      	ldr	r1, [pc, #40]	; (c0d0225c <cx_sha256_init+0x34>)
c0d02234:	680a      	ldr	r2, [r1, #0]
c0d02236:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d02238:	9003      	str	r0, [sp, #12]
c0d0223a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0223c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0223e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02240:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d02242:	4a07      	ldr	r2, [pc, #28]	; (c0d02260 <cx_sha256_init+0x38>)
c0d02244:	9b01      	ldr	r3, [sp, #4]
c0d02246:	4293      	cmp	r3, r2
c0d02248:	d101      	bne.n	c0d0224e <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0224a:	b004      	add	sp, #16
c0d0224c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0224e:	6808      	ldr	r0, [r1, #0]
c0d02250:	2104      	movs	r1, #4
c0d02252:	f001 fc97 	bl	c0d03b84 <longjmp>
c0d02256:	46c0      	nop			; (mov r8, r8)
c0d02258:	600008db 	.word	0x600008db
c0d0225c:	20001bb8 	.word	0x20001bb8
c0d02260:	90000864 	.word	0x90000864

c0d02264 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d02264:	b580      	push	{r7, lr}
c0d02266:	af00      	add	r7, sp, #0
c0d02268:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d0226a:	4a0a      	ldr	r2, [pc, #40]	; (c0d02294 <cx_keccak_init+0x30>)
c0d0226c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0226e:	4a0a      	ldr	r2, [pc, #40]	; (c0d02298 <cx_keccak_init+0x34>)
c0d02270:	6813      	ldr	r3, [r2, #0]
c0d02272:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d02274:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d02276:	9103      	str	r1, [sp, #12]
c0d02278:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0227a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0227c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0227e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d02280:	4906      	ldr	r1, [pc, #24]	; (c0d0229c <cx_keccak_init+0x38>)
c0d02282:	9b00      	ldr	r3, [sp, #0]
c0d02284:	428b      	cmp	r3, r1
c0d02286:	d101      	bne.n	c0d0228c <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02288:	b004      	add	sp, #16
c0d0228a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0228c:	6810      	ldr	r0, [r2, #0]
c0d0228e:	2104      	movs	r1, #4
c0d02290:	f001 fc78 	bl	c0d03b84 <longjmp>
c0d02294:	60000c3c 	.word	0x60000c3c
c0d02298:	20001bb8 	.word	0x20001bb8
c0d0229c:	90000c39 	.word	0x90000c39

c0d022a0 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d022a0:	b5b0      	push	{r4, r5, r7, lr}
c0d022a2:	af02      	add	r7, sp, #8
c0d022a4:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d022a6:	4c0b      	ldr	r4, [pc, #44]	; (c0d022d4 <cx_hash+0x34>)
c0d022a8:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022aa:	4c0b      	ldr	r4, [pc, #44]	; (c0d022d8 <cx_hash+0x38>)
c0d022ac:	6825      	ldr	r5, [r4, #0]
c0d022ae:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d022b0:	ad03      	add	r5, sp, #12
c0d022b2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d022b4:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d022b6:	9007      	str	r0, [sp, #28]
c0d022b8:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022ba:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022bc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022be:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d022c0:	4906      	ldr	r1, [pc, #24]	; (c0d022dc <cx_hash+0x3c>)
c0d022c2:	9a01      	ldr	r2, [sp, #4]
c0d022c4:	428a      	cmp	r2, r1
c0d022c6:	d101      	bne.n	c0d022cc <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d022c8:	b008      	add	sp, #32
c0d022ca:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022cc:	6820      	ldr	r0, [r4, #0]
c0d022ce:	2104      	movs	r1, #4
c0d022d0:	f001 fc58 	bl	c0d03b84 <longjmp>
c0d022d4:	60000ea6 	.word	0x60000ea6
c0d022d8:	20001bb8 	.word	0x20001bb8
c0d022dc:	90000e46 	.word	0x90000e46

c0d022e0 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d022e0:	b5b0      	push	{r4, r5, r7, lr}
c0d022e2:	af02      	add	r7, sp, #8
c0d022e4:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d022e6:	4c0a      	ldr	r4, [pc, #40]	; (c0d02310 <cx_ecfp_init_public_key+0x30>)
c0d022e8:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022ea:	4c0a      	ldr	r4, [pc, #40]	; (c0d02314 <cx_ecfp_init_public_key+0x34>)
c0d022ec:	6825      	ldr	r5, [r4, #0]
c0d022ee:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d022f0:	ad02      	add	r5, sp, #8
c0d022f2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d022f4:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022f6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022f8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022fa:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d022fc:	4906      	ldr	r1, [pc, #24]	; (c0d02318 <cx_ecfp_init_public_key+0x38>)
c0d022fe:	9a00      	ldr	r2, [sp, #0]
c0d02300:	428a      	cmp	r2, r1
c0d02302:	d101      	bne.n	c0d02308 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02304:	b006      	add	sp, #24
c0d02306:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02308:	6820      	ldr	r0, [r4, #0]
c0d0230a:	2104      	movs	r1, #4
c0d0230c:	f001 fc3a 	bl	c0d03b84 <longjmp>
c0d02310:	60002835 	.word	0x60002835
c0d02314:	20001bb8 	.word	0x20001bb8
c0d02318:	900028f0 	.word	0x900028f0

c0d0231c <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d0231c:	b5b0      	push	{r4, r5, r7, lr}
c0d0231e:	af02      	add	r7, sp, #8
c0d02320:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d02322:	4c0a      	ldr	r4, [pc, #40]	; (c0d0234c <cx_ecfp_init_private_key+0x30>)
c0d02324:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02326:	4c0a      	ldr	r4, [pc, #40]	; (c0d02350 <cx_ecfp_init_private_key+0x34>)
c0d02328:	6825      	ldr	r5, [r4, #0]
c0d0232a:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d0232c:	ad02      	add	r5, sp, #8
c0d0232e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02330:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02332:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02334:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02336:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d02338:	4906      	ldr	r1, [pc, #24]	; (c0d02354 <cx_ecfp_init_private_key+0x38>)
c0d0233a:	9a00      	ldr	r2, [sp, #0]
c0d0233c:	428a      	cmp	r2, r1
c0d0233e:	d101      	bne.n	c0d02344 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02340:	b006      	add	sp, #24
c0d02342:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02344:	6820      	ldr	r0, [r4, #0]
c0d02346:	2104      	movs	r1, #4
c0d02348:	f001 fc1c 	bl	c0d03b84 <longjmp>
c0d0234c:	600029ed 	.word	0x600029ed
c0d02350:	20001bb8 	.word	0x20001bb8
c0d02354:	900029ae 	.word	0x900029ae

c0d02358 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d02358:	b5b0      	push	{r4, r5, r7, lr}
c0d0235a:	af02      	add	r7, sp, #8
c0d0235c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d0235e:	4c0a      	ldr	r4, [pc, #40]	; (c0d02388 <cx_ecfp_generate_pair+0x30>)
c0d02360:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02362:	4c0a      	ldr	r4, [pc, #40]	; (c0d0238c <cx_ecfp_generate_pair+0x34>)
c0d02364:	6825      	ldr	r5, [r4, #0]
c0d02366:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02368:	ad02      	add	r5, sp, #8
c0d0236a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d0236c:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0236e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02370:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02372:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d02374:	4906      	ldr	r1, [pc, #24]	; (c0d02390 <cx_ecfp_generate_pair+0x38>)
c0d02376:	9a00      	ldr	r2, [sp, #0]
c0d02378:	428a      	cmp	r2, r1
c0d0237a:	d101      	bne.n	c0d02380 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0237c:	b006      	add	sp, #24
c0d0237e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02380:	6820      	ldr	r0, [r4, #0]
c0d02382:	2104      	movs	r1, #4
c0d02384:	f001 fbfe 	bl	c0d03b84 <longjmp>
c0d02388:	60002a2e 	.word	0x60002a2e
c0d0238c:	20001bb8 	.word	0x20001bb8
c0d02390:	90002a74 	.word	0x90002a74

c0d02394 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d02394:	b5b0      	push	{r4, r5, r7, lr}
c0d02396:	af02      	add	r7, sp, #8
c0d02398:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d0239a:	4c0b      	ldr	r4, [pc, #44]	; (c0d023c8 <os_perso_derive_node_bip32+0x34>)
c0d0239c:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0239e:	4c0b      	ldr	r4, [pc, #44]	; (c0d023cc <os_perso_derive_node_bip32+0x38>)
c0d023a0:	6825      	ldr	r5, [r4, #0]
c0d023a2:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d023a4:	ad03      	add	r5, sp, #12
c0d023a6:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d023a8:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d023aa:	9007      	str	r0, [sp, #28]
c0d023ac:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d023ae:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d023b0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d023b2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d023b4:	4806      	ldr	r0, [pc, #24]	; (c0d023d0 <os_perso_derive_node_bip32+0x3c>)
c0d023b6:	9901      	ldr	r1, [sp, #4]
c0d023b8:	4281      	cmp	r1, r0
c0d023ba:	d101      	bne.n	c0d023c0 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d023bc:	b008      	add	sp, #32
c0d023be:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023c0:	6820      	ldr	r0, [r4, #0]
c0d023c2:	2104      	movs	r1, #4
c0d023c4:	f001 fbde 	bl	c0d03b84 <longjmp>
c0d023c8:	6000512b 	.word	0x6000512b
c0d023cc:	20001bb8 	.word	0x20001bb8
c0d023d0:	9000517f 	.word	0x9000517f

c0d023d4 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d023d4:	b580      	push	{r7, lr}
c0d023d6:	af00      	add	r7, sp, #0
c0d023d8:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d023da:	490a      	ldr	r1, [pc, #40]	; (c0d02404 <os_sched_exit+0x30>)
c0d023dc:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d023de:	490a      	ldr	r1, [pc, #40]	; (c0d02408 <os_sched_exit+0x34>)
c0d023e0:	680a      	ldr	r2, [r1, #0]
c0d023e2:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d023e4:	9003      	str	r0, [sp, #12]
c0d023e6:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d023e8:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d023ea:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d023ec:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d023ee:	4807      	ldr	r0, [pc, #28]	; (c0d0240c <os_sched_exit+0x38>)
c0d023f0:	9a01      	ldr	r2, [sp, #4]
c0d023f2:	4282      	cmp	r2, r0
c0d023f4:	d101      	bne.n	c0d023fa <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d023f6:	b004      	add	sp, #16
c0d023f8:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023fa:	6808      	ldr	r0, [r1, #0]
c0d023fc:	2104      	movs	r1, #4
c0d023fe:	f001 fbc1 	bl	c0d03b84 <longjmp>
c0d02402:	46c0      	nop			; (mov r8, r8)
c0d02404:	60005fe1 	.word	0x60005fe1
c0d02408:	20001bb8 	.word	0x20001bb8
c0d0240c:	90005f6f 	.word	0x90005f6f

c0d02410 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d02410:	b580      	push	{r7, lr}
c0d02412:	af00      	add	r7, sp, #0
c0d02414:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d02416:	490a      	ldr	r1, [pc, #40]	; (c0d02440 <os_ux+0x30>)
c0d02418:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0241a:	490a      	ldr	r1, [pc, #40]	; (c0d02444 <os_ux+0x34>)
c0d0241c:	680a      	ldr	r2, [r1, #0]
c0d0241e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d02420:	9003      	str	r0, [sp, #12]
c0d02422:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02424:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02426:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02428:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d0242a:	4a07      	ldr	r2, [pc, #28]	; (c0d02448 <os_ux+0x38>)
c0d0242c:	9b01      	ldr	r3, [sp, #4]
c0d0242e:	4293      	cmp	r3, r2
c0d02430:	d101      	bne.n	c0d02436 <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02432:	b004      	add	sp, #16
c0d02434:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02436:	6808      	ldr	r0, [r1, #0]
c0d02438:	2104      	movs	r1, #4
c0d0243a:	f001 fba3 	bl	c0d03b84 <longjmp>
c0d0243e:	46c0      	nop			; (mov r8, r8)
c0d02440:	60006158 	.word	0x60006158
c0d02444:	20001bb8 	.word	0x20001bb8
c0d02448:	9000611f 	.word	0x9000611f

c0d0244c <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d0244c:	b580      	push	{r7, lr}
c0d0244e:	af00      	add	r7, sp, #0
c0d02450:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d02452:	4809      	ldr	r0, [pc, #36]	; (c0d02478 <os_seph_features+0x2c>)
c0d02454:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02456:	4909      	ldr	r1, [pc, #36]	; (c0d0247c <os_seph_features+0x30>)
c0d02458:	6808      	ldr	r0, [r1, #0]
c0d0245a:	9001      	str	r0, [sp, #4]
c0d0245c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0245e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02460:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02462:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d02464:	4a06      	ldr	r2, [pc, #24]	; (c0d02480 <os_seph_features+0x34>)
c0d02466:	9b00      	ldr	r3, [sp, #0]
c0d02468:	4293      	cmp	r3, r2
c0d0246a:	d101      	bne.n	c0d02470 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0246c:	b002      	add	sp, #8
c0d0246e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02470:	6808      	ldr	r0, [r1, #0]
c0d02472:	2104      	movs	r1, #4
c0d02474:	f001 fb86 	bl	c0d03b84 <longjmp>
c0d02478:	600064d6 	.word	0x600064d6
c0d0247c:	20001bb8 	.word	0x20001bb8
c0d02480:	90006444 	.word	0x90006444

c0d02484 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d02484:	b580      	push	{r7, lr}
c0d02486:	af00      	add	r7, sp, #0
c0d02488:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d0248a:	4a0a      	ldr	r2, [pc, #40]	; (c0d024b4 <io_seproxyhal_spi_send+0x30>)
c0d0248c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0248e:	4a0a      	ldr	r2, [pc, #40]	; (c0d024b8 <io_seproxyhal_spi_send+0x34>)
c0d02490:	6813      	ldr	r3, [r2, #0]
c0d02492:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d02494:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d02496:	9103      	str	r1, [sp, #12]
c0d02498:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0249a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0249c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0249e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d024a0:	4806      	ldr	r0, [pc, #24]	; (c0d024bc <io_seproxyhal_spi_send+0x38>)
c0d024a2:	9900      	ldr	r1, [sp, #0]
c0d024a4:	4281      	cmp	r1, r0
c0d024a6:	d101      	bne.n	c0d024ac <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d024a8:	b004      	add	sp, #16
c0d024aa:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d024ac:	6810      	ldr	r0, [r2, #0]
c0d024ae:	2104      	movs	r1, #4
c0d024b0:	f001 fb68 	bl	c0d03b84 <longjmp>
c0d024b4:	60006a1c 	.word	0x60006a1c
c0d024b8:	20001bb8 	.word	0x20001bb8
c0d024bc:	90006af3 	.word	0x90006af3

c0d024c0 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d024c0:	b580      	push	{r7, lr}
c0d024c2:	af00      	add	r7, sp, #0
c0d024c4:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d024c6:	4809      	ldr	r0, [pc, #36]	; (c0d024ec <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d024c8:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d024ca:	4909      	ldr	r1, [pc, #36]	; (c0d024f0 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d024cc:	6808      	ldr	r0, [r1, #0]
c0d024ce:	9001      	str	r0, [sp, #4]
c0d024d0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d024d2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d024d4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d024d6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d024d8:	4a06      	ldr	r2, [pc, #24]	; (c0d024f4 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d024da:	9b00      	ldr	r3, [sp, #0]
c0d024dc:	4293      	cmp	r3, r2
c0d024de:	d101      	bne.n	c0d024e4 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d024e0:	b002      	add	sp, #8
c0d024e2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d024e4:	6808      	ldr	r0, [r1, #0]
c0d024e6:	2104      	movs	r1, #4
c0d024e8:	f001 fb4c 	bl	c0d03b84 <longjmp>
c0d024ec:	60006bcf 	.word	0x60006bcf
c0d024f0:	20001bb8 	.word	0x20001bb8
c0d024f4:	90006b7f 	.word	0x90006b7f

c0d024f8 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d024f8:	b5d0      	push	{r4, r6, r7, lr}
c0d024fa:	af02      	add	r7, sp, #8
c0d024fc:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d024fe:	4b0b      	ldr	r3, [pc, #44]	; (c0d0252c <io_seproxyhal_spi_recv+0x34>)
c0d02500:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02502:	4b0b      	ldr	r3, [pc, #44]	; (c0d02530 <io_seproxyhal_spi_recv+0x38>)
c0d02504:	681c      	ldr	r4, [r3, #0]
c0d02506:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d02508:	ac03      	add	r4, sp, #12
c0d0250a:	c407      	stmia	r4!, {r0, r1, r2}
c0d0250c:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0250e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02510:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02512:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d02514:	4907      	ldr	r1, [pc, #28]	; (c0d02534 <io_seproxyhal_spi_recv+0x3c>)
c0d02516:	9a01      	ldr	r2, [sp, #4]
c0d02518:	428a      	cmp	r2, r1
c0d0251a:	d102      	bne.n	c0d02522 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d0251c:	b280      	uxth	r0, r0
c0d0251e:	b006      	add	sp, #24
c0d02520:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02522:	6818      	ldr	r0, [r3, #0]
c0d02524:	2104      	movs	r1, #4
c0d02526:	f001 fb2d 	bl	c0d03b84 <longjmp>
c0d0252a:	46c0      	nop			; (mov r8, r8)
c0d0252c:	60006cd1 	.word	0x60006cd1
c0d02530:	20001bb8 	.word	0x20001bb8
c0d02534:	90006c2b 	.word	0x90006c2b

c0d02538 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02538:	b5b0      	push	{r4, r5, r7, lr}
c0d0253a:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d0253c:	492c      	ldr	r1, [pc, #176]	; (c0d025f0 <bagl_ui_nanos_screen1_button+0xb8>)
c0d0253e:	4288      	cmp	r0, r1
c0d02540:	d006      	beq.n	c0d02550 <bagl_ui_nanos_screen1_button+0x18>
c0d02542:	492c      	ldr	r1, [pc, #176]	; (c0d025f4 <bagl_ui_nanos_screen1_button+0xbc>)
c0d02544:	4288      	cmp	r0, r1
c0d02546:	d151      	bne.n	c0d025ec <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d02548:	2000      	movs	r0, #0
c0d0254a:	f7ff ff43 	bl	c0d023d4 <os_sched_exit>
c0d0254e:	e04d      	b.n	c0d025ec <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d02550:	f7fe fba4 	bl	c0d00c9c <nvram_is_init>
c0d02554:	2801      	cmp	r0, #1
c0d02556:	d102      	bne.n	c0d0255e <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d02558:	a029      	add	r0, pc, #164	; (adr r0, c0d02600 <bagl_ui_nanos_screen1_button+0xc8>)
c0d0255a:	210d      	movs	r1, #13
c0d0255c:	e001      	b.n	c0d02562 <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d0255e:	a026      	add	r0, pc, #152	; (adr r0, c0d025f8 <bagl_ui_nanos_screen1_button+0xc0>)
c0d02560:	2105      	movs	r1, #5
c0d02562:	2203      	movs	r2, #3
c0d02564:	f7fd fe88 	bl	c0d00278 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02568:	4c29      	ldr	r4, [pc, #164]	; (c0d02610 <bagl_ui_nanos_screen1_button+0xd8>)
c0d0256a:	482b      	ldr	r0, [pc, #172]	; (c0d02618 <bagl_ui_nanos_screen1_button+0xe0>)
c0d0256c:	4478      	add	r0, pc
c0d0256e:	6020      	str	r0, [r4, #0]
c0d02570:	2004      	movs	r0, #4
c0d02572:	6060      	str	r0, [r4, #4]
c0d02574:	4829      	ldr	r0, [pc, #164]	; (c0d0261c <bagl_ui_nanos_screen1_button+0xe4>)
c0d02576:	4478      	add	r0, pc
c0d02578:	6120      	str	r0, [r4, #16]
c0d0257a:	2500      	movs	r5, #0
c0d0257c:	60e5      	str	r5, [r4, #12]
c0d0257e:	2003      	movs	r0, #3
c0d02580:	7620      	strb	r0, [r4, #24]
c0d02582:	61e5      	str	r5, [r4, #28]
c0d02584:	4620      	mov	r0, r4
c0d02586:	3018      	adds	r0, #24
c0d02588:	f7ff ff42 	bl	c0d02410 <os_ux>
c0d0258c:	61e0      	str	r0, [r4, #28]
c0d0258e:	f7ff f903 	bl	c0d01798 <io_seproxyhal_init_ux>
c0d02592:	60a5      	str	r5, [r4, #8]
c0d02594:	6820      	ldr	r0, [r4, #0]
c0d02596:	2800      	cmp	r0, #0
c0d02598:	d028      	beq.n	c0d025ec <bagl_ui_nanos_screen1_button+0xb4>
c0d0259a:	69e0      	ldr	r0, [r4, #28]
c0d0259c:	491d      	ldr	r1, [pc, #116]	; (c0d02614 <bagl_ui_nanos_screen1_button+0xdc>)
c0d0259e:	4288      	cmp	r0, r1
c0d025a0:	d116      	bne.n	c0d025d0 <bagl_ui_nanos_screen1_button+0x98>
c0d025a2:	e023      	b.n	c0d025ec <bagl_ui_nanos_screen1_button+0xb4>
c0d025a4:	6860      	ldr	r0, [r4, #4]
c0d025a6:	4285      	cmp	r5, r0
c0d025a8:	d220      	bcs.n	c0d025ec <bagl_ui_nanos_screen1_button+0xb4>
c0d025aa:	f7ff ff89 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d025ae:	2800      	cmp	r0, #0
c0d025b0:	d11c      	bne.n	c0d025ec <bagl_ui_nanos_screen1_button+0xb4>
c0d025b2:	68a0      	ldr	r0, [r4, #8]
c0d025b4:	68e1      	ldr	r1, [r4, #12]
c0d025b6:	2538      	movs	r5, #56	; 0x38
c0d025b8:	4368      	muls	r0, r5
c0d025ba:	6822      	ldr	r2, [r4, #0]
c0d025bc:	1810      	adds	r0, r2, r0
c0d025be:	2900      	cmp	r1, #0
c0d025c0:	d009      	beq.n	c0d025d6 <bagl_ui_nanos_screen1_button+0x9e>
c0d025c2:	4788      	blx	r1
c0d025c4:	2800      	cmp	r0, #0
c0d025c6:	d106      	bne.n	c0d025d6 <bagl_ui_nanos_screen1_button+0x9e>
c0d025c8:	68a0      	ldr	r0, [r4, #8]
c0d025ca:	1c45      	adds	r5, r0, #1
c0d025cc:	60a5      	str	r5, [r4, #8]
c0d025ce:	6820      	ldr	r0, [r4, #0]
c0d025d0:	2800      	cmp	r0, #0
c0d025d2:	d1e7      	bne.n	c0d025a4 <bagl_ui_nanos_screen1_button+0x6c>
c0d025d4:	e00a      	b.n	c0d025ec <bagl_ui_nanos_screen1_button+0xb4>
c0d025d6:	2801      	cmp	r0, #1
c0d025d8:	d103      	bne.n	c0d025e2 <bagl_ui_nanos_screen1_button+0xaa>
c0d025da:	68a0      	ldr	r0, [r4, #8]
c0d025dc:	4345      	muls	r5, r0
c0d025de:	6820      	ldr	r0, [r4, #0]
c0d025e0:	1940      	adds	r0, r0, r5
c0d025e2:	f7fe fb91 	bl	c0d00d08 <io_seproxyhal_display>
c0d025e6:	68a0      	ldr	r0, [r4, #8]
c0d025e8:	1c40      	adds	r0, r0, #1
c0d025ea:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d025ec:	2000      	movs	r0, #0
c0d025ee:	bdb0      	pop	{r4, r5, r7, pc}
c0d025f0:	80000002 	.word	0x80000002
c0d025f4:	80000001 	.word	0x80000001
c0d025f8:	54494e49 	.word	0x54494e49
c0d025fc:	00000000 	.word	0x00000000
c0d02600:	6c697453 	.word	0x6c697453
c0d02604:	6e75206c 	.word	0x6e75206c
c0d02608:	74696e69 	.word	0x74696e69
c0d0260c:	00000000 	.word	0x00000000
c0d02610:	20001a98 	.word	0x20001a98
c0d02614:	b0105044 	.word	0xb0105044
c0d02618:	00001854 	.word	0x00001854
c0d0261c:	00000153 	.word	0x00000153

c0d02620 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d02620:	b5b0      	push	{r4, r5, r7, lr}
c0d02622:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d02624:	2800      	cmp	r0, #0
c0d02626:	d005      	beq.n	c0d02634 <ui_display_debug+0x14>
c0d02628:	2900      	cmp	r1, #0
c0d0262a:	d003      	beq.n	c0d02634 <ui_display_debug+0x14>
c0d0262c:	2a00      	cmp	r2, #0
c0d0262e:	d001      	beq.n	c0d02634 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d02630:	f7fd fe22 	bl	c0d00278 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02634:	4c21      	ldr	r4, [pc, #132]	; (c0d026bc <ui_display_debug+0x9c>)
c0d02636:	4823      	ldr	r0, [pc, #140]	; (c0d026c4 <ui_display_debug+0xa4>)
c0d02638:	4478      	add	r0, pc
c0d0263a:	6020      	str	r0, [r4, #0]
c0d0263c:	2004      	movs	r0, #4
c0d0263e:	6060      	str	r0, [r4, #4]
c0d02640:	4821      	ldr	r0, [pc, #132]	; (c0d026c8 <ui_display_debug+0xa8>)
c0d02642:	4478      	add	r0, pc
c0d02644:	6120      	str	r0, [r4, #16]
c0d02646:	2500      	movs	r5, #0
c0d02648:	60e5      	str	r5, [r4, #12]
c0d0264a:	2003      	movs	r0, #3
c0d0264c:	7620      	strb	r0, [r4, #24]
c0d0264e:	61e5      	str	r5, [r4, #28]
c0d02650:	4620      	mov	r0, r4
c0d02652:	3018      	adds	r0, #24
c0d02654:	f7ff fedc 	bl	c0d02410 <os_ux>
c0d02658:	61e0      	str	r0, [r4, #28]
c0d0265a:	f7ff f89d 	bl	c0d01798 <io_seproxyhal_init_ux>
c0d0265e:	60a5      	str	r5, [r4, #8]
c0d02660:	6820      	ldr	r0, [r4, #0]
c0d02662:	2800      	cmp	r0, #0
c0d02664:	d028      	beq.n	c0d026b8 <ui_display_debug+0x98>
c0d02666:	69e0      	ldr	r0, [r4, #28]
c0d02668:	4915      	ldr	r1, [pc, #84]	; (c0d026c0 <ui_display_debug+0xa0>)
c0d0266a:	4288      	cmp	r0, r1
c0d0266c:	d116      	bne.n	c0d0269c <ui_display_debug+0x7c>
c0d0266e:	e023      	b.n	c0d026b8 <ui_display_debug+0x98>
c0d02670:	6860      	ldr	r0, [r4, #4]
c0d02672:	4285      	cmp	r5, r0
c0d02674:	d220      	bcs.n	c0d026b8 <ui_display_debug+0x98>
c0d02676:	f7ff ff23 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d0267a:	2800      	cmp	r0, #0
c0d0267c:	d11c      	bne.n	c0d026b8 <ui_display_debug+0x98>
c0d0267e:	68a0      	ldr	r0, [r4, #8]
c0d02680:	68e1      	ldr	r1, [r4, #12]
c0d02682:	2538      	movs	r5, #56	; 0x38
c0d02684:	4368      	muls	r0, r5
c0d02686:	6822      	ldr	r2, [r4, #0]
c0d02688:	1810      	adds	r0, r2, r0
c0d0268a:	2900      	cmp	r1, #0
c0d0268c:	d009      	beq.n	c0d026a2 <ui_display_debug+0x82>
c0d0268e:	4788      	blx	r1
c0d02690:	2800      	cmp	r0, #0
c0d02692:	d106      	bne.n	c0d026a2 <ui_display_debug+0x82>
c0d02694:	68a0      	ldr	r0, [r4, #8]
c0d02696:	1c45      	adds	r5, r0, #1
c0d02698:	60a5      	str	r5, [r4, #8]
c0d0269a:	6820      	ldr	r0, [r4, #0]
c0d0269c:	2800      	cmp	r0, #0
c0d0269e:	d1e7      	bne.n	c0d02670 <ui_display_debug+0x50>
c0d026a0:	e00a      	b.n	c0d026b8 <ui_display_debug+0x98>
c0d026a2:	2801      	cmp	r0, #1
c0d026a4:	d103      	bne.n	c0d026ae <ui_display_debug+0x8e>
c0d026a6:	68a0      	ldr	r0, [r4, #8]
c0d026a8:	4345      	muls	r5, r0
c0d026aa:	6820      	ldr	r0, [r4, #0]
c0d026ac:	1940      	adds	r0, r0, r5
c0d026ae:	f7fe fb2b 	bl	c0d00d08 <io_seproxyhal_display>
c0d026b2:	68a0      	ldr	r0, [r4, #8]
c0d026b4:	1c40      	adds	r0, r0, #1
c0d026b6:	60a0      	str	r0, [r4, #8]
}
c0d026b8:	bdb0      	pop	{r4, r5, r7, pc}
c0d026ba:	46c0      	nop			; (mov r8, r8)
c0d026bc:	20001a98 	.word	0x20001a98
c0d026c0:	b0105044 	.word	0xb0105044
c0d026c4:	00001788 	.word	0x00001788
c0d026c8:	00000087 	.word	0x00000087

c0d026cc <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d026cc:	b580      	push	{r7, lr}
c0d026ce:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d026d0:	4905      	ldr	r1, [pc, #20]	; (c0d026e8 <bagl_ui_nanos_screen2_button+0x1c>)
c0d026d2:	4288      	cmp	r0, r1
c0d026d4:	d002      	beq.n	c0d026dc <bagl_ui_nanos_screen2_button+0x10>
c0d026d6:	4905      	ldr	r1, [pc, #20]	; (c0d026ec <bagl_ui_nanos_screen2_button+0x20>)
c0d026d8:	4288      	cmp	r0, r1
c0d026da:	d102      	bne.n	c0d026e2 <bagl_ui_nanos_screen2_button+0x16>
c0d026dc:	2000      	movs	r0, #0
c0d026de:	f7ff fe79 	bl	c0d023d4 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d026e2:	2000      	movs	r0, #0
c0d026e4:	bd80      	pop	{r7, pc}
c0d026e6:	46c0      	nop			; (mov r8, r8)
c0d026e8:	80000002 	.word	0x80000002
c0d026ec:	80000001 	.word	0x80000001

c0d026f0 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d026f0:	b5b0      	push	{r4, r5, r7, lr}
c0d026f2:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d026f4:	2001      	movs	r0, #1
c0d026f6:	0204      	lsls	r4, r0, #8
c0d026f8:	f7ff fea8 	bl	c0d0244c <os_seph_features>
c0d026fc:	4220      	tst	r0, r4
c0d026fe:	d136      	bne.n	c0d0276e <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d02700:	4c3c      	ldr	r4, [pc, #240]	; (c0d027f4 <ui_idle+0x104>)
c0d02702:	4840      	ldr	r0, [pc, #256]	; (c0d02804 <ui_idle+0x114>)
c0d02704:	4478      	add	r0, pc
c0d02706:	6020      	str	r0, [r4, #0]
c0d02708:	2004      	movs	r0, #4
c0d0270a:	6060      	str	r0, [r4, #4]
c0d0270c:	483e      	ldr	r0, [pc, #248]	; (c0d02808 <ui_idle+0x118>)
c0d0270e:	4478      	add	r0, pc
c0d02710:	6120      	str	r0, [r4, #16]
c0d02712:	2500      	movs	r5, #0
c0d02714:	60e5      	str	r5, [r4, #12]
c0d02716:	2003      	movs	r0, #3
c0d02718:	7620      	strb	r0, [r4, #24]
c0d0271a:	61e5      	str	r5, [r4, #28]
c0d0271c:	4620      	mov	r0, r4
c0d0271e:	3018      	adds	r0, #24
c0d02720:	f7ff fe76 	bl	c0d02410 <os_ux>
c0d02724:	61e0      	str	r0, [r4, #28]
c0d02726:	f7ff f837 	bl	c0d01798 <io_seproxyhal_init_ux>
c0d0272a:	60a5      	str	r5, [r4, #8]
c0d0272c:	6820      	ldr	r0, [r4, #0]
c0d0272e:	2800      	cmp	r0, #0
c0d02730:	d05f      	beq.n	c0d027f2 <ui_idle+0x102>
c0d02732:	69e0      	ldr	r0, [r4, #28]
c0d02734:	4930      	ldr	r1, [pc, #192]	; (c0d027f8 <ui_idle+0x108>)
c0d02736:	4288      	cmp	r0, r1
c0d02738:	d116      	bne.n	c0d02768 <ui_idle+0x78>
c0d0273a:	e05a      	b.n	c0d027f2 <ui_idle+0x102>
c0d0273c:	6860      	ldr	r0, [r4, #4]
c0d0273e:	4285      	cmp	r5, r0
c0d02740:	d257      	bcs.n	c0d027f2 <ui_idle+0x102>
c0d02742:	f7ff febd 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d02746:	2800      	cmp	r0, #0
c0d02748:	d153      	bne.n	c0d027f2 <ui_idle+0x102>
c0d0274a:	68a0      	ldr	r0, [r4, #8]
c0d0274c:	68e1      	ldr	r1, [r4, #12]
c0d0274e:	2538      	movs	r5, #56	; 0x38
c0d02750:	4368      	muls	r0, r5
c0d02752:	6822      	ldr	r2, [r4, #0]
c0d02754:	1810      	adds	r0, r2, r0
c0d02756:	2900      	cmp	r1, #0
c0d02758:	d040      	beq.n	c0d027dc <ui_idle+0xec>
c0d0275a:	4788      	blx	r1
c0d0275c:	2800      	cmp	r0, #0
c0d0275e:	d13d      	bne.n	c0d027dc <ui_idle+0xec>
c0d02760:	68a0      	ldr	r0, [r4, #8]
c0d02762:	1c45      	adds	r5, r0, #1
c0d02764:	60a5      	str	r5, [r4, #8]
c0d02766:	6820      	ldr	r0, [r4, #0]
c0d02768:	2800      	cmp	r0, #0
c0d0276a:	d1e7      	bne.n	c0d0273c <ui_idle+0x4c>
c0d0276c:	e041      	b.n	c0d027f2 <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d0276e:	4c21      	ldr	r4, [pc, #132]	; (c0d027f4 <ui_idle+0x104>)
c0d02770:	4822      	ldr	r0, [pc, #136]	; (c0d027fc <ui_idle+0x10c>)
c0d02772:	4478      	add	r0, pc
c0d02774:	6020      	str	r0, [r4, #0]
c0d02776:	2004      	movs	r0, #4
c0d02778:	6060      	str	r0, [r4, #4]
c0d0277a:	4821      	ldr	r0, [pc, #132]	; (c0d02800 <ui_idle+0x110>)
c0d0277c:	4478      	add	r0, pc
c0d0277e:	6120      	str	r0, [r4, #16]
c0d02780:	2500      	movs	r5, #0
c0d02782:	60e5      	str	r5, [r4, #12]
c0d02784:	2003      	movs	r0, #3
c0d02786:	7620      	strb	r0, [r4, #24]
c0d02788:	61e5      	str	r5, [r4, #28]
c0d0278a:	4620      	mov	r0, r4
c0d0278c:	3018      	adds	r0, #24
c0d0278e:	f7ff fe3f 	bl	c0d02410 <os_ux>
c0d02792:	61e0      	str	r0, [r4, #28]
c0d02794:	f7ff f800 	bl	c0d01798 <io_seproxyhal_init_ux>
c0d02798:	60a5      	str	r5, [r4, #8]
c0d0279a:	6820      	ldr	r0, [r4, #0]
c0d0279c:	2800      	cmp	r0, #0
c0d0279e:	d028      	beq.n	c0d027f2 <ui_idle+0x102>
c0d027a0:	69e0      	ldr	r0, [r4, #28]
c0d027a2:	4915      	ldr	r1, [pc, #84]	; (c0d027f8 <ui_idle+0x108>)
c0d027a4:	4288      	cmp	r0, r1
c0d027a6:	d116      	bne.n	c0d027d6 <ui_idle+0xe6>
c0d027a8:	e023      	b.n	c0d027f2 <ui_idle+0x102>
c0d027aa:	6860      	ldr	r0, [r4, #4]
c0d027ac:	4285      	cmp	r5, r0
c0d027ae:	d220      	bcs.n	c0d027f2 <ui_idle+0x102>
c0d027b0:	f7ff fe86 	bl	c0d024c0 <io_seproxyhal_spi_is_status_sent>
c0d027b4:	2800      	cmp	r0, #0
c0d027b6:	d11c      	bne.n	c0d027f2 <ui_idle+0x102>
c0d027b8:	68a0      	ldr	r0, [r4, #8]
c0d027ba:	68e1      	ldr	r1, [r4, #12]
c0d027bc:	2538      	movs	r5, #56	; 0x38
c0d027be:	4368      	muls	r0, r5
c0d027c0:	6822      	ldr	r2, [r4, #0]
c0d027c2:	1810      	adds	r0, r2, r0
c0d027c4:	2900      	cmp	r1, #0
c0d027c6:	d009      	beq.n	c0d027dc <ui_idle+0xec>
c0d027c8:	4788      	blx	r1
c0d027ca:	2800      	cmp	r0, #0
c0d027cc:	d106      	bne.n	c0d027dc <ui_idle+0xec>
c0d027ce:	68a0      	ldr	r0, [r4, #8]
c0d027d0:	1c45      	adds	r5, r0, #1
c0d027d2:	60a5      	str	r5, [r4, #8]
c0d027d4:	6820      	ldr	r0, [r4, #0]
c0d027d6:	2800      	cmp	r0, #0
c0d027d8:	d1e7      	bne.n	c0d027aa <ui_idle+0xba>
c0d027da:	e00a      	b.n	c0d027f2 <ui_idle+0x102>
c0d027dc:	2801      	cmp	r0, #1
c0d027de:	d103      	bne.n	c0d027e8 <ui_idle+0xf8>
c0d027e0:	68a0      	ldr	r0, [r4, #8]
c0d027e2:	4345      	muls	r5, r0
c0d027e4:	6820      	ldr	r0, [r4, #0]
c0d027e6:	1940      	adds	r0, r0, r5
c0d027e8:	f7fe fa8e 	bl	c0d00d08 <io_seproxyhal_display>
c0d027ec:	68a0      	ldr	r0, [r4, #8]
c0d027ee:	1c40      	adds	r0, r0, #1
c0d027f0:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d027f2:	bdb0      	pop	{r4, r5, r7, pc}
c0d027f4:	20001a98 	.word	0x20001a98
c0d027f8:	b0105044 	.word	0xb0105044
c0d027fc:	0000172e 	.word	0x0000172e
c0d02800:	0000008d 	.word	0x0000008d
c0d02804:	000015dc 	.word	0x000015dc
c0d02808:	fffffe27 	.word	0xfffffe27

c0d0280c <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d0280c:	2000      	movs	r0, #0
c0d0280e:	4770      	bx	lr

c0d02810 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d02810:	b5d0      	push	{r4, r6, r7, lr}
c0d02812:	af02      	add	r7, sp, #8
c0d02814:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d02816:	4620      	mov	r0, r4
c0d02818:	f7ff fddc 	bl	c0d023d4 <os_sched_exit>
    return NULL;
c0d0281c:	4620      	mov	r0, r4
c0d0281e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02820 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02820:	4902      	ldr	r1, [pc, #8]	; (c0d0282c <USBD_LL_Init+0xc>)
c0d02822:	2000      	movs	r0, #0
c0d02824:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d02826:	4902      	ldr	r1, [pc, #8]	; (c0d02830 <USBD_LL_Init+0x10>)
c0d02828:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d0282a:	4770      	bx	lr
c0d0282c:	20001d2c 	.word	0x20001d2c
c0d02830:	20001d30 	.word	0x20001d30

c0d02834 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02834:	b5d0      	push	{r4, r6, r7, lr}
c0d02836:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02838:	4806      	ldr	r0, [pc, #24]	; (c0d02854 <USBD_LL_DeInit+0x20>)
c0d0283a:	214f      	movs	r1, #79	; 0x4f
c0d0283c:	7001      	strb	r1, [r0, #0]
c0d0283e:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02840:	7044      	strb	r4, [r0, #1]
c0d02842:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02844:	7081      	strb	r1, [r0, #2]
c0d02846:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02848:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0284a:	2104      	movs	r1, #4
c0d0284c:	f7ff fe1a 	bl	c0d02484 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02850:	4620      	mov	r0, r4
c0d02852:	bdd0      	pop	{r4, r6, r7, pc}
c0d02854:	20001a18 	.word	0x20001a18

c0d02858 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02858:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0285a:	af03      	add	r7, sp, #12
c0d0285c:	b083      	sub	sp, #12
c0d0285e:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02860:	264f      	movs	r6, #79	; 0x4f
c0d02862:	702e      	strb	r6, [r5, #0]
c0d02864:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02866:	706c      	strb	r4, [r5, #1]
c0d02868:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d0286a:	70a8      	strb	r0, [r5, #2]
c0d0286c:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0286e:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d02870:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02872:	2105      	movs	r1, #5
c0d02874:	4628      	mov	r0, r5
c0d02876:	f7ff fe05 	bl	c0d02484 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0287a:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d0287c:	706c      	strb	r4, [r5, #1]
c0d0287e:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d02880:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d02882:	70e8      	strb	r0, [r5, #3]
c0d02884:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d02886:	4628      	mov	r0, r5
c0d02888:	f7ff fdfc 	bl	c0d02484 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0288c:	4620      	mov	r0, r4
c0d0288e:	b003      	add	sp, #12
c0d02890:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02892 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d02892:	b5d0      	push	{r4, r6, r7, lr}
c0d02894:	af02      	add	r7, sp, #8
c0d02896:	b082      	sub	sp, #8
c0d02898:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0289a:	214f      	movs	r1, #79	; 0x4f
c0d0289c:	7001      	strb	r1, [r0, #0]
c0d0289e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d028a0:	7044      	strb	r4, [r0, #1]
c0d028a2:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d028a4:	7081      	strb	r1, [r0, #2]
c0d028a6:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d028a8:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d028aa:	2104      	movs	r1, #4
c0d028ac:	f7ff fdea 	bl	c0d02484 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d028b0:	4620      	mov	r0, r4
c0d028b2:	b002      	add	sp, #8
c0d028b4:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d028b8 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d028b8:	b5b0      	push	{r4, r5, r7, lr}
c0d028ba:	af02      	add	r7, sp, #8
c0d028bc:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d028be:	480f      	ldr	r0, [pc, #60]	; (c0d028fc <USBD_LL_OpenEP+0x44>)
c0d028c0:	2400      	movs	r4, #0
c0d028c2:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d028c4:	480e      	ldr	r0, [pc, #56]	; (c0d02900 <USBD_LL_OpenEP+0x48>)
c0d028c6:	6004      	str	r4, [r0, #0]
c0d028c8:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d028ca:	254f      	movs	r5, #79	; 0x4f
c0d028cc:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d028ce:	7044      	strb	r4, [r0, #1]
c0d028d0:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d028d2:	7085      	strb	r5, [r0, #2]
c0d028d4:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d028d6:	70c5      	strb	r5, [r0, #3]
c0d028d8:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d028da:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d028dc:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d028de:	2a03      	cmp	r2, #3
c0d028e0:	d802      	bhi.n	c0d028e8 <USBD_LL_OpenEP+0x30>
c0d028e2:	00d0      	lsls	r0, r2, #3
c0d028e4:	4c07      	ldr	r4, [pc, #28]	; (c0d02904 <USBD_LL_OpenEP+0x4c>)
c0d028e6:	40c4      	lsrs	r4, r0
c0d028e8:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d028ea:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d028ec:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d028ee:	2108      	movs	r1, #8
c0d028f0:	f7ff fdc8 	bl	c0d02484 <io_seproxyhal_spi_send>
c0d028f4:	2000      	movs	r0, #0
  return USBD_OK; 
c0d028f6:	b002      	add	sp, #8
c0d028f8:	bdb0      	pop	{r4, r5, r7, pc}
c0d028fa:	46c0      	nop			; (mov r8, r8)
c0d028fc:	20001d2c 	.word	0x20001d2c
c0d02900:	20001d30 	.word	0x20001d30
c0d02904:	02030401 	.word	0x02030401

c0d02908 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02908:	b5d0      	push	{r4, r6, r7, lr}
c0d0290a:	af02      	add	r7, sp, #8
c0d0290c:	b082      	sub	sp, #8
c0d0290e:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02910:	224f      	movs	r2, #79	; 0x4f
c0d02912:	7002      	strb	r2, [r0, #0]
c0d02914:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02916:	7044      	strb	r4, [r0, #1]
c0d02918:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d0291a:	7082      	strb	r2, [r0, #2]
c0d0291c:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0291e:	70c2      	strb	r2, [r0, #3]
c0d02920:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d02922:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02924:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02926:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02928:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d0292a:	2108      	movs	r1, #8
c0d0292c:	f7ff fdaa 	bl	c0d02484 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02930:	4620      	mov	r0, r4
c0d02932:	b002      	add	sp, #8
c0d02934:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02938 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02938:	b5b0      	push	{r4, r5, r7, lr}
c0d0293a:	af02      	add	r7, sp, #8
c0d0293c:	b082      	sub	sp, #8
c0d0293e:	460d      	mov	r5, r1
c0d02940:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02942:	2150      	movs	r1, #80	; 0x50
c0d02944:	7001      	strb	r1, [r0, #0]
c0d02946:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02948:	7044      	strb	r4, [r0, #1]
c0d0294a:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d0294c:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0294e:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02950:	2140      	movs	r1, #64	; 0x40
c0d02952:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02954:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02956:	2106      	movs	r1, #6
c0d02958:	f7ff fd94 	bl	c0d02484 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d0295c:	2080      	movs	r0, #128	; 0x80
c0d0295e:	4205      	tst	r5, r0
c0d02960:	d101      	bne.n	c0d02966 <USBD_LL_StallEP+0x2e>
c0d02962:	4807      	ldr	r0, [pc, #28]	; (c0d02980 <USBD_LL_StallEP+0x48>)
c0d02964:	e000      	b.n	c0d02968 <USBD_LL_StallEP+0x30>
c0d02966:	4805      	ldr	r0, [pc, #20]	; (c0d0297c <USBD_LL_StallEP+0x44>)
c0d02968:	6801      	ldr	r1, [r0, #0]
c0d0296a:	227f      	movs	r2, #127	; 0x7f
c0d0296c:	4015      	ands	r5, r2
c0d0296e:	2201      	movs	r2, #1
c0d02970:	40aa      	lsls	r2, r5
c0d02972:	430a      	orrs	r2, r1
c0d02974:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02976:	4620      	mov	r0, r4
c0d02978:	b002      	add	sp, #8
c0d0297a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0297c:	20001d2c 	.word	0x20001d2c
c0d02980:	20001d30 	.word	0x20001d30

c0d02984 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02984:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02986:	af03      	add	r7, sp, #12
c0d02988:	b083      	sub	sp, #12
c0d0298a:	460d      	mov	r5, r1
c0d0298c:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0298e:	2150      	movs	r1, #80	; 0x50
c0d02990:	7001      	strb	r1, [r0, #0]
c0d02992:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02994:	7044      	strb	r4, [r0, #1]
c0d02996:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02998:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0299a:	70c5      	strb	r5, [r0, #3]
c0d0299c:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d0299e:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d029a0:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d029a2:	2106      	movs	r1, #6
c0d029a4:	f7ff fd6e 	bl	c0d02484 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d029a8:	4235      	tst	r5, r6
c0d029aa:	d101      	bne.n	c0d029b0 <USBD_LL_ClearStallEP+0x2c>
c0d029ac:	4807      	ldr	r0, [pc, #28]	; (c0d029cc <USBD_LL_ClearStallEP+0x48>)
c0d029ae:	e000      	b.n	c0d029b2 <USBD_LL_ClearStallEP+0x2e>
c0d029b0:	4805      	ldr	r0, [pc, #20]	; (c0d029c8 <USBD_LL_ClearStallEP+0x44>)
c0d029b2:	6801      	ldr	r1, [r0, #0]
c0d029b4:	227f      	movs	r2, #127	; 0x7f
c0d029b6:	4015      	ands	r5, r2
c0d029b8:	2201      	movs	r2, #1
c0d029ba:	40aa      	lsls	r2, r5
c0d029bc:	4391      	bics	r1, r2
c0d029be:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d029c0:	4620      	mov	r0, r4
c0d029c2:	b003      	add	sp, #12
c0d029c4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d029c6:	46c0      	nop			; (mov r8, r8)
c0d029c8:	20001d2c 	.word	0x20001d2c
c0d029cc:	20001d30 	.word	0x20001d30

c0d029d0 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d029d0:	2080      	movs	r0, #128	; 0x80
c0d029d2:	4201      	tst	r1, r0
c0d029d4:	d001      	beq.n	c0d029da <USBD_LL_IsStallEP+0xa>
c0d029d6:	4806      	ldr	r0, [pc, #24]	; (c0d029f0 <USBD_LL_IsStallEP+0x20>)
c0d029d8:	e000      	b.n	c0d029dc <USBD_LL_IsStallEP+0xc>
c0d029da:	4804      	ldr	r0, [pc, #16]	; (c0d029ec <USBD_LL_IsStallEP+0x1c>)
c0d029dc:	6800      	ldr	r0, [r0, #0]
c0d029de:	227f      	movs	r2, #127	; 0x7f
c0d029e0:	4011      	ands	r1, r2
c0d029e2:	2201      	movs	r2, #1
c0d029e4:	408a      	lsls	r2, r1
c0d029e6:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d029e8:	b2d0      	uxtb	r0, r2
c0d029ea:	4770      	bx	lr
c0d029ec:	20001d30 	.word	0x20001d30
c0d029f0:	20001d2c 	.word	0x20001d2c

c0d029f4 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d029f4:	b5d0      	push	{r4, r6, r7, lr}
c0d029f6:	af02      	add	r7, sp, #8
c0d029f8:	b082      	sub	sp, #8
c0d029fa:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d029fc:	224f      	movs	r2, #79	; 0x4f
c0d029fe:	7002      	strb	r2, [r0, #0]
c0d02a00:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02a02:	7044      	strb	r4, [r0, #1]
c0d02a04:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d02a06:	7082      	strb	r2, [r0, #2]
c0d02a08:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02a0a:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02a0c:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02a0e:	2105      	movs	r1, #5
c0d02a10:	f7ff fd38 	bl	c0d02484 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02a14:	4620      	mov	r0, r4
c0d02a16:	b002      	add	sp, #8
c0d02a18:	bdd0      	pop	{r4, r6, r7, pc}

c0d02a1a <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d02a1a:	b5b0      	push	{r4, r5, r7, lr}
c0d02a1c:	af02      	add	r7, sp, #8
c0d02a1e:	b082      	sub	sp, #8
c0d02a20:	461c      	mov	r4, r3
c0d02a22:	4615      	mov	r5, r2
c0d02a24:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02a26:	2250      	movs	r2, #80	; 0x50
c0d02a28:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d02a2a:	1ce2      	adds	r2, r4, #3
c0d02a2c:	0a13      	lsrs	r3, r2, #8
c0d02a2e:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d02a30:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d02a32:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02a34:	2120      	movs	r1, #32
c0d02a36:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02a38:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02a3a:	2106      	movs	r1, #6
c0d02a3c:	f7ff fd22 	bl	c0d02484 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02a40:	4628      	mov	r0, r5
c0d02a42:	4621      	mov	r1, r4
c0d02a44:	f7ff fd1e 	bl	c0d02484 <io_seproxyhal_spi_send>
c0d02a48:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02a4a:	b002      	add	sp, #8
c0d02a4c:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a4e <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02a4e:	b5d0      	push	{r4, r6, r7, lr}
c0d02a50:	af02      	add	r7, sp, #8
c0d02a52:	b082      	sub	sp, #8
c0d02a54:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02a56:	2350      	movs	r3, #80	; 0x50
c0d02a58:	7003      	strb	r3, [r0, #0]
c0d02a5a:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02a5c:	7044      	strb	r4, [r0, #1]
c0d02a5e:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02a60:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d02a62:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02a64:	2130      	movs	r1, #48	; 0x30
c0d02a66:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02a68:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02a6a:	2106      	movs	r1, #6
c0d02a6c:	f7ff fd0a 	bl	c0d02484 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d02a70:	4620      	mov	r0, r4
c0d02a72:	b002      	add	sp, #8
c0d02a74:	bdd0      	pop	{r4, r6, r7, pc}

c0d02a76 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02a76:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a78:	af03      	add	r7, sp, #12
c0d02a7a:	b081      	sub	sp, #4
c0d02a7c:	4615      	mov	r5, r2
c0d02a7e:	460e      	mov	r6, r1
c0d02a80:	4604      	mov	r4, r0
c0d02a82:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d02a84:	2c00      	cmp	r4, #0
c0d02a86:	d011      	beq.n	c0d02aac <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02a88:	2049      	movs	r0, #73	; 0x49
c0d02a8a:	0081      	lsls	r1, r0, #2
c0d02a8c:	4620      	mov	r0, r4
c0d02a8e:	f000 ffd7 	bl	c0d03a40 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d02a92:	2e00      	cmp	r6, #0
c0d02a94:	d002      	beq.n	c0d02a9c <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d02a96:	2011      	movs	r0, #17
c0d02a98:	0100      	lsls	r0, r0, #4
c0d02a9a:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02a9c:	20fc      	movs	r0, #252	; 0xfc
c0d02a9e:	2101      	movs	r1, #1
c0d02aa0:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d02aa2:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d02aa4:	4620      	mov	r0, r4
c0d02aa6:	f7ff febb 	bl	c0d02820 <USBD_LL_Init>
c0d02aaa:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d02aac:	b2c0      	uxtb	r0, r0
c0d02aae:	b001      	add	sp, #4
c0d02ab0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02ab2 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d02ab2:	b5d0      	push	{r4, r6, r7, lr}
c0d02ab4:	af02      	add	r7, sp, #8
c0d02ab6:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02ab8:	20fc      	movs	r0, #252	; 0xfc
c0d02aba:	2101      	movs	r1, #1
c0d02abc:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d02abe:	2045      	movs	r0, #69	; 0x45
c0d02ac0:	0080      	lsls	r0, r0, #2
c0d02ac2:	5820      	ldr	r0, [r4, r0]
c0d02ac4:	2800      	cmp	r0, #0
c0d02ac6:	d006      	beq.n	c0d02ad6 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02ac8:	6840      	ldr	r0, [r0, #4]
c0d02aca:	f7ff fb1f 	bl	c0d0210c <pic>
c0d02ace:	4602      	mov	r2, r0
c0d02ad0:	7921      	ldrb	r1, [r4, #4]
c0d02ad2:	4620      	mov	r0, r4
c0d02ad4:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d02ad6:	4620      	mov	r0, r4
c0d02ad8:	f7ff fedb 	bl	c0d02892 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02adc:	4620      	mov	r0, r4
c0d02ade:	f7ff fea9 	bl	c0d02834 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d02ae2:	2000      	movs	r0, #0
c0d02ae4:	bdd0      	pop	{r4, r6, r7, pc}

c0d02ae6 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d02ae6:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d02ae8:	2900      	cmp	r1, #0
c0d02aea:	d003      	beq.n	c0d02af4 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02aec:	2245      	movs	r2, #69	; 0x45
c0d02aee:	0092      	lsls	r2, r2, #2
c0d02af0:	5081      	str	r1, [r0, r2]
c0d02af2:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02af4:	b2d0      	uxtb	r0, r2
c0d02af6:	4770      	bx	lr

c0d02af8 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02af8:	b580      	push	{r7, lr}
c0d02afa:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02afc:	f7ff feac 	bl	c0d02858 <USBD_LL_Start>
  
  return USBD_OK;  
c0d02b00:	2000      	movs	r0, #0
c0d02b02:	bd80      	pop	{r7, pc}

c0d02b04 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02b04:	b5b0      	push	{r4, r5, r7, lr}
c0d02b06:	af02      	add	r7, sp, #8
c0d02b08:	460c      	mov	r4, r1
c0d02b0a:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02b0c:	2045      	movs	r0, #69	; 0x45
c0d02b0e:	0080      	lsls	r0, r0, #2
c0d02b10:	5828      	ldr	r0, [r5, r0]
c0d02b12:	2800      	cmp	r0, #0
c0d02b14:	d00c      	beq.n	c0d02b30 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d02b16:	6800      	ldr	r0, [r0, #0]
c0d02b18:	f7ff faf8 	bl	c0d0210c <pic>
c0d02b1c:	4602      	mov	r2, r0
c0d02b1e:	4628      	mov	r0, r5
c0d02b20:	4621      	mov	r1, r4
c0d02b22:	4790      	blx	r2
c0d02b24:	4601      	mov	r1, r0
c0d02b26:	2002      	movs	r0, #2
c0d02b28:	2900      	cmp	r1, #0
c0d02b2a:	d100      	bne.n	c0d02b2e <USBD_SetClassConfig+0x2a>
c0d02b2c:	4608      	mov	r0, r1
c0d02b2e:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02b30:	2002      	movs	r0, #2
c0d02b32:	bdb0      	pop	{r4, r5, r7, pc}

c0d02b34 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02b34:	b5b0      	push	{r4, r5, r7, lr}
c0d02b36:	af02      	add	r7, sp, #8
c0d02b38:	460c      	mov	r4, r1
c0d02b3a:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02b3c:	2045      	movs	r0, #69	; 0x45
c0d02b3e:	0080      	lsls	r0, r0, #2
c0d02b40:	5828      	ldr	r0, [r5, r0]
c0d02b42:	2800      	cmp	r0, #0
c0d02b44:	d006      	beq.n	c0d02b54 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02b46:	6840      	ldr	r0, [r0, #4]
c0d02b48:	f7ff fae0 	bl	c0d0210c <pic>
c0d02b4c:	4602      	mov	r2, r0
c0d02b4e:	4628      	mov	r0, r5
c0d02b50:	4621      	mov	r1, r4
c0d02b52:	4790      	blx	r2
  }
  return USBD_OK;
c0d02b54:	2000      	movs	r0, #0
c0d02b56:	bdb0      	pop	{r4, r5, r7, pc}

c0d02b58 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02b58:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b5a:	af03      	add	r7, sp, #12
c0d02b5c:	b081      	sub	sp, #4
c0d02b5e:	4604      	mov	r4, r0
c0d02b60:	2021      	movs	r0, #33	; 0x21
c0d02b62:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02b64:	19a5      	adds	r5, r4, r6
c0d02b66:	4628      	mov	r0, r5
c0d02b68:	f000 fb69 	bl	c0d0323e <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02b6c:	20f4      	movs	r0, #244	; 0xf4
c0d02b6e:	2101      	movs	r1, #1
c0d02b70:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d02b72:	2087      	movs	r0, #135	; 0x87
c0d02b74:	0040      	lsls	r0, r0, #1
c0d02b76:	5a20      	ldrh	r0, [r4, r0]
c0d02b78:	21f8      	movs	r1, #248	; 0xf8
c0d02b7a:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02b7c:	5da1      	ldrb	r1, [r4, r6]
c0d02b7e:	201f      	movs	r0, #31
c0d02b80:	4008      	ands	r0, r1
c0d02b82:	2802      	cmp	r0, #2
c0d02b84:	d008      	beq.n	c0d02b98 <USBD_LL_SetupStage+0x40>
c0d02b86:	2801      	cmp	r0, #1
c0d02b88:	d00b      	beq.n	c0d02ba2 <USBD_LL_SetupStage+0x4a>
c0d02b8a:	2800      	cmp	r0, #0
c0d02b8c:	d10e      	bne.n	c0d02bac <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d02b8e:	4620      	mov	r0, r4
c0d02b90:	4629      	mov	r1, r5
c0d02b92:	f000 f8f1 	bl	c0d02d78 <USBD_StdDevReq>
c0d02b96:	e00e      	b.n	c0d02bb6 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02b98:	4620      	mov	r0, r4
c0d02b9a:	4629      	mov	r1, r5
c0d02b9c:	f000 fad3 	bl	c0d03146 <USBD_StdEPReq>
c0d02ba0:	e009      	b.n	c0d02bb6 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d02ba2:	4620      	mov	r0, r4
c0d02ba4:	4629      	mov	r1, r5
c0d02ba6:	f000 faa6 	bl	c0d030f6 <USBD_StdItfReq>
c0d02baa:	e004      	b.n	c0d02bb6 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d02bac:	2080      	movs	r0, #128	; 0x80
c0d02bae:	4001      	ands	r1, r0
c0d02bb0:	4620      	mov	r0, r4
c0d02bb2:	f7ff fec1 	bl	c0d02938 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d02bb6:	2000      	movs	r0, #0
c0d02bb8:	b001      	add	sp, #4
c0d02bba:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02bbc <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d02bbc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02bbe:	af03      	add	r7, sp, #12
c0d02bc0:	b081      	sub	sp, #4
c0d02bc2:	4615      	mov	r5, r2
c0d02bc4:	460e      	mov	r6, r1
c0d02bc6:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02bc8:	2e00      	cmp	r6, #0
c0d02bca:	d011      	beq.n	c0d02bf0 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02bcc:	2045      	movs	r0, #69	; 0x45
c0d02bce:	0080      	lsls	r0, r0, #2
c0d02bd0:	5820      	ldr	r0, [r4, r0]
c0d02bd2:	6980      	ldr	r0, [r0, #24]
c0d02bd4:	2800      	cmp	r0, #0
c0d02bd6:	d034      	beq.n	c0d02c42 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02bd8:	21fc      	movs	r1, #252	; 0xfc
c0d02bda:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02bdc:	2903      	cmp	r1, #3
c0d02bde:	d130      	bne.n	c0d02c42 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02be0:	f7ff fa94 	bl	c0d0210c <pic>
c0d02be4:	4603      	mov	r3, r0
c0d02be6:	4620      	mov	r0, r4
c0d02be8:	4631      	mov	r1, r6
c0d02bea:	462a      	mov	r2, r5
c0d02bec:	4798      	blx	r3
c0d02bee:	e028      	b.n	c0d02c42 <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02bf0:	20f4      	movs	r0, #244	; 0xf4
c0d02bf2:	5820      	ldr	r0, [r4, r0]
c0d02bf4:	2803      	cmp	r0, #3
c0d02bf6:	d124      	bne.n	c0d02c42 <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02bf8:	2090      	movs	r0, #144	; 0x90
c0d02bfa:	5820      	ldr	r0, [r4, r0]
c0d02bfc:	218c      	movs	r1, #140	; 0x8c
c0d02bfe:	5861      	ldr	r1, [r4, r1]
c0d02c00:	4622      	mov	r2, r4
c0d02c02:	328c      	adds	r2, #140	; 0x8c
c0d02c04:	4281      	cmp	r1, r0
c0d02c06:	d90a      	bls.n	c0d02c1e <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02c08:	1a09      	subs	r1, r1, r0
c0d02c0a:	6011      	str	r1, [r2, #0]
c0d02c0c:	4281      	cmp	r1, r0
c0d02c0e:	d300      	bcc.n	c0d02c12 <USBD_LL_DataOutStage+0x56>
c0d02c10:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d02c12:	b28a      	uxth	r2, r1
c0d02c14:	4620      	mov	r0, r4
c0d02c16:	4629      	mov	r1, r5
c0d02c18:	f000 fc70 	bl	c0d034fc <USBD_CtlContinueRx>
c0d02c1c:	e011      	b.n	c0d02c42 <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02c1e:	2045      	movs	r0, #69	; 0x45
c0d02c20:	0080      	lsls	r0, r0, #2
c0d02c22:	5820      	ldr	r0, [r4, r0]
c0d02c24:	6900      	ldr	r0, [r0, #16]
c0d02c26:	2800      	cmp	r0, #0
c0d02c28:	d008      	beq.n	c0d02c3c <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02c2a:	21fc      	movs	r1, #252	; 0xfc
c0d02c2c:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02c2e:	2903      	cmp	r1, #3
c0d02c30:	d104      	bne.n	c0d02c3c <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02c32:	f7ff fa6b 	bl	c0d0210c <pic>
c0d02c36:	4601      	mov	r1, r0
c0d02c38:	4620      	mov	r0, r4
c0d02c3a:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02c3c:	4620      	mov	r0, r4
c0d02c3e:	f000 fc65 	bl	c0d0350c <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02c42:	2000      	movs	r0, #0
c0d02c44:	b001      	add	sp, #4
c0d02c46:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c48 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02c48:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c4a:	af03      	add	r7, sp, #12
c0d02c4c:	b081      	sub	sp, #4
c0d02c4e:	460d      	mov	r5, r1
c0d02c50:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02c52:	2d00      	cmp	r5, #0
c0d02c54:	d012      	beq.n	c0d02c7c <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02c56:	2045      	movs	r0, #69	; 0x45
c0d02c58:	0080      	lsls	r0, r0, #2
c0d02c5a:	5820      	ldr	r0, [r4, r0]
c0d02c5c:	2800      	cmp	r0, #0
c0d02c5e:	d054      	beq.n	c0d02d0a <USBD_LL_DataInStage+0xc2>
c0d02c60:	6940      	ldr	r0, [r0, #20]
c0d02c62:	2800      	cmp	r0, #0
c0d02c64:	d051      	beq.n	c0d02d0a <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02c66:	21fc      	movs	r1, #252	; 0xfc
c0d02c68:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02c6a:	2903      	cmp	r1, #3
c0d02c6c:	d14d      	bne.n	c0d02d0a <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d02c6e:	f7ff fa4d 	bl	c0d0210c <pic>
c0d02c72:	4602      	mov	r2, r0
c0d02c74:	4620      	mov	r0, r4
c0d02c76:	4629      	mov	r1, r5
c0d02c78:	4790      	blx	r2
c0d02c7a:	e046      	b.n	c0d02d0a <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02c7c:	20f4      	movs	r0, #244	; 0xf4
c0d02c7e:	5820      	ldr	r0, [r4, r0]
c0d02c80:	2802      	cmp	r0, #2
c0d02c82:	d13a      	bne.n	c0d02cfa <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02c84:	69e0      	ldr	r0, [r4, #28]
c0d02c86:	6a25      	ldr	r5, [r4, #32]
c0d02c88:	42a8      	cmp	r0, r5
c0d02c8a:	d90b      	bls.n	c0d02ca4 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02c8c:	1b40      	subs	r0, r0, r5
c0d02c8e:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d02c90:	2109      	movs	r1, #9
c0d02c92:	014a      	lsls	r2, r1, #5
c0d02c94:	58a1      	ldr	r1, [r4, r2]
c0d02c96:	1949      	adds	r1, r1, r5
c0d02c98:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02c9a:	b282      	uxth	r2, r0
c0d02c9c:	4620      	mov	r0, r4
c0d02c9e:	f000 fc1e 	bl	c0d034de <USBD_CtlContinueSendData>
c0d02ca2:	e02a      	b.n	c0d02cfa <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02ca4:	69a6      	ldr	r6, [r4, #24]
c0d02ca6:	4630      	mov	r0, r6
c0d02ca8:	4629      	mov	r1, r5
c0d02caa:	f000 fccf 	bl	c0d0364c <__aeabi_uidivmod>
c0d02cae:	42ae      	cmp	r6, r5
c0d02cb0:	d30f      	bcc.n	c0d02cd2 <USBD_LL_DataInStage+0x8a>
c0d02cb2:	2900      	cmp	r1, #0
c0d02cb4:	d10d      	bne.n	c0d02cd2 <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02cb6:	20f8      	movs	r0, #248	; 0xf8
c0d02cb8:	5820      	ldr	r0, [r4, r0]
c0d02cba:	4625      	mov	r5, r4
c0d02cbc:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02cbe:	4286      	cmp	r6, r0
c0d02cc0:	d207      	bcs.n	c0d02cd2 <USBD_LL_DataInStage+0x8a>
c0d02cc2:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02cc4:	4620      	mov	r0, r4
c0d02cc6:	4631      	mov	r1, r6
c0d02cc8:	4632      	mov	r2, r6
c0d02cca:	f000 fc08 	bl	c0d034de <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02cce:	602e      	str	r6, [r5, #0]
c0d02cd0:	e013      	b.n	c0d02cfa <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02cd2:	2045      	movs	r0, #69	; 0x45
c0d02cd4:	0080      	lsls	r0, r0, #2
c0d02cd6:	5820      	ldr	r0, [r4, r0]
c0d02cd8:	2800      	cmp	r0, #0
c0d02cda:	d00b      	beq.n	c0d02cf4 <USBD_LL_DataInStage+0xac>
c0d02cdc:	68c0      	ldr	r0, [r0, #12]
c0d02cde:	2800      	cmp	r0, #0
c0d02ce0:	d008      	beq.n	c0d02cf4 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02ce2:	21fc      	movs	r1, #252	; 0xfc
c0d02ce4:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02ce6:	2903      	cmp	r1, #3
c0d02ce8:	d104      	bne.n	c0d02cf4 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02cea:	f7ff fa0f 	bl	c0d0210c <pic>
c0d02cee:	4601      	mov	r1, r0
c0d02cf0:	4620      	mov	r0, r4
c0d02cf2:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02cf4:	4620      	mov	r0, r4
c0d02cf6:	f000 fc16 	bl	c0d03526 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02cfa:	2001      	movs	r0, #1
c0d02cfc:	0201      	lsls	r1, r0, #8
c0d02cfe:	1860      	adds	r0, r4, r1
c0d02d00:	5c61      	ldrb	r1, [r4, r1]
c0d02d02:	2901      	cmp	r1, #1
c0d02d04:	d101      	bne.n	c0d02d0a <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02d06:	2100      	movs	r1, #0
c0d02d08:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02d0a:	2000      	movs	r0, #0
c0d02d0c:	b001      	add	sp, #4
c0d02d0e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02d10 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02d10:	b5d0      	push	{r4, r6, r7, lr}
c0d02d12:	af02      	add	r7, sp, #8
c0d02d14:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02d16:	2090      	movs	r0, #144	; 0x90
c0d02d18:	2140      	movs	r1, #64	; 0x40
c0d02d1a:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02d1c:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02d1e:	20fc      	movs	r0, #252	; 0xfc
c0d02d20:	2101      	movs	r1, #1
c0d02d22:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02d24:	2045      	movs	r0, #69	; 0x45
c0d02d26:	0080      	lsls	r0, r0, #2
c0d02d28:	5820      	ldr	r0, [r4, r0]
c0d02d2a:	2800      	cmp	r0, #0
c0d02d2c:	d006      	beq.n	c0d02d3c <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02d2e:	6840      	ldr	r0, [r0, #4]
c0d02d30:	f7ff f9ec 	bl	c0d0210c <pic>
c0d02d34:	4602      	mov	r2, r0
c0d02d36:	7921      	ldrb	r1, [r4, #4]
c0d02d38:	4620      	mov	r0, r4
c0d02d3a:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02d3c:	2000      	movs	r0, #0
c0d02d3e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02d40 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02d40:	7401      	strb	r1, [r0, #16]
c0d02d42:	2000      	movs	r0, #0
  return USBD_OK;
c0d02d44:	4770      	bx	lr

c0d02d46 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02d46:	2000      	movs	r0, #0
c0d02d48:	4770      	bx	lr

c0d02d4a <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02d4a:	2000      	movs	r0, #0
c0d02d4c:	4770      	bx	lr

c0d02d4e <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02d4e:	b5d0      	push	{r4, r6, r7, lr}
c0d02d50:	af02      	add	r7, sp, #8
c0d02d52:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02d54:	20fc      	movs	r0, #252	; 0xfc
c0d02d56:	5c20      	ldrb	r0, [r4, r0]
c0d02d58:	2803      	cmp	r0, #3
c0d02d5a:	d10a      	bne.n	c0d02d72 <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02d5c:	2045      	movs	r0, #69	; 0x45
c0d02d5e:	0080      	lsls	r0, r0, #2
c0d02d60:	5820      	ldr	r0, [r4, r0]
c0d02d62:	69c0      	ldr	r0, [r0, #28]
c0d02d64:	2800      	cmp	r0, #0
c0d02d66:	d004      	beq.n	c0d02d72 <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02d68:	f7ff f9d0 	bl	c0d0210c <pic>
c0d02d6c:	4601      	mov	r1, r0
c0d02d6e:	4620      	mov	r0, r4
c0d02d70:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d02d72:	2000      	movs	r0, #0
c0d02d74:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02d78 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02d78:	b5d0      	push	{r4, r6, r7, lr}
c0d02d7a:	af02      	add	r7, sp, #8
c0d02d7c:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02d7e:	7848      	ldrb	r0, [r1, #1]
c0d02d80:	2809      	cmp	r0, #9
c0d02d82:	d810      	bhi.n	c0d02da6 <USBD_StdDevReq+0x2e>
c0d02d84:	4478      	add	r0, pc
c0d02d86:	7900      	ldrb	r0, [r0, #4]
c0d02d88:	0040      	lsls	r0, r0, #1
c0d02d8a:	4487      	add	pc, r0
c0d02d8c:	150c0804 	.word	0x150c0804
c0d02d90:	0c25190c 	.word	0x0c25190c
c0d02d94:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02d96:	4620      	mov	r0, r4
c0d02d98:	f000 f938 	bl	c0d0300c <USBD_GetStatus>
c0d02d9c:	e01f      	b.n	c0d02dde <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02d9e:	4620      	mov	r0, r4
c0d02da0:	f000 f976 	bl	c0d03090 <USBD_ClrFeature>
c0d02da4:	e01b      	b.n	c0d02dde <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02da6:	2180      	movs	r1, #128	; 0x80
c0d02da8:	4620      	mov	r0, r4
c0d02daa:	f7ff fdc5 	bl	c0d02938 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02dae:	2100      	movs	r1, #0
c0d02db0:	4620      	mov	r0, r4
c0d02db2:	f7ff fdc1 	bl	c0d02938 <USBD_LL_StallEP>
c0d02db6:	e012      	b.n	c0d02dde <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02db8:	4620      	mov	r0, r4
c0d02dba:	f000 f950 	bl	c0d0305e <USBD_SetFeature>
c0d02dbe:	e00e      	b.n	c0d02dde <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02dc0:	4620      	mov	r0, r4
c0d02dc2:	f000 f897 	bl	c0d02ef4 <USBD_SetAddress>
c0d02dc6:	e00a      	b.n	c0d02dde <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02dc8:	4620      	mov	r0, r4
c0d02dca:	f000 f8ff 	bl	c0d02fcc <USBD_GetConfig>
c0d02dce:	e006      	b.n	c0d02dde <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02dd0:	4620      	mov	r0, r4
c0d02dd2:	f000 f8bd 	bl	c0d02f50 <USBD_SetConfig>
c0d02dd6:	e002      	b.n	c0d02dde <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02dd8:	4620      	mov	r0, r4
c0d02dda:	f000 f803 	bl	c0d02de4 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02dde:	2000      	movs	r0, #0
c0d02de0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02de4 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02de4:	b5b0      	push	{r4, r5, r7, lr}
c0d02de6:	af02      	add	r7, sp, #8
c0d02de8:	b082      	sub	sp, #8
c0d02dea:	460d      	mov	r5, r1
c0d02dec:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02dee:	8868      	ldrh	r0, [r5, #2]
c0d02df0:	0a01      	lsrs	r1, r0, #8
c0d02df2:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02df4:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02df6:	2a0e      	cmp	r2, #14
c0d02df8:	d83e      	bhi.n	c0d02e78 <USBD_GetDescriptor+0x94>
c0d02dfa:	46c0      	nop			; (mov r8, r8)
c0d02dfc:	447a      	add	r2, pc
c0d02dfe:	7912      	ldrb	r2, [r2, #4]
c0d02e00:	0052      	lsls	r2, r2, #1
c0d02e02:	4497      	add	pc, r2
c0d02e04:	390c2607 	.word	0x390c2607
c0d02e08:	39362e39 	.word	0x39362e39
c0d02e0c:	39393939 	.word	0x39393939
c0d02e10:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02e14:	2011      	movs	r0, #17
c0d02e16:	0100      	lsls	r0, r0, #4
c0d02e18:	5820      	ldr	r0, [r4, r0]
c0d02e1a:	6800      	ldr	r0, [r0, #0]
c0d02e1c:	e012      	b.n	c0d02e44 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02e1e:	b2c0      	uxtb	r0, r0
c0d02e20:	2805      	cmp	r0, #5
c0d02e22:	d829      	bhi.n	c0d02e78 <USBD_GetDescriptor+0x94>
c0d02e24:	4478      	add	r0, pc
c0d02e26:	7900      	ldrb	r0, [r0, #4]
c0d02e28:	0040      	lsls	r0, r0, #1
c0d02e2a:	4487      	add	pc, r0
c0d02e2c:	544f4a02 	.word	0x544f4a02
c0d02e30:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02e32:	2011      	movs	r0, #17
c0d02e34:	0100      	lsls	r0, r0, #4
c0d02e36:	5820      	ldr	r0, [r4, r0]
c0d02e38:	6840      	ldr	r0, [r0, #4]
c0d02e3a:	e003      	b.n	c0d02e44 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02e3c:	2011      	movs	r0, #17
c0d02e3e:	0100      	lsls	r0, r0, #4
c0d02e40:	5820      	ldr	r0, [r4, r0]
c0d02e42:	69c0      	ldr	r0, [r0, #28]
c0d02e44:	f7ff f962 	bl	c0d0210c <pic>
c0d02e48:	4602      	mov	r2, r0
c0d02e4a:	7c20      	ldrb	r0, [r4, #16]
c0d02e4c:	a901      	add	r1, sp, #4
c0d02e4e:	4790      	blx	r2
c0d02e50:	e025      	b.n	c0d02e9e <USBD_GetDescriptor+0xba>
c0d02e52:	2045      	movs	r0, #69	; 0x45
c0d02e54:	0080      	lsls	r0, r0, #2
c0d02e56:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02e58:	7c21      	ldrb	r1, [r4, #16]
c0d02e5a:	2900      	cmp	r1, #0
c0d02e5c:	d014      	beq.n	c0d02e88 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02e5e:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02e60:	e018      	b.n	c0d02e94 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02e62:	7c20      	ldrb	r0, [r4, #16]
c0d02e64:	2800      	cmp	r0, #0
c0d02e66:	d107      	bne.n	c0d02e78 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02e68:	2045      	movs	r0, #69	; 0x45
c0d02e6a:	0080      	lsls	r0, r0, #2
c0d02e6c:	5820      	ldr	r0, [r4, r0]
c0d02e6e:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02e70:	e010      	b.n	c0d02e94 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02e72:	7c20      	ldrb	r0, [r4, #16]
c0d02e74:	2800      	cmp	r0, #0
c0d02e76:	d009      	beq.n	c0d02e8c <USBD_GetDescriptor+0xa8>
c0d02e78:	4620      	mov	r0, r4
c0d02e7a:	f7ff fd5d 	bl	c0d02938 <USBD_LL_StallEP>
c0d02e7e:	2100      	movs	r1, #0
c0d02e80:	4620      	mov	r0, r4
c0d02e82:	f7ff fd59 	bl	c0d02938 <USBD_LL_StallEP>
c0d02e86:	e01a      	b.n	c0d02ebe <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02e88:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02e8a:	e003      	b.n	c0d02e94 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02e8c:	2045      	movs	r0, #69	; 0x45
c0d02e8e:	0080      	lsls	r0, r0, #2
c0d02e90:	5820      	ldr	r0, [r4, r0]
c0d02e92:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02e94:	f7ff f93a 	bl	c0d0210c <pic>
c0d02e98:	4601      	mov	r1, r0
c0d02e9a:	a801      	add	r0, sp, #4
c0d02e9c:	4788      	blx	r1
c0d02e9e:	4601      	mov	r1, r0
c0d02ea0:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02ea2:	8802      	ldrh	r2, [r0, #0]
c0d02ea4:	2a00      	cmp	r2, #0
c0d02ea6:	d00a      	beq.n	c0d02ebe <USBD_GetDescriptor+0xda>
c0d02ea8:	88e8      	ldrh	r0, [r5, #6]
c0d02eaa:	2800      	cmp	r0, #0
c0d02eac:	d007      	beq.n	c0d02ebe <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02eae:	4282      	cmp	r2, r0
c0d02eb0:	d300      	bcc.n	c0d02eb4 <USBD_GetDescriptor+0xd0>
c0d02eb2:	4602      	mov	r2, r0
c0d02eb4:	a801      	add	r0, sp, #4
c0d02eb6:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02eb8:	4620      	mov	r0, r4
c0d02eba:	f000 faf9 	bl	c0d034b0 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02ebe:	b002      	add	sp, #8
c0d02ec0:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02ec2:	2011      	movs	r0, #17
c0d02ec4:	0100      	lsls	r0, r0, #4
c0d02ec6:	5820      	ldr	r0, [r4, r0]
c0d02ec8:	6880      	ldr	r0, [r0, #8]
c0d02eca:	e7bb      	b.n	c0d02e44 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02ecc:	2011      	movs	r0, #17
c0d02ece:	0100      	lsls	r0, r0, #4
c0d02ed0:	5820      	ldr	r0, [r4, r0]
c0d02ed2:	68c0      	ldr	r0, [r0, #12]
c0d02ed4:	e7b6      	b.n	c0d02e44 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02ed6:	2011      	movs	r0, #17
c0d02ed8:	0100      	lsls	r0, r0, #4
c0d02eda:	5820      	ldr	r0, [r4, r0]
c0d02edc:	6900      	ldr	r0, [r0, #16]
c0d02ede:	e7b1      	b.n	c0d02e44 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02ee0:	2011      	movs	r0, #17
c0d02ee2:	0100      	lsls	r0, r0, #4
c0d02ee4:	5820      	ldr	r0, [r4, r0]
c0d02ee6:	6940      	ldr	r0, [r0, #20]
c0d02ee8:	e7ac      	b.n	c0d02e44 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02eea:	2011      	movs	r0, #17
c0d02eec:	0100      	lsls	r0, r0, #4
c0d02eee:	5820      	ldr	r0, [r4, r0]
c0d02ef0:	6980      	ldr	r0, [r0, #24]
c0d02ef2:	e7a7      	b.n	c0d02e44 <USBD_GetDescriptor+0x60>

c0d02ef4 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02ef4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02ef6:	af03      	add	r7, sp, #12
c0d02ef8:	b081      	sub	sp, #4
c0d02efa:	460a      	mov	r2, r1
c0d02efc:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02efe:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f00:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02f02:	2800      	cmp	r0, #0
c0d02f04:	d10b      	bne.n	c0d02f1e <USBD_SetAddress+0x2a>
c0d02f06:	88d0      	ldrh	r0, [r2, #6]
c0d02f08:	2800      	cmp	r0, #0
c0d02f0a:	d108      	bne.n	c0d02f1e <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02f0c:	8850      	ldrh	r0, [r2, #2]
c0d02f0e:	267f      	movs	r6, #127	; 0x7f
c0d02f10:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02f12:	20fc      	movs	r0, #252	; 0xfc
c0d02f14:	5c20      	ldrb	r0, [r4, r0]
c0d02f16:	4625      	mov	r5, r4
c0d02f18:	35fc      	adds	r5, #252	; 0xfc
c0d02f1a:	2803      	cmp	r0, #3
c0d02f1c:	d108      	bne.n	c0d02f30 <USBD_SetAddress+0x3c>
c0d02f1e:	4620      	mov	r0, r4
c0d02f20:	f7ff fd0a 	bl	c0d02938 <USBD_LL_StallEP>
c0d02f24:	2100      	movs	r1, #0
c0d02f26:	4620      	mov	r0, r4
c0d02f28:	f7ff fd06 	bl	c0d02938 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02f2c:	b001      	add	sp, #4
c0d02f2e:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02f30:	20fe      	movs	r0, #254	; 0xfe
c0d02f32:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02f34:	b2f1      	uxtb	r1, r6
c0d02f36:	4620      	mov	r0, r4
c0d02f38:	f7ff fd5c 	bl	c0d029f4 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02f3c:	4620      	mov	r0, r4
c0d02f3e:	f000 fae5 	bl	c0d0350c <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02f42:	2002      	movs	r0, #2
c0d02f44:	2101      	movs	r1, #1
c0d02f46:	2e00      	cmp	r6, #0
c0d02f48:	d100      	bne.n	c0d02f4c <USBD_SetAddress+0x58>
c0d02f4a:	4608      	mov	r0, r1
c0d02f4c:	7028      	strb	r0, [r5, #0]
c0d02f4e:	e7ed      	b.n	c0d02f2c <USBD_SetAddress+0x38>

c0d02f50 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02f50:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02f52:	af03      	add	r7, sp, #12
c0d02f54:	b081      	sub	sp, #4
c0d02f56:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02f58:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f5a:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02f5c:	2e02      	cmp	r6, #2
c0d02f5e:	d21d      	bcs.n	c0d02f9c <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02f60:	20fc      	movs	r0, #252	; 0xfc
c0d02f62:	5c21      	ldrb	r1, [r4, r0]
c0d02f64:	4620      	mov	r0, r4
c0d02f66:	30fc      	adds	r0, #252	; 0xfc
c0d02f68:	2903      	cmp	r1, #3
c0d02f6a:	d007      	beq.n	c0d02f7c <USBD_SetConfig+0x2c>
c0d02f6c:	2902      	cmp	r1, #2
c0d02f6e:	d115      	bne.n	c0d02f9c <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02f70:	2e00      	cmp	r6, #0
c0d02f72:	d026      	beq.n	c0d02fc2 <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02f74:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02f76:	2103      	movs	r1, #3
c0d02f78:	7001      	strb	r1, [r0, #0]
c0d02f7a:	e009      	b.n	c0d02f90 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02f7c:	2e00      	cmp	r6, #0
c0d02f7e:	d016      	beq.n	c0d02fae <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02f80:	6860      	ldr	r0, [r4, #4]
c0d02f82:	4286      	cmp	r6, r0
c0d02f84:	d01d      	beq.n	c0d02fc2 <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02f86:	b2c1      	uxtb	r1, r0
c0d02f88:	4620      	mov	r0, r4
c0d02f8a:	f7ff fdd3 	bl	c0d02b34 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02f8e:	6066      	str	r6, [r4, #4]
c0d02f90:	4620      	mov	r0, r4
c0d02f92:	4631      	mov	r1, r6
c0d02f94:	f7ff fdb6 	bl	c0d02b04 <USBD_SetClassConfig>
c0d02f98:	2802      	cmp	r0, #2
c0d02f9a:	d112      	bne.n	c0d02fc2 <USBD_SetConfig+0x72>
c0d02f9c:	4620      	mov	r0, r4
c0d02f9e:	4629      	mov	r1, r5
c0d02fa0:	f7ff fcca 	bl	c0d02938 <USBD_LL_StallEP>
c0d02fa4:	2100      	movs	r1, #0
c0d02fa6:	4620      	mov	r0, r4
c0d02fa8:	f7ff fcc6 	bl	c0d02938 <USBD_LL_StallEP>
c0d02fac:	e00c      	b.n	c0d02fc8 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02fae:	2102      	movs	r1, #2
c0d02fb0:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02fb2:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02fb4:	4620      	mov	r0, r4
c0d02fb6:	4631      	mov	r1, r6
c0d02fb8:	f7ff fdbc 	bl	c0d02b34 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02fbc:	4620      	mov	r0, r4
c0d02fbe:	f000 faa5 	bl	c0d0350c <USBD_CtlSendStatus>
c0d02fc2:	4620      	mov	r0, r4
c0d02fc4:	f000 faa2 	bl	c0d0350c <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02fc8:	b001      	add	sp, #4
c0d02fca:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02fcc <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02fcc:	b5d0      	push	{r4, r6, r7, lr}
c0d02fce:	af02      	add	r7, sp, #8
c0d02fd0:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02fd2:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02fd4:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02fd6:	2801      	cmp	r0, #1
c0d02fd8:	d10a      	bne.n	c0d02ff0 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02fda:	20fc      	movs	r0, #252	; 0xfc
c0d02fdc:	5c20      	ldrb	r0, [r4, r0]
c0d02fde:	2803      	cmp	r0, #3
c0d02fe0:	d00e      	beq.n	c0d03000 <USBD_GetConfig+0x34>
c0d02fe2:	2802      	cmp	r0, #2
c0d02fe4:	d104      	bne.n	c0d02ff0 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02fe6:	2000      	movs	r0, #0
c0d02fe8:	60a0      	str	r0, [r4, #8]
c0d02fea:	4621      	mov	r1, r4
c0d02fec:	3108      	adds	r1, #8
c0d02fee:	e008      	b.n	c0d03002 <USBD_GetConfig+0x36>
c0d02ff0:	4620      	mov	r0, r4
c0d02ff2:	f7ff fca1 	bl	c0d02938 <USBD_LL_StallEP>
c0d02ff6:	2100      	movs	r1, #0
c0d02ff8:	4620      	mov	r0, r4
c0d02ffa:	f7ff fc9d 	bl	c0d02938 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02ffe:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d03000:	1d21      	adds	r1, r4, #4
c0d03002:	2201      	movs	r2, #1
c0d03004:	4620      	mov	r0, r4
c0d03006:	f000 fa53 	bl	c0d034b0 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d0300a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0300c <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d0300c:	b5b0      	push	{r4, r5, r7, lr}
c0d0300e:	af02      	add	r7, sp, #8
c0d03010:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d03012:	20fc      	movs	r0, #252	; 0xfc
c0d03014:	5c20      	ldrb	r0, [r4, r0]
c0d03016:	21fe      	movs	r1, #254	; 0xfe
c0d03018:	4001      	ands	r1, r0
c0d0301a:	2902      	cmp	r1, #2
c0d0301c:	d116      	bne.n	c0d0304c <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d0301e:	2001      	movs	r0, #1
c0d03020:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d03022:	2041      	movs	r0, #65	; 0x41
c0d03024:	0080      	lsls	r0, r0, #2
c0d03026:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d03028:	4625      	mov	r5, r4
c0d0302a:	350c      	adds	r5, #12
c0d0302c:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0302e:	2900      	cmp	r1, #0
c0d03030:	d005      	beq.n	c0d0303e <USBD_GetStatus+0x32>
c0d03032:	4620      	mov	r0, r4
c0d03034:	f000 fa77 	bl	c0d03526 <USBD_CtlReceiveStatus>
c0d03038:	68e1      	ldr	r1, [r4, #12]
c0d0303a:	2002      	movs	r0, #2
c0d0303c:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d0303e:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d03040:	2202      	movs	r2, #2
c0d03042:	4620      	mov	r0, r4
c0d03044:	4629      	mov	r1, r5
c0d03046:	f000 fa33 	bl	c0d034b0 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d0304a:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0304c:	2180      	movs	r1, #128	; 0x80
c0d0304e:	4620      	mov	r0, r4
c0d03050:	f7ff fc72 	bl	c0d02938 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d03054:	2100      	movs	r1, #0
c0d03056:	4620      	mov	r0, r4
c0d03058:	f7ff fc6e 	bl	c0d02938 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d0305c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0305e <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0305e:	b5b0      	push	{r4, r5, r7, lr}
c0d03060:	af02      	add	r7, sp, #8
c0d03062:	460d      	mov	r5, r1
c0d03064:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d03066:	8868      	ldrh	r0, [r5, #2]
c0d03068:	2801      	cmp	r0, #1
c0d0306a:	d110      	bne.n	c0d0308e <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d0306c:	2041      	movs	r0, #65	; 0x41
c0d0306e:	0080      	lsls	r0, r0, #2
c0d03070:	2101      	movs	r1, #1
c0d03072:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d03074:	2045      	movs	r0, #69	; 0x45
c0d03076:	0080      	lsls	r0, r0, #2
c0d03078:	5820      	ldr	r0, [r4, r0]
c0d0307a:	6880      	ldr	r0, [r0, #8]
c0d0307c:	f7ff f846 	bl	c0d0210c <pic>
c0d03080:	4602      	mov	r2, r0
c0d03082:	4620      	mov	r0, r4
c0d03084:	4629      	mov	r1, r5
c0d03086:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d03088:	4620      	mov	r0, r4
c0d0308a:	f000 fa3f 	bl	c0d0350c <USBD_CtlSendStatus>
  }

}
c0d0308e:	bdb0      	pop	{r4, r5, r7, pc}

c0d03090 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d03090:	b5b0      	push	{r4, r5, r7, lr}
c0d03092:	af02      	add	r7, sp, #8
c0d03094:	460d      	mov	r5, r1
c0d03096:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d03098:	20fc      	movs	r0, #252	; 0xfc
c0d0309a:	5c20      	ldrb	r0, [r4, r0]
c0d0309c:	21fe      	movs	r1, #254	; 0xfe
c0d0309e:	4001      	ands	r1, r0
c0d030a0:	2902      	cmp	r1, #2
c0d030a2:	d114      	bne.n	c0d030ce <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d030a4:	8868      	ldrh	r0, [r5, #2]
c0d030a6:	2801      	cmp	r0, #1
c0d030a8:	d119      	bne.n	c0d030de <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d030aa:	2041      	movs	r0, #65	; 0x41
c0d030ac:	0080      	lsls	r0, r0, #2
c0d030ae:	2100      	movs	r1, #0
c0d030b0:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d030b2:	2045      	movs	r0, #69	; 0x45
c0d030b4:	0080      	lsls	r0, r0, #2
c0d030b6:	5820      	ldr	r0, [r4, r0]
c0d030b8:	6880      	ldr	r0, [r0, #8]
c0d030ba:	f7ff f827 	bl	c0d0210c <pic>
c0d030be:	4602      	mov	r2, r0
c0d030c0:	4620      	mov	r0, r4
c0d030c2:	4629      	mov	r1, r5
c0d030c4:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d030c6:	4620      	mov	r0, r4
c0d030c8:	f000 fa20 	bl	c0d0350c <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d030cc:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d030ce:	2180      	movs	r1, #128	; 0x80
c0d030d0:	4620      	mov	r0, r4
c0d030d2:	f7ff fc31 	bl	c0d02938 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d030d6:	2100      	movs	r1, #0
c0d030d8:	4620      	mov	r0, r4
c0d030da:	f7ff fc2d 	bl	c0d02938 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d030de:	bdb0      	pop	{r4, r5, r7, pc}

c0d030e0 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d030e0:	b5d0      	push	{r4, r6, r7, lr}
c0d030e2:	af02      	add	r7, sp, #8
c0d030e4:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d030e6:	2180      	movs	r1, #128	; 0x80
c0d030e8:	f7ff fc26 	bl	c0d02938 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d030ec:	2100      	movs	r1, #0
c0d030ee:	4620      	mov	r0, r4
c0d030f0:	f7ff fc22 	bl	c0d02938 <USBD_LL_StallEP>
}
c0d030f4:	bdd0      	pop	{r4, r6, r7, pc}

c0d030f6 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d030f6:	b5b0      	push	{r4, r5, r7, lr}
c0d030f8:	af02      	add	r7, sp, #8
c0d030fa:	460d      	mov	r5, r1
c0d030fc:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d030fe:	20fc      	movs	r0, #252	; 0xfc
c0d03100:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d03102:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d03104:	2803      	cmp	r0, #3
c0d03106:	d115      	bne.n	c0d03134 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d03108:	88a8      	ldrh	r0, [r5, #4]
c0d0310a:	22fe      	movs	r2, #254	; 0xfe
c0d0310c:	4002      	ands	r2, r0
c0d0310e:	2a01      	cmp	r2, #1
c0d03110:	d810      	bhi.n	c0d03134 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d03112:	2045      	movs	r0, #69	; 0x45
c0d03114:	0080      	lsls	r0, r0, #2
c0d03116:	5820      	ldr	r0, [r4, r0]
c0d03118:	6880      	ldr	r0, [r0, #8]
c0d0311a:	f7fe fff7 	bl	c0d0210c <pic>
c0d0311e:	4602      	mov	r2, r0
c0d03120:	4620      	mov	r0, r4
c0d03122:	4629      	mov	r1, r5
c0d03124:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d03126:	88e8      	ldrh	r0, [r5, #6]
c0d03128:	2800      	cmp	r0, #0
c0d0312a:	d10a      	bne.n	c0d03142 <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d0312c:	4620      	mov	r0, r4
c0d0312e:	f000 f9ed 	bl	c0d0350c <USBD_CtlSendStatus>
c0d03132:	e006      	b.n	c0d03142 <USBD_StdItfReq+0x4c>
c0d03134:	4620      	mov	r0, r4
c0d03136:	f7ff fbff 	bl	c0d02938 <USBD_LL_StallEP>
c0d0313a:	2100      	movs	r1, #0
c0d0313c:	4620      	mov	r0, r4
c0d0313e:	f7ff fbfb 	bl	c0d02938 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d03142:	2000      	movs	r0, #0
c0d03144:	bdb0      	pop	{r4, r5, r7, pc}

c0d03146 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d03146:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03148:	af03      	add	r7, sp, #12
c0d0314a:	b081      	sub	sp, #4
c0d0314c:	460e      	mov	r6, r1
c0d0314e:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d03150:	7830      	ldrb	r0, [r6, #0]
c0d03152:	2160      	movs	r1, #96	; 0x60
c0d03154:	4001      	ands	r1, r0
c0d03156:	2920      	cmp	r1, #32
c0d03158:	d10a      	bne.n	c0d03170 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d0315a:	2045      	movs	r0, #69	; 0x45
c0d0315c:	0080      	lsls	r0, r0, #2
c0d0315e:	5820      	ldr	r0, [r4, r0]
c0d03160:	6880      	ldr	r0, [r0, #8]
c0d03162:	f7fe ffd3 	bl	c0d0210c <pic>
c0d03166:	4602      	mov	r2, r0
c0d03168:	4620      	mov	r0, r4
c0d0316a:	4631      	mov	r1, r6
c0d0316c:	4790      	blx	r2
c0d0316e:	e063      	b.n	c0d03238 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d03170:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d03172:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d03174:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d03176:	2800      	cmp	r0, #0
c0d03178:	d012      	beq.n	c0d031a0 <USBD_StdEPReq+0x5a>
c0d0317a:	2801      	cmp	r0, #1
c0d0317c:	d019      	beq.n	c0d031b2 <USBD_StdEPReq+0x6c>
c0d0317e:	2803      	cmp	r0, #3
c0d03180:	d15a      	bne.n	c0d03238 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d03182:	20fc      	movs	r0, #252	; 0xfc
c0d03184:	5c20      	ldrb	r0, [r4, r0]
c0d03186:	2803      	cmp	r0, #3
c0d03188:	d117      	bne.n	c0d031ba <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d0318a:	8870      	ldrh	r0, [r6, #2]
c0d0318c:	2800      	cmp	r0, #0
c0d0318e:	d12d      	bne.n	c0d031ec <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d03190:	4329      	orrs	r1, r5
c0d03192:	2980      	cmp	r1, #128	; 0x80
c0d03194:	d02a      	beq.n	c0d031ec <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d03196:	4620      	mov	r0, r4
c0d03198:	4629      	mov	r1, r5
c0d0319a:	f7ff fbcd 	bl	c0d02938 <USBD_LL_StallEP>
c0d0319e:	e025      	b.n	c0d031ec <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d031a0:	20fc      	movs	r0, #252	; 0xfc
c0d031a2:	5c20      	ldrb	r0, [r4, r0]
c0d031a4:	2803      	cmp	r0, #3
c0d031a6:	d02f      	beq.n	c0d03208 <USBD_StdEPReq+0xc2>
c0d031a8:	2802      	cmp	r0, #2
c0d031aa:	d10e      	bne.n	c0d031ca <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d031ac:	0668      	lsls	r0, r5, #25
c0d031ae:	d109      	bne.n	c0d031c4 <USBD_StdEPReq+0x7e>
c0d031b0:	e042      	b.n	c0d03238 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d031b2:	20fc      	movs	r0, #252	; 0xfc
c0d031b4:	5c20      	ldrb	r0, [r4, r0]
c0d031b6:	2803      	cmp	r0, #3
c0d031b8:	d00f      	beq.n	c0d031da <USBD_StdEPReq+0x94>
c0d031ba:	2802      	cmp	r0, #2
c0d031bc:	d105      	bne.n	c0d031ca <USBD_StdEPReq+0x84>
c0d031be:	4329      	orrs	r1, r5
c0d031c0:	2980      	cmp	r1, #128	; 0x80
c0d031c2:	d039      	beq.n	c0d03238 <USBD_StdEPReq+0xf2>
c0d031c4:	4620      	mov	r0, r4
c0d031c6:	4629      	mov	r1, r5
c0d031c8:	e004      	b.n	c0d031d4 <USBD_StdEPReq+0x8e>
c0d031ca:	4620      	mov	r0, r4
c0d031cc:	f7ff fbb4 	bl	c0d02938 <USBD_LL_StallEP>
c0d031d0:	2100      	movs	r1, #0
c0d031d2:	4620      	mov	r0, r4
c0d031d4:	f7ff fbb0 	bl	c0d02938 <USBD_LL_StallEP>
c0d031d8:	e02e      	b.n	c0d03238 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d031da:	8870      	ldrh	r0, [r6, #2]
c0d031dc:	2800      	cmp	r0, #0
c0d031de:	d12b      	bne.n	c0d03238 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d031e0:	0668      	lsls	r0, r5, #25
c0d031e2:	d00d      	beq.n	c0d03200 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d031e4:	4620      	mov	r0, r4
c0d031e6:	4629      	mov	r1, r5
c0d031e8:	f7ff fbcc 	bl	c0d02984 <USBD_LL_ClearStallEP>
c0d031ec:	2045      	movs	r0, #69	; 0x45
c0d031ee:	0080      	lsls	r0, r0, #2
c0d031f0:	5820      	ldr	r0, [r4, r0]
c0d031f2:	6880      	ldr	r0, [r0, #8]
c0d031f4:	f7fe ff8a 	bl	c0d0210c <pic>
c0d031f8:	4602      	mov	r2, r0
c0d031fa:	4620      	mov	r0, r4
c0d031fc:	4631      	mov	r1, r6
c0d031fe:	4790      	blx	r2
c0d03200:	4620      	mov	r0, r4
c0d03202:	f000 f983 	bl	c0d0350c <USBD_CtlSendStatus>
c0d03206:	e017      	b.n	c0d03238 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d03208:	4626      	mov	r6, r4
c0d0320a:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d0320c:	4620      	mov	r0, r4
c0d0320e:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d03210:	420d      	tst	r5, r1
c0d03212:	d100      	bne.n	c0d03216 <USBD_StdEPReq+0xd0>
c0d03214:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d03216:	4620      	mov	r0, r4
c0d03218:	4629      	mov	r1, r5
c0d0321a:	f7ff fbd9 	bl	c0d029d0 <USBD_LL_IsStallEP>
c0d0321e:	2101      	movs	r1, #1
c0d03220:	2800      	cmp	r0, #0
c0d03222:	d100      	bne.n	c0d03226 <USBD_StdEPReq+0xe0>
c0d03224:	4601      	mov	r1, r0
c0d03226:	207f      	movs	r0, #127	; 0x7f
c0d03228:	4005      	ands	r5, r0
c0d0322a:	0128      	lsls	r0, r5, #4
c0d0322c:	5031      	str	r1, [r6, r0]
c0d0322e:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d03230:	2202      	movs	r2, #2
c0d03232:	4620      	mov	r0, r4
c0d03234:	f000 f93c 	bl	c0d034b0 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d03238:	2000      	movs	r0, #0
c0d0323a:	b001      	add	sp, #4
c0d0323c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0323e <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d0323e:	780a      	ldrb	r2, [r1, #0]
c0d03240:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d03242:	784a      	ldrb	r2, [r1, #1]
c0d03244:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d03246:	788a      	ldrb	r2, [r1, #2]
c0d03248:	78cb      	ldrb	r3, [r1, #3]
c0d0324a:	021b      	lsls	r3, r3, #8
c0d0324c:	4313      	orrs	r3, r2
c0d0324e:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d03250:	790a      	ldrb	r2, [r1, #4]
c0d03252:	794b      	ldrb	r3, [r1, #5]
c0d03254:	021b      	lsls	r3, r3, #8
c0d03256:	4313      	orrs	r3, r2
c0d03258:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d0325a:	798a      	ldrb	r2, [r1, #6]
c0d0325c:	79c9      	ldrb	r1, [r1, #7]
c0d0325e:	0209      	lsls	r1, r1, #8
c0d03260:	4311      	orrs	r1, r2
c0d03262:	80c1      	strh	r1, [r0, #6]

}
c0d03264:	4770      	bx	lr

c0d03266 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d03266:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03268:	af03      	add	r7, sp, #12
c0d0326a:	b083      	sub	sp, #12
c0d0326c:	460d      	mov	r5, r1
c0d0326e:	4604      	mov	r4, r0
c0d03270:	a802      	add	r0, sp, #8
c0d03272:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d03274:	8006      	strh	r6, [r0, #0]
c0d03276:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d03278:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d0327a:	7829      	ldrb	r1, [r5, #0]
c0d0327c:	2060      	movs	r0, #96	; 0x60
c0d0327e:	4008      	ands	r0, r1
c0d03280:	2800      	cmp	r0, #0
c0d03282:	d010      	beq.n	c0d032a6 <USBD_HID_Setup+0x40>
c0d03284:	2820      	cmp	r0, #32
c0d03286:	d139      	bne.n	c0d032fc <USBD_HID_Setup+0x96>
c0d03288:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d0328a:	4601      	mov	r1, r0
c0d0328c:	390a      	subs	r1, #10
c0d0328e:	2902      	cmp	r1, #2
c0d03290:	d334      	bcc.n	c0d032fc <USBD_HID_Setup+0x96>
c0d03292:	2802      	cmp	r0, #2
c0d03294:	d01c      	beq.n	c0d032d0 <USBD_HID_Setup+0x6a>
c0d03296:	2803      	cmp	r0, #3
c0d03298:	d01a      	beq.n	c0d032d0 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d0329a:	4620      	mov	r0, r4
c0d0329c:	4629      	mov	r1, r5
c0d0329e:	f7ff ff1f 	bl	c0d030e0 <USBD_CtlError>
c0d032a2:	2602      	movs	r6, #2
c0d032a4:	e02a      	b.n	c0d032fc <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d032a6:	7868      	ldrb	r0, [r5, #1]
c0d032a8:	280b      	cmp	r0, #11
c0d032aa:	d014      	beq.n	c0d032d6 <USBD_HID_Setup+0x70>
c0d032ac:	280a      	cmp	r0, #10
c0d032ae:	d00f      	beq.n	c0d032d0 <USBD_HID_Setup+0x6a>
c0d032b0:	2806      	cmp	r0, #6
c0d032b2:	d123      	bne.n	c0d032fc <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d032b4:	8868      	ldrh	r0, [r5, #2]
c0d032b6:	0a00      	lsrs	r0, r0, #8
c0d032b8:	2600      	movs	r6, #0
c0d032ba:	2821      	cmp	r0, #33	; 0x21
c0d032bc:	d00f      	beq.n	c0d032de <USBD_HID_Setup+0x78>
c0d032be:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d032c0:	4632      	mov	r2, r6
c0d032c2:	4631      	mov	r1, r6
c0d032c4:	d117      	bne.n	c0d032f6 <USBD_HID_Setup+0x90>
c0d032c6:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d032c8:	9000      	str	r0, [sp, #0]
c0d032ca:	f000 f847 	bl	c0d0335c <USBD_HID_GetReportDescriptor_impl>
c0d032ce:	e00a      	b.n	c0d032e6 <USBD_HID_Setup+0x80>
c0d032d0:	a901      	add	r1, sp, #4
c0d032d2:	2201      	movs	r2, #1
c0d032d4:	e00f      	b.n	c0d032f6 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d032d6:	4620      	mov	r0, r4
c0d032d8:	f000 f918 	bl	c0d0350c <USBD_CtlSendStatus>
c0d032dc:	e00e      	b.n	c0d032fc <USBD_HID_Setup+0x96>
c0d032de:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d032e0:	9000      	str	r0, [sp, #0]
c0d032e2:	f000 f833 	bl	c0d0334c <USBD_HID_GetHidDescriptor_impl>
c0d032e6:	9b00      	ldr	r3, [sp, #0]
c0d032e8:	4601      	mov	r1, r0
c0d032ea:	881a      	ldrh	r2, [r3, #0]
c0d032ec:	88e8      	ldrh	r0, [r5, #6]
c0d032ee:	4282      	cmp	r2, r0
c0d032f0:	d300      	bcc.n	c0d032f4 <USBD_HID_Setup+0x8e>
c0d032f2:	4602      	mov	r2, r0
c0d032f4:	801a      	strh	r2, [r3, #0]
c0d032f6:	4620      	mov	r0, r4
c0d032f8:	f000 f8da 	bl	c0d034b0 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d032fc:	b2f0      	uxtb	r0, r6
c0d032fe:	b003      	add	sp, #12
c0d03300:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03302 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d03302:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03304:	af03      	add	r7, sp, #12
c0d03306:	b081      	sub	sp, #4
c0d03308:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d0330a:	2182      	movs	r1, #130	; 0x82
c0d0330c:	2502      	movs	r5, #2
c0d0330e:	2640      	movs	r6, #64	; 0x40
c0d03310:	462a      	mov	r2, r5
c0d03312:	4633      	mov	r3, r6
c0d03314:	f7ff fad0 	bl	c0d028b8 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d03318:	4620      	mov	r0, r4
c0d0331a:	4629      	mov	r1, r5
c0d0331c:	462a      	mov	r2, r5
c0d0331e:	4633      	mov	r3, r6
c0d03320:	f7ff faca 	bl	c0d028b8 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d03324:	4620      	mov	r0, r4
c0d03326:	4629      	mov	r1, r5
c0d03328:	4632      	mov	r2, r6
c0d0332a:	f7ff fb90 	bl	c0d02a4e <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d0332e:	2000      	movs	r0, #0
c0d03330:	b001      	add	sp, #4
c0d03332:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03334 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d03334:	b5d0      	push	{r4, r6, r7, lr}
c0d03336:	af02      	add	r7, sp, #8
c0d03338:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d0333a:	2182      	movs	r1, #130	; 0x82
c0d0333c:	f7ff fae4 	bl	c0d02908 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d03340:	2102      	movs	r1, #2
c0d03342:	4620      	mov	r0, r4
c0d03344:	f7ff fae0 	bl	c0d02908 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d03348:	2000      	movs	r0, #0
c0d0334a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0334c <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d0334c:	2109      	movs	r1, #9
c0d0334e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d03350:	4801      	ldr	r0, [pc, #4]	; (c0d03358 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d03352:	4478      	add	r0, pc
c0d03354:	4770      	bx	lr
c0d03356:	46c0      	nop			; (mov r8, r8)
c0d03358:	00000c72 	.word	0x00000c72

c0d0335c <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d0335c:	2122      	movs	r1, #34	; 0x22
c0d0335e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d03360:	4801      	ldr	r0, [pc, #4]	; (c0d03368 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d03362:	4478      	add	r0, pc
c0d03364:	4770      	bx	lr
c0d03366:	46c0      	nop			; (mov r8, r8)
c0d03368:	00000c3d 	.word	0x00000c3d

c0d0336c <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d0336c:	b5b0      	push	{r4, r5, r7, lr}
c0d0336e:	af02      	add	r7, sp, #8
c0d03370:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d03372:	2102      	movs	r1, #2
c0d03374:	2240      	movs	r2, #64	; 0x40
c0d03376:	f7ff fb6a 	bl	c0d02a4e <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d0337a:	4d0d      	ldr	r5, [pc, #52]	; (c0d033b0 <USBD_HID_DataOut_impl+0x44>)
c0d0337c:	7828      	ldrb	r0, [r5, #0]
c0d0337e:	2800      	cmp	r0, #0
c0d03380:	d113      	bne.n	c0d033aa <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d03382:	2002      	movs	r0, #2
c0d03384:	f7fe f928 	bl	c0d015d8 <io_seproxyhal_get_ep_rx_size>
c0d03388:	4602      	mov	r2, r0
c0d0338a:	480d      	ldr	r0, [pc, #52]	; (c0d033c0 <USBD_HID_DataOut_impl+0x54>)
c0d0338c:	4478      	add	r0, pc
c0d0338e:	4621      	mov	r1, r4
c0d03390:	f7fd ff86 	bl	c0d012a0 <io_usb_hid_receive>
c0d03394:	2802      	cmp	r0, #2
c0d03396:	d108      	bne.n	c0d033aa <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d03398:	2001      	movs	r0, #1
c0d0339a:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d0339c:	4805      	ldr	r0, [pc, #20]	; (c0d033b4 <USBD_HID_DataOut_impl+0x48>)
c0d0339e:	2107      	movs	r1, #7
c0d033a0:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d033a2:	4805      	ldr	r0, [pc, #20]	; (c0d033b8 <USBD_HID_DataOut_impl+0x4c>)
c0d033a4:	6800      	ldr	r0, [r0, #0]
c0d033a6:	4905      	ldr	r1, [pc, #20]	; (c0d033bc <USBD_HID_DataOut_impl+0x50>)
c0d033a8:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d033aa:	2000      	movs	r0, #0
c0d033ac:	bdb0      	pop	{r4, r5, r7, pc}
c0d033ae:	46c0      	nop			; (mov r8, r8)
c0d033b0:	20001d10 	.word	0x20001d10
c0d033b4:	20001d18 	.word	0x20001d18
c0d033b8:	20001c00 	.word	0x20001c00
c0d033bc:	20001d1c 	.word	0x20001d1c
c0d033c0:	ffffe3a1 	.word	0xffffe3a1

c0d033c4 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d033c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d033c6:	af03      	add	r7, sp, #12
c0d033c8:	b081      	sub	sp, #4
c0d033ca:	4604      	mov	r4, r0
c0d033cc:	2049      	movs	r0, #73	; 0x49
c0d033ce:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d033d0:	4810      	ldr	r0, [pc, #64]	; (c0d03414 <USB_power+0x50>)
c0d033d2:	2100      	movs	r1, #0
c0d033d4:	462a      	mov	r2, r5
c0d033d6:	f7fe f80f 	bl	c0d013f8 <os_memset>

  if (enabled) {
c0d033da:	2c00      	cmp	r4, #0
c0d033dc:	d015      	beq.n	c0d0340a <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d033de:	4c0d      	ldr	r4, [pc, #52]	; (c0d03414 <USB_power+0x50>)
c0d033e0:	2600      	movs	r6, #0
c0d033e2:	4620      	mov	r0, r4
c0d033e4:	4631      	mov	r1, r6
c0d033e6:	462a      	mov	r2, r5
c0d033e8:	f7fe f806 	bl	c0d013f8 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d033ec:	490a      	ldr	r1, [pc, #40]	; (c0d03418 <USB_power+0x54>)
c0d033ee:	4479      	add	r1, pc
c0d033f0:	4620      	mov	r0, r4
c0d033f2:	4632      	mov	r2, r6
c0d033f4:	f7ff fb3f 	bl	c0d02a76 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d033f8:	4908      	ldr	r1, [pc, #32]	; (c0d0341c <USB_power+0x58>)
c0d033fa:	4479      	add	r1, pc
c0d033fc:	4620      	mov	r0, r4
c0d033fe:	f7ff fb72 	bl	c0d02ae6 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d03402:	4620      	mov	r0, r4
c0d03404:	f7ff fb78 	bl	c0d02af8 <USBD_Start>
c0d03408:	e002      	b.n	c0d03410 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d0340a:	4802      	ldr	r0, [pc, #8]	; (c0d03414 <USB_power+0x50>)
c0d0340c:	f7ff fb51 	bl	c0d02ab2 <USBD_DeInit>
  }
}
c0d03410:	b001      	add	sp, #4
c0d03412:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03414:	20001d34 	.word	0x20001d34
c0d03418:	00000bf2 	.word	0x00000bf2
c0d0341c:	00000c22 	.word	0x00000c22

c0d03420 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d03420:	2012      	movs	r0, #18
c0d03422:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d03424:	4801      	ldr	r0, [pc, #4]	; (c0d0342c <USBD_DeviceDescriptor+0xc>)
c0d03426:	4478      	add	r0, pc
c0d03428:	4770      	bx	lr
c0d0342a:	46c0      	nop			; (mov r8, r8)
c0d0342c:	00000ba7 	.word	0x00000ba7

c0d03430 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d03430:	2004      	movs	r0, #4
c0d03432:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d03434:	4801      	ldr	r0, [pc, #4]	; (c0d0343c <USBD_LangIDStrDescriptor+0xc>)
c0d03436:	4478      	add	r0, pc
c0d03438:	4770      	bx	lr
c0d0343a:	46c0      	nop			; (mov r8, r8)
c0d0343c:	00000bca 	.word	0x00000bca

c0d03440 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d03440:	200e      	movs	r0, #14
c0d03442:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d03444:	4801      	ldr	r0, [pc, #4]	; (c0d0344c <USBD_ManufacturerStrDescriptor+0xc>)
c0d03446:	4478      	add	r0, pc
c0d03448:	4770      	bx	lr
c0d0344a:	46c0      	nop			; (mov r8, r8)
c0d0344c:	00000bbe 	.word	0x00000bbe

c0d03450 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d03450:	200e      	movs	r0, #14
c0d03452:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d03454:	4801      	ldr	r0, [pc, #4]	; (c0d0345c <USBD_ProductStrDescriptor+0xc>)
c0d03456:	4478      	add	r0, pc
c0d03458:	4770      	bx	lr
c0d0345a:	46c0      	nop			; (mov r8, r8)
c0d0345c:	00000b3b 	.word	0x00000b3b

c0d03460 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d03460:	200a      	movs	r0, #10
c0d03462:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d03464:	4801      	ldr	r0, [pc, #4]	; (c0d0346c <USBD_SerialStrDescriptor+0xc>)
c0d03466:	4478      	add	r0, pc
c0d03468:	4770      	bx	lr
c0d0346a:	46c0      	nop			; (mov r8, r8)
c0d0346c:	00000bac 	.word	0x00000bac

c0d03470 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d03470:	200e      	movs	r0, #14
c0d03472:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d03474:	4801      	ldr	r0, [pc, #4]	; (c0d0347c <USBD_ConfigStrDescriptor+0xc>)
c0d03476:	4478      	add	r0, pc
c0d03478:	4770      	bx	lr
c0d0347a:	46c0      	nop			; (mov r8, r8)
c0d0347c:	00000b1b 	.word	0x00000b1b

c0d03480 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d03480:	200e      	movs	r0, #14
c0d03482:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d03484:	4801      	ldr	r0, [pc, #4]	; (c0d0348c <USBD_InterfaceStrDescriptor+0xc>)
c0d03486:	4478      	add	r0, pc
c0d03488:	4770      	bx	lr
c0d0348a:	46c0      	nop			; (mov r8, r8)
c0d0348c:	00000b0b 	.word	0x00000b0b

c0d03490 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d03490:	2129      	movs	r1, #41	; 0x29
c0d03492:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d03494:	4801      	ldr	r0, [pc, #4]	; (c0d0349c <USBD_GetCfgDesc_impl+0xc>)
c0d03496:	4478      	add	r0, pc
c0d03498:	4770      	bx	lr
c0d0349a:	46c0      	nop			; (mov r8, r8)
c0d0349c:	00000bbe 	.word	0x00000bbe

c0d034a0 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d034a0:	210a      	movs	r1, #10
c0d034a2:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d034a4:	4801      	ldr	r0, [pc, #4]	; (c0d034ac <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d034a6:	4478      	add	r0, pc
c0d034a8:	4770      	bx	lr
c0d034aa:	46c0      	nop			; (mov r8, r8)
c0d034ac:	00000bda 	.word	0x00000bda

c0d034b0 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d034b0:	b5b0      	push	{r4, r5, r7, lr}
c0d034b2:	af02      	add	r7, sp, #8
c0d034b4:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d034b6:	21f4      	movs	r1, #244	; 0xf4
c0d034b8:	2302      	movs	r3, #2
c0d034ba:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d034bc:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d034be:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d034c0:	2109      	movs	r1, #9
c0d034c2:	0149      	lsls	r1, r1, #5
c0d034c4:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d034c6:	6a01      	ldr	r1, [r0, #32]
c0d034c8:	428a      	cmp	r2, r1
c0d034ca:	d300      	bcc.n	c0d034ce <USBD_CtlSendData+0x1e>
c0d034cc:	460a      	mov	r2, r1
c0d034ce:	b293      	uxth	r3, r2
c0d034d0:	2500      	movs	r5, #0
c0d034d2:	4629      	mov	r1, r5
c0d034d4:	4622      	mov	r2, r4
c0d034d6:	f7ff faa0 	bl	c0d02a1a <USBD_LL_Transmit>
  
  return USBD_OK;
c0d034da:	4628      	mov	r0, r5
c0d034dc:	bdb0      	pop	{r4, r5, r7, pc}

c0d034de <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d034de:	b5b0      	push	{r4, r5, r7, lr}
c0d034e0:	af02      	add	r7, sp, #8
c0d034e2:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d034e4:	6a01      	ldr	r1, [r0, #32]
c0d034e6:	428a      	cmp	r2, r1
c0d034e8:	d300      	bcc.n	c0d034ec <USBD_CtlContinueSendData+0xe>
c0d034ea:	460a      	mov	r2, r1
c0d034ec:	b293      	uxth	r3, r2
c0d034ee:	2500      	movs	r5, #0
c0d034f0:	4629      	mov	r1, r5
c0d034f2:	4622      	mov	r2, r4
c0d034f4:	f7ff fa91 	bl	c0d02a1a <USBD_LL_Transmit>
  return USBD_OK;
c0d034f8:	4628      	mov	r0, r5
c0d034fa:	bdb0      	pop	{r4, r5, r7, pc}

c0d034fc <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d034fc:	b5d0      	push	{r4, r6, r7, lr}
c0d034fe:	af02      	add	r7, sp, #8
c0d03500:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d03502:	4621      	mov	r1, r4
c0d03504:	f7ff faa3 	bl	c0d02a4e <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d03508:	4620      	mov	r0, r4
c0d0350a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0350c <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d0350c:	b5d0      	push	{r4, r6, r7, lr}
c0d0350e:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d03510:	21f4      	movs	r1, #244	; 0xf4
c0d03512:	2204      	movs	r2, #4
c0d03514:	5042      	str	r2, [r0, r1]
c0d03516:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d03518:	4621      	mov	r1, r4
c0d0351a:	4622      	mov	r2, r4
c0d0351c:	4623      	mov	r3, r4
c0d0351e:	f7ff fa7c 	bl	c0d02a1a <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03522:	4620      	mov	r0, r4
c0d03524:	bdd0      	pop	{r4, r6, r7, pc}

c0d03526 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d03526:	b5d0      	push	{r4, r6, r7, lr}
c0d03528:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d0352a:	21f4      	movs	r1, #244	; 0xf4
c0d0352c:	2205      	movs	r2, #5
c0d0352e:	5042      	str	r2, [r0, r1]
c0d03530:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d03532:	4621      	mov	r1, r4
c0d03534:	4622      	mov	r2, r4
c0d03536:	f7ff fa8a 	bl	c0d02a4e <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d0353a:	4620      	mov	r0, r4
c0d0353c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d03540 <__aeabi_uidiv>:
c0d03540:	2200      	movs	r2, #0
c0d03542:	0843      	lsrs	r3, r0, #1
c0d03544:	428b      	cmp	r3, r1
c0d03546:	d374      	bcc.n	c0d03632 <__aeabi_uidiv+0xf2>
c0d03548:	0903      	lsrs	r3, r0, #4
c0d0354a:	428b      	cmp	r3, r1
c0d0354c:	d35f      	bcc.n	c0d0360e <__aeabi_uidiv+0xce>
c0d0354e:	0a03      	lsrs	r3, r0, #8
c0d03550:	428b      	cmp	r3, r1
c0d03552:	d344      	bcc.n	c0d035de <__aeabi_uidiv+0x9e>
c0d03554:	0b03      	lsrs	r3, r0, #12
c0d03556:	428b      	cmp	r3, r1
c0d03558:	d328      	bcc.n	c0d035ac <__aeabi_uidiv+0x6c>
c0d0355a:	0c03      	lsrs	r3, r0, #16
c0d0355c:	428b      	cmp	r3, r1
c0d0355e:	d30d      	bcc.n	c0d0357c <__aeabi_uidiv+0x3c>
c0d03560:	22ff      	movs	r2, #255	; 0xff
c0d03562:	0209      	lsls	r1, r1, #8
c0d03564:	ba12      	rev	r2, r2
c0d03566:	0c03      	lsrs	r3, r0, #16
c0d03568:	428b      	cmp	r3, r1
c0d0356a:	d302      	bcc.n	c0d03572 <__aeabi_uidiv+0x32>
c0d0356c:	1212      	asrs	r2, r2, #8
c0d0356e:	0209      	lsls	r1, r1, #8
c0d03570:	d065      	beq.n	c0d0363e <__aeabi_uidiv+0xfe>
c0d03572:	0b03      	lsrs	r3, r0, #12
c0d03574:	428b      	cmp	r3, r1
c0d03576:	d319      	bcc.n	c0d035ac <__aeabi_uidiv+0x6c>
c0d03578:	e000      	b.n	c0d0357c <__aeabi_uidiv+0x3c>
c0d0357a:	0a09      	lsrs	r1, r1, #8
c0d0357c:	0bc3      	lsrs	r3, r0, #15
c0d0357e:	428b      	cmp	r3, r1
c0d03580:	d301      	bcc.n	c0d03586 <__aeabi_uidiv+0x46>
c0d03582:	03cb      	lsls	r3, r1, #15
c0d03584:	1ac0      	subs	r0, r0, r3
c0d03586:	4152      	adcs	r2, r2
c0d03588:	0b83      	lsrs	r3, r0, #14
c0d0358a:	428b      	cmp	r3, r1
c0d0358c:	d301      	bcc.n	c0d03592 <__aeabi_uidiv+0x52>
c0d0358e:	038b      	lsls	r3, r1, #14
c0d03590:	1ac0      	subs	r0, r0, r3
c0d03592:	4152      	adcs	r2, r2
c0d03594:	0b43      	lsrs	r3, r0, #13
c0d03596:	428b      	cmp	r3, r1
c0d03598:	d301      	bcc.n	c0d0359e <__aeabi_uidiv+0x5e>
c0d0359a:	034b      	lsls	r3, r1, #13
c0d0359c:	1ac0      	subs	r0, r0, r3
c0d0359e:	4152      	adcs	r2, r2
c0d035a0:	0b03      	lsrs	r3, r0, #12
c0d035a2:	428b      	cmp	r3, r1
c0d035a4:	d301      	bcc.n	c0d035aa <__aeabi_uidiv+0x6a>
c0d035a6:	030b      	lsls	r3, r1, #12
c0d035a8:	1ac0      	subs	r0, r0, r3
c0d035aa:	4152      	adcs	r2, r2
c0d035ac:	0ac3      	lsrs	r3, r0, #11
c0d035ae:	428b      	cmp	r3, r1
c0d035b0:	d301      	bcc.n	c0d035b6 <__aeabi_uidiv+0x76>
c0d035b2:	02cb      	lsls	r3, r1, #11
c0d035b4:	1ac0      	subs	r0, r0, r3
c0d035b6:	4152      	adcs	r2, r2
c0d035b8:	0a83      	lsrs	r3, r0, #10
c0d035ba:	428b      	cmp	r3, r1
c0d035bc:	d301      	bcc.n	c0d035c2 <__aeabi_uidiv+0x82>
c0d035be:	028b      	lsls	r3, r1, #10
c0d035c0:	1ac0      	subs	r0, r0, r3
c0d035c2:	4152      	adcs	r2, r2
c0d035c4:	0a43      	lsrs	r3, r0, #9
c0d035c6:	428b      	cmp	r3, r1
c0d035c8:	d301      	bcc.n	c0d035ce <__aeabi_uidiv+0x8e>
c0d035ca:	024b      	lsls	r3, r1, #9
c0d035cc:	1ac0      	subs	r0, r0, r3
c0d035ce:	4152      	adcs	r2, r2
c0d035d0:	0a03      	lsrs	r3, r0, #8
c0d035d2:	428b      	cmp	r3, r1
c0d035d4:	d301      	bcc.n	c0d035da <__aeabi_uidiv+0x9a>
c0d035d6:	020b      	lsls	r3, r1, #8
c0d035d8:	1ac0      	subs	r0, r0, r3
c0d035da:	4152      	adcs	r2, r2
c0d035dc:	d2cd      	bcs.n	c0d0357a <__aeabi_uidiv+0x3a>
c0d035de:	09c3      	lsrs	r3, r0, #7
c0d035e0:	428b      	cmp	r3, r1
c0d035e2:	d301      	bcc.n	c0d035e8 <__aeabi_uidiv+0xa8>
c0d035e4:	01cb      	lsls	r3, r1, #7
c0d035e6:	1ac0      	subs	r0, r0, r3
c0d035e8:	4152      	adcs	r2, r2
c0d035ea:	0983      	lsrs	r3, r0, #6
c0d035ec:	428b      	cmp	r3, r1
c0d035ee:	d301      	bcc.n	c0d035f4 <__aeabi_uidiv+0xb4>
c0d035f0:	018b      	lsls	r3, r1, #6
c0d035f2:	1ac0      	subs	r0, r0, r3
c0d035f4:	4152      	adcs	r2, r2
c0d035f6:	0943      	lsrs	r3, r0, #5
c0d035f8:	428b      	cmp	r3, r1
c0d035fa:	d301      	bcc.n	c0d03600 <__aeabi_uidiv+0xc0>
c0d035fc:	014b      	lsls	r3, r1, #5
c0d035fe:	1ac0      	subs	r0, r0, r3
c0d03600:	4152      	adcs	r2, r2
c0d03602:	0903      	lsrs	r3, r0, #4
c0d03604:	428b      	cmp	r3, r1
c0d03606:	d301      	bcc.n	c0d0360c <__aeabi_uidiv+0xcc>
c0d03608:	010b      	lsls	r3, r1, #4
c0d0360a:	1ac0      	subs	r0, r0, r3
c0d0360c:	4152      	adcs	r2, r2
c0d0360e:	08c3      	lsrs	r3, r0, #3
c0d03610:	428b      	cmp	r3, r1
c0d03612:	d301      	bcc.n	c0d03618 <__aeabi_uidiv+0xd8>
c0d03614:	00cb      	lsls	r3, r1, #3
c0d03616:	1ac0      	subs	r0, r0, r3
c0d03618:	4152      	adcs	r2, r2
c0d0361a:	0883      	lsrs	r3, r0, #2
c0d0361c:	428b      	cmp	r3, r1
c0d0361e:	d301      	bcc.n	c0d03624 <__aeabi_uidiv+0xe4>
c0d03620:	008b      	lsls	r3, r1, #2
c0d03622:	1ac0      	subs	r0, r0, r3
c0d03624:	4152      	adcs	r2, r2
c0d03626:	0843      	lsrs	r3, r0, #1
c0d03628:	428b      	cmp	r3, r1
c0d0362a:	d301      	bcc.n	c0d03630 <__aeabi_uidiv+0xf0>
c0d0362c:	004b      	lsls	r3, r1, #1
c0d0362e:	1ac0      	subs	r0, r0, r3
c0d03630:	4152      	adcs	r2, r2
c0d03632:	1a41      	subs	r1, r0, r1
c0d03634:	d200      	bcs.n	c0d03638 <__aeabi_uidiv+0xf8>
c0d03636:	4601      	mov	r1, r0
c0d03638:	4152      	adcs	r2, r2
c0d0363a:	4610      	mov	r0, r2
c0d0363c:	4770      	bx	lr
c0d0363e:	e7ff      	b.n	c0d03640 <__aeabi_uidiv+0x100>
c0d03640:	b501      	push	{r0, lr}
c0d03642:	2000      	movs	r0, #0
c0d03644:	f000 f8f0 	bl	c0d03828 <__aeabi_idiv0>
c0d03648:	bd02      	pop	{r1, pc}
c0d0364a:	46c0      	nop			; (mov r8, r8)

c0d0364c <__aeabi_uidivmod>:
c0d0364c:	2900      	cmp	r1, #0
c0d0364e:	d0f7      	beq.n	c0d03640 <__aeabi_uidiv+0x100>
c0d03650:	e776      	b.n	c0d03540 <__aeabi_uidiv>
c0d03652:	4770      	bx	lr

c0d03654 <__aeabi_idiv>:
c0d03654:	4603      	mov	r3, r0
c0d03656:	430b      	orrs	r3, r1
c0d03658:	d47f      	bmi.n	c0d0375a <__aeabi_idiv+0x106>
c0d0365a:	2200      	movs	r2, #0
c0d0365c:	0843      	lsrs	r3, r0, #1
c0d0365e:	428b      	cmp	r3, r1
c0d03660:	d374      	bcc.n	c0d0374c <__aeabi_idiv+0xf8>
c0d03662:	0903      	lsrs	r3, r0, #4
c0d03664:	428b      	cmp	r3, r1
c0d03666:	d35f      	bcc.n	c0d03728 <__aeabi_idiv+0xd4>
c0d03668:	0a03      	lsrs	r3, r0, #8
c0d0366a:	428b      	cmp	r3, r1
c0d0366c:	d344      	bcc.n	c0d036f8 <__aeabi_idiv+0xa4>
c0d0366e:	0b03      	lsrs	r3, r0, #12
c0d03670:	428b      	cmp	r3, r1
c0d03672:	d328      	bcc.n	c0d036c6 <__aeabi_idiv+0x72>
c0d03674:	0c03      	lsrs	r3, r0, #16
c0d03676:	428b      	cmp	r3, r1
c0d03678:	d30d      	bcc.n	c0d03696 <__aeabi_idiv+0x42>
c0d0367a:	22ff      	movs	r2, #255	; 0xff
c0d0367c:	0209      	lsls	r1, r1, #8
c0d0367e:	ba12      	rev	r2, r2
c0d03680:	0c03      	lsrs	r3, r0, #16
c0d03682:	428b      	cmp	r3, r1
c0d03684:	d302      	bcc.n	c0d0368c <__aeabi_idiv+0x38>
c0d03686:	1212      	asrs	r2, r2, #8
c0d03688:	0209      	lsls	r1, r1, #8
c0d0368a:	d065      	beq.n	c0d03758 <__aeabi_idiv+0x104>
c0d0368c:	0b03      	lsrs	r3, r0, #12
c0d0368e:	428b      	cmp	r3, r1
c0d03690:	d319      	bcc.n	c0d036c6 <__aeabi_idiv+0x72>
c0d03692:	e000      	b.n	c0d03696 <__aeabi_idiv+0x42>
c0d03694:	0a09      	lsrs	r1, r1, #8
c0d03696:	0bc3      	lsrs	r3, r0, #15
c0d03698:	428b      	cmp	r3, r1
c0d0369a:	d301      	bcc.n	c0d036a0 <__aeabi_idiv+0x4c>
c0d0369c:	03cb      	lsls	r3, r1, #15
c0d0369e:	1ac0      	subs	r0, r0, r3
c0d036a0:	4152      	adcs	r2, r2
c0d036a2:	0b83      	lsrs	r3, r0, #14
c0d036a4:	428b      	cmp	r3, r1
c0d036a6:	d301      	bcc.n	c0d036ac <__aeabi_idiv+0x58>
c0d036a8:	038b      	lsls	r3, r1, #14
c0d036aa:	1ac0      	subs	r0, r0, r3
c0d036ac:	4152      	adcs	r2, r2
c0d036ae:	0b43      	lsrs	r3, r0, #13
c0d036b0:	428b      	cmp	r3, r1
c0d036b2:	d301      	bcc.n	c0d036b8 <__aeabi_idiv+0x64>
c0d036b4:	034b      	lsls	r3, r1, #13
c0d036b6:	1ac0      	subs	r0, r0, r3
c0d036b8:	4152      	adcs	r2, r2
c0d036ba:	0b03      	lsrs	r3, r0, #12
c0d036bc:	428b      	cmp	r3, r1
c0d036be:	d301      	bcc.n	c0d036c4 <__aeabi_idiv+0x70>
c0d036c0:	030b      	lsls	r3, r1, #12
c0d036c2:	1ac0      	subs	r0, r0, r3
c0d036c4:	4152      	adcs	r2, r2
c0d036c6:	0ac3      	lsrs	r3, r0, #11
c0d036c8:	428b      	cmp	r3, r1
c0d036ca:	d301      	bcc.n	c0d036d0 <__aeabi_idiv+0x7c>
c0d036cc:	02cb      	lsls	r3, r1, #11
c0d036ce:	1ac0      	subs	r0, r0, r3
c0d036d0:	4152      	adcs	r2, r2
c0d036d2:	0a83      	lsrs	r3, r0, #10
c0d036d4:	428b      	cmp	r3, r1
c0d036d6:	d301      	bcc.n	c0d036dc <__aeabi_idiv+0x88>
c0d036d8:	028b      	lsls	r3, r1, #10
c0d036da:	1ac0      	subs	r0, r0, r3
c0d036dc:	4152      	adcs	r2, r2
c0d036de:	0a43      	lsrs	r3, r0, #9
c0d036e0:	428b      	cmp	r3, r1
c0d036e2:	d301      	bcc.n	c0d036e8 <__aeabi_idiv+0x94>
c0d036e4:	024b      	lsls	r3, r1, #9
c0d036e6:	1ac0      	subs	r0, r0, r3
c0d036e8:	4152      	adcs	r2, r2
c0d036ea:	0a03      	lsrs	r3, r0, #8
c0d036ec:	428b      	cmp	r3, r1
c0d036ee:	d301      	bcc.n	c0d036f4 <__aeabi_idiv+0xa0>
c0d036f0:	020b      	lsls	r3, r1, #8
c0d036f2:	1ac0      	subs	r0, r0, r3
c0d036f4:	4152      	adcs	r2, r2
c0d036f6:	d2cd      	bcs.n	c0d03694 <__aeabi_idiv+0x40>
c0d036f8:	09c3      	lsrs	r3, r0, #7
c0d036fa:	428b      	cmp	r3, r1
c0d036fc:	d301      	bcc.n	c0d03702 <__aeabi_idiv+0xae>
c0d036fe:	01cb      	lsls	r3, r1, #7
c0d03700:	1ac0      	subs	r0, r0, r3
c0d03702:	4152      	adcs	r2, r2
c0d03704:	0983      	lsrs	r3, r0, #6
c0d03706:	428b      	cmp	r3, r1
c0d03708:	d301      	bcc.n	c0d0370e <__aeabi_idiv+0xba>
c0d0370a:	018b      	lsls	r3, r1, #6
c0d0370c:	1ac0      	subs	r0, r0, r3
c0d0370e:	4152      	adcs	r2, r2
c0d03710:	0943      	lsrs	r3, r0, #5
c0d03712:	428b      	cmp	r3, r1
c0d03714:	d301      	bcc.n	c0d0371a <__aeabi_idiv+0xc6>
c0d03716:	014b      	lsls	r3, r1, #5
c0d03718:	1ac0      	subs	r0, r0, r3
c0d0371a:	4152      	adcs	r2, r2
c0d0371c:	0903      	lsrs	r3, r0, #4
c0d0371e:	428b      	cmp	r3, r1
c0d03720:	d301      	bcc.n	c0d03726 <__aeabi_idiv+0xd2>
c0d03722:	010b      	lsls	r3, r1, #4
c0d03724:	1ac0      	subs	r0, r0, r3
c0d03726:	4152      	adcs	r2, r2
c0d03728:	08c3      	lsrs	r3, r0, #3
c0d0372a:	428b      	cmp	r3, r1
c0d0372c:	d301      	bcc.n	c0d03732 <__aeabi_idiv+0xde>
c0d0372e:	00cb      	lsls	r3, r1, #3
c0d03730:	1ac0      	subs	r0, r0, r3
c0d03732:	4152      	adcs	r2, r2
c0d03734:	0883      	lsrs	r3, r0, #2
c0d03736:	428b      	cmp	r3, r1
c0d03738:	d301      	bcc.n	c0d0373e <__aeabi_idiv+0xea>
c0d0373a:	008b      	lsls	r3, r1, #2
c0d0373c:	1ac0      	subs	r0, r0, r3
c0d0373e:	4152      	adcs	r2, r2
c0d03740:	0843      	lsrs	r3, r0, #1
c0d03742:	428b      	cmp	r3, r1
c0d03744:	d301      	bcc.n	c0d0374a <__aeabi_idiv+0xf6>
c0d03746:	004b      	lsls	r3, r1, #1
c0d03748:	1ac0      	subs	r0, r0, r3
c0d0374a:	4152      	adcs	r2, r2
c0d0374c:	1a41      	subs	r1, r0, r1
c0d0374e:	d200      	bcs.n	c0d03752 <__aeabi_idiv+0xfe>
c0d03750:	4601      	mov	r1, r0
c0d03752:	4152      	adcs	r2, r2
c0d03754:	4610      	mov	r0, r2
c0d03756:	4770      	bx	lr
c0d03758:	e05d      	b.n	c0d03816 <__aeabi_idiv+0x1c2>
c0d0375a:	0fca      	lsrs	r2, r1, #31
c0d0375c:	d000      	beq.n	c0d03760 <__aeabi_idiv+0x10c>
c0d0375e:	4249      	negs	r1, r1
c0d03760:	1003      	asrs	r3, r0, #32
c0d03762:	d300      	bcc.n	c0d03766 <__aeabi_idiv+0x112>
c0d03764:	4240      	negs	r0, r0
c0d03766:	4053      	eors	r3, r2
c0d03768:	2200      	movs	r2, #0
c0d0376a:	469c      	mov	ip, r3
c0d0376c:	0903      	lsrs	r3, r0, #4
c0d0376e:	428b      	cmp	r3, r1
c0d03770:	d32d      	bcc.n	c0d037ce <__aeabi_idiv+0x17a>
c0d03772:	0a03      	lsrs	r3, r0, #8
c0d03774:	428b      	cmp	r3, r1
c0d03776:	d312      	bcc.n	c0d0379e <__aeabi_idiv+0x14a>
c0d03778:	22fc      	movs	r2, #252	; 0xfc
c0d0377a:	0189      	lsls	r1, r1, #6
c0d0377c:	ba12      	rev	r2, r2
c0d0377e:	0a03      	lsrs	r3, r0, #8
c0d03780:	428b      	cmp	r3, r1
c0d03782:	d30c      	bcc.n	c0d0379e <__aeabi_idiv+0x14a>
c0d03784:	0189      	lsls	r1, r1, #6
c0d03786:	1192      	asrs	r2, r2, #6
c0d03788:	428b      	cmp	r3, r1
c0d0378a:	d308      	bcc.n	c0d0379e <__aeabi_idiv+0x14a>
c0d0378c:	0189      	lsls	r1, r1, #6
c0d0378e:	1192      	asrs	r2, r2, #6
c0d03790:	428b      	cmp	r3, r1
c0d03792:	d304      	bcc.n	c0d0379e <__aeabi_idiv+0x14a>
c0d03794:	0189      	lsls	r1, r1, #6
c0d03796:	d03a      	beq.n	c0d0380e <__aeabi_idiv+0x1ba>
c0d03798:	1192      	asrs	r2, r2, #6
c0d0379a:	e000      	b.n	c0d0379e <__aeabi_idiv+0x14a>
c0d0379c:	0989      	lsrs	r1, r1, #6
c0d0379e:	09c3      	lsrs	r3, r0, #7
c0d037a0:	428b      	cmp	r3, r1
c0d037a2:	d301      	bcc.n	c0d037a8 <__aeabi_idiv+0x154>
c0d037a4:	01cb      	lsls	r3, r1, #7
c0d037a6:	1ac0      	subs	r0, r0, r3
c0d037a8:	4152      	adcs	r2, r2
c0d037aa:	0983      	lsrs	r3, r0, #6
c0d037ac:	428b      	cmp	r3, r1
c0d037ae:	d301      	bcc.n	c0d037b4 <__aeabi_idiv+0x160>
c0d037b0:	018b      	lsls	r3, r1, #6
c0d037b2:	1ac0      	subs	r0, r0, r3
c0d037b4:	4152      	adcs	r2, r2
c0d037b6:	0943      	lsrs	r3, r0, #5
c0d037b8:	428b      	cmp	r3, r1
c0d037ba:	d301      	bcc.n	c0d037c0 <__aeabi_idiv+0x16c>
c0d037bc:	014b      	lsls	r3, r1, #5
c0d037be:	1ac0      	subs	r0, r0, r3
c0d037c0:	4152      	adcs	r2, r2
c0d037c2:	0903      	lsrs	r3, r0, #4
c0d037c4:	428b      	cmp	r3, r1
c0d037c6:	d301      	bcc.n	c0d037cc <__aeabi_idiv+0x178>
c0d037c8:	010b      	lsls	r3, r1, #4
c0d037ca:	1ac0      	subs	r0, r0, r3
c0d037cc:	4152      	adcs	r2, r2
c0d037ce:	08c3      	lsrs	r3, r0, #3
c0d037d0:	428b      	cmp	r3, r1
c0d037d2:	d301      	bcc.n	c0d037d8 <__aeabi_idiv+0x184>
c0d037d4:	00cb      	lsls	r3, r1, #3
c0d037d6:	1ac0      	subs	r0, r0, r3
c0d037d8:	4152      	adcs	r2, r2
c0d037da:	0883      	lsrs	r3, r0, #2
c0d037dc:	428b      	cmp	r3, r1
c0d037de:	d301      	bcc.n	c0d037e4 <__aeabi_idiv+0x190>
c0d037e0:	008b      	lsls	r3, r1, #2
c0d037e2:	1ac0      	subs	r0, r0, r3
c0d037e4:	4152      	adcs	r2, r2
c0d037e6:	d2d9      	bcs.n	c0d0379c <__aeabi_idiv+0x148>
c0d037e8:	0843      	lsrs	r3, r0, #1
c0d037ea:	428b      	cmp	r3, r1
c0d037ec:	d301      	bcc.n	c0d037f2 <__aeabi_idiv+0x19e>
c0d037ee:	004b      	lsls	r3, r1, #1
c0d037f0:	1ac0      	subs	r0, r0, r3
c0d037f2:	4152      	adcs	r2, r2
c0d037f4:	1a41      	subs	r1, r0, r1
c0d037f6:	d200      	bcs.n	c0d037fa <__aeabi_idiv+0x1a6>
c0d037f8:	4601      	mov	r1, r0
c0d037fa:	4663      	mov	r3, ip
c0d037fc:	4152      	adcs	r2, r2
c0d037fe:	105b      	asrs	r3, r3, #1
c0d03800:	4610      	mov	r0, r2
c0d03802:	d301      	bcc.n	c0d03808 <__aeabi_idiv+0x1b4>
c0d03804:	4240      	negs	r0, r0
c0d03806:	2b00      	cmp	r3, #0
c0d03808:	d500      	bpl.n	c0d0380c <__aeabi_idiv+0x1b8>
c0d0380a:	4249      	negs	r1, r1
c0d0380c:	4770      	bx	lr
c0d0380e:	4663      	mov	r3, ip
c0d03810:	105b      	asrs	r3, r3, #1
c0d03812:	d300      	bcc.n	c0d03816 <__aeabi_idiv+0x1c2>
c0d03814:	4240      	negs	r0, r0
c0d03816:	b501      	push	{r0, lr}
c0d03818:	2000      	movs	r0, #0
c0d0381a:	f000 f805 	bl	c0d03828 <__aeabi_idiv0>
c0d0381e:	bd02      	pop	{r1, pc}

c0d03820 <__aeabi_idivmod>:
c0d03820:	2900      	cmp	r1, #0
c0d03822:	d0f8      	beq.n	c0d03816 <__aeabi_idiv+0x1c2>
c0d03824:	e716      	b.n	c0d03654 <__aeabi_idiv>
c0d03826:	4770      	bx	lr

c0d03828 <__aeabi_idiv0>:
c0d03828:	4770      	bx	lr
c0d0382a:	46c0      	nop			; (mov r8, r8)

c0d0382c <__aeabi_uldivmod>:
c0d0382c:	2b00      	cmp	r3, #0
c0d0382e:	d111      	bne.n	c0d03854 <__aeabi_uldivmod+0x28>
c0d03830:	2a00      	cmp	r2, #0
c0d03832:	d10f      	bne.n	c0d03854 <__aeabi_uldivmod+0x28>
c0d03834:	2900      	cmp	r1, #0
c0d03836:	d100      	bne.n	c0d0383a <__aeabi_uldivmod+0xe>
c0d03838:	2800      	cmp	r0, #0
c0d0383a:	d002      	beq.n	c0d03842 <__aeabi_uldivmod+0x16>
c0d0383c:	2100      	movs	r1, #0
c0d0383e:	43c9      	mvns	r1, r1
c0d03840:	1c08      	adds	r0, r1, #0
c0d03842:	b407      	push	{r0, r1, r2}
c0d03844:	4802      	ldr	r0, [pc, #8]	; (c0d03850 <__aeabi_uldivmod+0x24>)
c0d03846:	a102      	add	r1, pc, #8	; (adr r1, c0d03850 <__aeabi_uldivmod+0x24>)
c0d03848:	1840      	adds	r0, r0, r1
c0d0384a:	9002      	str	r0, [sp, #8]
c0d0384c:	bd03      	pop	{r0, r1, pc}
c0d0384e:	46c0      	nop			; (mov r8, r8)
c0d03850:	ffffffd9 	.word	0xffffffd9
c0d03854:	b403      	push	{r0, r1}
c0d03856:	4668      	mov	r0, sp
c0d03858:	b501      	push	{r0, lr}
c0d0385a:	9802      	ldr	r0, [sp, #8]
c0d0385c:	f000 f806 	bl	c0d0386c <__udivmoddi4>
c0d03860:	9b01      	ldr	r3, [sp, #4]
c0d03862:	469e      	mov	lr, r3
c0d03864:	b002      	add	sp, #8
c0d03866:	bc0c      	pop	{r2, r3}
c0d03868:	4770      	bx	lr
c0d0386a:	46c0      	nop			; (mov r8, r8)

c0d0386c <__udivmoddi4>:
c0d0386c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0386e:	464d      	mov	r5, r9
c0d03870:	4656      	mov	r6, sl
c0d03872:	4644      	mov	r4, r8
c0d03874:	465f      	mov	r7, fp
c0d03876:	b4f0      	push	{r4, r5, r6, r7}
c0d03878:	4692      	mov	sl, r2
c0d0387a:	b083      	sub	sp, #12
c0d0387c:	0004      	movs	r4, r0
c0d0387e:	000d      	movs	r5, r1
c0d03880:	4699      	mov	r9, r3
c0d03882:	428b      	cmp	r3, r1
c0d03884:	d82f      	bhi.n	c0d038e6 <__udivmoddi4+0x7a>
c0d03886:	d02c      	beq.n	c0d038e2 <__udivmoddi4+0x76>
c0d03888:	4649      	mov	r1, r9
c0d0388a:	4650      	mov	r0, sl
c0d0388c:	f000 f8ae 	bl	c0d039ec <__clzdi2>
c0d03890:	0029      	movs	r1, r5
c0d03892:	0006      	movs	r6, r0
c0d03894:	0020      	movs	r0, r4
c0d03896:	f000 f8a9 	bl	c0d039ec <__clzdi2>
c0d0389a:	1a33      	subs	r3, r6, r0
c0d0389c:	4698      	mov	r8, r3
c0d0389e:	3b20      	subs	r3, #32
c0d038a0:	469b      	mov	fp, r3
c0d038a2:	d500      	bpl.n	c0d038a6 <__udivmoddi4+0x3a>
c0d038a4:	e074      	b.n	c0d03990 <__udivmoddi4+0x124>
c0d038a6:	4653      	mov	r3, sl
c0d038a8:	465a      	mov	r2, fp
c0d038aa:	4093      	lsls	r3, r2
c0d038ac:	001f      	movs	r7, r3
c0d038ae:	4653      	mov	r3, sl
c0d038b0:	4642      	mov	r2, r8
c0d038b2:	4093      	lsls	r3, r2
c0d038b4:	001e      	movs	r6, r3
c0d038b6:	42af      	cmp	r7, r5
c0d038b8:	d829      	bhi.n	c0d0390e <__udivmoddi4+0xa2>
c0d038ba:	d026      	beq.n	c0d0390a <__udivmoddi4+0x9e>
c0d038bc:	465b      	mov	r3, fp
c0d038be:	1ba4      	subs	r4, r4, r6
c0d038c0:	41bd      	sbcs	r5, r7
c0d038c2:	2b00      	cmp	r3, #0
c0d038c4:	da00      	bge.n	c0d038c8 <__udivmoddi4+0x5c>
c0d038c6:	e079      	b.n	c0d039bc <__udivmoddi4+0x150>
c0d038c8:	2200      	movs	r2, #0
c0d038ca:	2300      	movs	r3, #0
c0d038cc:	9200      	str	r2, [sp, #0]
c0d038ce:	9301      	str	r3, [sp, #4]
c0d038d0:	2301      	movs	r3, #1
c0d038d2:	465a      	mov	r2, fp
c0d038d4:	4093      	lsls	r3, r2
c0d038d6:	9301      	str	r3, [sp, #4]
c0d038d8:	2301      	movs	r3, #1
c0d038da:	4642      	mov	r2, r8
c0d038dc:	4093      	lsls	r3, r2
c0d038de:	9300      	str	r3, [sp, #0]
c0d038e0:	e019      	b.n	c0d03916 <__udivmoddi4+0xaa>
c0d038e2:	4282      	cmp	r2, r0
c0d038e4:	d9d0      	bls.n	c0d03888 <__udivmoddi4+0x1c>
c0d038e6:	2200      	movs	r2, #0
c0d038e8:	2300      	movs	r3, #0
c0d038ea:	9200      	str	r2, [sp, #0]
c0d038ec:	9301      	str	r3, [sp, #4]
c0d038ee:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d038f0:	2b00      	cmp	r3, #0
c0d038f2:	d001      	beq.n	c0d038f8 <__udivmoddi4+0x8c>
c0d038f4:	601c      	str	r4, [r3, #0]
c0d038f6:	605d      	str	r5, [r3, #4]
c0d038f8:	9800      	ldr	r0, [sp, #0]
c0d038fa:	9901      	ldr	r1, [sp, #4]
c0d038fc:	b003      	add	sp, #12
c0d038fe:	bc3c      	pop	{r2, r3, r4, r5}
c0d03900:	4690      	mov	r8, r2
c0d03902:	4699      	mov	r9, r3
c0d03904:	46a2      	mov	sl, r4
c0d03906:	46ab      	mov	fp, r5
c0d03908:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0390a:	42a3      	cmp	r3, r4
c0d0390c:	d9d6      	bls.n	c0d038bc <__udivmoddi4+0x50>
c0d0390e:	2200      	movs	r2, #0
c0d03910:	2300      	movs	r3, #0
c0d03912:	9200      	str	r2, [sp, #0]
c0d03914:	9301      	str	r3, [sp, #4]
c0d03916:	4643      	mov	r3, r8
c0d03918:	2b00      	cmp	r3, #0
c0d0391a:	d0e8      	beq.n	c0d038ee <__udivmoddi4+0x82>
c0d0391c:	07fb      	lsls	r3, r7, #31
c0d0391e:	0872      	lsrs	r2, r6, #1
c0d03920:	431a      	orrs	r2, r3
c0d03922:	4646      	mov	r6, r8
c0d03924:	087b      	lsrs	r3, r7, #1
c0d03926:	e00e      	b.n	c0d03946 <__udivmoddi4+0xda>
c0d03928:	42ab      	cmp	r3, r5
c0d0392a:	d101      	bne.n	c0d03930 <__udivmoddi4+0xc4>
c0d0392c:	42a2      	cmp	r2, r4
c0d0392e:	d80c      	bhi.n	c0d0394a <__udivmoddi4+0xde>
c0d03930:	1aa4      	subs	r4, r4, r2
c0d03932:	419d      	sbcs	r5, r3
c0d03934:	2001      	movs	r0, #1
c0d03936:	1924      	adds	r4, r4, r4
c0d03938:	416d      	adcs	r5, r5
c0d0393a:	2100      	movs	r1, #0
c0d0393c:	3e01      	subs	r6, #1
c0d0393e:	1824      	adds	r4, r4, r0
c0d03940:	414d      	adcs	r5, r1
c0d03942:	2e00      	cmp	r6, #0
c0d03944:	d006      	beq.n	c0d03954 <__udivmoddi4+0xe8>
c0d03946:	42ab      	cmp	r3, r5
c0d03948:	d9ee      	bls.n	c0d03928 <__udivmoddi4+0xbc>
c0d0394a:	3e01      	subs	r6, #1
c0d0394c:	1924      	adds	r4, r4, r4
c0d0394e:	416d      	adcs	r5, r5
c0d03950:	2e00      	cmp	r6, #0
c0d03952:	d1f8      	bne.n	c0d03946 <__udivmoddi4+0xda>
c0d03954:	465b      	mov	r3, fp
c0d03956:	9800      	ldr	r0, [sp, #0]
c0d03958:	9901      	ldr	r1, [sp, #4]
c0d0395a:	1900      	adds	r0, r0, r4
c0d0395c:	4169      	adcs	r1, r5
c0d0395e:	2b00      	cmp	r3, #0
c0d03960:	db22      	blt.n	c0d039a8 <__udivmoddi4+0x13c>
c0d03962:	002b      	movs	r3, r5
c0d03964:	465a      	mov	r2, fp
c0d03966:	40d3      	lsrs	r3, r2
c0d03968:	002a      	movs	r2, r5
c0d0396a:	4644      	mov	r4, r8
c0d0396c:	40e2      	lsrs	r2, r4
c0d0396e:	001c      	movs	r4, r3
c0d03970:	465b      	mov	r3, fp
c0d03972:	0015      	movs	r5, r2
c0d03974:	2b00      	cmp	r3, #0
c0d03976:	db2c      	blt.n	c0d039d2 <__udivmoddi4+0x166>
c0d03978:	0026      	movs	r6, r4
c0d0397a:	409e      	lsls	r6, r3
c0d0397c:	0033      	movs	r3, r6
c0d0397e:	0026      	movs	r6, r4
c0d03980:	4647      	mov	r7, r8
c0d03982:	40be      	lsls	r6, r7
c0d03984:	0032      	movs	r2, r6
c0d03986:	1a80      	subs	r0, r0, r2
c0d03988:	4199      	sbcs	r1, r3
c0d0398a:	9000      	str	r0, [sp, #0]
c0d0398c:	9101      	str	r1, [sp, #4]
c0d0398e:	e7ae      	b.n	c0d038ee <__udivmoddi4+0x82>
c0d03990:	4642      	mov	r2, r8
c0d03992:	2320      	movs	r3, #32
c0d03994:	1a9b      	subs	r3, r3, r2
c0d03996:	4652      	mov	r2, sl
c0d03998:	40da      	lsrs	r2, r3
c0d0399a:	4641      	mov	r1, r8
c0d0399c:	0013      	movs	r3, r2
c0d0399e:	464a      	mov	r2, r9
c0d039a0:	408a      	lsls	r2, r1
c0d039a2:	0017      	movs	r7, r2
c0d039a4:	431f      	orrs	r7, r3
c0d039a6:	e782      	b.n	c0d038ae <__udivmoddi4+0x42>
c0d039a8:	4642      	mov	r2, r8
c0d039aa:	2320      	movs	r3, #32
c0d039ac:	1a9b      	subs	r3, r3, r2
c0d039ae:	002a      	movs	r2, r5
c0d039b0:	4646      	mov	r6, r8
c0d039b2:	409a      	lsls	r2, r3
c0d039b4:	0023      	movs	r3, r4
c0d039b6:	40f3      	lsrs	r3, r6
c0d039b8:	4313      	orrs	r3, r2
c0d039ba:	e7d5      	b.n	c0d03968 <__udivmoddi4+0xfc>
c0d039bc:	4642      	mov	r2, r8
c0d039be:	2320      	movs	r3, #32
c0d039c0:	2100      	movs	r1, #0
c0d039c2:	1a9b      	subs	r3, r3, r2
c0d039c4:	2200      	movs	r2, #0
c0d039c6:	9100      	str	r1, [sp, #0]
c0d039c8:	9201      	str	r2, [sp, #4]
c0d039ca:	2201      	movs	r2, #1
c0d039cc:	40da      	lsrs	r2, r3
c0d039ce:	9201      	str	r2, [sp, #4]
c0d039d0:	e782      	b.n	c0d038d8 <__udivmoddi4+0x6c>
c0d039d2:	4642      	mov	r2, r8
c0d039d4:	2320      	movs	r3, #32
c0d039d6:	0026      	movs	r6, r4
c0d039d8:	1a9b      	subs	r3, r3, r2
c0d039da:	40de      	lsrs	r6, r3
c0d039dc:	002f      	movs	r7, r5
c0d039de:	46b4      	mov	ip, r6
c0d039e0:	4097      	lsls	r7, r2
c0d039e2:	4666      	mov	r6, ip
c0d039e4:	003b      	movs	r3, r7
c0d039e6:	4333      	orrs	r3, r6
c0d039e8:	e7c9      	b.n	c0d0397e <__udivmoddi4+0x112>
c0d039ea:	46c0      	nop			; (mov r8, r8)

c0d039ec <__clzdi2>:
c0d039ec:	b510      	push	{r4, lr}
c0d039ee:	2900      	cmp	r1, #0
c0d039f0:	d103      	bne.n	c0d039fa <__clzdi2+0xe>
c0d039f2:	f000 f807 	bl	c0d03a04 <__clzsi2>
c0d039f6:	3020      	adds	r0, #32
c0d039f8:	e002      	b.n	c0d03a00 <__clzdi2+0x14>
c0d039fa:	1c08      	adds	r0, r1, #0
c0d039fc:	f000 f802 	bl	c0d03a04 <__clzsi2>
c0d03a00:	bd10      	pop	{r4, pc}
c0d03a02:	46c0      	nop			; (mov r8, r8)

c0d03a04 <__clzsi2>:
c0d03a04:	211c      	movs	r1, #28
c0d03a06:	2301      	movs	r3, #1
c0d03a08:	041b      	lsls	r3, r3, #16
c0d03a0a:	4298      	cmp	r0, r3
c0d03a0c:	d301      	bcc.n	c0d03a12 <__clzsi2+0xe>
c0d03a0e:	0c00      	lsrs	r0, r0, #16
c0d03a10:	3910      	subs	r1, #16
c0d03a12:	0a1b      	lsrs	r3, r3, #8
c0d03a14:	4298      	cmp	r0, r3
c0d03a16:	d301      	bcc.n	c0d03a1c <__clzsi2+0x18>
c0d03a18:	0a00      	lsrs	r0, r0, #8
c0d03a1a:	3908      	subs	r1, #8
c0d03a1c:	091b      	lsrs	r3, r3, #4
c0d03a1e:	4298      	cmp	r0, r3
c0d03a20:	d301      	bcc.n	c0d03a26 <__clzsi2+0x22>
c0d03a22:	0900      	lsrs	r0, r0, #4
c0d03a24:	3904      	subs	r1, #4
c0d03a26:	a202      	add	r2, pc, #8	; (adr r2, c0d03a30 <__clzsi2+0x2c>)
c0d03a28:	5c10      	ldrb	r0, [r2, r0]
c0d03a2a:	1840      	adds	r0, r0, r1
c0d03a2c:	4770      	bx	lr
c0d03a2e:	46c0      	nop			; (mov r8, r8)
c0d03a30:	02020304 	.word	0x02020304
c0d03a34:	01010101 	.word	0x01010101
	...

c0d03a40 <__aeabi_memclr>:
c0d03a40:	b510      	push	{r4, lr}
c0d03a42:	2200      	movs	r2, #0
c0d03a44:	f000 f806 	bl	c0d03a54 <__aeabi_memset>
c0d03a48:	bd10      	pop	{r4, pc}
c0d03a4a:	46c0      	nop			; (mov r8, r8)

c0d03a4c <__aeabi_memcpy>:
c0d03a4c:	b510      	push	{r4, lr}
c0d03a4e:	f000 f809 	bl	c0d03a64 <memcpy>
c0d03a52:	bd10      	pop	{r4, pc}

c0d03a54 <__aeabi_memset>:
c0d03a54:	0013      	movs	r3, r2
c0d03a56:	b510      	push	{r4, lr}
c0d03a58:	000a      	movs	r2, r1
c0d03a5a:	0019      	movs	r1, r3
c0d03a5c:	f000 f840 	bl	c0d03ae0 <memset>
c0d03a60:	bd10      	pop	{r4, pc}
c0d03a62:	46c0      	nop			; (mov r8, r8)

c0d03a64 <memcpy>:
c0d03a64:	b570      	push	{r4, r5, r6, lr}
c0d03a66:	2a0f      	cmp	r2, #15
c0d03a68:	d932      	bls.n	c0d03ad0 <memcpy+0x6c>
c0d03a6a:	000c      	movs	r4, r1
c0d03a6c:	4304      	orrs	r4, r0
c0d03a6e:	000b      	movs	r3, r1
c0d03a70:	07a4      	lsls	r4, r4, #30
c0d03a72:	d131      	bne.n	c0d03ad8 <memcpy+0x74>
c0d03a74:	0015      	movs	r5, r2
c0d03a76:	0004      	movs	r4, r0
c0d03a78:	3d10      	subs	r5, #16
c0d03a7a:	092d      	lsrs	r5, r5, #4
c0d03a7c:	3501      	adds	r5, #1
c0d03a7e:	012d      	lsls	r5, r5, #4
c0d03a80:	1949      	adds	r1, r1, r5
c0d03a82:	681e      	ldr	r6, [r3, #0]
c0d03a84:	6026      	str	r6, [r4, #0]
c0d03a86:	685e      	ldr	r6, [r3, #4]
c0d03a88:	6066      	str	r6, [r4, #4]
c0d03a8a:	689e      	ldr	r6, [r3, #8]
c0d03a8c:	60a6      	str	r6, [r4, #8]
c0d03a8e:	68de      	ldr	r6, [r3, #12]
c0d03a90:	3310      	adds	r3, #16
c0d03a92:	60e6      	str	r6, [r4, #12]
c0d03a94:	3410      	adds	r4, #16
c0d03a96:	4299      	cmp	r1, r3
c0d03a98:	d1f3      	bne.n	c0d03a82 <memcpy+0x1e>
c0d03a9a:	230f      	movs	r3, #15
c0d03a9c:	1945      	adds	r5, r0, r5
c0d03a9e:	4013      	ands	r3, r2
c0d03aa0:	2b03      	cmp	r3, #3
c0d03aa2:	d91b      	bls.n	c0d03adc <memcpy+0x78>
c0d03aa4:	1f1c      	subs	r4, r3, #4
c0d03aa6:	2300      	movs	r3, #0
c0d03aa8:	08a4      	lsrs	r4, r4, #2
c0d03aaa:	3401      	adds	r4, #1
c0d03aac:	00a4      	lsls	r4, r4, #2
c0d03aae:	58ce      	ldr	r6, [r1, r3]
c0d03ab0:	50ee      	str	r6, [r5, r3]
c0d03ab2:	3304      	adds	r3, #4
c0d03ab4:	429c      	cmp	r4, r3
c0d03ab6:	d1fa      	bne.n	c0d03aae <memcpy+0x4a>
c0d03ab8:	2303      	movs	r3, #3
c0d03aba:	192d      	adds	r5, r5, r4
c0d03abc:	1909      	adds	r1, r1, r4
c0d03abe:	401a      	ands	r2, r3
c0d03ac0:	d005      	beq.n	c0d03ace <memcpy+0x6a>
c0d03ac2:	2300      	movs	r3, #0
c0d03ac4:	5ccc      	ldrb	r4, [r1, r3]
c0d03ac6:	54ec      	strb	r4, [r5, r3]
c0d03ac8:	3301      	adds	r3, #1
c0d03aca:	429a      	cmp	r2, r3
c0d03acc:	d1fa      	bne.n	c0d03ac4 <memcpy+0x60>
c0d03ace:	bd70      	pop	{r4, r5, r6, pc}
c0d03ad0:	0005      	movs	r5, r0
c0d03ad2:	2a00      	cmp	r2, #0
c0d03ad4:	d1f5      	bne.n	c0d03ac2 <memcpy+0x5e>
c0d03ad6:	e7fa      	b.n	c0d03ace <memcpy+0x6a>
c0d03ad8:	0005      	movs	r5, r0
c0d03ada:	e7f2      	b.n	c0d03ac2 <memcpy+0x5e>
c0d03adc:	001a      	movs	r2, r3
c0d03ade:	e7f8      	b.n	c0d03ad2 <memcpy+0x6e>

c0d03ae0 <memset>:
c0d03ae0:	b570      	push	{r4, r5, r6, lr}
c0d03ae2:	0783      	lsls	r3, r0, #30
c0d03ae4:	d03f      	beq.n	c0d03b66 <memset+0x86>
c0d03ae6:	1e54      	subs	r4, r2, #1
c0d03ae8:	2a00      	cmp	r2, #0
c0d03aea:	d03b      	beq.n	c0d03b64 <memset+0x84>
c0d03aec:	b2ce      	uxtb	r6, r1
c0d03aee:	0003      	movs	r3, r0
c0d03af0:	2503      	movs	r5, #3
c0d03af2:	e003      	b.n	c0d03afc <memset+0x1c>
c0d03af4:	1e62      	subs	r2, r4, #1
c0d03af6:	2c00      	cmp	r4, #0
c0d03af8:	d034      	beq.n	c0d03b64 <memset+0x84>
c0d03afa:	0014      	movs	r4, r2
c0d03afc:	3301      	adds	r3, #1
c0d03afe:	1e5a      	subs	r2, r3, #1
c0d03b00:	7016      	strb	r6, [r2, #0]
c0d03b02:	422b      	tst	r3, r5
c0d03b04:	d1f6      	bne.n	c0d03af4 <memset+0x14>
c0d03b06:	2c03      	cmp	r4, #3
c0d03b08:	d924      	bls.n	c0d03b54 <memset+0x74>
c0d03b0a:	25ff      	movs	r5, #255	; 0xff
c0d03b0c:	400d      	ands	r5, r1
c0d03b0e:	022a      	lsls	r2, r5, #8
c0d03b10:	4315      	orrs	r5, r2
c0d03b12:	042a      	lsls	r2, r5, #16
c0d03b14:	4315      	orrs	r5, r2
c0d03b16:	2c0f      	cmp	r4, #15
c0d03b18:	d911      	bls.n	c0d03b3e <memset+0x5e>
c0d03b1a:	0026      	movs	r6, r4
c0d03b1c:	3e10      	subs	r6, #16
c0d03b1e:	0936      	lsrs	r6, r6, #4
c0d03b20:	3601      	adds	r6, #1
c0d03b22:	0136      	lsls	r6, r6, #4
c0d03b24:	001a      	movs	r2, r3
c0d03b26:	199b      	adds	r3, r3, r6
c0d03b28:	6015      	str	r5, [r2, #0]
c0d03b2a:	6055      	str	r5, [r2, #4]
c0d03b2c:	6095      	str	r5, [r2, #8]
c0d03b2e:	60d5      	str	r5, [r2, #12]
c0d03b30:	3210      	adds	r2, #16
c0d03b32:	4293      	cmp	r3, r2
c0d03b34:	d1f8      	bne.n	c0d03b28 <memset+0x48>
c0d03b36:	220f      	movs	r2, #15
c0d03b38:	4014      	ands	r4, r2
c0d03b3a:	2c03      	cmp	r4, #3
c0d03b3c:	d90a      	bls.n	c0d03b54 <memset+0x74>
c0d03b3e:	1f26      	subs	r6, r4, #4
c0d03b40:	08b6      	lsrs	r6, r6, #2
c0d03b42:	3601      	adds	r6, #1
c0d03b44:	00b6      	lsls	r6, r6, #2
c0d03b46:	001a      	movs	r2, r3
c0d03b48:	199b      	adds	r3, r3, r6
c0d03b4a:	c220      	stmia	r2!, {r5}
c0d03b4c:	4293      	cmp	r3, r2
c0d03b4e:	d1fc      	bne.n	c0d03b4a <memset+0x6a>
c0d03b50:	2203      	movs	r2, #3
c0d03b52:	4014      	ands	r4, r2
c0d03b54:	2c00      	cmp	r4, #0
c0d03b56:	d005      	beq.n	c0d03b64 <memset+0x84>
c0d03b58:	b2c9      	uxtb	r1, r1
c0d03b5a:	191c      	adds	r4, r3, r4
c0d03b5c:	7019      	strb	r1, [r3, #0]
c0d03b5e:	3301      	adds	r3, #1
c0d03b60:	429c      	cmp	r4, r3
c0d03b62:	d1fb      	bne.n	c0d03b5c <memset+0x7c>
c0d03b64:	bd70      	pop	{r4, r5, r6, pc}
c0d03b66:	0014      	movs	r4, r2
c0d03b68:	0003      	movs	r3, r0
c0d03b6a:	e7cc      	b.n	c0d03b06 <memset+0x26>

c0d03b6c <setjmp>:
c0d03b6c:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d03b6e:	4641      	mov	r1, r8
c0d03b70:	464a      	mov	r2, r9
c0d03b72:	4653      	mov	r3, sl
c0d03b74:	465c      	mov	r4, fp
c0d03b76:	466d      	mov	r5, sp
c0d03b78:	4676      	mov	r6, lr
c0d03b7a:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d03b7c:	3828      	subs	r0, #40	; 0x28
c0d03b7e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03b80:	2000      	movs	r0, #0
c0d03b82:	4770      	bx	lr

c0d03b84 <longjmp>:
c0d03b84:	3010      	adds	r0, #16
c0d03b86:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03b88:	4690      	mov	r8, r2
c0d03b8a:	4699      	mov	r9, r3
c0d03b8c:	46a2      	mov	sl, r4
c0d03b8e:	46ab      	mov	fp, r5
c0d03b90:	46b5      	mov	sp, r6
c0d03b92:	c808      	ldmia	r0!, {r3}
c0d03b94:	3828      	subs	r0, #40	; 0x28
c0d03b96:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03b98:	1c08      	adds	r0, r1, #0
c0d03b9a:	d100      	bne.n	c0d03b9e <longjmp+0x1a>
c0d03b9c:	2001      	movs	r0, #1
c0d03b9e:	4718      	bx	r3

c0d03ba0 <strlen>:
c0d03ba0:	b510      	push	{r4, lr}
c0d03ba2:	0783      	lsls	r3, r0, #30
c0d03ba4:	d027      	beq.n	c0d03bf6 <strlen+0x56>
c0d03ba6:	7803      	ldrb	r3, [r0, #0]
c0d03ba8:	2b00      	cmp	r3, #0
c0d03baa:	d026      	beq.n	c0d03bfa <strlen+0x5a>
c0d03bac:	0003      	movs	r3, r0
c0d03bae:	2103      	movs	r1, #3
c0d03bb0:	e002      	b.n	c0d03bb8 <strlen+0x18>
c0d03bb2:	781a      	ldrb	r2, [r3, #0]
c0d03bb4:	2a00      	cmp	r2, #0
c0d03bb6:	d01c      	beq.n	c0d03bf2 <strlen+0x52>
c0d03bb8:	3301      	adds	r3, #1
c0d03bba:	420b      	tst	r3, r1
c0d03bbc:	d1f9      	bne.n	c0d03bb2 <strlen+0x12>
c0d03bbe:	6819      	ldr	r1, [r3, #0]
c0d03bc0:	4a0f      	ldr	r2, [pc, #60]	; (c0d03c00 <strlen+0x60>)
c0d03bc2:	4c10      	ldr	r4, [pc, #64]	; (c0d03c04 <strlen+0x64>)
c0d03bc4:	188a      	adds	r2, r1, r2
c0d03bc6:	438a      	bics	r2, r1
c0d03bc8:	4222      	tst	r2, r4
c0d03bca:	d10f      	bne.n	c0d03bec <strlen+0x4c>
c0d03bcc:	3304      	adds	r3, #4
c0d03bce:	6819      	ldr	r1, [r3, #0]
c0d03bd0:	4a0b      	ldr	r2, [pc, #44]	; (c0d03c00 <strlen+0x60>)
c0d03bd2:	188a      	adds	r2, r1, r2
c0d03bd4:	438a      	bics	r2, r1
c0d03bd6:	4222      	tst	r2, r4
c0d03bd8:	d108      	bne.n	c0d03bec <strlen+0x4c>
c0d03bda:	3304      	adds	r3, #4
c0d03bdc:	6819      	ldr	r1, [r3, #0]
c0d03bde:	4a08      	ldr	r2, [pc, #32]	; (c0d03c00 <strlen+0x60>)
c0d03be0:	188a      	adds	r2, r1, r2
c0d03be2:	438a      	bics	r2, r1
c0d03be4:	4222      	tst	r2, r4
c0d03be6:	d0f1      	beq.n	c0d03bcc <strlen+0x2c>
c0d03be8:	e000      	b.n	c0d03bec <strlen+0x4c>
c0d03bea:	3301      	adds	r3, #1
c0d03bec:	781a      	ldrb	r2, [r3, #0]
c0d03bee:	2a00      	cmp	r2, #0
c0d03bf0:	d1fb      	bne.n	c0d03bea <strlen+0x4a>
c0d03bf2:	1a18      	subs	r0, r3, r0
c0d03bf4:	bd10      	pop	{r4, pc}
c0d03bf6:	0003      	movs	r3, r0
c0d03bf8:	e7e1      	b.n	c0d03bbe <strlen+0x1e>
c0d03bfa:	2000      	movs	r0, #0
c0d03bfc:	e7fa      	b.n	c0d03bf4 <strlen+0x54>
c0d03bfe:	46c0      	nop			; (mov r8, r8)
c0d03c00:	fefefeff 	.word	0xfefefeff
c0d03c04:	80808080 	.word	0x80808080
c0d03c08:	58565455 	.word	0x58565455
c0d03c0c:	54545347 	.word	0x54545347
c0d03c10:	465a565a 	.word	0x465a565a
c0d03c14:	4a424f52 	.word	0x4a424f52
c0d03c18:	44484753 	.word	0x44484753
c0d03c1c:	50495a55 	.word	0x50495a55
c0d03c20:	58474551 	.word	0x58474551
c0d03c24:	45414e52 	.word	0x45414e52
c0d03c28:	48515051 	.word	0x48515051
c0d03c2c:	39424b41 	.word	0x39424b41
c0d03c30:	4c535442 	.word	0x4c535442
c0d03c34:	46564a4f 	.word	0x46564a4f
c0d03c38:	574e5642 	.word	0x574e5642
c0d03c3c:	4e534d41 	.word	0x4e534d41
c0d03c40:	5a435842 	.word	0x5a435842
c0d03c44:	48544a4c 	.word	0x48544a4c
c0d03c48:	564f4353 	.word	0x564f4353
c0d03c4c:	5241504d 	.word	0x5241504d
c0d03c50:	5158455a 	.word	0x5158455a
c0d03c54:	5845464a 	.word	0x5845464a
c0d03c58:	00000051 	.word	0x00000051

c0d03c5c <trits_mapping>:
c0d03c5c:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d03c6c:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d03c7c:	00ff0100 000000ff 00010000 0001ff00     ................
c0d03c8c:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d03c9c:	00000100 01000101 000101ff 01010101     ................
c0d03cac:	00000001                                ....

c0d03cb0 <HALF_3>:
c0d03cb0:	f16b9c2d dd01633c 3d8cf0ee b09a028b     -.k.<c.....=....
c0d03cc0:	246cd94a f1c6d805 6cee5506 da330aa3     J.l$.....U.l..3.
c0d03cd0:	fde381a1 fe13f810 f97f039e 1b3dc3ce     ..............=.
c0d03ce0:	00000001                                ....

c0d03ce4 <bagl_ui_nanos_screen1>:
c0d03ce4:	00000003 00800000 00000020 00000001     ........ .......
c0d03cf4:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03d1c:	00000107 0080000c 00000020 00000000     ........ .......
c0d03d2c:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03d54:	00030005 0007000c 00000007 00000000     ................
	...
c0d03d6c:	00070000 00000000 00000000 00000000     ................
	...
c0d03d8c:	00750005 0008000d 00000006 00000000     ..u.............
c0d03d9c:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03dc4 <bagl_ui_nanos_screen2>:
c0d03dc4:	00000003 00800000 00000020 00000001     ........ .......
c0d03dd4:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03dfc:	00000107 00800012 00000020 00000000     ........ .......
c0d03e0c:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03e34:	00030005 0007000c 00000007 00000000     ................
	...
c0d03e4c:	00070000 00000000 00000000 00000000     ................
	...
c0d03e6c:	00750005 0008000d 00000006 00000000     ..u.............
c0d03e7c:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03ea4 <bagl_ui_sample_blue>:
c0d03ea4:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03eb4:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03edc:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03eec:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03f14:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03f24:	00ffffff 001d2028 00002004 c0d03f84     ....( ... ...?..
	...
c0d03f4c:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03f5c:	0041ccb4 00f9f9f9 0000a004 c0d03f90     ..A..........?..
c0d03f6c:	00000000 0037ae99 00f9f9f9 c0d02811     ......7......(..
	...
c0d03f84:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03f95 <USBD_PRODUCT_FS_STRING>:
c0d03f95:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d03fa3 <HID_ReportDesc>:
c0d03fa3:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d03fb3:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d03fc3:	0000c008 11210900                                .....

c0d03fc8 <USBD_HID_Desc>:
c0d03fc8:	01112109 22220100 00011200                       .!...."".

c0d03fd1 <USBD_DeviceDesc>:
c0d03fd1:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03fe1:	21000103                                         ...

c0d03fe4 <HID_Desc>:
c0d03fe4:	c0d03421 c0d03431 c0d03441 c0d03451     !4..14..A4..Q4..
c0d03ff4:	c0d03461 c0d03471 c0d03481 00000000     a4..q4...4......

c0d04004 <USBD_LangIDDesc>:
c0d04004:	04090304                                ....

c0d04008 <USBD_MANUFACTURER_STRING>:
c0d04008:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d04016 <USB_SERIAL_STRING>:
c0d04016:	0030030a 00300030 33030031                       ..0.0.0.1.

c0d04020 <USBD_HID>:
c0d04020:	c0d03303 c0d03335 c0d03267 00000000     .3..53..g2......
	...
c0d04038:	c0d0336d 00000000 00000000 00000000     m3..............
c0d04048:	c0d03491 c0d03491 c0d03491 c0d034a1     .4...4...4...4..

c0d04058 <USBD_CfgDesc>:
c0d04058:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d04068:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d04078:	05070100 00400302 00000001              ......@.....

c0d04084 <USBD_DeviceQualifierDesc>:
c0d04084:	0200060a 40000000 00000001              .......@....

c0d04090 <_etext>:
	...

c0d040c0 <N_storage_real>:
	...
