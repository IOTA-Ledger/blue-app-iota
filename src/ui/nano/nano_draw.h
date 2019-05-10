#ifndef NANO_DISPLAY_H
#define NANO_DISPLAY_H

void nano_draw_main_menu(void);
void nano_draw_about(void);
void nano_draw_version(void);
void nano_draw_more_info(void);
void nano_draw_bip_path(void);
void nano_draw_address_full(void);   // display pubkey on ledger
void nano_draw_address_digest(void); // display abbrv with chk
void nano_draw_bundle_addr(void);    // display address in tx
void nano_draw_bundle(void);

void nano_draw_getting_addr(void);
void nano_draw_validating(void);
void nano_draw_receiving(void);
void nano_draw_signing(void);

#endif // NANO_DISPLAY_H
