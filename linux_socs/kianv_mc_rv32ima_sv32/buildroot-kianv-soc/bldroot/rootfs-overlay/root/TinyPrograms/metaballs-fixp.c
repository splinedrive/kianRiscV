#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <math.h>

#define POW2_24 (1<<24)
#define FPS 50
#define WIDTH 80
#define HEIGHT 50
#define CLAMP(x, low, high) (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))
#define ABS(a) (((a) < 0) ? -(a) : (a))

int32_t iTime = 0;
// sin(x) = x * (1 + x^2 * (0.00761 * x^2 - 0.16605))
// this formula works pretty well in the range [-pi/2, +pi/2]
// x is fixed-point 24 bit precision
int32_t sin24(int32_t x) {
    int32_t sign;
    if (x>0) { sign = 1; } else { sign = -1; x = -x; }    //
    while (x>79060768) { x = x - 105414357; }             // reduce the argument to the acceptable range
    if (x>26353589) { return sign*sin24(52707179 - x); }  //
    return sign*(x/4096)*((16777216 + (((x/4096)*(x/4096))/4096)*((((x/4096)*(x/4096))/131 - 2785856)/4096))/4096);
}

// cos(x) = 1 + x^2 * (0.03705 * x^2 - 0.49670))
// this formula works pretty well in the range [-pi/2, +pi/2]
// x is fixed-point 24 bit precision
int32_t cos24(int32_t x) {
    if (x<0) { x = -x; }                             //
    while (x>79060768) { x = x - 105414357; }        // reduce the argument to the acceptable range
    if (x>26353589) { return -sin24(x - 26353589); } //
    return 16777216 + (((x/4096)*(x/4096))/4096)*((((x/4096)*(x/4096))/27 - 8333243)/4096);
}

// square root of a fixed-point number
// stored in a 32 bit integer variable, shift is the precision
int32_t sqrtfp(int32_t n, int32_t shift) {
    int32_t x;
    int32_t x_old;
    int32_t n_one;

    if (n > 2147483647/shift) { // pay attention to potential overflows
        return 2 * sqrtfp(n / 4, shift);
    }
    x = shift; // initial guess 1.0, can do better, but oh well
    n_one = n * shift; // need to compensate for fixp division
    for (;;) {
        x_old = x;
        x = (x + n_one / x) / 2;
        if (ABS(x - x_old) <= 1) {
            return x;
        }
    }
}

void mainImage(int32_t fragCoord_x, int32_t fragCoord_y) { // kinda shadertoy naming :)
    int32_t u; int32_t v;
    int32_t fragColor_r; int32_t fragColor_g; int32_t fragColor_b;
    int32_t sdf;
    int32_t a; int32_t b; int32_t c; int32_t d; int32_t e;
    int32_t d1; int32_t d2; int32_t d3;
    u = ((2*fragCoord_x - WIDTH )*POW2_24)/HEIGHT;
    v = ((2*fragCoord_y - HEIGHT)*POW2_24)/HEIGHT;
    a = sin24(iTime/2)-u;
    b = sin24(iTime/2)-v;
    c = cos24(iTime/2)-v;
    d = sin24(iTime/4)-u;
    e = sin24(iTime  )-v;
    d1 = ((POW2_24*6/10)/CLAMP(sqrtfp((a/4096)*(a/4096) + (b/4096)*(b/4096), POW2_24)/4096,100,10000))*4096; // linear motion
    d2 = ((POW2_24*6/10)/CLAMP(sqrtfp((a/4096)*(a/4096) + (c/4096)*(c/4096), POW2_24)/4096,100,10000))*4096; // circular motion
    d3 = ((POW2_24*6/10)/CLAMP(sqrtfp((d/4096)*(d/4096) + (e/4096)*(e/4096), POW2_24)/4096,100,10000))*4096; // wave
    sdf = d1 + d2 + d3 - (POW2_24*22)/10;
    fragColor_r = ((255*17*((sdf+POW2_24)/4096))/10)/4096;     // orange halo (red and green channels)
    fragColor_g = ((255*8*((sdf+POW2_24)/4096))/10)/4096;
    fragColor_b = 255; if (sdf<0) { fragColor_b = 0; }
    printf("%d;%d;%d", CLAMP(fragColor_r,0,255), CLAMP(fragColor_g, 0, 255), CLAMP(fragColor_b, 0, 255));
}

int main () {
    printf("\033[2j\033[?25l"); // clear screen and hide cursor
    for (;;) {
        printf("\033[H"); // home
        for (int j = 0; j<HEIGHT; j+=2) {
            for (int i = 0; i<WIDTH; i++) {
                printf("\033[48;2;"); mainImage(i, j+0); printf("m");  // set background color
                printf("\033[38;2;"); mainImage(i, j+1); printf("m");  // set foreground color
                printf("\xE2\x96\x83");                                // half-block Unicode symbol
            }
            printf("\033[49m\n");
        }
        usleep(1000000/FPS);
        iTime += POW2_24/(FPS/2);
        if (iTime>POW2_24*100) iTime = 0; // 100 approx 32 pi :)
    }
    return 0;
}

