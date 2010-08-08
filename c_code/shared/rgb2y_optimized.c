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
 *
 * According to a test of 1000000 random vectors, this implementation produces a
 * perfect result 99.95 % of the time. In the other 0.05 %, the error is ±1.
 */

/* 8-bit */
static inline uint8_t rgb2y( uint8_t r, uint8_t g, uint8_t b )
{
    uint32_t y = ( ( uint32_t )( ( 65.7377882352941 * ( 1<<16 ) ) + 0.5 ) ) * r +
        ( ( uint32_t )( ( 129.0571294117647 * ( 1<<16 ) ) + 0.5 ) ) * g +
        ( ( uint32_t )( ( 25.0639058823529 * ( 1<<16 ) ) + 0.5 ) ) * b +
        ( 256 * ( 1<<16 ) ) * 16;
    y = ( y + ( 1<<23 ) ) >> 24;
    return ( uint8_t )y;
}


/* 30-bit */
static inline uint32_t rgb2cb( uint8_t r, uint8_t g, uint8_t b )
{
    int32_t cb = ( ( int32_t )( ( -37.9450869960784 * ( 1<<15 ) ) - 0.5 ) ) * r +
        ( ( int32_t )( ( -74.4941286901961 * ( 1<<15 ) ) - 0.5 ) ) * g +
        ( ( int32_t )( ( 112.4392156862745 * ( 1<<15 ) ) + 0.5 ) ) * b +
        ( 256 * ( 1<<15 ) ) * 128;
    cb = ( cb + 1 ) >> 1;
    return ( uint32_t )cb;
}


/* 30-bit */
static inline uint32_t rgb2cr( uint8_t r, uint8_t g, uint8_t b )
{
    int32_t cr = ( ( int32_t )( ( 112.4392156862745 * ( 1<<15 ) ) + 0.5 ) ) * r +
        ( ( int32_t )( ( -94.1539006745098 * ( 1<<15 ) ) - 0.5 ) ) * g +
        ( ( int32_t )( ( -18.2853150117647 * ( 1<<15 ) ) - 0.5 ) ) * b +
        ( 256 * ( 1<<15 ) ) * 128;
    cr = ( cr + 1 ) >> 1;
    return ( uint32_t )cr;
}


int rgb2y_convertImage( const rgb2y_rgbPixel_t * restrict rgbImg,
                        uint16_t width,
                        uint16_t height,
                        rgb2y_yQuad_t * restrict yccImg )
{
    register rgb2y_yQuad_t *yQuad = yccImg;
    register const rgb2y_rgbPixel_t *p = rgbImg;

    for( uint16_t i = 0; i < height; i+=2 ) {
        for( uint16_t j = 0; j < width; j+=2 ) {

            yQuad->y[0] = rgb2y( p->r, p->g, p->b );
            uint32_t cb1 = rgb2cb( p->r, p->g, p->b );
            uint32_t cr1 = rgb2cr( p->r, p->g, p->b );
            p++;

            yQuad->y[1] = rgb2y( p->r, p->g, p->b );
            uint32_t cb2 = rgb2cb( p->r, p->g, p->b );
            uint32_t cr2 = rgb2cr( p->r, p->g, p->b );
            p = (p + width - 1);

            yQuad->y[2] = rgb2y( p->r, p->g, p->b );
            uint32_t cb3 = rgb2cb( p->r, p->g, p->b );
            uint32_t cr3 = rgb2cr( p->r, p->g, p->b );
            p++;

            yQuad->y[3] = rgb2y( p->r, p->g, p->b );
            uint32_t cb4 = rgb2cb( p->r, p->g, p->b );
            uint32_t cr4 = rgb2cr( p->r, p->g, p->b );
            p = (p - width + 1);

            // downsample 4 30-bit values to 1 8-bit value for Cb and Cr
            yQuad->cb = ( ( cb1 + cb2 + cb3 + cb4 ) + ( 1<<23 ) ) >> 24;
            yQuad->cr = ( ( cr1 + cr2 + cr3 + cr4 ) + ( 1<<23 ) ) >> 24;

            yQuad++;
        }
    }
    return 0;
}
