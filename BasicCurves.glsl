// Author: Inigo Quiles
// Title: Expo

#ifdef GL_ES
precision mediump float;

#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

//Drawing Fuctions
float parabola( float x, float k ){
    return pow( 4.0*x*(1.0-x), k );
}

float impulse( float k, float x ){
    float h = k*x;
    return h*exp(1.0-h);
}

float almostIdentity(float x, float n){
    return sqrt(x*x + n);
}

float expImpulse(float x, float k){
    float h = k*x;
    return h*exp(1.0-h);
}

float sinc(float x, float k){
    float a = PI*(k*x -1.0);
    return  sin(a)/a;
}

float gain(float x, float k) 
{
    float a = 0.5*pow(2.0*((x<0.5)?x:1.0-x), k);
    return (x<0.5)?a:1.0-a;
}

// Draw in the y axis creating a very thin line. 
float plot(vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    float y = expImpulse(st.x,12.0);
    float y2 = sinc(st.x,5.0);
    
    vec3 color = vec3(y);
    vec3 color2 = vec3(y2);

    float pct = plot(st,y);
    float plot2 = plot(st,y2);
    color = (1.0-pct)*(1.0-plot2)*color + (1.0-pct)*(1.0-plot2)*color2 + 
    pct*vec3(0.0,1.0,0.0) + plot2* vec3(1.0,0.0,0.0);

    gl_FragColor = vec4(color,1.0);
}
