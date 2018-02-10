#include "main.h"
#include "ui.h"
#include "aux.h"

char top_str[21];
char bot_str[21];

//write_display(&words, sizeof(words), TYPE_STR);
//write_display(&int_val, sizeof(int_val), TYPE_INT);
void write_display(void* o, uint8_t sz, uint8_t t, uint8_t p) {
    //don't allow messages greater than 20
    if(sz > 20) sz = 20;
    char *c_ptr = NULL;
    
    if(p == TOP) c_ptr = &top_str[0];
    else c_ptr = &bot_str[0];
    
    //NULL value sets line blank
    if(o == NULL) {
        c_ptr[0] = '\0';
        return;
    }
    
    //uint32_t/int(half this) [0, 4,294,967,295] -
    //ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
        snprintf(c_ptr, sz, "%d", *(int32_t *) o);
    }
    else if(t == TYPE_UINT) {
        snprintf(c_ptr, sz, "%u", *(uint32_t *) o);
    }
    else if(t == TYPE_STR) {
        snprintf(c_ptr, sz, "%s", (char *) o);
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
        {BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0,
            BAGL_GLYPH_ICON_CROSS},
        NULL,
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
        NULL,
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
            BAGL_FILL, 0x41ccb4, 0xF9F9F9, BAGL_FONT_OPEN_SANS_LIGHT_14px |
            BAGL_FONT_ALIGNMENT_CENTER | BAGL_FONT_ALIGNMENT_MIDDLE, 0},
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

void initUImsg() {
    if(nvram_is_init()) {
        write_display("DONT USE OTHER", 20, TYPE_STR, TOP);
        write_display("PEOPLES SEED!", 20, TYPE_STR, BOT);
    }
    else {
        write_display("DONT USE OTHER", 20, TYPE_STR, TOP);
        write_display("PEOPLES SEED!", 20, TYPE_STR, BOT);
    }
}

//ui_display_debug(top, szof(top), TYPE_TOP, bot, szof(bot) TYPE_BOT);
void ui_display_debug(void *o, uint8_t sz, uint8_t t, void *o2,
                      uint8_t sz2, uint8_t t2) {
    write_display(o, sz, t, TOP);
    write_display(o2, sz2, t2, BOT);
    
    UX_DISPLAY(bagl_ui_nanos_screen, NULL);
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen, NULL);
    }
}

/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
 ---------------------------------------------------------------
 --------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
    switch (button_mask) {
        case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
            io_seproxyhal_touch_exit(NULL);
            break;
        case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
            io_seproxyhal_touch_exit(NULL);
            break;
    }
    return 0;
}






const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
    return NULL;
}

const bagl_element_t *io_seproxyhal_touch_deny(const bagl_element_t *e) {
    hashTainted = 1;
    G_io_apdu_buffer[0] = 0x69;
    G_io_apdu_buffer[1] = 0x85;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
    // Display back the original UX
    ui_idle();
    return 0; // do not redraw the widget
}

const bagl_element_t*
io_seproxyhal_touch_approve(const bagl_element_t *e) {
    unsigned int tx = 0;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
    // Display back the original UX
    ui_idle();
    return 0; // do not redraw the widget
}





unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
}

