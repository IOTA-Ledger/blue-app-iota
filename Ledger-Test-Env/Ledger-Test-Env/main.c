//
//  main.c
//  Ledger-Test-Env
//
//  Created by Tyler Hann on 2018-01-08.
//  Copyright © 2018 Tyler Hann. All rights reserved.
//

#include "main.h"

void print(char *chars) {
    printf("%s\n", chars);
    printf("+++");
}

int main(int argc, const char * argv[]) {
    char chars[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
    char chars2[82];
    tryte_t trytes[81], trytes2[81];
    trit_t trits[243], trits2[243];
    trint_t trints[49], trints2[49];
    uint32_t words[12];
    chars[81] = '\0';
    chars2[81] = '\0';
    
    //chars_to trytes and vice versa work as intended
    //trits to trytes and trytes to trits works
    chars_to_trytes(&chars[0], &trytes[0], 81);
    trytes_to_trits(&trytes[0], &trits[0], 81);
    
    print_243trits(&trits[0]);
    
    //String converted into trits properly
    trits_to_words_u(&trits[0], &words[0]);
    
    words_to_trints_u(&words[0], &trints[0]);
    specific_49trints_to_243trits(&trints[0], &trits2[0]);
    print_243trits(&trits2[0]);
    
    words_to_trits_u(&words[0], &trits2[0]);
    print_243trits(&trits2[0]);
    
    trits_to_trytes(&trits2[0], &trytes2[0], 243);
    trytes_to_chars(&trytes2[0], &chars2[0], 81);
    
    //result should be
//"EUCGRCGLPLOEIBAAQYIUTGJHOCOBDVUHFXQKQLRRANECEXZLEOIIMZZEQNPNTDRVRKJWIMGRQAK9DEWAC"
    print(&chars2[0]);
    return 0;
}
