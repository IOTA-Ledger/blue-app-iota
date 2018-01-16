//
//  word_converter_test.c
//  Ledger-Test-Env
//
//  Created by Tyler Hann on 2018-01-15.
//  Copyright © 2018 Tyler Hann. All rights reserved.
//

#include "word_converter_test.h"

void print(char *chars) {
    printf("%s\n", chars);
}

void test_word_converter(int total) {
    for(int i=0; i < total; i++) {
        char chars[82] =
    "WDIAJYSIPQNMMWMICWHAHMUGJTCCOJWHJLKPOULWTG9TZME9ZCVJNJWNTHESACLGXWPSKGYGVKKCXEBIM\0",
        chars2[82];
        tryte_t trytes[81], trytes2[81];
        trit_t trits[243], trits2[243];
        trint_t trints[49], trints2[49];
        uint32_t words[12];
        chars[81] = '\0';
        chars2[81] = '\0';
        
        //generate random trits
        //gen_trits(&trits[0], 243);
        chars_to_trytes(&chars[0], &trytes[0], 81);
        trytes_to_trits(&trytes[0], &trits[0], 81);
        
        print_243trits(&trits[0]);
        trits_to_trytes(&trits[0], &trytes[0], 243);
        trytes_to_chars(&trytes[0], &chars[0], 81);
        
        //display the generated seed
        printf("-------\n");
        print(&chars[0]);
        
        //convert
        specific_243trits_to_49trints(&trits[0], &trints[0]);
        trints_to_words_u_mem(&trints[0], &words[0]);
        print_words(&words[0], 12);
        words_to_trints_u_mem(&words[0], &trints2[0]);
        specific_49trints_to_243trits(&trints2[0], &trits2[0]);
        trits_to_trytes(&trits2[0], &trytes2[0], 243);
        trytes_to_chars(&trytes2[0], &chars2[0], 81);
        print_243trits(&trits2[0]);
        
        //display converted seed
        print(&chars2[0]);
    }
}
