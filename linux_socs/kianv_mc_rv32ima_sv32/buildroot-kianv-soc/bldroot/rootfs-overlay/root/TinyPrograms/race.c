// inspired by http://www.extentofthejam.com/pseudo/
#include <stdio.h>
#include <unistd.h>
#include <math.h>

#define FPS 24
#define MULTI 2
#define WIDTH (80*MULTI)
#define HEIGHT (50*MULTI)
#define CLAMP(x, low, high) (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))

float iTime = 0;

void mainImage(int fragCoord_x, int fragCoord_y, int *fragColor_r, int *fragColor_g, int *fragColor_b) { // kinda shadertoy naming :)
    float horizon = .32;
    float u =  (fragCoord_x -  WIDTH/2.)/HEIGHT;
    float v = -(fragCoord_y - HEIGHT/2.)/HEIGHT;

    float persp = 1./((horizon+.05)-v);
    float t = sin(iTime/4.);
    float t3 = t*t*t;
    float x = pow(t3 + u*persp - .05*t3*persp*persp, 2.);
    float y = 2.*persp+20.*iTime;
    int band = sin(y)>0;

    if (v>horizon) {
        *fragColor_r = 255*(1.-v); // sky
        *fragColor_g = 128;
        *fragColor_b = 178;
    } else {
        if (x>4.) { // grass
            *fragColor_r = 0;
            *fragColor_g = 178;
            *fragColor_b = 0;
        } else if (x>2.) { // red-white curb
            if (band) {
                *fragColor_r = *fragColor_g =  *fragColor_b = 255;
            } else {
                *fragColor_r = 255;
                *fragColor_g = 0;
                *fragColor_b = 0;
            }
        } else  { // road
            *fragColor_r = *fragColor_g =  *fragColor_b = 128; // asphalt
            if (x<.015 && !band) { // central line
                *fragColor_r = *fragColor_g = *fragColor_b = 255;
            }
        }
        *fragColor_r = CLAMP(*fragColor_r*(1-v), 0, 255);
        *fragColor_g = CLAMP(*fragColor_g*(1-v), 0, 255);
        *fragColor_b = CLAMP(*fragColor_b*(1-v), 0, 255);
    }
}

void multisample(int fragCoord_x, int fragCoord_y, int *fragColor_r, int *fragColor_g, int *fragColor_b) {
    int r[MULTI*MULTI], g[MULTI*MULTI], b[MULTI*MULTI];
    for (int j=0; j<MULTI; j++)
        for (int i=0; i<MULTI; i++)
            mainImage(fragCoord_x+i, fragCoord_y+j, &(r[i+j*MULTI]), &(g[i+j*MULTI]), &(b[i+j*MULTI]));

    *fragColor_r = *fragColor_g = *fragColor_b = 0;
    for (int i=0; i<MULTI*MULTI; i++) {
        *fragColor_r += r[i];
        *fragColor_g += g[i];
        *fragColor_b += b[i];
    }
    *fragColor_r /= MULTI*MULTI;
    *fragColor_g /= MULTI*MULTI;
    *fragColor_b /= MULTI*MULTI;
}

int main() {
    int fragColor_r, fragColor_g, fragColor_b;
    printf("\033[2J\033[?25l"); // clear screen and hide cursor
    for (;;) {
        printf("\033[H"); // home
        for (int j = 0; j<HEIGHT/MULTI; j+=2) {
            for (int i = 0; i<WIDTH/MULTI; i++) {
                multisample(i*MULTI, (j+0)*MULTI, &fragColor_r, &fragColor_g, &fragColor_b);
                printf("\033[48;2;%d;%d;%dm", fragColor_r, fragColor_g, fragColor_b);  // set background color
                multisample(i*MULTI, (j+1)*MULTI, &fragColor_r, &fragColor_g, &fragColor_b);
                printf("\033[38;2;%d;%d;%dm", fragColor_r, fragColor_g, fragColor_b);  // set foreground color
                printf("\xE2\x96\x83");           // half-block Unicode symbol
            }
            printf("\033[49m\n");
        }
        usleep(1000000/FPS);
        iTime += 1./FPS;
    }
    return 0;
}
