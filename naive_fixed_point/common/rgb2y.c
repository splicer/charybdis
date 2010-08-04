#include <rgb2y.h>
#include <stdio.h>


/* 8-bit */
static inline uint16_t rgb2y( uint8_t r, uint8_t g, uint8_t b )
{
    uint32_t y = ( ( uint32_t )( ( 65.738 * 256 ) + 0.5 ) * r ) +
        ( ( uint32_t )( ( 129.057 * 256 ) + 0.5 ) * g ) +
        ( (uint32_t )( ( 25.064 * 256 ) + 0.5 ) * b ) +
        ( 256 * 256 ) * 16;
    y = y / ( 256 * 256 );
    return ( uint16_t )y;
}


/* 9-bit */
static inline uint16_t rgb2cb( uint8_t r, uint8_t g, uint8_t b )
{
    int32_t cb = ( ( int32_t )( ( -37.945 * 512 ) - 0.5 ) * r ) +
        ( ( int32_t )( ( -74.494 * 512 ) - 0.5 ) * g ) +
        ( ( int32_t )( ( 112.439 * 512 ) + 0.5 ) * b ) +
        ( 512 * 256 ) * 128;
    cb = cb / ( 256 * 256 );
    return ( uint16_t )cb;
}


/* 9-bit */
static inline uint16_t rgb2cr( uint8_t r, uint8_t g, uint8_t b )
{
    int32_t cr = ( ( int32_t )( ( 112.439 * 512 ) + 0.5 ) * r ) +
        ( ( int32_t )( ( -94.154 * 512 ) - 0.5 ) * g ) +
        ( ( int32_t )( ( -18.285 * 512 ) - 0.5 ) * b ) +
        ( 512 * 256 ) * 128;
    cr = cr / ( 256 * 256 );
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

            yQuad->cb = (cb1 + cb2 + cb3 + cb4) / 4 / 2;
            yQuad->cr = (cr1 + cr2 + cr3 + cr4) / 4 / 2;

            yQuad++;
        }
    }
    return 0;
}
