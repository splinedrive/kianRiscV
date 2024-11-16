// @sylefeb 2024-01, GPL v3
// From https://github.com/sylefeb/gfxcat
// Bruno Levy: adapted to GL_tty

#include "GL_tty.h"

// ----------------------------------------------------------------------------

int time    = 0;

int turn    = 0;
int tdir    = 1;
int bdir    = 1;
int maxv    = (1<<14);

int pos_u   = 0;
int pos_v   = 0;

int rng     = 31421;

void render()
{

  int horizon = 120; 
  GL_home();
  // for each line
  for (int y=0 ; y<GL_height ; ++y) {

    int offs_y = (y<<1) - (horizon>>8) + 8;

    int ground;
    if (y < (horizon>>8)) {
      ground  = 0;
    } else {
      ground  = 1;
    }

    int inv_y = maxv;
    if (offs_y != 0) {
      inv_y = maxv / offs_y; // costly division, once per line
    }

    int clip  = ((inv_y>>4) > 70 || ground == 0) ? 1 : 0;

    int curve   = (ground?((inv_y*turn)>>10):0);  
    int u       = (pos_u<<6) + (( 0 - GL_width/2 + curve ) * inv_y) - (turn<<8);
    int v       = pos_v + inv_y;

    int u_incr  = inv_y;

    for (int i=0 ; i<GL_width ; ++i) {

      int r,g,b;
      if (clip) {
        int sky = (y-32);
        r = g = sky<0 ? 0 : sky;
        b = 255;
      } else {
        int dctr = u < 0 ? -u : u;
        dctr     = dctr >> 6;
        int band = ((dctr > 195 && dctr < 225) || dctr < 15) && ((v&256) ? 1 : 0);
        int road = dctr < 250 ? 1 : 0; // road width
        if (band) {
          r = g = b = 200;
        } else if (road == 1) {
          if (v&128) {
            r=4; g=7; b=5;
          } else {
            r=7;  g=7; b=6;
          }
        } else {
          if (v&128) {
            r=21;  g=80; b=0;
          } else {
            r=26; g=60; b=0;
          }
        }
      }

      GL_setpixelRGBhere(r,g,b);

      u += u_incr;
    }
    GL_newline();
  }

  GL_swapbuffers();
  
  pos_v = pos_v + 32;
  ++ time;

  turn += (time > 20) ? tdir : -tdir;
  if (turn > 64) {
    turn = 64;
    tdir = -1;
  } else if (turn < -64) {
    turn = -64;
    tdir = 1;
  }

}

// ----------------------------------------------------------------------------

int main(int argc,char **argv)
{
  GL_init();
  for(;;) {
      render();
  }
  GL_terminate();
  return 0;
}

// ----------------------------------------------------------------------------
