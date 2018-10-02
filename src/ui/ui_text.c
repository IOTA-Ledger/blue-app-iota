#include "ui_text.h"
#include "ui_types.h"
#include "iota/addresses.h"
#include <string.h>

/* ----------- BUILDING MENU / TEXT ARRAY ------------- */
void get_init_menu(char *msg)
{
    memset(msg, '\0', MENU_INIT_LEN * TEXT_LEN);

    uint8_t i = 0;

    strcpy(msg + (i++ * TEXT_LEN), "WARNING!");
    strcpy(msg + (i++ * TEXT_LEN), "IOTA is not like");
    strcpy(msg + (i++ * TEXT_LEN), "other cryptos!");
    strcpy(msg + (i++ * TEXT_LEN), "Please visit");
    strcpy(msg + (i++ * TEXT_LEN), "iotasec.info");
    strcpy(msg + (i++ * TEXT_LEN), "for more info.");
}

void get_main_menu(char *msg)
{
    memset(msg, '\0', MENU_MAIN_LEN * TEXT_LEN);

    uint8_t i = 0;

    strcpy(msg + (i++ * TEXT_LEN), "Connect");
    strcpy(msg + (i++ * TEXT_LEN), "About");
    strcpy(msg + (i++ * TEXT_LEN), "Exit App");
}

void get_about_menu(char *msg)
{
    memset(msg, '\0', MENU_ABOUT_LEN * TEXT_LEN);

    uint8_t i = 0;

    strcpy(msg + (i++ * TEXT_LEN), "Version");
    strcpy(msg + (i++ * TEXT_LEN), "More Info");
    strcpy(msg + (i++ * TEXT_LEN), "Back");
}

void get_more_info_menu(char *msg)
{
    memset(msg, '\0', MENU_MORE_INFO_LEN * TEXT_LEN);

    uint8_t i = 0;

    strcpy(msg + (i++ * TEXT_LEN), "Please visit");
    strcpy(msg + (i++ * TEXT_LEN), "iotasec.info");
    strcpy(msg + (i++ * TEXT_LEN), "for more info.");
}

void get_address_menu(char *msg)
{
    // address is 81 characters long
    memset(msg, '\0', MENU_ADDR_LEN * TEXT_LEN);

    uint8_t i = 0, j = 0, c_cpy = 6;

    // 13 chunks of 6 characters
    for (; i < MENU_ADDR_LEN; i++) {
        strncpy(msg + (i * TEXT_LEN), ui_state.addr + (j++ * 6), c_cpy);
        msg[i * TEXT_LEN + 6] = ' ';

        if (i == MENU_ADDR_LEN - 1)
            c_cpy = 3;

        strncpy(msg + (i * TEXT_LEN) + 7, ui_state.addr + (j++ * 6), c_cpy);
    }
}
