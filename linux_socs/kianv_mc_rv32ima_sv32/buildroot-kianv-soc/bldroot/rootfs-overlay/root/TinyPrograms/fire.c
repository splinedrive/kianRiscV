// A "doom fire" demo, by Dmitry Sokolov

#define GL_width  80
#define GL_height 50
#define GL_FPS 150
#include "GL_tty.h"

const char* palette[256] = {
    GL_RGB(  0,  0,   0), GL_RGB(  0,   4,  4), GL_RGB(  0,  16, 20), GL_RGB(  0,  28,  36),
    GL_RGB(  0,  32, 44), GL_RGB(  0,  36, 48), GL_RGB( 60,  24, 32), GL_RGB(100,  16,  16),
    GL_RGB(132,  12, 12), GL_RGB(160,   8,  8), GL_RGB(192,   8,  8), GL_RGB(220,   4,   4),
    GL_RGB(252,   0,  0), GL_RGB(252,   0,  0), GL_RGB(252,  12,  0), GL_RGB(252,  28,   0),
    GL_RGB(252,  40,  0), GL_RGB(252,  52,  0), GL_RGB(252,  64,  0), GL_RGB(252,  80,   0),
    GL_RGB(252,  92,  0), GL_RGB(252, 104,  0), GL_RGB(252, 116,  0), GL_RGB(252, 132,   0),
    GL_RGB(252, 144,  0), GL_RGB(252, 156,  0), GL_RGB(252, 156,  0), GL_RGB(252, 160,   0),
    GL_RGB(252, 160,  0), GL_RGB(252, 164,  0), GL_RGB(252, 168,  0), GL_RGB(252, 168,   0),
    GL_RGB(252, 172,  0), GL_RGB(252, 176,  0), GL_RGB(252, 176,  0), GL_RGB(252, 180,   0),
    GL_RGB(252, 180,  0), GL_RGB(252, 184,  0), GL_RGB(252, 188,  0), GL_RGB(252, 188,   0),
    GL_RGB(252, 192,  0), GL_RGB(252, 196,  0), GL_RGB(252, 196,  0), GL_RGB(252, 200,   0),
    GL_RGB(252, 204,  0), GL_RGB(252, 204,  0), GL_RGB(252, 208,  0), GL_RGB(252, 212,   0),
    GL_RGB(252, 212,  0), GL_RGB(252, 216,  0), GL_RGB(252, 220,  0), GL_RGB(252, 220,   0),
    GL_RGB(252, 224,  0), GL_RGB(252, 228,  0), GL_RGB(252, 228,  0), GL_RGB(252, 232,   0),
    GL_RGB(252, 232,  0), GL_RGB(252, 236,  0), GL_RGB(252, 240,  0), GL_RGB(252, 240,   0),
    GL_RGB(252, 244,  0), GL_RGB(252, 248,  0), GL_RGB(252, 248,  0), GL_RGB(252, 252,   0),
#define W GL_RGB(252,252,252)
    W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W,
    W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W,
    W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W,
    W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W,
    W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W,
    W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W,
    W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W,
    W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W
#undef W
};

static uint8_t fire[GL_width * GL_height];

void line_blur(int offset, int step, int nsteps) {
    uint8_t circ[3] = {0, fire[offset], fire[offset+step]};
    uint8_t beg = 1;
    for (int i=0; i<nsteps; i++) {
        fire[offset] = (circ[0]+circ[1]+circ[2])/3;
        circ[(beg+++2)%3] = i+2<nsteps ? fire[offset+2*step] : 0;
        offset += step;
    }
}

int myrand() {
   static long int randomseed = 0;
   randomseed = (randomseed * 1366l + 150889l) % 714025l;
   return (int)randomseed;
}


int main() {
    GL_init();
    for (;;) {
        GL_home();

        // box blur: first horizontal motion blur then vertical motion blur
        for (int j = 0; j<GL_height; j++)
            line_blur(j*GL_width, 1, GL_width);
        for (int i = 0; i<GL_width; i++)
            line_blur(i, GL_width, GL_height);
       
        for (int i = 0; i< GL_width*GL_height; i++) // cool
            if (!(myrand()&15) && fire[i]>0)
                fire[i]--;

        for (int i = 0; i<GL_width; i++) {       // add heat to the bed
            int idx = i+(GL_height-1)*GL_width;
            if (!(myrand()%32))
                fire[idx] = 128+myrand()%128;   // sparks
            else
                fire[idx] = fire[idx]<16 ? 16 : fire[idx]; // ember bed
        }

        for (int j = 0; j<GL_height; j+=2) {      // show the buffer
            for (int i = 0; i<GL_width; i++)
	        GL_set2pixelsIhere(
		   palette,fire[i+j*GL_width],
		           fire[i+(j+1)*GL_width]				   
		);
	    GL_newline();
        }

        for (int j = 1; j<GL_height; j++)        // scroll up
            for (int i = 0; i<GL_width; i++)
                fire[i+(j-1)*GL_width] = fire[i+j*GL_width] ;
       
        GL_swapbuffers();
        GL_swapbuffers();
    }
    return 0;
}

