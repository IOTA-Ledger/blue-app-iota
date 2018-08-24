#ifndef UI_DISPLAY_H
#define UI_DISPLAY_H

void display_init();
void display_welcome();
void display_about();
void display_version();
void display_more_info();
void display_change_seed();
void display_addr();     // display pubkey on ledger
void display_addr_chk(); // display abbrv with chk
void display_tx_addr();  // display address in tx
void display_prompt_tx();
void display_unknown_state();

#endif // UI_DISPLAY_H
