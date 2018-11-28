#include "blue_buttons.h"
#include "blue_screens.h"
#include "glyphs.h"
#include "os.h"

#include "os_io_seproxyhal.h"

#define BLUE_BUTTON_PROTOTYPE(name)                                            \
  unsigned int bagl_ui_##name##_button(unsigned int button_mask,               \
                                       unsigned int button_mask_counter) {     \
    return 0;                                                                  \
  }

static volatile int state = 0;

const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
  // Go back to the dashboard
  os_sched_exit(0);
  return NULL;
}

const bagl_element_t *bagl_ui_SETTINGS_blue_button(const bagl_element_t *e) {
  UX_DISPLAY(bagl_ui_settings, NULL);
  return NULL;
}

const bagl_element_t *bagl_ui_DASHBOARD_blue_button(const bagl_element_t *e) {
  return io_seproxyhal_touch_exit(NULL);
}

const bagl_element_t *bagl_ui_LEFT_blue_button(const bagl_element_t *e) {
  UX_DISPLAY(bagl_ui_main, NULL);
  return NULL;
}

const bagl_element_t *button_tx(const bagl_element_t *e) {
        UX_DISPLAY(bagl_ui_transaction_last, NULL);
    return NULL;
}

const bagl_element_t *button_tx_next(const bagl_element_t *e) {
    if(state < 3) {
        state++;
        UX_DISPLAY(bagl_ui_transaction, NULL);
    }
    else {
        state++;
        UX_DISPLAY(bagl_ui_transaction_last, NULL);
    }
  return NULL;
}

const bagl_element_t *button_tx_prev(const bagl_element_t *e) {
    if(state > 1) {
        state--;
        UX_DISPLAY(bagl_ui_transaction, NULL);
    }
    else {
        state--;
        UX_DISPLAY(bagl_ui_transaction_first, NULL);
    }
    return NULL;
}

const bagl_element_t *button_tmp(const bagl_element_t *e) {
  UX_DISPLAY(bagl_ui_signing_tx, NULL);
  return NULL;
}

BLUE_BUTTON_PROTOTYPE(main)
BLUE_BUTTON_PROTOTYPE(settings)
BLUE_BUTTON_PROTOTYPE(transaction_first)
BLUE_BUTTON_PROTOTYPE(transaction)
BLUE_BUTTON_PROTOTYPE(transaction_last)
BLUE_BUTTON_PROTOTYPE(generating_addr)
BLUE_BUTTON_PROTOTYPE(validating)
BLUE_BUTTON_PROTOTYPE(receiving_tx)
BLUE_BUTTON_PROTOTYPE(signing_tx)
