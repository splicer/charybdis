#include <stdio.h>
#include <rgb2y.h>

#define TEST_WIDTH 4
#define TEST_HEIGHT 4

static const rgb2y_rgbPixel_t test_rgbImage[TEST_WIDTH * TEST_HEIGHT] = {
    { 0xff, 0xff, 0xff },
    { 0xff, 0xff, 0xff },
    { 0xff, 0xff, 0xff },
    { 0xff, 0xff, 0xff },
    { 0xff, 0xff, 0xff },
    { 0xff, 0xff, 0xff },
    { 0xff, 0xff, 0xff },
    { 0xff, 0xff, 0xff },
    { 200, 0, 2 },
    { 127, 0, 0 },
    { 200, 0, 2 },
    { 127, 0, 0 },
    { 155, 2, 0 },
    { 140, 4, 2 },
    { 155, 2, 0 },
    { 140, 4, 2 }
};

static const rgb2y_yQuad_t expectedYccImage[1] = {
    { { 67, 49, 57, 54 }, 105, 196 }
};

static rgb2y_yQuad_t yccImage[1];


static void printYccImage( const rgb2y_yQuad_t *img, uint16_t numElements )
{
    for( uint16_t i = 0; i < numElements; i++ ) {
        printf( "{{%u, %u, %u, %u}, %u, %u}\n",
                img[i].y[0],
                img[i].y[1],
                img[i].y[2],
                img[i].y[3],
                img[i].cb,
                img[i].cr );
    }
}


int main()
{
    int retVal = rgb2y_convertImage( test_rgbImage, TEST_WIDTH, TEST_HEIGHT, yccImage );

    printf( "rgb2y_convertImage() returned %d\n", retVal );
    printf( "here's the ycc image:\n" );
    printYccImage( yccImage, TEST_WIDTH * TEST_HEIGHT / 4 );
    printf( "here's the expected ycc image:\n" );
    printYccImage( expectedYccImage, 1 );

    return 0;
}
