#include "main.h"
#include "ui.h"
#include "aux.h"

char top_str[21];
char mid_str[21];
char bot_str[21];

char glyph_bar_l[2];
char glyph_bar_r[2];
char glyph_cross[2];
char glyph_check[2];
char glyph_up[2];
char glyph_down[2];

uint8_t ui_state;

uint32_t bal = 0;
uint32_t out = 0;
char addr[21];

static uint8_t state_transitions[TOTAL_STATES][3];

void ui_display_state();
void init_state_transitions();
bool state_is(uint8_t state);
uint8_t ui_translate_mask(unsigned int button_mask);
void ui_transition_state(unsigned int button_mask);
void ui_write_addr(const char *a, uint8_t len);
void display_glyphs(char *c1, char *c2);
void display_glyphs_with_bars(char *c1, char *c2);

// write_display(&words, sizeof(words), TYPE_STR);
// write_display(&int_val, sizeof(int_val), TYPE_INT);
void write_display(void *o, uint8_t sz, uint8_t t, uint8_t p)
{
    // don't allow messages greater than 20
    if (sz > 21)
        sz = 2;
    char *c_ptr = NULL;

    if (p == TOP)
        c_ptr = &top_str[0];
    else if (p == BOT)
        c_ptr = &bot_str[0];
    else
        c_ptr = &mid_str[0];

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

// ********************************************************************************
// Ledger Nano S specific UI
// ********************************************************************************

static const bagl_element_t bagl_ui_nanos_screen[] = {
    // {
    //     {type, userid, x, y, width, height, stroke, radius, fill, fgcolor,
    //      bgcolor, font_id, icon_id},
    //     text,
    //     touch_area_brim,
    //     overfgcolor,
    //     overbgcolor,
    //     tap,
    //     out,
    //     over,
    // },
    {
        {BAGL_RECTANGLE, 0x00, 0, 0, 128, 32, 0, 0, BAGL_FILL, 0x000000,
         0xFFFFFF, 0, 0},
        NULL,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_LABELINE, 0x01, 0, 12, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
         BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        top_str,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_LABELINE, 0x01, 0, 18, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
         BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        mid_str,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_LABELINE, 0x01, 0, 24, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
         BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        bot_str,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_ICON, 0x00, 3, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
         BAGL_GLYPH_ICON_LESS},
        glyph_bar_l,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_ICON, 0x00, 117, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
         BAGL_GLYPH_ICON_LESS},
        glyph_bar_r,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0,
         BAGL_GLYPH_ICON_CROSS},
        glyph_cross,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
         BAGL_GLYPH_ICON_CHECK},
        glyph_check,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0,
         BAGL_GLYPH_ICON_UP},
        glyph_up,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
         BAGL_GLYPH_ICON_DOWN},
        glyph_down,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
};


// ********************************************************************************
// Ledger Blue specific UI
// ********************************************************************************

static const bagl_element_t bagl_ui_sample_blue[] = {
    // {
    //     {type, userid, x, y, width, height, stroke, radius, fill, fgcolor,
    //      bgcolor, font_id, icon_id},
    //     text,
    //     touch_area_brim,
    //     overfgcolor,
    //     overbgcolor,
    //     tap,
    //     out,
    //     over,
    // },
    {
        {BAGL_RECTANGLE, 0x00, 0, 60, 320, 420, 0, 0, BAGL_FILL, 0xf9f9f9,
         0xf9f9f9, 0, 0},
        NULL,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_RECTANGLE, 0x00, 0, 0, 320, 60, 0, 0, BAGL_FILL, 0x1d2028,
         0x1d2028, 0, 0},
        NULL,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_LABEL, 0x00, 20, 0, 320, 60, 0, 0, BAGL_FILL, 0xFFFFFF, 0x1d2028,
         BAGL_FONT_OPEN_SANS_LIGHT_14px | BAGL_FONT_ALIGNMENT_MIDDLE, 0},
        "Hello World",
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_BUTTON | BAGL_FLAG_TOUCHABLE, 0x00, 165, 225, 120, 40, 0, 6,
         BAGL_FILL, 0x41ccb4, 0xF9F9F9,
         BAGL_FONT_OPEN_SANS_LIGHT_14px | BAGL_FONT_ALIGNMENT_CENTER |
             BAGL_FONT_ALIGNMENT_MIDDLE,
         0},
        "EXIT",
        0,
        0x37ae99,
        0xF9F9F9,
        io_seproxyhal_touch_exit,
        NULL,
        NULL,
    },
};


/* ------------------- DISPLAY UI FUNCTIONS -------------
 ---------------------------------------------------------
 --------------------------------------------------------- */
void initUImsg()
{
    init_state_transitions();
    
    display_glyphs(glyph_cross, glyph_check);
    
    ui_state = STATE_WELCOME;
    ui_display_state();
}

void ui_sign_tx(uint64_t b, uint64_t o, const char *a, uint8_t len)
{
    bal = b;
    out = o;
    ui_write_addr(a, len);
    
    ui_state = STATE_TX_SIGN;
    
    ui_display_state();
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

void ui_write_addr(const char *a, uint8_t len)
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

void ui_idle(void)
{
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    }
    else {
        UX_DISPLAY(bagl_ui_nanos_screen, NULL);
    }
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
    hashTainted = 1;
    G_io_apdu_buffer[0] = 0x69;
    G_io_apdu_buffer[1] = 0x85;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
    // Display back the original UX
    ui_idle();
    return 0; // do not redraw the widget
}

const bagl_element_t *io_seproxyhal_touch_approve(const bagl_element_t *e)
{
    unsigned int tx = 0;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
    // Display back the original UX
    ui_idle();
    return 0; // do not redraw the widget
}


/* --------- STATE RELATED FUNCTIONS ----------- */

void display_on(char *c)
{
    if(c != NULL)
        c[0] = '\0';
}

void display_off(char *c)
{
    if(c != NULL) {
        c[0] = '.';
        c[1] = '\0';
    }
}

void display_glyphs(char *c1, char *c2)
{
    //turn off all glyphs
    display_off(glyph_bar_l);
    display_off(glyph_bar_r);
    display_off(glyph_cross);
    display_off(glyph_check);
    display_off(glyph_up);
    display_off(glyph_down);
    
    //turn on ones we want
    display_on(c1);
    display_on(c2);
}

void display_glyphs_with_bars(char *c1, char *c2)
{
    //turn off all glyphs
    display_off(glyph_cross);
    display_off(glyph_check);
    display_off(glyph_up);
    display_off(glyph_down);
    
    //turn on ones we want
    display_on(glyph_bar_l);
    display_on(glyph_bar_r);
    display_on(c1);
    display_on(c2);
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

void ui_transition_state(unsigned int button_mask)
{
    uint8_t translated_mask = ui_translate_mask(button_mask);
    
    //make sure we only transition on valid button presses
    if(translated_mask == BUTTON_BAD)
        return;
    
    ui_state = state_transitions[ui_state][translated_mask];
    
    if(state_is(STATE_EXIT))
        io_seproxyhal_touch_exit(NULL);
    
    //after transitioning, immediately display new state
    ui_display_state();
}

void ui_display_state()
{
    switch (ui_state) {
            /* ------------ WELCOME -------------- */
        case STATE_WELCOME: {
            write_display(NULL, 20, TYPE_STR, TOP);
            write_display("Welcome to IOTA", 20, TYPE_STR, MID);
            write_display(NULL, 20, TYPE_STR, BOT);
            
            display_glyphs(glyph_cross, NULL);
        } break;
            /* ------------ TX BAL -------------- */
        case STATE_TX_BAL: {
            write_display("Total Balance:", 20, TYPE_STR, TOP);
            write_display(NULL, 0, TYPE_STR, MID);
            write_display(&bal, 20, TYPE_UINT, BOT);
            
            display_glyphs(NULL, glyph_down);
        } break;
            /* ------------ TX SPEND -------------- */
        case STATE_TX_SPEND: {
            write_display("Send Amt:", 20, TYPE_STR, TOP);
            write_display(NULL, 0, TYPE_STR, MID);
            write_display(&out, 20, TYPE_UINT, BOT);
            
            display_glyphs(glyph_up, glyph_down);
        } break;
            /* ------------ TX ADDR -------------- */
        case STATE_TX_ADDR: {
            write_display("Dest Address:", 20, TYPE_STR, TOP);
            write_display(NULL, 0, TYPE_STR, MID);
            write_display(addr, 20, TYPE_STR, BOT);
            
            display_glyphs_with_bars(glyph_up, NULL);
        } break;
            /* ------------ UNKNOWN STATE -------------- */
        default: {
            write_display(NULL, 0, 0, TOP);
            write_display("UI ERROR", 20, TYPE_STR, MID);
            write_display(NULL, 0, 0, BOT);
            
            display_glyphs(NULL, NULL);
        } break;
    }
    
    UX_DISPLAY(bagl_ui_nanos_screen, NULL);
}

void init_state_transitions()
{
    /* ------------- WELCOME --------------- */
    state_transitions[STATE_WELCOME][BUTTON_L] = STATE_EXIT;
    state_transitions[STATE_WELCOME][BUTTON_R] = STATE_WELCOME;
    state_transitions[STATE_WELCOME][BUTTON_B] = STATE_WELCOME;
    /* ------------- TX BALANCE --------------- */
    state_transitions[STATE_TX_BAL][BUTTON_L] = STATE_TX_BAL;
    state_transitions[STATE_TX_BAL][BUTTON_R] = STATE_TX_SPEND;
    state_transitions[STATE_TX_BAL][BUTTON_B] = STATE_EXIT;
    /* ------------- TX SPEND --------------- */
    state_transitions[STATE_TX_SPEND][BUTTON_L] = STATE_TX_BAL;
    state_transitions[STATE_TX_SPEND][BUTTON_R] = STATE_TX_ADDR;
    state_transitions[STATE_TX_SPEND][BUTTON_B] = STATE_EXIT;
    /* ------------- TX ADDR --------------- */
    state_transitions[STATE_TX_ADDR][BUTTON_L] = STATE_TX_SPEND;
    state_transitions[STATE_TX_ADDR][BUTTON_R] = STATE_TX_ADDR;
    state_transitions[STATE_TX_ADDR][BUTTON_B] = STATE_WELCOME;
}



unsigned int bagl_ui_sample_blue_button(unsigned int button_mask,
                                        unsigned int button_mask_counter)
{
    return 0;
}
