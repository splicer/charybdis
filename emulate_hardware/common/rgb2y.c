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
    uint8_t y0 = ( uint8_t )( r * 65.7377882352941/255 + 0.5 );
    uint8_t y1 = ( uint8_t )( g * 129.0571294117647/255 + 0.5 );
    uint8_t y2 = ( uint8_t )( b * 25.0639058823529/255 + 0.5 );
    return y0 + y1 + y2 + 16;
}


/* 9-bit */
static inline uint16_t rgb2cb( uint8_t r, uint8_t g, uint8_t b )
{
    int16_t cb0 = ( int16_t )( r * 2 * -37.9450869960784/255 - 0.5 );
    int16_t cb1 = ( int16_t )( g * 2 * -74.4941286901961/255 - 0.5 );
    int16_t cb2 = ( int16_t )( b * 2 * 112.4392156862745/255 + 0.5 );
    return ( uint16_t )( cb0 + cb1 + cb2 + 128 * 2 );
}


/* 9-bit */
static inline uint16_t rgb2cr( uint8_t r, uint8_t g, uint8_t b )
{
    int16_t cr0 = ( int16_t )( r * 2 * 112.4392156862745/255 + 0.5 );
    int16_t cr1 = ( int16_t )( g * 2 * -94.1539006745098/255 - 0.5 );
    int16_t cr2 = ( int16_t )( b * 2 * -18.2853150117647/255 - 0.5 );
    return ( uint16_t )( cr0 + cr1 + cr2 + 128 * 2 );
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
