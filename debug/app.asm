
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
c0d00014:	f001 fa6a 	bl	c0d014ec <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f001 f9b6 	bl	c0d01388 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 fe47 	bl	c0d03cb8 <setjmp>
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
c0d00040:	f001 fbfa 	bl	c0d01838 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f002 f8db 	bl	c0d02200 <pic>
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
c0d0005a:	f002 f8d1 	bl	c0d02200 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f002 f91f 	bl	c0d022a4 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f003 fa26 	bl	c0d034b8 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f003 fa23 	bl	c0d034b8 <USB_power>

            ui_idle();
c0d00072:	f002 fbb7 	bl	c0d027e4 <ui_idle>

            IOTA_main();
c0d00076:	f001 f81f 	bl	c0d010b8 <IOTA_main>
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
c0d0008c:	f003 fe20 	bl	c0d03cd0 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d04200 	.word	0xc0d04200

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
c0d000c8:	f003 fb3a 	bl	c0d03740 <__aeabi_uidivmod>
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
c0d000e6:	f003 faa5 	bl	c0d03634 <__aeabi_uidiv>
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
c0d00156:	f003 fa6d 	bl	c0d03634 <__aeabi_uidiv>
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
c0d0017e:	f000 fd41 	bl	c0d00c04 <kerl_initialize>
c0d00182:	2631      	movs	r6, #49	; 0x31
    kerl_absorb_trints(&seed_trints[0], 49);
c0d00184:	4628      	mov	r0, r5
c0d00186:	4631      	mov	r1, r6
c0d00188:	f000 fd76 	bl	c0d00c78 <kerl_absorb_trints>
c0d0018c:	9400      	str	r4, [sp, #0]
    kerl_squeeze_trints(&private_key[0], 49);
c0d0018e:	4620      	mov	r0, r4
c0d00190:	4631      	mov	r1, r6
c0d00192:	f000 fde1 	bl	c0d00d58 <kerl_squeeze_trints>

    kerl_initialize();
c0d00196:	f000 fd35 	bl	c0d00c04 <kerl_initialize>
    kerl_absorb_trints(&seed_trints[0], 49);
c0d0019a:	4628      	mov	r0, r5
c0d0019c:	4631      	mov	r1, r6
c0d0019e:	f000 fd6b 	bl	c0d00c78 <kerl_absorb_trints>
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
c0d001b2:	f000 fdd1 	bl	c0d00d58 <kerl_squeeze_trints>
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
c0d00206:	f000 fcfd 	bl	c0d00c04 <kerl_initialize>
c0d0020a:	2631      	movs	r6, #49	; 0x31
            kerl_absorb_trints(&private_key[j*49], 49);
c0d0020c:	4620      	mov	r0, r4
c0d0020e:	4631      	mov	r1, r6
c0d00210:	f000 fd32 	bl	c0d00c78 <kerl_absorb_trints>
            kerl_squeeze_trints(&private_key[j*49], 49);
c0d00214:	4620      	mov	r0, r4
c0d00216:	4631      	mov	r1, r6
c0d00218:	f000 fd9e 	bl	c0d00d58 <kerl_squeeze_trints>
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
c0d0022e:	f000 fce9 	bl	c0d00c04 <kerl_initialize>
    kerl_absorb_trints(private_key, 49*27); // re-absorb the entire private key
c0d00232:	4910      	ldr	r1, [pc, #64]	; (c0d00274 <generate_public_address_half+0x8c>)
c0d00234:	4630      	mov	r0, r6
c0d00236:	f000 fd1f 	bl	c0d00c78 <kerl_absorb_trints>

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
c0d0024c:	f000 fd84 	bl	c0d00d58 <kerl_squeeze_trints>

        //now get address
        kerl_initialize();
c0d00250:	f000 fcd8 	bl	c0d00c04 <kerl_initialize>
c0d00254:	9d01      	ldr	r5, [sp, #4]
        //address out stores first half, private key stores second half
        kerl_absorb_trints(address_out, 49);
c0d00256:	4628      	mov	r0, r5
c0d00258:	4621      	mov	r1, r4
c0d0025a:	f000 fd0d 	bl	c0d00c78 <kerl_absorb_trints>
        kerl_absorb_trints(private_key, 49);
c0d0025e:	4630      	mov	r0, r6
c0d00260:	4621      	mov	r1, r4
c0d00262:	f000 fd09 	bl	c0d00c78 <kerl_absorb_trints>
        //finally publish the public key
        kerl_squeeze_trints(address_out, 49);
c0d00266:	4628      	mov	r0, r5
c0d00268:	4621      	mov	r1, r4
c0d0026a:	f000 fd75 	bl	c0d00d58 <kerl_squeeze_trints>
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
c0d0029e:	f001 fd5f 	bl	c0d01d60 <snprintf>
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
    for (uint8_t i = 0; i < (num_trits / 243); i++) {
        specific_243trits_to_49trints(trits + i * 243, trints + i * 49);
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
c0d003a4:	f003 f9d0 	bl	c0d03748 <__aeabi_idiv>
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
c0d003d0:	f003 f930 	bl	c0d03634 <__aeabi_uidiv>
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
        specific_243trits_to_49trints(trits + i * 243, trints + i * 49);
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
c0d00400:	f003 f9a2 	bl	c0d03748 <__aeabi_idiv>
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
c0d00436:	f003 f8fd 	bl	c0d03634 <__aeabi_uidiv>
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
    for (uint8_t i = 0; i < (num_trints / 49); i++) {
        specific_49trints_to_243trits(trints + i * 49, trits + i * 243);
    }
}

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
c0d00472:	f003 f969 	bl	c0d03748 <__aeabi_idiv>
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
c0d004a0:	f003 f8c8 	bl	c0d03634 <__aeabi_uidiv>
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
    }

    return ret;
}

void get_seed(unsigned char *privateKey, uint8_t sz, char *msg) {
c0d004b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004ba:	af03      	add	r7, sp, #12
c0d004bc:	b0e1      	sub	sp, #388	; 0x184
c0d004be:	9201      	str	r2, [sp, #4]
  // kerl requires 424 bytes
  kerl_initialize();
c0d004c0:	f000 fba0 	bl	c0d00c04 <kerl_initialize>
c0d004c4:	ae3f      	add	r6, sp, #252	; 0xfc
c0d004c6:	2551      	movs	r5, #81	; 0x51
  //   // absorb these bytes
  //   kerl_absorb_bytes(&bytes_in[0], 48);
  // }

  trint_t seed_trints[49];
  tryte_t seed_trytes[81] = {0};
c0d004c8:	4630      	mov	r0, r6
c0d004ca:	4629      	mov	r1, r5
c0d004cc:	f003 fb5e 	bl	c0d03b8c <__aeabi_memclr>
c0d004d0:	ac02      	add	r4, sp, #8
  {
    char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d004d2:	4910      	ldr	r1, [pc, #64]	; (c0d00514 <get_seed+0x5c>)
c0d004d4:	4479      	add	r1, pc
c0d004d6:	2252      	movs	r2, #82	; 0x52
c0d004d8:	4620      	mov	r0, r4
c0d004da:	f003 fb5d 	bl	c0d03b98 <__aeabi_memcpy>
    chars_to_trytes(test_kerl, seed_trytes, 81);
c0d004de:	4620      	mov	r0, r4
c0d004e0:	4631      	mov	r1, r6
c0d004e2:	462a      	mov	r2, r5
c0d004e4:	f000 fa2a 	bl	c0d0093c <chars_to_trytes>
c0d004e8:	ac02      	add	r4, sp, #8
  }
  {
    trit_t seed_trits[81 * 3] = {0};
c0d004ea:	21f3      	movs	r1, #243	; 0xf3
c0d004ec:	4620      	mov	r0, r4
c0d004ee:	f003 fb4d 	bl	c0d03b8c <__aeabi_memclr>
    trytes_to_trits(seed_trytes, seed_trits, 81);
c0d004f2:	4630      	mov	r0, r6
c0d004f4:	4621      	mov	r1, r4
c0d004f6:	462a      	mov	r2, r5
c0d004f8:	f000 fa02 	bl	c0d00900 <trytes_to_trits>
c0d004fc:	ad54      	add	r5, sp, #336	; 0x150
    specific_243trits_to_49trints(seed_trits, seed_trints);
c0d004fe:	4620      	mov	r0, r4
c0d00500:	4629      	mov	r1, r5
c0d00502:	f7ff fed7 	bl	c0d002b4 <specific_243trits_to_49trints>
  }
  // kerl_squeeze_trints(&seed_trints[0], 49);
  get_private_key(seed_trints, 0, msg);
c0d00506:	2100      	movs	r1, #0
c0d00508:	4628      	mov	r0, r5
c0d0050a:	9a01      	ldr	r2, [sp, #4]
c0d0050c:	f000 f804 	bl	c0d00518 <get_private_key>
}
c0d00510:	b061      	add	sp, #388	; 0x184
c0d00512:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00514:	0000387c 	.word	0x0000387c

c0d00518 <get_private_key>:

//write func to get private key
void get_private_key(trint_t *seed_trints, uint32_t idx, char *msg) {
c0d00518:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0051a:	af03      	add	r7, sp, #12
c0d0051c:	b0ff      	sub	sp, #508	; 0x1fc
c0d0051e:	b0ff      	sub	sp, #508	; 0x1fc
c0d00520:	b0f3      	sub	sp, #460	; 0x1cc
    { // localize the memory for private key
        //currently able to store 31 - [-1][-1][-1][0][-1]
        trint_t private_key_trints[49 * 27]; //trints are still just int8_t but encoded

        //generate private key using level 1 for first half
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 1, msg);
c0d00522:	ab01      	add	r3, sp, #4
c0d00524:	c307      	stmia	r3!, {r0, r1, r2}
c0d00526:	466b      	mov	r3, sp
c0d00528:	601a      	str	r2, [r3, #0]
c0d0052a:	ad19      	add	r5, sp, #100	; 0x64
c0d0052c:	2601      	movs	r6, #1
c0d0052e:	462a      	mov	r2, r5
c0d00530:	4633      	mov	r3, r6
c0d00532:	f7ff fe1c 	bl	c0d0016e <generate_private_key_half>
c0d00536:	4c17      	ldr	r4, [pc, #92]	; (c0d00594 <get_private_key+0x7c>)
c0d00538:	446c      	add	r4, sp
        //use this half to generate half public key 1
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 1);
c0d0053a:	4628      	mov	r0, r5
c0d0053c:	4621      	mov	r1, r4
c0d0053e:	4632      	mov	r2, r6
c0d00540:	f7ff fe52 	bl	c0d001e8 <generate_public_address_half>

        //use level 2 to generate second half of private key
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 2, msg);
c0d00544:	4668      	mov	r0, sp
c0d00546:	9903      	ldr	r1, [sp, #12]
c0d00548:	6001      	str	r1, [r0, #0]
c0d0054a:	2602      	movs	r6, #2
c0d0054c:	9801      	ldr	r0, [sp, #4]
c0d0054e:	9902      	ldr	r1, [sp, #8]
c0d00550:	462a      	mov	r2, r5
c0d00552:	4633      	mov	r3, r6
c0d00554:	f7ff fe0b 	bl	c0d0016e <generate_private_key_half>

        //finally level 2 to generate second half of public key (and then digests both)
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 2);
c0d00558:	4628      	mov	r0, r5
c0d0055a:	4621      	mov	r1, r4
c0d0055c:	4632      	mov	r2, r6
c0d0055e:	f7ff fe43 	bl	c0d001e8 <generate_public_address_half>
c0d00562:	ad19      	add	r5, sp, #100	; 0x64
    }
    // 12s to get here if k=25, 2min otherwise
    //now public key will hold the actual public address
    trit_t pub_trits[243];
    specific_49trints_to_243trits(&public_key_trints[0], &pub_trits[0]);
c0d00564:	4620      	mov	r0, r4
c0d00566:	4629      	mov	r1, r5
c0d00568:	f7ff ff02 	bl	c0d00370 <specific_49trints_to_243trits>
c0d0056c:	ac04      	add	r4, sp, #16

    tryte_t seed_trytes[81];
    trits_to_trytes(pub_trits, seed_trytes, 243);
c0d0056e:	22f3      	movs	r2, #243	; 0xf3
c0d00570:	4628      	mov	r0, r5
c0d00572:	4621      	mov	r1, r4
c0d00574:	f000 f98e 	bl	c0d00894 <trits_to_trytes>
c0d00578:	2551      	movs	r5, #81	; 0x51

    trytes_to_chars(seed_trytes, msg, 81);
c0d0057a:	4620      	mov	r0, r4
c0d0057c:	9c03      	ldr	r4, [sp, #12]
c0d0057e:	4621      	mov	r1, r4
c0d00580:	462a      	mov	r2, r5
c0d00582:	f000 f9f1 	bl	c0d00968 <trytes_to_chars>

    //null terminate the public key
    msg[81] = '\0';
c0d00586:	2000      	movs	r0, #0
c0d00588:	5560      	strb	r0, [r4, r5]
}
c0d0058a:	1ffc      	subs	r4, r7, #7
c0d0058c:	3c05      	subs	r4, #5
c0d0058e:	46a5      	mov	sp, r4
c0d00590:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00592:	46c0      	nop			; (mov r8, r8)
c0d00594:	00000590 	.word	0x00000590

c0d00598 <bigint_add_intarr_u_mem>:
    }
    return i;
}*/

int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
c0d00598:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0059a:	af03      	add	r7, sp, #12
c0d0059c:	b087      	sub	sp, #28
c0d0059e:	2300      	movs	r3, #0
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d005a0:	2a00      	cmp	r2, #0
c0d005a2:	d03b      	beq.n	c0d0061c <bigint_add_intarr_u_mem+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005a4:	2500      	movs	r5, #0
c0d005a6:	43ec      	mvns	r4, r5
c0d005a8:	9200      	str	r2, [sp, #0]
c0d005aa:	4613      	mov	r3, r2
c0d005ac:	9502      	str	r5, [sp, #8]
int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add_u(bigint_in[i], int_in[i], val.hi);
c0d005ae:	9401      	str	r4, [sp, #4]
c0d005b0:	9304      	str	r3, [sp, #16]
c0d005b2:	9005      	str	r0, [sp, #20]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d005b4:	6802      	ldr	r2, [r0, #0]
c0d005b6:	c908      	ldmia	r1!, {r3}
c0d005b8:	9106      	str	r1, [sp, #24]
c0d005ba:	1898      	adds	r0, r3, r2
c0d005bc:	9902      	ldr	r1, [sp, #8]
c0d005be:	460b      	mov	r3, r1
c0d005c0:	415b      	adcs	r3, r3
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d005c2:	4602      	mov	r2, r0
c0d005c4:	4022      	ands	r2, r4
c0d005c6:	1c52      	adds	r2, r2, #1
c0d005c8:	4626      	mov	r6, r4
c0d005ca:	460c      	mov	r4, r1
c0d005cc:	4611      	mov	r1, r2
c0d005ce:	4164      	adcs	r4, r4
c0d005d0:	2201      	movs	r2, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
c0d005d2:	4015      	ands	r5, r2
c0d005d4:	2d00      	cmp	r5, #0
c0d005d6:	d100      	bne.n	c0d005da <bigint_add_intarr_u_mem+0x42>
c0d005d8:	4601      	mov	r1, r0
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005da:	42b1      	cmp	r1, r6
c0d005dc:	4616      	mov	r6, r2
c0d005de:	d800      	bhi.n	c0d005e2 <bigint_add_intarr_u_mem+0x4a>
c0d005e0:	9e02      	ldr	r6, [sp, #8]
c0d005e2:	9103      	str	r1, [sp, #12]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
c0d005e4:	2d00      	cmp	r5, #0
c0d005e6:	9805      	ldr	r0, [sp, #20]
c0d005e8:	d100      	bne.n	c0d005ec <bigint_add_intarr_u_mem+0x54>
c0d005ea:	461c      	mov	r4, r3
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005ec:	2c00      	cmp	r4, #0
c0d005ee:	4611      	mov	r1, r2
c0d005f0:	d100      	bne.n	c0d005f4 <bigint_add_intarr_u_mem+0x5c>
c0d005f2:	4621      	mov	r1, r4
c0d005f4:	2c00      	cmp	r4, #0
c0d005f6:	d000      	beq.n	c0d005fa <bigint_add_intarr_u_mem+0x62>
c0d005f8:	460e      	mov	r6, r1
    struct int_bool_pair ret = { (uint32_t)r, carry1 || carry2 };
c0d005fa:	431e      	orrs	r6, r3

int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d005fc:	2e00      	cmp	r6, #0
c0d005fe:	9906      	ldr	r1, [sp, #24]
c0d00600:	9c01      	ldr	r4, [sp, #4]
c0d00602:	d100      	bne.n	c0d00606 <bigint_add_intarr_u_mem+0x6e>
c0d00604:	4632      	mov	r2, r6
        val = full_add_u(bigint_in[i], int_in[i], val.hi);
        bigint_in[i] = val.low;
c0d00606:	9b03      	ldr	r3, [sp, #12]
c0d00608:	c008      	stmia	r0!, {r3}
c0d0060a:	9b04      	ldr	r3, [sp, #16]

int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d0060c:	1e5b      	subs	r3, r3, #1
c0d0060e:	4615      	mov	r5, r2
c0d00610:	d1ce      	bne.n	c0d005b0 <bigint_add_intarr_u_mem+0x18>
c0d00612:	2000      	movs	r0, #0
c0d00614:	43c3      	mvns	r3, r0
c0d00616:	2e00      	cmp	r6, #0
c0d00618:	d100      	bne.n	c0d0061c <bigint_add_intarr_u_mem+0x84>
c0d0061a:	9b00      	ldr	r3, [sp, #0]

    if (val.hi) {
        return -1;
    }
    return len;
}
c0d0061c:	4618      	mov	r0, r3
c0d0061e:	b007      	add	sp, #28
c0d00620:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00622 <bigint_add_int_u_mem>:
    return len;
}

//memory optimized for add in place
int bigint_add_int_u_mem(uint32_t *bigint_in, uint32_t int_in, uint8_t len)
{
c0d00622:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00624:	af03      	add	r7, sp, #12
c0d00626:	b083      	sub	sp, #12

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00628:	6803      	ldr	r3, [r0, #0]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0062a:	2600      	movs	r6, #0

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0062c:	1859      	adds	r1, r3, r1
c0d0062e:	4633      	mov	r3, r6
c0d00630:	415b      	adcs	r3, r3
c0d00632:	9001      	str	r0, [sp, #4]
{
    struct int_bool_pair val;

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;
c0d00634:	6001      	str	r1, [r0, #0]
c0d00636:	2101      	movs	r1, #1
c0d00638:	2b00      	cmp	r3, #0
c0d0063a:	d100      	bne.n	c0d0063e <bigint_add_int_u_mem+0x1c>
c0d0063c:	4619      	mov	r1, r3
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0063e:	43f0      	mvns	r0, r6

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;

    for (uint8_t i = 1; i < len; i++) {
c0d00640:	9002      	str	r0, [sp, #8]
c0d00642:	2a02      	cmp	r2, #2
c0d00644:	d31b      	bcc.n	c0d0067e <bigint_add_int_u_mem+0x5c>
c0d00646:	2301      	movs	r3, #1
c0d00648:	9200      	str	r2, [sp, #0]
        // only continue adding, if there is a carry bit
        if (!val.hi) {
c0d0064a:	07c9      	lsls	r1, r1, #31
c0d0064c:	d01d      	beq.n	c0d0068a <bigint_add_int_u_mem+0x68>
            return i;
        }
        val = full_add_u(bigint_in[i], 0, true);
c0d0064e:	0099      	lsls	r1, r3, #2
c0d00650:	9801      	ldr	r0, [sp, #4]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00652:	5845      	ldr	r5, [r0, r1]
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00654:	1c6a      	adds	r2, r5, #1
c0d00656:	4634      	mov	r4, r6
c0d00658:	4176      	adcs	r6, r6
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            return i;
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_in[i] = val.low;
c0d0065a:	5042      	str	r2, [r0, r1]
c0d0065c:	2501      	movs	r5, #1
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0065e:	9802      	ldr	r0, [sp, #8]
c0d00660:	4282      	cmp	r2, r0
c0d00662:	4629      	mov	r1, r5
c0d00664:	d800      	bhi.n	c0d00668 <bigint_add_int_u_mem+0x46>
c0d00666:	4621      	mov	r1, r4
c0d00668:	2e00      	cmp	r6, #0
c0d0066a:	d100      	bne.n	c0d0066e <bigint_add_int_u_mem+0x4c>
c0d0066c:	4635      	mov	r5, r6
c0d0066e:	2e00      	cmp	r6, #0
c0d00670:	d000      	beq.n	c0d00674 <bigint_add_int_u_mem+0x52>
c0d00672:	4629      	mov	r1, r5

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;

    for (uint8_t i = 1; i < len; i++) {
c0d00674:	1c5b      	adds	r3, r3, #1
c0d00676:	9a00      	ldr	r2, [sp, #0]
c0d00678:	4293      	cmp	r3, r2
c0d0067a:	4626      	mov	r6, r4
c0d0067c:	d3e5      	bcc.n	c0d0064a <bigint_add_int_u_mem+0x28>
        val = full_add_u(bigint_in[i], 0, true);
        bigint_in[i] = val.low;
    }

    // detect overflow
    if (val.hi) {
c0d0067e:	2900      	cmp	r1, #0
c0d00680:	d100      	bne.n	c0d00684 <bigint_add_int_u_mem+0x62>
c0d00682:	9202      	str	r2, [sp, #8]
c0d00684:	9802      	ldr	r0, [sp, #8]
c0d00686:	b003      	add	sp, #12
c0d00688:	bdf0      	pop	{r4, r5, r6, r7, pc}
        return -1;
    }
    return len;
}
c0d0068a:	4618      	mov	r0, r3
c0d0068c:	b003      	add	sp, #12
c0d0068e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00690 <bigint_add_int_u>:

int bigint_add_int_u(uint32_t bigint_in[], uint32_t int_in, uint32_t bigint_out[], uint8_t len)
{
c0d00690:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00692:	af03      	add	r7, sp, #12
c0d00694:	b085      	sub	sp, #20
c0d00696:	9303      	str	r3, [sp, #12]
c0d00698:	9001      	str	r0, [sp, #4]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0069a:	6800      	ldr	r0, [r0, #0]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0069c:	2400      	movs	r4, #0

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0069e:	1840      	adds	r0, r0, r1
c0d006a0:	4623      	mov	r3, r4
c0d006a2:	415b      	adcs	r3, r3
c0d006a4:	9202      	str	r2, [sp, #8]
    struct int_bool_pair val;
    uint8_t i;

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;
c0d006a6:	6010      	str	r0, [r2, #0]

    i = 1;
    for (; i < len; i++) {
c0d006a8:	2601      	movs	r6, #1
c0d006aa:	2b00      	cmp	r3, #0
c0d006ac:	4631      	mov	r1, r6
c0d006ae:	d000      	beq.n	c0d006b2 <bigint_add_int_u+0x22>
c0d006b0:	4621      	mov	r1, r4
c0d006b2:	2b00      	cmp	r3, #0
c0d006b4:	4635      	mov	r5, r6
c0d006b6:	d100      	bne.n	c0d006ba <bigint_add_int_u+0x2a>
c0d006b8:	461d      	mov	r5, r3
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d006ba:	43e0      	mvns	r0, r4
    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;

    i = 1;
    for (; i < len; i++) {
c0d006bc:	9000      	str	r0, [sp, #0]
c0d006be:	9803      	ldr	r0, [sp, #12]
c0d006c0:	2802      	cmp	r0, #2
c0d006c2:	d323      	bcc.n	c0d0070c <bigint_add_int_u+0x7c>
c0d006c4:	2900      	cmp	r1, #0
c0d006c6:	d121      	bne.n	c0d0070c <bigint_add_int_u+0x7c>
c0d006c8:	2101      	movs	r1, #1
c0d006ca:	9104      	str	r1, [sp, #16]
c0d006cc:	4634      	mov	r4, r6
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            break;
        }
        val = full_add_u(bigint_in[i], 0, true);
c0d006ce:	008d      	lsls	r5, r1, #2

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d006d0:	9801      	ldr	r0, [sp, #4]
c0d006d2:	5943      	ldr	r3, [r0, r5]
c0d006d4:	2200      	movs	r2, #0
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d006d6:	1c58      	adds	r0, r3, #1
c0d006d8:	4613      	mov	r3, r2
c0d006da:	415b      	adcs	r3, r3
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            break;
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
c0d006dc:	9e02      	ldr	r6, [sp, #8]
c0d006de:	5170      	str	r0, [r6, r5]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d006e0:	9d00      	ldr	r5, [sp, #0]
c0d006e2:	42a8      	cmp	r0, r5
c0d006e4:	9d04      	ldr	r5, [sp, #16]
c0d006e6:	d800      	bhi.n	c0d006ea <bigint_add_int_u+0x5a>
c0d006e8:	4615      	mov	r5, r2
c0d006ea:	2b00      	cmp	r3, #0
c0d006ec:	9a04      	ldr	r2, [sp, #16]
c0d006ee:	d100      	bne.n	c0d006f2 <bigint_add_int_u+0x62>
c0d006f0:	461a      	mov	r2, r3
c0d006f2:	2b00      	cmp	r3, #0
c0d006f4:	4626      	mov	r6, r4
c0d006f6:	d000      	beq.n	c0d006fa <bigint_add_int_u+0x6a>
c0d006f8:	4615      	mov	r5, r2
    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;

    i = 1;
    for (; i < len; i++) {
c0d006fa:	462a      	mov	r2, r5
c0d006fc:	4072      	eors	r2, r6
c0d006fe:	1c49      	adds	r1, r1, #1
c0d00700:	9803      	ldr	r0, [sp, #12]
c0d00702:	4281      	cmp	r1, r0
c0d00704:	d203      	bcs.n	c0d0070e <bigint_add_int_u+0x7e>
c0d00706:	2a00      	cmp	r2, #0
c0d00708:	d0e0      	beq.n	c0d006cc <bigint_add_int_u+0x3c>
c0d0070a:	e000      	b.n	c0d0070e <bigint_add_int_u+0x7e>
c0d0070c:	4631      	mov	r1, r6
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
    }
    // copy the remaining words
    for (uint8_t j = i; j < len; j++) {
c0d0070e:	b2cb      	uxtb	r3, r1
c0d00710:	9803      	ldr	r0, [sp, #12]
c0d00712:	4283      	cmp	r3, r0
c0d00714:	d20a      	bcs.n	c0d0072c <bigint_add_int_u+0x9c>
        bigint_out[j] = bigint_in[j];
c0d00716:	9803      	ldr	r0, [sp, #12]
c0d00718:	1ac4      	subs	r4, r0, r3
c0d0071a:	009a      	lsls	r2, r3, #2
c0d0071c:	9801      	ldr	r0, [sp, #4]
c0d0071e:	1880      	adds	r0, r0, r2
c0d00720:	9e02      	ldr	r6, [sp, #8]
c0d00722:	18b2      	adds	r2, r6, r2
c0d00724:	c840      	ldmia	r0!, {r6}
c0d00726:	c240      	stmia	r2!, {r6}
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
    }
    // copy the remaining words
    for (uint8_t j = i; j < len; j++) {
c0d00728:	1e64      	subs	r4, r4, #1
c0d0072a:	d1fb      	bne.n	c0d00724 <bigint_add_int_u+0x94>
        bigint_out[j] = bigint_in[j];
    }

    if (val.hi && i == len) {
c0d0072c:	2000      	movs	r0, #0
c0d0072e:	43c0      	mvns	r0, r0
c0d00730:	9a03      	ldr	r2, [sp, #12]
c0d00732:	4293      	cmp	r3, r2
c0d00734:	d000      	beq.n	c0d00738 <bigint_add_int_u+0xa8>
c0d00736:	4608      	mov	r0, r1
c0d00738:	2d00      	cmp	r5, #0
c0d0073a:	d100      	bne.n	c0d0073e <bigint_add_int_u+0xae>
c0d0073c:	4608      	mov	r0, r1
        return -1;
    }
    return i;
}
c0d0073e:	b005      	add	sp, #20
c0d00740:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00742 <bigint_sub_bigint_u_mem>:
    return len;
}

//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
c0d00742:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00744:	af03      	add	r7, sp, #12
c0d00746:	b086      	sub	sp, #24
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00748:	2a00      	cmp	r2, #0
c0d0074a:	d037      	beq.n	c0d007bc <bigint_sub_bigint_u_mem+0x7a>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0074c:	2300      	movs	r3, #0
c0d0074e:	9300      	str	r3, [sp, #0]
c0d00750:	43de      	mvns	r6, r3
c0d00752:	2501      	movs	r5, #1
c0d00754:	9505      	str	r5, [sp, #20]
c0d00756:	9203      	str	r2, [sp, #12]
c0d00758:	9001      	str	r0, [sp, #4]
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0075a:	6804      	ldr	r4, [r0, #0]
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d0075c:	c908      	ldmia	r1!, {r3}
c0d0075e:	9104      	str	r1, [sp, #16]
c0d00760:	43db      	mvns	r3, r3
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00762:	1918      	adds	r0, r3, r4
c0d00764:	4633      	mov	r3, r6
c0d00766:	9e00      	ldr	r6, [sp, #0]
c0d00768:	4632      	mov	r2, r6
c0d0076a:	4152      	adcs	r2, r2
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d0076c:	4601      	mov	r1, r0
c0d0076e:	4019      	ands	r1, r3
c0d00770:	1c4c      	adds	r4, r1, #1
c0d00772:	4631      	mov	r1, r6
c0d00774:	4149      	adcs	r1, r1
c0d00776:	9e05      	ldr	r6, [sp, #20]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00778:	4035      	ands	r5, r6
c0d0077a:	2d00      	cmp	r5, #0
c0d0077c:	d100      	bne.n	c0d00780 <bigint_sub_bigint_u_mem+0x3e>
c0d0077e:	4604      	mov	r4, r0
c0d00780:	9402      	str	r4, [sp, #8]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00782:	429c      	cmp	r4, r3
c0d00784:	4634      	mov	r4, r6
c0d00786:	461e      	mov	r6, r3
c0d00788:	d800      	bhi.n	c0d0078c <bigint_sub_bigint_u_mem+0x4a>
c0d0078a:	9c00      	ldr	r4, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0078c:	2d00      	cmp	r5, #0
c0d0078e:	d100      	bne.n	c0d00792 <bigint_sub_bigint_u_mem+0x50>
c0d00790:	4611      	mov	r1, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00792:	2900      	cmp	r1, #0
c0d00794:	9b05      	ldr	r3, [sp, #20]
c0d00796:	461d      	mov	r5, r3
c0d00798:	d100      	bne.n	c0d0079c <bigint_sub_bigint_u_mem+0x5a>
c0d0079a:	460d      	mov	r5, r1
c0d0079c:	2900      	cmp	r1, #0
c0d0079e:	d000      	beq.n	c0d007a2 <bigint_sub_bigint_u_mem+0x60>
c0d007a0:	462c      	mov	r4, r5
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d007a2:	4314      	orrs	r4, r2
//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d007a4:	2c00      	cmp	r4, #0
c0d007a6:	461d      	mov	r5, r3
c0d007a8:	9802      	ldr	r0, [sp, #8]
c0d007aa:	d100      	bne.n	c0d007ae <bigint_sub_bigint_u_mem+0x6c>
c0d007ac:	4625      	mov	r5, r4
c0d007ae:	9901      	ldr	r1, [sp, #4]
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_one[i] = val.low;
c0d007b0:	c101      	stmia	r1!, {r0}
c0d007b2:	4608      	mov	r0, r1
c0d007b4:	9a03      	ldr	r2, [sp, #12]
//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d007b6:	1e52      	subs	r2, r2, #1
c0d007b8:	9904      	ldr	r1, [sp, #16]
c0d007ba:	d1cc      	bne.n	c0d00756 <bigint_sub_bigint_u_mem+0x14>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_one[i] = val.low;
    }
    return 0;
c0d007bc:	2000      	movs	r0, #0
c0d007be:	b006      	add	sp, #24
c0d007c0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d007c2 <bigint_sub_bigint_u>:
}

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
c0d007c2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007c4:	af03      	add	r7, sp, #12
c0d007c6:	b087      	sub	sp, #28
c0d007c8:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d007ca:	2d00      	cmp	r5, #0
c0d007cc:	d037      	beq.n	c0d0083e <bigint_sub_bigint_u+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d007ce:	2400      	movs	r4, #0
c0d007d0:	9402      	str	r4, [sp, #8]
c0d007d2:	43e3      	mvns	r3, r4
c0d007d4:	9301      	str	r3, [sp, #4]
c0d007d6:	2601      	movs	r6, #1
c0d007d8:	9600      	str	r6, [sp, #0]
c0d007da:	9203      	str	r2, [sp, #12]
c0d007dc:	9504      	str	r5, [sp, #16]
c0d007de:	4604      	mov	r4, r0
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d007e0:	cc01      	ldmia	r4!, {r0}
c0d007e2:	9405      	str	r4, [sp, #20]
c0d007e4:	460c      	mov	r4, r1
int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d007e6:	cc02      	ldmia	r4!, {r1}
c0d007e8:	9406      	str	r4, [sp, #24]
c0d007ea:	43c9      	mvns	r1, r1
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d007ec:	180a      	adds	r2, r1, r0
c0d007ee:	9902      	ldr	r1, [sp, #8]
c0d007f0:	460c      	mov	r4, r1
c0d007f2:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d007f4:	4610      	mov	r0, r2
c0d007f6:	9d01      	ldr	r5, [sp, #4]
c0d007f8:	4028      	ands	r0, r5
c0d007fa:	1c43      	adds	r3, r0, #1
c0d007fc:	4608      	mov	r0, r1
c0d007fe:	4140      	adcs	r0, r0
c0d00800:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00802:	400e      	ands	r6, r1
c0d00804:	2e00      	cmp	r6, #0
c0d00806:	d100      	bne.n	c0d0080a <bigint_sub_bigint_u+0x48>
c0d00808:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0080a:	42ab      	cmp	r3, r5
c0d0080c:	460d      	mov	r5, r1
c0d0080e:	d800      	bhi.n	c0d00812 <bigint_sub_bigint_u+0x50>
c0d00810:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00812:	2e00      	cmp	r6, #0
c0d00814:	9a03      	ldr	r2, [sp, #12]
c0d00816:	d100      	bne.n	c0d0081a <bigint_sub_bigint_u+0x58>
c0d00818:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0081a:	2800      	cmp	r0, #0
c0d0081c:	460e      	mov	r6, r1
c0d0081e:	d100      	bne.n	c0d00822 <bigint_sub_bigint_u+0x60>
c0d00820:	4606      	mov	r6, r0
c0d00822:	2800      	cmp	r0, #0
c0d00824:	d000      	beq.n	c0d00828 <bigint_sub_bigint_u+0x66>
c0d00826:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d00828:	4325      	orrs	r5, r4

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0082a:	2d00      	cmp	r5, #0
c0d0082c:	460e      	mov	r6, r1
c0d0082e:	9805      	ldr	r0, [sp, #20]
c0d00830:	d100      	bne.n	c0d00834 <bigint_sub_bigint_u+0x72>
c0d00832:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d00834:	c208      	stmia	r2!, {r3}
c0d00836:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00838:	1e6d      	subs	r5, r5, #1
c0d0083a:	9906      	ldr	r1, [sp, #24]
c0d0083c:	d1cd      	bne.n	c0d007da <bigint_sub_bigint_u+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d0083e:	2000      	movs	r0, #0
c0d00840:	b007      	add	sp, #28
c0d00842:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00844 <bigint_cmp_bigint_u>:
    }
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
c0d00844:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00846:	af03      	add	r7, sp, #12
c0d00848:	b081      	sub	sp, #4
c0d0084a:	2400      	movs	r4, #0
c0d0084c:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d0084e:	32ff      	adds	r2, #255	; 0xff
c0d00850:	b253      	sxtb	r3, r2
c0d00852:	2b00      	cmp	r3, #0
c0d00854:	db0f      	blt.n	c0d00876 <bigint_cmp_bigint_u+0x32>
c0d00856:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d00858:	009b      	lsls	r3, r3, #2
c0d0085a:	58ce      	ldr	r6, [r1, r3]
c0d0085c:	58c4      	ldr	r4, [r0, r3]
c0d0085e:	2301      	movs	r3, #1
c0d00860:	42b4      	cmp	r4, r6
c0d00862:	d80b      	bhi.n	c0d0087c <bigint_cmp_bigint_u+0x38>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00864:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d00866:	42b4      	cmp	r4, r6
c0d00868:	d307      	bcc.n	c0d0087a <bigint_cmp_bigint_u+0x36>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d0086a:	b253      	sxtb	r3, r2
c0d0086c:	42ab      	cmp	r3, r5
c0d0086e:	461a      	mov	r2, r3
c0d00870:	dcf2      	bgt.n	c0d00858 <bigint_cmp_bigint_u+0x14>
c0d00872:	9b00      	ldr	r3, [sp, #0]
c0d00874:	e002      	b.n	c0d0087c <bigint_cmp_bigint_u+0x38>
c0d00876:	4623      	mov	r3, r4
c0d00878:	e000      	b.n	c0d0087c <bigint_cmp_bigint_u+0x38>
c0d0087a:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d0087c:	4618      	mov	r0, r3
c0d0087e:	b001      	add	sp, #4
c0d00880:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00882 <bigint_not_u>:
    return 0;
}

int bigint_not_u(uint32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00882:	2900      	cmp	r1, #0
c0d00884:	d004      	beq.n	c0d00890 <bigint_not_u+0xe>
        bigint[i] = ~bigint[i];
c0d00886:	6802      	ldr	r2, [r0, #0]
c0d00888:	43d2      	mvns	r2, r2
c0d0088a:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not_u(uint32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0088c:	1e49      	subs	r1, r1, #1
c0d0088e:	d1fa      	bne.n	c0d00886 <bigint_not_u+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d00890:	2000      	movs	r0, #0
c0d00892:	4770      	bx	lr

c0d00894 <trits_to_trytes>:
    0x1B3DC3CE,
    0x00000001};

static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";
int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len)
{
c0d00894:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00896:	af03      	add	r7, sp, #12
c0d00898:	b083      	sub	sp, #12
c0d0089a:	4616      	mov	r6, r2
c0d0089c:	460c      	mov	r4, r1
c0d0089e:	4605      	mov	r5, r0
    if (trit_len % 3 != 0) {
c0d008a0:	2103      	movs	r1, #3
c0d008a2:	4630      	mov	r0, r6
c0d008a4:	f002 ff4c 	bl	c0d03740 <__aeabi_uidivmod>
c0d008a8:	2000      	movs	r0, #0
c0d008aa:	43c2      	mvns	r2, r0
c0d008ac:	2900      	cmp	r1, #0
c0d008ae:	d123      	bne.n	c0d008f8 <trits_to_trytes+0x64>
c0d008b0:	9502      	str	r5, [sp, #8]
c0d008b2:	4635      	mov	r5, r6
c0d008b4:	2603      	movs	r6, #3
c0d008b6:	9001      	str	r0, [sp, #4]
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;
c0d008b8:	4628      	mov	r0, r5
c0d008ba:	4631      	mov	r1, r6
c0d008bc:	f002 feba 	bl	c0d03634 <__aeabi_uidiv>

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d008c0:	2d03      	cmp	r5, #3
c0d008c2:	9a01      	ldr	r2, [sp, #4]
c0d008c4:	d318      	bcc.n	c0d008f8 <trits_to_trytes+0x64>
c0d008c6:	2200      	movs	r2, #0
c0d008c8:	9200      	str	r2, [sp, #0]
c0d008ca:	9601      	str	r6, [sp, #4]
c0d008cc:	9e01      	ldr	r6, [sp, #4]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
c0d008ce:	4633      	mov	r3, r6
c0d008d0:	4353      	muls	r3, r2
c0d008d2:	4625      	mov	r5, r4
c0d008d4:	9902      	ldr	r1, [sp, #8]
c0d008d6:	5ccc      	ldrb	r4, [r1, r3]
c0d008d8:	18cb      	adds	r3, r1, r3
c0d008da:	2101      	movs	r1, #1
c0d008dc:	5659      	ldrsb	r1, [r3, r1]
c0d008de:	4371      	muls	r1, r6
c0d008e0:	1909      	adds	r1, r1, r4
c0d008e2:	2402      	movs	r4, #2
c0d008e4:	571b      	ldrsb	r3, [r3, r4]
c0d008e6:	2409      	movs	r4, #9
c0d008e8:	435c      	muls	r4, r3
c0d008ea:	1909      	adds	r1, r1, r4
c0d008ec:	462c      	mov	r4, r5
c0d008ee:	54a1      	strb	r1, [r4, r2]
    if (trit_len % 3 != 0) {
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d008f0:	1c52      	adds	r2, r2, #1
c0d008f2:	4282      	cmp	r2, r0
c0d008f4:	d3eb      	bcc.n	c0d008ce <trits_to_trytes+0x3a>
c0d008f6:	9a00      	ldr	r2, [sp, #0]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
    }
    return 0;
}
c0d008f8:	4610      	mov	r0, r2
c0d008fa:	b003      	add	sp, #12
c0d008fc:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00900 <trytes_to_trits>:

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
c0d00900:	b5b0      	push	{r4, r5, r7, lr}
c0d00902:	af02      	add	r7, sp, #8
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00904:	2a00      	cmp	r2, #0
c0d00906:	d015      	beq.n	c0d00934 <trytes_to_trits+0x34>
c0d00908:	4b0b      	ldr	r3, [pc, #44]	; (c0d00938 <trytes_to_trits+0x38>)
c0d0090a:	447b      	add	r3, pc
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d0090c:	240d      	movs	r4, #13
c0d0090e:	0624      	lsls	r4, r4, #24
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
c0d00910:	7805      	ldrb	r5, [r0, #0]
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00912:	062d      	lsls	r5, r5, #24
c0d00914:	192c      	adds	r4, r5, r4
c0d00916:	1624      	asrs	r4, r4, #24
c0d00918:	2503      	movs	r5, #3
c0d0091a:	4365      	muls	r5, r4
c0d0091c:	5d5c      	ldrb	r4, [r3, r5]
c0d0091e:	700c      	strb	r4, [r1, #0]
c0d00920:	195c      	adds	r4, r3, r5
        trits_out[i*3+1] = trits_mapping[idx][1];
c0d00922:	7865      	ldrb	r5, [r4, #1]
c0d00924:	704d      	strb	r5, [r1, #1]
        trits_out[i*3+2] = trits_mapping[idx][2];
c0d00926:	78a4      	ldrb	r4, [r4, #2]
c0d00928:	708c      	strb	r4, [r1, #2]
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d0092a:	1e52      	subs	r2, r2, #1
c0d0092c:	1cc9      	adds	r1, r1, #3
c0d0092e:	1c40      	adds	r0, r0, #1
c0d00930:	2a00      	cmp	r2, #0
c0d00932:	d1eb      	bne.n	c0d0090c <trytes_to_trits+0xc>
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
c0d00934:	2000      	movs	r0, #0
c0d00936:	bdb0      	pop	{r4, r5, r7, pc}
c0d00938:	0000349a 	.word	0x0000349a

c0d0093c <chars_to_trytes>:
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
c0d0093c:	b5d0      	push	{r4, r6, r7, lr}
c0d0093e:	af02      	add	r7, sp, #8
c0d00940:	e00e      	b.n	c0d00960 <chars_to_trytes+0x24>
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
c0d00942:	7803      	ldrb	r3, [r0, #0]
c0d00944:	b25b      	sxtb	r3, r3
c0d00946:	2400      	movs	r4, #0
c0d00948:	2b39      	cmp	r3, #57	; 0x39
c0d0094a:	d005      	beq.n	c0d00958 <chars_to_trytes+0x1c>
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
c0d0094c:	2b4e      	cmp	r3, #78	; 0x4e
c0d0094e:	db01      	blt.n	c0d00954 <chars_to_trytes+0x18>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
c0d00950:	33a5      	adds	r3, #165	; 0xa5
c0d00952:	e000      	b.n	c0d00956 <chars_to_trytes+0x1a>
c0d00954:	33c0      	adds	r3, #192	; 0xc0
c0d00956:	461c      	mov	r4, r3
c0d00958:	700c      	strb	r4, [r1, #0]
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0095a:	1e52      	subs	r2, r2, #1
c0d0095c:	1c40      	adds	r0, r0, #1
c0d0095e:	1c49      	adds	r1, r1, #1
c0d00960:	2a00      	cmp	r2, #0
c0d00962:	d1ee      	bne.n	c0d00942 <chars_to_trytes+0x6>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
c0d00964:	2000      	movs	r0, #0
c0d00966:	bdd0      	pop	{r4, r6, r7, pc}

c0d00968 <trytes_to_chars>:
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
c0d00968:	b5d0      	push	{r4, r6, r7, lr}
c0d0096a:	af02      	add	r7, sp, #8
    for (uint16_t i = 0; i < len; i++) {
c0d0096c:	2a00      	cmp	r2, #0
c0d0096e:	d00a      	beq.n	c0d00986 <trytes_to_chars+0x1e>
c0d00970:	a306      	add	r3, pc, #24	; (adr r3, c0d0098c <tryte_to_char_mapping>)
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
c0d00972:	7804      	ldrb	r4, [r0, #0]
c0d00974:	b264      	sxtb	r4, r4
c0d00976:	191c      	adds	r4, r3, r4
c0d00978:	7b64      	ldrb	r4, [r4, #13]
c0d0097a:	700c      	strb	r4, [r1, #0]
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
    for (uint16_t i = 0; i < len; i++) {
c0d0097c:	1e52      	subs	r2, r2, #1
c0d0097e:	1c40      	adds	r0, r0, #1
c0d00980:	1c49      	adds	r1, r1, #1
c0d00982:	2a00      	cmp	r2, #0
c0d00984:	d1f5      	bne.n	c0d00972 <trytes_to_chars+0xa>
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
    }

    return 0;
c0d00986:	2000      	movs	r0, #0
c0d00988:	bdd0      	pop	{r4, r6, r7, pc}
c0d0098a:	46c0      	nop			; (mov r8, r8)

c0d0098c <tryte_to_char_mapping>:
c0d0098c:	51504f4e 	.word	0x51504f4e
c0d00990:	55545352 	.word	0x55545352
c0d00994:	59585756 	.word	0x59585756
c0d00998:	4241395a 	.word	0x4241395a
c0d0099c:	46454443 	.word	0x46454443
c0d009a0:	4a494847 	.word	0x4a494847
c0d009a4:	004d4c4b 	.word	0x004d4c4b

c0d009a8 <trints_to_words_u_mem>:
}

// ---- NEED ALL BELOW FOR TRITS_TO_WORDS AS WELL AS ALL _U FUNCS IN BIGINT

int trints_to_words_u_mem(const trint_t *trints_in, uint32_t *base)
{
c0d009a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d009aa:	af03      	add	r7, sp, #12
c0d009ac:	b095      	sub	sp, #84	; 0x54
c0d009ae:	460e      	mov	r6, r1
    uint32_t size = 1;
    trit_t trits[5];

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);
c0d009b0:	2130      	movs	r1, #48	; 0x30
c0d009b2:	9000      	str	r0, [sp, #0]
c0d009b4:	5640      	ldrsb	r0, [r0, r1]
c0d009b6:	a913      	add	r1, sp, #76	; 0x4c
c0d009b8:	2203      	movs	r2, #3
c0d009ba:	f7ff fd45 	bl	c0d00448 <trint_to_trits>
c0d009be:	2001      	movs	r0, #1
c0d009c0:	24f1      	movs	r4, #241	; 0xf1

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d009c2:	9606      	str	r6, [sp, #24]
c0d009c4:	9004      	str	r0, [sp, #16]

        if(i%5 == 4) //we need a new trint
c0d009c6:	2105      	movs	r1, #5
c0d009c8:	4620      	mov	r0, r4
c0d009ca:	f002 ffa3 	bl	c0d03914 <__aeabi_idivmod>
c0d009ce:	460e      	mov	r6, r1
c0d009d0:	2e04      	cmp	r6, #4
c0d009d2:	d10b      	bne.n	c0d009ec <trints_to_words_u_mem+0x44>
c0d009d4:	2505      	movs	r5, #5
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);
c0d009d6:	4620      	mov	r0, r4
c0d009d8:	4629      	mov	r1, r5
c0d009da:	f002 feb5 	bl	c0d03748 <__aeabi_idiv>
c0d009de:	b2c0      	uxtb	r0, r0
c0d009e0:	9900      	ldr	r1, [sp, #0]
c0d009e2:	5608      	ldrsb	r0, [r1, r0]
c0d009e4:	a913      	add	r1, sp, #76	; 0x4c
c0d009e6:	462a      	mov	r2, r5
c0d009e8:	f7ff fd2e 	bl	c0d00448 <trint_to_trits>
c0d009ec:	a813      	add	r0, sp, #76	; 0x4c

        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;
c0d009ee:	5d80      	ldrb	r0, [r0, r6]
c0d009f0:	1c41      	adds	r1, r0, #1
c0d009f2:	2500      	movs	r5, #0
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d009f4:	9804      	ldr	r0, [sp, #16]
c0d009f6:	2800      	cmp	r0, #0
c0d009f8:	d022      	beq.n	c0d00a40 <trints_to_words_u_mem+0x98>
c0d009fa:	9101      	str	r1, [sp, #4]
c0d009fc:	9402      	str	r4, [sp, #8]
c0d009fe:	2500      	movs	r5, #0
c0d00a00:	462e      	mov	r6, r5
c0d00a02:	9503      	str	r5, [sp, #12]
                uint64_t v = base[j];
c0d00a04:	00b1      	lsls	r1, r6, #2
c0d00a06:	9105      	str	r1, [sp, #20]
c0d00a08:	9806      	ldr	r0, [sp, #24]
c0d00a0a:	5840      	ldr	r0, [r0, r1]
                v = v * 3 + carry;
c0d00a0c:	2203      	movs	r2, #3
c0d00a0e:	9c03      	ldr	r4, [sp, #12]
c0d00a10:	4621      	mov	r1, r4
c0d00a12:	4623      	mov	r3, r4
c0d00a14:	f002 ffa4 	bl	c0d03960 <__aeabi_lmul>
c0d00a18:	9b04      	ldr	r3, [sp, #16]
c0d00a1a:	1940      	adds	r0, r0, r5
c0d00a1c:	4161      	adcs	r1, r4

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
c0d00a1e:	9a06      	ldr	r2, [sp, #24]
c0d00a20:	9c05      	ldr	r4, [sp, #20]
c0d00a22:	5110      	str	r0, [r2, r4]
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d00a24:	1c76      	adds	r6, r6, #1
c0d00a26:	42b3      	cmp	r3, r6
c0d00a28:	460d      	mov	r5, r1
c0d00a2a:	d1eb      	bne.n	c0d00a04 <trints_to_words_u_mem+0x5c>
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
c0d00a2c:	2900      	cmp	r1, #0
c0d00a2e:	d004      	beq.n	c0d00a3a <trints_to_words_u_mem+0x92>
                base[sz] = carry;
c0d00a30:	0098      	lsls	r0, r3, #2
c0d00a32:	9a06      	ldr	r2, [sp, #24]
c0d00a34:	5011      	str	r1, [r2, r0]
                size++;
c0d00a36:	1c5d      	adds	r5, r3, #1
c0d00a38:	e000      	b.n	c0d00a3c <trints_to_words_u_mem+0x94>
c0d00a3a:	461d      	mov	r5, r3
c0d00a3c:	9c02      	ldr	r4, [sp, #8]
c0d00a3e:	9901      	ldr	r1, [sp, #4]
            }
        }

        // add
        {
            sz = bigint_add_int_u_mem(base, trit, 12);
c0d00a40:	b2c9      	uxtb	r1, r1
c0d00a42:	220c      	movs	r2, #12
c0d00a44:	9e06      	ldr	r6, [sp, #24]
c0d00a46:	4630      	mov	r0, r6
c0d00a48:	f7ff fdeb 	bl	c0d00622 <bigint_add_int_u_mem>
            if(sz > size) size = sz;
c0d00a4c:	42a8      	cmp	r0, r5
c0d00a4e:	d800      	bhi.n	c0d00a52 <trints_to_words_u_mem+0xaa>
c0d00a50:	4628      	mov	r0, r5

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d00a52:	1e61      	subs	r1, r4, #1
c0d00a54:	2c00      	cmp	r4, #0
c0d00a56:	460c      	mov	r4, r1
c0d00a58:	dcb4      	bgt.n	c0d009c4 <trints_to_words_u_mem+0x1c>
            sz = bigint_add_int_u_mem(base, trit, 12);
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
c0d00a5a:	4818      	ldr	r0, [pc, #96]	; (c0d00abc <trints_to_words_u_mem+0x114>)
c0d00a5c:	4478      	add	r0, pc
c0d00a5e:	220c      	movs	r2, #12
c0d00a60:	4631      	mov	r1, r6
c0d00a62:	f7ff feef 	bl	c0d00844 <bigint_cmp_bigint_u>
c0d00a66:	2801      	cmp	r0, #1
c0d00a68:	db14      	blt.n	c0d00a94 <trints_to_words_u_mem+0xec>
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
    } else {
        uint32_t tmp[12];
        bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
c0d00a6a:	4816      	ldr	r0, [pc, #88]	; (c0d00ac4 <trints_to_words_u_mem+0x11c>)
c0d00a6c:	4478      	add	r0, pc
c0d00a6e:	ae07      	add	r6, sp, #28
c0d00a70:	250c      	movs	r5, #12
c0d00a72:	9906      	ldr	r1, [sp, #24]
c0d00a74:	4632      	mov	r2, r6
c0d00a76:	462b      	mov	r3, r5
c0d00a78:	f7ff fea3 	bl	c0d007c2 <bigint_sub_bigint_u>
        bigint_not_u(tmp, 12);
c0d00a7c:	4630      	mov	r0, r6
c0d00a7e:	4629      	mov	r1, r5
c0d00a80:	f7ff feff 	bl	c0d00882 <bigint_not_u>
        bigint_add_int_u(tmp, 1, base, 12);
c0d00a84:	2101      	movs	r1, #1
c0d00a86:	4630      	mov	r0, r6
c0d00a88:	9e06      	ldr	r6, [sp, #24]
c0d00a8a:	4632      	mov	r2, r6
c0d00a8c:	462b      	mov	r3, r5
c0d00a8e:	f7ff fdff 	bl	c0d00690 <bigint_add_int_u>
c0d00a92:	e005      	b.n	c0d00aa0 <trints_to_words_u_mem+0xf8>
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
c0d00a94:	490a      	ldr	r1, [pc, #40]	; (c0d00ac0 <trints_to_words_u_mem+0x118>)
c0d00a96:	4479      	add	r1, pc
c0d00a98:	220c      	movs	r2, #12
c0d00a9a:	4630      	mov	r0, r6
c0d00a9c:	f7ff fe51 	bl	c0d00742 <bigint_sub_bigint_u_mem>
c0d00aa0:	2000      	movs	r0, #0
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
        uint32_t base_tmp = base[i];
c0d00aa2:	0081      	lsls	r1, r0, #2
c0d00aa4:	5872      	ldr	r2, [r6, r1]
        base[i] = base[11-i];
c0d00aa6:	1a73      	subs	r3, r6, r1
c0d00aa8:	6adc      	ldr	r4, [r3, #44]	; 0x2c
c0d00aaa:	5074      	str	r4, [r6, r1]
        base[11-i] = base_tmp;
c0d00aac:	62da      	str	r2, [r3, #44]	; 0x2c
        bigint_not_u(tmp, 12);
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
c0d00aae:	1c40      	adds	r0, r0, #1
c0d00ab0:	2806      	cmp	r0, #6
c0d00ab2:	d1f6      	bne.n	c0d00aa2 <trints_to_words_u_mem+0xfa>
        base[i] = base[11-i];
        base[11-i] = base_tmp;
    }

    //outputs correct words according to official js
    return 0;
c0d00ab4:	2000      	movs	r0, #0
c0d00ab6:	b015      	add	sp, #84	; 0x54
c0d00ab8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00aba:	46c0      	nop			; (mov r8, r8)
c0d00abc:	0000339c 	.word	0x0000339c
c0d00ac0:	00003362 	.word	0x00003362
c0d00ac4:	0000338c 	.word	0x0000338c

c0d00ac8 <words_to_trints_u_mem>:
    return 0;
}


int words_to_trints_u_mem(uint32_t *words_in, trint_t *trints_out)
{
c0d00ac8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00aca:	af03      	add	r7, sp, #12
c0d00acc:	b095      	sub	sp, #84	; 0x54
c0d00ace:	9101      	str	r1, [sp, #4]
c0d00ad0:	260b      	movs	r6, #11
c0d00ad2:	2100      	movs	r1, #0


void reverse_words(uint32_t *words, uint8_t sz) {
    uint8_t j=sz-1;
    uint32_t tmp;
    for(uint8_t i=0; i<j; i++, j--) {
c0d00ad4:	b2ca      	uxtb	r2, r1
        tmp = words[i];
c0d00ad6:	0092      	lsls	r2, r2, #2
c0d00ad8:	5883      	ldr	r3, [r0, r2]


void reverse_words(uint32_t *words, uint8_t sz) {
    uint8_t j=sz-1;
    uint32_t tmp;
    for(uint8_t i=0; i<j; i++, j--) {
c0d00ada:	b2f4      	uxtb	r4, r6
        tmp = words[i];
        words[i] = words[j];
c0d00adc:	00a4      	lsls	r4, r4, #2
c0d00ade:	5905      	ldr	r5, [r0, r4]
c0d00ae0:	5085      	str	r5, [r0, r2]
        words[j] = tmp;
c0d00ae2:	5103      	str	r3, [r0, r4]


void reverse_words(uint32_t *words, uint8_t sz) {
    uint8_t j=sz-1;
    uint32_t tmp;
    for(uint8_t i=0; i<j; i++, j--) {
c0d00ae4:	1e76      	subs	r6, r6, #1
c0d00ae6:	b2f2      	uxtb	r2, r6
c0d00ae8:	1c49      	adds	r1, r1, #1
c0d00aea:	b2cb      	uxtb	r3, r1
c0d00aec:	4293      	cmp	r3, r2
c0d00aee:	d3f1      	bcc.n	c0d00ad4 <words_to_trints_u_mem+0xc>
    reverse_words(base, 12);

    //base is properly reversed
    bool flip_trits = false;
    // check if big num is negative
    if (base[11] >> 31 == 0) {
c0d00af0:	6ac1      	ldr	r1, [r0, #44]	; 0x2c
c0d00af2:	2900      	cmp	r1, #0
c0d00af4:	9007      	str	r0, [sp, #28]
c0d00af6:	db06      	blt.n	c0d00b06 <words_to_trints_u_mem+0x3e>
        //positive two's complement
        bigint_add_intarr_u_mem(base, HALF_3_u, 12);
c0d00af8:	493e      	ldr	r1, [pc, #248]	; (c0d00bf4 <words_to_trints_u_mem+0x12c>)
c0d00afa:	4479      	add	r1, pc
c0d00afc:	220c      	movs	r2, #12
c0d00afe:	f7ff fd4b 	bl	c0d00598 <bigint_add_intarr_u_mem>
c0d00b02:	2000      	movs	r0, #0
c0d00b04:	e013      	b.n	c0d00b2e <words_to_trints_u_mem+0x66>
c0d00b06:	240c      	movs	r4, #12
c0d00b08:	4605      	mov	r5, r0

    } else {
        //negative number
        bigint_not_u(base, 12);
c0d00b0a:	4621      	mov	r1, r4
c0d00b0c:	f7ff feb9 	bl	c0d00882 <bigint_not_u>
        //***** Doesn't seem to enter here - probably because uint..
        if(bigint_cmp_bigint_u(base, HALF_3_u, 12) > 0) {
c0d00b10:	4939      	ldr	r1, [pc, #228]	; (c0d00bf8 <words_to_trints_u_mem+0x130>)
c0d00b12:	4479      	add	r1, pc
c0d00b14:	4628      	mov	r0, r5
c0d00b16:	4622      	mov	r2, r4
c0d00b18:	f7ff fe94 	bl	c0d00844 <bigint_cmp_bigint_u>
c0d00b1c:	2801      	cmp	r0, #1
c0d00b1e:	db54      	blt.n	c0d00bca <words_to_trints_u_mem+0x102>
            bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
c0d00b20:	4936      	ldr	r1, [pc, #216]	; (c0d00bfc <words_to_trints_u_mem+0x134>)
c0d00b22:	4479      	add	r1, pc
c0d00b24:	220c      	movs	r2, #12
c0d00b26:	4628      	mov	r0, r5
c0d00b28:	f7ff fe0b 	bl	c0d00742 <bigint_sub_bigint_u_mem>
c0d00b2c:	2001      	movs	r0, #1
c0d00b2e:	9005      	str	r0, [sp, #20]
c0d00b30:	2000      	movs	r0, #0
c0d00b32:	9004      	str	r0, [sp, #16]
c0d00b34:	4605      	mov	r5, r0
c0d00b36:	9506      	str	r5, [sp, #24]
c0d00b38:	250b      	movs	r5, #11
c0d00b3a:	9c04      	ldr	r4, [sp, #16]
c0d00b3c:	9907      	ldr	r1, [sp, #28]
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF)
                                      + rem : 0) + base[j];
c0d00b3e:	00a8      	lsls	r0, r5, #2
c0d00b40:	9008      	str	r0, [sp, #32]
c0d00b42:	5808      	ldr	r0, [r1, r0]
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF)
c0d00b44:	2c00      	cmp	r4, #0
c0d00b46:	2203      	movs	r2, #3
c0d00b48:	2600      	movs	r6, #0
                                      + rem : 0) + base[j];
            //radix is 3
            uint64_t q = (lhs / 3) & 0xFFFFFFFF;
            uint8_t r = lhs % 3;
c0d00b4a:	4621      	mov	r1, r4
c0d00b4c:	4633      	mov	r3, r6
c0d00b4e:	f002 fee7 	bl	c0d03920 <__aeabi_uldivmod>
c0d00b52:	4614      	mov	r4, r2
c0d00b54:	9907      	ldr	r1, [sp, #28]

            base[j] = (uint32_t)q;
c0d00b56:	9a08      	ldr	r2, [sp, #32]
c0d00b58:	5088      	str	r0, [r1, r2]
    uint32_t rem = 0;
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
c0d00b5a:	1e68      	subs	r0, r5, #1
c0d00b5c:	2d00      	cmp	r5, #0
c0d00b5e:	4605      	mov	r5, r0
c0d00b60:	dced      	bgt.n	c0d00b3e <words_to_trints_u_mem+0x76>
c0d00b62:	9d06      	ldr	r5, [sp, #24]

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;
c0d00b64:	b2e8      	uxtb	r0, r5
c0d00b66:	2105      	movs	r1, #5
c0d00b68:	9008      	str	r0, [sp, #32]
c0d00b6a:	f002 fde9 	bl	c0d03740 <__aeabi_uidivmod>

        if (flip_trits) {
            trits[i%5] = -trits[i%5];
c0d00b6e:	23fe      	movs	r3, #254	; 0xfe
c0d00b70:	43d8      	mvns	r0, r3
c0d00b72:	1b00      	subs	r0, r0, r4

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;
c0d00b74:	34ff      	adds	r4, #255	; 0xff

        if (flip_trits) {
c0d00b76:	9a05      	ldr	r2, [sp, #20]
c0d00b78:	2a00      	cmp	r2, #0
c0d00b7a:	d100      	bne.n	c0d00b7e <words_to_trints_u_mem+0xb6>
c0d00b7c:	4620      	mov	r0, r4
c0d00b7e:	aa09      	add	r2, sp, #36	; 0x24

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;
c0d00b80:	5450      	strb	r0, [r2, r1]

        if (flip_trits) {
            trits[i%5] = -trits[i%5];
        }

        if(i%5 == 4) // we've finished a trint, store it
c0d00b82:	2904      	cmp	r1, #4
c0d00b84:	4634      	mov	r4, r6
c0d00b86:	d110      	bne.n	c0d00baa <words_to_trints_u_mem+0xe2>
c0d00b88:	a809      	add	r0, sp, #36	; 0x24
c0d00b8a:	9403      	str	r4, [sp, #12]
            trints_out[(uint8_t)(i/5)] = trits_to_trint(&trits[0], 5);
c0d00b8c:	2405      	movs	r4, #5
c0d00b8e:	4621      	mov	r1, r4
c0d00b90:	461e      	mov	r6, r3
c0d00b92:	f7ff fbd2 	bl	c0d0033a <trits_to_trint>
c0d00b96:	9002      	str	r0, [sp, #8]
c0d00b98:	9808      	ldr	r0, [sp, #32]
c0d00b9a:	4621      	mov	r1, r4
c0d00b9c:	9c03      	ldr	r4, [sp, #12]
c0d00b9e:	f002 fd49 	bl	c0d03634 <__aeabi_uidiv>
c0d00ba2:	4633      	mov	r3, r6
c0d00ba4:	9901      	ldr	r1, [sp, #4]
c0d00ba6:	9a02      	ldr	r2, [sp, #8]
c0d00ba8:	540a      	strb	r2, [r1, r0]
    // Same result up to here!!


    uint32_t rem = 0;
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
c0d00baa:	1c6d      	adds	r5, r5, #1
c0d00bac:	402b      	ands	r3, r5
c0d00bae:	0858      	lsrs	r0, r3, #1
c0d00bb0:	2879      	cmp	r0, #121	; 0x79
c0d00bb2:	d3c0      	bcc.n	c0d00b36 <words_to_trints_u_mem+0x6e>
c0d00bb4:	a809      	add	r0, sp, #36	; 0x24

        if(i%5 == 4) // we've finished a trint, store it
            trints_out[(uint8_t)(i/5)] = trits_to_trint(&trits[0], 5);
    }
    //set very last trit to 0
    trits[2] = 0;
c0d00bb6:	7084      	strb	r4, [r0, #2]
    //the last trint %5 won't == 4 so store it manually
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00bb8:	2103      	movs	r1, #3
c0d00bba:	f7ff fbbe 	bl	c0d0033a <trits_to_trint>
c0d00bbe:	2130      	movs	r1, #48	; 0x30
c0d00bc0:	9a01      	ldr	r2, [sp, #4]
c0d00bc2:	5450      	strb	r0, [r2, r1]

    //words_to_trints_u works (same result as official
    return 0;
c0d00bc4:	4620      	mov	r0, r4
c0d00bc6:	b015      	add	sp, #84	; 0x54
c0d00bc8:	bdf0      	pop	{r4, r5, r6, r7, pc}
            bigint_sub_bigint_u_mem(base, HALF_3_u, 12);

            flip_trits = true;
        } else {
            //bigint is between unsigned half3 and 2**384 - 3**242/2).
            bigint_add_int_u_mem(base, 1, 12);
c0d00bca:	2101      	movs	r1, #1
c0d00bcc:	240c      	movs	r4, #12
c0d00bce:	4628      	mov	r0, r5
c0d00bd0:	4622      	mov	r2, r4
c0d00bd2:	f7ff fd26 	bl	c0d00622 <bigint_add_int_u_mem>

            //ta_slice returns same array (from official implementation)
            //so just sub base from half3 but store in base
            uint32_t tmp[12];
            bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
c0d00bd6:	480a      	ldr	r0, [pc, #40]	; (c0d00c00 <words_to_trints_u_mem+0x138>)
c0d00bd8:	4478      	add	r0, pc
c0d00bda:	ae09      	add	r6, sp, #36	; 0x24
c0d00bdc:	4629      	mov	r1, r5
c0d00bde:	4632      	mov	r2, r6
c0d00be0:	4623      	mov	r3, r4
c0d00be2:	f7ff fdee 	bl	c0d007c2 <bigint_sub_bigint_u>
            memcpy(base, tmp, 48);
c0d00be6:	ce1e      	ldmia	r6!, {r1, r2, r3, r4}
c0d00be8:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00bea:	ce1e      	ldmia	r6!, {r1, r2, r3, r4}
c0d00bec:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00bee:	ce1e      	ldmia	r6!, {r1, r2, r3, r4}
c0d00bf0:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00bf2:	e786      	b.n	c0d00b02 <words_to_trints_u_mem+0x3a>
c0d00bf4:	000032fe 	.word	0x000032fe
c0d00bf8:	000032e6 	.word	0x000032e6
c0d00bfc:	000032d6 	.word	0x000032d6
c0d00c00:	00003220 	.word	0x00003220

c0d00c04 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char sha3_bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00c04:	b580      	push	{r7, lr}
c0d00c06:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00c08:	2003      	movs	r0, #3
c0d00c0a:	01c1      	lsls	r1, r0, #7
c0d00c0c:	4802      	ldr	r0, [pc, #8]	; (c0d00c18 <kerl_initialize+0x14>)
c0d00c0e:	f001 fba3 	bl	c0d02358 <cx_keccak_init>
    return 0;
c0d00c12:	2000      	movs	r0, #0
c0d00c14:	bd80      	pop	{r7, pc}
c0d00c16:	46c0      	nop			; (mov r8, r8)
c0d00c18:	20001840 	.word	0x20001840

c0d00c1c <kerl_absorb_trints_single>:

    return 0;
}

int kerl_absorb_trints_single(trint_t *trints_in)
{
c0d00c1c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c1e:	af03      	add	r7, sp, #12
c0d00c20:	b099      	sub	sp, #100	; 0x64
c0d00c22:	4605      	mov	r5, r0
c0d00c24:	ac0d      	add	r4, sp, #52	; 0x34
    // First, convert to bytes
    uint32_t words[12] = {0};
c0d00c26:	2130      	movs	r1, #48	; 0x30
c0d00c28:	4620      	mov	r0, r4
c0d00c2a:	f002 ffaf 	bl	c0d03b8c <__aeabi_memclr>
    unsigned char bytes[48];

    //Convert straight from trints to words
    trints_to_words_u_mem(trints_in, words);
c0d00c2e:	4628      	mov	r0, r5
c0d00c30:	4621      	mov	r1, r4
c0d00c32:	f7ff feb9 	bl	c0d009a8 <trints_to_words_u_mem>
c0d00c36:	a801      	add	r0, sp, #4
}

void words_to_bytes(const int32_t *words, unsigned char *bytes,
                    const uint8_t num_words) {

    memcpy(bytes, words, num_words * 4);
c0d00c38:	4601      	mov	r1, r0
c0d00c3a:	cc6c      	ldmia	r4!, {r2, r3, r5, r6}
c0d00c3c:	c16c      	stmia	r1!, {r2, r3, r5, r6}
c0d00c3e:	cc6c      	ldmia	r4!, {r2, r3, r5, r6}
c0d00c40:	c16c      	stmia	r1!, {r2, r3, r5, r6}
c0d00c42:	cc6c      	ldmia	r4!, {r2, r3, r5, r6}
c0d00c44:	c16c      	stmia	r1!, {r2, r3, r5, r6}
c0d00c46:	2100      	movs	r1, #0

#if BYTE_ORDER == LITTLE_ENDIAN
    // swap endianness on little-endian hardware
    uint32_t *p = (uint32_t *)bytes;
    for (uint8_t i = 0; i < num_words; i++) {
        *p = change_endianess(*p);
c0d00c48:	6802      	ldr	r2, [r0, #0]
}

uint32_t change_endianess(uint32_t i) {
    return ((i & 0xFF) << 24) |
    ((i & 0xFF00) << 8) |
    ((i >> 8) & 0xFF00) |
c0d00c4a:	ba12      	rev	r2, r2

#if BYTE_ORDER == LITTLE_ENDIAN
    // swap endianness on little-endian hardware
    uint32_t *p = (uint32_t *)bytes;
    for (uint8_t i = 0; i < num_words; i++) {
        *p = change_endianess(*p);
c0d00c4c:	c004      	stmia	r0!, {r2}
    memcpy(bytes, words, num_words * 4);

#if BYTE_ORDER == LITTLE_ENDIAN
    // swap endianness on little-endian hardware
    uint32_t *p = (uint32_t *)bytes;
    for (uint8_t i = 0; i < num_words; i++) {
c0d00c4e:	1c49      	adds	r1, r1, #1
c0d00c50:	b2ca      	uxtb	r2, r1
c0d00c52:	2a0c      	cmp	r2, #12
c0d00c54:	d3f8      	bcc.n	c0d00c48 <kerl_absorb_trints_single+0x2c>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, sha3_bytes_out);
c0d00c56:	4806      	ldr	r0, [pc, #24]	; (c0d00c70 <kerl_absorb_trints_single+0x54>)
c0d00c58:	4669      	mov	r1, sp
c0d00c5a:	6008      	str	r0, [r1, #0]
c0d00c5c:	4805      	ldr	r0, [pc, #20]	; (c0d00c74 <kerl_absorb_trints_single+0x58>)
c0d00c5e:	2101      	movs	r1, #1
c0d00c60:	aa01      	add	r2, sp, #4
c0d00c62:	2330      	movs	r3, #48	; 0x30
c0d00c64:	f001 fb96 	bl	c0d02394 <cx_hash>
c0d00c68:	2000      	movs	r0, #0

    //Convert straight from trints to words
    trints_to_words_u_mem(trints_in, words);
    words_to_bytes(words, bytes, 12);

    return kerl_absorb_bytes(bytes, 48);
c0d00c6a:	b019      	add	sp, #100	; 0x64
c0d00c6c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00c6e:	46c0      	nop			; (mov r8, r8)
c0d00c70:	200019e8 	.word	0x200019e8
c0d00c74:	20001840 	.word	0x20001840

c0d00c78 <kerl_absorb_trints>:
}

int kerl_absorb_trints(trint_t *trints_in, uint16_t len) {
c0d00c78:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c7a:	af03      	add	r7, sp, #12
c0d00c7c:	b081      	sub	sp, #4
c0d00c7e:	460c      	mov	r4, r1
c0d00c80:	9000      	str	r0, [sp, #0]
c0d00c82:	2531      	movs	r5, #49	; 0x31
    for (uint8_t i = 0; i < (len / 49); i++) {
c0d00c84:	4620      	mov	r0, r4
c0d00c86:	4629      	mov	r1, r5
c0d00c88:	f002 fcd4 	bl	c0d03634 <__aeabi_uidiv>
c0d00c8c:	4606      	mov	r6, r0
c0d00c8e:	2c31      	cmp	r4, #49	; 0x31
c0d00c90:	d30a      	bcc.n	c0d00ca8 <kerl_absorb_trints+0x30>
c0d00c92:	2000      	movs	r0, #0
c0d00c94:	4604      	mov	r4, r0
        kerl_absorb_trints_single(trints_in + i * 49);
c0d00c96:	4368      	muls	r0, r5
c0d00c98:	9900      	ldr	r1, [sp, #0]
c0d00c9a:	1808      	adds	r0, r1, r0
c0d00c9c:	f7ff ffbe 	bl	c0d00c1c <kerl_absorb_trints_single>

    return kerl_absorb_bytes(bytes, 48);
}

int kerl_absorb_trints(trint_t *trints_in, uint16_t len) {
    for (uint8_t i = 0; i < (len / 49); i++) {
c0d00ca0:	1c64      	adds	r4, r4, #1
c0d00ca2:	b2e0      	uxtb	r0, r4
c0d00ca4:	42b0      	cmp	r0, r6
c0d00ca6:	d3f6      	bcc.n	c0d00c96 <kerl_absorb_trints+0x1e>
        kerl_absorb_trints_single(trints_in + i * 49);
    }

    return 0;
c0d00ca8:	2000      	movs	r0, #0
c0d00caa:	b001      	add	sp, #4
c0d00cac:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00cb0 <kerl_squeeze_trints_single>:
}

int kerl_squeeze_trints_single(trint_t *trints_out)
{
c0d00cb0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00cb2:	af03      	add	r7, sp, #12
c0d00cb4:	b09d      	sub	sp, #116	; 0x74
c0d00cb6:	9003      	str	r0, [sp, #12]
    return 0;
}

int kerl_finalize(unsigned char *bytes_out, uint16_t len)
{
    memcpy(bytes_out, sha3_bytes_out, len);
c0d00cb8:	4e25      	ldr	r6, [pc, #148]	; (c0d00d50 <kerl_squeeze_trints_single+0xa0>)
c0d00cba:	a811      	add	r0, sp, #68	; 0x44
c0d00cbc:	4631      	mov	r1, r6
c0d00cbe:	c93c      	ldmia	r1!, {r2, r3, r4, r5}
c0d00cc0:	c03c      	stmia	r0!, {r2, r3, r4, r5}
c0d00cc2:	c93c      	ldmia	r1!, {r2, r3, r4, r5}
c0d00cc4:	c03c      	stmia	r0!, {r2, r3, r4, r5}
c0d00cc6:	c93c      	ldmia	r1!, {r2, r3, r4, r5}
c0d00cc8:	c03c      	stmia	r0!, {r2, r3, r4, r5}
c0d00cca:	a805      	add	r0, sp, #20
}

void bytes_to_words(const unsigned char *bytes, int32_t *words,
                    const uint8_t num_words) {

    memcpy(words, bytes, num_words * 4);
c0d00ccc:	4601      	mov	r1, r0
c0d00cce:	4632      	mov	r2, r6
c0d00cd0:	ca78      	ldmia	r2!, {r3, r4, r5, r6}
c0d00cd2:	c178      	stmia	r1!, {r3, r4, r5, r6}
c0d00cd4:	ca78      	ldmia	r2!, {r3, r4, r5, r6}
c0d00cd6:	c178      	stmia	r1!, {r3, r4, r5, r6}
c0d00cd8:	ca78      	ldmia	r2!, {r3, r4, r5, r6}
c0d00cda:	c178      	stmia	r1!, {r3, r4, r5, r6}
c0d00cdc:	2100      	movs	r1, #0

#if BYTE_ORDER == LITTLE_ENDIAN
    // swap endianness on little-endian hardware
    uint32_t *p = words;
    for (uint8_t i = 0; i < num_words; i++) {
        *p = change_endianess(*p);
c0d00cde:	6802      	ldr	r2, [r0, #0]
}

uint32_t change_endianess(uint32_t i) {
    return ((i & 0xFF) << 24) |
    ((i & 0xFF00) << 8) |
    ((i >> 8) & 0xFF00) |
c0d00ce0:	ba12      	rev	r2, r2

#if BYTE_ORDER == LITTLE_ENDIAN
    // swap endianness on little-endian hardware
    uint32_t *p = words;
    for (uint8_t i = 0; i < num_words; i++) {
        *p = change_endianess(*p);
c0d00ce2:	c004      	stmia	r0!, {r2}
    memcpy(words, bytes, num_words * 4);

#if BYTE_ORDER == LITTLE_ENDIAN
    // swap endianness on little-endian hardware
    uint32_t *p = words;
    for (uint8_t i = 0; i < num_words; i++) {
c0d00ce4:	1c49      	adds	r1, r1, #1
c0d00ce6:	b2ca      	uxtb	r2, r1
c0d00ce8:	2a0c      	cmp	r2, #12
c0d00cea:	d3f8      	bcc.n	c0d00cde <kerl_squeeze_trints_single+0x2e>
c0d00cec:	a805      	add	r0, sp, #20
c0d00cee:	9c03      	ldr	r4, [sp, #12]
    int32_t words[12];

    kerl_finalize(bytes_out, 48);

    bytes_to_words(bytes_out, words, 12);
    words_to_trints_u_mem(words, &trints_out[0]);
c0d00cf0:	4621      	mov	r1, r4
c0d00cf2:	f7ff fee9 	bl	c0d00ac8 <words_to_trints_u_mem>

    //-- Setting last trit to 0
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
c0d00cf6:	2030      	movs	r0, #48	; 0x30
c0d00cf8:	9002      	str	r0, [sp, #8]
c0d00cfa:	5620      	ldrsb	r0, [r4, r0]
c0d00cfc:	ae04      	add	r6, sp, #16
c0d00cfe:	2503      	movs	r5, #3
c0d00d00:	4631      	mov	r1, r6
c0d00d02:	462a      	mov	r2, r5
c0d00d04:	f7ff fba0 	bl	c0d00448 <trint_to_trits>
c0d00d08:	2400      	movs	r4, #0
    trits[2] = 0; //set last trit to 0
c0d00d0a:	70b4      	strb	r4, [r6, #2]
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00d0c:	4630      	mov	r0, r6
c0d00d0e:	4629      	mov	r1, r5
c0d00d10:	f7ff fb13 	bl	c0d0033a <trits_to_trint>
c0d00d14:	9902      	ldr	r1, [sp, #8]
c0d00d16:	9a03      	ldr	r2, [sp, #12]
c0d00d18:	5450      	strb	r0, [r2, r1]
c0d00d1a:	a811      	add	r0, sp, #68	; 0x44

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = ~bytes_out[i];
c0d00d1c:	1b00      	subs	r0, r0, r4
c0d00d1e:	7801      	ldrb	r1, [r0, #0]
c0d00d20:	43c9      	mvns	r1, r1
c0d00d22:	7001      	strb	r1, [r0, #0]
    trits[2] = 0; //set last trit to 0
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d00d24:	1e64      	subs	r4, r4, #1
c0d00d26:	4620      	mov	r0, r4
c0d00d28:	3030      	adds	r0, #48	; 0x30
c0d00d2a:	d1f6      	bne.n	c0d00d1a <kerl_squeeze_trints_single+0x6a>
cx_sha3_t sha3;
static unsigned char sha3_bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d00d2c:	01e9      	lsls	r1, r5, #7
c0d00d2e:	4c09      	ldr	r4, [pc, #36]	; (c0d00d54 <kerl_squeeze_trints_single+0xa4>)
c0d00d30:	4620      	mov	r0, r4
c0d00d32:	f001 fb11 	bl	c0d02358 <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, sha3_bytes_out);
c0d00d36:	4668      	mov	r0, sp
c0d00d38:	4905      	ldr	r1, [pc, #20]	; (c0d00d50 <kerl_squeeze_trints_single+0xa0>)
c0d00d3a:	6001      	str	r1, [r0, #0]
c0d00d3c:	2101      	movs	r1, #1
c0d00d3e:	aa11      	add	r2, sp, #68	; 0x44
c0d00d40:	2330      	movs	r3, #48	; 0x30
c0d00d42:	4620      	mov	r0, r4
c0d00d44:	f001 fb26 	bl	c0d02394 <cx_hash>
c0d00d48:	2000      	movs	r0, #0
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out, 48);

    return 0;
c0d00d4a:	b01d      	add	sp, #116	; 0x74
c0d00d4c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00d4e:	46c0      	nop			; (mov r8, r8)
c0d00d50:	200019e8 	.word	0x200019e8
c0d00d54:	20001840 	.word	0x20001840

c0d00d58 <kerl_squeeze_trints>:
}

int kerl_squeeze_trints(trint_t *trints_out, uint16_t len)
{
c0d00d58:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00d5a:	af03      	add	r7, sp, #12
c0d00d5c:	b081      	sub	sp, #4
c0d00d5e:	460c      	mov	r4, r1
c0d00d60:	9000      	str	r0, [sp, #0]
c0d00d62:	2531      	movs	r5, #49	; 0x31
    for (uint8_t i = 0; i < (len / 49); i++) {
c0d00d64:	4620      	mov	r0, r4
c0d00d66:	4629      	mov	r1, r5
c0d00d68:	f002 fc64 	bl	c0d03634 <__aeabi_uidiv>
c0d00d6c:	4606      	mov	r6, r0
c0d00d6e:	2c31      	cmp	r4, #49	; 0x31
c0d00d70:	d30a      	bcc.n	c0d00d88 <kerl_squeeze_trints+0x30>
c0d00d72:	2000      	movs	r0, #0
c0d00d74:	4604      	mov	r4, r0
        kerl_squeeze_trints_single(trints_out + i * 49);
c0d00d76:	4368      	muls	r0, r5
c0d00d78:	9900      	ldr	r1, [sp, #0]
c0d00d7a:	1808      	adds	r0, r1, r0
c0d00d7c:	f7ff ff98 	bl	c0d00cb0 <kerl_squeeze_trints_single>
    return 0;
}

int kerl_squeeze_trints(trint_t *trints_out, uint16_t len)
{
    for (uint8_t i = 0; i < (len / 49); i++) {
c0d00d80:	1c64      	adds	r4, r4, #1
c0d00d82:	b2e0      	uxtb	r0, r4
c0d00d84:	42b0      	cmp	r0, r6
c0d00d86:	d3f6      	bcc.n	c0d00d76 <kerl_squeeze_trints+0x1e>
        kerl_squeeze_trints_single(trints_out + i * 49);
    }

    return 0;
c0d00d88:	2000      	movs	r0, #0
c0d00d8a:	b001      	add	sp, #4
c0d00d8c:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00d90 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00d90:	b580      	push	{r7, lr}
c0d00d92:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00d94:	4804      	ldr	r0, [pc, #16]	; (c0d00da8 <nvram_is_init+0x18>)
c0d00d96:	f001 fa33 	bl	c0d02200 <pic>
c0d00d9a:	7801      	ldrb	r1, [r0, #0]
c0d00d9c:	2000      	movs	r0, #0
c0d00d9e:	2901      	cmp	r1, #1
c0d00da0:	d100      	bne.n	c0d00da4 <nvram_is_init+0x14>
c0d00da2:	4608      	mov	r0, r1
    else return true;
}
c0d00da4:	bd80      	pop	{r7, pc}
c0d00da6:	46c0      	nop			; (mov r8, r8)
c0d00da8:	c0d04200 	.word	0xc0d04200

c0d00dac <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00dac:	b5b0      	push	{r4, r5, r7, lr}
c0d00dae:	af02      	add	r7, sp, #8
c0d00db0:	4605      	mov	r5, r0
c0d00db2:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00db4:	4028      	ands	r0, r5
c0d00db6:	2400      	movs	r4, #0
c0d00db8:	2801      	cmp	r0, #1
c0d00dba:	d013      	beq.n	c0d00de4 <io_exchange_al+0x38>
c0d00dbc:	2802      	cmp	r0, #2
c0d00dbe:	d113      	bne.n	c0d00de8 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00dc0:	2900      	cmp	r1, #0
c0d00dc2:	d008      	beq.n	c0d00dd6 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00dc4:	480b      	ldr	r0, [pc, #44]	; (c0d00df4 <io_exchange_al+0x48>)
c0d00dc6:	f001 fbd7 	bl	c0d02578 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d00dca:	b268      	sxtb	r0, r5
c0d00dcc:	2800      	cmp	r0, #0
c0d00dce:	da09      	bge.n	c0d00de4 <io_exchange_al+0x38>
                reset();
c0d00dd0:	f001 fa4c 	bl	c0d0226c <reset>
c0d00dd4:	e006      	b.n	c0d00de4 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00dd6:	2041      	movs	r0, #65	; 0x41
c0d00dd8:	0081      	lsls	r1, r0, #2
c0d00dda:	4806      	ldr	r0, [pc, #24]	; (c0d00df4 <io_exchange_al+0x48>)
c0d00ddc:	2200      	movs	r2, #0
c0d00dde:	f001 fc05 	bl	c0d025ec <io_seproxyhal_spi_recv>
c0d00de2:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00de4:	4620      	mov	r0, r4
c0d00de6:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00de8:	4803      	ldr	r0, [pc, #12]	; (c0d00df8 <io_exchange_al+0x4c>)
c0d00dea:	6800      	ldr	r0, [r0, #0]
c0d00dec:	2102      	movs	r1, #2
c0d00dee:	f002 ff6f 	bl	c0d03cd0 <longjmp>
c0d00df2:	46c0      	nop			; (mov r8, r8)
c0d00df4:	20001c08 	.word	0x20001c08
c0d00df8:	20001bb8 	.word	0x20001bb8

c0d00dfc <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00dfc:	b580      	push	{r7, lr}
c0d00dfe:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00e00:	f000 fe8e 	bl	c0d01b20 <io_seproxyhal_display_default>
}
c0d00e04:	bd80      	pop	{r7, pc}
	...

c0d00e08 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00e08:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e0a:	af03      	add	r7, sp, #12
c0d00e0c:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00e0e:	48a6      	ldr	r0, [pc, #664]	; (c0d010a8 <io_event+0x2a0>)
c0d00e10:	7800      	ldrb	r0, [r0, #0]
c0d00e12:	2805      	cmp	r0, #5
c0d00e14:	d02e      	beq.n	c0d00e74 <io_event+0x6c>
c0d00e16:	280d      	cmp	r0, #13
c0d00e18:	d04e      	beq.n	c0d00eb8 <io_event+0xb0>
c0d00e1a:	280c      	cmp	r0, #12
c0d00e1c:	d000      	beq.n	c0d00e20 <io_event+0x18>
c0d00e1e:	e13a      	b.n	c0d01096 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00e20:	4ea2      	ldr	r6, [pc, #648]	; (c0d010ac <io_event+0x2a4>)
c0d00e22:	2001      	movs	r0, #1
c0d00e24:	7630      	strb	r0, [r6, #24]
c0d00e26:	2500      	movs	r5, #0
c0d00e28:	61f5      	str	r5, [r6, #28]
c0d00e2a:	4634      	mov	r4, r6
c0d00e2c:	3418      	adds	r4, #24
c0d00e2e:	4620      	mov	r0, r4
c0d00e30:	f001 fb68 	bl	c0d02504 <os_ux>
c0d00e34:	61f0      	str	r0, [r6, #28]
c0d00e36:	499e      	ldr	r1, [pc, #632]	; (c0d010b0 <io_event+0x2a8>)
c0d00e38:	4288      	cmp	r0, r1
c0d00e3a:	d100      	bne.n	c0d00e3e <io_event+0x36>
c0d00e3c:	e12b      	b.n	c0d01096 <io_event+0x28e>
c0d00e3e:	2800      	cmp	r0, #0
c0d00e40:	d100      	bne.n	c0d00e44 <io_event+0x3c>
c0d00e42:	e128      	b.n	c0d01096 <io_event+0x28e>
c0d00e44:	499b      	ldr	r1, [pc, #620]	; (c0d010b4 <io_event+0x2ac>)
c0d00e46:	4288      	cmp	r0, r1
c0d00e48:	d000      	beq.n	c0d00e4c <io_event+0x44>
c0d00e4a:	e0ac      	b.n	c0d00fa6 <io_event+0x19e>
c0d00e4c:	2003      	movs	r0, #3
c0d00e4e:	7630      	strb	r0, [r6, #24]
c0d00e50:	61f5      	str	r5, [r6, #28]
c0d00e52:	4620      	mov	r0, r4
c0d00e54:	f001 fb56 	bl	c0d02504 <os_ux>
c0d00e58:	61f0      	str	r0, [r6, #28]
c0d00e5a:	f000 fd17 	bl	c0d0188c <io_seproxyhal_init_ux>
c0d00e5e:	60b5      	str	r5, [r6, #8]
c0d00e60:	6830      	ldr	r0, [r6, #0]
c0d00e62:	2800      	cmp	r0, #0
c0d00e64:	d100      	bne.n	c0d00e68 <io_event+0x60>
c0d00e66:	e116      	b.n	c0d01096 <io_event+0x28e>
c0d00e68:	69f0      	ldr	r0, [r6, #28]
c0d00e6a:	4991      	ldr	r1, [pc, #580]	; (c0d010b0 <io_event+0x2a8>)
c0d00e6c:	4288      	cmp	r0, r1
c0d00e6e:	d000      	beq.n	c0d00e72 <io_event+0x6a>
c0d00e70:	e096      	b.n	c0d00fa0 <io_event+0x198>
c0d00e72:	e110      	b.n	c0d01096 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00e74:	4d8d      	ldr	r5, [pc, #564]	; (c0d010ac <io_event+0x2a4>)
c0d00e76:	2001      	movs	r0, #1
c0d00e78:	7628      	strb	r0, [r5, #24]
c0d00e7a:	2600      	movs	r6, #0
c0d00e7c:	61ee      	str	r6, [r5, #28]
c0d00e7e:	462c      	mov	r4, r5
c0d00e80:	3418      	adds	r4, #24
c0d00e82:	4620      	mov	r0, r4
c0d00e84:	f001 fb3e 	bl	c0d02504 <os_ux>
c0d00e88:	4601      	mov	r1, r0
c0d00e8a:	61e9      	str	r1, [r5, #28]
c0d00e8c:	4889      	ldr	r0, [pc, #548]	; (c0d010b4 <io_event+0x2ac>)
c0d00e8e:	4281      	cmp	r1, r0
c0d00e90:	d15d      	bne.n	c0d00f4e <io_event+0x146>
c0d00e92:	2003      	movs	r0, #3
c0d00e94:	7628      	strb	r0, [r5, #24]
c0d00e96:	61ee      	str	r6, [r5, #28]
c0d00e98:	4620      	mov	r0, r4
c0d00e9a:	f001 fb33 	bl	c0d02504 <os_ux>
c0d00e9e:	61e8      	str	r0, [r5, #28]
c0d00ea0:	f000 fcf4 	bl	c0d0188c <io_seproxyhal_init_ux>
c0d00ea4:	60ae      	str	r6, [r5, #8]
c0d00ea6:	6828      	ldr	r0, [r5, #0]
c0d00ea8:	2800      	cmp	r0, #0
c0d00eaa:	d100      	bne.n	c0d00eae <io_event+0xa6>
c0d00eac:	e0f3      	b.n	c0d01096 <io_event+0x28e>
c0d00eae:	69e8      	ldr	r0, [r5, #28]
c0d00eb0:	497f      	ldr	r1, [pc, #508]	; (c0d010b0 <io_event+0x2a8>)
c0d00eb2:	4288      	cmp	r0, r1
c0d00eb4:	d148      	bne.n	c0d00f48 <io_event+0x140>
c0d00eb6:	e0ee      	b.n	c0d01096 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00eb8:	4d7c      	ldr	r5, [pc, #496]	; (c0d010ac <io_event+0x2a4>)
c0d00eba:	6868      	ldr	r0, [r5, #4]
c0d00ebc:	68a9      	ldr	r1, [r5, #8]
c0d00ebe:	4281      	cmp	r1, r0
c0d00ec0:	d300      	bcc.n	c0d00ec4 <io_event+0xbc>
c0d00ec2:	e0e8      	b.n	c0d01096 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00ec4:	2001      	movs	r0, #1
c0d00ec6:	7628      	strb	r0, [r5, #24]
c0d00ec8:	2600      	movs	r6, #0
c0d00eca:	61ee      	str	r6, [r5, #28]
c0d00ecc:	462c      	mov	r4, r5
c0d00ece:	3418      	adds	r4, #24
c0d00ed0:	4620      	mov	r0, r4
c0d00ed2:	f001 fb17 	bl	c0d02504 <os_ux>
c0d00ed6:	61e8      	str	r0, [r5, #28]
c0d00ed8:	4975      	ldr	r1, [pc, #468]	; (c0d010b0 <io_event+0x2a8>)
c0d00eda:	4288      	cmp	r0, r1
c0d00edc:	d100      	bne.n	c0d00ee0 <io_event+0xd8>
c0d00ede:	e0da      	b.n	c0d01096 <io_event+0x28e>
c0d00ee0:	2800      	cmp	r0, #0
c0d00ee2:	d100      	bne.n	c0d00ee6 <io_event+0xde>
c0d00ee4:	e0d7      	b.n	c0d01096 <io_event+0x28e>
c0d00ee6:	4973      	ldr	r1, [pc, #460]	; (c0d010b4 <io_event+0x2ac>)
c0d00ee8:	4288      	cmp	r0, r1
c0d00eea:	d000      	beq.n	c0d00eee <io_event+0xe6>
c0d00eec:	e08d      	b.n	c0d0100a <io_event+0x202>
c0d00eee:	2003      	movs	r0, #3
c0d00ef0:	7628      	strb	r0, [r5, #24]
c0d00ef2:	61ee      	str	r6, [r5, #28]
c0d00ef4:	4620      	mov	r0, r4
c0d00ef6:	f001 fb05 	bl	c0d02504 <os_ux>
c0d00efa:	61e8      	str	r0, [r5, #28]
c0d00efc:	f000 fcc6 	bl	c0d0188c <io_seproxyhal_init_ux>
c0d00f00:	60ae      	str	r6, [r5, #8]
c0d00f02:	6828      	ldr	r0, [r5, #0]
c0d00f04:	2800      	cmp	r0, #0
c0d00f06:	d100      	bne.n	c0d00f0a <io_event+0x102>
c0d00f08:	e0c5      	b.n	c0d01096 <io_event+0x28e>
c0d00f0a:	69e8      	ldr	r0, [r5, #28]
c0d00f0c:	4968      	ldr	r1, [pc, #416]	; (c0d010b0 <io_event+0x2a8>)
c0d00f0e:	4288      	cmp	r0, r1
c0d00f10:	d178      	bne.n	c0d01004 <io_event+0x1fc>
c0d00f12:	e0c0      	b.n	c0d01096 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00f14:	6868      	ldr	r0, [r5, #4]
c0d00f16:	4286      	cmp	r6, r0
c0d00f18:	d300      	bcc.n	c0d00f1c <io_event+0x114>
c0d00f1a:	e0bc      	b.n	c0d01096 <io_event+0x28e>
c0d00f1c:	f001 fb4a 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d00f20:	2800      	cmp	r0, #0
c0d00f22:	d000      	beq.n	c0d00f26 <io_event+0x11e>
c0d00f24:	e0b7      	b.n	c0d01096 <io_event+0x28e>
c0d00f26:	68a8      	ldr	r0, [r5, #8]
c0d00f28:	68e9      	ldr	r1, [r5, #12]
c0d00f2a:	2438      	movs	r4, #56	; 0x38
c0d00f2c:	4360      	muls	r0, r4
c0d00f2e:	682a      	ldr	r2, [r5, #0]
c0d00f30:	1810      	adds	r0, r2, r0
c0d00f32:	2900      	cmp	r1, #0
c0d00f34:	d100      	bne.n	c0d00f38 <io_event+0x130>
c0d00f36:	e085      	b.n	c0d01044 <io_event+0x23c>
c0d00f38:	4788      	blx	r1
c0d00f3a:	2800      	cmp	r0, #0
c0d00f3c:	d000      	beq.n	c0d00f40 <io_event+0x138>
c0d00f3e:	e081      	b.n	c0d01044 <io_event+0x23c>
c0d00f40:	68a8      	ldr	r0, [r5, #8]
c0d00f42:	1c46      	adds	r6, r0, #1
c0d00f44:	60ae      	str	r6, [r5, #8]
c0d00f46:	6828      	ldr	r0, [r5, #0]
c0d00f48:	2800      	cmp	r0, #0
c0d00f4a:	d1e3      	bne.n	c0d00f14 <io_event+0x10c>
c0d00f4c:	e0a3      	b.n	c0d01096 <io_event+0x28e>
c0d00f4e:	6928      	ldr	r0, [r5, #16]
c0d00f50:	2800      	cmp	r0, #0
c0d00f52:	d100      	bne.n	c0d00f56 <io_event+0x14e>
c0d00f54:	e09f      	b.n	c0d01096 <io_event+0x28e>
c0d00f56:	4a56      	ldr	r2, [pc, #344]	; (c0d010b0 <io_event+0x2a8>)
c0d00f58:	4291      	cmp	r1, r2
c0d00f5a:	d100      	bne.n	c0d00f5e <io_event+0x156>
c0d00f5c:	e09b      	b.n	c0d01096 <io_event+0x28e>
c0d00f5e:	2900      	cmp	r1, #0
c0d00f60:	d100      	bne.n	c0d00f64 <io_event+0x15c>
c0d00f62:	e098      	b.n	c0d01096 <io_event+0x28e>
c0d00f64:	4950      	ldr	r1, [pc, #320]	; (c0d010a8 <io_event+0x2a0>)
c0d00f66:	78c9      	ldrb	r1, [r1, #3]
c0d00f68:	0849      	lsrs	r1, r1, #1
c0d00f6a:	f000 fe1b 	bl	c0d01ba4 <io_seproxyhal_button_push>
c0d00f6e:	e092      	b.n	c0d01096 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00f70:	6870      	ldr	r0, [r6, #4]
c0d00f72:	4285      	cmp	r5, r0
c0d00f74:	d300      	bcc.n	c0d00f78 <io_event+0x170>
c0d00f76:	e08e      	b.n	c0d01096 <io_event+0x28e>
c0d00f78:	f001 fb1c 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d00f7c:	2800      	cmp	r0, #0
c0d00f7e:	d000      	beq.n	c0d00f82 <io_event+0x17a>
c0d00f80:	e089      	b.n	c0d01096 <io_event+0x28e>
c0d00f82:	68b0      	ldr	r0, [r6, #8]
c0d00f84:	68f1      	ldr	r1, [r6, #12]
c0d00f86:	2438      	movs	r4, #56	; 0x38
c0d00f88:	4360      	muls	r0, r4
c0d00f8a:	6832      	ldr	r2, [r6, #0]
c0d00f8c:	1810      	adds	r0, r2, r0
c0d00f8e:	2900      	cmp	r1, #0
c0d00f90:	d076      	beq.n	c0d01080 <io_event+0x278>
c0d00f92:	4788      	blx	r1
c0d00f94:	2800      	cmp	r0, #0
c0d00f96:	d173      	bne.n	c0d01080 <io_event+0x278>
c0d00f98:	68b0      	ldr	r0, [r6, #8]
c0d00f9a:	1c45      	adds	r5, r0, #1
c0d00f9c:	60b5      	str	r5, [r6, #8]
c0d00f9e:	6830      	ldr	r0, [r6, #0]
c0d00fa0:	2800      	cmp	r0, #0
c0d00fa2:	d1e5      	bne.n	c0d00f70 <io_event+0x168>
c0d00fa4:	e077      	b.n	c0d01096 <io_event+0x28e>
c0d00fa6:	88b0      	ldrh	r0, [r6, #4]
c0d00fa8:	9004      	str	r0, [sp, #16]
c0d00faa:	6830      	ldr	r0, [r6, #0]
c0d00fac:	9003      	str	r0, [sp, #12]
c0d00fae:	483e      	ldr	r0, [pc, #248]	; (c0d010a8 <io_event+0x2a0>)
c0d00fb0:	4601      	mov	r1, r0
c0d00fb2:	79cc      	ldrb	r4, [r1, #7]
c0d00fb4:	798b      	ldrb	r3, [r1, #6]
c0d00fb6:	794d      	ldrb	r5, [r1, #5]
c0d00fb8:	790a      	ldrb	r2, [r1, #4]
c0d00fba:	4630      	mov	r0, r6
c0d00fbc:	78ce      	ldrb	r6, [r1, #3]
c0d00fbe:	68c1      	ldr	r1, [r0, #12]
c0d00fc0:	4668      	mov	r0, sp
c0d00fc2:	6006      	str	r6, [r0, #0]
c0d00fc4:	6041      	str	r1, [r0, #4]
c0d00fc6:	0212      	lsls	r2, r2, #8
c0d00fc8:	432a      	orrs	r2, r5
c0d00fca:	021b      	lsls	r3, r3, #8
c0d00fcc:	4323      	orrs	r3, r4
c0d00fce:	9803      	ldr	r0, [sp, #12]
c0d00fd0:	9904      	ldr	r1, [sp, #16]
c0d00fd2:	f000 fcd5 	bl	c0d01980 <io_seproxyhal_touch_element_callback>
c0d00fd6:	e05e      	b.n	c0d01096 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00fd8:	6868      	ldr	r0, [r5, #4]
c0d00fda:	4286      	cmp	r6, r0
c0d00fdc:	d25b      	bcs.n	c0d01096 <io_event+0x28e>
c0d00fde:	f001 fae9 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d00fe2:	2800      	cmp	r0, #0
c0d00fe4:	d157      	bne.n	c0d01096 <io_event+0x28e>
c0d00fe6:	68a8      	ldr	r0, [r5, #8]
c0d00fe8:	68e9      	ldr	r1, [r5, #12]
c0d00fea:	2438      	movs	r4, #56	; 0x38
c0d00fec:	4360      	muls	r0, r4
c0d00fee:	682a      	ldr	r2, [r5, #0]
c0d00ff0:	1810      	adds	r0, r2, r0
c0d00ff2:	2900      	cmp	r1, #0
c0d00ff4:	d026      	beq.n	c0d01044 <io_event+0x23c>
c0d00ff6:	4788      	blx	r1
c0d00ff8:	2800      	cmp	r0, #0
c0d00ffa:	d123      	bne.n	c0d01044 <io_event+0x23c>
c0d00ffc:	68a8      	ldr	r0, [r5, #8]
c0d00ffe:	1c46      	adds	r6, r0, #1
c0d01000:	60ae      	str	r6, [r5, #8]
c0d01002:	6828      	ldr	r0, [r5, #0]
c0d01004:	2800      	cmp	r0, #0
c0d01006:	d1e7      	bne.n	c0d00fd8 <io_event+0x1d0>
c0d01008:	e045      	b.n	c0d01096 <io_event+0x28e>
c0d0100a:	6828      	ldr	r0, [r5, #0]
c0d0100c:	2800      	cmp	r0, #0
c0d0100e:	d030      	beq.n	c0d01072 <io_event+0x26a>
c0d01010:	68a8      	ldr	r0, [r5, #8]
c0d01012:	6869      	ldr	r1, [r5, #4]
c0d01014:	4288      	cmp	r0, r1
c0d01016:	d22c      	bcs.n	c0d01072 <io_event+0x26a>
c0d01018:	f001 facc 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d0101c:	2800      	cmp	r0, #0
c0d0101e:	d128      	bne.n	c0d01072 <io_event+0x26a>
c0d01020:	68a8      	ldr	r0, [r5, #8]
c0d01022:	68e9      	ldr	r1, [r5, #12]
c0d01024:	2438      	movs	r4, #56	; 0x38
c0d01026:	4360      	muls	r0, r4
c0d01028:	682a      	ldr	r2, [r5, #0]
c0d0102a:	1810      	adds	r0, r2, r0
c0d0102c:	2900      	cmp	r1, #0
c0d0102e:	d015      	beq.n	c0d0105c <io_event+0x254>
c0d01030:	4788      	blx	r1
c0d01032:	2800      	cmp	r0, #0
c0d01034:	d112      	bne.n	c0d0105c <io_event+0x254>
c0d01036:	68a8      	ldr	r0, [r5, #8]
c0d01038:	1c40      	adds	r0, r0, #1
c0d0103a:	60a8      	str	r0, [r5, #8]
c0d0103c:	6829      	ldr	r1, [r5, #0]
c0d0103e:	2900      	cmp	r1, #0
c0d01040:	d1e7      	bne.n	c0d01012 <io_event+0x20a>
c0d01042:	e016      	b.n	c0d01072 <io_event+0x26a>
c0d01044:	2801      	cmp	r0, #1
c0d01046:	d103      	bne.n	c0d01050 <io_event+0x248>
c0d01048:	68a8      	ldr	r0, [r5, #8]
c0d0104a:	4344      	muls	r4, r0
c0d0104c:	6828      	ldr	r0, [r5, #0]
c0d0104e:	1900      	adds	r0, r0, r4
c0d01050:	f000 fd66 	bl	c0d01b20 <io_seproxyhal_display_default>
c0d01054:	68a8      	ldr	r0, [r5, #8]
c0d01056:	1c40      	adds	r0, r0, #1
c0d01058:	60a8      	str	r0, [r5, #8]
c0d0105a:	e01c      	b.n	c0d01096 <io_event+0x28e>
c0d0105c:	2801      	cmp	r0, #1
c0d0105e:	d103      	bne.n	c0d01068 <io_event+0x260>
c0d01060:	68a8      	ldr	r0, [r5, #8]
c0d01062:	4344      	muls	r4, r0
c0d01064:	6828      	ldr	r0, [r5, #0]
c0d01066:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d01068:	f000 fd5a 	bl	c0d01b20 <io_seproxyhal_display_default>
c0d0106c:	68a8      	ldr	r0, [r5, #8]
c0d0106e:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d01070:	60a8      	str	r0, [r5, #8]
c0d01072:	6868      	ldr	r0, [r5, #4]
c0d01074:	68a9      	ldr	r1, [r5, #8]
c0d01076:	4281      	cmp	r1, r0
c0d01078:	d30d      	bcc.n	c0d01096 <io_event+0x28e>
c0d0107a:	f001 fa9b 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d0107e:	e00a      	b.n	c0d01096 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d01080:	2801      	cmp	r0, #1
c0d01082:	d103      	bne.n	c0d0108c <io_event+0x284>
c0d01084:	68b0      	ldr	r0, [r6, #8]
c0d01086:	4344      	muls	r4, r0
c0d01088:	6830      	ldr	r0, [r6, #0]
c0d0108a:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d0108c:	f000 fd48 	bl	c0d01b20 <io_seproxyhal_display_default>
c0d01090:	68b0      	ldr	r0, [r6, #8]
c0d01092:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d01094:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d01096:	f001 fa8d 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d0109a:	2800      	cmp	r0, #0
c0d0109c:	d101      	bne.n	c0d010a2 <io_event+0x29a>
        io_seproxyhal_general_status();
c0d0109e:	f000 fac9 	bl	c0d01634 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d010a2:	2001      	movs	r0, #1
c0d010a4:	b005      	add	sp, #20
c0d010a6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d010a8:	20001a18 	.word	0x20001a18
c0d010ac:	20001a98 	.word	0x20001a98
c0d010b0:	b0105044 	.word	0xb0105044
c0d010b4:	b0105055 	.word	0xb0105055

c0d010b8 <IOTA_main>:





static void IOTA_main(void) {
c0d010b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d010ba:	af03      	add	r7, sp, #12
c0d010bc:	b0dd      	sub	sp, #372	; 0x174
c0d010be:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d010c0:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d010c2:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d010c4:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d010c6:	a0a1      	add	r0, pc, #644	; (adr r0, c0d0134c <IOTA_main+0x294>)
c0d010c8:	2110      	movs	r1, #16
c0d010ca:	2203      	movs	r2, #3
c0d010cc:	9109      	str	r1, [sp, #36]	; 0x24
c0d010ce:	9208      	str	r2, [sp, #32]
c0d010d0:	f7ff f8d2 	bl	c0d00278 <write_debug>
c0d010d4:	a80e      	add	r0, sp, #56	; 0x38
c0d010d6:	304d      	adds	r0, #77	; 0x4d
c0d010d8:	9007      	str	r0, [sp, #28]
c0d010da:	a80b      	add	r0, sp, #44	; 0x2c
c0d010dc:	1dc1      	adds	r1, r0, #7
c0d010de:	9106      	str	r1, [sp, #24]
c0d010e0:	1d00      	adds	r0, r0, #4
c0d010e2:	9005      	str	r0, [sp, #20]
c0d010e4:	4e9d      	ldr	r6, [pc, #628]	; (c0d0135c <IOTA_main+0x2a4>)
c0d010e6:	6830      	ldr	r0, [r6, #0]
c0d010e8:	e08d      	b.n	c0d01206 <IOTA_main+0x14e>
c0d010ea:	489f      	ldr	r0, [pc, #636]	; (c0d01368 <IOTA_main+0x2b0>)
c0d010ec:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d010ee:	4330      	orrs	r0, r6
c0d010f0:	2880      	cmp	r0, #128	; 0x80
c0d010f2:	d000      	beq.n	c0d010f6 <IOTA_main+0x3e>
c0d010f4:	e11e      	b.n	c0d01334 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d010f6:	7810      	ldrb	r0, [r2, #0]
c0d010f8:	2800      	cmp	r0, #0
c0d010fa:	4e98      	ldr	r6, [pc, #608]	; (c0d0135c <IOTA_main+0x2a4>)
c0d010fc:	d004      	beq.n	c0d01108 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d010fe:	489c      	ldr	r0, [pc, #624]	; (c0d01370 <IOTA_main+0x2b8>)
c0d01100:	f001 f90c 	bl	c0d0231c <cx_sha256_init>
                        hashTainted = 0;
c0d01104:	4899      	ldr	r0, [pc, #612]	; (c0d0136c <IOTA_main+0x2b4>)
c0d01106:	7004      	strb	r4, [r0, #0]
c0d01108:	4897      	ldr	r0, [pc, #604]	; (c0d01368 <IOTA_main+0x2b0>)
c0d0110a:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d0110c:	7908      	ldrb	r0, [r1, #4]
c0d0110e:	1808      	adds	r0, r1, r0
c0d01110:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d01112:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d01114:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01116:	4308      	orrs	r0, r1
c0d01118:	905a      	str	r0, [sp, #360]	; 0x168
c0d0111a:	e0e5      	b.n	c0d012e8 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d0111c:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d0111e:	2818      	cmp	r0, #24
c0d01120:	d800      	bhi.n	c0d01124 <IOTA_main+0x6c>
c0d01122:	e10c      	b.n	c0d0133e <IOTA_main+0x286>
c0d01124:	950a      	str	r5, [sp, #40]	; 0x28
c0d01126:	4d90      	ldr	r5, [pc, #576]	; (c0d01368 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d01128:	00a0      	lsls	r0, r4, #2
c0d0112a:	1829      	adds	r1, r5, r0
c0d0112c:	794a      	ldrb	r2, [r1, #5]
c0d0112e:	0612      	lsls	r2, r2, #24
c0d01130:	798b      	ldrb	r3, [r1, #6]
c0d01132:	041b      	lsls	r3, r3, #16
c0d01134:	4313      	orrs	r3, r2
c0d01136:	79ca      	ldrb	r2, [r1, #7]
c0d01138:	0212      	lsls	r2, r2, #8
c0d0113a:	431a      	orrs	r2, r3
c0d0113c:	7a09      	ldrb	r1, [r1, #8]
c0d0113e:	4311      	orrs	r1, r2
c0d01140:	aa2b      	add	r2, sp, #172	; 0xac
c0d01142:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d01144:	1c64      	adds	r4, r4, #1
c0d01146:	2c05      	cmp	r4, #5
c0d01148:	d1ee      	bne.n	c0d01128 <IOTA_main+0x70>
c0d0114a:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d0114c:	9103      	str	r1, [sp, #12]
c0d0114e:	4668      	mov	r0, sp
c0d01150:	6001      	str	r1, [r0, #0]
c0d01152:	2421      	movs	r4, #33	; 0x21
c0d01154:	a92b      	add	r1, sp, #172	; 0xac
c0d01156:	2205      	movs	r2, #5
c0d01158:	ad23      	add	r5, sp, #140	; 0x8c
c0d0115a:	9502      	str	r5, [sp, #8]
c0d0115c:	4620      	mov	r0, r4
c0d0115e:	462b      	mov	r3, r5
c0d01160:	f001 f992 	bl	c0d02488 <os_perso_derive_node_bip32>
c0d01164:	2220      	movs	r2, #32
c0d01166:	9204      	str	r2, [sp, #16]
c0d01168:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d0116a:	9301      	str	r3, [sp, #4]
c0d0116c:	4620      	mov	r0, r4
c0d0116e:	4629      	mov	r1, r5
c0d01170:	f001 f94e 	bl	c0d02410 <cx_ecfp_init_private_key>
c0d01174:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d01176:	4620      	mov	r0, r4
c0d01178:	9903      	ldr	r1, [sp, #12]
c0d0117a:	460a      	mov	r2, r1
c0d0117c:	462b      	mov	r3, r5
c0d0117e:	f001 f929 	bl	c0d023d4 <cx_ecfp_init_public_key>
c0d01182:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d01184:	4620      	mov	r0, r4
c0d01186:	4629      	mov	r1, r5
c0d01188:	9a01      	ldr	r2, [sp, #4]
c0d0118a:	f001 f95f 	bl	c0d0244c <cx_ecfp_generate_pair>
c0d0118e:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d01190:	9802      	ldr	r0, [sp, #8]
c0d01192:	9904      	ldr	r1, [sp, #16]
c0d01194:	4622      	mov	r2, r4
c0d01196:	f7ff f98f 	bl	c0d004b8 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d0119a:	2552      	movs	r5, #82	; 0x52
c0d0119c:	4872      	ldr	r0, [pc, #456]	; (c0d01368 <IOTA_main+0x2b0>)
c0d0119e:	4621      	mov	r1, r4
c0d011a0:	462a      	mov	r2, r5
c0d011a2:	f000 f9ad 	bl	c0d01500 <os_memmove>
                    tx = 82;
c0d011a6:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d011a8:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d011aa:	1c41      	adds	r1, r0, #1
c0d011ac:	915b      	str	r1, [sp, #364]	; 0x16c
c0d011ae:	3610      	adds	r6, #16
c0d011b0:	4a6d      	ldr	r2, [pc, #436]	; (c0d01368 <IOTA_main+0x2b0>)
c0d011b2:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d011b4:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d011b6:	1c41      	adds	r1, r0, #1
c0d011b8:	915b      	str	r1, [sp, #364]	; 0x16c
c0d011ba:	9903      	ldr	r1, [sp, #12]
c0d011bc:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d011be:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d011c0:	b281      	uxth	r1, r0
c0d011c2:	9804      	ldr	r0, [sp, #16]
c0d011c4:	f000 fd2a 	bl	c0d01c1c <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d011c8:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d011ca:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d011cc:	4308      	orrs	r0, r1
c0d011ce:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d011d0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d011d2:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d011d4:	202e      	movs	r0, #46	; 0x2e
c0d011d6:	9905      	ldr	r1, [sp, #20]
c0d011d8:	7048      	strb	r0, [r1, #1]
c0d011da:	7008      	strb	r0, [r1, #0]
c0d011dc:	7088      	strb	r0, [r1, #2]
c0d011de:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d011e0:	78c8      	ldrb	r0, [r1, #3]
c0d011e2:	9a06      	ldr	r2, [sp, #24]
c0d011e4:	70d0      	strb	r0, [r2, #3]
c0d011e6:	7888      	ldrb	r0, [r1, #2]
c0d011e8:	7090      	strb	r0, [r2, #2]
c0d011ea:	7848      	ldrb	r0, [r1, #1]
c0d011ec:	7050      	strb	r0, [r2, #1]
c0d011ee:	7808      	ldrb	r0, [r1, #0]
c0d011f0:	7010      	strb	r0, [r2, #0]
c0d011f2:	7908      	ldrb	r0, [r1, #4]
c0d011f4:	7110      	strb	r0, [r2, #4]
c0d011f6:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d011f8:	2140      	movs	r1, #64	; 0x40
c0d011fa:	2203      	movs	r2, #3
c0d011fc:	f001 fa8a 	bl	c0d02714 <ui_display_debug>
c0d01200:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d01202:	4e56      	ldr	r6, [pc, #344]	; (c0d0135c <IOTA_main+0x2a4>)
c0d01204:	e070      	b.n	c0d012e8 <IOTA_main+0x230>
c0d01206:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d01208:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d0120a:	9057      	str	r0, [sp, #348]	; 0x15c
c0d0120c:	ac4d      	add	r4, sp, #308	; 0x134
c0d0120e:	4620      	mov	r0, r4
c0d01210:	f002 fd52 	bl	c0d03cb8 <setjmp>
c0d01214:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d01216:	6034      	str	r4, [r6, #0]
c0d01218:	4951      	ldr	r1, [pc, #324]	; (c0d01360 <IOTA_main+0x2a8>)
c0d0121a:	4208      	tst	r0, r1
c0d0121c:	d011      	beq.n	c0d01242 <IOTA_main+0x18a>
c0d0121e:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d01220:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d01222:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d01224:	6031      	str	r1, [r6, #0]
c0d01226:	210f      	movs	r1, #15
c0d01228:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d0122a:	4001      	ands	r1, r0
c0d0122c:	2209      	movs	r2, #9
c0d0122e:	0312      	lsls	r2, r2, #12
c0d01230:	4291      	cmp	r1, r2
c0d01232:	d003      	beq.n	c0d0123c <IOTA_main+0x184>
c0d01234:	9a08      	ldr	r2, [sp, #32]
c0d01236:	0352      	lsls	r2, r2, #13
c0d01238:	4291      	cmp	r1, r2
c0d0123a:	d142      	bne.n	c0d012c2 <IOTA_main+0x20a>
c0d0123c:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d0123e:	8008      	strh	r0, [r1, #0]
c0d01240:	e046      	b.n	c0d012d0 <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d01242:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d01244:	905c      	str	r0, [sp, #368]	; 0x170
c0d01246:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d01248:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d0124a:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d0124c:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d0124e:	b2c0      	uxtb	r0, r0
c0d01250:	b289      	uxth	r1, r1
c0d01252:	f000 fce3 	bl	c0d01c1c <io_exchange>
c0d01256:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d01258:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d0125a:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d0125c:	2800      	cmp	r0, #0
c0d0125e:	d053      	beq.n	c0d01308 <IOTA_main+0x250>
c0d01260:	4941      	ldr	r1, [pc, #260]	; (c0d01368 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d01262:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d01264:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d01266:	2880      	cmp	r0, #128	; 0x80
c0d01268:	4a40      	ldr	r2, [pc, #256]	; (c0d0136c <IOTA_main+0x2b4>)
c0d0126a:	d155      	bne.n	c0d01318 <IOTA_main+0x260>
c0d0126c:	7848      	ldrb	r0, [r1, #1]
c0d0126e:	216d      	movs	r1, #109	; 0x6d
c0d01270:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d01272:	2807      	cmp	r0, #7
c0d01274:	dc3f      	bgt.n	c0d012f6 <IOTA_main+0x23e>
c0d01276:	2802      	cmp	r0, #2
c0d01278:	d100      	bne.n	c0d0127c <IOTA_main+0x1c4>
c0d0127a:	e74f      	b.n	c0d0111c <IOTA_main+0x64>
c0d0127c:	2804      	cmp	r0, #4
c0d0127e:	d153      	bne.n	c0d01328 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d01280:	210b      	movs	r1, #11
c0d01282:	2203      	movs	r2, #3
c0d01284:	a03c      	add	r0, pc, #240	; (adr r0, c0d01378 <IOTA_main+0x2c0>)
c0d01286:	f7fe fff7 	bl	c0d00278 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d0128a:	2048      	movs	r0, #72	; 0x48
c0d0128c:	4936      	ldr	r1, [pc, #216]	; (c0d01368 <IOTA_main+0x2b0>)
c0d0128e:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d01290:	2049      	movs	r0, #73	; 0x49
c0d01292:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d01294:	2021      	movs	r0, #33	; 0x21
c0d01296:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d01298:	3610      	adds	r6, #16
c0d0129a:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d0129c:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d0129e:	2005      	movs	r0, #5
c0d012a0:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d012a2:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d012a4:	b281      	uxth	r1, r0
c0d012a6:	2020      	movs	r0, #32
c0d012a8:	f000 fcb8 	bl	c0d01c1c <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d012ac:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d012ae:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d012b0:	4308      	orrs	r0, r1
c0d012b2:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d012b4:	4620      	mov	r0, r4
c0d012b6:	4621      	mov	r1, r4
c0d012b8:	4622      	mov	r2, r4
c0d012ba:	f001 fa2b 	bl	c0d02714 <ui_display_debug>
c0d012be:	4e27      	ldr	r6, [pc, #156]	; (c0d0135c <IOTA_main+0x2a4>)
c0d012c0:	e012      	b.n	c0d012e8 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d012c2:	4928      	ldr	r1, [pc, #160]	; (c0d01364 <IOTA_main+0x2ac>)
c0d012c4:	4008      	ands	r0, r1
c0d012c6:	210d      	movs	r1, #13
c0d012c8:	02c9      	lsls	r1, r1, #11
c0d012ca:	4301      	orrs	r1, r0
c0d012cc:	a859      	add	r0, sp, #356	; 0x164
c0d012ce:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d012d0:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d012d2:	0a00      	lsrs	r0, r0, #8
c0d012d4:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d012d6:	4a24      	ldr	r2, [pc, #144]	; (c0d01368 <IOTA_main+0x2b0>)
c0d012d8:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d012da:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d012dc:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d012de:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d012e0:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d012e2:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d012e4:	1c80      	adds	r0, r0, #2
c0d012e6:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d012e8:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d012ea:	6030      	str	r0, [r6, #0]
c0d012ec:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d012ee:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d012f0:	2900      	cmp	r1, #0
c0d012f2:	d088      	beq.n	c0d01206 <IOTA_main+0x14e>
c0d012f4:	e006      	b.n	c0d01304 <IOTA_main+0x24c>
c0d012f6:	2808      	cmp	r0, #8
c0d012f8:	d100      	bne.n	c0d012fc <IOTA_main+0x244>
c0d012fa:	e6f6      	b.n	c0d010ea <IOTA_main+0x32>
c0d012fc:	28ff      	cmp	r0, #255	; 0xff
c0d012fe:	d113      	bne.n	c0d01328 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d01300:	b05d      	add	sp, #372	; 0x174
c0d01302:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d01304:	f002 fce4 	bl	c0d03cd0 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d01308:	2001      	movs	r0, #1
c0d0130a:	4918      	ldr	r1, [pc, #96]	; (c0d0136c <IOTA_main+0x2b4>)
c0d0130c:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d0130e:	4813      	ldr	r0, [pc, #76]	; (c0d0135c <IOTA_main+0x2a4>)
c0d01310:	6800      	ldr	r0, [r0, #0]
c0d01312:	491c      	ldr	r1, [pc, #112]	; (c0d01384 <IOTA_main+0x2cc>)
c0d01314:	f002 fcdc 	bl	c0d03cd0 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d01318:	2001      	movs	r0, #1
c0d0131a:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d0131c:	480f      	ldr	r0, [pc, #60]	; (c0d0135c <IOTA_main+0x2a4>)
c0d0131e:	6800      	ldr	r0, [r0, #0]
c0d01320:	2137      	movs	r1, #55	; 0x37
c0d01322:	0249      	lsls	r1, r1, #9
c0d01324:	f002 fcd4 	bl	c0d03cd0 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d01328:	2001      	movs	r0, #1
c0d0132a:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d0132c:	480b      	ldr	r0, [pc, #44]	; (c0d0135c <IOTA_main+0x2a4>)
c0d0132e:	6800      	ldr	r0, [r0, #0]
c0d01330:	f002 fcce 	bl	c0d03cd0 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d01334:	4809      	ldr	r0, [pc, #36]	; (c0d0135c <IOTA_main+0x2a4>)
c0d01336:	6800      	ldr	r0, [r0, #0]
c0d01338:	490e      	ldr	r1, [pc, #56]	; (c0d01374 <IOTA_main+0x2bc>)
c0d0133a:	f002 fcc9 	bl	c0d03cd0 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d0133e:	2001      	movs	r0, #1
c0d01340:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d01342:	4806      	ldr	r0, [pc, #24]	; (c0d0135c <IOTA_main+0x2a4>)
c0d01344:	6800      	ldr	r0, [r0, #0]
c0d01346:	3109      	adds	r1, #9
c0d01348:	f002 fcc2 	bl	c0d03cd0 <longjmp>
c0d0134c:	74696157 	.word	0x74696157
c0d01350:	20676e69 	.word	0x20676e69
c0d01354:	20726f66 	.word	0x20726f66
c0d01358:	0067736d 	.word	0x0067736d
c0d0135c:	20001bb8 	.word	0x20001bb8
c0d01360:	0000ffff 	.word	0x0000ffff
c0d01364:	000007ff 	.word	0x000007ff
c0d01368:	20001c08 	.word	0x20001c08
c0d0136c:	20001b48 	.word	0x20001b48
c0d01370:	20001b4c 	.word	0x20001b4c
c0d01374:	00006a86 	.word	0x00006a86
c0d01378:	20646142 	.word	0x20646142
c0d0137c:	6b627550 	.word	0x6b627550
c0d01380:	00007965 	.word	0x00007965
c0d01384:	00006982 	.word	0x00006982

c0d01388 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d01388:	4801      	ldr	r0, [pc, #4]	; (c0d01390 <os_boot+0x8>)
c0d0138a:	2100      	movs	r1, #0
c0d0138c:	6001      	str	r1, [r0, #0]
}
c0d0138e:	4770      	bx	lr
c0d01390:	20001bb8 	.word	0x20001bb8

c0d01394 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d01394:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01396:	af03      	add	r7, sp, #12
c0d01398:	b083      	sub	sp, #12
c0d0139a:	9202      	str	r2, [sp, #8]
c0d0139c:	460c      	mov	r4, r1
c0d0139e:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d013a0:	4d4a      	ldr	r5, [pc, #296]	; (c0d014cc <io_usb_hid_receive+0x138>)
c0d013a2:	42ac      	cmp	r4, r5
c0d013a4:	d00f      	beq.n	c0d013c6 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d013a6:	4e49      	ldr	r6, [pc, #292]	; (c0d014cc <io_usb_hid_receive+0x138>)
c0d013a8:	2540      	movs	r5, #64	; 0x40
c0d013aa:	4630      	mov	r0, r6
c0d013ac:	4629      	mov	r1, r5
c0d013ae:	f002 fbed 	bl	c0d03b8c <__aeabi_memclr>
c0d013b2:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d013b4:	2840      	cmp	r0, #64	; 0x40
c0d013b6:	4602      	mov	r2, r0
c0d013b8:	d300      	bcc.n	c0d013bc <io_usb_hid_receive+0x28>
c0d013ba:	462a      	mov	r2, r5
c0d013bc:	4630      	mov	r0, r6
c0d013be:	4621      	mov	r1, r4
c0d013c0:	f000 f89e 	bl	c0d01500 <os_memmove>
c0d013c4:	4d41      	ldr	r5, [pc, #260]	; (c0d014cc <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d013c6:	78a8      	ldrb	r0, [r5, #2]
c0d013c8:	2805      	cmp	r0, #5
c0d013ca:	d900      	bls.n	c0d013ce <io_usb_hid_receive+0x3a>
c0d013cc:	e076      	b.n	c0d014bc <io_usb_hid_receive+0x128>
c0d013ce:	46c0      	nop			; (mov r8, r8)
c0d013d0:	4478      	add	r0, pc
c0d013d2:	7900      	ldrb	r0, [r0, #4]
c0d013d4:	0040      	lsls	r0, r0, #1
c0d013d6:	4487      	add	pc, r0
c0d013d8:	71130c02 	.word	0x71130c02
c0d013dc:	1f71      	.short	0x1f71
c0d013de:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d013e0:	71ae      	strb	r6, [r5, #6]
c0d013e2:	716e      	strb	r6, [r5, #5]
c0d013e4:	712e      	strb	r6, [r5, #4]
c0d013e6:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d013e8:	2140      	movs	r1, #64	; 0x40
c0d013ea:	4628      	mov	r0, r5
c0d013ec:	9a01      	ldr	r2, [sp, #4]
c0d013ee:	4790      	blx	r2
c0d013f0:	e00b      	b.n	c0d0140a <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d013f2:	1ce8      	adds	r0, r5, #3
c0d013f4:	2104      	movs	r1, #4
c0d013f6:	f000 ff73 	bl	c0d022e0 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d013fa:	2140      	movs	r1, #64	; 0x40
c0d013fc:	4628      	mov	r0, r5
c0d013fe:	e001      	b.n	c0d01404 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d01400:	4832      	ldr	r0, [pc, #200]	; (c0d014cc <io_usb_hid_receive+0x138>)
c0d01402:	2140      	movs	r1, #64	; 0x40
c0d01404:	9a01      	ldr	r2, [sp, #4]
c0d01406:	4790      	blx	r2
c0d01408:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d0140a:	4831      	ldr	r0, [pc, #196]	; (c0d014d0 <io_usb_hid_receive+0x13c>)
c0d0140c:	2100      	movs	r1, #0
c0d0140e:	6001      	str	r1, [r0, #0]
c0d01410:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d01412:	b2c0      	uxtb	r0, r0
c0d01414:	b003      	add	sp, #12
c0d01416:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d01418:	78e8      	ldrb	r0, [r5, #3]
c0d0141a:	4c2d      	ldr	r4, [pc, #180]	; (c0d014d0 <io_usb_hid_receive+0x13c>)
c0d0141c:	6821      	ldr	r1, [r4, #0]
c0d0141e:	0a09      	lsrs	r1, r1, #8
c0d01420:	2600      	movs	r6, #0
c0d01422:	4288      	cmp	r0, r1
c0d01424:	d1f1      	bne.n	c0d0140a <io_usb_hid_receive+0x76>
c0d01426:	7928      	ldrb	r0, [r5, #4]
c0d01428:	6821      	ldr	r1, [r4, #0]
c0d0142a:	b2c9      	uxtb	r1, r1
c0d0142c:	4288      	cmp	r0, r1
c0d0142e:	d1ec      	bne.n	c0d0140a <io_usb_hid_receive+0x76>
c0d01430:	4b28      	ldr	r3, [pc, #160]	; (c0d014d4 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d01432:	9802      	ldr	r0, [sp, #8]
c0d01434:	18c0      	adds	r0, r0, r3
c0d01436:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d01438:	6820      	ldr	r0, [r4, #0]
c0d0143a:	2800      	cmp	r0, #0
c0d0143c:	d00e      	beq.n	c0d0145c <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d0143e:	4629      	mov	r1, r5
c0d01440:	4019      	ands	r1, r3
c0d01442:	4825      	ldr	r0, [pc, #148]	; (c0d014d8 <io_usb_hid_receive+0x144>)
c0d01444:	6802      	ldr	r2, [r0, #0]
c0d01446:	4291      	cmp	r1, r2
c0d01448:	461e      	mov	r6, r3
c0d0144a:	d900      	bls.n	c0d0144e <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d0144c:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d0144e:	462a      	mov	r2, r5
c0d01450:	4032      	ands	r2, r6
c0d01452:	4822      	ldr	r0, [pc, #136]	; (c0d014dc <io_usb_hid_receive+0x148>)
c0d01454:	6800      	ldr	r0, [r0, #0]
c0d01456:	491d      	ldr	r1, [pc, #116]	; (c0d014cc <io_usb_hid_receive+0x138>)
c0d01458:	1d49      	adds	r1, r1, #5
c0d0145a:	e021      	b.n	c0d014a0 <io_usb_hid_receive+0x10c>
c0d0145c:	9301      	str	r3, [sp, #4]
c0d0145e:	491b      	ldr	r1, [pc, #108]	; (c0d014cc <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d01460:	7988      	ldrb	r0, [r1, #6]
c0d01462:	7949      	ldrb	r1, [r1, #5]
c0d01464:	0209      	lsls	r1, r1, #8
c0d01466:	4301      	orrs	r1, r0
c0d01468:	481d      	ldr	r0, [pc, #116]	; (c0d014e0 <io_usb_hid_receive+0x14c>)
c0d0146a:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d0146c:	6801      	ldr	r1, [r0, #0]
c0d0146e:	2241      	movs	r2, #65	; 0x41
c0d01470:	0092      	lsls	r2, r2, #2
c0d01472:	4291      	cmp	r1, r2
c0d01474:	d8c9      	bhi.n	c0d0140a <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d01476:	6801      	ldr	r1, [r0, #0]
c0d01478:	4817      	ldr	r0, [pc, #92]	; (c0d014d8 <io_usb_hid_receive+0x144>)
c0d0147a:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d0147c:	4917      	ldr	r1, [pc, #92]	; (c0d014dc <io_usb_hid_receive+0x148>)
c0d0147e:	4a19      	ldr	r2, [pc, #100]	; (c0d014e4 <io_usb_hid_receive+0x150>)
c0d01480:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d01482:	4919      	ldr	r1, [pc, #100]	; (c0d014e8 <io_usb_hid_receive+0x154>)
c0d01484:	9a02      	ldr	r2, [sp, #8]
c0d01486:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d01488:	4629      	mov	r1, r5
c0d0148a:	9e01      	ldr	r6, [sp, #4]
c0d0148c:	4031      	ands	r1, r6
c0d0148e:	6802      	ldr	r2, [r0, #0]
c0d01490:	4291      	cmp	r1, r2
c0d01492:	d900      	bls.n	c0d01496 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d01494:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d01496:	462a      	mov	r2, r5
c0d01498:	4032      	ands	r2, r6
c0d0149a:	480c      	ldr	r0, [pc, #48]	; (c0d014cc <io_usb_hid_receive+0x138>)
c0d0149c:	1dc1      	adds	r1, r0, #7
c0d0149e:	4811      	ldr	r0, [pc, #68]	; (c0d014e4 <io_usb_hid_receive+0x150>)
c0d014a0:	f000 f82e 	bl	c0d01500 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d014a4:	4035      	ands	r5, r6
c0d014a6:	480d      	ldr	r0, [pc, #52]	; (c0d014dc <io_usb_hid_receive+0x148>)
c0d014a8:	6801      	ldr	r1, [r0, #0]
c0d014aa:	1949      	adds	r1, r1, r5
c0d014ac:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d014ae:	480a      	ldr	r0, [pc, #40]	; (c0d014d8 <io_usb_hid_receive+0x144>)
c0d014b0:	6801      	ldr	r1, [r0, #0]
c0d014b2:	1b49      	subs	r1, r1, r5
c0d014b4:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d014b6:	6820      	ldr	r0, [r4, #0]
c0d014b8:	1c40      	adds	r0, r0, #1
c0d014ba:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d014bc:	4806      	ldr	r0, [pc, #24]	; (c0d014d8 <io_usb_hid_receive+0x144>)
c0d014be:	6801      	ldr	r1, [r0, #0]
c0d014c0:	2001      	movs	r0, #1
c0d014c2:	2602      	movs	r6, #2
c0d014c4:	2900      	cmp	r1, #0
c0d014c6:	d1a4      	bne.n	c0d01412 <io_usb_hid_receive+0x7e>
c0d014c8:	e79f      	b.n	c0d0140a <io_usb_hid_receive+0x76>
c0d014ca:	46c0      	nop			; (mov r8, r8)
c0d014cc:	20001bbc 	.word	0x20001bbc
c0d014d0:	20001bfc 	.word	0x20001bfc
c0d014d4:	0000ffff 	.word	0x0000ffff
c0d014d8:	20001c04 	.word	0x20001c04
c0d014dc:	20001d0c 	.word	0x20001d0c
c0d014e0:	20001c00 	.word	0x20001c00
c0d014e4:	20001c08 	.word	0x20001c08
c0d014e8:	0001fff9 	.word	0x0001fff9

c0d014ec <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d014ec:	b580      	push	{r7, lr}
c0d014ee:	af00      	add	r7, sp, #0
c0d014f0:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d014f2:	2a00      	cmp	r2, #0
c0d014f4:	d003      	beq.n	c0d014fe <os_memset+0x12>
    DSTCHAR[length] = c;
c0d014f6:	4611      	mov	r1, r2
c0d014f8:	461a      	mov	r2, r3
c0d014fa:	f002 fb51 	bl	c0d03ba0 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d014fe:	bd80      	pop	{r7, pc}

c0d01500 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d01500:	b5b0      	push	{r4, r5, r7, lr}
c0d01502:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d01504:	4288      	cmp	r0, r1
c0d01506:	d90d      	bls.n	c0d01524 <os_memmove+0x24>
    while(length--) {
c0d01508:	2a00      	cmp	r2, #0
c0d0150a:	d014      	beq.n	c0d01536 <os_memmove+0x36>
c0d0150c:	1e49      	subs	r1, r1, #1
c0d0150e:	4252      	negs	r2, r2
c0d01510:	1e40      	subs	r0, r0, #1
c0d01512:	2300      	movs	r3, #0
c0d01514:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d01516:	461c      	mov	r4, r3
c0d01518:	4354      	muls	r4, r2
c0d0151a:	5d0d      	ldrb	r5, [r1, r4]
c0d0151c:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d0151e:	1c52      	adds	r2, r2, #1
c0d01520:	d1f9      	bne.n	c0d01516 <os_memmove+0x16>
c0d01522:	e008      	b.n	c0d01536 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01524:	2a00      	cmp	r2, #0
c0d01526:	d006      	beq.n	c0d01536 <os_memmove+0x36>
c0d01528:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d0152a:	b29c      	uxth	r4, r3
c0d0152c:	5d0d      	ldrb	r5, [r1, r4]
c0d0152e:	5505      	strb	r5, [r0, r4]
      l++;
c0d01530:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01532:	1e52      	subs	r2, r2, #1
c0d01534:	d1f9      	bne.n	c0d0152a <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d01536:	bdb0      	pop	{r4, r5, r7, pc}

c0d01538 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01538:	4801      	ldr	r0, [pc, #4]	; (c0d01540 <io_usb_hid_init+0x8>)
c0d0153a:	2100      	movs	r1, #0
c0d0153c:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d0153e:	4770      	bx	lr
c0d01540:	20001bfc 	.word	0x20001bfc

c0d01544 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d01544:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01546:	af03      	add	r7, sp, #12
c0d01548:	b087      	sub	sp, #28
c0d0154a:	9301      	str	r3, [sp, #4]
c0d0154c:	9203      	str	r2, [sp, #12]
c0d0154e:	460e      	mov	r6, r1
c0d01550:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d01552:	2e00      	cmp	r6, #0
c0d01554:	d042      	beq.n	c0d015dc <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d01556:	4d31      	ldr	r5, [pc, #196]	; (c0d0161c <io_usb_hid_exchange+0xd8>)
c0d01558:	2000      	movs	r0, #0
c0d0155a:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d0155c:	4930      	ldr	r1, [pc, #192]	; (c0d01620 <io_usb_hid_exchange+0xdc>)
c0d0155e:	4831      	ldr	r0, [pc, #196]	; (c0d01624 <io_usb_hid_exchange+0xe0>)
c0d01560:	6008      	str	r0, [r1, #0]
c0d01562:	4c31      	ldr	r4, [pc, #196]	; (c0d01628 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01564:	1d60      	adds	r0, r4, #5
c0d01566:	213b      	movs	r1, #59	; 0x3b
c0d01568:	9005      	str	r0, [sp, #20]
c0d0156a:	9102      	str	r1, [sp, #8]
c0d0156c:	f002 fb0e 	bl	c0d03b8c <__aeabi_memclr>
c0d01570:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d01572:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d01574:	6828      	ldr	r0, [r5, #0]
c0d01576:	0a00      	lsrs	r0, r0, #8
c0d01578:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d0157a:	6828      	ldr	r0, [r5, #0]
c0d0157c:	7120      	strb	r0, [r4, #4]
c0d0157e:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d01580:	6828      	ldr	r0, [r5, #0]
c0d01582:	2800      	cmp	r0, #0
c0d01584:	9106      	str	r1, [sp, #24]
c0d01586:	d009      	beq.n	c0d0159c <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d01588:	293b      	cmp	r1, #59	; 0x3b
c0d0158a:	460a      	mov	r2, r1
c0d0158c:	d300      	bcc.n	c0d01590 <io_usb_hid_exchange+0x4c>
c0d0158e:	9a02      	ldr	r2, [sp, #8]
c0d01590:	4823      	ldr	r0, [pc, #140]	; (c0d01620 <io_usb_hid_exchange+0xdc>)
c0d01592:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d01594:	6819      	ldr	r1, [r3, #0]
c0d01596:	9805      	ldr	r0, [sp, #20]
c0d01598:	461e      	mov	r6, r3
c0d0159a:	e00a      	b.n	c0d015b2 <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d0159c:	0a30      	lsrs	r0, r6, #8
c0d0159e:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d015a0:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d015a2:	2039      	movs	r0, #57	; 0x39
c0d015a4:	2939      	cmp	r1, #57	; 0x39
c0d015a6:	460a      	mov	r2, r1
c0d015a8:	d300      	bcc.n	c0d015ac <io_usb_hid_exchange+0x68>
c0d015aa:	4602      	mov	r2, r0
c0d015ac:	4e1c      	ldr	r6, [pc, #112]	; (c0d01620 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d015ae:	6831      	ldr	r1, [r6, #0]
c0d015b0:	1de0      	adds	r0, r4, #7
c0d015b2:	9205      	str	r2, [sp, #20]
c0d015b4:	f7ff ffa4 	bl	c0d01500 <os_memmove>
c0d015b8:	4d18      	ldr	r5, [pc, #96]	; (c0d0161c <io_usb_hid_exchange+0xd8>)
c0d015ba:	6830      	ldr	r0, [r6, #0]
c0d015bc:	4631      	mov	r1, r6
c0d015be:	9e05      	ldr	r6, [sp, #20]
c0d015c0:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d015c2:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d015c4:	6828      	ldr	r0, [r5, #0]
c0d015c6:	1c40      	adds	r0, r0, #1
c0d015c8:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d015ca:	2140      	movs	r1, #64	; 0x40
c0d015cc:	4620      	mov	r0, r4
c0d015ce:	9a04      	ldr	r2, [sp, #16]
c0d015d0:	4790      	blx	r2
c0d015d2:	9806      	ldr	r0, [sp, #24]
c0d015d4:	1b86      	subs	r6, r0, r6
c0d015d6:	4815      	ldr	r0, [pc, #84]	; (c0d0162c <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d015d8:	4206      	tst	r6, r0
c0d015da:	d1c3      	bne.n	c0d01564 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d015dc:	480f      	ldr	r0, [pc, #60]	; (c0d0161c <io_usb_hid_exchange+0xd8>)
c0d015de:	2400      	movs	r4, #0
c0d015e0:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d015e2:	2080      	movs	r0, #128	; 0x80
c0d015e4:	9901      	ldr	r1, [sp, #4]
c0d015e6:	4201      	tst	r1, r0
c0d015e8:	d001      	beq.n	c0d015ee <io_usb_hid_exchange+0xaa>
    reset();
c0d015ea:	f000 fe3f 	bl	c0d0226c <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d015ee:	9801      	ldr	r0, [sp, #4]
c0d015f0:	0680      	lsls	r0, r0, #26
c0d015f2:	d40f      	bmi.n	c0d01614 <io_usb_hid_exchange+0xd0>
c0d015f4:	4c0c      	ldr	r4, [pc, #48]	; (c0d01628 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d015f6:	2140      	movs	r1, #64	; 0x40
c0d015f8:	4620      	mov	r0, r4
c0d015fa:	9a03      	ldr	r2, [sp, #12]
c0d015fc:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d015fe:	b2c2      	uxtb	r2, r0
c0d01600:	2a40      	cmp	r2, #64	; 0x40
c0d01602:	d8f8      	bhi.n	c0d015f6 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d01604:	9804      	ldr	r0, [sp, #16]
c0d01606:	4621      	mov	r1, r4
c0d01608:	f7ff fec4 	bl	c0d01394 <io_usb_hid_receive>
c0d0160c:	2802      	cmp	r0, #2
c0d0160e:	d1f2      	bne.n	c0d015f6 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d01610:	4807      	ldr	r0, [pc, #28]	; (c0d01630 <io_usb_hid_exchange+0xec>)
c0d01612:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d01614:	b2a0      	uxth	r0, r4
c0d01616:	b007      	add	sp, #28
c0d01618:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0161a:	46c0      	nop			; (mov r8, r8)
c0d0161c:	20001bfc 	.word	0x20001bfc
c0d01620:	20001d0c 	.word	0x20001d0c
c0d01624:	20001c08 	.word	0x20001c08
c0d01628:	20001bbc 	.word	0x20001bbc
c0d0162c:	0000ffff 	.word	0x0000ffff
c0d01630:	20001c00 	.word	0x20001c00

c0d01634 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d01634:	b580      	push	{r7, lr}
c0d01636:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d01638:	f000 ffbc 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d0163c:	2800      	cmp	r0, #0
c0d0163e:	d10b      	bne.n	c0d01658 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d01640:	4806      	ldr	r0, [pc, #24]	; (c0d0165c <io_seproxyhal_general_status+0x28>)
c0d01642:	2160      	movs	r1, #96	; 0x60
c0d01644:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d01646:	2100      	movs	r1, #0
c0d01648:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d0164a:	2202      	movs	r2, #2
c0d0164c:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d0164e:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d01650:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d01652:	2105      	movs	r1, #5
c0d01654:	f000 ff90 	bl	c0d02578 <io_seproxyhal_spi_send>
}
c0d01658:	bd80      	pop	{r7, pc}
c0d0165a:	46c0      	nop			; (mov r8, r8)
c0d0165c:	20001a18 	.word	0x20001a18

c0d01660 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d01660:	b5d0      	push	{r4, r6, r7, lr}
c0d01662:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d01664:	4815      	ldr	r0, [pc, #84]	; (c0d016bc <io_seproxyhal_handle_usb_event+0x5c>)
c0d01666:	78c0      	ldrb	r0, [r0, #3]
c0d01668:	1e40      	subs	r0, r0, #1
c0d0166a:	2807      	cmp	r0, #7
c0d0166c:	d824      	bhi.n	c0d016b8 <io_seproxyhal_handle_usb_event+0x58>
c0d0166e:	46c0      	nop			; (mov r8, r8)
c0d01670:	4478      	add	r0, pc
c0d01672:	7900      	ldrb	r0, [r0, #4]
c0d01674:	0040      	lsls	r0, r0, #1
c0d01676:	4487      	add	pc, r0
c0d01678:	141f1803 	.word	0x141f1803
c0d0167c:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d01680:	4c0f      	ldr	r4, [pc, #60]	; (c0d016c0 <io_seproxyhal_handle_usb_event+0x60>)
c0d01682:	2101      	movs	r1, #1
c0d01684:	4620      	mov	r0, r4
c0d01686:	f001 fbd5 	bl	c0d02e34 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d0168a:	4620      	mov	r0, r4
c0d0168c:	f001 fbba 	bl	c0d02e04 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d01690:	480c      	ldr	r0, [pc, #48]	; (c0d016c4 <io_seproxyhal_handle_usb_event+0x64>)
c0d01692:	7800      	ldrb	r0, [r0, #0]
c0d01694:	2801      	cmp	r0, #1
c0d01696:	d10f      	bne.n	c0d016b8 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d01698:	480b      	ldr	r0, [pc, #44]	; (c0d016c8 <io_seproxyhal_handle_usb_event+0x68>)
c0d0169a:	6800      	ldr	r0, [r0, #0]
c0d0169c:	2110      	movs	r1, #16
c0d0169e:	f002 fb17 	bl	c0d03cd0 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d016a2:	4807      	ldr	r0, [pc, #28]	; (c0d016c0 <io_seproxyhal_handle_usb_event+0x60>)
c0d016a4:	f001 fbc9 	bl	c0d02e3a <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d016a8:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d016aa:	4805      	ldr	r0, [pc, #20]	; (c0d016c0 <io_seproxyhal_handle_usb_event+0x60>)
c0d016ac:	f001 fbc9 	bl	c0d02e42 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d016b0:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d016b2:	4803      	ldr	r0, [pc, #12]	; (c0d016c0 <io_seproxyhal_handle_usb_event+0x60>)
c0d016b4:	f001 fbc3 	bl	c0d02e3e <USBD_LL_Resume>
      break;
  }
}
c0d016b8:	bdd0      	pop	{r4, r6, r7, pc}
c0d016ba:	46c0      	nop			; (mov r8, r8)
c0d016bc:	20001a18 	.word	0x20001a18
c0d016c0:	20001d34 	.word	0x20001d34
c0d016c4:	20001d10 	.word	0x20001d10
c0d016c8:	20001bb8 	.word	0x20001bb8

c0d016cc <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d016cc:	217f      	movs	r1, #127	; 0x7f
c0d016ce:	4001      	ands	r1, r0
c0d016d0:	4801      	ldr	r0, [pc, #4]	; (c0d016d8 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d016d2:	5c40      	ldrb	r0, [r0, r1]
c0d016d4:	4770      	bx	lr
c0d016d6:	46c0      	nop			; (mov r8, r8)
c0d016d8:	20001d11 	.word	0x20001d11

c0d016dc <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d016dc:	b580      	push	{r7, lr}
c0d016de:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d016e0:	480f      	ldr	r0, [pc, #60]	; (c0d01720 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d016e2:	7901      	ldrb	r1, [r0, #4]
c0d016e4:	2904      	cmp	r1, #4
c0d016e6:	d008      	beq.n	c0d016fa <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d016e8:	2902      	cmp	r1, #2
c0d016ea:	d011      	beq.n	c0d01710 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d016ec:	2901      	cmp	r1, #1
c0d016ee:	d10e      	bne.n	c0d0170e <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d016f0:	1d81      	adds	r1, r0, #6
c0d016f2:	480d      	ldr	r0, [pc, #52]	; (c0d01728 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d016f4:	f001 faaa 	bl	c0d02c4c <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d016f8:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d016fa:	78c2      	ldrb	r2, [r0, #3]
c0d016fc:	217f      	movs	r1, #127	; 0x7f
c0d016fe:	4011      	ands	r1, r2
c0d01700:	7942      	ldrb	r2, [r0, #5]
c0d01702:	4b08      	ldr	r3, [pc, #32]	; (c0d01724 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d01704:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01706:	1d82      	adds	r2, r0, #6
c0d01708:	4807      	ldr	r0, [pc, #28]	; (c0d01728 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d0170a:	f001 fad1 	bl	c0d02cb0 <USBD_LL_DataOutStage>
      break;
  }
}
c0d0170e:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01710:	78c2      	ldrb	r2, [r0, #3]
c0d01712:	217f      	movs	r1, #127	; 0x7f
c0d01714:	4011      	ands	r1, r2
c0d01716:	1d82      	adds	r2, r0, #6
c0d01718:	4803      	ldr	r0, [pc, #12]	; (c0d01728 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d0171a:	f001 fb0f 	bl	c0d02d3c <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d0171e:	bd80      	pop	{r7, pc}
c0d01720:	20001a18 	.word	0x20001a18
c0d01724:	20001d11 	.word	0x20001d11
c0d01728:	20001d34 	.word	0x20001d34

c0d0172c <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d0172c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0172e:	af03      	add	r7, sp, #12
c0d01730:	b083      	sub	sp, #12
c0d01732:	9201      	str	r2, [sp, #4]
c0d01734:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d01736:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d01738:	2b00      	cmp	r3, #0
c0d0173a:	d100      	bne.n	c0d0173e <io_usb_send_ep+0x12>
c0d0173c:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d0173e:	9801      	ldr	r0, [sp, #4]
c0d01740:	28ff      	cmp	r0, #255	; 0xff
c0d01742:	d843      	bhi.n	c0d017cc <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01744:	4e25      	ldr	r6, [pc, #148]	; (c0d017dc <io_usb_send_ep+0xb0>)
c0d01746:	2050      	movs	r0, #80	; 0x50
c0d01748:	7030      	strb	r0, [r6, #0]
c0d0174a:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d0174c:	1ce0      	adds	r0, r4, #3
c0d0174e:	9100      	str	r1, [sp, #0]
c0d01750:	0a01      	lsrs	r1, r0, #8
c0d01752:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d01754:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d01756:	2080      	movs	r0, #128	; 0x80
c0d01758:	4302      	orrs	r2, r0
c0d0175a:	9202      	str	r2, [sp, #8]
c0d0175c:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0175e:	2020      	movs	r0, #32
c0d01760:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d01762:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d01764:	2106      	movs	r1, #6
c0d01766:	4630      	mov	r0, r6
c0d01768:	f000 ff06 	bl	c0d02578 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d0176c:	9800      	ldr	r0, [sp, #0]
c0d0176e:	4621      	mov	r1, r4
c0d01770:	f000 ff02 	bl	c0d02578 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d01774:	2d00      	cmp	r5, #0
c0d01776:	d10d      	bne.n	c0d01794 <io_usb_send_ep+0x68>
c0d01778:	e028      	b.n	c0d017cc <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d0177a:	2d00      	cmp	r5, #0
c0d0177c:	d002      	beq.n	c0d01784 <io_usb_send_ep+0x58>
c0d0177e:	1e6c      	subs	r4, r5, #1
c0d01780:	2d01      	cmp	r5, #1
c0d01782:	d025      	beq.n	c0d017d0 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d01784:	2915      	cmp	r1, #21
c0d01786:	d102      	bne.n	c0d0178e <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d01788:	79b0      	ldrb	r0, [r6, #6]
c0d0178a:	0700      	lsls	r0, r0, #28
c0d0178c:	d520      	bpl.n	c0d017d0 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d0178e:	f000 f829 	bl	c0d017e4 <io_seproxyhal_handle_event>
c0d01792:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01794:	f000 ff0e 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d01798:	2800      	cmp	r0, #0
c0d0179a:	d101      	bne.n	c0d017a0 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d0179c:	f7ff ff4a 	bl	c0d01634 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d017a0:	2180      	movs	r1, #128	; 0x80
c0d017a2:	2400      	movs	r4, #0
c0d017a4:	4630      	mov	r0, r6
c0d017a6:	4622      	mov	r2, r4
c0d017a8:	f000 ff20 	bl	c0d025ec <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d017ac:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d017ae:	2806      	cmp	r0, #6
c0d017b0:	d1e3      	bne.n	c0d0177a <io_usb_send_ep+0x4e>
c0d017b2:	2910      	cmp	r1, #16
c0d017b4:	d1e1      	bne.n	c0d0177a <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d017b6:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d017b8:	9a02      	ldr	r2, [sp, #8]
c0d017ba:	4290      	cmp	r0, r2
c0d017bc:	d1dd      	bne.n	c0d0177a <io_usb_send_ep+0x4e>
c0d017be:	7930      	ldrb	r0, [r6, #4]
c0d017c0:	2802      	cmp	r0, #2
c0d017c2:	d1da      	bne.n	c0d0177a <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d017c4:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d017c6:	9a01      	ldr	r2, [sp, #4]
c0d017c8:	4290      	cmp	r0, r2
c0d017ca:	d1d6      	bne.n	c0d0177a <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d017cc:	b003      	add	sp, #12
c0d017ce:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d017d0:	4803      	ldr	r0, [pc, #12]	; (c0d017e0 <io_usb_send_ep+0xb4>)
c0d017d2:	6800      	ldr	r0, [r0, #0]
c0d017d4:	2110      	movs	r1, #16
c0d017d6:	f002 fa7b 	bl	c0d03cd0 <longjmp>
c0d017da:	46c0      	nop			; (mov r8, r8)
c0d017dc:	20001a18 	.word	0x20001a18
c0d017e0:	20001bb8 	.word	0x20001bb8

c0d017e4 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d017e4:	b580      	push	{r7, lr}
c0d017e6:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d017e8:	480d      	ldr	r0, [pc, #52]	; (c0d01820 <io_seproxyhal_handle_event+0x3c>)
c0d017ea:	7882      	ldrb	r2, [r0, #2]
c0d017ec:	7841      	ldrb	r1, [r0, #1]
c0d017ee:	0209      	lsls	r1, r1, #8
c0d017f0:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d017f2:	7800      	ldrb	r0, [r0, #0]
c0d017f4:	2810      	cmp	r0, #16
c0d017f6:	d008      	beq.n	c0d0180a <io_seproxyhal_handle_event+0x26>
c0d017f8:	280f      	cmp	r0, #15
c0d017fa:	d10d      	bne.n	c0d01818 <io_seproxyhal_handle_event+0x34>
c0d017fc:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d017fe:	2904      	cmp	r1, #4
c0d01800:	d10d      	bne.n	c0d0181e <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d01802:	f7ff ff2d 	bl	c0d01660 <io_seproxyhal_handle_usb_event>
c0d01806:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01808:	bd80      	pop	{r7, pc}
c0d0180a:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d0180c:	2906      	cmp	r1, #6
c0d0180e:	d306      	bcc.n	c0d0181e <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d01810:	f7ff ff64 	bl	c0d016dc <io_seproxyhal_handle_usb_ep_xfer_event>
c0d01814:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01816:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d01818:	2002      	movs	r0, #2
c0d0181a:	f7ff faf5 	bl	c0d00e08 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d0181e:	bd80      	pop	{r7, pc}
c0d01820:	20001a18 	.word	0x20001a18

c0d01824 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01824:	b580      	push	{r7, lr}
c0d01826:	af00      	add	r7, sp, #0
c0d01828:	460a      	mov	r2, r1
c0d0182a:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d0182c:	2082      	movs	r0, #130	; 0x82
c0d0182e:	2314      	movs	r3, #20
c0d01830:	f7ff ff7c 	bl	c0d0172c <io_usb_send_ep>
}
c0d01834:	bd80      	pop	{r7, pc}
	...

c0d01838 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01838:	b5d0      	push	{r4, r6, r7, lr}
c0d0183a:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d0183c:	2007      	movs	r0, #7
c0d0183e:	f000 fcf7 	bl	c0d02230 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d01842:	480a      	ldr	r0, [pc, #40]	; (c0d0186c <io_seproxyhal_init+0x34>)
c0d01844:	2400      	movs	r4, #0
c0d01846:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01848:	4809      	ldr	r0, [pc, #36]	; (c0d01870 <io_seproxyhal_init+0x38>)
c0d0184a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d0184c:	4809      	ldr	r0, [pc, #36]	; (c0d01874 <io_seproxyhal_init+0x3c>)
c0d0184e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d01850:	4809      	ldr	r0, [pc, #36]	; (c0d01878 <io_seproxyhal_init+0x40>)
c0d01852:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01854:	4809      	ldr	r0, [pc, #36]	; (c0d0187c <io_seproxyhal_init+0x44>)
c0d01856:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d01858:	f7ff fe6e 	bl	c0d01538 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d0185c:	4808      	ldr	r0, [pc, #32]	; (c0d01880 <io_seproxyhal_init+0x48>)
c0d0185e:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d01860:	4808      	ldr	r0, [pc, #32]	; (c0d01884 <io_seproxyhal_init+0x4c>)
c0d01862:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d01864:	4808      	ldr	r0, [pc, #32]	; (c0d01888 <io_seproxyhal_init+0x50>)
c0d01866:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d01868:	bdd0      	pop	{r4, r6, r7, pc}
c0d0186a:	46c0      	nop			; (mov r8, r8)
c0d0186c:	20001d18 	.word	0x20001d18
c0d01870:	20001d1a 	.word	0x20001d1a
c0d01874:	20001d1c 	.word	0x20001d1c
c0d01878:	20001d1e 	.word	0x20001d1e
c0d0187c:	20001d10 	.word	0x20001d10
c0d01880:	20001d20 	.word	0x20001d20
c0d01884:	20001d24 	.word	0x20001d24
c0d01888:	20001d28 	.word	0x20001d28

c0d0188c <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d0188c:	4801      	ldr	r0, [pc, #4]	; (c0d01894 <io_seproxyhal_init_ux+0x8>)
c0d0188e:	2100      	movs	r1, #0
c0d01890:	6001      	str	r1, [r0, #0]

}
c0d01892:	4770      	bx	lr
c0d01894:	20001d20 	.word	0x20001d20

c0d01898 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01898:	b5b0      	push	{r4, r5, r7, lr}
c0d0189a:	af02      	add	r7, sp, #8
c0d0189c:	460d      	mov	r5, r1
c0d0189e:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d018a0:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d018a2:	2800      	cmp	r0, #0
c0d018a4:	d00c      	beq.n	c0d018c0 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d018a6:	f000 fcab 	bl	c0d02200 <pic>
c0d018aa:	4601      	mov	r1, r0
c0d018ac:	4620      	mov	r0, r4
c0d018ae:	4788      	blx	r1
c0d018b0:	f000 fca6 	bl	c0d02200 <pic>
c0d018b4:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d018b6:	2800      	cmp	r0, #0
c0d018b8:	d010      	beq.n	c0d018dc <io_seproxyhal_touch_out+0x44>
c0d018ba:	2801      	cmp	r0, #1
c0d018bc:	d000      	beq.n	c0d018c0 <io_seproxyhal_touch_out+0x28>
c0d018be:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d018c0:	2d00      	cmp	r5, #0
c0d018c2:	d007      	beq.n	c0d018d4 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d018c4:	4620      	mov	r0, r4
c0d018c6:	47a8      	blx	r5
c0d018c8:	2100      	movs	r1, #0
    if (!el) {
c0d018ca:	2800      	cmp	r0, #0
c0d018cc:	d006      	beq.n	c0d018dc <io_seproxyhal_touch_out+0x44>
c0d018ce:	2801      	cmp	r0, #1
c0d018d0:	d000      	beq.n	c0d018d4 <io_seproxyhal_touch_out+0x3c>
c0d018d2:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d018d4:	4620      	mov	r0, r4
c0d018d6:	f7ff fa91 	bl	c0d00dfc <io_seproxyhal_display>
c0d018da:	2101      	movs	r1, #1
  return 1;
}
c0d018dc:	4608      	mov	r0, r1
c0d018de:	bdb0      	pop	{r4, r5, r7, pc}

c0d018e0 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d018e0:	b5b0      	push	{r4, r5, r7, lr}
c0d018e2:	af02      	add	r7, sp, #8
c0d018e4:	b08e      	sub	sp, #56	; 0x38
c0d018e6:	460c      	mov	r4, r1
c0d018e8:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d018ea:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d018ec:	2800      	cmp	r0, #0
c0d018ee:	d00c      	beq.n	c0d0190a <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d018f0:	f000 fc86 	bl	c0d02200 <pic>
c0d018f4:	4601      	mov	r1, r0
c0d018f6:	4628      	mov	r0, r5
c0d018f8:	4788      	blx	r1
c0d018fa:	f000 fc81 	bl	c0d02200 <pic>
c0d018fe:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01900:	2800      	cmp	r0, #0
c0d01902:	d016      	beq.n	c0d01932 <io_seproxyhal_touch_over+0x52>
c0d01904:	2801      	cmp	r0, #1
c0d01906:	d000      	beq.n	c0d0190a <io_seproxyhal_touch_over+0x2a>
c0d01908:	4605      	mov	r5, r0
c0d0190a:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d0190c:	2238      	movs	r2, #56	; 0x38
c0d0190e:	4629      	mov	r1, r5
c0d01910:	f7ff fdf6 	bl	c0d01500 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d01914:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01916:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01918:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d0191a:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d0191c:	2c00      	cmp	r4, #0
c0d0191e:	d004      	beq.n	c0d0192a <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01920:	4628      	mov	r0, r5
c0d01922:	47a0      	blx	r4
c0d01924:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d01926:	2800      	cmp	r0, #0
c0d01928:	d003      	beq.n	c0d01932 <io_seproxyhal_touch_over+0x52>
c0d0192a:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d0192c:	f7ff fa66 	bl	c0d00dfc <io_seproxyhal_display>
c0d01930:	2101      	movs	r1, #1
  return 1;
}
c0d01932:	4608      	mov	r0, r1
c0d01934:	b00e      	add	sp, #56	; 0x38
c0d01936:	bdb0      	pop	{r4, r5, r7, pc}

c0d01938 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01938:	b5b0      	push	{r4, r5, r7, lr}
c0d0193a:	af02      	add	r7, sp, #8
c0d0193c:	460d      	mov	r5, r1
c0d0193e:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01940:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d01942:	2800      	cmp	r0, #0
c0d01944:	d00c      	beq.n	c0d01960 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d01946:	f000 fc5b 	bl	c0d02200 <pic>
c0d0194a:	4601      	mov	r1, r0
c0d0194c:	4620      	mov	r0, r4
c0d0194e:	4788      	blx	r1
c0d01950:	f000 fc56 	bl	c0d02200 <pic>
c0d01954:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01956:	2800      	cmp	r0, #0
c0d01958:	d010      	beq.n	c0d0197c <io_seproxyhal_touch_tap+0x44>
c0d0195a:	2801      	cmp	r0, #1
c0d0195c:	d000      	beq.n	c0d01960 <io_seproxyhal_touch_tap+0x28>
c0d0195e:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01960:	2d00      	cmp	r5, #0
c0d01962:	d007      	beq.n	c0d01974 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d01964:	4620      	mov	r0, r4
c0d01966:	47a8      	blx	r5
c0d01968:	2100      	movs	r1, #0
    if (!el) {
c0d0196a:	2800      	cmp	r0, #0
c0d0196c:	d006      	beq.n	c0d0197c <io_seproxyhal_touch_tap+0x44>
c0d0196e:	2801      	cmp	r0, #1
c0d01970:	d000      	beq.n	c0d01974 <io_seproxyhal_touch_tap+0x3c>
c0d01972:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d01974:	4620      	mov	r0, r4
c0d01976:	f7ff fa41 	bl	c0d00dfc <io_seproxyhal_display>
c0d0197a:	2101      	movs	r1, #1
  return 1;
}
c0d0197c:	4608      	mov	r0, r1
c0d0197e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01980 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d01980:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01982:	af03      	add	r7, sp, #12
c0d01984:	b087      	sub	sp, #28
c0d01986:	9302      	str	r3, [sp, #8]
c0d01988:	9203      	str	r2, [sp, #12]
c0d0198a:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d0198c:	2900      	cmp	r1, #0
c0d0198e:	d076      	beq.n	c0d01a7e <io_seproxyhal_touch_element_callback+0xfe>
c0d01990:	9004      	str	r0, [sp, #16]
c0d01992:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01994:	9001      	str	r0, [sp, #4]
c0d01996:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01998:	9000      	str	r0, [sp, #0]
c0d0199a:	2600      	movs	r6, #0
c0d0199c:	9606      	str	r6, [sp, #24]
c0d0199e:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d019a0:	f000 fe08 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d019a4:	2800      	cmp	r0, #0
c0d019a6:	d155      	bne.n	c0d01a54 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d019a8:	2038      	movs	r0, #56	; 0x38
c0d019aa:	4370      	muls	r0, r6
c0d019ac:	9d04      	ldr	r5, [sp, #16]
c0d019ae:	182e      	adds	r6, r5, r0
c0d019b0:	4b36      	ldr	r3, [pc, #216]	; (c0d01a8c <io_seproxyhal_touch_element_callback+0x10c>)
c0d019b2:	681a      	ldr	r2, [r3, #0]
c0d019b4:	2101      	movs	r1, #1
c0d019b6:	4296      	cmp	r6, r2
c0d019b8:	d000      	beq.n	c0d019bc <io_seproxyhal_touch_element_callback+0x3c>
c0d019ba:	9906      	ldr	r1, [sp, #24]
c0d019bc:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d019be:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d019c0:	2800      	cmp	r0, #0
c0d019c2:	da41      	bge.n	c0d01a48 <io_seproxyhal_touch_element_callback+0xc8>
c0d019c4:	2020      	movs	r0, #32
c0d019c6:	5c35      	ldrb	r5, [r6, r0]
c0d019c8:	2102      	movs	r1, #2
c0d019ca:	5e71      	ldrsh	r1, [r6, r1]
c0d019cc:	1b4a      	subs	r2, r1, r5
c0d019ce:	9803      	ldr	r0, [sp, #12]
c0d019d0:	4282      	cmp	r2, r0
c0d019d2:	dc39      	bgt.n	c0d01a48 <io_seproxyhal_touch_element_callback+0xc8>
c0d019d4:	1869      	adds	r1, r5, r1
c0d019d6:	88f2      	ldrh	r2, [r6, #6]
c0d019d8:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d019da:	9803      	ldr	r0, [sp, #12]
c0d019dc:	4288      	cmp	r0, r1
c0d019de:	da33      	bge.n	c0d01a48 <io_seproxyhal_touch_element_callback+0xc8>
c0d019e0:	2104      	movs	r1, #4
c0d019e2:	5e70      	ldrsh	r0, [r6, r1]
c0d019e4:	1b42      	subs	r2, r0, r5
c0d019e6:	9902      	ldr	r1, [sp, #8]
c0d019e8:	428a      	cmp	r2, r1
c0d019ea:	dc2d      	bgt.n	c0d01a48 <io_seproxyhal_touch_element_callback+0xc8>
c0d019ec:	1940      	adds	r0, r0, r5
c0d019ee:	8931      	ldrh	r1, [r6, #8]
c0d019f0:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d019f2:	9902      	ldr	r1, [sp, #8]
c0d019f4:	4281      	cmp	r1, r0
c0d019f6:	da27      	bge.n	c0d01a48 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d019f8:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d019fa:	4286      	cmp	r6, r0
c0d019fc:	d010      	beq.n	c0d01a20 <io_seproxyhal_touch_element_callback+0xa0>
c0d019fe:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01a00:	2800      	cmp	r0, #0
c0d01a02:	d00d      	beq.n	c0d01a20 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d01a04:	9801      	ldr	r0, [sp, #4]
c0d01a06:	2800      	cmp	r0, #0
c0d01a08:	d005      	beq.n	c0d01a16 <io_seproxyhal_touch_element_callback+0x96>
c0d01a0a:	4630      	mov	r0, r6
c0d01a0c:	9901      	ldr	r1, [sp, #4]
c0d01a0e:	4788      	blx	r1
c0d01a10:	4b1e      	ldr	r3, [pc, #120]	; (c0d01a8c <io_seproxyhal_touch_element_callback+0x10c>)
c0d01a12:	2800      	cmp	r0, #0
c0d01a14:	d018      	beq.n	c0d01a48 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01a16:	6818      	ldr	r0, [r3, #0]
c0d01a18:	9901      	ldr	r1, [sp, #4]
c0d01a1a:	f7ff ff3d 	bl	c0d01898 <io_seproxyhal_touch_out>
c0d01a1e:	e008      	b.n	c0d01a32 <io_seproxyhal_touch_element_callback+0xb2>
c0d01a20:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d01a22:	2801      	cmp	r0, #1
c0d01a24:	d009      	beq.n	c0d01a3a <io_seproxyhal_touch_element_callback+0xba>
c0d01a26:	2802      	cmp	r0, #2
c0d01a28:	d10e      	bne.n	c0d01a48 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d01a2a:	4630      	mov	r0, r6
c0d01a2c:	9901      	ldr	r1, [sp, #4]
c0d01a2e:	f7ff ff83 	bl	c0d01938 <io_seproxyhal_touch_tap>
c0d01a32:	4b16      	ldr	r3, [pc, #88]	; (c0d01a8c <io_seproxyhal_touch_element_callback+0x10c>)
c0d01a34:	2800      	cmp	r0, #0
c0d01a36:	d007      	beq.n	c0d01a48 <io_seproxyhal_touch_element_callback+0xc8>
c0d01a38:	e023      	b.n	c0d01a82 <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d01a3a:	4630      	mov	r0, r6
c0d01a3c:	9901      	ldr	r1, [sp, #4]
c0d01a3e:	f7ff ff4f 	bl	c0d018e0 <io_seproxyhal_touch_over>
c0d01a42:	4b12      	ldr	r3, [pc, #72]	; (c0d01a8c <io_seproxyhal_touch_element_callback+0x10c>)
c0d01a44:	2800      	cmp	r0, #0
c0d01a46:	d11f      	bne.n	c0d01a88 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01a48:	1c64      	adds	r4, r4, #1
c0d01a4a:	b2e6      	uxtb	r6, r4
c0d01a4c:	9805      	ldr	r0, [sp, #20]
c0d01a4e:	4286      	cmp	r6, r0
c0d01a50:	d3a6      	bcc.n	c0d019a0 <io_seproxyhal_touch_element_callback+0x20>
c0d01a52:	e000      	b.n	c0d01a56 <io_seproxyhal_touch_element_callback+0xd6>
c0d01a54:	4b0d      	ldr	r3, [pc, #52]	; (c0d01a8c <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d01a56:	9806      	ldr	r0, [sp, #24]
c0d01a58:	0600      	lsls	r0, r0, #24
c0d01a5a:	d010      	beq.n	c0d01a7e <io_seproxyhal_touch_element_callback+0xfe>
c0d01a5c:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d01a5e:	2800      	cmp	r0, #0
c0d01a60:	d00d      	beq.n	c0d01a7e <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01a62:	f000 fda7 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d01a66:	4909      	ldr	r1, [pc, #36]	; (c0d01a8c <io_seproxyhal_touch_element_callback+0x10c>)
c0d01a68:	2800      	cmp	r0, #0
c0d01a6a:	d108      	bne.n	c0d01a7e <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01a6c:	6808      	ldr	r0, [r1, #0]
c0d01a6e:	9901      	ldr	r1, [sp, #4]
c0d01a70:	f7ff ff12 	bl	c0d01898 <io_seproxyhal_touch_out>
c0d01a74:	4d05      	ldr	r5, [pc, #20]	; (c0d01a8c <io_seproxyhal_touch_element_callback+0x10c>)
c0d01a76:	2800      	cmp	r0, #0
c0d01a78:	d001      	beq.n	c0d01a7e <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d01a7a:	2000      	movs	r0, #0
c0d01a7c:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d01a7e:	b007      	add	sp, #28
c0d01a80:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01a82:	2000      	movs	r0, #0
c0d01a84:	6018      	str	r0, [r3, #0]
c0d01a86:	e7fa      	b.n	c0d01a7e <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d01a88:	601e      	str	r6, [r3, #0]
c0d01a8a:	e7f8      	b.n	c0d01a7e <io_seproxyhal_touch_element_callback+0xfe>
c0d01a8c:	20001d20 	.word	0x20001d20

c0d01a90 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d01a90:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a92:	af03      	add	r7, sp, #12
c0d01a94:	b08b      	sub	sp, #44	; 0x2c
c0d01a96:	460c      	mov	r4, r1
c0d01a98:	4601      	mov	r1, r0
c0d01a9a:	ad04      	add	r5, sp, #16
c0d01a9c:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d01a9e:	4628      	mov	r0, r5
c0d01aa0:	9203      	str	r2, [sp, #12]
c0d01aa2:	f7ff fd2d 	bl	c0d01500 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d01aa6:	6821      	ldr	r1, [r4, #0]
c0d01aa8:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d01aaa:	6862      	ldr	r2, [r4, #4]
c0d01aac:	9502      	str	r5, [sp, #8]
c0d01aae:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01ab0:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01ab2:	4e1a      	ldr	r6, [pc, #104]	; (c0d01b1c <io_seproxyhal_display_icon+0x8c>)
c0d01ab4:	2365      	movs	r3, #101	; 0x65
c0d01ab6:	4635      	mov	r5, r6
c0d01ab8:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d01aba:	b292      	uxth	r2, r2
c0d01abc:	4342      	muls	r2, r0
c0d01abe:	b28b      	uxth	r3, r1
c0d01ac0:	4353      	muls	r3, r2
c0d01ac2:	08d9      	lsrs	r1, r3, #3
c0d01ac4:	1c4e      	adds	r6, r1, #1
c0d01ac6:	2207      	movs	r2, #7
c0d01ac8:	4213      	tst	r3, r2
c0d01aca:	d100      	bne.n	c0d01ace <io_seproxyhal_display_icon+0x3e>
c0d01acc:	460e      	mov	r6, r1
c0d01ace:	4631      	mov	r1, r6
c0d01ad0:	9101      	str	r1, [sp, #4]
c0d01ad2:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01ad4:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d01ad6:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d01ad8:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01ada:	0a01      	lsrs	r1, r0, #8
c0d01adc:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d01ade:	70a8      	strb	r0, [r5, #2]
c0d01ae0:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01ae2:	4628      	mov	r0, r5
c0d01ae4:	f000 fd48 	bl	c0d02578 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01ae8:	9802      	ldr	r0, [sp, #8]
c0d01aea:	9903      	ldr	r1, [sp, #12]
c0d01aec:	f000 fd44 	bl	c0d02578 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01af0:	68a0      	ldr	r0, [r4, #8]
c0d01af2:	7028      	strb	r0, [r5, #0]
c0d01af4:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d01af6:	4628      	mov	r0, r5
c0d01af8:	f000 fd3e 	bl	c0d02578 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d01afc:	68e0      	ldr	r0, [r4, #12]
c0d01afe:	f000 fb7f 	bl	c0d02200 <pic>
c0d01b02:	b2b1      	uxth	r1, r6
c0d01b04:	f000 fd38 	bl	c0d02578 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01b08:	9801      	ldr	r0, [sp, #4]
c0d01b0a:	b285      	uxth	r5, r0
c0d01b0c:	6920      	ldr	r0, [r4, #16]
c0d01b0e:	f000 fb77 	bl	c0d02200 <pic>
c0d01b12:	4629      	mov	r1, r5
c0d01b14:	f000 fd30 	bl	c0d02578 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01b18:	b00b      	add	sp, #44	; 0x2c
c0d01b1a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01b1c:	20001a18 	.word	0x20001a18

c0d01b20 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01b20:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01b22:	af03      	add	r7, sp, #12
c0d01b24:	b081      	sub	sp, #4
c0d01b26:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01b28:	7820      	ldrb	r0, [r4, #0]
c0d01b2a:	267f      	movs	r6, #127	; 0x7f
c0d01b2c:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d01b2e:	2e00      	cmp	r6, #0
c0d01b30:	d02e      	beq.n	c0d01b90 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d01b32:	69e0      	ldr	r0, [r4, #28]
c0d01b34:	2800      	cmp	r0, #0
c0d01b36:	d01d      	beq.n	c0d01b74 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01b38:	f000 fb62 	bl	c0d02200 <pic>
c0d01b3c:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d01b3e:	2e05      	cmp	r6, #5
c0d01b40:	d102      	bne.n	c0d01b48 <io_seproxyhal_display_default+0x28>
c0d01b42:	7ea0      	ldrb	r0, [r4, #26]
c0d01b44:	2800      	cmp	r0, #0
c0d01b46:	d025      	beq.n	c0d01b94 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01b48:	4628      	mov	r0, r5
c0d01b4a:	f002 f8cf 	bl	c0d03cec <strlen>
c0d01b4e:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01b50:	4813      	ldr	r0, [pc, #76]	; (c0d01ba0 <io_seproxyhal_display_default+0x80>)
c0d01b52:	2165      	movs	r1, #101	; 0x65
c0d01b54:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01b56:	4631      	mov	r1, r6
c0d01b58:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01b5a:	0a0a      	lsrs	r2, r1, #8
c0d01b5c:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d01b5e:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01b60:	2103      	movs	r1, #3
c0d01b62:	f000 fd09 	bl	c0d02578 <io_seproxyhal_spi_send>
c0d01b66:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01b68:	4620      	mov	r0, r4
c0d01b6a:	f000 fd05 	bl	c0d02578 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d01b6e:	b2b1      	uxth	r1, r6
c0d01b70:	4628      	mov	r0, r5
c0d01b72:	e00b      	b.n	c0d01b8c <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01b74:	480a      	ldr	r0, [pc, #40]	; (c0d01ba0 <io_seproxyhal_display_default+0x80>)
c0d01b76:	2165      	movs	r1, #101	; 0x65
c0d01b78:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01b7a:	2100      	movs	r1, #0
c0d01b7c:	7041      	strb	r1, [r0, #1]
c0d01b7e:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01b80:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01b82:	2103      	movs	r1, #3
c0d01b84:	f000 fcf8 	bl	c0d02578 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01b88:	4620      	mov	r0, r4
c0d01b8a:	4629      	mov	r1, r5
c0d01b8c:	f000 fcf4 	bl	c0d02578 <io_seproxyhal_spi_send>
    }
  }
}
c0d01b90:	b001      	add	sp, #4
c0d01b92:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d01b94:	4620      	mov	r0, r4
c0d01b96:	4629      	mov	r1, r5
c0d01b98:	f7ff ff7a 	bl	c0d01a90 <io_seproxyhal_display_icon>
c0d01b9c:	e7f8      	b.n	c0d01b90 <io_seproxyhal_display_default+0x70>
c0d01b9e:	46c0      	nop			; (mov r8, r8)
c0d01ba0:	20001a18 	.word	0x20001a18

c0d01ba4 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d01ba4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01ba6:	af03      	add	r7, sp, #12
c0d01ba8:	b081      	sub	sp, #4
c0d01baa:	4604      	mov	r4, r0
  if (button_callback) {
c0d01bac:	2c00      	cmp	r4, #0
c0d01bae:	d02e      	beq.n	c0d01c0e <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d01bb0:	4818      	ldr	r0, [pc, #96]	; (c0d01c14 <io_seproxyhal_button_push+0x70>)
c0d01bb2:	6802      	ldr	r2, [r0, #0]
c0d01bb4:	428a      	cmp	r2, r1
c0d01bb6:	d103      	bne.n	c0d01bc0 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01bb8:	4a17      	ldr	r2, [pc, #92]	; (c0d01c18 <io_seproxyhal_button_push+0x74>)
c0d01bba:	6813      	ldr	r3, [r2, #0]
c0d01bbc:	1c5b      	adds	r3, r3, #1
c0d01bbe:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01bc0:	6806      	ldr	r6, [r0, #0]
c0d01bc2:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d01bc4:	4a14      	ldr	r2, [pc, #80]	; (c0d01c18 <io_seproxyhal_button_push+0x74>)
c0d01bc6:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01bc8:	2900      	cmp	r1, #0
c0d01bca:	d001      	beq.n	c0d01bd0 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01bcc:	6006      	str	r6, [r0, #0]
c0d01bce:	e005      	b.n	c0d01bdc <io_seproxyhal_button_push+0x38>
c0d01bd0:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d01bd2:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d01bd4:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d01bd6:	2301      	movs	r3, #1
c0d01bd8:	07db      	lsls	r3, r3, #31
c0d01bda:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d01bdc:	6800      	ldr	r0, [r0, #0]
c0d01bde:	4288      	cmp	r0, r1
c0d01be0:	d001      	beq.n	c0d01be6 <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d01be2:	2000      	movs	r0, #0
c0d01be4:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d01be6:	2d08      	cmp	r5, #8
c0d01be8:	d30e      	bcc.n	c0d01c08 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01bea:	2103      	movs	r1, #3
c0d01bec:	4628      	mov	r0, r5
c0d01bee:	f001 fda7 	bl	c0d03740 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d01bf2:	2001      	movs	r0, #1
c0d01bf4:	0780      	lsls	r0, r0, #30
c0d01bf6:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01bf8:	2900      	cmp	r1, #0
c0d01bfa:	4601      	mov	r1, r0
c0d01bfc:	d000      	beq.n	c0d01c00 <io_seproxyhal_button_push+0x5c>
c0d01bfe:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01c00:	2900      	cmp	r1, #0
c0d01c02:	db02      	blt.n	c0d01c0a <io_seproxyhal_button_push+0x66>
c0d01c04:	4608      	mov	r0, r1
c0d01c06:	e000      	b.n	c0d01c0a <io_seproxyhal_button_push+0x66>
c0d01c08:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01c0a:	4629      	mov	r1, r5
c0d01c0c:	47a0      	blx	r4
  }
}
c0d01c0e:	b001      	add	sp, #4
c0d01c10:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01c12:	46c0      	nop			; (mov r8, r8)
c0d01c14:	20001d24 	.word	0x20001d24
c0d01c18:	20001d28 	.word	0x20001d28

c0d01c1c <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01c1c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c1e:	af03      	add	r7, sp, #12
c0d01c20:	b081      	sub	sp, #4
c0d01c22:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01c24:	200f      	movs	r0, #15
c0d01c26:	4204      	tst	r4, r0
c0d01c28:	d006      	beq.n	c0d01c38 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01c2a:	4620      	mov	r0, r4
c0d01c2c:	f7ff f8be 	bl	c0d00dac <io_exchange_al>
c0d01c30:	4605      	mov	r5, r0
  }
}
c0d01c32:	b2a8      	uxth	r0, r5
c0d01c34:	b001      	add	sp, #4
c0d01c36:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01c38:	2610      	movs	r6, #16
c0d01c3a:	4026      	ands	r6, r4
c0d01c3c:	2900      	cmp	r1, #0
c0d01c3e:	d02a      	beq.n	c0d01c96 <io_exchange+0x7a>
c0d01c40:	2e00      	cmp	r6, #0
c0d01c42:	d128      	bne.n	c0d01c96 <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01c44:	483d      	ldr	r0, [pc, #244]	; (c0d01d3c <io_exchange+0x120>)
c0d01c46:	7800      	ldrb	r0, [r0, #0]
c0d01c48:	2807      	cmp	r0, #7
c0d01c4a:	d00b      	beq.n	c0d01c64 <io_exchange+0x48>
c0d01c4c:	2800      	cmp	r0, #0
c0d01c4e:	d004      	beq.n	c0d01c5a <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01c50:	4620      	mov	r0, r4
c0d01c52:	f7ff f8ab 	bl	c0d00dac <io_exchange_al>
c0d01c56:	2800      	cmp	r0, #0
c0d01c58:	d00a      	beq.n	c0d01c70 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01c5a:	4839      	ldr	r0, [pc, #228]	; (c0d01d40 <io_exchange+0x124>)
c0d01c5c:	6800      	ldr	r0, [r0, #0]
c0d01c5e:	2109      	movs	r1, #9
c0d01c60:	f002 f836 	bl	c0d03cd0 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01c64:	483d      	ldr	r0, [pc, #244]	; (c0d01d5c <io_exchange+0x140>)
c0d01c66:	4478      	add	r0, pc
c0d01c68:	2200      	movs	r2, #0
c0d01c6a:	2320      	movs	r3, #32
c0d01c6c:	f7ff fc6a 	bl	c0d01544 <io_usb_hid_exchange>
c0d01c70:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d01c72:	4832      	ldr	r0, [pc, #200]	; (c0d01d3c <io_exchange+0x120>)
c0d01c74:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d01c76:	4833      	ldr	r0, [pc, #204]	; (c0d01d44 <io_exchange+0x128>)
c0d01c78:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01c7a:	4833      	ldr	r0, [pc, #204]	; (c0d01d48 <io_exchange+0x12c>)
c0d01c7c:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01c7e:	4833      	ldr	r0, [pc, #204]	; (c0d01d4c <io_exchange+0x130>)
c0d01c80:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01c82:	4833      	ldr	r0, [pc, #204]	; (c0d01d50 <io_exchange+0x134>)
c0d01c84:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d01c86:	06a0      	lsls	r0, r4, #26
c0d01c88:	d4d3      	bmi.n	c0d01c32 <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01c8a:	f7ff fcd3 	bl	c0d01634 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01c8e:	0620      	lsls	r0, r4, #24
c0d01c90:	d501      	bpl.n	c0d01c96 <io_exchange+0x7a>
        reset();
c0d01c92:	f000 faeb 	bl	c0d0226c <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d01c96:	2e00      	cmp	r6, #0
c0d01c98:	d10c      	bne.n	c0d01cb4 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01c9a:	0660      	lsls	r0, r4, #25
c0d01c9c:	d448      	bmi.n	c0d01d30 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d01c9e:	4827      	ldr	r0, [pc, #156]	; (c0d01d3c <io_exchange+0x120>)
c0d01ca0:	2100      	movs	r1, #0
c0d01ca2:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d01ca4:	4827      	ldr	r0, [pc, #156]	; (c0d01d44 <io_exchange+0x128>)
c0d01ca6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d01ca8:	4827      	ldr	r0, [pc, #156]	; (c0d01d48 <io_exchange+0x12c>)
c0d01caa:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d01cac:	4827      	ldr	r0, [pc, #156]	; (c0d01d4c <io_exchange+0x130>)
c0d01cae:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01cb0:	4827      	ldr	r0, [pc, #156]	; (c0d01d50 <io_exchange+0x134>)
c0d01cb2:	7001      	strb	r1, [r0, #0]
c0d01cb4:	4c28      	ldr	r4, [pc, #160]	; (c0d01d58 <io_exchange+0x13c>)
c0d01cb6:	4e24      	ldr	r6, [pc, #144]	; (c0d01d48 <io_exchange+0x12c>)
c0d01cb8:	e008      	b.n	c0d01ccc <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d01cba:	f7ff fd0f 	bl	c0d016dc <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01cbe:	8830      	ldrh	r0, [r6, #0]
c0d01cc0:	2800      	cmp	r0, #0
c0d01cc2:	d003      	beq.n	c0d01ccc <io_exchange+0xb0>
c0d01cc4:	e032      	b.n	c0d01d2c <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d01cc6:	2002      	movs	r0, #2
c0d01cc8:	f7ff f89e 	bl	c0d00e08 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01ccc:	f000 fc72 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d01cd0:	2800      	cmp	r0, #0
c0d01cd2:	d101      	bne.n	c0d01cd8 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01cd4:	f7ff fcae 	bl	c0d01634 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01cd8:	2180      	movs	r1, #128	; 0x80
c0d01cda:	2500      	movs	r5, #0
c0d01cdc:	4620      	mov	r0, r4
c0d01cde:	462a      	mov	r2, r5
c0d01ce0:	f000 fc84 	bl	c0d025ec <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01ce4:	1ec1      	subs	r1, r0, #3
c0d01ce6:	78a2      	ldrb	r2, [r4, #2]
c0d01ce8:	7863      	ldrb	r3, [r4, #1]
c0d01cea:	021b      	lsls	r3, r3, #8
c0d01cec:	4313      	orrs	r3, r2
c0d01cee:	4299      	cmp	r1, r3
c0d01cf0:	d110      	bne.n	c0d01d14 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01cf2:	4917      	ldr	r1, [pc, #92]	; (c0d01d50 <io_exchange+0x134>)
c0d01cf4:	7809      	ldrb	r1, [r1, #0]
c0d01cf6:	2900      	cmp	r1, #0
c0d01cf8:	d002      	beq.n	c0d01d00 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01cfa:	f7ff fd73 	bl	c0d017e4 <io_seproxyhal_handle_event>
c0d01cfe:	e7e5      	b.n	c0d01ccc <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01d00:	7821      	ldrb	r1, [r4, #0]
c0d01d02:	2910      	cmp	r1, #16
c0d01d04:	d00f      	beq.n	c0d01d26 <io_exchange+0x10a>
c0d01d06:	290f      	cmp	r1, #15
c0d01d08:	d1dd      	bne.n	c0d01cc6 <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01d0a:	2804      	cmp	r0, #4
c0d01d0c:	d102      	bne.n	c0d01d14 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01d0e:	f7ff fca7 	bl	c0d01660 <io_seproxyhal_handle_usb_event>
c0d01d12:	e7db      	b.n	c0d01ccc <io_exchange+0xb0>
c0d01d14:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d01d16:	4909      	ldr	r1, [pc, #36]	; (c0d01d3c <io_exchange+0x120>)
c0d01d18:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01d1a:	490a      	ldr	r1, [pc, #40]	; (c0d01d44 <io_exchange+0x128>)
c0d01d1c:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01d1e:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01d20:	490a      	ldr	r1, [pc, #40]	; (c0d01d4c <io_exchange+0x130>)
c0d01d22:	8008      	strh	r0, [r1, #0]
c0d01d24:	e7d2      	b.n	c0d01ccc <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01d26:	2806      	cmp	r0, #6
c0d01d28:	d2c7      	bcs.n	c0d01cba <io_exchange+0x9e>
c0d01d2a:	e782      	b.n	c0d01c32 <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01d2c:	8835      	ldrh	r5, [r6, #0]
c0d01d2e:	e780      	b.n	c0d01c32 <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01d30:	4805      	ldr	r0, [pc, #20]	; (c0d01d48 <io_exchange+0x12c>)
c0d01d32:	8800      	ldrh	r0, [r0, #0]
c0d01d34:	4907      	ldr	r1, [pc, #28]	; (c0d01d54 <io_exchange+0x138>)
c0d01d36:	1845      	adds	r5, r0, r1
c0d01d38:	e77b      	b.n	c0d01c32 <io_exchange+0x16>
c0d01d3a:	46c0      	nop			; (mov r8, r8)
c0d01d3c:	20001d18 	.word	0x20001d18
c0d01d40:	20001bb8 	.word	0x20001bb8
c0d01d44:	20001d1a 	.word	0x20001d1a
c0d01d48:	20001d1c 	.word	0x20001d1c
c0d01d4c:	20001d1e 	.word	0x20001d1e
c0d01d50:	20001d10 	.word	0x20001d10
c0d01d54:	0000fffb 	.word	0x0000fffb
c0d01d58:	20001a18 	.word	0x20001a18
c0d01d5c:	fffffbbb 	.word	0xfffffbbb

c0d01d60 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01d60:	b081      	sub	sp, #4
c0d01d62:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01d64:	af03      	add	r7, sp, #12
c0d01d66:	b094      	sub	sp, #80	; 0x50
c0d01d68:	4616      	mov	r6, r2
c0d01d6a:	460d      	mov	r5, r1
c0d01d6c:	900e      	str	r0, [sp, #56]	; 0x38
c0d01d6e:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01d70:	2d02      	cmp	r5, #2
c0d01d72:	d200      	bcs.n	c0d01d76 <snprintf+0x16>
c0d01d74:	e22a      	b.n	c0d021cc <snprintf+0x46c>
c0d01d76:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01d78:	2800      	cmp	r0, #0
c0d01d7a:	d100      	bne.n	c0d01d7e <snprintf+0x1e>
c0d01d7c:	e226      	b.n	c0d021cc <snprintf+0x46c>
c0d01d7e:	2e00      	cmp	r6, #0
c0d01d80:	d100      	bne.n	c0d01d84 <snprintf+0x24>
c0d01d82:	e223      	b.n	c0d021cc <snprintf+0x46c>
c0d01d84:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d01d86:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01d88:	9109      	str	r1, [sp, #36]	; 0x24
c0d01d8a:	462a      	mov	r2, r5
c0d01d8c:	f7ff fbae 	bl	c0d014ec <os_memset>
c0d01d90:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01d92:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01d94:	7830      	ldrb	r0, [r6, #0]
c0d01d96:	2800      	cmp	r0, #0
c0d01d98:	d100      	bne.n	c0d01d9c <snprintf+0x3c>
c0d01d9a:	e217      	b.n	c0d021cc <snprintf+0x46c>
c0d01d9c:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01d9e:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01da0:	1e6b      	subs	r3, r5, #1
c0d01da2:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01da4:	460a      	mov	r2, r1
c0d01da6:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01da8:	e003      	b.n	c0d01db2 <snprintf+0x52>
c0d01daa:	1970      	adds	r0, r6, r5
c0d01dac:	7840      	ldrb	r0, [r0, #1]
c0d01dae:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01db0:	1c6d      	adds	r5, r5, #1
c0d01db2:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01db4:	2800      	cmp	r0, #0
c0d01db6:	d001      	beq.n	c0d01dbc <snprintf+0x5c>
c0d01db8:	2825      	cmp	r0, #37	; 0x25
c0d01dba:	d1f6      	bne.n	c0d01daa <snprintf+0x4a>
c0d01dbc:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01dbe:	429d      	cmp	r5, r3
c0d01dc0:	d300      	bcc.n	c0d01dc4 <snprintf+0x64>
c0d01dc2:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01dc4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01dc6:	4631      	mov	r1, r6
c0d01dc8:	462a      	mov	r2, r5
c0d01dca:	461c      	mov	r4, r3
c0d01dcc:	f7ff fb98 	bl	c0d01500 <os_memmove>
c0d01dd0:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01dd2:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01dd4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01dd6:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01dd8:	2b00      	cmp	r3, #0
c0d01dda:	d100      	bne.n	c0d01dde <snprintf+0x7e>
c0d01ddc:	e1f6      	b.n	c0d021cc <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01dde:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01de0:	5d71      	ldrb	r1, [r6, r5]
c0d01de2:	2925      	cmp	r1, #37	; 0x25
c0d01de4:	d000      	beq.n	c0d01de8 <snprintf+0x88>
c0d01de6:	e0ab      	b.n	c0d01f40 <snprintf+0x1e0>
c0d01de8:	9304      	str	r3, [sp, #16]
c0d01dea:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01dec:	1c40      	adds	r0, r0, #1
c0d01dee:	2100      	movs	r1, #0
c0d01df0:	2220      	movs	r2, #32
c0d01df2:	920a      	str	r2, [sp, #40]	; 0x28
c0d01df4:	220a      	movs	r2, #10
c0d01df6:	9203      	str	r2, [sp, #12]
c0d01df8:	9102      	str	r1, [sp, #8]
c0d01dfa:	9106      	str	r1, [sp, #24]
c0d01dfc:	910d      	str	r1, [sp, #52]	; 0x34
c0d01dfe:	460b      	mov	r3, r1
c0d01e00:	2102      	movs	r1, #2
c0d01e02:	910c      	str	r1, [sp, #48]	; 0x30
c0d01e04:	4606      	mov	r6, r0
c0d01e06:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01e08:	7831      	ldrb	r1, [r6, #0]
c0d01e0a:	1c76      	adds	r6, r6, #1
c0d01e0c:	2300      	movs	r3, #0
c0d01e0e:	2962      	cmp	r1, #98	; 0x62
c0d01e10:	dc41      	bgt.n	c0d01e96 <snprintf+0x136>
c0d01e12:	4608      	mov	r0, r1
c0d01e14:	3825      	subs	r0, #37	; 0x25
c0d01e16:	2823      	cmp	r0, #35	; 0x23
c0d01e18:	d900      	bls.n	c0d01e1c <snprintf+0xbc>
c0d01e1a:	e094      	b.n	c0d01f46 <snprintf+0x1e6>
c0d01e1c:	0040      	lsls	r0, r0, #1
c0d01e1e:	46c0      	nop			; (mov r8, r8)
c0d01e20:	4478      	add	r0, pc
c0d01e22:	8880      	ldrh	r0, [r0, #4]
c0d01e24:	0040      	lsls	r0, r0, #1
c0d01e26:	4487      	add	pc, r0
c0d01e28:	0186012d 	.word	0x0186012d
c0d01e2c:	01860186 	.word	0x01860186
c0d01e30:	00510186 	.word	0x00510186
c0d01e34:	01860186 	.word	0x01860186
c0d01e38:	00580023 	.word	0x00580023
c0d01e3c:	00240186 	.word	0x00240186
c0d01e40:	00240024 	.word	0x00240024
c0d01e44:	00240024 	.word	0x00240024
c0d01e48:	00240024 	.word	0x00240024
c0d01e4c:	00240024 	.word	0x00240024
c0d01e50:	01860024 	.word	0x01860024
c0d01e54:	01860186 	.word	0x01860186
c0d01e58:	01860186 	.word	0x01860186
c0d01e5c:	01860186 	.word	0x01860186
c0d01e60:	01860186 	.word	0x01860186
c0d01e64:	01860186 	.word	0x01860186
c0d01e68:	01860186 	.word	0x01860186
c0d01e6c:	006c0186 	.word	0x006c0186
c0d01e70:	e7c9      	b.n	c0d01e06 <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01e72:	2930      	cmp	r1, #48	; 0x30
c0d01e74:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01e76:	4603      	mov	r3, r0
c0d01e78:	d100      	bne.n	c0d01e7c <snprintf+0x11c>
c0d01e7a:	460b      	mov	r3, r1
c0d01e7c:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01e7e:	2c00      	cmp	r4, #0
c0d01e80:	d000      	beq.n	c0d01e84 <snprintf+0x124>
c0d01e82:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01e84:	200a      	movs	r0, #10
c0d01e86:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01e88:	1840      	adds	r0, r0, r1
c0d01e8a:	3830      	subs	r0, #48	; 0x30
c0d01e8c:	900d      	str	r0, [sp, #52]	; 0x34
c0d01e8e:	4630      	mov	r0, r6
c0d01e90:	930a      	str	r3, [sp, #40]	; 0x28
c0d01e92:	4613      	mov	r3, r2
c0d01e94:	e7b4      	b.n	c0d01e00 <snprintf+0xa0>
c0d01e96:	296f      	cmp	r1, #111	; 0x6f
c0d01e98:	dd11      	ble.n	c0d01ebe <snprintf+0x15e>
c0d01e9a:	3970      	subs	r1, #112	; 0x70
c0d01e9c:	2908      	cmp	r1, #8
c0d01e9e:	d900      	bls.n	c0d01ea2 <snprintf+0x142>
c0d01ea0:	e149      	b.n	c0d02136 <snprintf+0x3d6>
c0d01ea2:	0049      	lsls	r1, r1, #1
c0d01ea4:	4479      	add	r1, pc
c0d01ea6:	8889      	ldrh	r1, [r1, #4]
c0d01ea8:	0049      	lsls	r1, r1, #1
c0d01eaa:	448f      	add	pc, r1
c0d01eac:	01440051 	.word	0x01440051
c0d01eb0:	002e0144 	.word	0x002e0144
c0d01eb4:	00590144 	.word	0x00590144
c0d01eb8:	01440144 	.word	0x01440144
c0d01ebc:	0051      	.short	0x0051
c0d01ebe:	2963      	cmp	r1, #99	; 0x63
c0d01ec0:	d054      	beq.n	c0d01f6c <snprintf+0x20c>
c0d01ec2:	2964      	cmp	r1, #100	; 0x64
c0d01ec4:	d057      	beq.n	c0d01f76 <snprintf+0x216>
c0d01ec6:	2968      	cmp	r1, #104	; 0x68
c0d01ec8:	d01d      	beq.n	c0d01f06 <snprintf+0x1a6>
c0d01eca:	e134      	b.n	c0d02136 <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01ecc:	7830      	ldrb	r0, [r6, #0]
c0d01ece:	2873      	cmp	r0, #115	; 0x73
c0d01ed0:	d000      	beq.n	c0d01ed4 <snprintf+0x174>
c0d01ed2:	e130      	b.n	c0d02136 <snprintf+0x3d6>
c0d01ed4:	4630      	mov	r0, r6
c0d01ed6:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01ed8:	e00d      	b.n	c0d01ef6 <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01eda:	7830      	ldrb	r0, [r6, #0]
c0d01edc:	282a      	cmp	r0, #42	; 0x2a
c0d01ede:	d000      	beq.n	c0d01ee2 <snprintf+0x182>
c0d01ee0:	e129      	b.n	c0d02136 <snprintf+0x3d6>
c0d01ee2:	7871      	ldrb	r1, [r6, #1]
c0d01ee4:	1c70      	adds	r0, r6, #1
c0d01ee6:	2301      	movs	r3, #1
c0d01ee8:	2948      	cmp	r1, #72	; 0x48
c0d01eea:	d004      	beq.n	c0d01ef6 <snprintf+0x196>
c0d01eec:	2968      	cmp	r1, #104	; 0x68
c0d01eee:	d002      	beq.n	c0d01ef6 <snprintf+0x196>
c0d01ef0:	2973      	cmp	r1, #115	; 0x73
c0d01ef2:	d000      	beq.n	c0d01ef6 <snprintf+0x196>
c0d01ef4:	e11f      	b.n	c0d02136 <snprintf+0x3d6>
c0d01ef6:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01ef8:	1d0a      	adds	r2, r1, #4
c0d01efa:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01efc:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01efe:	9102      	str	r1, [sp, #8]
c0d01f00:	e77e      	b.n	c0d01e00 <snprintf+0xa0>
c0d01f02:	2001      	movs	r0, #1
c0d01f04:	9006      	str	r0, [sp, #24]
c0d01f06:	2010      	movs	r0, #16
c0d01f08:	9003      	str	r0, [sp, #12]
c0d01f0a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01f0c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01f0e:	1d01      	adds	r1, r0, #4
c0d01f10:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01f12:	2103      	movs	r1, #3
c0d01f14:	400a      	ands	r2, r1
c0d01f16:	1c5b      	adds	r3, r3, #1
c0d01f18:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01f1a:	2a01      	cmp	r2, #1
c0d01f1c:	d100      	bne.n	c0d01f20 <snprintf+0x1c0>
c0d01f1e:	e0b8      	b.n	c0d02092 <snprintf+0x332>
c0d01f20:	2a02      	cmp	r2, #2
c0d01f22:	d100      	bne.n	c0d01f26 <snprintf+0x1c6>
c0d01f24:	e104      	b.n	c0d02130 <snprintf+0x3d0>
c0d01f26:	2a03      	cmp	r2, #3
c0d01f28:	4630      	mov	r0, r6
c0d01f2a:	d100      	bne.n	c0d01f2e <snprintf+0x1ce>
c0d01f2c:	e768      	b.n	c0d01e00 <snprintf+0xa0>
c0d01f2e:	9c08      	ldr	r4, [sp, #32]
c0d01f30:	4625      	mov	r5, r4
c0d01f32:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01f34:	1948      	adds	r0, r1, r5
c0d01f36:	7840      	ldrb	r0, [r0, #1]
c0d01f38:	1c6d      	adds	r5, r5, #1
c0d01f3a:	2800      	cmp	r0, #0
c0d01f3c:	d1fa      	bne.n	c0d01f34 <snprintf+0x1d4>
c0d01f3e:	e0ab      	b.n	c0d02098 <snprintf+0x338>
c0d01f40:	4606      	mov	r6, r0
c0d01f42:	920e      	str	r2, [sp, #56]	; 0x38
c0d01f44:	e109      	b.n	c0d0215a <snprintf+0x3fa>
c0d01f46:	2958      	cmp	r1, #88	; 0x58
c0d01f48:	d000      	beq.n	c0d01f4c <snprintf+0x1ec>
c0d01f4a:	e0f4      	b.n	c0d02136 <snprintf+0x3d6>
c0d01f4c:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01f4e:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01f50:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01f52:	1d01      	adds	r1, r0, #4
c0d01f54:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01f56:	6802      	ldr	r2, [r0, #0]
c0d01f58:	2000      	movs	r0, #0
c0d01f5a:	9005      	str	r0, [sp, #20]
c0d01f5c:	2510      	movs	r5, #16
c0d01f5e:	e014      	b.n	c0d01f8a <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01f60:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01f62:	1d01      	adds	r1, r0, #4
c0d01f64:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01f66:	6802      	ldr	r2, [r0, #0]
c0d01f68:	2000      	movs	r0, #0
c0d01f6a:	e00c      	b.n	c0d01f86 <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01f6c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01f6e:	1d01      	adds	r1, r0, #4
c0d01f70:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01f72:	6800      	ldr	r0, [r0, #0]
c0d01f74:	e087      	b.n	c0d02086 <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01f76:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01f78:	1d01      	adds	r1, r0, #4
c0d01f7a:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01f7c:	6800      	ldr	r0, [r0, #0]
c0d01f7e:	17c1      	asrs	r1, r0, #31
c0d01f80:	1842      	adds	r2, r0, r1
c0d01f82:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01f84:	0fc0      	lsrs	r0, r0, #31
c0d01f86:	9005      	str	r0, [sp, #20]
c0d01f88:	250a      	movs	r5, #10
c0d01f8a:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01f8c:	4295      	cmp	r5, r2
c0d01f8e:	920e      	str	r2, [sp, #56]	; 0x38
c0d01f90:	d814      	bhi.n	c0d01fbc <snprintf+0x25c>
c0d01f92:	2201      	movs	r2, #1
c0d01f94:	4628      	mov	r0, r5
c0d01f96:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01f98:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01f9a:	4629      	mov	r1, r5
c0d01f9c:	f001 fb4a 	bl	c0d03634 <__aeabi_uidiv>
c0d01fa0:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01fa2:	4288      	cmp	r0, r1
c0d01fa4:	d109      	bne.n	c0d01fba <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01fa6:	4628      	mov	r0, r5
c0d01fa8:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01faa:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01fac:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01fae:	910d      	str	r1, [sp, #52]	; 0x34
c0d01fb0:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01fb2:	4288      	cmp	r0, r1
c0d01fb4:	4622      	mov	r2, r4
c0d01fb6:	d9ee      	bls.n	c0d01f96 <snprintf+0x236>
c0d01fb8:	e000      	b.n	c0d01fbc <snprintf+0x25c>
c0d01fba:	460c      	mov	r4, r1
c0d01fbc:	950c      	str	r5, [sp, #48]	; 0x30
c0d01fbe:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01fc0:	2000      	movs	r0, #0
c0d01fc2:	4603      	mov	r3, r0
c0d01fc4:	43c1      	mvns	r1, r0
c0d01fc6:	9c05      	ldr	r4, [sp, #20]
c0d01fc8:	2c00      	cmp	r4, #0
c0d01fca:	d100      	bne.n	c0d01fce <snprintf+0x26e>
c0d01fcc:	4621      	mov	r1, r4
c0d01fce:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01fd0:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01fd2:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01fd4:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01fd6:	b2ca      	uxtb	r2, r1
c0d01fd8:	2a30      	cmp	r2, #48	; 0x30
c0d01fda:	d106      	bne.n	c0d01fea <snprintf+0x28a>
c0d01fdc:	2c00      	cmp	r4, #0
c0d01fde:	d004      	beq.n	c0d01fea <snprintf+0x28a>
c0d01fe0:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01fe2:	232d      	movs	r3, #45	; 0x2d
c0d01fe4:	700b      	strb	r3, [r1, #0]
c0d01fe6:	2400      	movs	r4, #0
c0d01fe8:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01fea:	1e81      	subs	r1, r0, #2
c0d01fec:	290d      	cmp	r1, #13
c0d01fee:	d80d      	bhi.n	c0d0200c <snprintf+0x2ac>
c0d01ff0:	1e41      	subs	r1, r0, #1
c0d01ff2:	d00b      	beq.n	c0d0200c <snprintf+0x2ac>
c0d01ff4:	a810      	add	r0, sp, #64	; 0x40
c0d01ff6:	9405      	str	r4, [sp, #20]
c0d01ff8:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01ffa:	4320      	orrs	r0, r4
c0d01ffc:	f001 fdd0 	bl	c0d03ba0 <__aeabi_memset>
c0d02000:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d02002:	1900      	adds	r0, r0, r4
c0d02004:	9c05      	ldr	r4, [sp, #20]
c0d02006:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02008:	1840      	adds	r0, r0, r1
c0d0200a:	1e43      	subs	r3, r0, #1
c0d0200c:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d0200e:	2c00      	cmp	r4, #0
c0d02010:	9601      	str	r6, [sp, #4]
c0d02012:	d003      	beq.n	c0d0201c <snprintf+0x2bc>
c0d02014:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d02016:	222d      	movs	r2, #45	; 0x2d
c0d02018:	54c2      	strb	r2, [r0, r3]
c0d0201a:	1c5b      	adds	r3, r3, #1
c0d0201c:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d0201e:	2900      	cmp	r1, #0
c0d02020:	d003      	beq.n	c0d0202a <snprintf+0x2ca>
c0d02022:	2800      	cmp	r0, #0
c0d02024:	d003      	beq.n	c0d0202e <snprintf+0x2ce>
c0d02026:	a06c      	add	r0, pc, #432	; (adr r0, c0d021d8 <g_pcHex_cap>)
c0d02028:	e002      	b.n	c0d02030 <snprintf+0x2d0>
c0d0202a:	461c      	mov	r4, r3
c0d0202c:	e016      	b.n	c0d0205c <snprintf+0x2fc>
c0d0202e:	a06e      	add	r0, pc, #440	; (adr r0, c0d021e8 <g_pcHex>)
c0d02030:	900d      	str	r0, [sp, #52]	; 0x34
c0d02032:	461c      	mov	r4, r3
c0d02034:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d02036:	460e      	mov	r6, r1
c0d02038:	f001 fafc 	bl	c0d03634 <__aeabi_uidiv>
c0d0203c:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d0203e:	4629      	mov	r1, r5
c0d02040:	f001 fb7e 	bl	c0d03740 <__aeabi_uidivmod>
c0d02044:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d02046:	5c40      	ldrb	r0, [r0, r1]
c0d02048:	a910      	add	r1, sp, #64	; 0x40
c0d0204a:	5508      	strb	r0, [r1, r4]
c0d0204c:	4630      	mov	r0, r6
c0d0204e:	4629      	mov	r1, r5
c0d02050:	f001 faf0 	bl	c0d03634 <__aeabi_uidiv>
c0d02054:	1c64      	adds	r4, r4, #1
c0d02056:	42b5      	cmp	r5, r6
c0d02058:	4601      	mov	r1, r0
c0d0205a:	d9eb      	bls.n	c0d02034 <snprintf+0x2d4>
c0d0205c:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d0205e:	429c      	cmp	r4, r3
c0d02060:	4625      	mov	r5, r4
c0d02062:	d300      	bcc.n	c0d02066 <snprintf+0x306>
c0d02064:	461d      	mov	r5, r3
c0d02066:	a910      	add	r1, sp, #64	; 0x40
c0d02068:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d0206a:	4620      	mov	r0, r4
c0d0206c:	462a      	mov	r2, r5
c0d0206e:	461e      	mov	r6, r3
c0d02070:	f7ff fa46 	bl	c0d01500 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d02074:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d02076:	1961      	adds	r1, r4, r5
c0d02078:	910e      	str	r1, [sp, #56]	; 0x38
c0d0207a:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d0207c:	2800      	cmp	r0, #0
c0d0207e:	9e01      	ldr	r6, [sp, #4]
c0d02080:	d16b      	bne.n	c0d0215a <snprintf+0x3fa>
c0d02082:	e0a3      	b.n	c0d021cc <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d02084:	2025      	movs	r0, #37	; 0x25
c0d02086:	9907      	ldr	r1, [sp, #28]
c0d02088:	7008      	strb	r0, [r1, #0]
c0d0208a:	9804      	ldr	r0, [sp, #16]
c0d0208c:	1e40      	subs	r0, r0, #1
c0d0208e:	1c49      	adds	r1, r1, #1
c0d02090:	e05f      	b.n	c0d02152 <snprintf+0x3f2>
c0d02092:	9d02      	ldr	r5, [sp, #8]
c0d02094:	9c08      	ldr	r4, [sp, #32]
c0d02096:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d02098:	9803      	ldr	r0, [sp, #12]
c0d0209a:	2810      	cmp	r0, #16
c0d0209c:	9807      	ldr	r0, [sp, #28]
c0d0209e:	d161      	bne.n	c0d02164 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d020a0:	2d00      	cmp	r5, #0
c0d020a2:	d06a      	beq.n	c0d0217a <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d020a4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d020a6:	1900      	adds	r0, r0, r4
c0d020a8:	900e      	str	r0, [sp, #56]	; 0x38
c0d020aa:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d020ac:	1aa0      	subs	r0, r4, r2
c0d020ae:	9b05      	ldr	r3, [sp, #20]
c0d020b0:	4283      	cmp	r3, r0
c0d020b2:	d800      	bhi.n	c0d020b6 <snprintf+0x356>
c0d020b4:	4603      	mov	r3, r0
c0d020b6:	930c      	str	r3, [sp, #48]	; 0x30
c0d020b8:	435c      	muls	r4, r3
c0d020ba:	940a      	str	r4, [sp, #40]	; 0x28
c0d020bc:	1c60      	adds	r0, r4, #1
c0d020be:	9007      	str	r0, [sp, #28]
c0d020c0:	2000      	movs	r0, #0
c0d020c2:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d020c4:	9100      	str	r1, [sp, #0]
c0d020c6:	940e      	str	r4, [sp, #56]	; 0x38
c0d020c8:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d020ca:	18e3      	adds	r3, r4, r3
c0d020cc:	900d      	str	r0, [sp, #52]	; 0x34
c0d020ce:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d020d0:	200f      	movs	r0, #15
c0d020d2:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d020d4:	0909      	lsrs	r1, r1, #4
c0d020d6:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d020d8:	18a4      	adds	r4, r4, r2
c0d020da:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d020dc:	2c02      	cmp	r4, #2
c0d020de:	d375      	bcc.n	c0d021cc <snprintf+0x46c>
c0d020e0:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d020e2:	2c01      	cmp	r4, #1
c0d020e4:	d003      	beq.n	c0d020ee <snprintf+0x38e>
c0d020e6:	2c00      	cmp	r4, #0
c0d020e8:	d108      	bne.n	c0d020fc <snprintf+0x39c>
c0d020ea:	a43f      	add	r4, pc, #252	; (adr r4, c0d021e8 <g_pcHex>)
c0d020ec:	e000      	b.n	c0d020f0 <snprintf+0x390>
c0d020ee:	a43a      	add	r4, pc, #232	; (adr r4, c0d021d8 <g_pcHex_cap>)
c0d020f0:	b2c9      	uxtb	r1, r1
c0d020f2:	5c61      	ldrb	r1, [r4, r1]
c0d020f4:	7019      	strb	r1, [r3, #0]
c0d020f6:	b2c0      	uxtb	r0, r0
c0d020f8:	5c20      	ldrb	r0, [r4, r0]
c0d020fa:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d020fc:	9807      	ldr	r0, [sp, #28]
c0d020fe:	4290      	cmp	r0, r2
c0d02100:	d064      	beq.n	c0d021cc <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d02102:	1e92      	subs	r2, r2, #2
c0d02104:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d02106:	1ca4      	adds	r4, r4, #2
c0d02108:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0210a:	1c40      	adds	r0, r0, #1
c0d0210c:	42a8      	cmp	r0, r5
c0d0210e:	9900      	ldr	r1, [sp, #0]
c0d02110:	d3d9      	bcc.n	c0d020c6 <snprintf+0x366>
c0d02112:	900d      	str	r0, [sp, #52]	; 0x34
c0d02114:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d02116:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d02118:	1a08      	subs	r0, r1, r0
c0d0211a:	9b05      	ldr	r3, [sp, #20]
c0d0211c:	4283      	cmp	r3, r0
c0d0211e:	d800      	bhi.n	c0d02122 <snprintf+0x3c2>
c0d02120:	4603      	mov	r3, r0
c0d02122:	4608      	mov	r0, r1
c0d02124:	4358      	muls	r0, r3
c0d02126:	1820      	adds	r0, r4, r0
c0d02128:	900e      	str	r0, [sp, #56]	; 0x38
c0d0212a:	1898      	adds	r0, r3, r2
c0d0212c:	1c43      	adds	r3, r0, #1
c0d0212e:	e038      	b.n	c0d021a2 <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d02130:	7808      	ldrb	r0, [r1, #0]
c0d02132:	2800      	cmp	r0, #0
c0d02134:	d023      	beq.n	c0d0217e <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d02136:	2005      	movs	r0, #5
c0d02138:	9d04      	ldr	r5, [sp, #16]
c0d0213a:	2d05      	cmp	r5, #5
c0d0213c:	462c      	mov	r4, r5
c0d0213e:	d300      	bcc.n	c0d02142 <snprintf+0x3e2>
c0d02140:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d02142:	9807      	ldr	r0, [sp, #28]
c0d02144:	a12c      	add	r1, pc, #176	; (adr r1, c0d021f8 <g_pcHex+0x10>)
c0d02146:	4622      	mov	r2, r4
c0d02148:	f7ff f9da 	bl	c0d01500 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d0214c:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d0214e:	9907      	ldr	r1, [sp, #28]
c0d02150:	1909      	adds	r1, r1, r4
c0d02152:	910e      	str	r1, [sp, #56]	; 0x38
c0d02154:	4603      	mov	r3, r0
c0d02156:	2800      	cmp	r0, #0
c0d02158:	d038      	beq.n	c0d021cc <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d0215a:	7830      	ldrb	r0, [r6, #0]
c0d0215c:	2800      	cmp	r0, #0
c0d0215e:	9908      	ldr	r1, [sp, #32]
c0d02160:	d034      	beq.n	c0d021cc <snprintf+0x46c>
c0d02162:	e61f      	b.n	c0d01da4 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d02164:	429d      	cmp	r5, r3
c0d02166:	d300      	bcc.n	c0d0216a <snprintf+0x40a>
c0d02168:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d0216a:	462a      	mov	r2, r5
c0d0216c:	461c      	mov	r4, r3
c0d0216e:	f7ff f9c7 	bl	c0d01500 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d02172:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d02174:	9907      	ldr	r1, [sp, #28]
c0d02176:	1949      	adds	r1, r1, r5
c0d02178:	e00f      	b.n	c0d0219a <snprintf+0x43a>
c0d0217a:	900e      	str	r0, [sp, #56]	; 0x38
c0d0217c:	e7ed      	b.n	c0d0215a <snprintf+0x3fa>
c0d0217e:	9b04      	ldr	r3, [sp, #16]
c0d02180:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d02182:	429c      	cmp	r4, r3
c0d02184:	d300      	bcc.n	c0d02188 <snprintf+0x428>
c0d02186:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d02188:	2120      	movs	r1, #32
c0d0218a:	9807      	ldr	r0, [sp, #28]
c0d0218c:	4622      	mov	r2, r4
c0d0218e:	f7ff f9ad 	bl	c0d014ec <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d02192:	9804      	ldr	r0, [sp, #16]
c0d02194:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d02196:	9907      	ldr	r1, [sp, #28]
c0d02198:	1909      	adds	r1, r1, r4
c0d0219a:	910e      	str	r1, [sp, #56]	; 0x38
c0d0219c:	4603      	mov	r3, r0
c0d0219e:	2800      	cmp	r0, #0
c0d021a0:	d014      	beq.n	c0d021cc <snprintf+0x46c>
c0d021a2:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d021a4:	42a8      	cmp	r0, r5
c0d021a6:	d9d8      	bls.n	c0d0215a <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d021a8:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d021aa:	429a      	cmp	r2, r3
c0d021ac:	d300      	bcc.n	c0d021b0 <snprintf+0x450>
c0d021ae:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d021b0:	2120      	movs	r1, #32
c0d021b2:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d021b4:	4628      	mov	r0, r5
c0d021b6:	920d      	str	r2, [sp, #52]	; 0x34
c0d021b8:	461c      	mov	r4, r3
c0d021ba:	f7ff f997 	bl	c0d014ec <os_memset>
c0d021be:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d021c0:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d021c2:	182d      	adds	r5, r5, r0
c0d021c4:	950e      	str	r5, [sp, #56]	; 0x38
c0d021c6:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d021c8:	2c00      	cmp	r4, #0
c0d021ca:	d1c6      	bne.n	c0d0215a <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d021cc:	2000      	movs	r0, #0
c0d021ce:	b014      	add	sp, #80	; 0x50
c0d021d0:	bcf0      	pop	{r4, r5, r6, r7}
c0d021d2:	bc02      	pop	{r1}
c0d021d4:	b001      	add	sp, #4
c0d021d6:	4708      	bx	r1

c0d021d8 <g_pcHex_cap>:
c0d021d8:	33323130 	.word	0x33323130
c0d021dc:	37363534 	.word	0x37363534
c0d021e0:	42413938 	.word	0x42413938
c0d021e4:	46454443 	.word	0x46454443

c0d021e8 <g_pcHex>:
c0d021e8:	33323130 	.word	0x33323130
c0d021ec:	37363534 	.word	0x37363534
c0d021f0:	62613938 	.word	0x62613938
c0d021f4:	66656463 	.word	0x66656463
c0d021f8:	4f525245 	.word	0x4f525245
c0d021fc:	00000052 	.word	0x00000052

c0d02200 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d02200:	b580      	push	{r7, lr}
c0d02202:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d02204:	4904      	ldr	r1, [pc, #16]	; (c0d02218 <pic+0x18>)
c0d02206:	4288      	cmp	r0, r1
c0d02208:	d304      	bcc.n	c0d02214 <pic+0x14>
c0d0220a:	4904      	ldr	r1, [pc, #16]	; (c0d0221c <pic+0x1c>)
c0d0220c:	4288      	cmp	r0, r1
c0d0220e:	d201      	bcs.n	c0d02214 <pic+0x14>
		link_address = pic_internal(link_address);
c0d02210:	f000 f806 	bl	c0d02220 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d02214:	bd80      	pop	{r7, pc}
c0d02216:	46c0      	nop			; (mov r8, r8)
c0d02218:	c0d00000 	.word	0xc0d00000
c0d0221c:	c0d04240 	.word	0xc0d04240

c0d02220 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d02220:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d02222:	4902      	ldr	r1, [pc, #8]	; (c0d0222c <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d02224:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d02226:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d02228:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d0222a:	4770      	bx	lr
c0d0222c:	c0d02221 	.word	0xc0d02221

c0d02230 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d02230:	b580      	push	{r7, lr}
c0d02232:	af00      	add	r7, sp, #0
c0d02234:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d02236:	490a      	ldr	r1, [pc, #40]	; (c0d02260 <check_api_level+0x30>)
c0d02238:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0223a:	490a      	ldr	r1, [pc, #40]	; (c0d02264 <check_api_level+0x34>)
c0d0223c:	680a      	ldr	r2, [r1, #0]
c0d0223e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d02240:	9003      	str	r0, [sp, #12]
c0d02242:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02244:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02246:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02248:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d0224a:	4807      	ldr	r0, [pc, #28]	; (c0d02268 <check_api_level+0x38>)
c0d0224c:	9a01      	ldr	r2, [sp, #4]
c0d0224e:	4282      	cmp	r2, r0
c0d02250:	d101      	bne.n	c0d02256 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02252:	b004      	add	sp, #16
c0d02254:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02256:	6808      	ldr	r0, [r1, #0]
c0d02258:	2104      	movs	r1, #4
c0d0225a:	f001 fd39 	bl	c0d03cd0 <longjmp>
c0d0225e:	46c0      	nop			; (mov r8, r8)
c0d02260:	60000137 	.word	0x60000137
c0d02264:	20001bb8 	.word	0x20001bb8
c0d02268:	900001c6 	.word	0x900001c6

c0d0226c <reset>:
  }
}

void reset ( void ) 
{
c0d0226c:	b580      	push	{r7, lr}
c0d0226e:	af00      	add	r7, sp, #0
c0d02270:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d02272:	4809      	ldr	r0, [pc, #36]	; (c0d02298 <reset+0x2c>)
c0d02274:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02276:	4809      	ldr	r0, [pc, #36]	; (c0d0229c <reset+0x30>)
c0d02278:	6801      	ldr	r1, [r0, #0]
c0d0227a:	9101      	str	r1, [sp, #4]
c0d0227c:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0227e:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d02280:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02282:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d02284:	4906      	ldr	r1, [pc, #24]	; (c0d022a0 <reset+0x34>)
c0d02286:	9a00      	ldr	r2, [sp, #0]
c0d02288:	428a      	cmp	r2, r1
c0d0228a:	d101      	bne.n	c0d02290 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0228c:	b002      	add	sp, #8
c0d0228e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02290:	6800      	ldr	r0, [r0, #0]
c0d02292:	2104      	movs	r1, #4
c0d02294:	f001 fd1c 	bl	c0d03cd0 <longjmp>
c0d02298:	60000200 	.word	0x60000200
c0d0229c:	20001bb8 	.word	0x20001bb8
c0d022a0:	900002f1 	.word	0x900002f1

c0d022a4 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d022a4:	b5d0      	push	{r4, r6, r7, lr}
c0d022a6:	af02      	add	r7, sp, #8
c0d022a8:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d022aa:	4b0a      	ldr	r3, [pc, #40]	; (c0d022d4 <nvm_write+0x30>)
c0d022ac:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022ae:	4b0a      	ldr	r3, [pc, #40]	; (c0d022d8 <nvm_write+0x34>)
c0d022b0:	681c      	ldr	r4, [r3, #0]
c0d022b2:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d022b4:	ac03      	add	r4, sp, #12
c0d022b6:	c407      	stmia	r4!, {r0, r1, r2}
c0d022b8:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022ba:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022bc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022be:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d022c0:	4806      	ldr	r0, [pc, #24]	; (c0d022dc <nvm_write+0x38>)
c0d022c2:	9901      	ldr	r1, [sp, #4]
c0d022c4:	4281      	cmp	r1, r0
c0d022c6:	d101      	bne.n	c0d022cc <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d022c8:	b006      	add	sp, #24
c0d022ca:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022cc:	6818      	ldr	r0, [r3, #0]
c0d022ce:	2104      	movs	r1, #4
c0d022d0:	f001 fcfe 	bl	c0d03cd0 <longjmp>
c0d022d4:	6000037f 	.word	0x6000037f
c0d022d8:	20001bb8 	.word	0x20001bb8
c0d022dc:	900003bc 	.word	0x900003bc

c0d022e0 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d022e0:	b580      	push	{r7, lr}
c0d022e2:	af00      	add	r7, sp, #0
c0d022e4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d022e6:	4a0a      	ldr	r2, [pc, #40]	; (c0d02310 <cx_rng+0x30>)
c0d022e8:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022ea:	4a0a      	ldr	r2, [pc, #40]	; (c0d02314 <cx_rng+0x34>)
c0d022ec:	6813      	ldr	r3, [r2, #0]
c0d022ee:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d022f0:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d022f2:	9103      	str	r1, [sp, #12]
c0d022f4:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022f6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022f8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022fa:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d022fc:	4906      	ldr	r1, [pc, #24]	; (c0d02318 <cx_rng+0x38>)
c0d022fe:	9b00      	ldr	r3, [sp, #0]
c0d02300:	428b      	cmp	r3, r1
c0d02302:	d101      	bne.n	c0d02308 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d02304:	b004      	add	sp, #16
c0d02306:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02308:	6810      	ldr	r0, [r2, #0]
c0d0230a:	2104      	movs	r1, #4
c0d0230c:	f001 fce0 	bl	c0d03cd0 <longjmp>
c0d02310:	6000052c 	.word	0x6000052c
c0d02314:	20001bb8 	.word	0x20001bb8
c0d02318:	90000567 	.word	0x90000567

c0d0231c <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d0231c:	b580      	push	{r7, lr}
c0d0231e:	af00      	add	r7, sp, #0
c0d02320:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d02322:	490a      	ldr	r1, [pc, #40]	; (c0d0234c <cx_sha256_init+0x30>)
c0d02324:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02326:	490a      	ldr	r1, [pc, #40]	; (c0d02350 <cx_sha256_init+0x34>)
c0d02328:	680a      	ldr	r2, [r1, #0]
c0d0232a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d0232c:	9003      	str	r0, [sp, #12]
c0d0232e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02330:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02332:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02334:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d02336:	4a07      	ldr	r2, [pc, #28]	; (c0d02354 <cx_sha256_init+0x38>)
c0d02338:	9b01      	ldr	r3, [sp, #4]
c0d0233a:	4293      	cmp	r3, r2
c0d0233c:	d101      	bne.n	c0d02342 <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0233e:	b004      	add	sp, #16
c0d02340:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02342:	6808      	ldr	r0, [r1, #0]
c0d02344:	2104      	movs	r1, #4
c0d02346:	f001 fcc3 	bl	c0d03cd0 <longjmp>
c0d0234a:	46c0      	nop			; (mov r8, r8)
c0d0234c:	600008db 	.word	0x600008db
c0d02350:	20001bb8 	.word	0x20001bb8
c0d02354:	90000864 	.word	0x90000864

c0d02358 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d02358:	b580      	push	{r7, lr}
c0d0235a:	af00      	add	r7, sp, #0
c0d0235c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d0235e:	4a0a      	ldr	r2, [pc, #40]	; (c0d02388 <cx_keccak_init+0x30>)
c0d02360:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02362:	4a0a      	ldr	r2, [pc, #40]	; (c0d0238c <cx_keccak_init+0x34>)
c0d02364:	6813      	ldr	r3, [r2, #0]
c0d02366:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d02368:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d0236a:	9103      	str	r1, [sp, #12]
c0d0236c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0236e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02370:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02372:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d02374:	4906      	ldr	r1, [pc, #24]	; (c0d02390 <cx_keccak_init+0x38>)
c0d02376:	9b00      	ldr	r3, [sp, #0]
c0d02378:	428b      	cmp	r3, r1
c0d0237a:	d101      	bne.n	c0d02380 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0237c:	b004      	add	sp, #16
c0d0237e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02380:	6810      	ldr	r0, [r2, #0]
c0d02382:	2104      	movs	r1, #4
c0d02384:	f001 fca4 	bl	c0d03cd0 <longjmp>
c0d02388:	60000c3c 	.word	0x60000c3c
c0d0238c:	20001bb8 	.word	0x20001bb8
c0d02390:	90000c39 	.word	0x90000c39

c0d02394 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d02394:	b5b0      	push	{r4, r5, r7, lr}
c0d02396:	af02      	add	r7, sp, #8
c0d02398:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d0239a:	4c0b      	ldr	r4, [pc, #44]	; (c0d023c8 <cx_hash+0x34>)
c0d0239c:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0239e:	4c0b      	ldr	r4, [pc, #44]	; (c0d023cc <cx_hash+0x38>)
c0d023a0:	6825      	ldr	r5, [r4, #0]
c0d023a2:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d023a4:	ad03      	add	r5, sp, #12
c0d023a6:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d023a8:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d023aa:	9007      	str	r0, [sp, #28]
c0d023ac:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d023ae:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d023b0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d023b2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d023b4:	4906      	ldr	r1, [pc, #24]	; (c0d023d0 <cx_hash+0x3c>)
c0d023b6:	9a01      	ldr	r2, [sp, #4]
c0d023b8:	428a      	cmp	r2, r1
c0d023ba:	d101      	bne.n	c0d023c0 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d023bc:	b008      	add	sp, #32
c0d023be:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023c0:	6820      	ldr	r0, [r4, #0]
c0d023c2:	2104      	movs	r1, #4
c0d023c4:	f001 fc84 	bl	c0d03cd0 <longjmp>
c0d023c8:	60000ea6 	.word	0x60000ea6
c0d023cc:	20001bb8 	.word	0x20001bb8
c0d023d0:	90000e46 	.word	0x90000e46

c0d023d4 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d023d4:	b5b0      	push	{r4, r5, r7, lr}
c0d023d6:	af02      	add	r7, sp, #8
c0d023d8:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d023da:	4c0a      	ldr	r4, [pc, #40]	; (c0d02404 <cx_ecfp_init_public_key+0x30>)
c0d023dc:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d023de:	4c0a      	ldr	r4, [pc, #40]	; (c0d02408 <cx_ecfp_init_public_key+0x34>)
c0d023e0:	6825      	ldr	r5, [r4, #0]
c0d023e2:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d023e4:	ad02      	add	r5, sp, #8
c0d023e6:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d023e8:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d023ea:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d023ec:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d023ee:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d023f0:	4906      	ldr	r1, [pc, #24]	; (c0d0240c <cx_ecfp_init_public_key+0x38>)
c0d023f2:	9a00      	ldr	r2, [sp, #0]
c0d023f4:	428a      	cmp	r2, r1
c0d023f6:	d101      	bne.n	c0d023fc <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d023f8:	b006      	add	sp, #24
c0d023fa:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023fc:	6820      	ldr	r0, [r4, #0]
c0d023fe:	2104      	movs	r1, #4
c0d02400:	f001 fc66 	bl	c0d03cd0 <longjmp>
c0d02404:	60002835 	.word	0x60002835
c0d02408:	20001bb8 	.word	0x20001bb8
c0d0240c:	900028f0 	.word	0x900028f0

c0d02410 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d02410:	b5b0      	push	{r4, r5, r7, lr}
c0d02412:	af02      	add	r7, sp, #8
c0d02414:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d02416:	4c0a      	ldr	r4, [pc, #40]	; (c0d02440 <cx_ecfp_init_private_key+0x30>)
c0d02418:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0241a:	4c0a      	ldr	r4, [pc, #40]	; (c0d02444 <cx_ecfp_init_private_key+0x34>)
c0d0241c:	6825      	ldr	r5, [r4, #0]
c0d0241e:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02420:	ad02      	add	r5, sp, #8
c0d02422:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02424:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02426:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02428:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0242a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d0242c:	4906      	ldr	r1, [pc, #24]	; (c0d02448 <cx_ecfp_init_private_key+0x38>)
c0d0242e:	9a00      	ldr	r2, [sp, #0]
c0d02430:	428a      	cmp	r2, r1
c0d02432:	d101      	bne.n	c0d02438 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02434:	b006      	add	sp, #24
c0d02436:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02438:	6820      	ldr	r0, [r4, #0]
c0d0243a:	2104      	movs	r1, #4
c0d0243c:	f001 fc48 	bl	c0d03cd0 <longjmp>
c0d02440:	600029ed 	.word	0x600029ed
c0d02444:	20001bb8 	.word	0x20001bb8
c0d02448:	900029ae 	.word	0x900029ae

c0d0244c <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d0244c:	b5b0      	push	{r4, r5, r7, lr}
c0d0244e:	af02      	add	r7, sp, #8
c0d02450:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d02452:	4c0a      	ldr	r4, [pc, #40]	; (c0d0247c <cx_ecfp_generate_pair+0x30>)
c0d02454:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02456:	4c0a      	ldr	r4, [pc, #40]	; (c0d02480 <cx_ecfp_generate_pair+0x34>)
c0d02458:	6825      	ldr	r5, [r4, #0]
c0d0245a:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d0245c:	ad02      	add	r5, sp, #8
c0d0245e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02460:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02462:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02464:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02466:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d02468:	4906      	ldr	r1, [pc, #24]	; (c0d02484 <cx_ecfp_generate_pair+0x38>)
c0d0246a:	9a00      	ldr	r2, [sp, #0]
c0d0246c:	428a      	cmp	r2, r1
c0d0246e:	d101      	bne.n	c0d02474 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02470:	b006      	add	sp, #24
c0d02472:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02474:	6820      	ldr	r0, [r4, #0]
c0d02476:	2104      	movs	r1, #4
c0d02478:	f001 fc2a 	bl	c0d03cd0 <longjmp>
c0d0247c:	60002a2e 	.word	0x60002a2e
c0d02480:	20001bb8 	.word	0x20001bb8
c0d02484:	90002a74 	.word	0x90002a74

c0d02488 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d02488:	b5b0      	push	{r4, r5, r7, lr}
c0d0248a:	af02      	add	r7, sp, #8
c0d0248c:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d0248e:	4c0b      	ldr	r4, [pc, #44]	; (c0d024bc <os_perso_derive_node_bip32+0x34>)
c0d02490:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02492:	4c0b      	ldr	r4, [pc, #44]	; (c0d024c0 <os_perso_derive_node_bip32+0x38>)
c0d02494:	6825      	ldr	r5, [r4, #0]
c0d02496:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d02498:	ad03      	add	r5, sp, #12
c0d0249a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d0249c:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d0249e:	9007      	str	r0, [sp, #28]
c0d024a0:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d024a2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d024a4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d024a6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d024a8:	4806      	ldr	r0, [pc, #24]	; (c0d024c4 <os_perso_derive_node_bip32+0x3c>)
c0d024aa:	9901      	ldr	r1, [sp, #4]
c0d024ac:	4281      	cmp	r1, r0
c0d024ae:	d101      	bne.n	c0d024b4 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d024b0:	b008      	add	sp, #32
c0d024b2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d024b4:	6820      	ldr	r0, [r4, #0]
c0d024b6:	2104      	movs	r1, #4
c0d024b8:	f001 fc0a 	bl	c0d03cd0 <longjmp>
c0d024bc:	6000512b 	.word	0x6000512b
c0d024c0:	20001bb8 	.word	0x20001bb8
c0d024c4:	9000517f 	.word	0x9000517f

c0d024c8 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d024c8:	b580      	push	{r7, lr}
c0d024ca:	af00      	add	r7, sp, #0
c0d024cc:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d024ce:	490a      	ldr	r1, [pc, #40]	; (c0d024f8 <os_sched_exit+0x30>)
c0d024d0:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d024d2:	490a      	ldr	r1, [pc, #40]	; (c0d024fc <os_sched_exit+0x34>)
c0d024d4:	680a      	ldr	r2, [r1, #0]
c0d024d6:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d024d8:	9003      	str	r0, [sp, #12]
c0d024da:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d024dc:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d024de:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d024e0:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d024e2:	4807      	ldr	r0, [pc, #28]	; (c0d02500 <os_sched_exit+0x38>)
c0d024e4:	9a01      	ldr	r2, [sp, #4]
c0d024e6:	4282      	cmp	r2, r0
c0d024e8:	d101      	bne.n	c0d024ee <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d024ea:	b004      	add	sp, #16
c0d024ec:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d024ee:	6808      	ldr	r0, [r1, #0]
c0d024f0:	2104      	movs	r1, #4
c0d024f2:	f001 fbed 	bl	c0d03cd0 <longjmp>
c0d024f6:	46c0      	nop			; (mov r8, r8)
c0d024f8:	60005fe1 	.word	0x60005fe1
c0d024fc:	20001bb8 	.word	0x20001bb8
c0d02500:	90005f6f 	.word	0x90005f6f

c0d02504 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d02504:	b580      	push	{r7, lr}
c0d02506:	af00      	add	r7, sp, #0
c0d02508:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d0250a:	490a      	ldr	r1, [pc, #40]	; (c0d02534 <os_ux+0x30>)
c0d0250c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0250e:	490a      	ldr	r1, [pc, #40]	; (c0d02538 <os_ux+0x34>)
c0d02510:	680a      	ldr	r2, [r1, #0]
c0d02512:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d02514:	9003      	str	r0, [sp, #12]
c0d02516:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02518:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0251a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0251c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d0251e:	4a07      	ldr	r2, [pc, #28]	; (c0d0253c <os_ux+0x38>)
c0d02520:	9b01      	ldr	r3, [sp, #4]
c0d02522:	4293      	cmp	r3, r2
c0d02524:	d101      	bne.n	c0d0252a <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02526:	b004      	add	sp, #16
c0d02528:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0252a:	6808      	ldr	r0, [r1, #0]
c0d0252c:	2104      	movs	r1, #4
c0d0252e:	f001 fbcf 	bl	c0d03cd0 <longjmp>
c0d02532:	46c0      	nop			; (mov r8, r8)
c0d02534:	60006158 	.word	0x60006158
c0d02538:	20001bb8 	.word	0x20001bb8
c0d0253c:	9000611f 	.word	0x9000611f

c0d02540 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d02540:	b580      	push	{r7, lr}
c0d02542:	af00      	add	r7, sp, #0
c0d02544:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d02546:	4809      	ldr	r0, [pc, #36]	; (c0d0256c <os_seph_features+0x2c>)
c0d02548:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0254a:	4909      	ldr	r1, [pc, #36]	; (c0d02570 <os_seph_features+0x30>)
c0d0254c:	6808      	ldr	r0, [r1, #0]
c0d0254e:	9001      	str	r0, [sp, #4]
c0d02550:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02552:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02554:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02556:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d02558:	4a06      	ldr	r2, [pc, #24]	; (c0d02574 <os_seph_features+0x34>)
c0d0255a:	9b00      	ldr	r3, [sp, #0]
c0d0255c:	4293      	cmp	r3, r2
c0d0255e:	d101      	bne.n	c0d02564 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02560:	b002      	add	sp, #8
c0d02562:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02564:	6808      	ldr	r0, [r1, #0]
c0d02566:	2104      	movs	r1, #4
c0d02568:	f001 fbb2 	bl	c0d03cd0 <longjmp>
c0d0256c:	600064d6 	.word	0x600064d6
c0d02570:	20001bb8 	.word	0x20001bb8
c0d02574:	90006444 	.word	0x90006444

c0d02578 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d02578:	b580      	push	{r7, lr}
c0d0257a:	af00      	add	r7, sp, #0
c0d0257c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d0257e:	4a0a      	ldr	r2, [pc, #40]	; (c0d025a8 <io_seproxyhal_spi_send+0x30>)
c0d02580:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02582:	4a0a      	ldr	r2, [pc, #40]	; (c0d025ac <io_seproxyhal_spi_send+0x34>)
c0d02584:	6813      	ldr	r3, [r2, #0]
c0d02586:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d02588:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d0258a:	9103      	str	r1, [sp, #12]
c0d0258c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0258e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02590:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02592:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d02594:	4806      	ldr	r0, [pc, #24]	; (c0d025b0 <io_seproxyhal_spi_send+0x38>)
c0d02596:	9900      	ldr	r1, [sp, #0]
c0d02598:	4281      	cmp	r1, r0
c0d0259a:	d101      	bne.n	c0d025a0 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0259c:	b004      	add	sp, #16
c0d0259e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d025a0:	6810      	ldr	r0, [r2, #0]
c0d025a2:	2104      	movs	r1, #4
c0d025a4:	f001 fb94 	bl	c0d03cd0 <longjmp>
c0d025a8:	60006a1c 	.word	0x60006a1c
c0d025ac:	20001bb8 	.word	0x20001bb8
c0d025b0:	90006af3 	.word	0x90006af3

c0d025b4 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d025b4:	b580      	push	{r7, lr}
c0d025b6:	af00      	add	r7, sp, #0
c0d025b8:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d025ba:	4809      	ldr	r0, [pc, #36]	; (c0d025e0 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d025bc:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d025be:	4909      	ldr	r1, [pc, #36]	; (c0d025e4 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d025c0:	6808      	ldr	r0, [r1, #0]
c0d025c2:	9001      	str	r0, [sp, #4]
c0d025c4:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d025c6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d025c8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d025ca:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d025cc:	4a06      	ldr	r2, [pc, #24]	; (c0d025e8 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d025ce:	9b00      	ldr	r3, [sp, #0]
c0d025d0:	4293      	cmp	r3, r2
c0d025d2:	d101      	bne.n	c0d025d8 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d025d4:	b002      	add	sp, #8
c0d025d6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d025d8:	6808      	ldr	r0, [r1, #0]
c0d025da:	2104      	movs	r1, #4
c0d025dc:	f001 fb78 	bl	c0d03cd0 <longjmp>
c0d025e0:	60006bcf 	.word	0x60006bcf
c0d025e4:	20001bb8 	.word	0x20001bb8
c0d025e8:	90006b7f 	.word	0x90006b7f

c0d025ec <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d025ec:	b5d0      	push	{r4, r6, r7, lr}
c0d025ee:	af02      	add	r7, sp, #8
c0d025f0:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d025f2:	4b0b      	ldr	r3, [pc, #44]	; (c0d02620 <io_seproxyhal_spi_recv+0x34>)
c0d025f4:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d025f6:	4b0b      	ldr	r3, [pc, #44]	; (c0d02624 <io_seproxyhal_spi_recv+0x38>)
c0d025f8:	681c      	ldr	r4, [r3, #0]
c0d025fa:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d025fc:	ac03      	add	r4, sp, #12
c0d025fe:	c407      	stmia	r4!, {r0, r1, r2}
c0d02600:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02602:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02604:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02606:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d02608:	4907      	ldr	r1, [pc, #28]	; (c0d02628 <io_seproxyhal_spi_recv+0x3c>)
c0d0260a:	9a01      	ldr	r2, [sp, #4]
c0d0260c:	428a      	cmp	r2, r1
c0d0260e:	d102      	bne.n	c0d02616 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d02610:	b280      	uxth	r0, r0
c0d02612:	b006      	add	sp, #24
c0d02614:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02616:	6818      	ldr	r0, [r3, #0]
c0d02618:	2104      	movs	r1, #4
c0d0261a:	f001 fb59 	bl	c0d03cd0 <longjmp>
c0d0261e:	46c0      	nop			; (mov r8, r8)
c0d02620:	60006cd1 	.word	0x60006cd1
c0d02624:	20001bb8 	.word	0x20001bb8
c0d02628:	90006c2b 	.word	0x90006c2b

c0d0262c <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d0262c:	b5b0      	push	{r4, r5, r7, lr}
c0d0262e:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d02630:	492c      	ldr	r1, [pc, #176]	; (c0d026e4 <bagl_ui_nanos_screen1_button+0xb8>)
c0d02632:	4288      	cmp	r0, r1
c0d02634:	d006      	beq.n	c0d02644 <bagl_ui_nanos_screen1_button+0x18>
c0d02636:	492c      	ldr	r1, [pc, #176]	; (c0d026e8 <bagl_ui_nanos_screen1_button+0xbc>)
c0d02638:	4288      	cmp	r0, r1
c0d0263a:	d151      	bne.n	c0d026e0 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d0263c:	2000      	movs	r0, #0
c0d0263e:	f7ff ff43 	bl	c0d024c8 <os_sched_exit>
c0d02642:	e04d      	b.n	c0d026e0 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d02644:	f7fe fba4 	bl	c0d00d90 <nvram_is_init>
c0d02648:	2801      	cmp	r0, #1
c0d0264a:	d102      	bne.n	c0d02652 <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d0264c:	a029      	add	r0, pc, #164	; (adr r0, c0d026f4 <bagl_ui_nanos_screen1_button+0xc8>)
c0d0264e:	210d      	movs	r1, #13
c0d02650:	e001      	b.n	c0d02656 <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d02652:	a026      	add	r0, pc, #152	; (adr r0, c0d026ec <bagl_ui_nanos_screen1_button+0xc0>)
c0d02654:	2105      	movs	r1, #5
c0d02656:	2203      	movs	r2, #3
c0d02658:	f7fd fe0e 	bl	c0d00278 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d0265c:	4c29      	ldr	r4, [pc, #164]	; (c0d02704 <bagl_ui_nanos_screen1_button+0xd8>)
c0d0265e:	482b      	ldr	r0, [pc, #172]	; (c0d0270c <bagl_ui_nanos_screen1_button+0xe0>)
c0d02660:	4478      	add	r0, pc
c0d02662:	6020      	str	r0, [r4, #0]
c0d02664:	2004      	movs	r0, #4
c0d02666:	6060      	str	r0, [r4, #4]
c0d02668:	4829      	ldr	r0, [pc, #164]	; (c0d02710 <bagl_ui_nanos_screen1_button+0xe4>)
c0d0266a:	4478      	add	r0, pc
c0d0266c:	6120      	str	r0, [r4, #16]
c0d0266e:	2500      	movs	r5, #0
c0d02670:	60e5      	str	r5, [r4, #12]
c0d02672:	2003      	movs	r0, #3
c0d02674:	7620      	strb	r0, [r4, #24]
c0d02676:	61e5      	str	r5, [r4, #28]
c0d02678:	4620      	mov	r0, r4
c0d0267a:	3018      	adds	r0, #24
c0d0267c:	f7ff ff42 	bl	c0d02504 <os_ux>
c0d02680:	61e0      	str	r0, [r4, #28]
c0d02682:	f7ff f903 	bl	c0d0188c <io_seproxyhal_init_ux>
c0d02686:	60a5      	str	r5, [r4, #8]
c0d02688:	6820      	ldr	r0, [r4, #0]
c0d0268a:	2800      	cmp	r0, #0
c0d0268c:	d028      	beq.n	c0d026e0 <bagl_ui_nanos_screen1_button+0xb4>
c0d0268e:	69e0      	ldr	r0, [r4, #28]
c0d02690:	491d      	ldr	r1, [pc, #116]	; (c0d02708 <bagl_ui_nanos_screen1_button+0xdc>)
c0d02692:	4288      	cmp	r0, r1
c0d02694:	d116      	bne.n	c0d026c4 <bagl_ui_nanos_screen1_button+0x98>
c0d02696:	e023      	b.n	c0d026e0 <bagl_ui_nanos_screen1_button+0xb4>
c0d02698:	6860      	ldr	r0, [r4, #4]
c0d0269a:	4285      	cmp	r5, r0
c0d0269c:	d220      	bcs.n	c0d026e0 <bagl_ui_nanos_screen1_button+0xb4>
c0d0269e:	f7ff ff89 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d026a2:	2800      	cmp	r0, #0
c0d026a4:	d11c      	bne.n	c0d026e0 <bagl_ui_nanos_screen1_button+0xb4>
c0d026a6:	68a0      	ldr	r0, [r4, #8]
c0d026a8:	68e1      	ldr	r1, [r4, #12]
c0d026aa:	2538      	movs	r5, #56	; 0x38
c0d026ac:	4368      	muls	r0, r5
c0d026ae:	6822      	ldr	r2, [r4, #0]
c0d026b0:	1810      	adds	r0, r2, r0
c0d026b2:	2900      	cmp	r1, #0
c0d026b4:	d009      	beq.n	c0d026ca <bagl_ui_nanos_screen1_button+0x9e>
c0d026b6:	4788      	blx	r1
c0d026b8:	2800      	cmp	r0, #0
c0d026ba:	d106      	bne.n	c0d026ca <bagl_ui_nanos_screen1_button+0x9e>
c0d026bc:	68a0      	ldr	r0, [r4, #8]
c0d026be:	1c45      	adds	r5, r0, #1
c0d026c0:	60a5      	str	r5, [r4, #8]
c0d026c2:	6820      	ldr	r0, [r4, #0]
c0d026c4:	2800      	cmp	r0, #0
c0d026c6:	d1e7      	bne.n	c0d02698 <bagl_ui_nanos_screen1_button+0x6c>
c0d026c8:	e00a      	b.n	c0d026e0 <bagl_ui_nanos_screen1_button+0xb4>
c0d026ca:	2801      	cmp	r0, #1
c0d026cc:	d103      	bne.n	c0d026d6 <bagl_ui_nanos_screen1_button+0xaa>
c0d026ce:	68a0      	ldr	r0, [r4, #8]
c0d026d0:	4345      	muls	r5, r0
c0d026d2:	6820      	ldr	r0, [r4, #0]
c0d026d4:	1940      	adds	r0, r0, r5
c0d026d6:	f7fe fb91 	bl	c0d00dfc <io_seproxyhal_display>
c0d026da:	68a0      	ldr	r0, [r4, #8]
c0d026dc:	1c40      	adds	r0, r0, #1
c0d026de:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d026e0:	2000      	movs	r0, #0
c0d026e2:	bdb0      	pop	{r4, r5, r7, pc}
c0d026e4:	80000002 	.word	0x80000002
c0d026e8:	80000001 	.word	0x80000001
c0d026ec:	54494e49 	.word	0x54494e49
c0d026f0:	00000000 	.word	0x00000000
c0d026f4:	6c697453 	.word	0x6c697453
c0d026f8:	6e75206c 	.word	0x6e75206c
c0d026fc:	74696e69 	.word	0x74696e69
c0d02700:	00000000 	.word	0x00000000
c0d02704:	20001a98 	.word	0x20001a98
c0d02708:	b0105044 	.word	0xb0105044
c0d0270c:	000018a8 	.word	0x000018a8
c0d02710:	00000153 	.word	0x00000153

c0d02714 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d02714:	b5b0      	push	{r4, r5, r7, lr}
c0d02716:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d02718:	2800      	cmp	r0, #0
c0d0271a:	d005      	beq.n	c0d02728 <ui_display_debug+0x14>
c0d0271c:	2900      	cmp	r1, #0
c0d0271e:	d003      	beq.n	c0d02728 <ui_display_debug+0x14>
c0d02720:	2a00      	cmp	r2, #0
c0d02722:	d001      	beq.n	c0d02728 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d02724:	f7fd fda8 	bl	c0d00278 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02728:	4c21      	ldr	r4, [pc, #132]	; (c0d027b0 <ui_display_debug+0x9c>)
c0d0272a:	4823      	ldr	r0, [pc, #140]	; (c0d027b8 <ui_display_debug+0xa4>)
c0d0272c:	4478      	add	r0, pc
c0d0272e:	6020      	str	r0, [r4, #0]
c0d02730:	2004      	movs	r0, #4
c0d02732:	6060      	str	r0, [r4, #4]
c0d02734:	4821      	ldr	r0, [pc, #132]	; (c0d027bc <ui_display_debug+0xa8>)
c0d02736:	4478      	add	r0, pc
c0d02738:	6120      	str	r0, [r4, #16]
c0d0273a:	2500      	movs	r5, #0
c0d0273c:	60e5      	str	r5, [r4, #12]
c0d0273e:	2003      	movs	r0, #3
c0d02740:	7620      	strb	r0, [r4, #24]
c0d02742:	61e5      	str	r5, [r4, #28]
c0d02744:	4620      	mov	r0, r4
c0d02746:	3018      	adds	r0, #24
c0d02748:	f7ff fedc 	bl	c0d02504 <os_ux>
c0d0274c:	61e0      	str	r0, [r4, #28]
c0d0274e:	f7ff f89d 	bl	c0d0188c <io_seproxyhal_init_ux>
c0d02752:	60a5      	str	r5, [r4, #8]
c0d02754:	6820      	ldr	r0, [r4, #0]
c0d02756:	2800      	cmp	r0, #0
c0d02758:	d028      	beq.n	c0d027ac <ui_display_debug+0x98>
c0d0275a:	69e0      	ldr	r0, [r4, #28]
c0d0275c:	4915      	ldr	r1, [pc, #84]	; (c0d027b4 <ui_display_debug+0xa0>)
c0d0275e:	4288      	cmp	r0, r1
c0d02760:	d116      	bne.n	c0d02790 <ui_display_debug+0x7c>
c0d02762:	e023      	b.n	c0d027ac <ui_display_debug+0x98>
c0d02764:	6860      	ldr	r0, [r4, #4]
c0d02766:	4285      	cmp	r5, r0
c0d02768:	d220      	bcs.n	c0d027ac <ui_display_debug+0x98>
c0d0276a:	f7ff ff23 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d0276e:	2800      	cmp	r0, #0
c0d02770:	d11c      	bne.n	c0d027ac <ui_display_debug+0x98>
c0d02772:	68a0      	ldr	r0, [r4, #8]
c0d02774:	68e1      	ldr	r1, [r4, #12]
c0d02776:	2538      	movs	r5, #56	; 0x38
c0d02778:	4368      	muls	r0, r5
c0d0277a:	6822      	ldr	r2, [r4, #0]
c0d0277c:	1810      	adds	r0, r2, r0
c0d0277e:	2900      	cmp	r1, #0
c0d02780:	d009      	beq.n	c0d02796 <ui_display_debug+0x82>
c0d02782:	4788      	blx	r1
c0d02784:	2800      	cmp	r0, #0
c0d02786:	d106      	bne.n	c0d02796 <ui_display_debug+0x82>
c0d02788:	68a0      	ldr	r0, [r4, #8]
c0d0278a:	1c45      	adds	r5, r0, #1
c0d0278c:	60a5      	str	r5, [r4, #8]
c0d0278e:	6820      	ldr	r0, [r4, #0]
c0d02790:	2800      	cmp	r0, #0
c0d02792:	d1e7      	bne.n	c0d02764 <ui_display_debug+0x50>
c0d02794:	e00a      	b.n	c0d027ac <ui_display_debug+0x98>
c0d02796:	2801      	cmp	r0, #1
c0d02798:	d103      	bne.n	c0d027a2 <ui_display_debug+0x8e>
c0d0279a:	68a0      	ldr	r0, [r4, #8]
c0d0279c:	4345      	muls	r5, r0
c0d0279e:	6820      	ldr	r0, [r4, #0]
c0d027a0:	1940      	adds	r0, r0, r5
c0d027a2:	f7fe fb2b 	bl	c0d00dfc <io_seproxyhal_display>
c0d027a6:	68a0      	ldr	r0, [r4, #8]
c0d027a8:	1c40      	adds	r0, r0, #1
c0d027aa:	60a0      	str	r0, [r4, #8]
}
c0d027ac:	bdb0      	pop	{r4, r5, r7, pc}
c0d027ae:	46c0      	nop			; (mov r8, r8)
c0d027b0:	20001a98 	.word	0x20001a98
c0d027b4:	b0105044 	.word	0xb0105044
c0d027b8:	000017dc 	.word	0x000017dc
c0d027bc:	00000087 	.word	0x00000087

c0d027c0 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d027c0:	b580      	push	{r7, lr}
c0d027c2:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d027c4:	4905      	ldr	r1, [pc, #20]	; (c0d027dc <bagl_ui_nanos_screen2_button+0x1c>)
c0d027c6:	4288      	cmp	r0, r1
c0d027c8:	d002      	beq.n	c0d027d0 <bagl_ui_nanos_screen2_button+0x10>
c0d027ca:	4905      	ldr	r1, [pc, #20]	; (c0d027e0 <bagl_ui_nanos_screen2_button+0x20>)
c0d027cc:	4288      	cmp	r0, r1
c0d027ce:	d102      	bne.n	c0d027d6 <bagl_ui_nanos_screen2_button+0x16>
c0d027d0:	2000      	movs	r0, #0
c0d027d2:	f7ff fe79 	bl	c0d024c8 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d027d6:	2000      	movs	r0, #0
c0d027d8:	bd80      	pop	{r7, pc}
c0d027da:	46c0      	nop			; (mov r8, r8)
c0d027dc:	80000002 	.word	0x80000002
c0d027e0:	80000001 	.word	0x80000001

c0d027e4 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d027e4:	b5b0      	push	{r4, r5, r7, lr}
c0d027e6:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d027e8:	2001      	movs	r0, #1
c0d027ea:	0204      	lsls	r4, r0, #8
c0d027ec:	f7ff fea8 	bl	c0d02540 <os_seph_features>
c0d027f0:	4220      	tst	r0, r4
c0d027f2:	d136      	bne.n	c0d02862 <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d027f4:	4c3c      	ldr	r4, [pc, #240]	; (c0d028e8 <ui_idle+0x104>)
c0d027f6:	4840      	ldr	r0, [pc, #256]	; (c0d028f8 <ui_idle+0x114>)
c0d027f8:	4478      	add	r0, pc
c0d027fa:	6020      	str	r0, [r4, #0]
c0d027fc:	2004      	movs	r0, #4
c0d027fe:	6060      	str	r0, [r4, #4]
c0d02800:	483e      	ldr	r0, [pc, #248]	; (c0d028fc <ui_idle+0x118>)
c0d02802:	4478      	add	r0, pc
c0d02804:	6120      	str	r0, [r4, #16]
c0d02806:	2500      	movs	r5, #0
c0d02808:	60e5      	str	r5, [r4, #12]
c0d0280a:	2003      	movs	r0, #3
c0d0280c:	7620      	strb	r0, [r4, #24]
c0d0280e:	61e5      	str	r5, [r4, #28]
c0d02810:	4620      	mov	r0, r4
c0d02812:	3018      	adds	r0, #24
c0d02814:	f7ff fe76 	bl	c0d02504 <os_ux>
c0d02818:	61e0      	str	r0, [r4, #28]
c0d0281a:	f7ff f837 	bl	c0d0188c <io_seproxyhal_init_ux>
c0d0281e:	60a5      	str	r5, [r4, #8]
c0d02820:	6820      	ldr	r0, [r4, #0]
c0d02822:	2800      	cmp	r0, #0
c0d02824:	d05f      	beq.n	c0d028e6 <ui_idle+0x102>
c0d02826:	69e0      	ldr	r0, [r4, #28]
c0d02828:	4930      	ldr	r1, [pc, #192]	; (c0d028ec <ui_idle+0x108>)
c0d0282a:	4288      	cmp	r0, r1
c0d0282c:	d116      	bne.n	c0d0285c <ui_idle+0x78>
c0d0282e:	e05a      	b.n	c0d028e6 <ui_idle+0x102>
c0d02830:	6860      	ldr	r0, [r4, #4]
c0d02832:	4285      	cmp	r5, r0
c0d02834:	d257      	bcs.n	c0d028e6 <ui_idle+0x102>
c0d02836:	f7ff febd 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d0283a:	2800      	cmp	r0, #0
c0d0283c:	d153      	bne.n	c0d028e6 <ui_idle+0x102>
c0d0283e:	68a0      	ldr	r0, [r4, #8]
c0d02840:	68e1      	ldr	r1, [r4, #12]
c0d02842:	2538      	movs	r5, #56	; 0x38
c0d02844:	4368      	muls	r0, r5
c0d02846:	6822      	ldr	r2, [r4, #0]
c0d02848:	1810      	adds	r0, r2, r0
c0d0284a:	2900      	cmp	r1, #0
c0d0284c:	d040      	beq.n	c0d028d0 <ui_idle+0xec>
c0d0284e:	4788      	blx	r1
c0d02850:	2800      	cmp	r0, #0
c0d02852:	d13d      	bne.n	c0d028d0 <ui_idle+0xec>
c0d02854:	68a0      	ldr	r0, [r4, #8]
c0d02856:	1c45      	adds	r5, r0, #1
c0d02858:	60a5      	str	r5, [r4, #8]
c0d0285a:	6820      	ldr	r0, [r4, #0]
c0d0285c:	2800      	cmp	r0, #0
c0d0285e:	d1e7      	bne.n	c0d02830 <ui_idle+0x4c>
c0d02860:	e041      	b.n	c0d028e6 <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d02862:	4c21      	ldr	r4, [pc, #132]	; (c0d028e8 <ui_idle+0x104>)
c0d02864:	4822      	ldr	r0, [pc, #136]	; (c0d028f0 <ui_idle+0x10c>)
c0d02866:	4478      	add	r0, pc
c0d02868:	6020      	str	r0, [r4, #0]
c0d0286a:	2004      	movs	r0, #4
c0d0286c:	6060      	str	r0, [r4, #4]
c0d0286e:	4821      	ldr	r0, [pc, #132]	; (c0d028f4 <ui_idle+0x110>)
c0d02870:	4478      	add	r0, pc
c0d02872:	6120      	str	r0, [r4, #16]
c0d02874:	2500      	movs	r5, #0
c0d02876:	60e5      	str	r5, [r4, #12]
c0d02878:	2003      	movs	r0, #3
c0d0287a:	7620      	strb	r0, [r4, #24]
c0d0287c:	61e5      	str	r5, [r4, #28]
c0d0287e:	4620      	mov	r0, r4
c0d02880:	3018      	adds	r0, #24
c0d02882:	f7ff fe3f 	bl	c0d02504 <os_ux>
c0d02886:	61e0      	str	r0, [r4, #28]
c0d02888:	f7ff f800 	bl	c0d0188c <io_seproxyhal_init_ux>
c0d0288c:	60a5      	str	r5, [r4, #8]
c0d0288e:	6820      	ldr	r0, [r4, #0]
c0d02890:	2800      	cmp	r0, #0
c0d02892:	d028      	beq.n	c0d028e6 <ui_idle+0x102>
c0d02894:	69e0      	ldr	r0, [r4, #28]
c0d02896:	4915      	ldr	r1, [pc, #84]	; (c0d028ec <ui_idle+0x108>)
c0d02898:	4288      	cmp	r0, r1
c0d0289a:	d116      	bne.n	c0d028ca <ui_idle+0xe6>
c0d0289c:	e023      	b.n	c0d028e6 <ui_idle+0x102>
c0d0289e:	6860      	ldr	r0, [r4, #4]
c0d028a0:	4285      	cmp	r5, r0
c0d028a2:	d220      	bcs.n	c0d028e6 <ui_idle+0x102>
c0d028a4:	f7ff fe86 	bl	c0d025b4 <io_seproxyhal_spi_is_status_sent>
c0d028a8:	2800      	cmp	r0, #0
c0d028aa:	d11c      	bne.n	c0d028e6 <ui_idle+0x102>
c0d028ac:	68a0      	ldr	r0, [r4, #8]
c0d028ae:	68e1      	ldr	r1, [r4, #12]
c0d028b0:	2538      	movs	r5, #56	; 0x38
c0d028b2:	4368      	muls	r0, r5
c0d028b4:	6822      	ldr	r2, [r4, #0]
c0d028b6:	1810      	adds	r0, r2, r0
c0d028b8:	2900      	cmp	r1, #0
c0d028ba:	d009      	beq.n	c0d028d0 <ui_idle+0xec>
c0d028bc:	4788      	blx	r1
c0d028be:	2800      	cmp	r0, #0
c0d028c0:	d106      	bne.n	c0d028d0 <ui_idle+0xec>
c0d028c2:	68a0      	ldr	r0, [r4, #8]
c0d028c4:	1c45      	adds	r5, r0, #1
c0d028c6:	60a5      	str	r5, [r4, #8]
c0d028c8:	6820      	ldr	r0, [r4, #0]
c0d028ca:	2800      	cmp	r0, #0
c0d028cc:	d1e7      	bne.n	c0d0289e <ui_idle+0xba>
c0d028ce:	e00a      	b.n	c0d028e6 <ui_idle+0x102>
c0d028d0:	2801      	cmp	r0, #1
c0d028d2:	d103      	bne.n	c0d028dc <ui_idle+0xf8>
c0d028d4:	68a0      	ldr	r0, [r4, #8]
c0d028d6:	4345      	muls	r5, r0
c0d028d8:	6820      	ldr	r0, [r4, #0]
c0d028da:	1940      	adds	r0, r0, r5
c0d028dc:	f7fe fa8e 	bl	c0d00dfc <io_seproxyhal_display>
c0d028e0:	68a0      	ldr	r0, [r4, #8]
c0d028e2:	1c40      	adds	r0, r0, #1
c0d028e4:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d028e6:	bdb0      	pop	{r4, r5, r7, pc}
c0d028e8:	20001a98 	.word	0x20001a98
c0d028ec:	b0105044 	.word	0xb0105044
c0d028f0:	00001782 	.word	0x00001782
c0d028f4:	0000008d 	.word	0x0000008d
c0d028f8:	00001630 	.word	0x00001630
c0d028fc:	fffffe27 	.word	0xfffffe27

c0d02900 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d02900:	2000      	movs	r0, #0
c0d02902:	4770      	bx	lr

c0d02904 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d02904:	b5d0      	push	{r4, r6, r7, lr}
c0d02906:	af02      	add	r7, sp, #8
c0d02908:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d0290a:	4620      	mov	r0, r4
c0d0290c:	f7ff fddc 	bl	c0d024c8 <os_sched_exit>
    return NULL;
c0d02910:	4620      	mov	r0, r4
c0d02912:	bdd0      	pop	{r4, r6, r7, pc}

c0d02914 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02914:	4902      	ldr	r1, [pc, #8]	; (c0d02920 <USBD_LL_Init+0xc>)
c0d02916:	2000      	movs	r0, #0
c0d02918:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d0291a:	4902      	ldr	r1, [pc, #8]	; (c0d02924 <USBD_LL_Init+0x10>)
c0d0291c:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d0291e:	4770      	bx	lr
c0d02920:	20001d2c 	.word	0x20001d2c
c0d02924:	20001d30 	.word	0x20001d30

c0d02928 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02928:	b5d0      	push	{r4, r6, r7, lr}
c0d0292a:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0292c:	4806      	ldr	r0, [pc, #24]	; (c0d02948 <USBD_LL_DeInit+0x20>)
c0d0292e:	214f      	movs	r1, #79	; 0x4f
c0d02930:	7001      	strb	r1, [r0, #0]
c0d02932:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02934:	7044      	strb	r4, [r0, #1]
c0d02936:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02938:	7081      	strb	r1, [r0, #2]
c0d0293a:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d0293c:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0293e:	2104      	movs	r1, #4
c0d02940:	f7ff fe1a 	bl	c0d02578 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02944:	4620      	mov	r0, r4
c0d02946:	bdd0      	pop	{r4, r6, r7, pc}
c0d02948:	20001a18 	.word	0x20001a18

c0d0294c <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d0294c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0294e:	af03      	add	r7, sp, #12
c0d02950:	b083      	sub	sp, #12
c0d02952:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02954:	264f      	movs	r6, #79	; 0x4f
c0d02956:	702e      	strb	r6, [r5, #0]
c0d02958:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0295a:	706c      	strb	r4, [r5, #1]
c0d0295c:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d0295e:	70a8      	strb	r0, [r5, #2]
c0d02960:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02962:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d02964:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02966:	2105      	movs	r1, #5
c0d02968:	4628      	mov	r0, r5
c0d0296a:	f7ff fe05 	bl	c0d02578 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0296e:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d02970:	706c      	strb	r4, [r5, #1]
c0d02972:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d02974:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d02976:	70e8      	strb	r0, [r5, #3]
c0d02978:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d0297a:	4628      	mov	r0, r5
c0d0297c:	f7ff fdfc 	bl	c0d02578 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02980:	4620      	mov	r0, r4
c0d02982:	b003      	add	sp, #12
c0d02984:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02986 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d02986:	b5d0      	push	{r4, r6, r7, lr}
c0d02988:	af02      	add	r7, sp, #8
c0d0298a:	b082      	sub	sp, #8
c0d0298c:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0298e:	214f      	movs	r1, #79	; 0x4f
c0d02990:	7001      	strb	r1, [r0, #0]
c0d02992:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02994:	7044      	strb	r4, [r0, #1]
c0d02996:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d02998:	7081      	strb	r1, [r0, #2]
c0d0299a:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d0299c:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d0299e:	2104      	movs	r1, #4
c0d029a0:	f7ff fdea 	bl	c0d02578 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d029a4:	4620      	mov	r0, r4
c0d029a6:	b002      	add	sp, #8
c0d029a8:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d029ac <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d029ac:	b5b0      	push	{r4, r5, r7, lr}
c0d029ae:	af02      	add	r7, sp, #8
c0d029b0:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d029b2:	480f      	ldr	r0, [pc, #60]	; (c0d029f0 <USBD_LL_OpenEP+0x44>)
c0d029b4:	2400      	movs	r4, #0
c0d029b6:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d029b8:	480e      	ldr	r0, [pc, #56]	; (c0d029f4 <USBD_LL_OpenEP+0x48>)
c0d029ba:	6004      	str	r4, [r0, #0]
c0d029bc:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d029be:	254f      	movs	r5, #79	; 0x4f
c0d029c0:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d029c2:	7044      	strb	r4, [r0, #1]
c0d029c4:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d029c6:	7085      	strb	r5, [r0, #2]
c0d029c8:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d029ca:	70c5      	strb	r5, [r0, #3]
c0d029cc:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d029ce:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d029d0:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d029d2:	2a03      	cmp	r2, #3
c0d029d4:	d802      	bhi.n	c0d029dc <USBD_LL_OpenEP+0x30>
c0d029d6:	00d0      	lsls	r0, r2, #3
c0d029d8:	4c07      	ldr	r4, [pc, #28]	; (c0d029f8 <USBD_LL_OpenEP+0x4c>)
c0d029da:	40c4      	lsrs	r4, r0
c0d029dc:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d029de:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d029e0:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d029e2:	2108      	movs	r1, #8
c0d029e4:	f7ff fdc8 	bl	c0d02578 <io_seproxyhal_spi_send>
c0d029e8:	2000      	movs	r0, #0
  return USBD_OK; 
c0d029ea:	b002      	add	sp, #8
c0d029ec:	bdb0      	pop	{r4, r5, r7, pc}
c0d029ee:	46c0      	nop			; (mov r8, r8)
c0d029f0:	20001d2c 	.word	0x20001d2c
c0d029f4:	20001d30 	.word	0x20001d30
c0d029f8:	02030401 	.word	0x02030401

c0d029fc <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d029fc:	b5d0      	push	{r4, r6, r7, lr}
c0d029fe:	af02      	add	r7, sp, #8
c0d02a00:	b082      	sub	sp, #8
c0d02a02:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02a04:	224f      	movs	r2, #79	; 0x4f
c0d02a06:	7002      	strb	r2, [r0, #0]
c0d02a08:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02a0a:	7044      	strb	r4, [r0, #1]
c0d02a0c:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d02a0e:	7082      	strb	r2, [r0, #2]
c0d02a10:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02a12:	70c2      	strb	r2, [r0, #3]
c0d02a14:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d02a16:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02a18:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02a1a:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02a1c:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02a1e:	2108      	movs	r1, #8
c0d02a20:	f7ff fdaa 	bl	c0d02578 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02a24:	4620      	mov	r0, r4
c0d02a26:	b002      	add	sp, #8
c0d02a28:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02a2c <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02a2c:	b5b0      	push	{r4, r5, r7, lr}
c0d02a2e:	af02      	add	r7, sp, #8
c0d02a30:	b082      	sub	sp, #8
c0d02a32:	460d      	mov	r5, r1
c0d02a34:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02a36:	2150      	movs	r1, #80	; 0x50
c0d02a38:	7001      	strb	r1, [r0, #0]
c0d02a3a:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02a3c:	7044      	strb	r4, [r0, #1]
c0d02a3e:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02a40:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02a42:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02a44:	2140      	movs	r1, #64	; 0x40
c0d02a46:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02a48:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02a4a:	2106      	movs	r1, #6
c0d02a4c:	f7ff fd94 	bl	c0d02578 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02a50:	2080      	movs	r0, #128	; 0x80
c0d02a52:	4205      	tst	r5, r0
c0d02a54:	d101      	bne.n	c0d02a5a <USBD_LL_StallEP+0x2e>
c0d02a56:	4807      	ldr	r0, [pc, #28]	; (c0d02a74 <USBD_LL_StallEP+0x48>)
c0d02a58:	e000      	b.n	c0d02a5c <USBD_LL_StallEP+0x30>
c0d02a5a:	4805      	ldr	r0, [pc, #20]	; (c0d02a70 <USBD_LL_StallEP+0x44>)
c0d02a5c:	6801      	ldr	r1, [r0, #0]
c0d02a5e:	227f      	movs	r2, #127	; 0x7f
c0d02a60:	4015      	ands	r5, r2
c0d02a62:	2201      	movs	r2, #1
c0d02a64:	40aa      	lsls	r2, r5
c0d02a66:	430a      	orrs	r2, r1
c0d02a68:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02a6a:	4620      	mov	r0, r4
c0d02a6c:	b002      	add	sp, #8
c0d02a6e:	bdb0      	pop	{r4, r5, r7, pc}
c0d02a70:	20001d2c 	.word	0x20001d2c
c0d02a74:	20001d30 	.word	0x20001d30

c0d02a78 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02a78:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a7a:	af03      	add	r7, sp, #12
c0d02a7c:	b083      	sub	sp, #12
c0d02a7e:	460d      	mov	r5, r1
c0d02a80:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02a82:	2150      	movs	r1, #80	; 0x50
c0d02a84:	7001      	strb	r1, [r0, #0]
c0d02a86:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02a88:	7044      	strb	r4, [r0, #1]
c0d02a8a:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02a8c:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02a8e:	70c5      	strb	r5, [r0, #3]
c0d02a90:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d02a92:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d02a94:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02a96:	2106      	movs	r1, #6
c0d02a98:	f7ff fd6e 	bl	c0d02578 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02a9c:	4235      	tst	r5, r6
c0d02a9e:	d101      	bne.n	c0d02aa4 <USBD_LL_ClearStallEP+0x2c>
c0d02aa0:	4807      	ldr	r0, [pc, #28]	; (c0d02ac0 <USBD_LL_ClearStallEP+0x48>)
c0d02aa2:	e000      	b.n	c0d02aa6 <USBD_LL_ClearStallEP+0x2e>
c0d02aa4:	4805      	ldr	r0, [pc, #20]	; (c0d02abc <USBD_LL_ClearStallEP+0x44>)
c0d02aa6:	6801      	ldr	r1, [r0, #0]
c0d02aa8:	227f      	movs	r2, #127	; 0x7f
c0d02aaa:	4015      	ands	r5, r2
c0d02aac:	2201      	movs	r2, #1
c0d02aae:	40aa      	lsls	r2, r5
c0d02ab0:	4391      	bics	r1, r2
c0d02ab2:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02ab4:	4620      	mov	r0, r4
c0d02ab6:	b003      	add	sp, #12
c0d02ab8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02aba:	46c0      	nop			; (mov r8, r8)
c0d02abc:	20001d2c 	.word	0x20001d2c
c0d02ac0:	20001d30 	.word	0x20001d30

c0d02ac4 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d02ac4:	2080      	movs	r0, #128	; 0x80
c0d02ac6:	4201      	tst	r1, r0
c0d02ac8:	d001      	beq.n	c0d02ace <USBD_LL_IsStallEP+0xa>
c0d02aca:	4806      	ldr	r0, [pc, #24]	; (c0d02ae4 <USBD_LL_IsStallEP+0x20>)
c0d02acc:	e000      	b.n	c0d02ad0 <USBD_LL_IsStallEP+0xc>
c0d02ace:	4804      	ldr	r0, [pc, #16]	; (c0d02ae0 <USBD_LL_IsStallEP+0x1c>)
c0d02ad0:	6800      	ldr	r0, [r0, #0]
c0d02ad2:	227f      	movs	r2, #127	; 0x7f
c0d02ad4:	4011      	ands	r1, r2
c0d02ad6:	2201      	movs	r2, #1
c0d02ad8:	408a      	lsls	r2, r1
c0d02ada:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d02adc:	b2d0      	uxtb	r0, r2
c0d02ade:	4770      	bx	lr
c0d02ae0:	20001d30 	.word	0x20001d30
c0d02ae4:	20001d2c 	.word	0x20001d2c

c0d02ae8 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02ae8:	b5d0      	push	{r4, r6, r7, lr}
c0d02aea:	af02      	add	r7, sp, #8
c0d02aec:	b082      	sub	sp, #8
c0d02aee:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02af0:	224f      	movs	r2, #79	; 0x4f
c0d02af2:	7002      	strb	r2, [r0, #0]
c0d02af4:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02af6:	7044      	strb	r4, [r0, #1]
c0d02af8:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d02afa:	7082      	strb	r2, [r0, #2]
c0d02afc:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02afe:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02b00:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02b02:	2105      	movs	r1, #5
c0d02b04:	f7ff fd38 	bl	c0d02578 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02b08:	4620      	mov	r0, r4
c0d02b0a:	b002      	add	sp, #8
c0d02b0c:	bdd0      	pop	{r4, r6, r7, pc}

c0d02b0e <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d02b0e:	b5b0      	push	{r4, r5, r7, lr}
c0d02b10:	af02      	add	r7, sp, #8
c0d02b12:	b082      	sub	sp, #8
c0d02b14:	461c      	mov	r4, r3
c0d02b16:	4615      	mov	r5, r2
c0d02b18:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02b1a:	2250      	movs	r2, #80	; 0x50
c0d02b1c:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d02b1e:	1ce2      	adds	r2, r4, #3
c0d02b20:	0a13      	lsrs	r3, r2, #8
c0d02b22:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d02b24:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d02b26:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02b28:	2120      	movs	r1, #32
c0d02b2a:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02b2c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02b2e:	2106      	movs	r1, #6
c0d02b30:	f7ff fd22 	bl	c0d02578 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02b34:	4628      	mov	r0, r5
c0d02b36:	4621      	mov	r1, r4
c0d02b38:	f7ff fd1e 	bl	c0d02578 <io_seproxyhal_spi_send>
c0d02b3c:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02b3e:	b002      	add	sp, #8
c0d02b40:	bdb0      	pop	{r4, r5, r7, pc}

c0d02b42 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02b42:	b5d0      	push	{r4, r6, r7, lr}
c0d02b44:	af02      	add	r7, sp, #8
c0d02b46:	b082      	sub	sp, #8
c0d02b48:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02b4a:	2350      	movs	r3, #80	; 0x50
c0d02b4c:	7003      	strb	r3, [r0, #0]
c0d02b4e:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02b50:	7044      	strb	r4, [r0, #1]
c0d02b52:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02b54:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d02b56:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02b58:	2130      	movs	r1, #48	; 0x30
c0d02b5a:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02b5c:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02b5e:	2106      	movs	r1, #6
c0d02b60:	f7ff fd0a 	bl	c0d02578 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d02b64:	4620      	mov	r0, r4
c0d02b66:	b002      	add	sp, #8
c0d02b68:	bdd0      	pop	{r4, r6, r7, pc}

c0d02b6a <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02b6a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b6c:	af03      	add	r7, sp, #12
c0d02b6e:	b081      	sub	sp, #4
c0d02b70:	4615      	mov	r5, r2
c0d02b72:	460e      	mov	r6, r1
c0d02b74:	4604      	mov	r4, r0
c0d02b76:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d02b78:	2c00      	cmp	r4, #0
c0d02b7a:	d011      	beq.n	c0d02ba0 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02b7c:	2049      	movs	r0, #73	; 0x49
c0d02b7e:	0081      	lsls	r1, r0, #2
c0d02b80:	4620      	mov	r0, r4
c0d02b82:	f001 f803 	bl	c0d03b8c <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d02b86:	2e00      	cmp	r6, #0
c0d02b88:	d002      	beq.n	c0d02b90 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d02b8a:	2011      	movs	r0, #17
c0d02b8c:	0100      	lsls	r0, r0, #4
c0d02b8e:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02b90:	20fc      	movs	r0, #252	; 0xfc
c0d02b92:	2101      	movs	r1, #1
c0d02b94:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d02b96:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d02b98:	4620      	mov	r0, r4
c0d02b9a:	f7ff febb 	bl	c0d02914 <USBD_LL_Init>
c0d02b9e:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d02ba0:	b2c0      	uxtb	r0, r0
c0d02ba2:	b001      	add	sp, #4
c0d02ba4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02ba6 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d02ba6:	b5d0      	push	{r4, r6, r7, lr}
c0d02ba8:	af02      	add	r7, sp, #8
c0d02baa:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02bac:	20fc      	movs	r0, #252	; 0xfc
c0d02bae:	2101      	movs	r1, #1
c0d02bb0:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d02bb2:	2045      	movs	r0, #69	; 0x45
c0d02bb4:	0080      	lsls	r0, r0, #2
c0d02bb6:	5820      	ldr	r0, [r4, r0]
c0d02bb8:	2800      	cmp	r0, #0
c0d02bba:	d006      	beq.n	c0d02bca <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02bbc:	6840      	ldr	r0, [r0, #4]
c0d02bbe:	f7ff fb1f 	bl	c0d02200 <pic>
c0d02bc2:	4602      	mov	r2, r0
c0d02bc4:	7921      	ldrb	r1, [r4, #4]
c0d02bc6:	4620      	mov	r0, r4
c0d02bc8:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d02bca:	4620      	mov	r0, r4
c0d02bcc:	f7ff fedb 	bl	c0d02986 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02bd0:	4620      	mov	r0, r4
c0d02bd2:	f7ff fea9 	bl	c0d02928 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d02bd6:	2000      	movs	r0, #0
c0d02bd8:	bdd0      	pop	{r4, r6, r7, pc}

c0d02bda <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d02bda:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d02bdc:	2900      	cmp	r1, #0
c0d02bde:	d003      	beq.n	c0d02be8 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02be0:	2245      	movs	r2, #69	; 0x45
c0d02be2:	0092      	lsls	r2, r2, #2
c0d02be4:	5081      	str	r1, [r0, r2]
c0d02be6:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02be8:	b2d0      	uxtb	r0, r2
c0d02bea:	4770      	bx	lr

c0d02bec <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02bec:	b580      	push	{r7, lr}
c0d02bee:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02bf0:	f7ff feac 	bl	c0d0294c <USBD_LL_Start>
  
  return USBD_OK;  
c0d02bf4:	2000      	movs	r0, #0
c0d02bf6:	bd80      	pop	{r7, pc}

c0d02bf8 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02bf8:	b5b0      	push	{r4, r5, r7, lr}
c0d02bfa:	af02      	add	r7, sp, #8
c0d02bfc:	460c      	mov	r4, r1
c0d02bfe:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02c00:	2045      	movs	r0, #69	; 0x45
c0d02c02:	0080      	lsls	r0, r0, #2
c0d02c04:	5828      	ldr	r0, [r5, r0]
c0d02c06:	2800      	cmp	r0, #0
c0d02c08:	d00c      	beq.n	c0d02c24 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d02c0a:	6800      	ldr	r0, [r0, #0]
c0d02c0c:	f7ff faf8 	bl	c0d02200 <pic>
c0d02c10:	4602      	mov	r2, r0
c0d02c12:	4628      	mov	r0, r5
c0d02c14:	4621      	mov	r1, r4
c0d02c16:	4790      	blx	r2
c0d02c18:	4601      	mov	r1, r0
c0d02c1a:	2002      	movs	r0, #2
c0d02c1c:	2900      	cmp	r1, #0
c0d02c1e:	d100      	bne.n	c0d02c22 <USBD_SetClassConfig+0x2a>
c0d02c20:	4608      	mov	r0, r1
c0d02c22:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02c24:	2002      	movs	r0, #2
c0d02c26:	bdb0      	pop	{r4, r5, r7, pc}

c0d02c28 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02c28:	b5b0      	push	{r4, r5, r7, lr}
c0d02c2a:	af02      	add	r7, sp, #8
c0d02c2c:	460c      	mov	r4, r1
c0d02c2e:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02c30:	2045      	movs	r0, #69	; 0x45
c0d02c32:	0080      	lsls	r0, r0, #2
c0d02c34:	5828      	ldr	r0, [r5, r0]
c0d02c36:	2800      	cmp	r0, #0
c0d02c38:	d006      	beq.n	c0d02c48 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02c3a:	6840      	ldr	r0, [r0, #4]
c0d02c3c:	f7ff fae0 	bl	c0d02200 <pic>
c0d02c40:	4602      	mov	r2, r0
c0d02c42:	4628      	mov	r0, r5
c0d02c44:	4621      	mov	r1, r4
c0d02c46:	4790      	blx	r2
  }
  return USBD_OK;
c0d02c48:	2000      	movs	r0, #0
c0d02c4a:	bdb0      	pop	{r4, r5, r7, pc}

c0d02c4c <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02c4c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c4e:	af03      	add	r7, sp, #12
c0d02c50:	b081      	sub	sp, #4
c0d02c52:	4604      	mov	r4, r0
c0d02c54:	2021      	movs	r0, #33	; 0x21
c0d02c56:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02c58:	19a5      	adds	r5, r4, r6
c0d02c5a:	4628      	mov	r0, r5
c0d02c5c:	f000 fb69 	bl	c0d03332 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02c60:	20f4      	movs	r0, #244	; 0xf4
c0d02c62:	2101      	movs	r1, #1
c0d02c64:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d02c66:	2087      	movs	r0, #135	; 0x87
c0d02c68:	0040      	lsls	r0, r0, #1
c0d02c6a:	5a20      	ldrh	r0, [r4, r0]
c0d02c6c:	21f8      	movs	r1, #248	; 0xf8
c0d02c6e:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02c70:	5da1      	ldrb	r1, [r4, r6]
c0d02c72:	201f      	movs	r0, #31
c0d02c74:	4008      	ands	r0, r1
c0d02c76:	2802      	cmp	r0, #2
c0d02c78:	d008      	beq.n	c0d02c8c <USBD_LL_SetupStage+0x40>
c0d02c7a:	2801      	cmp	r0, #1
c0d02c7c:	d00b      	beq.n	c0d02c96 <USBD_LL_SetupStage+0x4a>
c0d02c7e:	2800      	cmp	r0, #0
c0d02c80:	d10e      	bne.n	c0d02ca0 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d02c82:	4620      	mov	r0, r4
c0d02c84:	4629      	mov	r1, r5
c0d02c86:	f000 f8f1 	bl	c0d02e6c <USBD_StdDevReq>
c0d02c8a:	e00e      	b.n	c0d02caa <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02c8c:	4620      	mov	r0, r4
c0d02c8e:	4629      	mov	r1, r5
c0d02c90:	f000 fad3 	bl	c0d0323a <USBD_StdEPReq>
c0d02c94:	e009      	b.n	c0d02caa <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d02c96:	4620      	mov	r0, r4
c0d02c98:	4629      	mov	r1, r5
c0d02c9a:	f000 faa6 	bl	c0d031ea <USBD_StdItfReq>
c0d02c9e:	e004      	b.n	c0d02caa <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d02ca0:	2080      	movs	r0, #128	; 0x80
c0d02ca2:	4001      	ands	r1, r0
c0d02ca4:	4620      	mov	r0, r4
c0d02ca6:	f7ff fec1 	bl	c0d02a2c <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d02caa:	2000      	movs	r0, #0
c0d02cac:	b001      	add	sp, #4
c0d02cae:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02cb0 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d02cb0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02cb2:	af03      	add	r7, sp, #12
c0d02cb4:	b081      	sub	sp, #4
c0d02cb6:	4615      	mov	r5, r2
c0d02cb8:	460e      	mov	r6, r1
c0d02cba:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02cbc:	2e00      	cmp	r6, #0
c0d02cbe:	d011      	beq.n	c0d02ce4 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02cc0:	2045      	movs	r0, #69	; 0x45
c0d02cc2:	0080      	lsls	r0, r0, #2
c0d02cc4:	5820      	ldr	r0, [r4, r0]
c0d02cc6:	6980      	ldr	r0, [r0, #24]
c0d02cc8:	2800      	cmp	r0, #0
c0d02cca:	d034      	beq.n	c0d02d36 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02ccc:	21fc      	movs	r1, #252	; 0xfc
c0d02cce:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02cd0:	2903      	cmp	r1, #3
c0d02cd2:	d130      	bne.n	c0d02d36 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02cd4:	f7ff fa94 	bl	c0d02200 <pic>
c0d02cd8:	4603      	mov	r3, r0
c0d02cda:	4620      	mov	r0, r4
c0d02cdc:	4631      	mov	r1, r6
c0d02cde:	462a      	mov	r2, r5
c0d02ce0:	4798      	blx	r3
c0d02ce2:	e028      	b.n	c0d02d36 <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02ce4:	20f4      	movs	r0, #244	; 0xf4
c0d02ce6:	5820      	ldr	r0, [r4, r0]
c0d02ce8:	2803      	cmp	r0, #3
c0d02cea:	d124      	bne.n	c0d02d36 <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02cec:	2090      	movs	r0, #144	; 0x90
c0d02cee:	5820      	ldr	r0, [r4, r0]
c0d02cf0:	218c      	movs	r1, #140	; 0x8c
c0d02cf2:	5861      	ldr	r1, [r4, r1]
c0d02cf4:	4622      	mov	r2, r4
c0d02cf6:	328c      	adds	r2, #140	; 0x8c
c0d02cf8:	4281      	cmp	r1, r0
c0d02cfa:	d90a      	bls.n	c0d02d12 <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02cfc:	1a09      	subs	r1, r1, r0
c0d02cfe:	6011      	str	r1, [r2, #0]
c0d02d00:	4281      	cmp	r1, r0
c0d02d02:	d300      	bcc.n	c0d02d06 <USBD_LL_DataOutStage+0x56>
c0d02d04:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d02d06:	b28a      	uxth	r2, r1
c0d02d08:	4620      	mov	r0, r4
c0d02d0a:	4629      	mov	r1, r5
c0d02d0c:	f000 fc70 	bl	c0d035f0 <USBD_CtlContinueRx>
c0d02d10:	e011      	b.n	c0d02d36 <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02d12:	2045      	movs	r0, #69	; 0x45
c0d02d14:	0080      	lsls	r0, r0, #2
c0d02d16:	5820      	ldr	r0, [r4, r0]
c0d02d18:	6900      	ldr	r0, [r0, #16]
c0d02d1a:	2800      	cmp	r0, #0
c0d02d1c:	d008      	beq.n	c0d02d30 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02d1e:	21fc      	movs	r1, #252	; 0xfc
c0d02d20:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02d22:	2903      	cmp	r1, #3
c0d02d24:	d104      	bne.n	c0d02d30 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02d26:	f7ff fa6b 	bl	c0d02200 <pic>
c0d02d2a:	4601      	mov	r1, r0
c0d02d2c:	4620      	mov	r0, r4
c0d02d2e:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02d30:	4620      	mov	r0, r4
c0d02d32:	f000 fc65 	bl	c0d03600 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02d36:	2000      	movs	r0, #0
c0d02d38:	b001      	add	sp, #4
c0d02d3a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02d3c <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02d3c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02d3e:	af03      	add	r7, sp, #12
c0d02d40:	b081      	sub	sp, #4
c0d02d42:	460d      	mov	r5, r1
c0d02d44:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02d46:	2d00      	cmp	r5, #0
c0d02d48:	d012      	beq.n	c0d02d70 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02d4a:	2045      	movs	r0, #69	; 0x45
c0d02d4c:	0080      	lsls	r0, r0, #2
c0d02d4e:	5820      	ldr	r0, [r4, r0]
c0d02d50:	2800      	cmp	r0, #0
c0d02d52:	d054      	beq.n	c0d02dfe <USBD_LL_DataInStage+0xc2>
c0d02d54:	6940      	ldr	r0, [r0, #20]
c0d02d56:	2800      	cmp	r0, #0
c0d02d58:	d051      	beq.n	c0d02dfe <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02d5a:	21fc      	movs	r1, #252	; 0xfc
c0d02d5c:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02d5e:	2903      	cmp	r1, #3
c0d02d60:	d14d      	bne.n	c0d02dfe <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d02d62:	f7ff fa4d 	bl	c0d02200 <pic>
c0d02d66:	4602      	mov	r2, r0
c0d02d68:	4620      	mov	r0, r4
c0d02d6a:	4629      	mov	r1, r5
c0d02d6c:	4790      	blx	r2
c0d02d6e:	e046      	b.n	c0d02dfe <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02d70:	20f4      	movs	r0, #244	; 0xf4
c0d02d72:	5820      	ldr	r0, [r4, r0]
c0d02d74:	2802      	cmp	r0, #2
c0d02d76:	d13a      	bne.n	c0d02dee <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02d78:	69e0      	ldr	r0, [r4, #28]
c0d02d7a:	6a25      	ldr	r5, [r4, #32]
c0d02d7c:	42a8      	cmp	r0, r5
c0d02d7e:	d90b      	bls.n	c0d02d98 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02d80:	1b40      	subs	r0, r0, r5
c0d02d82:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d02d84:	2109      	movs	r1, #9
c0d02d86:	014a      	lsls	r2, r1, #5
c0d02d88:	58a1      	ldr	r1, [r4, r2]
c0d02d8a:	1949      	adds	r1, r1, r5
c0d02d8c:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02d8e:	b282      	uxth	r2, r0
c0d02d90:	4620      	mov	r0, r4
c0d02d92:	f000 fc1e 	bl	c0d035d2 <USBD_CtlContinueSendData>
c0d02d96:	e02a      	b.n	c0d02dee <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02d98:	69a6      	ldr	r6, [r4, #24]
c0d02d9a:	4630      	mov	r0, r6
c0d02d9c:	4629      	mov	r1, r5
c0d02d9e:	f000 fccf 	bl	c0d03740 <__aeabi_uidivmod>
c0d02da2:	42ae      	cmp	r6, r5
c0d02da4:	d30f      	bcc.n	c0d02dc6 <USBD_LL_DataInStage+0x8a>
c0d02da6:	2900      	cmp	r1, #0
c0d02da8:	d10d      	bne.n	c0d02dc6 <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02daa:	20f8      	movs	r0, #248	; 0xf8
c0d02dac:	5820      	ldr	r0, [r4, r0]
c0d02dae:	4625      	mov	r5, r4
c0d02db0:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02db2:	4286      	cmp	r6, r0
c0d02db4:	d207      	bcs.n	c0d02dc6 <USBD_LL_DataInStage+0x8a>
c0d02db6:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02db8:	4620      	mov	r0, r4
c0d02dba:	4631      	mov	r1, r6
c0d02dbc:	4632      	mov	r2, r6
c0d02dbe:	f000 fc08 	bl	c0d035d2 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02dc2:	602e      	str	r6, [r5, #0]
c0d02dc4:	e013      	b.n	c0d02dee <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02dc6:	2045      	movs	r0, #69	; 0x45
c0d02dc8:	0080      	lsls	r0, r0, #2
c0d02dca:	5820      	ldr	r0, [r4, r0]
c0d02dcc:	2800      	cmp	r0, #0
c0d02dce:	d00b      	beq.n	c0d02de8 <USBD_LL_DataInStage+0xac>
c0d02dd0:	68c0      	ldr	r0, [r0, #12]
c0d02dd2:	2800      	cmp	r0, #0
c0d02dd4:	d008      	beq.n	c0d02de8 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02dd6:	21fc      	movs	r1, #252	; 0xfc
c0d02dd8:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02dda:	2903      	cmp	r1, #3
c0d02ddc:	d104      	bne.n	c0d02de8 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02dde:	f7ff fa0f 	bl	c0d02200 <pic>
c0d02de2:	4601      	mov	r1, r0
c0d02de4:	4620      	mov	r0, r4
c0d02de6:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02de8:	4620      	mov	r0, r4
c0d02dea:	f000 fc16 	bl	c0d0361a <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02dee:	2001      	movs	r0, #1
c0d02df0:	0201      	lsls	r1, r0, #8
c0d02df2:	1860      	adds	r0, r4, r1
c0d02df4:	5c61      	ldrb	r1, [r4, r1]
c0d02df6:	2901      	cmp	r1, #1
c0d02df8:	d101      	bne.n	c0d02dfe <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02dfa:	2100      	movs	r1, #0
c0d02dfc:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02dfe:	2000      	movs	r0, #0
c0d02e00:	b001      	add	sp, #4
c0d02e02:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02e04 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02e04:	b5d0      	push	{r4, r6, r7, lr}
c0d02e06:	af02      	add	r7, sp, #8
c0d02e08:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02e0a:	2090      	movs	r0, #144	; 0x90
c0d02e0c:	2140      	movs	r1, #64	; 0x40
c0d02e0e:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02e10:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02e12:	20fc      	movs	r0, #252	; 0xfc
c0d02e14:	2101      	movs	r1, #1
c0d02e16:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02e18:	2045      	movs	r0, #69	; 0x45
c0d02e1a:	0080      	lsls	r0, r0, #2
c0d02e1c:	5820      	ldr	r0, [r4, r0]
c0d02e1e:	2800      	cmp	r0, #0
c0d02e20:	d006      	beq.n	c0d02e30 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02e22:	6840      	ldr	r0, [r0, #4]
c0d02e24:	f7ff f9ec 	bl	c0d02200 <pic>
c0d02e28:	4602      	mov	r2, r0
c0d02e2a:	7921      	ldrb	r1, [r4, #4]
c0d02e2c:	4620      	mov	r0, r4
c0d02e2e:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02e30:	2000      	movs	r0, #0
c0d02e32:	bdd0      	pop	{r4, r6, r7, pc}

c0d02e34 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02e34:	7401      	strb	r1, [r0, #16]
c0d02e36:	2000      	movs	r0, #0
  return USBD_OK;
c0d02e38:	4770      	bx	lr

c0d02e3a <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02e3a:	2000      	movs	r0, #0
c0d02e3c:	4770      	bx	lr

c0d02e3e <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02e3e:	2000      	movs	r0, #0
c0d02e40:	4770      	bx	lr

c0d02e42 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02e42:	b5d0      	push	{r4, r6, r7, lr}
c0d02e44:	af02      	add	r7, sp, #8
c0d02e46:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02e48:	20fc      	movs	r0, #252	; 0xfc
c0d02e4a:	5c20      	ldrb	r0, [r4, r0]
c0d02e4c:	2803      	cmp	r0, #3
c0d02e4e:	d10a      	bne.n	c0d02e66 <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02e50:	2045      	movs	r0, #69	; 0x45
c0d02e52:	0080      	lsls	r0, r0, #2
c0d02e54:	5820      	ldr	r0, [r4, r0]
c0d02e56:	69c0      	ldr	r0, [r0, #28]
c0d02e58:	2800      	cmp	r0, #0
c0d02e5a:	d004      	beq.n	c0d02e66 <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02e5c:	f7ff f9d0 	bl	c0d02200 <pic>
c0d02e60:	4601      	mov	r1, r0
c0d02e62:	4620      	mov	r0, r4
c0d02e64:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d02e66:	2000      	movs	r0, #0
c0d02e68:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02e6c <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02e6c:	b5d0      	push	{r4, r6, r7, lr}
c0d02e6e:	af02      	add	r7, sp, #8
c0d02e70:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02e72:	7848      	ldrb	r0, [r1, #1]
c0d02e74:	2809      	cmp	r0, #9
c0d02e76:	d810      	bhi.n	c0d02e9a <USBD_StdDevReq+0x2e>
c0d02e78:	4478      	add	r0, pc
c0d02e7a:	7900      	ldrb	r0, [r0, #4]
c0d02e7c:	0040      	lsls	r0, r0, #1
c0d02e7e:	4487      	add	pc, r0
c0d02e80:	150c0804 	.word	0x150c0804
c0d02e84:	0c25190c 	.word	0x0c25190c
c0d02e88:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02e8a:	4620      	mov	r0, r4
c0d02e8c:	f000 f938 	bl	c0d03100 <USBD_GetStatus>
c0d02e90:	e01f      	b.n	c0d02ed2 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02e92:	4620      	mov	r0, r4
c0d02e94:	f000 f976 	bl	c0d03184 <USBD_ClrFeature>
c0d02e98:	e01b      	b.n	c0d02ed2 <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e9a:	2180      	movs	r1, #128	; 0x80
c0d02e9c:	4620      	mov	r0, r4
c0d02e9e:	f7ff fdc5 	bl	c0d02a2c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02ea2:	2100      	movs	r1, #0
c0d02ea4:	4620      	mov	r0, r4
c0d02ea6:	f7ff fdc1 	bl	c0d02a2c <USBD_LL_StallEP>
c0d02eaa:	e012      	b.n	c0d02ed2 <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02eac:	4620      	mov	r0, r4
c0d02eae:	f000 f950 	bl	c0d03152 <USBD_SetFeature>
c0d02eb2:	e00e      	b.n	c0d02ed2 <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02eb4:	4620      	mov	r0, r4
c0d02eb6:	f000 f897 	bl	c0d02fe8 <USBD_SetAddress>
c0d02eba:	e00a      	b.n	c0d02ed2 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02ebc:	4620      	mov	r0, r4
c0d02ebe:	f000 f8ff 	bl	c0d030c0 <USBD_GetConfig>
c0d02ec2:	e006      	b.n	c0d02ed2 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02ec4:	4620      	mov	r0, r4
c0d02ec6:	f000 f8bd 	bl	c0d03044 <USBD_SetConfig>
c0d02eca:	e002      	b.n	c0d02ed2 <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02ecc:	4620      	mov	r0, r4
c0d02ece:	f000 f803 	bl	c0d02ed8 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02ed2:	2000      	movs	r0, #0
c0d02ed4:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02ed8 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02ed8:	b5b0      	push	{r4, r5, r7, lr}
c0d02eda:	af02      	add	r7, sp, #8
c0d02edc:	b082      	sub	sp, #8
c0d02ede:	460d      	mov	r5, r1
c0d02ee0:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02ee2:	8868      	ldrh	r0, [r5, #2]
c0d02ee4:	0a01      	lsrs	r1, r0, #8
c0d02ee6:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02ee8:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02eea:	2a0e      	cmp	r2, #14
c0d02eec:	d83e      	bhi.n	c0d02f6c <USBD_GetDescriptor+0x94>
c0d02eee:	46c0      	nop			; (mov r8, r8)
c0d02ef0:	447a      	add	r2, pc
c0d02ef2:	7912      	ldrb	r2, [r2, #4]
c0d02ef4:	0052      	lsls	r2, r2, #1
c0d02ef6:	4497      	add	pc, r2
c0d02ef8:	390c2607 	.word	0x390c2607
c0d02efc:	39362e39 	.word	0x39362e39
c0d02f00:	39393939 	.word	0x39393939
c0d02f04:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02f08:	2011      	movs	r0, #17
c0d02f0a:	0100      	lsls	r0, r0, #4
c0d02f0c:	5820      	ldr	r0, [r4, r0]
c0d02f0e:	6800      	ldr	r0, [r0, #0]
c0d02f10:	e012      	b.n	c0d02f38 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02f12:	b2c0      	uxtb	r0, r0
c0d02f14:	2805      	cmp	r0, #5
c0d02f16:	d829      	bhi.n	c0d02f6c <USBD_GetDescriptor+0x94>
c0d02f18:	4478      	add	r0, pc
c0d02f1a:	7900      	ldrb	r0, [r0, #4]
c0d02f1c:	0040      	lsls	r0, r0, #1
c0d02f1e:	4487      	add	pc, r0
c0d02f20:	544f4a02 	.word	0x544f4a02
c0d02f24:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02f26:	2011      	movs	r0, #17
c0d02f28:	0100      	lsls	r0, r0, #4
c0d02f2a:	5820      	ldr	r0, [r4, r0]
c0d02f2c:	6840      	ldr	r0, [r0, #4]
c0d02f2e:	e003      	b.n	c0d02f38 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02f30:	2011      	movs	r0, #17
c0d02f32:	0100      	lsls	r0, r0, #4
c0d02f34:	5820      	ldr	r0, [r4, r0]
c0d02f36:	69c0      	ldr	r0, [r0, #28]
c0d02f38:	f7ff f962 	bl	c0d02200 <pic>
c0d02f3c:	4602      	mov	r2, r0
c0d02f3e:	7c20      	ldrb	r0, [r4, #16]
c0d02f40:	a901      	add	r1, sp, #4
c0d02f42:	4790      	blx	r2
c0d02f44:	e025      	b.n	c0d02f92 <USBD_GetDescriptor+0xba>
c0d02f46:	2045      	movs	r0, #69	; 0x45
c0d02f48:	0080      	lsls	r0, r0, #2
c0d02f4a:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02f4c:	7c21      	ldrb	r1, [r4, #16]
c0d02f4e:	2900      	cmp	r1, #0
c0d02f50:	d014      	beq.n	c0d02f7c <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02f52:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02f54:	e018      	b.n	c0d02f88 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02f56:	7c20      	ldrb	r0, [r4, #16]
c0d02f58:	2800      	cmp	r0, #0
c0d02f5a:	d107      	bne.n	c0d02f6c <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02f5c:	2045      	movs	r0, #69	; 0x45
c0d02f5e:	0080      	lsls	r0, r0, #2
c0d02f60:	5820      	ldr	r0, [r4, r0]
c0d02f62:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02f64:	e010      	b.n	c0d02f88 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02f66:	7c20      	ldrb	r0, [r4, #16]
c0d02f68:	2800      	cmp	r0, #0
c0d02f6a:	d009      	beq.n	c0d02f80 <USBD_GetDescriptor+0xa8>
c0d02f6c:	4620      	mov	r0, r4
c0d02f6e:	f7ff fd5d 	bl	c0d02a2c <USBD_LL_StallEP>
c0d02f72:	2100      	movs	r1, #0
c0d02f74:	4620      	mov	r0, r4
c0d02f76:	f7ff fd59 	bl	c0d02a2c <USBD_LL_StallEP>
c0d02f7a:	e01a      	b.n	c0d02fb2 <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02f7c:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02f7e:	e003      	b.n	c0d02f88 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02f80:	2045      	movs	r0, #69	; 0x45
c0d02f82:	0080      	lsls	r0, r0, #2
c0d02f84:	5820      	ldr	r0, [r4, r0]
c0d02f86:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02f88:	f7ff f93a 	bl	c0d02200 <pic>
c0d02f8c:	4601      	mov	r1, r0
c0d02f8e:	a801      	add	r0, sp, #4
c0d02f90:	4788      	blx	r1
c0d02f92:	4601      	mov	r1, r0
c0d02f94:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02f96:	8802      	ldrh	r2, [r0, #0]
c0d02f98:	2a00      	cmp	r2, #0
c0d02f9a:	d00a      	beq.n	c0d02fb2 <USBD_GetDescriptor+0xda>
c0d02f9c:	88e8      	ldrh	r0, [r5, #6]
c0d02f9e:	2800      	cmp	r0, #0
c0d02fa0:	d007      	beq.n	c0d02fb2 <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02fa2:	4282      	cmp	r2, r0
c0d02fa4:	d300      	bcc.n	c0d02fa8 <USBD_GetDescriptor+0xd0>
c0d02fa6:	4602      	mov	r2, r0
c0d02fa8:	a801      	add	r0, sp, #4
c0d02faa:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02fac:	4620      	mov	r0, r4
c0d02fae:	f000 faf9 	bl	c0d035a4 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02fb2:	b002      	add	sp, #8
c0d02fb4:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02fb6:	2011      	movs	r0, #17
c0d02fb8:	0100      	lsls	r0, r0, #4
c0d02fba:	5820      	ldr	r0, [r4, r0]
c0d02fbc:	6880      	ldr	r0, [r0, #8]
c0d02fbe:	e7bb      	b.n	c0d02f38 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02fc0:	2011      	movs	r0, #17
c0d02fc2:	0100      	lsls	r0, r0, #4
c0d02fc4:	5820      	ldr	r0, [r4, r0]
c0d02fc6:	68c0      	ldr	r0, [r0, #12]
c0d02fc8:	e7b6      	b.n	c0d02f38 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02fca:	2011      	movs	r0, #17
c0d02fcc:	0100      	lsls	r0, r0, #4
c0d02fce:	5820      	ldr	r0, [r4, r0]
c0d02fd0:	6900      	ldr	r0, [r0, #16]
c0d02fd2:	e7b1      	b.n	c0d02f38 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02fd4:	2011      	movs	r0, #17
c0d02fd6:	0100      	lsls	r0, r0, #4
c0d02fd8:	5820      	ldr	r0, [r4, r0]
c0d02fda:	6940      	ldr	r0, [r0, #20]
c0d02fdc:	e7ac      	b.n	c0d02f38 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02fde:	2011      	movs	r0, #17
c0d02fe0:	0100      	lsls	r0, r0, #4
c0d02fe2:	5820      	ldr	r0, [r4, r0]
c0d02fe4:	6980      	ldr	r0, [r0, #24]
c0d02fe6:	e7a7      	b.n	c0d02f38 <USBD_GetDescriptor+0x60>

c0d02fe8 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02fe8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02fea:	af03      	add	r7, sp, #12
c0d02fec:	b081      	sub	sp, #4
c0d02fee:	460a      	mov	r2, r1
c0d02ff0:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02ff2:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02ff4:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02ff6:	2800      	cmp	r0, #0
c0d02ff8:	d10b      	bne.n	c0d03012 <USBD_SetAddress+0x2a>
c0d02ffa:	88d0      	ldrh	r0, [r2, #6]
c0d02ffc:	2800      	cmp	r0, #0
c0d02ffe:	d108      	bne.n	c0d03012 <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d03000:	8850      	ldrh	r0, [r2, #2]
c0d03002:	267f      	movs	r6, #127	; 0x7f
c0d03004:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d03006:	20fc      	movs	r0, #252	; 0xfc
c0d03008:	5c20      	ldrb	r0, [r4, r0]
c0d0300a:	4625      	mov	r5, r4
c0d0300c:	35fc      	adds	r5, #252	; 0xfc
c0d0300e:	2803      	cmp	r0, #3
c0d03010:	d108      	bne.n	c0d03024 <USBD_SetAddress+0x3c>
c0d03012:	4620      	mov	r0, r4
c0d03014:	f7ff fd0a 	bl	c0d02a2c <USBD_LL_StallEP>
c0d03018:	2100      	movs	r1, #0
c0d0301a:	4620      	mov	r0, r4
c0d0301c:	f7ff fd06 	bl	c0d02a2c <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d03020:	b001      	add	sp, #4
c0d03022:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d03024:	20fe      	movs	r0, #254	; 0xfe
c0d03026:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d03028:	b2f1      	uxtb	r1, r6
c0d0302a:	4620      	mov	r0, r4
c0d0302c:	f7ff fd5c 	bl	c0d02ae8 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d03030:	4620      	mov	r0, r4
c0d03032:	f000 fae5 	bl	c0d03600 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d03036:	2002      	movs	r0, #2
c0d03038:	2101      	movs	r1, #1
c0d0303a:	2e00      	cmp	r6, #0
c0d0303c:	d100      	bne.n	c0d03040 <USBD_SetAddress+0x58>
c0d0303e:	4608      	mov	r0, r1
c0d03040:	7028      	strb	r0, [r5, #0]
c0d03042:	e7ed      	b.n	c0d03020 <USBD_SetAddress+0x38>

c0d03044 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d03044:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03046:	af03      	add	r7, sp, #12
c0d03048:	b081      	sub	sp, #4
c0d0304a:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d0304c:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0304e:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d03050:	2e02      	cmp	r6, #2
c0d03052:	d21d      	bcs.n	c0d03090 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d03054:	20fc      	movs	r0, #252	; 0xfc
c0d03056:	5c21      	ldrb	r1, [r4, r0]
c0d03058:	4620      	mov	r0, r4
c0d0305a:	30fc      	adds	r0, #252	; 0xfc
c0d0305c:	2903      	cmp	r1, #3
c0d0305e:	d007      	beq.n	c0d03070 <USBD_SetConfig+0x2c>
c0d03060:	2902      	cmp	r1, #2
c0d03062:	d115      	bne.n	c0d03090 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d03064:	2e00      	cmp	r6, #0
c0d03066:	d026      	beq.n	c0d030b6 <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d03068:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d0306a:	2103      	movs	r1, #3
c0d0306c:	7001      	strb	r1, [r0, #0]
c0d0306e:	e009      	b.n	c0d03084 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d03070:	2e00      	cmp	r6, #0
c0d03072:	d016      	beq.n	c0d030a2 <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d03074:	6860      	ldr	r0, [r4, #4]
c0d03076:	4286      	cmp	r6, r0
c0d03078:	d01d      	beq.n	c0d030b6 <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d0307a:	b2c1      	uxtb	r1, r0
c0d0307c:	4620      	mov	r0, r4
c0d0307e:	f7ff fdd3 	bl	c0d02c28 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d03082:	6066      	str	r6, [r4, #4]
c0d03084:	4620      	mov	r0, r4
c0d03086:	4631      	mov	r1, r6
c0d03088:	f7ff fdb6 	bl	c0d02bf8 <USBD_SetClassConfig>
c0d0308c:	2802      	cmp	r0, #2
c0d0308e:	d112      	bne.n	c0d030b6 <USBD_SetConfig+0x72>
c0d03090:	4620      	mov	r0, r4
c0d03092:	4629      	mov	r1, r5
c0d03094:	f7ff fcca 	bl	c0d02a2c <USBD_LL_StallEP>
c0d03098:	2100      	movs	r1, #0
c0d0309a:	4620      	mov	r0, r4
c0d0309c:	f7ff fcc6 	bl	c0d02a2c <USBD_LL_StallEP>
c0d030a0:	e00c      	b.n	c0d030bc <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d030a2:	2102      	movs	r1, #2
c0d030a4:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d030a6:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d030a8:	4620      	mov	r0, r4
c0d030aa:	4631      	mov	r1, r6
c0d030ac:	f7ff fdbc 	bl	c0d02c28 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d030b0:	4620      	mov	r0, r4
c0d030b2:	f000 faa5 	bl	c0d03600 <USBD_CtlSendStatus>
c0d030b6:	4620      	mov	r0, r4
c0d030b8:	f000 faa2 	bl	c0d03600 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d030bc:	b001      	add	sp, #4
c0d030be:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d030c0 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d030c0:	b5d0      	push	{r4, r6, r7, lr}
c0d030c2:	af02      	add	r7, sp, #8
c0d030c4:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d030c6:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d030c8:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d030ca:	2801      	cmp	r0, #1
c0d030cc:	d10a      	bne.n	c0d030e4 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d030ce:	20fc      	movs	r0, #252	; 0xfc
c0d030d0:	5c20      	ldrb	r0, [r4, r0]
c0d030d2:	2803      	cmp	r0, #3
c0d030d4:	d00e      	beq.n	c0d030f4 <USBD_GetConfig+0x34>
c0d030d6:	2802      	cmp	r0, #2
c0d030d8:	d104      	bne.n	c0d030e4 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d030da:	2000      	movs	r0, #0
c0d030dc:	60a0      	str	r0, [r4, #8]
c0d030de:	4621      	mov	r1, r4
c0d030e0:	3108      	adds	r1, #8
c0d030e2:	e008      	b.n	c0d030f6 <USBD_GetConfig+0x36>
c0d030e4:	4620      	mov	r0, r4
c0d030e6:	f7ff fca1 	bl	c0d02a2c <USBD_LL_StallEP>
c0d030ea:	2100      	movs	r1, #0
c0d030ec:	4620      	mov	r0, r4
c0d030ee:	f7ff fc9d 	bl	c0d02a2c <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d030f2:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d030f4:	1d21      	adds	r1, r4, #4
c0d030f6:	2201      	movs	r2, #1
c0d030f8:	4620      	mov	r0, r4
c0d030fa:	f000 fa53 	bl	c0d035a4 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d030fe:	bdd0      	pop	{r4, r6, r7, pc}

c0d03100 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d03100:	b5b0      	push	{r4, r5, r7, lr}
c0d03102:	af02      	add	r7, sp, #8
c0d03104:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d03106:	20fc      	movs	r0, #252	; 0xfc
c0d03108:	5c20      	ldrb	r0, [r4, r0]
c0d0310a:	21fe      	movs	r1, #254	; 0xfe
c0d0310c:	4001      	ands	r1, r0
c0d0310e:	2902      	cmp	r1, #2
c0d03110:	d116      	bne.n	c0d03140 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d03112:	2001      	movs	r0, #1
c0d03114:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d03116:	2041      	movs	r0, #65	; 0x41
c0d03118:	0080      	lsls	r0, r0, #2
c0d0311a:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d0311c:	4625      	mov	r5, r4
c0d0311e:	350c      	adds	r5, #12
c0d03120:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d03122:	2900      	cmp	r1, #0
c0d03124:	d005      	beq.n	c0d03132 <USBD_GetStatus+0x32>
c0d03126:	4620      	mov	r0, r4
c0d03128:	f000 fa77 	bl	c0d0361a <USBD_CtlReceiveStatus>
c0d0312c:	68e1      	ldr	r1, [r4, #12]
c0d0312e:	2002      	movs	r0, #2
c0d03130:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d03132:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d03134:	2202      	movs	r2, #2
c0d03136:	4620      	mov	r0, r4
c0d03138:	4629      	mov	r1, r5
c0d0313a:	f000 fa33 	bl	c0d035a4 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d0313e:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d03140:	2180      	movs	r1, #128	; 0x80
c0d03142:	4620      	mov	r0, r4
c0d03144:	f7ff fc72 	bl	c0d02a2c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d03148:	2100      	movs	r1, #0
c0d0314a:	4620      	mov	r0, r4
c0d0314c:	f7ff fc6e 	bl	c0d02a2c <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d03150:	bdb0      	pop	{r4, r5, r7, pc}

c0d03152 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d03152:	b5b0      	push	{r4, r5, r7, lr}
c0d03154:	af02      	add	r7, sp, #8
c0d03156:	460d      	mov	r5, r1
c0d03158:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d0315a:	8868      	ldrh	r0, [r5, #2]
c0d0315c:	2801      	cmp	r0, #1
c0d0315e:	d110      	bne.n	c0d03182 <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d03160:	2041      	movs	r0, #65	; 0x41
c0d03162:	0080      	lsls	r0, r0, #2
c0d03164:	2101      	movs	r1, #1
c0d03166:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d03168:	2045      	movs	r0, #69	; 0x45
c0d0316a:	0080      	lsls	r0, r0, #2
c0d0316c:	5820      	ldr	r0, [r4, r0]
c0d0316e:	6880      	ldr	r0, [r0, #8]
c0d03170:	f7ff f846 	bl	c0d02200 <pic>
c0d03174:	4602      	mov	r2, r0
c0d03176:	4620      	mov	r0, r4
c0d03178:	4629      	mov	r1, r5
c0d0317a:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d0317c:	4620      	mov	r0, r4
c0d0317e:	f000 fa3f 	bl	c0d03600 <USBD_CtlSendStatus>
  }

}
c0d03182:	bdb0      	pop	{r4, r5, r7, pc}

c0d03184 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d03184:	b5b0      	push	{r4, r5, r7, lr}
c0d03186:	af02      	add	r7, sp, #8
c0d03188:	460d      	mov	r5, r1
c0d0318a:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d0318c:	20fc      	movs	r0, #252	; 0xfc
c0d0318e:	5c20      	ldrb	r0, [r4, r0]
c0d03190:	21fe      	movs	r1, #254	; 0xfe
c0d03192:	4001      	ands	r1, r0
c0d03194:	2902      	cmp	r1, #2
c0d03196:	d114      	bne.n	c0d031c2 <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d03198:	8868      	ldrh	r0, [r5, #2]
c0d0319a:	2801      	cmp	r0, #1
c0d0319c:	d119      	bne.n	c0d031d2 <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d0319e:	2041      	movs	r0, #65	; 0x41
c0d031a0:	0080      	lsls	r0, r0, #2
c0d031a2:	2100      	movs	r1, #0
c0d031a4:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d031a6:	2045      	movs	r0, #69	; 0x45
c0d031a8:	0080      	lsls	r0, r0, #2
c0d031aa:	5820      	ldr	r0, [r4, r0]
c0d031ac:	6880      	ldr	r0, [r0, #8]
c0d031ae:	f7ff f827 	bl	c0d02200 <pic>
c0d031b2:	4602      	mov	r2, r0
c0d031b4:	4620      	mov	r0, r4
c0d031b6:	4629      	mov	r1, r5
c0d031b8:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d031ba:	4620      	mov	r0, r4
c0d031bc:	f000 fa20 	bl	c0d03600 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d031c0:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d031c2:	2180      	movs	r1, #128	; 0x80
c0d031c4:	4620      	mov	r0, r4
c0d031c6:	f7ff fc31 	bl	c0d02a2c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d031ca:	2100      	movs	r1, #0
c0d031cc:	4620      	mov	r0, r4
c0d031ce:	f7ff fc2d 	bl	c0d02a2c <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d031d2:	bdb0      	pop	{r4, r5, r7, pc}

c0d031d4 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d031d4:	b5d0      	push	{r4, r6, r7, lr}
c0d031d6:	af02      	add	r7, sp, #8
c0d031d8:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d031da:	2180      	movs	r1, #128	; 0x80
c0d031dc:	f7ff fc26 	bl	c0d02a2c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d031e0:	2100      	movs	r1, #0
c0d031e2:	4620      	mov	r0, r4
c0d031e4:	f7ff fc22 	bl	c0d02a2c <USBD_LL_StallEP>
}
c0d031e8:	bdd0      	pop	{r4, r6, r7, pc}

c0d031ea <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d031ea:	b5b0      	push	{r4, r5, r7, lr}
c0d031ec:	af02      	add	r7, sp, #8
c0d031ee:	460d      	mov	r5, r1
c0d031f0:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d031f2:	20fc      	movs	r0, #252	; 0xfc
c0d031f4:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d031f6:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d031f8:	2803      	cmp	r0, #3
c0d031fa:	d115      	bne.n	c0d03228 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d031fc:	88a8      	ldrh	r0, [r5, #4]
c0d031fe:	22fe      	movs	r2, #254	; 0xfe
c0d03200:	4002      	ands	r2, r0
c0d03202:	2a01      	cmp	r2, #1
c0d03204:	d810      	bhi.n	c0d03228 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d03206:	2045      	movs	r0, #69	; 0x45
c0d03208:	0080      	lsls	r0, r0, #2
c0d0320a:	5820      	ldr	r0, [r4, r0]
c0d0320c:	6880      	ldr	r0, [r0, #8]
c0d0320e:	f7fe fff7 	bl	c0d02200 <pic>
c0d03212:	4602      	mov	r2, r0
c0d03214:	4620      	mov	r0, r4
c0d03216:	4629      	mov	r1, r5
c0d03218:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d0321a:	88e8      	ldrh	r0, [r5, #6]
c0d0321c:	2800      	cmp	r0, #0
c0d0321e:	d10a      	bne.n	c0d03236 <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d03220:	4620      	mov	r0, r4
c0d03222:	f000 f9ed 	bl	c0d03600 <USBD_CtlSendStatus>
c0d03226:	e006      	b.n	c0d03236 <USBD_StdItfReq+0x4c>
c0d03228:	4620      	mov	r0, r4
c0d0322a:	f7ff fbff 	bl	c0d02a2c <USBD_LL_StallEP>
c0d0322e:	2100      	movs	r1, #0
c0d03230:	4620      	mov	r0, r4
c0d03232:	f7ff fbfb 	bl	c0d02a2c <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d03236:	2000      	movs	r0, #0
c0d03238:	bdb0      	pop	{r4, r5, r7, pc}

c0d0323a <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d0323a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0323c:	af03      	add	r7, sp, #12
c0d0323e:	b081      	sub	sp, #4
c0d03240:	460e      	mov	r6, r1
c0d03242:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d03244:	7830      	ldrb	r0, [r6, #0]
c0d03246:	2160      	movs	r1, #96	; 0x60
c0d03248:	4001      	ands	r1, r0
c0d0324a:	2920      	cmp	r1, #32
c0d0324c:	d10a      	bne.n	c0d03264 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d0324e:	2045      	movs	r0, #69	; 0x45
c0d03250:	0080      	lsls	r0, r0, #2
c0d03252:	5820      	ldr	r0, [r4, r0]
c0d03254:	6880      	ldr	r0, [r0, #8]
c0d03256:	f7fe ffd3 	bl	c0d02200 <pic>
c0d0325a:	4602      	mov	r2, r0
c0d0325c:	4620      	mov	r0, r4
c0d0325e:	4631      	mov	r1, r6
c0d03260:	4790      	blx	r2
c0d03262:	e063      	b.n	c0d0332c <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d03264:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d03266:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d03268:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d0326a:	2800      	cmp	r0, #0
c0d0326c:	d012      	beq.n	c0d03294 <USBD_StdEPReq+0x5a>
c0d0326e:	2801      	cmp	r0, #1
c0d03270:	d019      	beq.n	c0d032a6 <USBD_StdEPReq+0x6c>
c0d03272:	2803      	cmp	r0, #3
c0d03274:	d15a      	bne.n	c0d0332c <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d03276:	20fc      	movs	r0, #252	; 0xfc
c0d03278:	5c20      	ldrb	r0, [r4, r0]
c0d0327a:	2803      	cmp	r0, #3
c0d0327c:	d117      	bne.n	c0d032ae <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d0327e:	8870      	ldrh	r0, [r6, #2]
c0d03280:	2800      	cmp	r0, #0
c0d03282:	d12d      	bne.n	c0d032e0 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d03284:	4329      	orrs	r1, r5
c0d03286:	2980      	cmp	r1, #128	; 0x80
c0d03288:	d02a      	beq.n	c0d032e0 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d0328a:	4620      	mov	r0, r4
c0d0328c:	4629      	mov	r1, r5
c0d0328e:	f7ff fbcd 	bl	c0d02a2c <USBD_LL_StallEP>
c0d03292:	e025      	b.n	c0d032e0 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d03294:	20fc      	movs	r0, #252	; 0xfc
c0d03296:	5c20      	ldrb	r0, [r4, r0]
c0d03298:	2803      	cmp	r0, #3
c0d0329a:	d02f      	beq.n	c0d032fc <USBD_StdEPReq+0xc2>
c0d0329c:	2802      	cmp	r0, #2
c0d0329e:	d10e      	bne.n	c0d032be <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d032a0:	0668      	lsls	r0, r5, #25
c0d032a2:	d109      	bne.n	c0d032b8 <USBD_StdEPReq+0x7e>
c0d032a4:	e042      	b.n	c0d0332c <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d032a6:	20fc      	movs	r0, #252	; 0xfc
c0d032a8:	5c20      	ldrb	r0, [r4, r0]
c0d032aa:	2803      	cmp	r0, #3
c0d032ac:	d00f      	beq.n	c0d032ce <USBD_StdEPReq+0x94>
c0d032ae:	2802      	cmp	r0, #2
c0d032b0:	d105      	bne.n	c0d032be <USBD_StdEPReq+0x84>
c0d032b2:	4329      	orrs	r1, r5
c0d032b4:	2980      	cmp	r1, #128	; 0x80
c0d032b6:	d039      	beq.n	c0d0332c <USBD_StdEPReq+0xf2>
c0d032b8:	4620      	mov	r0, r4
c0d032ba:	4629      	mov	r1, r5
c0d032bc:	e004      	b.n	c0d032c8 <USBD_StdEPReq+0x8e>
c0d032be:	4620      	mov	r0, r4
c0d032c0:	f7ff fbb4 	bl	c0d02a2c <USBD_LL_StallEP>
c0d032c4:	2100      	movs	r1, #0
c0d032c6:	4620      	mov	r0, r4
c0d032c8:	f7ff fbb0 	bl	c0d02a2c <USBD_LL_StallEP>
c0d032cc:	e02e      	b.n	c0d0332c <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d032ce:	8870      	ldrh	r0, [r6, #2]
c0d032d0:	2800      	cmp	r0, #0
c0d032d2:	d12b      	bne.n	c0d0332c <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d032d4:	0668      	lsls	r0, r5, #25
c0d032d6:	d00d      	beq.n	c0d032f4 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d032d8:	4620      	mov	r0, r4
c0d032da:	4629      	mov	r1, r5
c0d032dc:	f7ff fbcc 	bl	c0d02a78 <USBD_LL_ClearStallEP>
c0d032e0:	2045      	movs	r0, #69	; 0x45
c0d032e2:	0080      	lsls	r0, r0, #2
c0d032e4:	5820      	ldr	r0, [r4, r0]
c0d032e6:	6880      	ldr	r0, [r0, #8]
c0d032e8:	f7fe ff8a 	bl	c0d02200 <pic>
c0d032ec:	4602      	mov	r2, r0
c0d032ee:	4620      	mov	r0, r4
c0d032f0:	4631      	mov	r1, r6
c0d032f2:	4790      	blx	r2
c0d032f4:	4620      	mov	r0, r4
c0d032f6:	f000 f983 	bl	c0d03600 <USBD_CtlSendStatus>
c0d032fa:	e017      	b.n	c0d0332c <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d032fc:	4626      	mov	r6, r4
c0d032fe:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d03300:	4620      	mov	r0, r4
c0d03302:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d03304:	420d      	tst	r5, r1
c0d03306:	d100      	bne.n	c0d0330a <USBD_StdEPReq+0xd0>
c0d03308:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d0330a:	4620      	mov	r0, r4
c0d0330c:	4629      	mov	r1, r5
c0d0330e:	f7ff fbd9 	bl	c0d02ac4 <USBD_LL_IsStallEP>
c0d03312:	2101      	movs	r1, #1
c0d03314:	2800      	cmp	r0, #0
c0d03316:	d100      	bne.n	c0d0331a <USBD_StdEPReq+0xe0>
c0d03318:	4601      	mov	r1, r0
c0d0331a:	207f      	movs	r0, #127	; 0x7f
c0d0331c:	4005      	ands	r5, r0
c0d0331e:	0128      	lsls	r0, r5, #4
c0d03320:	5031      	str	r1, [r6, r0]
c0d03322:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d03324:	2202      	movs	r2, #2
c0d03326:	4620      	mov	r0, r4
c0d03328:	f000 f93c 	bl	c0d035a4 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d0332c:	2000      	movs	r0, #0
c0d0332e:	b001      	add	sp, #4
c0d03330:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03332 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d03332:	780a      	ldrb	r2, [r1, #0]
c0d03334:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d03336:	784a      	ldrb	r2, [r1, #1]
c0d03338:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d0333a:	788a      	ldrb	r2, [r1, #2]
c0d0333c:	78cb      	ldrb	r3, [r1, #3]
c0d0333e:	021b      	lsls	r3, r3, #8
c0d03340:	4313      	orrs	r3, r2
c0d03342:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d03344:	790a      	ldrb	r2, [r1, #4]
c0d03346:	794b      	ldrb	r3, [r1, #5]
c0d03348:	021b      	lsls	r3, r3, #8
c0d0334a:	4313      	orrs	r3, r2
c0d0334c:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d0334e:	798a      	ldrb	r2, [r1, #6]
c0d03350:	79c9      	ldrb	r1, [r1, #7]
c0d03352:	0209      	lsls	r1, r1, #8
c0d03354:	4311      	orrs	r1, r2
c0d03356:	80c1      	strh	r1, [r0, #6]

}
c0d03358:	4770      	bx	lr

c0d0335a <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d0335a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0335c:	af03      	add	r7, sp, #12
c0d0335e:	b083      	sub	sp, #12
c0d03360:	460d      	mov	r5, r1
c0d03362:	4604      	mov	r4, r0
c0d03364:	a802      	add	r0, sp, #8
c0d03366:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d03368:	8006      	strh	r6, [r0, #0]
c0d0336a:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d0336c:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d0336e:	7829      	ldrb	r1, [r5, #0]
c0d03370:	2060      	movs	r0, #96	; 0x60
c0d03372:	4008      	ands	r0, r1
c0d03374:	2800      	cmp	r0, #0
c0d03376:	d010      	beq.n	c0d0339a <USBD_HID_Setup+0x40>
c0d03378:	2820      	cmp	r0, #32
c0d0337a:	d139      	bne.n	c0d033f0 <USBD_HID_Setup+0x96>
c0d0337c:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d0337e:	4601      	mov	r1, r0
c0d03380:	390a      	subs	r1, #10
c0d03382:	2902      	cmp	r1, #2
c0d03384:	d334      	bcc.n	c0d033f0 <USBD_HID_Setup+0x96>
c0d03386:	2802      	cmp	r0, #2
c0d03388:	d01c      	beq.n	c0d033c4 <USBD_HID_Setup+0x6a>
c0d0338a:	2803      	cmp	r0, #3
c0d0338c:	d01a      	beq.n	c0d033c4 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d0338e:	4620      	mov	r0, r4
c0d03390:	4629      	mov	r1, r5
c0d03392:	f7ff ff1f 	bl	c0d031d4 <USBD_CtlError>
c0d03396:	2602      	movs	r6, #2
c0d03398:	e02a      	b.n	c0d033f0 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d0339a:	7868      	ldrb	r0, [r5, #1]
c0d0339c:	280b      	cmp	r0, #11
c0d0339e:	d014      	beq.n	c0d033ca <USBD_HID_Setup+0x70>
c0d033a0:	280a      	cmp	r0, #10
c0d033a2:	d00f      	beq.n	c0d033c4 <USBD_HID_Setup+0x6a>
c0d033a4:	2806      	cmp	r0, #6
c0d033a6:	d123      	bne.n	c0d033f0 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d033a8:	8868      	ldrh	r0, [r5, #2]
c0d033aa:	0a00      	lsrs	r0, r0, #8
c0d033ac:	2600      	movs	r6, #0
c0d033ae:	2821      	cmp	r0, #33	; 0x21
c0d033b0:	d00f      	beq.n	c0d033d2 <USBD_HID_Setup+0x78>
c0d033b2:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d033b4:	4632      	mov	r2, r6
c0d033b6:	4631      	mov	r1, r6
c0d033b8:	d117      	bne.n	c0d033ea <USBD_HID_Setup+0x90>
c0d033ba:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d033bc:	9000      	str	r0, [sp, #0]
c0d033be:	f000 f847 	bl	c0d03450 <USBD_HID_GetReportDescriptor_impl>
c0d033c2:	e00a      	b.n	c0d033da <USBD_HID_Setup+0x80>
c0d033c4:	a901      	add	r1, sp, #4
c0d033c6:	2201      	movs	r2, #1
c0d033c8:	e00f      	b.n	c0d033ea <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d033ca:	4620      	mov	r0, r4
c0d033cc:	f000 f918 	bl	c0d03600 <USBD_CtlSendStatus>
c0d033d0:	e00e      	b.n	c0d033f0 <USBD_HID_Setup+0x96>
c0d033d2:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d033d4:	9000      	str	r0, [sp, #0]
c0d033d6:	f000 f833 	bl	c0d03440 <USBD_HID_GetHidDescriptor_impl>
c0d033da:	9b00      	ldr	r3, [sp, #0]
c0d033dc:	4601      	mov	r1, r0
c0d033de:	881a      	ldrh	r2, [r3, #0]
c0d033e0:	88e8      	ldrh	r0, [r5, #6]
c0d033e2:	4282      	cmp	r2, r0
c0d033e4:	d300      	bcc.n	c0d033e8 <USBD_HID_Setup+0x8e>
c0d033e6:	4602      	mov	r2, r0
c0d033e8:	801a      	strh	r2, [r3, #0]
c0d033ea:	4620      	mov	r0, r4
c0d033ec:	f000 f8da 	bl	c0d035a4 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d033f0:	b2f0      	uxtb	r0, r6
c0d033f2:	b003      	add	sp, #12
c0d033f4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d033f6 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d033f6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d033f8:	af03      	add	r7, sp, #12
c0d033fa:	b081      	sub	sp, #4
c0d033fc:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d033fe:	2182      	movs	r1, #130	; 0x82
c0d03400:	2502      	movs	r5, #2
c0d03402:	2640      	movs	r6, #64	; 0x40
c0d03404:	462a      	mov	r2, r5
c0d03406:	4633      	mov	r3, r6
c0d03408:	f7ff fad0 	bl	c0d029ac <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d0340c:	4620      	mov	r0, r4
c0d0340e:	4629      	mov	r1, r5
c0d03410:	462a      	mov	r2, r5
c0d03412:	4633      	mov	r3, r6
c0d03414:	f7ff faca 	bl	c0d029ac <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d03418:	4620      	mov	r0, r4
c0d0341a:	4629      	mov	r1, r5
c0d0341c:	4632      	mov	r2, r6
c0d0341e:	f7ff fb90 	bl	c0d02b42 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d03422:	2000      	movs	r0, #0
c0d03424:	b001      	add	sp, #4
c0d03426:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03428 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d03428:	b5d0      	push	{r4, r6, r7, lr}
c0d0342a:	af02      	add	r7, sp, #8
c0d0342c:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d0342e:	2182      	movs	r1, #130	; 0x82
c0d03430:	f7ff fae4 	bl	c0d029fc <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d03434:	2102      	movs	r1, #2
c0d03436:	4620      	mov	r0, r4
c0d03438:	f7ff fae0 	bl	c0d029fc <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d0343c:	2000      	movs	r0, #0
c0d0343e:	bdd0      	pop	{r4, r6, r7, pc}

c0d03440 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d03440:	2109      	movs	r1, #9
c0d03442:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d03444:	4801      	ldr	r0, [pc, #4]	; (c0d0344c <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d03446:	4478      	add	r0, pc
c0d03448:	4770      	bx	lr
c0d0344a:	46c0      	nop			; (mov r8, r8)
c0d0344c:	00000cc6 	.word	0x00000cc6

c0d03450 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d03450:	2122      	movs	r1, #34	; 0x22
c0d03452:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d03454:	4801      	ldr	r0, [pc, #4]	; (c0d0345c <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d03456:	4478      	add	r0, pc
c0d03458:	4770      	bx	lr
c0d0345a:	46c0      	nop			; (mov r8, r8)
c0d0345c:	00000c91 	.word	0x00000c91

c0d03460 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d03460:	b5b0      	push	{r4, r5, r7, lr}
c0d03462:	af02      	add	r7, sp, #8
c0d03464:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d03466:	2102      	movs	r1, #2
c0d03468:	2240      	movs	r2, #64	; 0x40
c0d0346a:	f7ff fb6a 	bl	c0d02b42 <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d0346e:	4d0d      	ldr	r5, [pc, #52]	; (c0d034a4 <USBD_HID_DataOut_impl+0x44>)
c0d03470:	7828      	ldrb	r0, [r5, #0]
c0d03472:	2800      	cmp	r0, #0
c0d03474:	d113      	bne.n	c0d0349e <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d03476:	2002      	movs	r0, #2
c0d03478:	f7fe f928 	bl	c0d016cc <io_seproxyhal_get_ep_rx_size>
c0d0347c:	4602      	mov	r2, r0
c0d0347e:	480d      	ldr	r0, [pc, #52]	; (c0d034b4 <USBD_HID_DataOut_impl+0x54>)
c0d03480:	4478      	add	r0, pc
c0d03482:	4621      	mov	r1, r4
c0d03484:	f7fd ff86 	bl	c0d01394 <io_usb_hid_receive>
c0d03488:	2802      	cmp	r0, #2
c0d0348a:	d108      	bne.n	c0d0349e <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d0348c:	2001      	movs	r0, #1
c0d0348e:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d03490:	4805      	ldr	r0, [pc, #20]	; (c0d034a8 <USBD_HID_DataOut_impl+0x48>)
c0d03492:	2107      	movs	r1, #7
c0d03494:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d03496:	4805      	ldr	r0, [pc, #20]	; (c0d034ac <USBD_HID_DataOut_impl+0x4c>)
c0d03498:	6800      	ldr	r0, [r0, #0]
c0d0349a:	4905      	ldr	r1, [pc, #20]	; (c0d034b0 <USBD_HID_DataOut_impl+0x50>)
c0d0349c:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d0349e:	2000      	movs	r0, #0
c0d034a0:	bdb0      	pop	{r4, r5, r7, pc}
c0d034a2:	46c0      	nop			; (mov r8, r8)
c0d034a4:	20001d10 	.word	0x20001d10
c0d034a8:	20001d18 	.word	0x20001d18
c0d034ac:	20001c00 	.word	0x20001c00
c0d034b0:	20001d1c 	.word	0x20001d1c
c0d034b4:	ffffe3a1 	.word	0xffffe3a1

c0d034b8 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d034b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d034ba:	af03      	add	r7, sp, #12
c0d034bc:	b081      	sub	sp, #4
c0d034be:	4604      	mov	r4, r0
c0d034c0:	2049      	movs	r0, #73	; 0x49
c0d034c2:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d034c4:	4810      	ldr	r0, [pc, #64]	; (c0d03508 <USB_power+0x50>)
c0d034c6:	2100      	movs	r1, #0
c0d034c8:	462a      	mov	r2, r5
c0d034ca:	f7fe f80f 	bl	c0d014ec <os_memset>

  if (enabled) {
c0d034ce:	2c00      	cmp	r4, #0
c0d034d0:	d015      	beq.n	c0d034fe <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d034d2:	4c0d      	ldr	r4, [pc, #52]	; (c0d03508 <USB_power+0x50>)
c0d034d4:	2600      	movs	r6, #0
c0d034d6:	4620      	mov	r0, r4
c0d034d8:	4631      	mov	r1, r6
c0d034da:	462a      	mov	r2, r5
c0d034dc:	f7fe f806 	bl	c0d014ec <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d034e0:	490a      	ldr	r1, [pc, #40]	; (c0d0350c <USB_power+0x54>)
c0d034e2:	4479      	add	r1, pc
c0d034e4:	4620      	mov	r0, r4
c0d034e6:	4632      	mov	r2, r6
c0d034e8:	f7ff fb3f 	bl	c0d02b6a <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d034ec:	4908      	ldr	r1, [pc, #32]	; (c0d03510 <USB_power+0x58>)
c0d034ee:	4479      	add	r1, pc
c0d034f0:	4620      	mov	r0, r4
c0d034f2:	f7ff fb72 	bl	c0d02bda <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d034f6:	4620      	mov	r0, r4
c0d034f8:	f7ff fb78 	bl	c0d02bec <USBD_Start>
c0d034fc:	e002      	b.n	c0d03504 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d034fe:	4802      	ldr	r0, [pc, #8]	; (c0d03508 <USB_power+0x50>)
c0d03500:	f7ff fb51 	bl	c0d02ba6 <USBD_DeInit>
  }
}
c0d03504:	b001      	add	sp, #4
c0d03506:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03508:	20001d34 	.word	0x20001d34
c0d0350c:	00000c46 	.word	0x00000c46
c0d03510:	00000c76 	.word	0x00000c76

c0d03514 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d03514:	2012      	movs	r0, #18
c0d03516:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d03518:	4801      	ldr	r0, [pc, #4]	; (c0d03520 <USBD_DeviceDescriptor+0xc>)
c0d0351a:	4478      	add	r0, pc
c0d0351c:	4770      	bx	lr
c0d0351e:	46c0      	nop			; (mov r8, r8)
c0d03520:	00000bfb 	.word	0x00000bfb

c0d03524 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d03524:	2004      	movs	r0, #4
c0d03526:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d03528:	4801      	ldr	r0, [pc, #4]	; (c0d03530 <USBD_LangIDStrDescriptor+0xc>)
c0d0352a:	4478      	add	r0, pc
c0d0352c:	4770      	bx	lr
c0d0352e:	46c0      	nop			; (mov r8, r8)
c0d03530:	00000c1e 	.word	0x00000c1e

c0d03534 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d03534:	200e      	movs	r0, #14
c0d03536:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d03538:	4801      	ldr	r0, [pc, #4]	; (c0d03540 <USBD_ManufacturerStrDescriptor+0xc>)
c0d0353a:	4478      	add	r0, pc
c0d0353c:	4770      	bx	lr
c0d0353e:	46c0      	nop			; (mov r8, r8)
c0d03540:	00000c12 	.word	0x00000c12

c0d03544 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d03544:	200e      	movs	r0, #14
c0d03546:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d03548:	4801      	ldr	r0, [pc, #4]	; (c0d03550 <USBD_ProductStrDescriptor+0xc>)
c0d0354a:	4478      	add	r0, pc
c0d0354c:	4770      	bx	lr
c0d0354e:	46c0      	nop			; (mov r8, r8)
c0d03550:	00000b8f 	.word	0x00000b8f

c0d03554 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d03554:	200a      	movs	r0, #10
c0d03556:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d03558:	4801      	ldr	r0, [pc, #4]	; (c0d03560 <USBD_SerialStrDescriptor+0xc>)
c0d0355a:	4478      	add	r0, pc
c0d0355c:	4770      	bx	lr
c0d0355e:	46c0      	nop			; (mov r8, r8)
c0d03560:	00000c00 	.word	0x00000c00

c0d03564 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d03564:	200e      	movs	r0, #14
c0d03566:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d03568:	4801      	ldr	r0, [pc, #4]	; (c0d03570 <USBD_ConfigStrDescriptor+0xc>)
c0d0356a:	4478      	add	r0, pc
c0d0356c:	4770      	bx	lr
c0d0356e:	46c0      	nop			; (mov r8, r8)
c0d03570:	00000b6f 	.word	0x00000b6f

c0d03574 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d03574:	200e      	movs	r0, #14
c0d03576:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d03578:	4801      	ldr	r0, [pc, #4]	; (c0d03580 <USBD_InterfaceStrDescriptor+0xc>)
c0d0357a:	4478      	add	r0, pc
c0d0357c:	4770      	bx	lr
c0d0357e:	46c0      	nop			; (mov r8, r8)
c0d03580:	00000b5f 	.word	0x00000b5f

c0d03584 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d03584:	2129      	movs	r1, #41	; 0x29
c0d03586:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d03588:	4801      	ldr	r0, [pc, #4]	; (c0d03590 <USBD_GetCfgDesc_impl+0xc>)
c0d0358a:	4478      	add	r0, pc
c0d0358c:	4770      	bx	lr
c0d0358e:	46c0      	nop			; (mov r8, r8)
c0d03590:	00000c12 	.word	0x00000c12

c0d03594 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d03594:	210a      	movs	r1, #10
c0d03596:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d03598:	4801      	ldr	r0, [pc, #4]	; (c0d035a0 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d0359a:	4478      	add	r0, pc
c0d0359c:	4770      	bx	lr
c0d0359e:	46c0      	nop			; (mov r8, r8)
c0d035a0:	00000c2e 	.word	0x00000c2e

c0d035a4 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d035a4:	b5b0      	push	{r4, r5, r7, lr}
c0d035a6:	af02      	add	r7, sp, #8
c0d035a8:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d035aa:	21f4      	movs	r1, #244	; 0xf4
c0d035ac:	2302      	movs	r3, #2
c0d035ae:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d035b0:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d035b2:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d035b4:	2109      	movs	r1, #9
c0d035b6:	0149      	lsls	r1, r1, #5
c0d035b8:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d035ba:	6a01      	ldr	r1, [r0, #32]
c0d035bc:	428a      	cmp	r2, r1
c0d035be:	d300      	bcc.n	c0d035c2 <USBD_CtlSendData+0x1e>
c0d035c0:	460a      	mov	r2, r1
c0d035c2:	b293      	uxth	r3, r2
c0d035c4:	2500      	movs	r5, #0
c0d035c6:	4629      	mov	r1, r5
c0d035c8:	4622      	mov	r2, r4
c0d035ca:	f7ff faa0 	bl	c0d02b0e <USBD_LL_Transmit>
  
  return USBD_OK;
c0d035ce:	4628      	mov	r0, r5
c0d035d0:	bdb0      	pop	{r4, r5, r7, pc}

c0d035d2 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d035d2:	b5b0      	push	{r4, r5, r7, lr}
c0d035d4:	af02      	add	r7, sp, #8
c0d035d6:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d035d8:	6a01      	ldr	r1, [r0, #32]
c0d035da:	428a      	cmp	r2, r1
c0d035dc:	d300      	bcc.n	c0d035e0 <USBD_CtlContinueSendData+0xe>
c0d035de:	460a      	mov	r2, r1
c0d035e0:	b293      	uxth	r3, r2
c0d035e2:	2500      	movs	r5, #0
c0d035e4:	4629      	mov	r1, r5
c0d035e6:	4622      	mov	r2, r4
c0d035e8:	f7ff fa91 	bl	c0d02b0e <USBD_LL_Transmit>
  return USBD_OK;
c0d035ec:	4628      	mov	r0, r5
c0d035ee:	bdb0      	pop	{r4, r5, r7, pc}

c0d035f0 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d035f0:	b5d0      	push	{r4, r6, r7, lr}
c0d035f2:	af02      	add	r7, sp, #8
c0d035f4:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d035f6:	4621      	mov	r1, r4
c0d035f8:	f7ff faa3 	bl	c0d02b42 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d035fc:	4620      	mov	r0, r4
c0d035fe:	bdd0      	pop	{r4, r6, r7, pc}

c0d03600 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d03600:	b5d0      	push	{r4, r6, r7, lr}
c0d03602:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d03604:	21f4      	movs	r1, #244	; 0xf4
c0d03606:	2204      	movs	r2, #4
c0d03608:	5042      	str	r2, [r0, r1]
c0d0360a:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d0360c:	4621      	mov	r1, r4
c0d0360e:	4622      	mov	r2, r4
c0d03610:	4623      	mov	r3, r4
c0d03612:	f7ff fa7c 	bl	c0d02b0e <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03616:	4620      	mov	r0, r4
c0d03618:	bdd0      	pop	{r4, r6, r7, pc}

c0d0361a <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d0361a:	b5d0      	push	{r4, r6, r7, lr}
c0d0361c:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d0361e:	21f4      	movs	r1, #244	; 0xf4
c0d03620:	2205      	movs	r2, #5
c0d03622:	5042      	str	r2, [r0, r1]
c0d03624:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d03626:	4621      	mov	r1, r4
c0d03628:	4622      	mov	r2, r4
c0d0362a:	f7ff fa8a 	bl	c0d02b42 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d0362e:	4620      	mov	r0, r4
c0d03630:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d03634 <__aeabi_uidiv>:
c0d03634:	2200      	movs	r2, #0
c0d03636:	0843      	lsrs	r3, r0, #1
c0d03638:	428b      	cmp	r3, r1
c0d0363a:	d374      	bcc.n	c0d03726 <__aeabi_uidiv+0xf2>
c0d0363c:	0903      	lsrs	r3, r0, #4
c0d0363e:	428b      	cmp	r3, r1
c0d03640:	d35f      	bcc.n	c0d03702 <__aeabi_uidiv+0xce>
c0d03642:	0a03      	lsrs	r3, r0, #8
c0d03644:	428b      	cmp	r3, r1
c0d03646:	d344      	bcc.n	c0d036d2 <__aeabi_uidiv+0x9e>
c0d03648:	0b03      	lsrs	r3, r0, #12
c0d0364a:	428b      	cmp	r3, r1
c0d0364c:	d328      	bcc.n	c0d036a0 <__aeabi_uidiv+0x6c>
c0d0364e:	0c03      	lsrs	r3, r0, #16
c0d03650:	428b      	cmp	r3, r1
c0d03652:	d30d      	bcc.n	c0d03670 <__aeabi_uidiv+0x3c>
c0d03654:	22ff      	movs	r2, #255	; 0xff
c0d03656:	0209      	lsls	r1, r1, #8
c0d03658:	ba12      	rev	r2, r2
c0d0365a:	0c03      	lsrs	r3, r0, #16
c0d0365c:	428b      	cmp	r3, r1
c0d0365e:	d302      	bcc.n	c0d03666 <__aeabi_uidiv+0x32>
c0d03660:	1212      	asrs	r2, r2, #8
c0d03662:	0209      	lsls	r1, r1, #8
c0d03664:	d065      	beq.n	c0d03732 <__aeabi_uidiv+0xfe>
c0d03666:	0b03      	lsrs	r3, r0, #12
c0d03668:	428b      	cmp	r3, r1
c0d0366a:	d319      	bcc.n	c0d036a0 <__aeabi_uidiv+0x6c>
c0d0366c:	e000      	b.n	c0d03670 <__aeabi_uidiv+0x3c>
c0d0366e:	0a09      	lsrs	r1, r1, #8
c0d03670:	0bc3      	lsrs	r3, r0, #15
c0d03672:	428b      	cmp	r3, r1
c0d03674:	d301      	bcc.n	c0d0367a <__aeabi_uidiv+0x46>
c0d03676:	03cb      	lsls	r3, r1, #15
c0d03678:	1ac0      	subs	r0, r0, r3
c0d0367a:	4152      	adcs	r2, r2
c0d0367c:	0b83      	lsrs	r3, r0, #14
c0d0367e:	428b      	cmp	r3, r1
c0d03680:	d301      	bcc.n	c0d03686 <__aeabi_uidiv+0x52>
c0d03682:	038b      	lsls	r3, r1, #14
c0d03684:	1ac0      	subs	r0, r0, r3
c0d03686:	4152      	adcs	r2, r2
c0d03688:	0b43      	lsrs	r3, r0, #13
c0d0368a:	428b      	cmp	r3, r1
c0d0368c:	d301      	bcc.n	c0d03692 <__aeabi_uidiv+0x5e>
c0d0368e:	034b      	lsls	r3, r1, #13
c0d03690:	1ac0      	subs	r0, r0, r3
c0d03692:	4152      	adcs	r2, r2
c0d03694:	0b03      	lsrs	r3, r0, #12
c0d03696:	428b      	cmp	r3, r1
c0d03698:	d301      	bcc.n	c0d0369e <__aeabi_uidiv+0x6a>
c0d0369a:	030b      	lsls	r3, r1, #12
c0d0369c:	1ac0      	subs	r0, r0, r3
c0d0369e:	4152      	adcs	r2, r2
c0d036a0:	0ac3      	lsrs	r3, r0, #11
c0d036a2:	428b      	cmp	r3, r1
c0d036a4:	d301      	bcc.n	c0d036aa <__aeabi_uidiv+0x76>
c0d036a6:	02cb      	lsls	r3, r1, #11
c0d036a8:	1ac0      	subs	r0, r0, r3
c0d036aa:	4152      	adcs	r2, r2
c0d036ac:	0a83      	lsrs	r3, r0, #10
c0d036ae:	428b      	cmp	r3, r1
c0d036b0:	d301      	bcc.n	c0d036b6 <__aeabi_uidiv+0x82>
c0d036b2:	028b      	lsls	r3, r1, #10
c0d036b4:	1ac0      	subs	r0, r0, r3
c0d036b6:	4152      	adcs	r2, r2
c0d036b8:	0a43      	lsrs	r3, r0, #9
c0d036ba:	428b      	cmp	r3, r1
c0d036bc:	d301      	bcc.n	c0d036c2 <__aeabi_uidiv+0x8e>
c0d036be:	024b      	lsls	r3, r1, #9
c0d036c0:	1ac0      	subs	r0, r0, r3
c0d036c2:	4152      	adcs	r2, r2
c0d036c4:	0a03      	lsrs	r3, r0, #8
c0d036c6:	428b      	cmp	r3, r1
c0d036c8:	d301      	bcc.n	c0d036ce <__aeabi_uidiv+0x9a>
c0d036ca:	020b      	lsls	r3, r1, #8
c0d036cc:	1ac0      	subs	r0, r0, r3
c0d036ce:	4152      	adcs	r2, r2
c0d036d0:	d2cd      	bcs.n	c0d0366e <__aeabi_uidiv+0x3a>
c0d036d2:	09c3      	lsrs	r3, r0, #7
c0d036d4:	428b      	cmp	r3, r1
c0d036d6:	d301      	bcc.n	c0d036dc <__aeabi_uidiv+0xa8>
c0d036d8:	01cb      	lsls	r3, r1, #7
c0d036da:	1ac0      	subs	r0, r0, r3
c0d036dc:	4152      	adcs	r2, r2
c0d036de:	0983      	lsrs	r3, r0, #6
c0d036e0:	428b      	cmp	r3, r1
c0d036e2:	d301      	bcc.n	c0d036e8 <__aeabi_uidiv+0xb4>
c0d036e4:	018b      	lsls	r3, r1, #6
c0d036e6:	1ac0      	subs	r0, r0, r3
c0d036e8:	4152      	adcs	r2, r2
c0d036ea:	0943      	lsrs	r3, r0, #5
c0d036ec:	428b      	cmp	r3, r1
c0d036ee:	d301      	bcc.n	c0d036f4 <__aeabi_uidiv+0xc0>
c0d036f0:	014b      	lsls	r3, r1, #5
c0d036f2:	1ac0      	subs	r0, r0, r3
c0d036f4:	4152      	adcs	r2, r2
c0d036f6:	0903      	lsrs	r3, r0, #4
c0d036f8:	428b      	cmp	r3, r1
c0d036fa:	d301      	bcc.n	c0d03700 <__aeabi_uidiv+0xcc>
c0d036fc:	010b      	lsls	r3, r1, #4
c0d036fe:	1ac0      	subs	r0, r0, r3
c0d03700:	4152      	adcs	r2, r2
c0d03702:	08c3      	lsrs	r3, r0, #3
c0d03704:	428b      	cmp	r3, r1
c0d03706:	d301      	bcc.n	c0d0370c <__aeabi_uidiv+0xd8>
c0d03708:	00cb      	lsls	r3, r1, #3
c0d0370a:	1ac0      	subs	r0, r0, r3
c0d0370c:	4152      	adcs	r2, r2
c0d0370e:	0883      	lsrs	r3, r0, #2
c0d03710:	428b      	cmp	r3, r1
c0d03712:	d301      	bcc.n	c0d03718 <__aeabi_uidiv+0xe4>
c0d03714:	008b      	lsls	r3, r1, #2
c0d03716:	1ac0      	subs	r0, r0, r3
c0d03718:	4152      	adcs	r2, r2
c0d0371a:	0843      	lsrs	r3, r0, #1
c0d0371c:	428b      	cmp	r3, r1
c0d0371e:	d301      	bcc.n	c0d03724 <__aeabi_uidiv+0xf0>
c0d03720:	004b      	lsls	r3, r1, #1
c0d03722:	1ac0      	subs	r0, r0, r3
c0d03724:	4152      	adcs	r2, r2
c0d03726:	1a41      	subs	r1, r0, r1
c0d03728:	d200      	bcs.n	c0d0372c <__aeabi_uidiv+0xf8>
c0d0372a:	4601      	mov	r1, r0
c0d0372c:	4152      	adcs	r2, r2
c0d0372e:	4610      	mov	r0, r2
c0d03730:	4770      	bx	lr
c0d03732:	e7ff      	b.n	c0d03734 <__aeabi_uidiv+0x100>
c0d03734:	b501      	push	{r0, lr}
c0d03736:	2000      	movs	r0, #0
c0d03738:	f000 f8f0 	bl	c0d0391c <__aeabi_idiv0>
c0d0373c:	bd02      	pop	{r1, pc}
c0d0373e:	46c0      	nop			; (mov r8, r8)

c0d03740 <__aeabi_uidivmod>:
c0d03740:	2900      	cmp	r1, #0
c0d03742:	d0f7      	beq.n	c0d03734 <__aeabi_uidiv+0x100>
c0d03744:	e776      	b.n	c0d03634 <__aeabi_uidiv>
c0d03746:	4770      	bx	lr

c0d03748 <__aeabi_idiv>:
c0d03748:	4603      	mov	r3, r0
c0d0374a:	430b      	orrs	r3, r1
c0d0374c:	d47f      	bmi.n	c0d0384e <__aeabi_idiv+0x106>
c0d0374e:	2200      	movs	r2, #0
c0d03750:	0843      	lsrs	r3, r0, #1
c0d03752:	428b      	cmp	r3, r1
c0d03754:	d374      	bcc.n	c0d03840 <__aeabi_idiv+0xf8>
c0d03756:	0903      	lsrs	r3, r0, #4
c0d03758:	428b      	cmp	r3, r1
c0d0375a:	d35f      	bcc.n	c0d0381c <__aeabi_idiv+0xd4>
c0d0375c:	0a03      	lsrs	r3, r0, #8
c0d0375e:	428b      	cmp	r3, r1
c0d03760:	d344      	bcc.n	c0d037ec <__aeabi_idiv+0xa4>
c0d03762:	0b03      	lsrs	r3, r0, #12
c0d03764:	428b      	cmp	r3, r1
c0d03766:	d328      	bcc.n	c0d037ba <__aeabi_idiv+0x72>
c0d03768:	0c03      	lsrs	r3, r0, #16
c0d0376a:	428b      	cmp	r3, r1
c0d0376c:	d30d      	bcc.n	c0d0378a <__aeabi_idiv+0x42>
c0d0376e:	22ff      	movs	r2, #255	; 0xff
c0d03770:	0209      	lsls	r1, r1, #8
c0d03772:	ba12      	rev	r2, r2
c0d03774:	0c03      	lsrs	r3, r0, #16
c0d03776:	428b      	cmp	r3, r1
c0d03778:	d302      	bcc.n	c0d03780 <__aeabi_idiv+0x38>
c0d0377a:	1212      	asrs	r2, r2, #8
c0d0377c:	0209      	lsls	r1, r1, #8
c0d0377e:	d065      	beq.n	c0d0384c <__aeabi_idiv+0x104>
c0d03780:	0b03      	lsrs	r3, r0, #12
c0d03782:	428b      	cmp	r3, r1
c0d03784:	d319      	bcc.n	c0d037ba <__aeabi_idiv+0x72>
c0d03786:	e000      	b.n	c0d0378a <__aeabi_idiv+0x42>
c0d03788:	0a09      	lsrs	r1, r1, #8
c0d0378a:	0bc3      	lsrs	r3, r0, #15
c0d0378c:	428b      	cmp	r3, r1
c0d0378e:	d301      	bcc.n	c0d03794 <__aeabi_idiv+0x4c>
c0d03790:	03cb      	lsls	r3, r1, #15
c0d03792:	1ac0      	subs	r0, r0, r3
c0d03794:	4152      	adcs	r2, r2
c0d03796:	0b83      	lsrs	r3, r0, #14
c0d03798:	428b      	cmp	r3, r1
c0d0379a:	d301      	bcc.n	c0d037a0 <__aeabi_idiv+0x58>
c0d0379c:	038b      	lsls	r3, r1, #14
c0d0379e:	1ac0      	subs	r0, r0, r3
c0d037a0:	4152      	adcs	r2, r2
c0d037a2:	0b43      	lsrs	r3, r0, #13
c0d037a4:	428b      	cmp	r3, r1
c0d037a6:	d301      	bcc.n	c0d037ac <__aeabi_idiv+0x64>
c0d037a8:	034b      	lsls	r3, r1, #13
c0d037aa:	1ac0      	subs	r0, r0, r3
c0d037ac:	4152      	adcs	r2, r2
c0d037ae:	0b03      	lsrs	r3, r0, #12
c0d037b0:	428b      	cmp	r3, r1
c0d037b2:	d301      	bcc.n	c0d037b8 <__aeabi_idiv+0x70>
c0d037b4:	030b      	lsls	r3, r1, #12
c0d037b6:	1ac0      	subs	r0, r0, r3
c0d037b8:	4152      	adcs	r2, r2
c0d037ba:	0ac3      	lsrs	r3, r0, #11
c0d037bc:	428b      	cmp	r3, r1
c0d037be:	d301      	bcc.n	c0d037c4 <__aeabi_idiv+0x7c>
c0d037c0:	02cb      	lsls	r3, r1, #11
c0d037c2:	1ac0      	subs	r0, r0, r3
c0d037c4:	4152      	adcs	r2, r2
c0d037c6:	0a83      	lsrs	r3, r0, #10
c0d037c8:	428b      	cmp	r3, r1
c0d037ca:	d301      	bcc.n	c0d037d0 <__aeabi_idiv+0x88>
c0d037cc:	028b      	lsls	r3, r1, #10
c0d037ce:	1ac0      	subs	r0, r0, r3
c0d037d0:	4152      	adcs	r2, r2
c0d037d2:	0a43      	lsrs	r3, r0, #9
c0d037d4:	428b      	cmp	r3, r1
c0d037d6:	d301      	bcc.n	c0d037dc <__aeabi_idiv+0x94>
c0d037d8:	024b      	lsls	r3, r1, #9
c0d037da:	1ac0      	subs	r0, r0, r3
c0d037dc:	4152      	adcs	r2, r2
c0d037de:	0a03      	lsrs	r3, r0, #8
c0d037e0:	428b      	cmp	r3, r1
c0d037e2:	d301      	bcc.n	c0d037e8 <__aeabi_idiv+0xa0>
c0d037e4:	020b      	lsls	r3, r1, #8
c0d037e6:	1ac0      	subs	r0, r0, r3
c0d037e8:	4152      	adcs	r2, r2
c0d037ea:	d2cd      	bcs.n	c0d03788 <__aeabi_idiv+0x40>
c0d037ec:	09c3      	lsrs	r3, r0, #7
c0d037ee:	428b      	cmp	r3, r1
c0d037f0:	d301      	bcc.n	c0d037f6 <__aeabi_idiv+0xae>
c0d037f2:	01cb      	lsls	r3, r1, #7
c0d037f4:	1ac0      	subs	r0, r0, r3
c0d037f6:	4152      	adcs	r2, r2
c0d037f8:	0983      	lsrs	r3, r0, #6
c0d037fa:	428b      	cmp	r3, r1
c0d037fc:	d301      	bcc.n	c0d03802 <__aeabi_idiv+0xba>
c0d037fe:	018b      	lsls	r3, r1, #6
c0d03800:	1ac0      	subs	r0, r0, r3
c0d03802:	4152      	adcs	r2, r2
c0d03804:	0943      	lsrs	r3, r0, #5
c0d03806:	428b      	cmp	r3, r1
c0d03808:	d301      	bcc.n	c0d0380e <__aeabi_idiv+0xc6>
c0d0380a:	014b      	lsls	r3, r1, #5
c0d0380c:	1ac0      	subs	r0, r0, r3
c0d0380e:	4152      	adcs	r2, r2
c0d03810:	0903      	lsrs	r3, r0, #4
c0d03812:	428b      	cmp	r3, r1
c0d03814:	d301      	bcc.n	c0d0381a <__aeabi_idiv+0xd2>
c0d03816:	010b      	lsls	r3, r1, #4
c0d03818:	1ac0      	subs	r0, r0, r3
c0d0381a:	4152      	adcs	r2, r2
c0d0381c:	08c3      	lsrs	r3, r0, #3
c0d0381e:	428b      	cmp	r3, r1
c0d03820:	d301      	bcc.n	c0d03826 <__aeabi_idiv+0xde>
c0d03822:	00cb      	lsls	r3, r1, #3
c0d03824:	1ac0      	subs	r0, r0, r3
c0d03826:	4152      	adcs	r2, r2
c0d03828:	0883      	lsrs	r3, r0, #2
c0d0382a:	428b      	cmp	r3, r1
c0d0382c:	d301      	bcc.n	c0d03832 <__aeabi_idiv+0xea>
c0d0382e:	008b      	lsls	r3, r1, #2
c0d03830:	1ac0      	subs	r0, r0, r3
c0d03832:	4152      	adcs	r2, r2
c0d03834:	0843      	lsrs	r3, r0, #1
c0d03836:	428b      	cmp	r3, r1
c0d03838:	d301      	bcc.n	c0d0383e <__aeabi_idiv+0xf6>
c0d0383a:	004b      	lsls	r3, r1, #1
c0d0383c:	1ac0      	subs	r0, r0, r3
c0d0383e:	4152      	adcs	r2, r2
c0d03840:	1a41      	subs	r1, r0, r1
c0d03842:	d200      	bcs.n	c0d03846 <__aeabi_idiv+0xfe>
c0d03844:	4601      	mov	r1, r0
c0d03846:	4152      	adcs	r2, r2
c0d03848:	4610      	mov	r0, r2
c0d0384a:	4770      	bx	lr
c0d0384c:	e05d      	b.n	c0d0390a <__aeabi_idiv+0x1c2>
c0d0384e:	0fca      	lsrs	r2, r1, #31
c0d03850:	d000      	beq.n	c0d03854 <__aeabi_idiv+0x10c>
c0d03852:	4249      	negs	r1, r1
c0d03854:	1003      	asrs	r3, r0, #32
c0d03856:	d300      	bcc.n	c0d0385a <__aeabi_idiv+0x112>
c0d03858:	4240      	negs	r0, r0
c0d0385a:	4053      	eors	r3, r2
c0d0385c:	2200      	movs	r2, #0
c0d0385e:	469c      	mov	ip, r3
c0d03860:	0903      	lsrs	r3, r0, #4
c0d03862:	428b      	cmp	r3, r1
c0d03864:	d32d      	bcc.n	c0d038c2 <__aeabi_idiv+0x17a>
c0d03866:	0a03      	lsrs	r3, r0, #8
c0d03868:	428b      	cmp	r3, r1
c0d0386a:	d312      	bcc.n	c0d03892 <__aeabi_idiv+0x14a>
c0d0386c:	22fc      	movs	r2, #252	; 0xfc
c0d0386e:	0189      	lsls	r1, r1, #6
c0d03870:	ba12      	rev	r2, r2
c0d03872:	0a03      	lsrs	r3, r0, #8
c0d03874:	428b      	cmp	r3, r1
c0d03876:	d30c      	bcc.n	c0d03892 <__aeabi_idiv+0x14a>
c0d03878:	0189      	lsls	r1, r1, #6
c0d0387a:	1192      	asrs	r2, r2, #6
c0d0387c:	428b      	cmp	r3, r1
c0d0387e:	d308      	bcc.n	c0d03892 <__aeabi_idiv+0x14a>
c0d03880:	0189      	lsls	r1, r1, #6
c0d03882:	1192      	asrs	r2, r2, #6
c0d03884:	428b      	cmp	r3, r1
c0d03886:	d304      	bcc.n	c0d03892 <__aeabi_idiv+0x14a>
c0d03888:	0189      	lsls	r1, r1, #6
c0d0388a:	d03a      	beq.n	c0d03902 <__aeabi_idiv+0x1ba>
c0d0388c:	1192      	asrs	r2, r2, #6
c0d0388e:	e000      	b.n	c0d03892 <__aeabi_idiv+0x14a>
c0d03890:	0989      	lsrs	r1, r1, #6
c0d03892:	09c3      	lsrs	r3, r0, #7
c0d03894:	428b      	cmp	r3, r1
c0d03896:	d301      	bcc.n	c0d0389c <__aeabi_idiv+0x154>
c0d03898:	01cb      	lsls	r3, r1, #7
c0d0389a:	1ac0      	subs	r0, r0, r3
c0d0389c:	4152      	adcs	r2, r2
c0d0389e:	0983      	lsrs	r3, r0, #6
c0d038a0:	428b      	cmp	r3, r1
c0d038a2:	d301      	bcc.n	c0d038a8 <__aeabi_idiv+0x160>
c0d038a4:	018b      	lsls	r3, r1, #6
c0d038a6:	1ac0      	subs	r0, r0, r3
c0d038a8:	4152      	adcs	r2, r2
c0d038aa:	0943      	lsrs	r3, r0, #5
c0d038ac:	428b      	cmp	r3, r1
c0d038ae:	d301      	bcc.n	c0d038b4 <__aeabi_idiv+0x16c>
c0d038b0:	014b      	lsls	r3, r1, #5
c0d038b2:	1ac0      	subs	r0, r0, r3
c0d038b4:	4152      	adcs	r2, r2
c0d038b6:	0903      	lsrs	r3, r0, #4
c0d038b8:	428b      	cmp	r3, r1
c0d038ba:	d301      	bcc.n	c0d038c0 <__aeabi_idiv+0x178>
c0d038bc:	010b      	lsls	r3, r1, #4
c0d038be:	1ac0      	subs	r0, r0, r3
c0d038c0:	4152      	adcs	r2, r2
c0d038c2:	08c3      	lsrs	r3, r0, #3
c0d038c4:	428b      	cmp	r3, r1
c0d038c6:	d301      	bcc.n	c0d038cc <__aeabi_idiv+0x184>
c0d038c8:	00cb      	lsls	r3, r1, #3
c0d038ca:	1ac0      	subs	r0, r0, r3
c0d038cc:	4152      	adcs	r2, r2
c0d038ce:	0883      	lsrs	r3, r0, #2
c0d038d0:	428b      	cmp	r3, r1
c0d038d2:	d301      	bcc.n	c0d038d8 <__aeabi_idiv+0x190>
c0d038d4:	008b      	lsls	r3, r1, #2
c0d038d6:	1ac0      	subs	r0, r0, r3
c0d038d8:	4152      	adcs	r2, r2
c0d038da:	d2d9      	bcs.n	c0d03890 <__aeabi_idiv+0x148>
c0d038dc:	0843      	lsrs	r3, r0, #1
c0d038de:	428b      	cmp	r3, r1
c0d038e0:	d301      	bcc.n	c0d038e6 <__aeabi_idiv+0x19e>
c0d038e2:	004b      	lsls	r3, r1, #1
c0d038e4:	1ac0      	subs	r0, r0, r3
c0d038e6:	4152      	adcs	r2, r2
c0d038e8:	1a41      	subs	r1, r0, r1
c0d038ea:	d200      	bcs.n	c0d038ee <__aeabi_idiv+0x1a6>
c0d038ec:	4601      	mov	r1, r0
c0d038ee:	4663      	mov	r3, ip
c0d038f0:	4152      	adcs	r2, r2
c0d038f2:	105b      	asrs	r3, r3, #1
c0d038f4:	4610      	mov	r0, r2
c0d038f6:	d301      	bcc.n	c0d038fc <__aeabi_idiv+0x1b4>
c0d038f8:	4240      	negs	r0, r0
c0d038fa:	2b00      	cmp	r3, #0
c0d038fc:	d500      	bpl.n	c0d03900 <__aeabi_idiv+0x1b8>
c0d038fe:	4249      	negs	r1, r1
c0d03900:	4770      	bx	lr
c0d03902:	4663      	mov	r3, ip
c0d03904:	105b      	asrs	r3, r3, #1
c0d03906:	d300      	bcc.n	c0d0390a <__aeabi_idiv+0x1c2>
c0d03908:	4240      	negs	r0, r0
c0d0390a:	b501      	push	{r0, lr}
c0d0390c:	2000      	movs	r0, #0
c0d0390e:	f000 f805 	bl	c0d0391c <__aeabi_idiv0>
c0d03912:	bd02      	pop	{r1, pc}

c0d03914 <__aeabi_idivmod>:
c0d03914:	2900      	cmp	r1, #0
c0d03916:	d0f8      	beq.n	c0d0390a <__aeabi_idiv+0x1c2>
c0d03918:	e716      	b.n	c0d03748 <__aeabi_idiv>
c0d0391a:	4770      	bx	lr

c0d0391c <__aeabi_idiv0>:
c0d0391c:	4770      	bx	lr
c0d0391e:	46c0      	nop			; (mov r8, r8)

c0d03920 <__aeabi_uldivmod>:
c0d03920:	2b00      	cmp	r3, #0
c0d03922:	d111      	bne.n	c0d03948 <__aeabi_uldivmod+0x28>
c0d03924:	2a00      	cmp	r2, #0
c0d03926:	d10f      	bne.n	c0d03948 <__aeabi_uldivmod+0x28>
c0d03928:	2900      	cmp	r1, #0
c0d0392a:	d100      	bne.n	c0d0392e <__aeabi_uldivmod+0xe>
c0d0392c:	2800      	cmp	r0, #0
c0d0392e:	d002      	beq.n	c0d03936 <__aeabi_uldivmod+0x16>
c0d03930:	2100      	movs	r1, #0
c0d03932:	43c9      	mvns	r1, r1
c0d03934:	1c08      	adds	r0, r1, #0
c0d03936:	b407      	push	{r0, r1, r2}
c0d03938:	4802      	ldr	r0, [pc, #8]	; (c0d03944 <__aeabi_uldivmod+0x24>)
c0d0393a:	a102      	add	r1, pc, #8	; (adr r1, c0d03944 <__aeabi_uldivmod+0x24>)
c0d0393c:	1840      	adds	r0, r0, r1
c0d0393e:	9002      	str	r0, [sp, #8]
c0d03940:	bd03      	pop	{r0, r1, pc}
c0d03942:	46c0      	nop			; (mov r8, r8)
c0d03944:	ffffffd9 	.word	0xffffffd9
c0d03948:	b403      	push	{r0, r1}
c0d0394a:	4668      	mov	r0, sp
c0d0394c:	b501      	push	{r0, lr}
c0d0394e:	9802      	ldr	r0, [sp, #8]
c0d03950:	f000 f832 	bl	c0d039b8 <__udivmoddi4>
c0d03954:	9b01      	ldr	r3, [sp, #4]
c0d03956:	469e      	mov	lr, r3
c0d03958:	b002      	add	sp, #8
c0d0395a:	bc0c      	pop	{r2, r3}
c0d0395c:	4770      	bx	lr
c0d0395e:	46c0      	nop			; (mov r8, r8)

c0d03960 <__aeabi_lmul>:
c0d03960:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03962:	464f      	mov	r7, r9
c0d03964:	4646      	mov	r6, r8
c0d03966:	b4c0      	push	{r6, r7}
c0d03968:	0416      	lsls	r6, r2, #16
c0d0396a:	0c36      	lsrs	r6, r6, #16
c0d0396c:	4699      	mov	r9, r3
c0d0396e:	0033      	movs	r3, r6
c0d03970:	0405      	lsls	r5, r0, #16
c0d03972:	0c2c      	lsrs	r4, r5, #16
c0d03974:	0c07      	lsrs	r7, r0, #16
c0d03976:	0c15      	lsrs	r5, r2, #16
c0d03978:	4363      	muls	r3, r4
c0d0397a:	437e      	muls	r6, r7
c0d0397c:	436f      	muls	r7, r5
c0d0397e:	4365      	muls	r5, r4
c0d03980:	0c1c      	lsrs	r4, r3, #16
c0d03982:	19ad      	adds	r5, r5, r6
c0d03984:	1964      	adds	r4, r4, r5
c0d03986:	469c      	mov	ip, r3
c0d03988:	42a6      	cmp	r6, r4
c0d0398a:	d903      	bls.n	c0d03994 <__aeabi_lmul+0x34>
c0d0398c:	2380      	movs	r3, #128	; 0x80
c0d0398e:	025b      	lsls	r3, r3, #9
c0d03990:	4698      	mov	r8, r3
c0d03992:	4447      	add	r7, r8
c0d03994:	4663      	mov	r3, ip
c0d03996:	0c25      	lsrs	r5, r4, #16
c0d03998:	19ef      	adds	r7, r5, r7
c0d0399a:	041d      	lsls	r5, r3, #16
c0d0399c:	464b      	mov	r3, r9
c0d0399e:	434a      	muls	r2, r1
c0d039a0:	4343      	muls	r3, r0
c0d039a2:	0c2d      	lsrs	r5, r5, #16
c0d039a4:	0424      	lsls	r4, r4, #16
c0d039a6:	1964      	adds	r4, r4, r5
c0d039a8:	1899      	adds	r1, r3, r2
c0d039aa:	19c9      	adds	r1, r1, r7
c0d039ac:	0020      	movs	r0, r4
c0d039ae:	bc0c      	pop	{r2, r3}
c0d039b0:	4690      	mov	r8, r2
c0d039b2:	4699      	mov	r9, r3
c0d039b4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d039b6:	46c0      	nop			; (mov r8, r8)

c0d039b8 <__udivmoddi4>:
c0d039b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d039ba:	464d      	mov	r5, r9
c0d039bc:	4656      	mov	r6, sl
c0d039be:	4644      	mov	r4, r8
c0d039c0:	465f      	mov	r7, fp
c0d039c2:	b4f0      	push	{r4, r5, r6, r7}
c0d039c4:	4692      	mov	sl, r2
c0d039c6:	b083      	sub	sp, #12
c0d039c8:	0004      	movs	r4, r0
c0d039ca:	000d      	movs	r5, r1
c0d039cc:	4699      	mov	r9, r3
c0d039ce:	428b      	cmp	r3, r1
c0d039d0:	d82f      	bhi.n	c0d03a32 <__udivmoddi4+0x7a>
c0d039d2:	d02c      	beq.n	c0d03a2e <__udivmoddi4+0x76>
c0d039d4:	4649      	mov	r1, r9
c0d039d6:	4650      	mov	r0, sl
c0d039d8:	f000 f8ae 	bl	c0d03b38 <__clzdi2>
c0d039dc:	0029      	movs	r1, r5
c0d039de:	0006      	movs	r6, r0
c0d039e0:	0020      	movs	r0, r4
c0d039e2:	f000 f8a9 	bl	c0d03b38 <__clzdi2>
c0d039e6:	1a33      	subs	r3, r6, r0
c0d039e8:	4698      	mov	r8, r3
c0d039ea:	3b20      	subs	r3, #32
c0d039ec:	469b      	mov	fp, r3
c0d039ee:	d500      	bpl.n	c0d039f2 <__udivmoddi4+0x3a>
c0d039f0:	e074      	b.n	c0d03adc <__udivmoddi4+0x124>
c0d039f2:	4653      	mov	r3, sl
c0d039f4:	465a      	mov	r2, fp
c0d039f6:	4093      	lsls	r3, r2
c0d039f8:	001f      	movs	r7, r3
c0d039fa:	4653      	mov	r3, sl
c0d039fc:	4642      	mov	r2, r8
c0d039fe:	4093      	lsls	r3, r2
c0d03a00:	001e      	movs	r6, r3
c0d03a02:	42af      	cmp	r7, r5
c0d03a04:	d829      	bhi.n	c0d03a5a <__udivmoddi4+0xa2>
c0d03a06:	d026      	beq.n	c0d03a56 <__udivmoddi4+0x9e>
c0d03a08:	465b      	mov	r3, fp
c0d03a0a:	1ba4      	subs	r4, r4, r6
c0d03a0c:	41bd      	sbcs	r5, r7
c0d03a0e:	2b00      	cmp	r3, #0
c0d03a10:	da00      	bge.n	c0d03a14 <__udivmoddi4+0x5c>
c0d03a12:	e079      	b.n	c0d03b08 <__udivmoddi4+0x150>
c0d03a14:	2200      	movs	r2, #0
c0d03a16:	2300      	movs	r3, #0
c0d03a18:	9200      	str	r2, [sp, #0]
c0d03a1a:	9301      	str	r3, [sp, #4]
c0d03a1c:	2301      	movs	r3, #1
c0d03a1e:	465a      	mov	r2, fp
c0d03a20:	4093      	lsls	r3, r2
c0d03a22:	9301      	str	r3, [sp, #4]
c0d03a24:	2301      	movs	r3, #1
c0d03a26:	4642      	mov	r2, r8
c0d03a28:	4093      	lsls	r3, r2
c0d03a2a:	9300      	str	r3, [sp, #0]
c0d03a2c:	e019      	b.n	c0d03a62 <__udivmoddi4+0xaa>
c0d03a2e:	4282      	cmp	r2, r0
c0d03a30:	d9d0      	bls.n	c0d039d4 <__udivmoddi4+0x1c>
c0d03a32:	2200      	movs	r2, #0
c0d03a34:	2300      	movs	r3, #0
c0d03a36:	9200      	str	r2, [sp, #0]
c0d03a38:	9301      	str	r3, [sp, #4]
c0d03a3a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d03a3c:	2b00      	cmp	r3, #0
c0d03a3e:	d001      	beq.n	c0d03a44 <__udivmoddi4+0x8c>
c0d03a40:	601c      	str	r4, [r3, #0]
c0d03a42:	605d      	str	r5, [r3, #4]
c0d03a44:	9800      	ldr	r0, [sp, #0]
c0d03a46:	9901      	ldr	r1, [sp, #4]
c0d03a48:	b003      	add	sp, #12
c0d03a4a:	bc3c      	pop	{r2, r3, r4, r5}
c0d03a4c:	4690      	mov	r8, r2
c0d03a4e:	4699      	mov	r9, r3
c0d03a50:	46a2      	mov	sl, r4
c0d03a52:	46ab      	mov	fp, r5
c0d03a54:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03a56:	42a3      	cmp	r3, r4
c0d03a58:	d9d6      	bls.n	c0d03a08 <__udivmoddi4+0x50>
c0d03a5a:	2200      	movs	r2, #0
c0d03a5c:	2300      	movs	r3, #0
c0d03a5e:	9200      	str	r2, [sp, #0]
c0d03a60:	9301      	str	r3, [sp, #4]
c0d03a62:	4643      	mov	r3, r8
c0d03a64:	2b00      	cmp	r3, #0
c0d03a66:	d0e8      	beq.n	c0d03a3a <__udivmoddi4+0x82>
c0d03a68:	07fb      	lsls	r3, r7, #31
c0d03a6a:	0872      	lsrs	r2, r6, #1
c0d03a6c:	431a      	orrs	r2, r3
c0d03a6e:	4646      	mov	r6, r8
c0d03a70:	087b      	lsrs	r3, r7, #1
c0d03a72:	e00e      	b.n	c0d03a92 <__udivmoddi4+0xda>
c0d03a74:	42ab      	cmp	r3, r5
c0d03a76:	d101      	bne.n	c0d03a7c <__udivmoddi4+0xc4>
c0d03a78:	42a2      	cmp	r2, r4
c0d03a7a:	d80c      	bhi.n	c0d03a96 <__udivmoddi4+0xde>
c0d03a7c:	1aa4      	subs	r4, r4, r2
c0d03a7e:	419d      	sbcs	r5, r3
c0d03a80:	2001      	movs	r0, #1
c0d03a82:	1924      	adds	r4, r4, r4
c0d03a84:	416d      	adcs	r5, r5
c0d03a86:	2100      	movs	r1, #0
c0d03a88:	3e01      	subs	r6, #1
c0d03a8a:	1824      	adds	r4, r4, r0
c0d03a8c:	414d      	adcs	r5, r1
c0d03a8e:	2e00      	cmp	r6, #0
c0d03a90:	d006      	beq.n	c0d03aa0 <__udivmoddi4+0xe8>
c0d03a92:	42ab      	cmp	r3, r5
c0d03a94:	d9ee      	bls.n	c0d03a74 <__udivmoddi4+0xbc>
c0d03a96:	3e01      	subs	r6, #1
c0d03a98:	1924      	adds	r4, r4, r4
c0d03a9a:	416d      	adcs	r5, r5
c0d03a9c:	2e00      	cmp	r6, #0
c0d03a9e:	d1f8      	bne.n	c0d03a92 <__udivmoddi4+0xda>
c0d03aa0:	465b      	mov	r3, fp
c0d03aa2:	9800      	ldr	r0, [sp, #0]
c0d03aa4:	9901      	ldr	r1, [sp, #4]
c0d03aa6:	1900      	adds	r0, r0, r4
c0d03aa8:	4169      	adcs	r1, r5
c0d03aaa:	2b00      	cmp	r3, #0
c0d03aac:	db22      	blt.n	c0d03af4 <__udivmoddi4+0x13c>
c0d03aae:	002b      	movs	r3, r5
c0d03ab0:	465a      	mov	r2, fp
c0d03ab2:	40d3      	lsrs	r3, r2
c0d03ab4:	002a      	movs	r2, r5
c0d03ab6:	4644      	mov	r4, r8
c0d03ab8:	40e2      	lsrs	r2, r4
c0d03aba:	001c      	movs	r4, r3
c0d03abc:	465b      	mov	r3, fp
c0d03abe:	0015      	movs	r5, r2
c0d03ac0:	2b00      	cmp	r3, #0
c0d03ac2:	db2c      	blt.n	c0d03b1e <__udivmoddi4+0x166>
c0d03ac4:	0026      	movs	r6, r4
c0d03ac6:	409e      	lsls	r6, r3
c0d03ac8:	0033      	movs	r3, r6
c0d03aca:	0026      	movs	r6, r4
c0d03acc:	4647      	mov	r7, r8
c0d03ace:	40be      	lsls	r6, r7
c0d03ad0:	0032      	movs	r2, r6
c0d03ad2:	1a80      	subs	r0, r0, r2
c0d03ad4:	4199      	sbcs	r1, r3
c0d03ad6:	9000      	str	r0, [sp, #0]
c0d03ad8:	9101      	str	r1, [sp, #4]
c0d03ada:	e7ae      	b.n	c0d03a3a <__udivmoddi4+0x82>
c0d03adc:	4642      	mov	r2, r8
c0d03ade:	2320      	movs	r3, #32
c0d03ae0:	1a9b      	subs	r3, r3, r2
c0d03ae2:	4652      	mov	r2, sl
c0d03ae4:	40da      	lsrs	r2, r3
c0d03ae6:	4641      	mov	r1, r8
c0d03ae8:	0013      	movs	r3, r2
c0d03aea:	464a      	mov	r2, r9
c0d03aec:	408a      	lsls	r2, r1
c0d03aee:	0017      	movs	r7, r2
c0d03af0:	431f      	orrs	r7, r3
c0d03af2:	e782      	b.n	c0d039fa <__udivmoddi4+0x42>
c0d03af4:	4642      	mov	r2, r8
c0d03af6:	2320      	movs	r3, #32
c0d03af8:	1a9b      	subs	r3, r3, r2
c0d03afa:	002a      	movs	r2, r5
c0d03afc:	4646      	mov	r6, r8
c0d03afe:	409a      	lsls	r2, r3
c0d03b00:	0023      	movs	r3, r4
c0d03b02:	40f3      	lsrs	r3, r6
c0d03b04:	4313      	orrs	r3, r2
c0d03b06:	e7d5      	b.n	c0d03ab4 <__udivmoddi4+0xfc>
c0d03b08:	4642      	mov	r2, r8
c0d03b0a:	2320      	movs	r3, #32
c0d03b0c:	2100      	movs	r1, #0
c0d03b0e:	1a9b      	subs	r3, r3, r2
c0d03b10:	2200      	movs	r2, #0
c0d03b12:	9100      	str	r1, [sp, #0]
c0d03b14:	9201      	str	r2, [sp, #4]
c0d03b16:	2201      	movs	r2, #1
c0d03b18:	40da      	lsrs	r2, r3
c0d03b1a:	9201      	str	r2, [sp, #4]
c0d03b1c:	e782      	b.n	c0d03a24 <__udivmoddi4+0x6c>
c0d03b1e:	4642      	mov	r2, r8
c0d03b20:	2320      	movs	r3, #32
c0d03b22:	0026      	movs	r6, r4
c0d03b24:	1a9b      	subs	r3, r3, r2
c0d03b26:	40de      	lsrs	r6, r3
c0d03b28:	002f      	movs	r7, r5
c0d03b2a:	46b4      	mov	ip, r6
c0d03b2c:	4097      	lsls	r7, r2
c0d03b2e:	4666      	mov	r6, ip
c0d03b30:	003b      	movs	r3, r7
c0d03b32:	4333      	orrs	r3, r6
c0d03b34:	e7c9      	b.n	c0d03aca <__udivmoddi4+0x112>
c0d03b36:	46c0      	nop			; (mov r8, r8)

c0d03b38 <__clzdi2>:
c0d03b38:	b510      	push	{r4, lr}
c0d03b3a:	2900      	cmp	r1, #0
c0d03b3c:	d103      	bne.n	c0d03b46 <__clzdi2+0xe>
c0d03b3e:	f000 f807 	bl	c0d03b50 <__clzsi2>
c0d03b42:	3020      	adds	r0, #32
c0d03b44:	e002      	b.n	c0d03b4c <__clzdi2+0x14>
c0d03b46:	1c08      	adds	r0, r1, #0
c0d03b48:	f000 f802 	bl	c0d03b50 <__clzsi2>
c0d03b4c:	bd10      	pop	{r4, pc}
c0d03b4e:	46c0      	nop			; (mov r8, r8)

c0d03b50 <__clzsi2>:
c0d03b50:	211c      	movs	r1, #28
c0d03b52:	2301      	movs	r3, #1
c0d03b54:	041b      	lsls	r3, r3, #16
c0d03b56:	4298      	cmp	r0, r3
c0d03b58:	d301      	bcc.n	c0d03b5e <__clzsi2+0xe>
c0d03b5a:	0c00      	lsrs	r0, r0, #16
c0d03b5c:	3910      	subs	r1, #16
c0d03b5e:	0a1b      	lsrs	r3, r3, #8
c0d03b60:	4298      	cmp	r0, r3
c0d03b62:	d301      	bcc.n	c0d03b68 <__clzsi2+0x18>
c0d03b64:	0a00      	lsrs	r0, r0, #8
c0d03b66:	3908      	subs	r1, #8
c0d03b68:	091b      	lsrs	r3, r3, #4
c0d03b6a:	4298      	cmp	r0, r3
c0d03b6c:	d301      	bcc.n	c0d03b72 <__clzsi2+0x22>
c0d03b6e:	0900      	lsrs	r0, r0, #4
c0d03b70:	3904      	subs	r1, #4
c0d03b72:	a202      	add	r2, pc, #8	; (adr r2, c0d03b7c <__clzsi2+0x2c>)
c0d03b74:	5c10      	ldrb	r0, [r2, r0]
c0d03b76:	1840      	adds	r0, r0, r1
c0d03b78:	4770      	bx	lr
c0d03b7a:	46c0      	nop			; (mov r8, r8)
c0d03b7c:	02020304 	.word	0x02020304
c0d03b80:	01010101 	.word	0x01010101
	...

c0d03b8c <__aeabi_memclr>:
c0d03b8c:	b510      	push	{r4, lr}
c0d03b8e:	2200      	movs	r2, #0
c0d03b90:	f000 f806 	bl	c0d03ba0 <__aeabi_memset>
c0d03b94:	bd10      	pop	{r4, pc}
c0d03b96:	46c0      	nop			; (mov r8, r8)

c0d03b98 <__aeabi_memcpy>:
c0d03b98:	b510      	push	{r4, lr}
c0d03b9a:	f000 f809 	bl	c0d03bb0 <memcpy>
c0d03b9e:	bd10      	pop	{r4, pc}

c0d03ba0 <__aeabi_memset>:
c0d03ba0:	0013      	movs	r3, r2
c0d03ba2:	b510      	push	{r4, lr}
c0d03ba4:	000a      	movs	r2, r1
c0d03ba6:	0019      	movs	r1, r3
c0d03ba8:	f000 f840 	bl	c0d03c2c <memset>
c0d03bac:	bd10      	pop	{r4, pc}
c0d03bae:	46c0      	nop			; (mov r8, r8)

c0d03bb0 <memcpy>:
c0d03bb0:	b570      	push	{r4, r5, r6, lr}
c0d03bb2:	2a0f      	cmp	r2, #15
c0d03bb4:	d932      	bls.n	c0d03c1c <memcpy+0x6c>
c0d03bb6:	000c      	movs	r4, r1
c0d03bb8:	4304      	orrs	r4, r0
c0d03bba:	000b      	movs	r3, r1
c0d03bbc:	07a4      	lsls	r4, r4, #30
c0d03bbe:	d131      	bne.n	c0d03c24 <memcpy+0x74>
c0d03bc0:	0015      	movs	r5, r2
c0d03bc2:	0004      	movs	r4, r0
c0d03bc4:	3d10      	subs	r5, #16
c0d03bc6:	092d      	lsrs	r5, r5, #4
c0d03bc8:	3501      	adds	r5, #1
c0d03bca:	012d      	lsls	r5, r5, #4
c0d03bcc:	1949      	adds	r1, r1, r5
c0d03bce:	681e      	ldr	r6, [r3, #0]
c0d03bd0:	6026      	str	r6, [r4, #0]
c0d03bd2:	685e      	ldr	r6, [r3, #4]
c0d03bd4:	6066      	str	r6, [r4, #4]
c0d03bd6:	689e      	ldr	r6, [r3, #8]
c0d03bd8:	60a6      	str	r6, [r4, #8]
c0d03bda:	68de      	ldr	r6, [r3, #12]
c0d03bdc:	3310      	adds	r3, #16
c0d03bde:	60e6      	str	r6, [r4, #12]
c0d03be0:	3410      	adds	r4, #16
c0d03be2:	4299      	cmp	r1, r3
c0d03be4:	d1f3      	bne.n	c0d03bce <memcpy+0x1e>
c0d03be6:	230f      	movs	r3, #15
c0d03be8:	1945      	adds	r5, r0, r5
c0d03bea:	4013      	ands	r3, r2
c0d03bec:	2b03      	cmp	r3, #3
c0d03bee:	d91b      	bls.n	c0d03c28 <memcpy+0x78>
c0d03bf0:	1f1c      	subs	r4, r3, #4
c0d03bf2:	2300      	movs	r3, #0
c0d03bf4:	08a4      	lsrs	r4, r4, #2
c0d03bf6:	3401      	adds	r4, #1
c0d03bf8:	00a4      	lsls	r4, r4, #2
c0d03bfa:	58ce      	ldr	r6, [r1, r3]
c0d03bfc:	50ee      	str	r6, [r5, r3]
c0d03bfe:	3304      	adds	r3, #4
c0d03c00:	429c      	cmp	r4, r3
c0d03c02:	d1fa      	bne.n	c0d03bfa <memcpy+0x4a>
c0d03c04:	2303      	movs	r3, #3
c0d03c06:	192d      	adds	r5, r5, r4
c0d03c08:	1909      	adds	r1, r1, r4
c0d03c0a:	401a      	ands	r2, r3
c0d03c0c:	d005      	beq.n	c0d03c1a <memcpy+0x6a>
c0d03c0e:	2300      	movs	r3, #0
c0d03c10:	5ccc      	ldrb	r4, [r1, r3]
c0d03c12:	54ec      	strb	r4, [r5, r3]
c0d03c14:	3301      	adds	r3, #1
c0d03c16:	429a      	cmp	r2, r3
c0d03c18:	d1fa      	bne.n	c0d03c10 <memcpy+0x60>
c0d03c1a:	bd70      	pop	{r4, r5, r6, pc}
c0d03c1c:	0005      	movs	r5, r0
c0d03c1e:	2a00      	cmp	r2, #0
c0d03c20:	d1f5      	bne.n	c0d03c0e <memcpy+0x5e>
c0d03c22:	e7fa      	b.n	c0d03c1a <memcpy+0x6a>
c0d03c24:	0005      	movs	r5, r0
c0d03c26:	e7f2      	b.n	c0d03c0e <memcpy+0x5e>
c0d03c28:	001a      	movs	r2, r3
c0d03c2a:	e7f8      	b.n	c0d03c1e <memcpy+0x6e>

c0d03c2c <memset>:
c0d03c2c:	b570      	push	{r4, r5, r6, lr}
c0d03c2e:	0783      	lsls	r3, r0, #30
c0d03c30:	d03f      	beq.n	c0d03cb2 <memset+0x86>
c0d03c32:	1e54      	subs	r4, r2, #1
c0d03c34:	2a00      	cmp	r2, #0
c0d03c36:	d03b      	beq.n	c0d03cb0 <memset+0x84>
c0d03c38:	b2ce      	uxtb	r6, r1
c0d03c3a:	0003      	movs	r3, r0
c0d03c3c:	2503      	movs	r5, #3
c0d03c3e:	e003      	b.n	c0d03c48 <memset+0x1c>
c0d03c40:	1e62      	subs	r2, r4, #1
c0d03c42:	2c00      	cmp	r4, #0
c0d03c44:	d034      	beq.n	c0d03cb0 <memset+0x84>
c0d03c46:	0014      	movs	r4, r2
c0d03c48:	3301      	adds	r3, #1
c0d03c4a:	1e5a      	subs	r2, r3, #1
c0d03c4c:	7016      	strb	r6, [r2, #0]
c0d03c4e:	422b      	tst	r3, r5
c0d03c50:	d1f6      	bne.n	c0d03c40 <memset+0x14>
c0d03c52:	2c03      	cmp	r4, #3
c0d03c54:	d924      	bls.n	c0d03ca0 <memset+0x74>
c0d03c56:	25ff      	movs	r5, #255	; 0xff
c0d03c58:	400d      	ands	r5, r1
c0d03c5a:	022a      	lsls	r2, r5, #8
c0d03c5c:	4315      	orrs	r5, r2
c0d03c5e:	042a      	lsls	r2, r5, #16
c0d03c60:	4315      	orrs	r5, r2
c0d03c62:	2c0f      	cmp	r4, #15
c0d03c64:	d911      	bls.n	c0d03c8a <memset+0x5e>
c0d03c66:	0026      	movs	r6, r4
c0d03c68:	3e10      	subs	r6, #16
c0d03c6a:	0936      	lsrs	r6, r6, #4
c0d03c6c:	3601      	adds	r6, #1
c0d03c6e:	0136      	lsls	r6, r6, #4
c0d03c70:	001a      	movs	r2, r3
c0d03c72:	199b      	adds	r3, r3, r6
c0d03c74:	6015      	str	r5, [r2, #0]
c0d03c76:	6055      	str	r5, [r2, #4]
c0d03c78:	6095      	str	r5, [r2, #8]
c0d03c7a:	60d5      	str	r5, [r2, #12]
c0d03c7c:	3210      	adds	r2, #16
c0d03c7e:	4293      	cmp	r3, r2
c0d03c80:	d1f8      	bne.n	c0d03c74 <memset+0x48>
c0d03c82:	220f      	movs	r2, #15
c0d03c84:	4014      	ands	r4, r2
c0d03c86:	2c03      	cmp	r4, #3
c0d03c88:	d90a      	bls.n	c0d03ca0 <memset+0x74>
c0d03c8a:	1f26      	subs	r6, r4, #4
c0d03c8c:	08b6      	lsrs	r6, r6, #2
c0d03c8e:	3601      	adds	r6, #1
c0d03c90:	00b6      	lsls	r6, r6, #2
c0d03c92:	001a      	movs	r2, r3
c0d03c94:	199b      	adds	r3, r3, r6
c0d03c96:	c220      	stmia	r2!, {r5}
c0d03c98:	4293      	cmp	r3, r2
c0d03c9a:	d1fc      	bne.n	c0d03c96 <memset+0x6a>
c0d03c9c:	2203      	movs	r2, #3
c0d03c9e:	4014      	ands	r4, r2
c0d03ca0:	2c00      	cmp	r4, #0
c0d03ca2:	d005      	beq.n	c0d03cb0 <memset+0x84>
c0d03ca4:	b2c9      	uxtb	r1, r1
c0d03ca6:	191c      	adds	r4, r3, r4
c0d03ca8:	7019      	strb	r1, [r3, #0]
c0d03caa:	3301      	adds	r3, #1
c0d03cac:	429c      	cmp	r4, r3
c0d03cae:	d1fb      	bne.n	c0d03ca8 <memset+0x7c>
c0d03cb0:	bd70      	pop	{r4, r5, r6, pc}
c0d03cb2:	0014      	movs	r4, r2
c0d03cb4:	0003      	movs	r3, r0
c0d03cb6:	e7cc      	b.n	c0d03c52 <memset+0x26>

c0d03cb8 <setjmp>:
c0d03cb8:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d03cba:	4641      	mov	r1, r8
c0d03cbc:	464a      	mov	r2, r9
c0d03cbe:	4653      	mov	r3, sl
c0d03cc0:	465c      	mov	r4, fp
c0d03cc2:	466d      	mov	r5, sp
c0d03cc4:	4676      	mov	r6, lr
c0d03cc6:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d03cc8:	3828      	subs	r0, #40	; 0x28
c0d03cca:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03ccc:	2000      	movs	r0, #0
c0d03cce:	4770      	bx	lr

c0d03cd0 <longjmp>:
c0d03cd0:	3010      	adds	r0, #16
c0d03cd2:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03cd4:	4690      	mov	r8, r2
c0d03cd6:	4699      	mov	r9, r3
c0d03cd8:	46a2      	mov	sl, r4
c0d03cda:	46ab      	mov	fp, r5
c0d03cdc:	46b5      	mov	sp, r6
c0d03cde:	c808      	ldmia	r0!, {r3}
c0d03ce0:	3828      	subs	r0, #40	; 0x28
c0d03ce2:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03ce4:	1c08      	adds	r0, r1, #0
c0d03ce6:	d100      	bne.n	c0d03cea <longjmp+0x1a>
c0d03ce8:	2001      	movs	r0, #1
c0d03cea:	4718      	bx	r3

c0d03cec <strlen>:
c0d03cec:	b510      	push	{r4, lr}
c0d03cee:	0783      	lsls	r3, r0, #30
c0d03cf0:	d027      	beq.n	c0d03d42 <strlen+0x56>
c0d03cf2:	7803      	ldrb	r3, [r0, #0]
c0d03cf4:	2b00      	cmp	r3, #0
c0d03cf6:	d026      	beq.n	c0d03d46 <strlen+0x5a>
c0d03cf8:	0003      	movs	r3, r0
c0d03cfa:	2103      	movs	r1, #3
c0d03cfc:	e002      	b.n	c0d03d04 <strlen+0x18>
c0d03cfe:	781a      	ldrb	r2, [r3, #0]
c0d03d00:	2a00      	cmp	r2, #0
c0d03d02:	d01c      	beq.n	c0d03d3e <strlen+0x52>
c0d03d04:	3301      	adds	r3, #1
c0d03d06:	420b      	tst	r3, r1
c0d03d08:	d1f9      	bne.n	c0d03cfe <strlen+0x12>
c0d03d0a:	6819      	ldr	r1, [r3, #0]
c0d03d0c:	4a0f      	ldr	r2, [pc, #60]	; (c0d03d4c <strlen+0x60>)
c0d03d0e:	4c10      	ldr	r4, [pc, #64]	; (c0d03d50 <strlen+0x64>)
c0d03d10:	188a      	adds	r2, r1, r2
c0d03d12:	438a      	bics	r2, r1
c0d03d14:	4222      	tst	r2, r4
c0d03d16:	d10f      	bne.n	c0d03d38 <strlen+0x4c>
c0d03d18:	3304      	adds	r3, #4
c0d03d1a:	6819      	ldr	r1, [r3, #0]
c0d03d1c:	4a0b      	ldr	r2, [pc, #44]	; (c0d03d4c <strlen+0x60>)
c0d03d1e:	188a      	adds	r2, r1, r2
c0d03d20:	438a      	bics	r2, r1
c0d03d22:	4222      	tst	r2, r4
c0d03d24:	d108      	bne.n	c0d03d38 <strlen+0x4c>
c0d03d26:	3304      	adds	r3, #4
c0d03d28:	6819      	ldr	r1, [r3, #0]
c0d03d2a:	4a08      	ldr	r2, [pc, #32]	; (c0d03d4c <strlen+0x60>)
c0d03d2c:	188a      	adds	r2, r1, r2
c0d03d2e:	438a      	bics	r2, r1
c0d03d30:	4222      	tst	r2, r4
c0d03d32:	d0f1      	beq.n	c0d03d18 <strlen+0x2c>
c0d03d34:	e000      	b.n	c0d03d38 <strlen+0x4c>
c0d03d36:	3301      	adds	r3, #1
c0d03d38:	781a      	ldrb	r2, [r3, #0]
c0d03d3a:	2a00      	cmp	r2, #0
c0d03d3c:	d1fb      	bne.n	c0d03d36 <strlen+0x4a>
c0d03d3e:	1a18      	subs	r0, r3, r0
c0d03d40:	bd10      	pop	{r4, pc}
c0d03d42:	0003      	movs	r3, r0
c0d03d44:	e7e1      	b.n	c0d03d0a <strlen+0x1e>
c0d03d46:	2000      	movs	r0, #0
c0d03d48:	e7fa      	b.n	c0d03d40 <strlen+0x54>
c0d03d4a:	46c0      	nop			; (mov r8, r8)
c0d03d4c:	fefefeff 	.word	0xfefefeff
c0d03d50:	80808080 	.word	0x80808080
c0d03d54:	45544550 	.word	0x45544550
c0d03d58:	54455052 	.word	0x54455052
c0d03d5c:	45505245 	.word	0x45505245
c0d03d60:	50524554 	.word	0x50524554
c0d03d64:	52455445 	.word	0x52455445
c0d03d68:	45544550 	.word	0x45544550
c0d03d6c:	54455052 	.word	0x54455052
c0d03d70:	45505245 	.word	0x45505245
c0d03d74:	50524554 	.word	0x50524554
c0d03d78:	52455445 	.word	0x52455445
c0d03d7c:	45544550 	.word	0x45544550
c0d03d80:	54455052 	.word	0x54455052
c0d03d84:	45505245 	.word	0x45505245
c0d03d88:	50524554 	.word	0x50524554
c0d03d8c:	52455445 	.word	0x52455445
c0d03d90:	45544550 	.word	0x45544550
c0d03d94:	54455052 	.word	0x54455052
c0d03d98:	45505245 	.word	0x45505245
c0d03d9c:	50524554 	.word	0x50524554
c0d03da0:	52455445 	.word	0x52455445
c0d03da4:	00000052 	.word	0x00000052

c0d03da8 <trits_mapping>:
c0d03da8:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d03db8:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d03dc8:	00ff0100 000000ff 00010000 0001ff00     ................
c0d03dd8:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d03de8:	00000100 01000101 000101ff 01010101     ................
c0d03df8:	00000001                                ....

c0d03dfc <HALF_3_u>:
c0d03dfc:	a5ce8964 9f007669 1484504f 3ade00d9     d...iv..OP.....:
c0d03e0c:	0c24486e 50979d57 79a4c702 48bbae36     nH$.W..P...y6..H
c0d03e1c:	a9f6808b aa06a805 a87fabdf 5e69ebef     ..............i^

c0d03e2c <bagl_ui_nanos_screen1>:
c0d03e2c:	00000003 00800000 00000020 00000001     ........ .......
c0d03e3c:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03e64:	00000107 0080000c 00000020 00000000     ........ .......
c0d03e74:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03e9c:	00030005 0007000c 00000007 00000000     ................
	...
c0d03eb4:	00070000 00000000 00000000 00000000     ................
	...
c0d03ed4:	00750005 0008000d 00000006 00000000     ..u.............
c0d03ee4:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03f0c <bagl_ui_nanos_screen2>:
c0d03f0c:	00000003 00800000 00000020 00000001     ........ .......
c0d03f1c:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03f44:	00000107 00800012 00000020 00000000     ........ .......
c0d03f54:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03f7c:	00030005 0007000c 00000007 00000000     ................
	...
c0d03f94:	00070000 00000000 00000000 00000000     ................
	...
c0d03fb4:	00750005 0008000d 00000006 00000000     ..u.............
c0d03fc4:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03fec <bagl_ui_sample_blue>:
c0d03fec:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03ffc:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d04024:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d04034:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d0405c:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d0406c:	00ffffff 001d2028 00002004 c0d040cc     ....( ... ...@..
	...
c0d04094:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d040a4:	0041ccb4 00f9f9f9 0000a004 c0d040d8     ..A..........@..
c0d040b4:	00000000 0037ae99 00f9f9f9 c0d02905     ......7......)..
	...
c0d040cc:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d040dd <USBD_PRODUCT_FS_STRING>:
c0d040dd:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d040eb <HID_ReportDesc>:
c0d040eb:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d040fb:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d0410b:	0000c008 11210900                                .....

c0d04110 <USBD_HID_Desc>:
c0d04110:	01112109 22220100 00011200                       .!...."".

c0d04119 <USBD_DeviceDesc>:
c0d04119:	02000112 40000000 00012c97 02010200     .......@.,......
c0d04129:	15000103                                         ...

c0d0412c <HID_Desc>:
c0d0412c:	c0d03515 c0d03525 c0d03535 c0d03545     .5..%5..55..E5..
c0d0413c:	c0d03555 c0d03565 c0d03575 00000000     U5..e5..u5......

c0d0414c <USBD_LangIDDesc>:
c0d0414c:	04090304                                ....

c0d04150 <USBD_MANUFACTURER_STRING>:
c0d04150:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d0415e <USB_SERIAL_STRING>:
c0d0415e:	0030030a 00300030 33f70031                       ..0.0.0.1.

c0d04168 <USBD_HID>:
c0d04168:	c0d033f7 c0d03429 c0d0335b 00000000     .3..)4..[3......
	...
c0d04180:	c0d03461 00000000 00000000 00000000     a4..............
c0d04190:	c0d03585 c0d03585 c0d03585 c0d03595     .5...5...5...5..

c0d041a0 <USBD_CfgDesc>:
c0d041a0:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d041b0:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d041c0:	05070100 00400302 00000001              ......@.....

c0d041cc <USBD_DeviceQualifierDesc>:
c0d041cc:	0200060a 40000000 00000001              .......@....

c0d041d8 <_etext>:
	...

c0d04200 <N_storage_real>:
	...
