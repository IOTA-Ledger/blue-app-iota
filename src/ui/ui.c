#include "ui.h"
#include <string.h>
#include "common.h"
#include "iota/addresses.h"

UI_TEXT_CTX ui_text;
UI_GLYPH_CTX ui_glyphs;
UI_STATE_CTX ui_state;

// ----------- local function prototypes
void init_state_transitions(void);
void ui_transition_state(unsigned int button_mask);

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
        ui_text.half_top, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 13, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        ui_text.top_str, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 19, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        ui_text.mid_str, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 25, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_LABELINE, 0x01, 0, 36, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        ui_text.half_bot, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 3, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LESS}, ui_glyphs.glyph_bar_l, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 117, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LESS}, ui_glyphs.glyph_bar_r, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0,
        BAGL_GLYPH_ICON_CROSS}, ui_glyphs.glyph_cross, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_CHECK}, ui_glyphs.glyph_check, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0,
        BAGL_GLYPH_ICON_UP}, ui_glyphs.glyph_up, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_DOWN}, ui_glyphs.glyph_down, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 9, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_WARNING_BADGE}, ui_glyphs.glyph_warn, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 9, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LOADING_BADGE}, ui_glyphs.glyph_load, 0, 0, 0, NULL, NULL, NULL},
    
    {{BAGL_ICON, 0x00, 24, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_DASHBOARD_BADGE}, ui_glyphs.glyph_dash, 0, 0, 0, NULL, NULL, NULL}};
// clang-format on

/* ------------------- DISPLAY UI FUNCTIONS -------------
 ---------------------------------------------------------
 --------------------------------------------------------- */
void ui_render()
{
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

void ctx_initialize()
{
    os_memset(&ui_text, 0, sizeof(ui_text));
    os_memset(&ui_glyphs, 0, sizeof(ui_glyphs));
    os_memset(&ui_state, 0, sizeof(ui_state.state));
    
    ui_state.menu_idx = 0;
    ui_state.display_full_value = false;
}

void ui_init(bool flash_is_init)
{
    ctx_initialize();
    init_state_transitions();

    if (flash_is_init)
        ui_state.state = STATE_MENU_WELCOME;
    else
        ui_state.state = STATE_MENU_INIT;

    ui_build_display();
    ui_render();
}

// Entry points for main to modify display
void ui_display_welcome()
{
    ui_state.state = STATE_MENU_WELCOME;
    ui_build_display();
    ui_render();
}

/* Not having these coded as actual states preserves the previous
 state we were in to return to */
void ui_display_calc()
{
    clear_display();
    write_display("Calculating...", TYPE_STR, MID);
    
    display_glyphs(ui_glyphs.glyph_load, NULL);
    ui_render();
}

void ui_display_recv()
{
    clear_display();
    write_display("Receiving TX...", TYPE_STR, MID);
    
    display_glyphs(ui_glyphs.glyph_load, NULL);
    ui_render();
}

void ui_display_sending()
{
    clear_display();
    write_display("Signing TX...", TYPE_STR, MID);
    
    display_glyphs(ui_glyphs.glyph_load, NULL);
    ui_render();
}

void ui_display_address(char *a, uint8_t len)
{
    if (len != 81)
        return;
    
    memcpy(ui_state.addr, a, 81);
    state_go(STATE_DISP_ADDR_CHK, 0);
    
    ui_build_display();
    ui_render();
}

// Generates user prompt for tx
void ui_sign_tx(int64_t b, int64_t p, const char *a, uint8_t len)
{
    // we only accept 81 character addresses - no checksum
    if (len != 81)
        return;
    
    ui_state.bal = b;
    ui_state.pay = p;
    memcpy(ui_state.addr, a, len);
    
    ui_state.state = STATE_TX_BAL;
    
    ui_build_display();
    ui_render();
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

/* ----------------------------------------------------
 ------------------------------------------------------
            ------- MAIN BUTTON LOGIC -------
        Every button press calls transition_state
 ------------------------------------------------------
 --------------------------------------------------- */
void ui_transition_state(unsigned int button_mask)
{
    uint8_t translated_mask = ui_translate_mask(button_mask);
    
    // make sure we only transition on valid button presses
    if (translated_mask == BUTTON_BAD)
        return;
    
    // store current state for menu/button handling
    uint8_t old_state = ui_state.state;
    ui_state.state = state_transitions[ui_state.state][translated_mask];
    
    // special handling of menus (including new state transition)
    ui_handle_menus(old_state, translated_mask);
    
    // See if a special function needs to be called
    // for instance user_sign or user_deny()
    ui_handle_button(old_state, translated_mask);
    
    // after transitioning, build new display
    ui_build_display();
    
    if (ui_state.state == STATE_EXIT)
        io_seproxyhal_touch_exit(NULL);
    
    // render new display
    ui_render();
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
    /* ------------- MENU VIEW IDX --------------- */
    state_transitions[STATE_MENU_DISP_IDX][BUTTON_L] = STATE_MENU_DISP_IDX;
    state_transitions[STATE_MENU_DISP_IDX][BUTTON_R] = STATE_MENU_DISP_IDX;
    state_transitions[STATE_MENU_DISP_IDX][BUTTON_B] = STATE_MENU_DISP_IDX;
    /* ------------- MENU ADVANCED MODE --------------- */
    state_transitions[STATE_MENU_ADVANCED][BUTTON_L] = STATE_MENU_ADVANCED;
    state_transitions[STATE_MENU_ADVANCED][BUTTON_R] = STATE_MENU_ADVANCED;
    state_transitions[STATE_MENU_ADVANCED][BUTTON_B] = STATE_MENU_ADVANCED;
    /* ------------- MENU ADVANCED MODE WARNING --------------- */
    state_transitions[STATE_MENU_ADV_WARN][BUTTON_L] = STATE_MENU_ADV_WARN;
    state_transitions[STATE_MENU_ADV_WARN][BUTTON_R] = STATE_MENU_ADV_WARN;
    state_transitions[STATE_MENU_ADV_WARN][BUTTON_B] = STATE_MENU_ADV_WARN;
    /* ------------- MENU BROWSER MODE --------------- */
    state_transitions[STATE_MENU_BROWSER][BUTTON_L] = STATE_MENU_BROWSER;
    state_transitions[STATE_MENU_BROWSER][BUTTON_R] = STATE_MENU_BROWSER;
    state_transitions[STATE_MENU_BROWSER][BUTTON_B] = STATE_MENU_BROWSER;
    /* ------------- TX BALANCE --------------- */
    state_transitions[STATE_TX_BAL][BUTTON_L] = STATE_TX_DENY;
    state_transitions[STATE_TX_BAL][BUTTON_R] = STATE_TX_PAY;
    state_transitions[STATE_TX_BAL][BUTTON_B] = STATE_TX_BAL;
    /* ------------- TX SPEND --------------- */
    state_transitions[STATE_TX_PAY][BUTTON_L] = STATE_TX_BAL;
    state_transitions[STATE_TX_PAY][BUTTON_R] = STATE_TX_ADDR;
    state_transitions[STATE_TX_PAY][BUTTON_B] = STATE_TX_PAY;
    /* ------------- TX ADDR --------------- */
    state_transitions[STATE_TX_ADDR][BUTTON_L] = STATE_TX_PAY;
    state_transitions[STATE_TX_ADDR][BUTTON_R] = STATE_TX_APPROVE;
    state_transitions[STATE_TX_ADDR][BUTTON_B] = STATE_MENU_TX_ADDR;
    /* ------------- MENU TX ADDR --------------- */
    state_transitions[STATE_MENU_TX_ADDR][BUTTON_L] = STATE_MENU_TX_ADDR;
    state_transitions[STATE_MENU_TX_ADDR][BUTTON_R] = STATE_MENU_TX_ADDR;
    state_transitions[STATE_MENU_TX_ADDR][BUTTON_B] = STATE_MENU_TX_ADDR;
    /* ------------- TX APPROVE --------------- */
    state_transitions[STATE_TX_APPROVE][BUTTON_L] = STATE_TX_ADDR;
    state_transitions[STATE_TX_APPROVE][BUTTON_R] = STATE_TX_DENY;
    state_transitions[STATE_TX_APPROVE][BUTTON_B] = STATE_TX_APPROVE;
    /* ------------- TX DENY --------------- */
    state_transitions[STATE_TX_DENY][BUTTON_L] = STATE_TX_APPROVE;
    state_transitions[STATE_TX_DENY][BUTTON_R] = STATE_TX_BAL;
    state_transitions[STATE_TX_DENY][BUTTON_B] = STATE_MENU_WELCOME;
    /* ------------- MENU DISP ADDR --------------- */
    state_transitions[STATE_MENU_DISP_ADDR][BUTTON_L] = STATE_MENU_DISP_ADDR;
    state_transitions[STATE_MENU_DISP_ADDR][BUTTON_R] = STATE_MENU_DISP_ADDR;
    state_transitions[STATE_MENU_DISP_ADDR][BUTTON_B] = STATE_MENU_DISP_ADDR;
    /* ------------- DISP ADDR --------------- */
    state_transitions[STATE_DISP_ADDR_CHK][BUTTON_L] = STATE_DISP_ADDR_CHK;
    state_transitions[STATE_DISP_ADDR_CHK][BUTTON_R] = STATE_MENU_DISP_ADDR;
    state_transitions[STATE_DISP_ADDR_CHK][BUTTON_B] = STATE_MENU_WELCOME;
}
