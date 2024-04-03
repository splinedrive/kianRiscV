/*
 * Displays a tree using turtle graphics
 * Bruno Levy, Jan 2024
 */ 

#define GL_width 80
#define GL_height 25
#define GL_FPS 2
#define GL_USE_TURTLE
#include "GL_tty.h"

void tree(Turtle* T, int L, int depth, int max_depth, int branch_angle) {
    int branch_L = L-1;
    if(branch_L < 2) {
        branch_L = 2;
    }
    int g = (depth*255)/max_depth;
    if(depth == 0) {
        return;
    }
    Turtle_pen_color(T, g, 255-g, 0);
    Turtle_forward(T,L);
    Turtle_turn_right(T,branch_angle);
    tree(T,branch_L,depth-1, max_depth, branch_angle);
    Turtle_turn_left(T,2*branch_angle);
    tree(T,branch_L,depth-1, max_depth, branch_angle);
    Turtle_turn_right(T,branch_angle);    
    Turtle_turn_right(T,180);
    Turtle_pen_up(T);
    Turtle_forward(T,L);
    Turtle_pen_down(T);    
    Turtle_turn_right(T,180);
}

int main() {
    Turtle T;
    GL_init();
    for(;;) {
        for(int depth=1; depth<13; ++depth) {
            GL_clear();
            Turtle_init(&T);
            Turtle_pen_up(&T);
            Turtle_backward(&T, GL_height/2);
            Turtle_pen_down(&T);
            tree(&T,6,depth,13,26);
            GL_swapbuffers();
        }
    }
   
    GL_terminate();
}
