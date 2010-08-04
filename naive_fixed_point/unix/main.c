#include <stdio.h>
#include <rgb2y.h>

static const rgb2y_rgbPixel_t rgbImage[4] = {
    { 200, 0, 2 },
    { 127, 0, 0 },
    { 155, 2, 0 },
    { 140, 4, 2 }
};

static const rgb2y_yQuad_t expectedYccImage[1] = {
    { { 67, 48, 56, 54 }, 52, 97 }
};

static rgb2y_yQuad_t yccImage[1];


int main()
{
    int retVal = rgb2y_convertImage( rgbImage, 2, 2, yccImage );
    
    printf( "rgb2y_convertImage() returned %d\n", retVal );
    printf( "here's the ycc image:\n" );
    printf( "{{%u, %u, %u, %u}, %u, %u}\n",
            yccImage[0].y[0],
            yccImage[0].y[1],
            yccImage[0].y[2],
            yccImage[0].y[3],
            yccImage[0].cb,
            yccImage[0].cr );
    printf( "here's the expected ycc image:\n" );
    printf( "{{%u, %u, %u, %u}, %u, %u}\n",
            expectedYccImage[0].y[0],
            expectedYccImage[0].y[1],
            expectedYccImage[0].y[2],
            expectedYccImage[0].y[3],
            expectedYccImage[0].cb,
            expectedYccImage[0].cr );

    return 0;
}
