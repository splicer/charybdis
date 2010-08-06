#ifndef RGB2Y_H
#define RGB2Y_H

#include <stdint.h>

typedef struct _rgb2y_rgbPixel_t {
    uint8_t r;
    uint8_t g;
    uint8_t b;
} __attribute__((packed)) rgb2y_rgbPixel_t;

typedef struct _rgb2y_yQuad_t {
    uint8_t y[4];
    uint8_t cb;
    uint8_t cr;
} __attribute__((packed)) rgb2y_yQuad_t;

int rgb2y_convertImage( const rgb2y_rgbPixel_t *rgbImg,
                        uint16_t width,
                        uint16_t height,
                        rgb2y_yQuad_t *yccImg );

#endif
