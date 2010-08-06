#include <test.h>
#include <stdbool.h>
#include <rgb2y.h>

#define RUN_TEST( num ) \
    ( test ## num() ? 0 : 1 << num )


static bool test0()
{
    return true;
}


static bool test1()
{
    return true;
}


uint32_t test_runTests()
{
    uint32_t results = 0;

    results |= RUN_TEST( 0 );
    results |= RUN_TEST( 1 );

    return results;
}
