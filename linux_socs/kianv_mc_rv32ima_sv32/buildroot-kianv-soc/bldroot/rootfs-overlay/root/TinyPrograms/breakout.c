// "pong war" (0 player breakout game) by Dmitry Sokolov
// Similar things: https://github.com/vnglst/pong-wars/blob/main/index.html

#include <stdlib.h>
#include <stdbool.h>
#define GL_FPS 30
#include "GL_tty.h"

#define ABS(a) (((a) < 0) ? -(a) : (a))
#define CLAMP(x, low, high) (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))

const char* palette[2] = { GL_RGB(187,204,51), GL_RGB(213,48,49) };
struct Ball { int x[2], v[2]; } balls[2];
bool field[48*48]; // battlefield. The brick grid is 16x16, but it is zoomed x4 for more fluid motion
int score = 128;   // half of 16x16, duh

int xor_field(int x, int y, bool ball) { // flip a 4x4 block of the battlefield
    int hit = -1;                        // N.B. it is not aligned to the brick grid
    for (int j=0; j<4; j++)
        for (int i=0; i<4; i++) {
            int idx = x+i+(y+j)*48;
            if ((field[idx] ^= true)==ball) hit = idx; // if a ball hits a brick, return the brick position
        }
    return hit;
}

int main() {
    balls[0].x[0] = 3;  balls[0].x[1] = 3; // initial position and speed for two balls
    balls[0].v[0] = 1;  balls[0].v[1] = 3;
    balls[1].x[0] = 41; balls[1].x[1] = 43;
    balls[1].v[0] = 1;  balls[1].v[1] = -3;

    for (int i=0; i<48*48; i++)
        field[i] = i<48*48/2; // initialize the battlefield

    GL_init();
    for (;;) {
        GL_home();
        for (int b=0; b<2; b++) { // for each ball
            for (int d=0; d<2; d++ ) { // for each coordinate
                for (int i=0; i<ABS(balls[b].v[d]); i++) { // move the ball one step at a time
                    balls[b].x[d] += balls[b].v[d] > 0 ? 1 : -1;
                    if (balls[b].x[d]<0 || balls[b].x[d]>48-4) { // bounce the ball from the walls
                        balls[b].x[d] = CLAMP(balls[b].x[d], 0, 48-4);
                        balls[b].v[d] = -balls[b].v[d];
                        break;
                    }
                    int hit = xor_field(balls[b].x[0], balls[b].x[1], !b); xor_field(balls[b].x[0], balls[b].x[1], !b);
                    if (hit!=-1) { // if we hit a brick
                        score += b ? 1 : -1; // update the score
                        xor_field(((hit%48)/4)*4, ((hit/48)/4)*4, !b); // snap the hit to the brick grid and break the brick
                        balls[b].v[d] = -balls[b].v[d]; // bounce the ball off the brick
                        balls[b].x[d] += balls[b].v[d] > 0 ? 1 : -1;
#if 0
                        int dim = rand()%2;    // break the regularity, alter the speed randomly
                        int inc = rand()%3-1;  // however do not go too fast nor change direction
                        if (balls[b].v[dim]+inc!=0 && ABS(balls[b].v[dim]+inc)<4)
                            balls[b].v[dim] += inc;
#endif
                        break;
                    }
                }
            }
        }


       
        for (int b=0; b<2; b++) // imprint the balls into the battlefield
            xor_field(balls[b].x[0], balls[b].x[1], b);
        
        for (int j=0; j<48; j+=2) {
            for (int i=0; i<48; i++)
                GL_set2pixelsIhere(
                    palette,
                    field[i + j*48],
                    field[i + (j+1)*48]
                    );
            GL_newline();
        }

        for (int b=0; b<2; b++) // clear the balls from the battlefield
            xor_field(balls[b].x[0], balls[b].x[1], b);

        // Draw the balls as two hexagons (composed of triangles and black squares)
        // How to find unicode characters:
        // https://www.w3.org/TR/xml-entity-names/025.html
	// https://onlineunicodetools.com/convert-unicode-to-utf8
	// https://copypastecharacter.com/
	/*
	   // commented out because on some tty emulators, font is different and makes
	   // it look really bad, so kept initial "block ball" instead...
        for(int b=0; b<2; ++b) {
            int x = balls[b].x[0];
            int y = balls[b].x[1];
            int bkg = field[x+y*48];

            printf("\033[38;2;%sm",palette[b]);	   	   
            printf("\033[48;2;%sm",palette[bkg]);

            GL_gotoxy(x+1,y/2+1);
            printf("\xE2\x97\xA2\xE2\x96\x88\xE2\x96\x88\xE2\x97\xA3");
            GL_gotoxy(x+1,y/2+2);
            printf("\xE2\x97\xA5\xE2\x96\x88\xE2\x96\x88\xE2\x97\xA4");
        }
        */
        
        GL_gotoxy(0,25);
        printf("\033[48;2;%sm",palette[0]); // show current score
        printf("\033[38;2;%sm",palette[1]);
        printf("%d", score);
        printf("\033[48;2;%sm",palette[1]);
        printf("\033[38;2;%sm",palette[0]);
        printf("%d", 256-score);

        GL_swapbuffers();
    }
    return 0;
}

