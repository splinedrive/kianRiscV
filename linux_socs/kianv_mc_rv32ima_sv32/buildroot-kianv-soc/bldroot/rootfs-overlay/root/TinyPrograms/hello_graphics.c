#include "GL_tty.h"
// Small demo for Ansi graphics
// Bruno Levy, January 2024

int main() {
    GL_init();
    for(int i=0; i<25; ++i) {
        for(int j=0; j<80; ++j) {
            int r = (24-i)*5;
            int g = i*5;
            int b = j*3;
            GL_setpixelRGB(j,i,r,g,b);
        }
    }
    GL_terminate();
}
