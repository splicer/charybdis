#include <stdio.h>
#include <rgb2y.h>

#define USE_STDIN

#if !defined( USE_STDIN )
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

static const rgb2y_yQuad_t expectedYccImage[4] = {
    { { 235, 235, 235, 235 }, 128, 128 },
    { { 235, 235, 235, 235 }, 128, 128 },
    { { 68, 49, 57, 54 }, 105, 196 },
    { { 68, 49, 57, 54 }, 105, 196 }
};

static rgb2y_yQuad_t yccImage[1];
#endif // USE_STDIN


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
#if defined( USE_STDIN )
    unsigned int rgbUint[12];
    rgb2y_rgbPixel_t rgb[4];
    rgb2y_yQuad_t ycc[1];

    if( 12 != scanf( "%u %u %u %u %u %u %u %u %u %u %u %u",
                    &rgbUint[0], &rgbUint[1], &rgbUint[2],
                    &rgbUint[3], &rgbUint[4], &rgbUint[5],
                    &rgbUint[6], &rgbUint[7], &rgbUint[8],
                    &rgbUint[9], &rgbUint[10], &rgbUint[11] ) ) {
        fprintf( stderr, "please supply 12 decimals\n" );
        return 1;
    }

    rgb[0].r = ( uint8_t )rgbUint[0];
    rgb[0].g = ( uint8_t )rgbUint[1];
    rgb[0].b = ( uint8_t )rgbUint[2];
    rgb[1].r = ( uint8_t )rgbUint[3];
    rgb[1].g = ( uint8_t )rgbUint[4];
    rgb[1].b = ( uint8_t )rgbUint[5];
    rgb[2].r = ( uint8_t )rgbUint[6];
    rgb[2].g = ( uint8_t )rgbUint[7];
    rgb[2].b = ( uint8_t )rgbUint[8];
    rgb[3].r = ( uint8_t )rgbUint[9];
    rgb[3].g = ( uint8_t )rgbUint[10];
    rgb[3].b = ( uint8_t )rgbUint[11];

    rgb2y_convertImage( rgb, 2, 2, ycc );
    printYccImage( ycc, 1 );
#else
    int retVal = rgb2y_convertImage( test_rgbImage, TEST_WIDTH, TEST_HEIGHT, yccImage );

    printf( "rgb2y_convertImage() returned %d\n", retVal );
    printf( "here's the ycc image:\n" );
    printYccImage( yccImage, TEST_WIDTH * TEST_HEIGHT / 4 );
    printf( "here's the expected ycc image:\n" );
    printYccImage( expectedYccImage, 4 );
#endif

    return 0;
}
