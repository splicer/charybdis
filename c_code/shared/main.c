#include <rgb2y.h>
#include <cute_parrot_test.h>

rgb2y_yQuad_t ycc[CUTE_PARROT_TEST_WIDTH * CUTE_PARROT_TEST_HEIGHT / 4];


int main()
{
    rgb2y_convertImage( ( rgb2y_rgbPixel_t * )CuteParrotTestRgbImg,
                        CUTE_PARROT_TEST_WIDTH,
                        CUTE_PARROT_TEST_HEIGHT,
                        ycc );

    return 0;
}
