#include <stdio.h>
#include <stdlib.h>
#include <rgb2y.h>


static void printYccImage( const rgb2y_yQuad_t *img, uint16_t numElements )
{
    for( uint16_t i = 0; i < numElements; i++ ) {
        printf( "%u %u %u %u %u %u\n",
                img[i].y[0],
                img[i].y[1],
                img[i].y[2],
                img[i].y[3],
                img[i].cb,
                img[i].cr );
    }
}


int main( int argc, char *argv[] )
{
    unsigned int rgbUint[12];
    rgb2y_rgbPixel_t rgb[4];
    rgb2y_yQuad_t ycc[1];

    if( argc != 13 ) {
        fprintf( stderr, "please supply 12 decimals\n" );
        return 1;
    }

    for( int i = 1; i < 13; i++ ) {
        rgbUint[i] = atoi( argv[i] );
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

    return 0;
}
