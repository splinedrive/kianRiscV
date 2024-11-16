#include <stdio.h>
#include <unistd.h>
#include <stdint.h>

#define POW2_24 (1<<24)
#define FPS 24
#define MULTI 2
#define WIDTH (80*MULTI)
#define HEIGHT (50*MULTI)
#define CLAMP(x, low, high) (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))

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

int32_t mul24(int32_t a, int32_t b) {
    return (a/4096)*(b/4096);
}

int32_t div24(int32_t a, int32_t b) {
    return (a/(b/4096))*4096;
}

int32_t iTime = 0;

void mainImage(int32_t fragCoord_x, int32_t fragCoord_y, int32_t *fragColor_r, int32_t *fragColor_g, int32_t *fragColor_b) { // kinda shadertoy naming :)
    int32_t u; int32_t v;
    int32_t horizon = (POW2_24*3)/10;
    int32_t persp;

    int32_t t, t3;
    int32_t x, y;
    int32_t band;

    u =  ((fragCoord_x - WIDTH /2)*POW2_24)/HEIGHT;
    v = -((fragCoord_y - HEIGHT/2)*POW2_24)/HEIGHT;

    if (v>horizon) {
        *fragColor_r = (255*((POW2_24-v)/4096))/4096; // sky
        *fragColor_g = 128;
        *fragColor_b = 178;
    } else {
        persp = div24(POW2_24, horizon + POW2_24/13 - v);
        t = sin24(iTime/4);
        t3 = mul24(mul24(t, t), t);
        x = t3 + mul24(u, persp) - mul24(mul24(t3/10, persp), persp);
        if (x>10*POW2_24 || x<-10*POW2_24) { // ugly hack to avoid overflow: if x is large, it is grass
            *fragColor_r = 0;
            *fragColor_g = 178;
            *fragColor_b = 0;
        } else {
            x = mul24(x, x);
            y = 2*persp+ 20*iTime;
            band = sin24(y)>0;
            if (x>4*POW2_24) { // grass
                *fragColor_r = 0;
                *fragColor_g = 178;
                *fragColor_b = 0;
            } else if (x>2*POW2_24) { // red-white curb
                if (band) {
                    *fragColor_r = *fragColor_g =  *fragColor_b = 255;
                } else {
                    *fragColor_r = 255;
                    *fragColor_g = 0;
                    *fragColor_b = 0;
                }
            } else  { // road
                *fragColor_r = *fragColor_g =  *fragColor_b = 128; // asphalt
                if (x<POW2_24/66 && !band) { // central line
                    *fragColor_r = *fragColor_g = *fragColor_b = 255;
                }
            }
        }
        *fragColor_r = CLAMP((*fragColor_r*((POW2_24-v)/4096))/4096, 0, 255);
        *fragColor_g = CLAMP((*fragColor_g*((POW2_24-v)/4096))/4096, 0, 255);
        *fragColor_b = CLAMP((*fragColor_b*((POW2_24-v)/4096))/4096, 0, 255);
    }
}

void multisample(int32_t fragCoord_x, int32_t fragCoord_y, int32_t *fragColor_r, int32_t *fragColor_g, int32_t *fragColor_b) {
    int32_t r[MULTI*MULTI], g[MULTI*MULTI], b[MULTI*MULTI];
    for (int32_t j=0; j<MULTI; j++)
        for (int32_t i=0; i<MULTI; i++)
            mainImage(fragCoord_x+i, fragCoord_y+j, &(r[i+j*MULTI]), &(g[i+j*MULTI]), &(b[i+j*MULTI]));

    *fragColor_r = *fragColor_g = *fragColor_b = 0;
    for (int32_t i=0; i<MULTI*MULTI; i++) {
        *fragColor_r += r[i];
        *fragColor_g += g[i];
        *fragColor_b += b[i];
    }
    *fragColor_r /= MULTI*MULTI;
    *fragColor_g /= MULTI*MULTI;
    *fragColor_b /= MULTI*MULTI;
}

int main() {
    int32_t fragColor_r, fragColor_g, fragColor_b;
    printf("\033[2J\033[?25l"); // clear screen and hide cursor
    for (;;) {
        printf("\033[H"); // home
        for (int j = 0; j<HEIGHT/MULTI; j+=2) {
            for (int i = 0; i<WIDTH/MULTI; i++) {
                multisample(i*MULTI, (j+0)*MULTI, &fragColor_r, &fragColor_g, &fragColor_b);
                printf("\033[48;2;%d;%d;%dm", fragColor_r, fragColor_g, fragColor_b);  // set background color
                multisample(i*MULTI, (j+1)*MULTI, &fragColor_r, &fragColor_g, &fragColor_b);
                printf("\033[38;2;%d;%d;%dm", fragColor_r, fragColor_g, fragColor_b);  // set foreground color
                printf("\xE2\x96\x83");  // half-block Unicode symbol
            }
            printf("\033[49m\n");
        }
        usleep(1000000/FPS);
        iTime += POW2_24/(FPS/2);
        if (iTime>POW2_24*100) iTime = 0; // 100 approx 32 pi :)
    }
    return 0;
}

