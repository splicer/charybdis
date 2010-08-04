#include <rgb2y.h>
#include <stdio.h>


/* 8-bit */
static inline int rgb2y(int r, int g, int b)
{
    int y = ((int)((65.738 * 256) + 0.5) * r) + ((int)((129.057 * 256) + 0.5) * g) + ((int)((25.064 * 256) + 0.5) * b) + (256*256) * 16;
    y = y / (256 * 256);
    return y;
}


/* 9-bit */
static inline int rgb2cb(int r, int g, int b)
{
    int cb = ((int)((-37.945 * 512) - 0.5) * r) + ((int)((-74.494 * 512) - 0.5) *g) + ((int)((112.439 *512) + 0.5) *b) + (512*256) * 128;
    cb = cb / (512 * 256);
    return cb;
}


/* 9-bit */
static inline int rgb2cr(int r, int g, int b)
{
    int cr = ((int)((112.439 * 512) + 0.5) * r) + ((int)((-94.154 * 512) - 0.5) *g) + ((int)((-18.285 * 512) - 0.5) *b) + (512*256) * 128;
    cr = cr / (512 * 256);
    return cr;
}


int rgb2y_convertImage( const rgb2y_rgbPixel_t *rgbImg,
                        uint16_t width,
                        uint16_t height,
                        rgb2y_yQuad_t *yccImg )
{
    rgb2y_yQuad_t *yQuad = yccImg;

    for( int i = 0; i < height; i+=2 ) {
        for( int j = 0; j < width; j+=2 ) {
            const rgb2y_rgbPixel_t *p = &rgbImg[i * width + j];

            yQuad->y[0] = rgb2y( p->r, p->g, p->b );
            int cb1 = rgb2cb( p->r, p->g, p->b );
            int cr1 = rgb2cr( p->r, p->g, p->b );
            p++;

            yQuad->y[1] = rgb2y( p->r, p->g, p->b );
            int cb2 = rgb2cb( p->r, p->g, p->b );
            int cr2 = rgb2cr( p->r, p->g, p->b );
            p = &rgbImg[(i+1) * width + j];

            yQuad->y[2] = rgb2y( p->r, p->g, p->b );
            int cb3 = rgb2cb( p->r, p->g, p->b );
            int cr3 = rgb2cr( p->r, p->g, p->b );
            p++;

            yQuad->y[3] = rgb2y( p->r, p->g, p->b );
            int cb4 = rgb2cb( p->r, p->g, p->b );
            int cr4 = rgb2cr( p->r, p->g, p->b );

            yQuad->cb = (cb1 + cb2 + cb3 + cb4) / 4 / 2;
            yQuad->cr = (cr1 + cr2 + cr3 + cr4) / 4 / 2;

            yQuad++;
        }
    }
    return 0;
}
