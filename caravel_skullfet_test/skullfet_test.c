/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

#include "verilog/dv/caravel/defs.h"

#define PROJECT_ID              6

#define TEST_RESULT_PASS        0x1
#define TEST_RESULT_FAIL        0xf

void main()
{
    // nand/inverter inputs
    reg_mprj_io_8  =   GPIO_MODE_USER_STD_INPUT_PULLUP;
    reg_mprj_io_10 =   GPIO_MODE_USER_STD_INPUT_PULLUP;
    reg_mprj_io_11 =   GPIO_MODE_USER_STD_INPUT_PULLUP;

    // nand/inverter outputs
    reg_mprj_io_9 =   GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_12 =   GPIO_MODE_USER_STD_OUTPUT;

    /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    // activate the project by setting the 1st bit of 1st bank of LA - depends on the project ID
    reg_la0_iena = 0; // input enable off
    reg_la0_oenb = 0; // output enable on
    reg_la0_data = 1 << PROJECT_ID;

    reg_la1_iena = 0xffffffff; // input enable on
    reg_la1_oenb = 0; // output enable on

    // Test inverter logic
    reg_la1_data = 1;
    if (reg_la1_data & 1) {
        reg_mprj_datal = TEST_RESULT_FAIL << 28;
        return;
    }

    reg_la1_data = 0;
    if (!(reg_la1_data & 1)) {
        reg_mprj_datal = TEST_RESULT_FAIL << 28;
        return;
    }

    reg_mprj_datal = TEST_RESULT_PASS << 28;
}

