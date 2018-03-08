#include "main.h"

#include <stdio.h>
#include <stdlib.h>
// iota-related stuff
#include "iota/kerl.h"
#include "iota/conversion.h"
#include "iota/addresses.h"

int print_help();
void address(char* seedChars, int index, int security, char* result);

int main(int argc, char *argv[]){

	if (argc != 5) {
		return print_help();
	}

	int num;
	int security = (int)strtol(argv[2], NULL, 10);
	int index = (int)strtol(argv[3], NULL, 10);
	int count = (int)strtol(argv[4], NULL, 10);
	char* seed_chars = argv[1];

	char addresses[(count*82)];
	addresses[0] = '\0';
	for (int i = 0; i < count; i++) {
		char char_address[81];
		address(seed_chars, index+i, security, char_address);
		strcat(addresses, char_address);
		strcat(addresses, "\n");
	}


	printf("%s", addresses);
	
	return 0;
}

int print_help() {
	printf("Usage c_light_wallet <SEED_81_CHARS> SECURITY INDEX COUNT\n");
	return 0;
}

void address(char* seed_chars, int index, int security, char result[81]) {
	
	unsigned char address[81];
	unsigned char seed_bytes[48];
	chars_to_bytes(seed_chars, seed_bytes, 81);
	get_public_addr(seed_bytes, index, security, address);
	
	bytes_to_chars(address, result, 48);
}
