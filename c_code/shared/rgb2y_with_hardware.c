#include <rgb2y.h>

#define IN_MASK 0x00FFFFFF
#define Y_MASK  0x000000FF
#define C_MASK  0x000001FF
#define CB_SHFT 8
#define CR_SHFT 17


int rgb2y_convertImage( const rgb2y_rgbPixel_t *rgbImg,
                        uint16_t width,
                        uint16_t height,
                        rgb2y_yQuad_t *yccImg )
{
    rgb2y_yQuad_t *yQuad = yccImg;

    for( uint16_t i = 0; i < height; i+=2 ) {
        for( uint16_t j = 0; j < width; j+=2 ) {
            const rgb2y_rgbPixel_t *p = &rgbImg[i * width + j];
            
            uint32_t input;
            uint32_t result;
            uint32_t cb_sum = 0;
            uint32_t cr_sum = 0;
            
            /* Pack the input register bits as:
             * 0 to 7   -> red
             * 8 to 15  -> green
             * 16 to 23 -> blue
             *
             * This cast works correctly on little-endian machines (tested), but might not on big-endian machines.
             */
            input = *((uint32_t *)p) & IN_MASK;

            /* Call Hardware */
            asm("rtoy %[result], %[input]" : [result] "=r" (result) : [input] "r" (input) );

            yQuad->y[0] = result & Y_MASK;
            cb_sum += (result >> CB_SHFT) & C_MASK;
            cr_sum += (result >> CR_SHFT) & C_MASK;

            p++;
            

            /* Pack the input register bits as:
             * 0 to 7   -> red
             * 8 to 15  -> green
             * 16 to 23 -> blue
             *
             * This cast works correctly on little-endian machines (tested), but might not on big-endian machines.
             */
            input = *((uint32_t *)p) & IN_MASK;

            /* Call Hardware */
            asm("rtoy %[result], %[input]" : [result] "=r" (result) : [input] "r" (input) );

            yQuad->y[0] = result & Y_MASK;
            cb_sum += (result >> CB_SHFT) & C_MASK;
            cr_sum += (result >> CR_SHFT) & C_MASK;
            
            p = &rgbImg[(i+1) * width + j];


            /* Pack the input register bits as:
             * 0 to 7   -> red
             * 8 to 15  -> green
             * 16 to 23 -> blue
             *
             * This cast works correctly on little-endian machines (tested), but might not on big-endian machines.
             */
            input = *((uint32_t *)p) & IN_MASK;

            /* Call Hardware */
            asm("rtoy %[result], %[input]" : [result] "=r" (result) : [input] "r" (input) );

            yQuad->y[0] = result & Y_MASK;
            cb_sum += (result >> CB_SHFT) & C_MASK;
            cr_sum += (result >> CR_SHFT) & C_MASK;
            
            p++;


            /* Pack the input register bits as:
             * 0 to 7   -> red
             * 8 to 15  -> green
             * 16 to 23 -> blue
             *
             * This cast works correctly on little-endian machines (tested), but might not on big-endian machines.
             */
            input = *((uint32_t *)p) & IN_MASK;

            /* Call Hardware */
            asm("rtoy %[result], %[input]" : [result] "=r" (result) : [input] "r" (input) );

            yQuad->y[0] = result & Y_MASK;
            cb_sum += (result >> CB_SHFT) & C_MASK;
            cr_sum += (result >> CR_SHFT) & C_MASK;

            // downsample 4 9-bit values to 1 8-bit value for Cb and Cr
            yQuad->cb = ( cb_sum + ( 1<<2 ) ) >> 3;
            yQuad->cr = ( cr_sum + ( 1<<2 ) ) >> 3;

            yQuad++;
        }
    }
    return 0;
}
