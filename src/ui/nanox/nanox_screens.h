#ifndef NANOX_SCREENS_H
#define NANOX_SCREENS_H

#include "nanox_elements.h"
#include "nanox_types.h"
#include "api.h"
#include "glyphs.h"

void display_about_x();
void ui_display_main_menu();
void return_main_menu();
void ui_display_getting_addr();
void ui_sign_tx();

// main menu flow
UX_STEP_NOCB(ux_main_flow_0_step, pb,
             {
                 &C_nanox_icon_iota,
                 "IOTA",
             });
UX_STEP_VALID(ux_main_flow_1_step, nnbnn, display_about_x(),
              {
                  "",
                  "",
                  "About",
                  "",
                  "",
              });
UX_STEP_VALID(ux_main_flow_2_step, pb, os_sched_exit(-1),
              {
                  &C_icon_dashboard,
                  "Exit App",
              });

const ux_flow_step_t *const ux_main_flow[] = {
    &ux_main_flow_0_step,
    &ux_main_flow_1_step,
    &ux_main_flow_2_step,
    FLOW_END_STEP,
};
// -- main menu flow

// about menu flow
UX_STEP_NOCB(ux_about_flow_0_step, bn,
             {
                 "Version",
                 APPVERSION,
             });
UX_STEP_NOCB(ux_about_flow_1_step, nnbnn,
             {
                 "",
                 "Please visit",
                 "iota.org/sec",
                 "for more info.",
                 "",
             });
UX_STEP_VALID(ux_about_flow_2_step, pb, ui_sign_tx(),
              {
                  &C_icon_back_x,
                  "Back",
              });

const ux_flow_step_t *const ux_about_flow[] = {
    &ux_about_flow_0_step,
    &ux_about_flow_1_step,
    &ux_about_flow_2_step,
    FLOW_END_STEP,
};
// -- about menu flow

// getting_addr flow
UX_STEP_VALID(ux_getting_addr_flow_0_step, pb, return_main_menu(),
              {
                  &C_icon_loader,
                  "Getting Address",
              });
const ux_flow_step_t *const ux_getting_addr_flow[] = {
    &ux_getting_addr_flow_0_step,
    FLOW_END_STEP,
};
// -- getting addr flow

// TX flow
UX_STEP_NOCB(ux_tx_flow_0_step, bnnn_paging,
             {
                 .title = "Output:",
                 .text = nanox_ui_text.mid_str,
             });
UX_STEP_INIT(ux_tx_pre_input, NULL, NULL,
             { strcpy(nanox_ui_text.mid_str, "ZMIFIF\0"); });
UX_STEP_NOCB(ux_tx_input_flow, bnnn_paging,
             {
                 .title = "Input:",
                 .text = nanox_ui_text.mid_str,
             });
UX_STEP_INIT(ux_tx_post_input, NULL, NULL,
             { strcpy(nanox_ui_text.mid_str, "BISCUIT\0"); });
UX_STEP_VALID(ux_tx_approve, nnbnn, return_main_menu(),
              {
                  "",
                  "",
                  "Approve",
                  "",
                  "",
              });
UX_STEP_VALID(ux_tx_deny, nnbnn, return_main_menu(),
              {
                  "",
                  "",
                  "Deny",
                  "",
                  "",
              });

const ux_flow_step_t *const ux_tx_flow[] = {
    &ux_tx_flow_0_step, &ux_tx_pre_input, &ux_tx_input_flow, &ux_tx_post_input,
    &ux_tx_approve,     &ux_tx_deny,      FLOW_END_STEP,
};

#endif // NANOX_SCREENS_H
