#ifndef NANOX_SCREENS_H
#define NANOX_SCREENS_H

#include "nanox_elements.h"
#include "nanox_types.h"
#include "api.h"
#include "glyphs.h"

UX_STEP_NOCB(ux_idle_flow_1_step, bn,
             {
                 "Application",
                 "is ready",
             });
UX_STEP_NOCB(ux_idle_flow_2_step, bn,
             {
                 "Version",
                 APPVERSION,
             });
UX_STEP_VALID(ux_idle_flow_3_step, bn, os_sched_exit(-1),
              {
                  "Yeah",
                  "Quit",
              });

const ux_flow_step_t *const ux_idle_flow[] = {
    &ux_idle_flow_1_step,
    &ux_idle_flow_2_step,
    &ux_idle_flow_3_step,
    FLOW_END_STEP,
};

#endif // NANOX_SCREENS_H
