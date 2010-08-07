#ifndef TEST_IMAGE_H
#define TEST_IMAGE_H

#include <stdint.h>

#define IMG_ROWS    1
#define IMG_COLS    4
#define IMG_RGB     3

static uint8_t IMG_RGB_IMAGE[IMG_ROWS][IMG_COLS][IMG_RGB] = {
                                                { {200, 0, 2}, {127, 0, 0}, {155, 2, 0}, {140, 4, 2} }
                                            };

#endif
