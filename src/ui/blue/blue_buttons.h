#ifndef BLUE_BUTTONS_H
#define BLUE_BUTTONS_H

#include "os.h"
#include "ux.h"
#include "os_io_seproxyhal.h"

const bagl_element_t *bagl_ui_SETTINGS_blue_button(const bagl_element_t *e);
const bagl_element_t *bagl_ui_DASHBOARD_blue_button(const bagl_element_t *e);
const bagl_element_t *bagl_ui_LEFT_blue_button(const bagl_element_t *e);
const bagl_element_t *button_tx(const bagl_element_t *e);
const bagl_element_t *button_tx_next(const bagl_element_t *e);
const bagl_element_t *button_tx_prev(const bagl_element_t *e);
const bagl_element_t *button_tmp(const bagl_element_t *e);
const bagl_element_t *button_deny(const bagl_element_t *e);
const bagl_element_t *button_approve(const bagl_element_t *e);

unsigned int bagl_ui_main_button(unsigned int, unsigned int);
unsigned int bagl_ui_settings_button(unsigned int, unsigned int);
unsigned int bagl_ui_disp_addr_button(unsigned int, unsigned int);
unsigned int bagl_ui_transaction_first_button(unsigned int, unsigned int);
unsigned int bagl_ui_transaction_button(unsigned int, unsigned int);
unsigned int bagl_ui_transaction_last_button(unsigned int, unsigned int);
unsigned int bagl_ui_generating_addr_button(unsigned int, unsigned int);
unsigned int bagl_ui_validating_button(unsigned int, unsigned int);
unsigned int bagl_ui_receiving_tx_button(unsigned int, unsigned int);
unsigned int bagl_ui_signing_tx_button(unsigned int, unsigned int);

#endif // BLUE_BUTTONS_H
