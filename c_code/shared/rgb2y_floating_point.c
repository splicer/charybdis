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

static inline uint8_t rgb2y( uint8_t r, uint8_t g, uint8_t b )
{
    double y = 65.7377882352941/256 * r + 129.0571294117647/256 * g + 25.0639058823529/256 * b + 16;
    return ( uint8_t )( y + 0.5 );
}


static inline double rgb2cb( uint8_t r, uint8_t g, uint8_t b )
{
    return -37.9450869960784/256 * r - 74.4941286901961/256 * g + 112.4392156862745/256 * b + 128;
}


static inline double rgb2cr( uint8_t r, uint8_t g, uint8_t b )
{
    return 112.4392156862745/256 * r - 94.1539006745098/256 * g - 18.2853150117647/256 * b + 128;
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
            double cb1 = rgb2cb( p->r, p->g, p->b );
            double cr1 = rgb2cr( p->r, p->g, p->b );
            p++;

            yQuad->y[1] = rgb2y( p->r, p->g, p->b );
            double cb2 = rgb2cb( p->r, p->g, p->b );
            double cr2 = rgb2cr( p->r, p->g, p->b );
            p = &rgbImg[(i+1) * width + j];

            yQuad->y[2] = rgb2y( p->r, p->g, p->b );
            double cb3 = rgb2cb( p->r, p->g, p->b );
            double cr3 = rgb2cr( p->r, p->g, p->b );
            p++;

            yQuad->y[3] = rgb2y( p->r, p->g, p->b );
            double cb4 = rgb2cb( p->r, p->g, p->b );
            double cr4 = rgb2cr( p->r, p->g, p->b );

            // average the Cb and Cr values
            yQuad->cb = ( uint8_t )( ( cb1 + cb2 + cb3 + cb4 ) / 4 + 0.5 );
            yQuad->cr = ( uint8_t )( ( cr1 + cr2 + cr3 + cr4 ) / 4 + 0.5 );

            yQuad++;
        }
    }
    return 0;
}
