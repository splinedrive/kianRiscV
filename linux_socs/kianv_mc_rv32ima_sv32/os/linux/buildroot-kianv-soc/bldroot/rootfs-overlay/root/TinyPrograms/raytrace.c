/* -------------------------------------------------------- */
/*
  A small fixed point raytracer, @sylefeb
  Website: https://github.com/sylefeb/gfxcat
- 2012-02-09 (SL) created (OpenCL exercise)
- 2023-06-02 (SL) reworked (iron demo)
- 2024-01-15 (SL) added in gfxcat
- 2024-01-29 (BL) ported to GL_tty ANSI rendering
*/
/* -------------------------------------------------------- */ 

#define INLINE static inline 

#define SHRINK 2 // Resolution determined by amount of "shrinking"
                 // 0: 320x200
                 // 1: 160x100
                 // 2:  80x50
                 // (you need to set a tiny font in the TTY
                 //  if using 0 or 1)

#define GL_width  (320 >> SHRINK)
#define GL_height (200 >> SHRINK)
#include "GL_tty.h"
#include "sine_table.h"
#include <stdint.h>
/* -------------------------------------------------------- */
int g_time = 280;
/* -------------------------------------------------------- */
typedef  unsigned char t_pixel;
typedef  int32_t       stdi;
typedef  int64_t       wide;
/* -------------------------------------------------------- */
#define  FP       (16)
#define  BASE_MAX (1<<30)
INLINE stdi to_fixed(stdi v)     { return v<<FP; }
INLINE stdi from_fixed(stdi v)   { return v>>FP; }
INLINE stdi fxmul(wide a,wide b) { return (stdi)((a*b)>>FP); }
INLINE stdi fxdiv(wide a,wide b) { if (b == 0) return (stdi)BASE_MAX; return (stdi)((a<<FP)/b); }
/* -------------------------------------------------------- */
// Square root code from https://github.com/chmike/fpsqrt/blob/master/fpsqrt.c
// MIT License, see https://github.com/chmike/fpsqrt/blob/master/LICENSE
stdi sqrt_fixed(stdi v)
{
  if (v <= 0) { return BASE_MAX; }
  uint32_t b = BASE_MAX, q = 0, r = v;
  while (b > r) { b >>= 2; }
  while (b > 0) {
      uint32_t t = q + b;
      q >>= 1;
      if ( r >= t ) { r -= t; q += b; }
      b >>= 2;
  }
  return q<<(stdi)(FP/2);
}
/* -------------------------------------------------------- */
// 3d vectors
typedef struct { stdi x,y,z; } v3f;

INLINE v3f   add(v3f a,v3f b)   { v3f tmp; tmp.x = a.x+b.x; tmp.y = a.y+b.y; tmp.z = a.z+b.z; return tmp; }
INLINE v3f   sub(v3f a,v3f b)   { v3f tmp; tmp.x = a.x-b.x; tmp.y = a.y-b.y; tmp.z = a.z-b.z; return tmp; }
INLINE v3f   mul(v3f a,stdi s)  { v3f tmp; tmp.x = fxmul(a.x,s);   tmp.y = fxmul(a.y,s);   tmp.z = fxmul(a.z,s);   return tmp; }
INLINE v3f   vdiv(v3f a,stdi s) { v3f tmp; tmp.x = fxdiv(a.x,s);   tmp.y = fxdiv(a.y,s);   tmp.z = fxdiv(a.z,s);   return tmp; }
INLINE v3f   vmul(v3f a,v3f b)  { v3f tmp; tmp.x = fxmul(a.x,b.x); tmp.y = fxmul(a.y,b.y); tmp.z = fxmul(a.z,b.z); return tmp; }
INLINE stdi  dot(v3f a,v3f b)   { return fxmul(a.x,b.x) + fxmul(a.y,b.y) + fxmul(a.z,b.z); }
INLINE stdi  length(v3f a)      { return sqrt_fixed(dot(a,a)); }


INLINE v3f   normalize(v3f a)   { stdi l = length(a); if (l != 0) return vdiv(a,l); else return a; }
INLINE v3f   s2v(stdi s)        { v3f tmp; tmp.x = s; tmp.y = s; tmp.z = s; return tmp; }
/* -------------------------------------------------------- */
typedef struct {
  v3f s; // start
  v3f n; // direction (normalized)
} t_ray;
typedef struct {
  stdi  d; // distance from origin
  v3f   n; // normal
} t_plane;
typedef struct {
  v3f   p; // center
  stdi  r; // radius
  v3f   c; // diffuse color
} t_sphere;
typedef struct {
  stdi  t; // distance along ray
  v3f   p; // intersection point
  v3f   n; // normal at intersection point
  v3f   c; // diffuse color at intersection point
} t_hit;
/* -------------------------------------------------------- */
void intersectPlane(const t_ray *r, const t_plane *p, t_hit *h)
{
  h->t   = BASE_MAX;
  stdi l = p->d - dot(r->s , p->n);
  stdi d = dot(r->n , p->n);
  if (d >= 0) { return; }
  stdi t = fxdiv(l,d);
  if (t > 0) {
    h->t = t;
    h->p = add(r->s , mul(r->n, t));
    h->n = p->n;
    h->c = s2v(to_fixed( (((h->p.x>>(FP-3)) + g_time) ^ ((h->p.z>>(FP-3))) + g_time) &255));
  }
}
/* -------------------------------------------------------- */
void intersectSphere(const t_ray *r, const t_sphere *s, t_hit *h)
{
  h->t     = BASE_MAX;
  v3f   d  = sub( s->p, r->s );
  stdi t   = dot( d, r->n );
  if (t < 0)   { return; }
  stdi hh  = dot(d,d) - fxmul(t,t);
  stdi rr  = fxmul(s->r,s->r);
  if (hh > rr) { return; }
  stdi rt  = sqrt_fixed(rr - hh);
  h->t     = t - rt;
  v3f   p  = add(r->s,mul(r->n,h->t));
  h->p     = p;
  h->n     = normalize( sub(p,s->p) );
  h->c     = s->c;
}
/* -------------------------------------------------------- */
v3f reflect(v3f v,v3f n) { return sub(v,mul(n,2*dot(v,n))); }
v3f intersectScene(const t_ray *r, t_hit *h, int max_bounce, int shadow);
/* -------------------------------------------------------- */
v3f fragColor( const t_ray *r, const t_hit *h )
{
  v3f   lpos   = {to_fixed(-16),to_fixed(64),to_fixed(32)};
  v3f   l      = normalize(lpos);
  t_hit hitl;
  t_ray lray   = { h->p, l };
  intersectScene( &lray, &hitl, 0, 1 );
  stdi diffuse = 0,spec = 0;
  if (hitl.t == BASE_MAX) {
    stdi atten   = (h->t)>>9;
    diffuse      = dot( l , h->n ) - atten;
    if (diffuse < 0) { diffuse = 0; }
    v3f  v       = reflect( l, h->n );
    spec         = dot( v , r->n);
    if (spec < 0) { spec = 0; }
    spec         = fxmul(spec,spec);  spec = fxmul(spec,spec);
  }
  return add(mul(h->c,diffuse) , s2v(spec * 255));
}
/* -------------------------------------------------------- */
v3f intersectScene(const t_ray *r, t_hit *h, int max_bounce, int shadow)
{
  t_hit thit;
  v3f   clr = {0,0,0};
  h->t      = BASE_MAX;
  // plane
  {
    t_plane pl = { to_fixed(-14), {0,to_fixed(1),0} };
    intersectPlane( r, &pl, &thit );
    if (thit.t < h->t) {
      *h  = thit;
      if (!shadow) { clr = fragColor(r, h); }
      // bounce
      if (max_bounce > 0) {
        t_ray rs = { h->p, reflect(r->n, h->n) };
        v3f bclr = intersectScene( &rs, &thit, max_bounce-1, shadow );
        if ( thit.t < BASE_MAX ) { // hit?
          clr    = add(clr,bclr); // naive mix
        }
      }
    }
  }
  // spheres
  for (int i = 0; i < 3 ; ++i) {
    stdi rd     = 6 + i*2;
    v3f c       = {to_fixed(15),to_fixed(rd - 14),to_fixed(0)};
    int   a     = (g_time<<3) + (i*1365);
    stdi cs     = sine_table[(a+1024)&4095]<<(FP-12);
    stdi ss     = sine_table[(a     )&4095]<<(FP-12);
    t_sphere sp = {
      {(fxmul(c.x,cs) - fxmul(c.z,ss)),c.y,(fxmul(c.x,ss) + fxmul(c.z,cs))},
      to_fixed(rd),
      {to_fixed(i==0?255:31),to_fixed(i==1?255:31),to_fixed(i==2?255:31)} // rgb
    };
    intersectSphere( r, &sp, &thit );
    if ( thit.t < h->t ) { // in front from previous?
      *h  = thit;
      if (!shadow) { clr = fragColor(r, h); }
      // bounce once
      if (max_bounce > 0) {
        t_ray rs = { h->p, reflect(r->n, h->n) };
        v3f bclr = intersectScene( &rs, &thit, max_bounce-1, shadow );
        if ( thit.t < BASE_MAX ) { // hit?
          clr    = add(clr,bclr); // naive mix
        }
      }
    }
  }
  return clr;
}
/* -------------------------------------------------------- */
#define  clamp(a,m,M) ((a)<(m)?(m):((a)>(M)?(M):a))
/* -------------------------------------------------------- */
void tracePixel(int i, int j, uint8_t* R, uint8_t* G, uint8_t* B)
{
  stdi pi = to_fixed((i-(GL_width >> 1)) << SHRINK);
  stdi pj = to_fixed(((GL_height >> 1) - j) << SHRINK);  
    
  v3f  scr  = {pi/4 , pj/4, 0};  // screen point in world space
  v3f  eye  = {0,to_fixed(8),to_fixed(-64)}; // eye in world space
  v3f  v    = normalize( sub(scr,eye) );
  int  a    = 48;
  stdi cs   = sine_table[(a+1024)&4095]<<(FP-12);
  stdi ss   = sine_table[(a     )&4095]<<(FP-12);
  v3f  vr   = {v.x,(fxmul(v.y,cs) - fxmul(v.z,ss)),(fxmul(v.y,ss) + fxmul(v.z,cs))};
  // shoot ray
  t_ray r   = { eye, vr };
  t_hit h;
  v3f clr   = intersectScene( &r, &h, 1, 0 );
  *R = clamp(from_fixed(clr.x),0,255);
  *G = clamp(from_fixed(clr.y),0,255);
  *B = clamp(from_fixed(clr.z),0,255);
}
/* -------------------------------------------------------- */
int main(int argc, char **argv)
{
  GL_init();
  for(;;) {
      GL_scan_RGB(GL_width, GL_height, tracePixel);
      GL_swapbuffers();
      g_time+=7;
  }
  return 0;
}
/* -------------------------------------------------------- */
