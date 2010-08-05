#include <rgb2y.h>

/* These coefficients are derived from the analog-to-analog matrix as follows:
 *
 * (Matlab code)
 *
 * a_to_a = [0.299 0.587 0.114; -0.168736 -0.331264 0.5; 0.5 -0.418688 -0.081312]
 *
 * a_to_d = [219 0 0; 0 224 0; 0 0 224] * a_to_a
 *
 * d_to_d = 256/255 * a_to_d
 *
 *
 * Important Notes
 * ---------------
 *
 * Also, according to the C99 standard, casting a float to an int rounds
 * towards zero.
 */

/* 8-bit */
static inline uint16_t rgb2y( uint8_t r, uint8_t g, uint8_t b )
{
    // FP shift of 24
    uint32_t y = ( ( uint32_t )( ( 65.7377882352941 * ( 1<<16 ) ) + 0.5 ) * r ) +
        ( ( uint32_t )( ( 129.0571294117647 * ( 1<<16 ) ) + 0.5 ) * g ) +
        ( (uint32_t )( ( 25.0639058823529 * ( 1<<16 ) ) + 0.5 ) * b ) +
        ( 256 * ( 1<<16 ) ) * 16;
    y = ( y + ( 1<<23 ) ) >> 24;
    return ( uint16_t )y;
}


/* 9-bit */
static inline uint16_t rgb2cb( uint8_t r, uint8_t g, uint8_t b )
{
    // FP shift of 22
    int32_t cb = ( ( int32_t )( ( -37.9450869960784 * ( 1<<15 ) ) - 0.5 ) * r ) +
        ( ( int32_t )( ( -74.4941286901961 * ( 1<<15 ) ) - 0.5 ) * g ) +
        ( ( int32_t )( ( 112.4392156862745 * ( 1<<15 ) ) + 0.5 ) * b ) +
        ( 256 * ( 1<<15 ) ) * 128;
    cb = ( cb + ( 1<<21 ) ) >> 22;
    return ( uint16_t )cb;
}


/* 9-bit */
static inline uint16_t rgb2cr( uint8_t r, uint8_t g, uint8_t b )
{
    // FP shift of 22
    int32_t cr = ( ( int32_t )( ( 112.4392156862745 * ( 1<<15 ) ) + 0.5 ) * r ) +
        ( ( int32_t )( ( -94.1539006745098 * ( 1<<15 ) ) - 0.5 ) * g ) +
        ( ( int32_t )( ( -18.2853150117647 * ( 1<<15 ) ) - 0.5 ) * b ) +
        ( 256 * ( 1<<15 ) ) * 128;
    cr = ( cr + ( 1<<21 ) ) >> 22;
    return ( uint16_t )cr;
}


int rgb2y_convertImage( const rgb2y_rgbPixel_t *rgbImg,
                        uint16_t width,
                        uint16_t height,
                        rgb2y_yQuad_t *yccImg )
{
    rgb2y_yQuad_t *yQuad = yccImg;

    for( uint16_t i = 0; i < height; i+=2 ) {
        for( uint16_t j = 0; j < width; j+=2 ) {
            const rgb2y_rgbPixel_t *p = &rgbImg[i * width + j];

            yQuad->y[0] = rgb2y( p->r, p->g, p->b );
            uint16_t cb1 = rgb2cb( p->r, p->g, p->b );
            uint16_t cr1 = rgb2cr( p->r, p->g, p->b );
            p++;

            yQuad->y[1] = rgb2y( p->r, p->g, p->b );
            uint16_t cb2 = rgb2cb( p->r, p->g, p->b );
            uint16_t cr2 = rgb2cr( p->r, p->g, p->b );
            p = &rgbImg[(i+1) * width + j];

            yQuad->y[2] = rgb2y( p->r, p->g, p->b );
            uint16_t cb3 = rgb2cb( p->r, p->g, p->b );
            uint16_t cr3 = rgb2cr( p->r, p->g, p->b );
            p++;

            yQuad->y[3] = rgb2y( p->r, p->g, p->b );
            uint16_t cb4 = rgb2cb( p->r, p->g, p->b );
            uint16_t cr4 = rgb2cr( p->r, p->g, p->b );

            // downsample 4 9-bit values to 1 8-bit value for Cb and Cr
            yQuad->cb = ( ( cb1 + cb2 + cb3 + cb4 ) + ( 1<<2 ) ) >> 3;
            yQuad->cr = ( ( cr1 + cr2 + cr3 + cr4 ) + ( 1<<2 ) ) >> 3;

            yQuad++;
        }
    }
    return 0;
}
