// C version of humanshader
// See https://humanshader.com/
// (using a computer is clearly not as fun, but it is interesting to have
//  a small not too computationally expensive raytracing program that
//  can run on small softcores for PGAs).
// Using the 16-bits version with no divide from here: https://www.shadertoy.com/view/XflXDs

#include <stdio.h>
#define GL_width  71
#define GL_height 40

void human_shader(int x, int y) {
    int R, B;

    //-------------------------    
    // Section A (2 MUL, 3 ADD)
    //-------------------------    
    int u = x-36;
    int v = 18-y;
    int u2 = u*u;
    int v2 = v*v;
    int h = u2 + v2;
    //-------------------------  
    
    if( h < 200 ) 
    {
        //-------------------------------------
        // Section B, Sphere (4/7 MUL, 5/9 ADD)
        //-------------------------------------
        R = 420;
        B = 520;

        int t = 5200 + h*8;
        int p = (t*u)>>7;
        int q = (t*v)>>7;
        
        // bounce light
        int w = 18 + (((p*5-q*13))>>9);
        if( w>0 ) R += w*w;
        
        // sky light / ambient occlusion
        int o = q + 900;
        R = (R*o)>>12;
        B = (B*o)>>12;

        // sun/key light
        if( p > -q )
        {
            int w = (p+q)>>3;
            R += w;
            B += w;
        }
        //-------------------------  
	}
    else if( v<0 )
    {
        //-------------------------------------
        // Section C, Ground (5/9 MUL, 6/9 ADD)
        //-------------------------------------
        R = 150 + 2*v;
        B = 50;
        
        int p = h + 8*v2;
        int c = 240*(-v) - p;

        // sky light / ambient occlusion
        if( c>1200 )
        {
            int o = (25*c)>>3;
            o = (c*(7840-o)>>9) - 8560;
            R = (R*o)>>10;
            B = (B*o)>>10;
        }

        // sun/key light with soft shadow
        int r = c + u*v;
        int d = 3200 - h - 2*r;
        if( d>0 ) R += d;
        //-------------------------  
    }
    else
    {
        //------------------------------
        // Section D, Sky (1 MUL, 2 ADD)
        //------------------------------
        int c = x + 4*y;
        R = 132 + c;
        B = 192 + c;
        //-------------------------  
    }
    
    //-------------------------
    // Section E (3 MUL, 1 ADD)
    //-------------------------
    if(R > 255) R = 255;
    if(B > 255) B = 255;
    
    int G = (R*11 + 5*B)>>4;
    //-------------------------  
    
    printf("\033[48;2;%d;%d;%dm ",R,G,B);
    if((x % GL_width) == 0) {
      printf("\033[48;2;0;0;0m");
      printf("\n");
    }
}

int main() {
  for (int y = 0; y < GL_height; y++) {
    for (int x = 0; x < GL_width; x++) {
      human_shader(x, y);
    }
  }
   printf("\033[0m\n");
    return 0;
}
