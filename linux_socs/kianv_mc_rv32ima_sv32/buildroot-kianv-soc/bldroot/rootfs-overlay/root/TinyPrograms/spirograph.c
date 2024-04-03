/*
 * Displays rotating squares
 * Bruno Levy, 2020-2024
 */

#include "GL_tty.h"
//#include <stdlib.h>
//#include <unistd.h>

int sintab[64] = {
   0,25,49,74,97,120,142,162,181,197,212,225,236,244,251,254,
   256,254,251,244,236,225,212,197,181,162,142,120,97,74,49,25,
   0,-25,-49,-74,-97,-120,-142,-162,-181,-197,-212,-225,-236,-244,
   -251,-254,-256,-254,-251,-244,-236,-225,-212,-197,-181,-162,
   -142,-120,-97,-74,-49,-25
};

int main() {
    GL_init();
    GL_clear();
    int frame;

    for(;;) {
	int pts[8];

	if(frame & (1 << 6)) {
	    GL_clear();
	}
	int a = frame << 1;
        int scaling = sintab[frame&63]+200;
	
	int Ux = (sintab[a & 63] * scaling) >> 12;
        int Uy = (sintab[(a + 16) & 63] * scaling) >> 12;
	int Vx = -Uy;
	int Vy =  Ux;
	
	pts[0] = (GL_width/2)  + Ux + Vx; 
	pts[1] = (GL_height/2) + Uy + Vy; 

	pts[2] = (GL_width/2)  - Ux + Vx; 
	pts[3] = (GL_height/2) - Uy + Vy; 

	pts[4] = (GL_width/2)  - Ux - Vx; 
	pts[5] = (GL_height/2) - Uy - Vy; 

	pts[6] = (GL_width/2)  + Ux - Vx; 
	pts[7] = (GL_height/2) + Uy - Vy; 
	
        int color = frame % 255;
        int R = frame & 255;
        int G = (frame >> 2) & 255;
        int B = 255 - R;

        GL_line(pts[0],pts[1],pts[2],pts[3],R,G,B);
        GL_line(pts[2],pts[3],pts[4],pts[5],R,G,B);
        GL_line(pts[4],pts[5],pts[6],pts[7],R,G,B);
        GL_line(pts[6],pts[7],pts[0],pts[1],R,G,B);

        GL_swapbuffers();
	
	++frame;
    }
}
