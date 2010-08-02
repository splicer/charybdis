#include <stdint.h>
#include <stdio.h>

#define IMG_ROWS    1
#define IMG_COLS    4
#define IMG_RGB     3

uint8_t image[IMG_ROWS][IMG_COLS][IMG_RGB] = {{
                                                {200, 0, 2}, {127, 0, 0}, {155, 2, 0}, {140, 4, 2}
                                            }};

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

int main()
{
    for( int i=0; i<IMG_ROWS; i++ ) {

        for( int j=0; j<IMG_COLS/4; j++ ) {

            int r = image[i][j][0];
            int g = image[i][j][1];
            int b = image[i][j][2];

            int y1 = rgb2y(r, g, b);
            int cb1 = rgb2cb(r, g, b);
            int cr1 = rgb2cr(r, g, b);

            r = image[i][j+1][0];
            g = image[i][j+1][1];
            b = image[i][j+1][2];

            int y2 = rgb2y(r, g, b);
            int cb2 = rgb2cb(r, g, b);
            int cr2 = rgb2cr(r, g, b);

            r = image[i][j+2][0];
            g = image[i][j+2][1];
            b = image[i][j+2][2];

            int y3 = rgb2y(r, g, b);
            int cb3 = rgb2cb(r, g, b);
            int cr3 = rgb2cr(r, g, b);

            r = image[i][j+3][0];
            g = image[i][j+3][1];
            b = image[i][j+3][2];

            int y4 = rgb2y(r, g, b);
            int cb4 = rgb2cb(r, g, b);
            int cr4 = rgb2cr(r, g, b);

            int cb = (cb1 + cb2 + cb3 + cb4) / 4 / 2;
            int cr = (cr1 + cr2 + cr3 + cr4) / 4 / 2;
        
            printf("Raw values:\n");
            printf("%3d %3d %3d\n", y1, cb1, cr1);
            printf("%3d %3d %3d\n", y2, cb2, cr2);
            printf("%3d %3d %3d\n", y3, cb3, cr3);
            printf("%3d %3d %3d\n\n", y4, cb4, cr4);

            printf("Averaged (y,y,y,y, cb,cr):\n");
            printf("%3d %3d %3d %3d\n", y1, y2, y3, y4);
            printf("%3d %3d\n", cb, cr);
        }
    }

    return 0;
}
