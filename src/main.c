#include "main.h"

#include <stdio.h>
#include <time.h>
// iota-related stuff
#include "iota/kerl.h"
#include "iota/conversion.h"
#include "iota/addresses.h"

int print_help();
void address(char* seedChars, int index, int security, char* result);

int main(int argc, char *argv[]){

	if (argc != 2) {
		return print_help();
	}

	char* seed_chars = argv[1];
	char char_address[81];
	address(seed_chars, 0, 2, char_address);
	printf("%s\n", char_address);
	
	return 0;
}

int print_help() {
	printf("Usage c_light_wallet <SEED_81_CHARS>\n");
	return 0;
}

void address(char* seed_chars, int index, int security, char result[81]) {
	
	unsigned char address[81];
	unsigned char seed_bytes[48];
	chars_to_bytes(seed_chars, seed_bytes, 81);
	get_public_addr(seed_bytes, index, security, address);
	
	bytes_to_chars(address, result, 48);
}
