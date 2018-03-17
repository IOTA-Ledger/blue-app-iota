#include "ui.h"
#include <string.h>
#include "common.h"
#include "aux.h"

char half_top[21];
char top_str[21];
char mid_str[21];
char bot_str[21];
char half_bot[21];

// flags for turning on/off certain glyphs
char glyph_bar_l[2], glyph_bar_r[2];
char glyph_bar_l_c[2], glyph_bar_r_c[2];
char glyph_cross[2], glyph_check[2];
char glyph_up[2], glyph_down[2];
char glyph_warn[2], glyph_dash[2], glyph_load[2];

uint8_t ui_state;
uint8_t menu_idx;

// tx information
int64_t bal = 0;
int64_t pay = 0;
char addr[21];

// matrix holds layout of state transitions
static uint8_t state_transitions[TOTAL_STATES][3];

// ----------- local function prototypes
void init_state_transitions(void);
void ui_display_state(void);
void ui_handle_button(uint8_t button_mask);
void ui_handle_menus(uint8_t state, uint8_t translated_mask);
void ui_transition_state(unsigned int button_mask);

void glyph_on(char *c);
void glyph_off(char *c);
void clear_display();
void clear_glyphs();

void get_init_menu(char *msg);
void get_welcome_menu(char *msg);
void get_disp_addr_menu(char *msg);
void get_disp_idx_menu(char *msg);
void get_advanced_menu(char *msg);
void get_browser_menu(char *msg);

unsigned int bagl_ui_nanos_screen_button(unsigned int, unsigned int);

// *************************
// Ledger Nano S specific UI
// *************************
// one dynamic screen that changes based on the ui state

// clang-format off
static const bagl_element_t bagl_ui_nanos_screen[] = {
    // {type, userid, x, y, width, height, stroke, radius, fill,
    // fgcolor, bgcolor, fontid, iconid}, text .....
    {{BAGL_RECTANGLE, 0x00, 0, 0, 128, 32, 0, 0, BAGL_FILL, 0x000000, 0xFFFFFF,
        0, 0}, NULL, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_LABELINE, 0x01, 0, 3, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        half_top, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 13, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        top_str, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 19, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        mid_str, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 25, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        bot_str, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_LABELINE, 0x01, 0, 36, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        half_bot, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 3, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LESS}, glyph_bar_l, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 117, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LESS}, glyph_bar_r, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 3, 0, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LESS}, glyph_bar_l_c, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 117, 0, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LESS}, glyph_bar_r_c, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0,
        BAGL_GLYPH_ICON_CROSS}, glyph_cross, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_CHECK}, glyph_check, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0,
        BAGL_GLYPH_ICON_UP}, glyph_up, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_DOWN}, glyph_down, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 9, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_WARNING_BADGE}, glyph_warn, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 9, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LOADING_BADGE}, glyph_load, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 24, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_DASHBOARD_BADGE}, glyph_dash, 0, 0, 0, NULL, NULL, NULL}};
// clang-format on

/* ------------------- DISPLAY UI FUNCTIONS -------------
 ---------------------------------------------------------
 --------------------------------------------------------- */
void ui_init(bool first_run)
{
    init_state_transitions();
    menu_idx = 0;

    if (first_run)
        ui_state = STATE_MENU_INIT;
    else
        ui_state = STATE_MENU_WELCOME;

    ui_display_state();
}

void ui_reset()
{
    bal = 0;
    pay = 0;
    memset(addr, '\0', sizeof(addr));

    ui_state = STATE_MENU_WELCOME;
    ui_display_state();
}

void ui_record_addr(const char *a, uint8_t len)
{
    // length 81 or 82 means full address
    if (len == 81 || len == 82) {
        // Convert into abbreviated seeed
        memcpy(addr, a, 6);          // first 6 chars of address
        memcpy(addr + 6, "...", 3);  // copy ...
        memcpy(addr + 9, a + 75, 7); // copy last 6 chars + null
    }
    else if (len <= 21) {
        memcpy(addr, a, len);
    }
}

void ui_display_welcome()
{
    ui_state = STATE_MENU_WELCOME;
    ui_display_state();
}

void ui_display_calc()
{
    ui_state = STATE_CALC;
    ui_display_state();
}

void ui_display_recv()
{
    ui_state = STATE_RECV;
    ui_display_state();
}

void ui_display_sending()
{
    ui_state = STATE_SEND;
    ui_display_state();
}

void ui_sign_tx(int64_t b, int64_t p, const char *a, uint8_t len)
{
    bal = b;
    pay = p;
    ui_record_addr(a, len);

    ui_state = STATE_TX_BAL;

    ui_display_state();
}

// write_display(&words, sizeof(words), TYPE_STR);
// write_display(&int_val, sizeof(int_val), TYPE_INT);
void write_display(void *o, uint8_t sz, uint8_t t, uint8_t p)
{
    // don't allow messages greater than 20
    if (sz > 21)
        sz = 21;

    char *c_ptr = NULL;

    switch (p) {
    case TOP_H:
        c_ptr = half_top;
        break;
    case TOP:
        c_ptr = top_str;
        break;
    case BOT:
        c_ptr = bot_str;
        break;
    case BOT_H:
        c_ptr = half_bot;
        break;
    case MID:
    default:
        c_ptr = mid_str;
        break;
    }

    // NULL value sets line blank
    if (o == NULL) {
        c_ptr[0] = '\0';
        return;
    }

    // uint32_t/int(half this) [0, 4,294,967,295] -
    // ledger does not support long - USE %d not %i!
    if (t == TYPE_INT) {
        snprintf(c_ptr, sz, "%d", *(int32_t *)o);
    }
    else if (t == TYPE_UINT) {
        snprintf(c_ptr, sz, "%u", *(uint32_t *)o);
    }
    else if (t == TYPE_STR) {
        snprintf(c_ptr, sz, "%s", (char *)o);
    }
}

// ui_display_message(top, szof(top), TYPE_TOP,
//                  mid, szof(mid), TYPE_MID,
//                  bot, szof(bot) TYPE_BOT);
void ui_display_message(void *o, uint8_t sz, uint8_t t, void *o2, uint8_t sz2,
                        uint8_t t2, void *o3, uint8_t sz3, uint8_t t3)
{
    write_display(o, sz, t, TOP);
    write_display(o2, sz2, t2, MID);
    write_display(o3, sz3, t3, BOT);

    UX_DISPLAY(bagl_ui_nanos_screen, NULL);
}

void ui_force_draw()
{
    bool ux_done = false;
    while (!ux_done) {
        io_seproxyhal_general_status();
        io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer,
                               sizeof(G_io_seproxyhal_spi_buffer), 0);

        // manually handle events
        switch (G_io_seproxyhal_spi_buffer[0]) {
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            if (UX_DISPLAYED()) {
                ux_done = true;
                break;
            }
            else {
                UX_DISPLAYED_EVENT();
            }
            break;
        default:
            // ignore any other event
            break;
        }
    }

    // now everything is in the buffer, the next general status renders it
    io_seproxyhal_general_status();
    io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer,
                           sizeof(G_io_seproxyhal_spi_buffer), 0);
}


/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
 ---------------------------------------------------------------
 --------------------------------------------------------------- */
unsigned int bagl_ui_nanos_screen_button(unsigned int button_mask,
                                         unsigned int button_mask_counter)
{
    ui_transition_state(button_mask);

    return 0;
}


const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e)
{
    // Go back to the dashboard
    os_sched_exit(0);
    return NULL;
}

const bagl_element_t *io_seproxyhal_touch_deny(const bagl_element_t *e)
{
    G_io_apdu_buffer[0] = 0x69;
    G_io_apdu_buffer[1] = 0x85;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);

    return 0; // do not redraw the widget
}

const bagl_element_t *io_seproxyhal_touch_approve(const bagl_element_t *e)
{
    unsigned int tx = 0;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);

    return 0; // do not redraw the widget
}


/* --------- STATE RELATED FUNCTIONS ----------- */

void write_text_array(char *array, uint8_t len)
{
    clear_display();
    clear_glyphs();

    if (menu_idx > 0) {
        write_display(array + (21 * (menu_idx - 1)), 21, TYPE_STR, TOP_H);
        glyph_on(glyph_up);
    }

    write_display(array + (21 * menu_idx), 21, TYPE_STR, MID);

    if (menu_idx < len - 1) {
        write_display(array + (21 * (menu_idx + 1)), 21, TYPE_STR, BOT_H);
        glyph_on(glyph_down);
    }
}

void clear_text()
{
    write_display(NULL, 21, TYPE_STR, TOP_H);
    write_display(NULL, 21, TYPE_STR, TOP);
    write_display(NULL, 21, TYPE_STR, MID);
    write_display(NULL, 21, TYPE_STR, BOT);
    write_display(NULL, 21, TYPE_STR, BOT_H);
}

// Turns glyphs on or off
void glyph_on(char *c)
{
    if (c != NULL)
        c[0] = '\0';
}

void glyph_off(char *c)
{
    if (c != NULL) {
        c[0] = '.';
        c[1] = '\0';
    }
}

void clear_glyphs()
{
    // turn off all glyphs
    glyph_off(glyph_bar_l);
    glyph_off(glyph_bar_r);
    glyph_off(glyph_bar_l_c);
    glyph_off(glyph_bar_r_c);
    glyph_off(glyph_cross);
    glyph_off(glyph_check);
    glyph_off(glyph_up);
    glyph_off(glyph_down);
    glyph_off(glyph_warn);
    glyph_off(glyph_load);
    glyph_off(glyph_dash);
}

void clear_display()
{
    clear_text();
    clear_glyphs();
}

// turns on only 2 glyphs
void display_glyphs(char *c1, char *c2)
{
    clear_glyphs();

    // turn on ones we want
    glyph_on(c1);
    glyph_on(c2);
}

// combine glyphs with bars along top for confirm
void display_glyphs_confirm(char *c1, char *c2)
{
    clear_glyphs();

    // turn on ones we want
    glyph_on(glyph_bar_l);
    glyph_on(glyph_bar_r);
    glyph_on(glyph_bar_l_c);
    glyph_on(glyph_bar_r_c);
    glyph_on(c1);
    glyph_on(c2);
}

// combine glyphs with bars along top for exit
void display_glyphs_exit(char *c1, char *c2)
{
    clear_glyphs();

    // turn on ones we want
    glyph_on(glyph_bar_l);
    glyph_on(glyph_bar_r);
    glyph_on(c1);
    glyph_on(c2);
}

uint8_t ui_translate_mask(unsigned int button_mask)
{
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        return BUTTON_L;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        return BUTTON_R;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT | BUTTON_LEFT:
        return BUTTON_B;
    default:
        return BUTTON_BAD;
    }
}

bool state_is(uint8_t state)
{
    return ui_state == state;
}

/* ----------------------------------------------------
 ------------------------------------------------------
        Every button press calls transition_state
 ------------------------------------------------------
 --------------------------------------------------- */
void ui_transition_state(unsigned int button_mask)
{
    uint8_t translated_mask = ui_translate_mask(button_mask);

    // make sure we only transition on valid button presses
    if (translated_mask == BUTTON_BAD)
        return;

    ui_handle_button(translated_mask);

    // store previous state for menu handling
    uint8_t old_state = ui_state;
    ui_state = state_transitions[ui_state][translated_mask];

    // handle menus uniquely (including new state transition)
    ui_handle_menus(old_state, translated_mask);

    if (state_is(STATE_EXIT))
        io_seproxyhal_touch_exit(NULL);

    // after transitioning, immediately display new state
    ui_display_state();
}


/* ----------------------------------------------------
 ------------------------------------------------------
        Default display options per screen
        * Text menus have special handling
 ------------------------------------------------------
 --------------------------------------------------- */
void ui_display_state()
{
    switch (ui_state) {
        /* ------------ INIT *MENU* -------------- */
    case STATE_MENU_INIT: {
        char msg[MENU_INIT_LEN * 21];
        get_init_menu(msg);
        write_text_array(msg, MENU_INIT_LEN);

        // special override states
        if (menu_idx == 0)
            glyph_on(glyph_warn);
        if (menu_idx == MENU_INIT_LEN - 1) {
            display_glyphs_exit(glyph_up, NULL);
        }
    } break;
        /* ------------ WELCOME *MENU* -------------- */
    case STATE_MENU_WELCOME: {
        char msg[MENU_WELCOME_LEN * 21];
        get_welcome_menu(msg);
        write_text_array(msg, MENU_WELCOME_LEN);

        // special override display states
        switch (menu_idx) {
        // turn off BOT_H
        case 0:
            display_glyphs_exit(NULL, glyph_down);
        case MENU_WELCOME_LEN - 2:
            write_display(NULL, 21, TYPE_STR, BOT_H);
            break;
        // turn off TOP_H
        case MENU_WELCOME_LEN - 1:
            display_glyphs_exit(glyph_up, glyph_dash);
        case 1:
            write_display(NULL, 21, TYPE_STR, TOP_H);
            break;
        }
    } break;
        /* ------------ DISPLAY ADDR *MENU* -------------- */
    case STATE_MENU_DISP_ADDR: {
        char msg[MENU_DISP_ACCOUNTS_LEN * 21];
        get_disp_addr_menu(msg);
        write_text_array(msg, MENU_DISP_ACCOUNTS_LEN);

        // special override display states
        switch (menu_idx) {
        // turn off BOT_H
        case MENU_WELCOME_LEN - 2:
            write_display(NULL, 21, TYPE_STR, BOT_H);
            break;
            // turn off TOP_H
        case MENU_WELCOME_LEN - 1:
            display_glyphs_exit(glyph_up, glyph_dash);
            write_display(NULL, 21, TYPE_STR, TOP_H);
            break;
        }
    } break;
        /* ------------ DISPLAY INDEXES *MENU* -------------- */
    case STATE_MENU_DISP_IDX: {
        char msg[MENU_DISP_ACCOUNTS_LEN * 21];
        get_disp_idx_menu(msg);
        write_text_array(msg, MENU_DISP_ACCOUNTS_LEN);

        // special override display states
        switch (menu_idx) {
            // turn off BOT_H
        case MENU_WELCOME_LEN - 2:
            write_display(NULL, 21, TYPE_STR, BOT_H);
            break;
            // turn off TOP_H
        case MENU_WELCOME_LEN - 1:
            display_glyphs_exit(glyph_up, glyph_dash);
            write_display(NULL, 21, TYPE_STR, TOP_H);
            break;
        }
    } break;
        /* ------------ ADVANCED MODE *MENU* -------------- */
    case STATE_MENU_ADVANCED: {
        char msg[MENU_ADVANCED_LEN * 21];
        get_advanced_menu(msg);
        write_text_array(msg, MENU_ADVANCED_LEN);

        // no special overrides
    } break;
        /* ------------ BROWSER SUPPORT *MENU* -------------- */
    case STATE_MENU_BROWSER: {
        char msg[MENU_BROWSER_LEN * 21];
        get_browser_menu(msg);
        write_text_array(msg, MENU_BROWSER_LEN);

        // no special overrides
    } break;
        /* ------------ TX BAL -------------- */
    case STATE_TX_BAL: {
        clear_display();
        write_display("Total Balance:", 21, TYPE_STR, TOP);
        write_display(&bal, 21, TYPE_UINT, BOT);

        display_glyphs(glyph_up, glyph_down);
    } break;
        /* ------------ TX SPEND -------------- */
    case STATE_TX_SPEND: {
        clear_display();
        write_display("Total Payments:", 21, TYPE_STR, TOP);
        write_display(&pay, 21, TYPE_UINT, BOT);

        display_glyphs(glyph_up, glyph_down);
    } break;
        /* ------------ TX ADDR -------------- */
    case STATE_TX_ADDR: {
        clear_display();
        write_display("Dest Address:", 21, TYPE_STR, TOP);
        write_display(addr, 21, TYPE_STR, BOT);

        display_glyphs(glyph_up, glyph_down);
    } break;
        /* ------------ TX APPROVE -------------- */
    case STATE_TX_APPROVE: {
        clear_display();
        write_display("Approve TX", 21, TYPE_STR, MID);

        display_glyphs_exit(glyph_up, glyph_down);
    } break;
        /* ------------ TX DENY -------------- */
    case STATE_TX_DENY: {
        clear_display();
        write_display("Deny TX", 21, TYPE_STR, MID);

        display_glyphs_exit(glyph_up, glyph_down);
    } break;
        /* ------------ CALCULATING -------------- */
    case STATE_CALC: {
        clear_display();
        write_display("Calculating...", 21, TYPE_STR, MID);

        display_glyphs_exit(glyph_load, NULL);
    } break;
        /* ------------ RECEIVING -------------- */
    case STATE_RECV: {
        clear_display();
        write_display("Receiving TX...", 21, TYPE_STR, MID);

        display_glyphs_exit(glyph_load, NULL);
    } break;
        /* ------------ SENDING -------------- */
    case STATE_SEND: {
        clear_display();
        write_display("Signing TX...", 21, TYPE_STR, MID);

        display_glyphs_exit(glyph_load, NULL);
    } break;
        /* ------------ UNKNOWN STATE -------------- */
    default: {
        clear_display();
        write_display("UI ERROR", 21, TYPE_STR, MID);

        display_glyphs_exit(NULL, NULL);
    } break;
    }

    UX_DISPLAY(bagl_ui_nanos_screen, NULL);
}


/* ----------------------------------------------------
 ------------------------------------------------------
        Special handling of text menus
 ------------------------------------------------------
 --------------------------------------------------- */
void ui_handle_menus(uint8_t state, uint8_t translated_mask)
{
    uint8_t array_sz = 0;

    switch (state) {
        /* ------------ STATE INIT -------------- */
    case STATE_MENU_INIT:
        array_sz = MENU_INIT_LEN - 1;

        if (translated_mask == BUTTON_B && menu_idx == array_sz) {
            ui_state = STATE_MENU_WELCOME;
            menu_idx = 0;
            return;
        }
        break;
        /* ------------ STATE OPTIONS -------------- */
    case STATE_MENU_WELCOME:
        array_sz = MENU_WELCOME_LEN - 1;

        if (translated_mask == BUTTON_B) {
            switch (menu_idx) {
            // Welcome Message
            case 0:
                ui_state = STATE_EXIT;
                return;
            // View Addresses
            case 1:
                ui_state = STATE_MENU_DISP_ADDR;
                menu_idx = 0;
                return;
            // View Indexes
            case 2:
                ui_state = STATE_MENU_DISP_IDX;
                menu_idx = 0;
                return;
            // Advanced Mode
            case 3:
                ui_state = STATE_MENU_ADVANCED;
                // default to the currently set mode
                menu_idx = get_advanced_mode();
                return;
            // Browser Mode
            case 4:
                ui_state = STATE_MENU_BROWSER;
                // default to the currently set mode
                menu_idx = get_browser_mode();
                return;
            // Exit App
            case MENU_WELCOME_LEN - 1:
                ui_state = STATE_EXIT;
                return;
            }
        }
        break;
        /* ------------ STATE DISPLAY_ADDRESSES -------------- */
    case STATE_MENU_DISP_ADDR:
        array_sz = MENU_DISP_ACCOUNTS_LEN - 1;

        // Back
        if (translated_mask == BUTTON_B && menu_idx == array_sz) {
            ui_state = STATE_MENU_WELCOME;
            menu_idx = 1;
            return;
        }
        break;
        /* ------------ STATE DISPLAY_INDEXES -------------- */
    case STATE_MENU_DISP_IDX:
        array_sz = MENU_DISP_ACCOUNTS_LEN - 1;

        // Back
        if (translated_mask == BUTTON_B && menu_idx == array_sz) {
            ui_state = STATE_MENU_WELCOME;
            menu_idx = 2;
            return;
        }
        break;
        /* ------------ STATE ADVANCED MODE -------------- */
    case STATE_MENU_ADVANCED:
        array_sz = MENU_ADVANCED_LEN - 1;

        if (translated_mask == BUTTON_B) {
            // menu idx entries line up with modes
            write_advanced_mode(menu_idx);

            ui_state = STATE_MENU_WELCOME;
            menu_idx = 3;
            return;
        }
        break;
        /* ------------ STATE BROWSER MODE -------------- */
    case STATE_MENU_BROWSER:
        array_sz = MENU_BROWSER_LEN - 1;

        if (translated_mask == BUTTON_B) {
            // menu idx entries line up with modes
            write_browser_mode(menu_idx);

            ui_state = STATE_MENU_WELCOME;
            menu_idx = 4;
            return;
        }
        break;
        /* ------------ DEFAULT -------------- */
    default:
        menu_idx = 0;
        return;
    }

    // auto incr or decr menu_idx
    if (translated_mask == BUTTON_L)
        menu_idx = MAX(0, menu_idx - 1);
    else if (translated_mask == BUTTON_R)
        menu_idx = MIN(array_sz, menu_idx + 1);
}


/* ----------------------------------------------------
 ------------------------------------------------------
        Special button actions
 ------------------------------------------------------
 --------------------------------------------------- */
void ui_handle_button(uint8_t button_mask)
{
    if (button_mask == BUTTON_B) {
        /* ------------- APPROVE TX --------------- */
        if (ui_state == STATE_TX_APPROVE)
            user_sign();
        /* ------------- DENY TX --------------- */
        if (ui_state == STATE_TX_DENY)
            user_deny();
    }
}


/* ----------------------------------------------------
 ------------------------------------------------------
        Initializes Default State Transitions
 ------------------------------------------------------
 --------------------------------------------------- */
void init_state_transitions()
{
    /* ------------- MENU INIT --------------- */
    state_transitions[STATE_MENU_INIT][BUTTON_L] = STATE_MENU_INIT;
    state_transitions[STATE_MENU_INIT][BUTTON_R] = STATE_MENU_INIT;
    state_transitions[STATE_MENU_INIT][BUTTON_B] = STATE_MENU_INIT;
    /* ------------- MENU WELCOME --------------- */
    state_transitions[STATE_MENU_WELCOME][BUTTON_L] = STATE_MENU_WELCOME;
    state_transitions[STATE_MENU_WELCOME][BUTTON_R] = STATE_MENU_WELCOME;
    state_transitions[STATE_MENU_WELCOME][BUTTON_B] = STATE_MENU_WELCOME;
    /* ------------- MENU VIEW ADDR --------------- */
    state_transitions[STATE_MENU_DISP_ADDR][BUTTON_L] = STATE_MENU_DISP_ADDR;
    state_transitions[STATE_MENU_DISP_ADDR][BUTTON_R] = STATE_MENU_DISP_ADDR;
    state_transitions[STATE_MENU_DISP_ADDR][BUTTON_B] = STATE_MENU_DISP_ADDR;
    /* ------------- MENU VIEW IDX --------------- */
    state_transitions[STATE_MENU_DISP_IDX][BUTTON_L] = STATE_MENU_DISP_IDX;
    state_transitions[STATE_MENU_DISP_IDX][BUTTON_R] = STATE_MENU_DISP_IDX;
    state_transitions[STATE_MENU_DISP_IDX][BUTTON_B] = STATE_MENU_DISP_IDX;
    /* ------------- MENU ADVANCED MODE --------------- */
    state_transitions[STATE_MENU_ADVANCED][BUTTON_L] = STATE_MENU_ADVANCED;
    state_transitions[STATE_MENU_ADVANCED][BUTTON_R] = STATE_MENU_ADVANCED;
    state_transitions[STATE_MENU_ADVANCED][BUTTON_B] = STATE_MENU_ADVANCED;
    /* ------------- MENU BROWSER MODE --------------- */
    state_transitions[STATE_MENU_BROWSER][BUTTON_L] = STATE_MENU_BROWSER;
    state_transitions[STATE_MENU_BROWSER][BUTTON_R] = STATE_MENU_BROWSER;
    state_transitions[STATE_MENU_BROWSER][BUTTON_B] = STATE_MENU_BROWSER;
    /* ------------- CALCULATING --------------- */
    state_transitions[STATE_CALC][BUTTON_L] = STATE_CALC;
    state_transitions[STATE_CALC][BUTTON_R] = STATE_CALC;
    state_transitions[STATE_CALC][BUTTON_B] = STATE_CALC;
    /* ------------- RECEIVING --------------- */
    state_transitions[STATE_RECV][BUTTON_L] = STATE_RECV;
    state_transitions[STATE_RECV][BUTTON_R] = STATE_RECV;
    state_transitions[STATE_RECV][BUTTON_B] = STATE_RECV;
    /* ------------- SENDING --------------- */
    state_transitions[STATE_SEND][BUTTON_L] = STATE_SEND;
    state_transitions[STATE_SEND][BUTTON_R] = STATE_SEND;
    state_transitions[STATE_SEND][BUTTON_B] = STATE_SEND;
    /* ------------- TX BALANCE --------------- */
    state_transitions[STATE_TX_BAL][BUTTON_L] = STATE_TX_DENY;
    state_transitions[STATE_TX_BAL][BUTTON_R] = STATE_TX_SPEND;
    state_transitions[STATE_TX_BAL][BUTTON_B] = STATE_TX_BAL;
    /* ------------- TX SPEND --------------- */
    state_transitions[STATE_TX_SPEND][BUTTON_L] = STATE_TX_BAL;
    state_transitions[STATE_TX_SPEND][BUTTON_R] = STATE_TX_ADDR;
    state_transitions[STATE_TX_SPEND][BUTTON_B] = STATE_TX_SPEND;
    /* ------------- TX ADDR --------------- */
    state_transitions[STATE_TX_ADDR][BUTTON_L] = STATE_TX_SPEND;
    state_transitions[STATE_TX_ADDR][BUTTON_R] = STATE_TX_APPROVE;
    state_transitions[STATE_TX_ADDR][BUTTON_B] = STATE_TX_ADDR;
    /* ------------- TX APPROVE --------------- */
    state_transitions[STATE_TX_APPROVE][BUTTON_L] = STATE_TX_ADDR;
    state_transitions[STATE_TX_APPROVE][BUTTON_R] = STATE_TX_DENY;
    state_transitions[STATE_TX_APPROVE][BUTTON_B] = STATE_TX_APPROVE;
    /* ------------- TX DENY --------------- */
    state_transitions[STATE_TX_DENY][BUTTON_L] = STATE_TX_APPROVE;
    state_transitions[STATE_TX_DENY][BUTTON_R] = STATE_TX_BAL;
    state_transitions[STATE_TX_DENY][BUTTON_B] = STATE_MENU_WELCOME;
}

/* ----------- BUILDING MENU / TEXT ARRAY ------------- */
void get_init_menu(char *msg)
{
    memset(msg, '\0', MENU_INIT_LEN * 21);

    uint8_t i = 0;

    strcpy(msg + (i++ * 21), "WARNING!");
    strcpy(msg + (i++ * 21), "IOTA is not like");
    strcpy(msg + (i++ * 21), "other cryptos!");
    strcpy(msg + (i++ * 21), "Visit iota.org/sec");
    strcpy(msg + (i++ * 21), "to learn more.");
}

void get_welcome_menu(char *msg)
{
    memset(msg, '\0', MENU_WELCOME_LEN * 21);

    uint8_t i = 0;

    strcpy(msg + (i++ * 21), " Welcome to IOTA");
    strcpy(msg + (i++ * 21), "View Addresses");
    strcpy(msg + (i++ * 21), "View Seed Indexes");
    strcpy(msg + (i++ * 21), "Advanced Mode");
    strcpy(msg + (i++ * 21), "Browser Support");
    strcpy(msg + (i++ * 21), "Exit App");
}

void get_disp_addr_menu(char *msg)
{
    memset(msg, '\0', MENU_DISP_ACCOUNTS_LEN * 21);

    uint8_t i = 0;

    strcpy(msg + (i++ * 21), "Account [1]");
    strcpy(msg + (i++ * 21), "Account [2]");
    strcpy(msg + (i++ * 21), "Account [3]");
    strcpy(msg + (i++ * 21), "Account [4]");
    strcpy(msg + (i++ * 21), "Account [5]");
    strcpy(msg + (i++ * 21), "Back");
}

void get_disp_idx_menu(char *msg)
{
    memset(msg, '\0', MENU_DISP_ACCOUNTS_LEN * 21);

    uint8_t i = 0;

    strcpy(msg + (i * 21), "[1]: ");
    snprintf(msg + (i++ * 21) + 5, 16, "%u", get_seed_idx(0));
    strcpy(msg + (i * 21), "[2]: ");
    snprintf(msg + (i++ * 21) + 5, 16, "%u", get_seed_idx(1));
    strcpy(msg + (i * 21), "[3]: ");
    snprintf(msg + (i++ * 21) + 5, 16, "%u", get_seed_idx(2));
    strcpy(msg + (i * 21), "[4]: ");
    snprintf(msg + (i++ * 21) + 5, 16, "%u", get_seed_idx(3));
    strcpy(msg + (i * 21), "[5]: ");
    snprintf(msg + (i++ * 21) + 5, 16, "%u", get_seed_idx(4));
    strcpy(msg + (i * 21), "Back");
}

void get_advanced_menu(char *msg)
{
    memset(msg, '\0', MENU_ADVANCED_LEN * 21);

    uint8_t i = 0;

    strcpy(msg + (i++ * 21), "Default");
    strcpy(msg + (i++ * 21), "Advanced");
}

void get_browser_menu(char *msg)
{
    memset(msg, '\0', MENU_BROWSER_LEN * 21);

    uint8_t i = 0;

    strcpy(msg + (i++ * 21), "Disabled");
    strcpy(msg + (i++ * 21), "Enabled");
}
